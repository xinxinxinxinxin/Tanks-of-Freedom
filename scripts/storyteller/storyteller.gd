
var bag

const STEP_INTERVAL = 0.2

var action_handlers = {
    'lock' : preload("res://scripts/storyteller/actions/lock_hud.gd").new(),
    'camera' : preload("res://scripts/storyteller/actions/camera.gd").new(),
    'sleep' : preload("res://scripts/storyteller/actions/sleep.gd").new(),
    'move' : preload("res://scripts/storyteller/actions/move.gd").new(),
    'die' : preload("res://scripts/storyteller/actions/die.gd").new(),
    'claim' : preload("res://scripts/storyteller/actions/claim.gd").new(),
}

var current_story = []
var story_bookmark = 0
var pause = false

func _init_bag(bag):
    self.bag = bag
    self.init_handlers()

func init_handlers():
    for handler_name in self.action_handlers:
        self.action_handlers[handler_name]._init_bag(self.bag)


func load_story():
    self.story_bookmark = 0
    self.pause = false
    self.ugly_hardcoded_story()

func tell_a_story():
    self.load_story()
    self.perform_next_action()


func perform_next_action():
    if self.story_bookmark == self.current_story.size():
        return

    if self.pause or self.bag.camera.panning:
        self.bag.timers.set_timeout(self.STEP_INTERVAL, self, "perform_next_action")
        return

    var story_step = self.current_story[self.story_bookmark]

    self.action_handlers[story_step['action']].perform(story_step['details'])

    self.story_bookmark = self.story_bookmark + 1

    if story_step.has('delay'):
        self.bag.timers.set_timeout(story_step['delay'], self, "perform_next_action")
    else:
        self.bag.timers.set_timeout(self.STEP_INTERVAL, self, "perform_next_action")




