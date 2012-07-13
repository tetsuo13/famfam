/**
 * Main family tree renderer.
 *
 * @copyright 2012 Andrei Nicholson
 */

float zoom;
PVector offset;
PVector poffset;
PVector mouse;
ArrayList tree;

void setup() {
    size($(document).width(), 480);

    tree = new ArrayList();
    tree.add(new Person("Andrei Nicholson"));
}

void draw() {
    background(238, 240, 220);

/*
    for (int i = 0; i < tree.size(); i++) {
        Person p = (Person) tree.get(i);
        p.update();
    }
*/

    for (Person p: tree) {
        p.update();
    }
}

void mousePressed() {
    mouse = new PVector(mouseX, mouseY);
    poffset.set(offset);

    for (Person p: tree) {
        if (p.mouseOverEditLink(mouseX, mouseY)) {
            console.log("PRESSED");
        }
    }
}

void mouseDragged() {
    offset.x = (mouseX - mouse.x) / zoom + poffset.x;
    offset.y = (mouseY - mouse.y) / zoom + poffset.y;
}

void mouseOver() {
console.log("YES");
    }

/**
 * Individual person.
 */
public class Person {
    private String name;
    private color rectStroke = color(100, 167, 196);

    // Left top right bottom bounding box.
    private int[] editRectangle = {0, 0, 0, 0};

    final static PFont NAME_FONT = loadFont("Arial Bold");
    final static PFont EDIT_FONT = loadFont("Arial");

    final static String EDIT_TEXT = "edit";

    public Person(String n) {
        this.name = n;
        zoom = 1.0;
        offset = new PVector(0, 0);
        poffset = new PVector(0, 0);
        rectMode(CENTER);
        smooth();
    }

    public boolean mouseOverEditLink(int x, int y) {
        return (x >= this.editRectangle[0] && x <= this.editRectangle[2] &&
                y >= this.editRectangle[1] && y <= this.editRectangle[3]);
    }

    public void update() {
        int leftEdge = width / 2;
        int topEdge = height / 2;
        int leftTextEdge = leftEdge - 70;

        pushMatrix();

        translate(0, 0);
        scale(zoom);
        translate(offset.x, offset.y);

        fill(255);
        stroke(this.rectStroke);
        rect(leftEdge, topEdge, 166, 60);

        fill(0, 0, 0);
        textMode(SCREEN);
        textFont(this.NAME_FONT);
        text(this.name, leftTextEdge, topEdge - 10);

        fill(0, 0, 255);
        textFont(this.EDIT_FONT, 10);
        text(this.EDIT_TEXT, leftTextEdge, topEdge + 20);

        // Update bounding box position for "edit" link.
        // TODO: This never updates, only takes on the initial values.
        this.editRectangle[0] = leftTextEdge;
        this.editRectangle[1] = topEdge + 20 - 10;
        this.editRectangle[2] = leftTextEdge + textWidth(this.EDIT_TEXT);
        this.editRectangle[3] = topEdge + 20;

        popMatrix();
    }

}

// vim: set syntax=processing:
