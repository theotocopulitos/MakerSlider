include <scad/tapercube.scad>;

module makerslide(h=100) {
	linear_extrude(
		file="scad/makerslide_extrusion_profile.dxf", layer="makerslide",
		height=h, center=true, convexity=10);
}

module wiggle(variance=0.5, deg=15.0) {
  for (i = [0 : deg : 360])
    translate([ cos(i)*variance, sin(i)*variance ])
    	child(0);
}

module cap() {
	depth = 10;
	etch_depth = 5;

	difference() {
		translate([-5, -25, 0])
			tapercube(30,50,depth, 3);

		translate([0, 0, depth-etch_depth/2])
			wiggle(0.55, 30)
				makerslide(etch_depth+0.1);

		translate([10,10,depth/2])
			cylinder(r=2.5, h=depth*2, center=true, $fn=32);

		translate([10,0,depth])
			cube([16,36,10], center=true);
	}
}

cap();