func ugly_hardcoded_story():
    var map = str(self.bag.root.workshop_file_name)

    if map == "PDMPD4MX":
        self.current_story = [
            {'action' : 'lock', 'details' : {}, 'delay': 1},
            {'action' : 'camera', 'details' : {'where' : Vector2(30, 19), 'speed' : 1}},
            {'action' : 'move', 'details' : {'who' : Vector2(28, 21), 'where' : Vector2(28, 20)}},
            {'action' : 'move', 'details' : {'who' : Vector2(30, 21), 'where' : Vector2(30, 20)}},
            {'action' : 'move', 'details' : {'who' : Vector2(28, 20), 'where' : Vector2(28, 19)}},
            {'action' : 'move', 'details' : {'who' : Vector2(30, 20), 'where' : Vector2(30, 19)}},
            {'action' : 'move', 'details' : {'who' : Vector2(28, 19), 'where' : Vector2(27, 19)}},
            {'action' : 'move', 'details' : {'who' : Vector2(30, 19), 'where' : Vector2(29, 19)}},
            {'action' : 'move', 'details' : {'who' : Vector2(27, 19), 'where' : Vector2(27, 18)}},
            {'action' : 'move', 'details' : {'who' : Vector2(29, 19), 'where' : Vector2(29, 18)}},
            {'action' : 'die', 'details' : {'who' : Vector2(27, 17)}},
            {'action' : 'die', 'details' : {'who' : Vector2(28, 17)}},
            {'action' : 'die', 'details' : {'who' : Vector2(26, 17)}},
            {'action' : 'die', 'details' : {'who' : Vector2(30, 17)}},
            {'action' : 'die', 'details' : {'who' : Vector2(29, 17)}},
            {'action' : 'sleep', 'details' : {'time' : 2}},
            {'action' : 'camera', 'details' : {'where' : Vector2(25, 19)}},
        ]
    elif map == "N4TEMHKK":
        self.current_story = [
            {'action' : 'lock', 'details' : {}},
            {'action' : 'camera', 'details' : {'where' : Vector2(20, 25), 'zoom' : 3}, 'delay' : 2},
            {'action' : 'camera', 'details' : {'where' : Vector2(19, 10), 'speed' : 0.1}, 'delay' : 2},
            {'action' : 'camera', 'details' : {'where' : Vector2(20, 25)}, 'delay' : 2},
            {'action' : 'camera', 'details' : {'where' : Vector2(19, 10), 'speed' : 0.5}, 'delay' : 2},

            {'action' : 'move', 'details' : {'who' : Vector2(12, 10), 'where' : Vector2(13, 10)}},
            {'action' : 'move', 'details' : {'who' : Vector2(24, 10), 'where' : Vector2(23, 10)}},
            {'action' : 'move', 'details' : {'who' : Vector2(11, 10), 'where' : Vector2(12, 10)}},
            {'action' : 'move', 'details' : {'who' : Vector2(25, 10), 'where' : Vector2(24, 10)}},

            {'action' : 'move', 'details' : {'who' : Vector2(13, 10), 'where' : Vector2(14, 10)}},
            {'action' : 'move', 'details' : {'who' : Vector2(23, 10), 'where' : Vector2(22, 10)}},
            {'action' : 'move', 'details' : {'who' : Vector2(12, 10), 'where' : Vector2(13, 10)}},
            {'action' : 'move', 'details' : {'who' : Vector2(24, 10), 'where' : Vector2(23, 10)}},

            {'action' : 'move', 'details' : {'who' : Vector2(14, 10), 'where' : Vector2(14, 11)}},
            {'action' : 'move', 'details' : {'who' : Vector2(22, 10), 'where' : Vector2(22, 11)}},
            {'action' : 'move', 'details' : {'who' : Vector2(13, 10), 'where' : Vector2(14, 10)}},
            {'action' : 'move', 'details' : {'who' : Vector2(23, 10), 'where' : Vector2(22, 10)}},

            {'action' : 'move', 'details' : {'who' : Vector2(14, 11), 'where' : Vector2(14, 12)}},
            {'action' : 'move', 'details' : {'who' : Vector2(22, 11), 'where' : Vector2(22, 12)}},
            {'action' : 'move', 'details' : {'who' : Vector2(14, 10), 'where' : Vector2(14, 11)}},
            {'action' : 'move', 'details' : {'who' : Vector2(22, 10), 'where' : Vector2(22, 11)}},

            {'action' : 'move', 'details' : {'who' : Vector2(14, 12), 'where' : Vector2(14, 13)}},
            {'action' : 'move', 'details' : {'who' : Vector2(22, 12), 'where' : Vector2(22, 13)}},
            {'action' : 'move', 'details' : {'who' : Vector2(14, 11), 'where' : Vector2(14, 12)}},
            {'action' : 'move', 'details' : {'who' : Vector2(22, 11), 'where' : Vector2(22, 12)}},

            {'action' : 'move', 'details' : {'who' : Vector2(14, 13), 'where' : Vector2(15, 13)}},
            {'action' : 'move', 'details' : {'who' : Vector2(22, 13), 'where' : Vector2(21, 13)}},
            {'action' : 'move', 'details' : {'who' : Vector2(14, 12), 'where' : Vector2(14, 13)}},
            {'action' : 'move', 'details' : {'who' : Vector2(22, 12), 'where' : Vector2(22, 13)}},

            {'action' : 'move', 'details' : {'who' : Vector2(15, 13), 'where' : Vector2(16, 13)}},
            {'action' : 'move', 'details' : {'who' : Vector2(21, 13), 'where' : Vector2(20, 13)}},
            {'action' : 'move', 'details' : {'who' : Vector2(14, 13), 'where' : Vector2(15, 13)}},
            {'action' : 'move', 'details' : {'who' : Vector2(22, 13), 'where' : Vector2(21, 13)}},
        ]
    elif map == "T9ET4W3M":
        self.current_story = [
            {'action' : 'lock', 'details' : {}},
            {'action' : 'camera', 'details' : {'where' : Vector2(18, 30), 'zoom' : 2}, 'delay' : 2},
            {'action' : 'camera', 'details' : {'where' : Vector2(17, 21)}, 'delay' : 2},

            {'action' : 'move', 'details' : {'who' : Vector2(17, 22), 'where' : Vector2(17, 21)}},
            {'action' : 'move', 'details' : {'who' : Vector2(16, 23), 'where' : Vector2(16, 22)}},
            {'action' : 'move', 'details' : {'who' : Vector2(18, 23), 'where' : Vector2(18, 22)}},
            {'action' : 'move', 'details' : {'who' : Vector2(15, 24), 'where' : Vector2(15, 23)}},
            {'action' : 'move', 'details' : {'who' : Vector2(19, 24), 'where' : Vector2(19, 23)}},

            {'action' : 'move', 'details' : {'who' : Vector2(17, 21), 'where' : Vector2(17, 20)}},
            {'action' : 'move', 'details' : {'who' : Vector2(16, 22), 'where' : Vector2(16, 21)}},
            {'action' : 'move', 'details' : {'who' : Vector2(18, 22), 'where' : Vector2(18, 21)}},
            {'action' : 'move', 'details' : {'who' : Vector2(15, 23), 'where' : Vector2(15, 22)}},
            {'action' : 'move', 'details' : {'who' : Vector2(19, 23), 'where' : Vector2(19, 22)}, 'delay' : 2},

            {'action' : 'camera', 'details' : {'where' : Vector2(18, 30), 'zoom' : 1}, 'delay' : 2},
            {'action' : 'camera', 'details' : {'where' : Vector2(17, 19)}, 'delay' : 2},

            {'action' : 'move', 'details' : {'who' : Vector2(16, 21), 'where' : Vector2(16, 20)}},
            {'action' : 'move', 'details' : {'who' : Vector2(18, 21), 'where' : Vector2(18, 20)}},

            {'action' : 'die', 'details' : {'who' : Vector2(16, 19)}},
            {'action' : 'die', 'details' : {'who' : Vector2(18, 19)}, 'delay' : 2},

            {'action' : 'camera', 'details' : {'where' : Vector2(17, 16)}},
            {'action' : 'move', 'details' : {'who' : Vector2(17, 20), 'where' : Vector2(17, 17)}},
            {'action' : 'move', 'details' : {'who' : Vector2(16, 20), 'where' : Vector2(15, 16)}},
            {'action' : 'move', 'details' : {'who' : Vector2(18, 20), 'where' : Vector2(19, 16)}, 'delay' : 2},

            {'action' : 'move', 'details' : {'who' : Vector2(17, 15), 'where' : Vector2(17, 16)}},
            {'action' : 'die', 'details' : {'who' : Vector2(17, 17)}, 'delay' : 0.5},

            {'action' : 'move', 'details' : {'who' : Vector2(15, 16), 'where' : Vector2(16, 16)}},
            {'action' : 'move', 'details' : {'who' : Vector2(19, 16), 'where' : Vector2(18, 16)}},
            {'action' : 'die', 'details' : {'who' : Vector2(17, 16)}, 'delay' : 2},

            {'action' : 'camera', 'details' : {'where' : Vector2(15, 14)}, 'delay' : 2},
            {'action' : 'move', 'details' : {'who' : Vector2(16, 16), 'where' : Vector2(15, 15)}},
            {'action' : 'move', 'details' : {'who' : Vector2(18, 16), 'where' : Vector2(17, 15)}},

            {'action' : 'claim', 'details' : {'what' : Vector2(15, 14), 'side' : 0}},
            {'action' : 'claim', 'details' : {'what' : Vector2(17, 14), 'side' : 0}},
            {'action' : 'claim', 'details' : {'what' : Vector2(19, 14), 'side' : 0}},
        ]
    else:
        self.current_story = []