extends Node2D

var matrix := []

var not_so_random_letters = \
	"MXSEKWAPAK" + \
	"SDDNAPEIFP" + \
	"RRFBYMXIHK" + \
	"EYQILGODSO" + \
	"EMDLFICDED" + \
	"MSLLDNEMDF" + \
	"HKDNUISEOD" + \
	"RIJEOPARDY" + \
	"AWISREHDKS" + \
	"POSSKIYJSX"

var words := []
var rects := []
var hits := []

func _ready():
	load_words()
	matrix.resize(10)
	for x in range(10):
		matrix[x] = []
		matrix[x].resize(10)
		for y in range (10):
			var l = Label.new()
			l.rect_position = Vector2(50 + x * 20, 50 + y * 20)
			# matrix[x][y] = char(65 + randi() % 26) 
			matrix[x][y] = not_so_random_letters[x + y * 10] 
			l.text = matrix[x][y]
			add_child(l)
	find_words()

func load_words():
	var file := File.new()
	file.open("res://word_list.txt", File.READ)
	while not file.eof_reached():
		words.append(file.get_line())
	file.close()

func find_words():
	for word_length in range (3,9):
		for x in range(10):
			for y in range(10):
				var horizontal := ""
				var vertical := ""
				for pos in range (word_length):
					horizontal += matrix[x + pos][y] if x + pos < 10 else "-"
					vertical += matrix[x][y + pos] if y + pos < 10 else "-"
				if horizontal in words:
					rects.append(Rect2(45 + x * 20, 45 + y * 20, 20 * word_length, 20))
					hits.append({"word": horizontal, "pos": Vector2(x, y), "direction": "horizontal"})
				if vertical in words:
					rects.append(Rect2(45 + x * 20, 45 + y * 20, 20, 20 * word_length))
					hits.append({"word": vertical, "pos": Vector2(x, y), "direction": "vertical"})
	update()
	print (hits)

func _draw():
	for r in rects: draw_rect(r, Color(1,0,0), false)
