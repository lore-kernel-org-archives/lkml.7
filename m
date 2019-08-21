Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6439C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B79222DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfHUIdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 04:33:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:34007 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbfHUIdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 04:33:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 01:33:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="195953496"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.122])
  by fmsmga001.fm.intel.com with ESMTP; 21 Aug 2019 01:33:39 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] perf scripts python: exported-sql-viewer.py: Add Time chart by CPU
Date:   Wed, 21 Aug 2019 11:32:16 +0300
Message-Id: <20190821083216.1340-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821083216.1340-1-adrian.hunter@intel.com>
References: <20190821083216.1340-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a time chart based on context switch information. Context switch
information was added to the database export fairly recently, so the chart
menu option will only appear if context switch information is in the
database. Refer to the Exported SQL Viewer Help option for more
information about the chart.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripts/python/exported-sql-viewer.py     | 1333 ++++++++++++++++-
 1 file changed, 1331 insertions(+), 2 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index a5af52f422e6..ebc6a2e5eae9 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -105,6 +105,9 @@ except ImportError:
 	glb_nsz = 16
 import re
 import os
+import random
+import copy
+import math
 
 pyside_version_1 = True
 if not "--pyside-version-1" in sys.argv:
@@ -1154,6 +1157,1301 @@ class CallTreeWindow(TreeWindowBase):
 			self.view.setCurrentIndex(last_child)
 			parent = last_child
 
+# ExecComm() gets the comm_id of the command string that was set when the process exec'd i.e. the program name
+
+def ExecComm(db, thread_id, time):
+	query = QSqlQuery(db)
+	QueryExec(query, "SELECT comm_threads.comm_id, comms.c_time, comms.exec_flag"
+				" FROM comm_threads"
+				" INNER JOIN comms ON comms.id = comm_threads.comm_id"
+				" WHERE comm_threads.thread_id = " + str(thread_id) +
+				" ORDER BY comms.c_time, comms.id")
+	first = None
+	last = None
+	while query.next():
+		if first is None:
+			first = query.value(0)
+		if query.value(2) and Decimal(query.value(1)) <= Decimal(time):
+			last = query.value(0)
+	if not(last is None):
+		return last
+	return first
+
+# Container for (x, y) data
+
+class XY():
+	def __init__(self, x=0, y=0):
+		self.x = x
+		self.y = y
+
+	def __str__(self):
+		return "XY({}, {})".format(str(self.x), str(self.y))
+
+# Container for sub-range data
+
+class Subrange():
+	def __init__(self, lo=0, hi=0):
+		self.lo = lo
+		self.hi = hi
+
+	def __str__(self):
+		return "Subrange({}, {})".format(str(self.lo), str(self.hi))
+
+# Graph data region base class
+
+class GraphDataRegion(object):
+
+	def __init__(self, key, title = "", ordinal = ""):
+		self.key = key
+		self.title = title
+		self.ordinal = ordinal
+
+# Function to sort GraphDataRegion
+
+def GraphDataRegionOrdinal(data_region):
+	return data_region.ordinal
+
+# Attributes for a graph region
+
+class GraphRegionAttribute():
+
+	def __init__(self, colour):
+		self.colour = colour
+
+# Switch graph data region represents a task
+
+class SwitchGraphDataRegion(GraphDataRegion):
+
+	def __init__(self, key, exec_comm_id, pid, tid, comm, thread_id, comm_id):
+		super(SwitchGraphDataRegion, self).__init__(key)
+
+		self.title = str(pid) + " / " + str(tid) + " " + comm
+		# Order graph legend within exec comm by pid / tid / time
+		self.ordinal = str(pid).rjust(16) + str(exec_comm_id).rjust(8) + str(tid).rjust(16)
+		self.exec_comm_id = exec_comm_id
+		self.pid = pid
+		self.tid = tid
+		self.comm = comm
+		self.thread_id = thread_id
+		self.comm_id = comm_id
+
+# Graph data point
+
+class GraphDataPoint():
+
+	def __init__(self, data, index, x, y, altx=None, alty=None, hregion=None, vregion=None):
+		self.data = data
+		self.index = index
+		self.x = x
+		self.y = y
+		self.altx = altx
+		self.alty = alty
+		self.hregion = hregion
+		self.vregion = vregion
+
+# Graph data (single graph) base class
+
+class GraphData(object):
+
+	def __init__(self, collection, xbase=Decimal(0), ybase=Decimal(0)):
+		self.collection = collection
+		self.points = []
+		self.xbase = xbase
+		self.ybase = ybase
+		self.title = ""
+
+	def AddPoint(self, x, y, altx=None, alty=None, hregion=None, vregion=None):
+		index = len(self.points)
+
+		x = float(Decimal(x) - self.xbase)
+		y = float(Decimal(y) - self.ybase)
+
+		self.points.append(GraphDataPoint(self, index, x, y, altx, alty, hregion, vregion))
+
+	def XToData(self, x):
+		return Decimal(x) + self.xbase
+
+	def YToData(self, y):
+		return Decimal(y) + self.ybase
+
+# Switch graph data (for one CPU)
+
+class SwitchGraphData(GraphData):
+
+	def __init__(self, db, collection, cpu, xbase):
+		super(SwitchGraphData, self).__init__(collection, xbase)
+
+		self.cpu = cpu
+		self.title = "CPU " + str(cpu)
+		self.SelectSwitches(db)
+
+	def SelectComms(self, db, thread_id, last_comm_id, start_time, end_time):
+		query = QSqlQuery(db)
+		QueryExec(query, "SELECT id, c_time"
+					" FROM comms"
+					" WHERE c_thread_id = " + str(thread_id) +
+					"   AND exec_flag = TRUE"
+					"   AND c_time >= " + str(start_time) +
+					"   AND c_time <= " + str(end_time) +
+					" ORDER BY c_time, id")
+		while query.next():
+			comm_id = query.value(0)
+			if comm_id == last_comm_id:
+				continue
+			time = query.value(1)
+			hregion = self.HRegion(db, thread_id, comm_id, time)
+			self.AddPoint(time, 1000, None, None, hregion)
+
+	def SelectSwitches(self, db):
+		last_time = None
+		last_comm_id = None
+		last_thread_id = None
+		query = QSqlQuery(db)
+		QueryExec(query, "SELECT time, thread_out_id, thread_in_id, comm_out_id, comm_in_id, flags"
+					" FROM context_switches"
+					" WHERE machine_id = " + str(self.collection.machine_id) +
+					"   AND cpu = " + str(self.cpu) +
+					" ORDER BY time, id")
+		while query.next():
+			flags = int(query.value(5))
+			if flags & 1:
+				# Schedule-out: detect and add exec's
+				if last_thread_id == query.value(1) and last_comm_id is not None and last_comm_id != query.value(3):
+					self.SelectComms(db, last_thread_id, last_comm_id, last_time, query.value(0))
+				continue
+			# Schedule-in: add data point
+			if len(self.points) == 0:
+				start_time = self.collection.glb.StartTime(self.collection.machine_id)
+				hregion = self.HRegion(db, query.value(1), query.value(3), start_time)
+				self.AddPoint(start_time, 1000, None, None, hregion)
+			time = query.value(0)
+			comm_id = query.value(4)
+			thread_id = query.value(2)
+			hregion = self.HRegion(db, thread_id, comm_id, time)
+			self.AddPoint(time, 1000, None, None, hregion)
+			last_time = time
+			last_comm_id = comm_id
+			last_thread_id = thread_id
+
+	def NewHRegion(self, db, key, thread_id, comm_id, time):
+		exec_comm_id = ExecComm(db, thread_id, time)
+		query = QSqlQuery(db)
+		QueryExec(query, "SELECT pid, tid FROM threads WHERE id = " + str(thread_id))
+		if query.next():
+			pid = query.value(0)
+			tid = query.value(1)
+		else:
+			pid = -1
+			tid = -1
+		query = QSqlQuery(db)
+		QueryExec(query, "SELECT comm FROM comms WHERE id = " + str(comm_id))
+		if query.next():
+			comm = query.value(0)
+		else:
+			comm = ""
+		return SwitchGraphDataRegion(key, exec_comm_id, pid, tid, comm, thread_id, comm_id)
+
+	def HRegion(self, db, thread_id, comm_id, time):
+		key = str(thread_id) + ":" + str(comm_id)
+		hregion = self.collection.LookupHRegion(key)
+		if hregion is None:
+			hregion = self.NewHRegion(db, key, thread_id, comm_id, time)
+			self.collection.AddHRegion(key, hregion)
+		return hregion
+
+# Graph data collection (multiple related graphs) base class
+
+class GraphDataCollection(object):
+
+	def __init__(self, glb):
+		self.glb = glb
+		self.data = []
+		self.hregions = {}
+		self.xrangelo = None
+		self.xrangehi = None
+		self.yrangelo = None
+		self.yrangehi = None
+		self.dp = XY(0, 0)
+
+	def AddGraphData(self, data):
+		self.data.append(data)
+
+	def LookupHRegion(self, key):
+		if key in self.hregions:
+			return self.hregions[key]
+		return None
+
+	def AddHRegion(self, key, hregion):
+		self.hregions[key] = hregion
+
+# Switch graph data collection (SwitchGraphData for each CPU)
+
+class SwitchGraphDataCollection(GraphDataCollection):
+
+	def __init__(self, glb, db, machine_id):
+		super(SwitchGraphDataCollection, self).__init__(glb)
+
+		self.machine_id = machine_id
+		self.cpus = self.SelectCPUs(db)
+
+		self.xrangelo = glb.StartTime(machine_id)
+		self.xrangehi = glb.FinishTime(machine_id)
+
+		self.yrangelo = Decimal(0)
+		self.yrangehi = Decimal(1000)
+
+		for cpu in self.cpus:
+			self.AddGraphData(SwitchGraphData(db, self, cpu, self.xrangelo))
+
+	def SelectCPUs(self, db):
+		cpus = []
+		query = QSqlQuery(db)
+		QueryExec(query, "SELECT DISTINCT cpu"
+					" FROM context_switches"
+					" WHERE machine_id = " + str(self.machine_id))
+		while query.next():
+			cpus.append(int(query.value(0)))
+		return sorted(cpus)
+
+# Switch graph data graphics item displays the graphed data
+
+class SwitchGraphDataGraphicsItem(QGraphicsItem):
+
+	def __init__(self, data, graph_width, graph_height, attrs, event_handler, parent=None):
+		super(SwitchGraphDataGraphicsItem, self).__init__(parent)
+
+		self.data = data
+		self.graph_width = graph_width
+		self.graph_height = graph_height
+		self.attrs = attrs
+		self.event_handler = event_handler
+		self.setAcceptHoverEvents(True)
+
+	def boundingRect(self):
+		return QRectF(0, 0, self.graph_width, self.graph_height)
+
+	def PaintPoint(self, painter, last, x):
+		if not(last is None or last.hregion.pid == 0 or x < self.attrs.subrange.x.lo):
+			if last.x < self.attrs.subrange.x.lo:
+				x0 = self.attrs.subrange.x.lo
+			else:
+				x0 = last.x
+			if x > self.attrs.subrange.x.hi:
+				x1 = self.attrs.subrange.x.hi
+			else:
+				x1 = x - 1
+			x0 = self.attrs.XToPixel(x0)
+			x1 = self.attrs.XToPixel(x1)
+
+			y0 = self.attrs.YToPixel(last.y)
+
+			colour = self.attrs.region_attributes[last.hregion.key].colour
+
+			width = x1 - x0 + 1
+			if width < 2:
+				painter.setPen(colour)
+				painter.drawLine(x0, self.graph_height - y0, x0, self.graph_height)
+			else:
+				painter.fillRect(x0, self.graph_height - y0, width, self.graph_height - 1, colour)
+
+	def paint(self, painter, option, widget):
+		last = None
+		for point in self.data.points:
+			self.PaintPoint(painter, last, point.x)
+			if point.x > self.attrs.subrange.x.hi:
+				break;
+			last = point
+		self.PaintPoint(painter, last, self.attrs.subrange.x.hi + 1)
+
+	def BinarySearchPoint(self, target):
+		lower_pos = 0
+		higher_pos = len(self.data.points)
+		while True:
+			pos = int((lower_pos + higher_pos) / 2)
+			val = self.data.points[pos].x
+			if target >= val:
+				lower_pos = pos
+			else:
+				higher_pos = pos
+			if higher_pos <= lower_pos + 1:
+				return lower_pos
+
+	def XPixelToData(self, x):
+		x = self.attrs.PixelToX(x)
+		if x < self.data.points[0].x:
+			x = 0
+			pos = 0
+			low = True
+		else:
+			pos = self.BinarySearchPoint(x)
+			low = False
+		return (low, pos, self.data.XToData(x))
+
+	def EventToData(self, event):
+		no_data = (None,) * 4
+		if len(self.data.points) < 1:
+			return no_data
+		x = event.pos().x()
+		if x < 0:
+			return no_data
+		low0, pos0, time_from = self.XPixelToData(x)
+		low1, pos1, time_to = self.XPixelToData(x + 1)
+		hregions = set()
+		hregion_times = []
+		if not low1:
+			for i in xrange(pos0, pos1 + 1):
+				hregion = self.data.points[i].hregion
+				hregions.add(hregion)
+				if i == pos0:
+					time = time_from
+				else:
+					time = self.data.XToData(self.data.points[i].x)
+				hregion_times.append((hregion, time))
+		return (time_from, time_to, hregions, hregion_times)
+
+	def hoverMoveEvent(self, event):
+		time_from, time_to, hregions, hregion_times = self.EventToData(event)
+		if time_from is not None:
+			self.event_handler.PointEvent(self.data.cpu, time_from, time_to, hregions)
+
+	def hoverLeaveEvent(self, event):
+		self.event_handler.NoPointEvent()
+
+	def mousePressEvent(self, event):
+		if event.button() != Qt.RightButton:
+			super(SwitchGraphDataGraphicsItem, self).mousePressEvent(event)
+			return
+		time_from, time_to, hregions, hregion_times = self.EventToData(event)
+		if hregion_times:
+			self.event_handler.RightClickEvent(self.data.cpu, hregion_times, event.screenPos())
+
+# X-axis graphics item
+
+class XAxisGraphicsItem(QGraphicsItem):
+
+	def __init__(self, width, parent=None):
+		super(XAxisGraphicsItem, self).__init__(parent)
+
+		self.width = width
+		self.max_mark_sz = 4
+		self.height = self.max_mark_sz + 1
+
+	def boundingRect(self):
+		return QRectF(0, 0, self.width, self.height)
+
+	def Step(self):
+		attrs = self.parentItem().attrs
+		subrange = attrs.subrange.x
+		t = subrange.hi - subrange.lo
+		s = (3.0 * t) / self.width
+		n = 1.0
+		while s > n:
+			n = n * 10.0
+		return n
+
+	def PaintMarks(self, painter, at_y, lo, hi, step, i):
+		attrs = self.parentItem().attrs
+		x = lo
+		while x <= hi:
+			xp = attrs.XToPixel(x)
+			if i % 10:
+				if i % 5:
+					sz = 1
+				else:
+					sz = 2
+			else:
+				sz = self.max_mark_sz
+				i = 0
+			painter.drawLine(xp, at_y, xp, at_y + sz)
+			x += step
+			i += 1
+
+	def paint(self, painter, option, widget):
+		# Using QPainter::drawLine(int x1, int y1, int x2, int y2) so x2 = width -1
+		painter.drawLine(0, 0, self.width - 1, 0)
+		n = self.Step()
+		attrs = self.parentItem().attrs
+		subrange = attrs.subrange.x
+		if subrange.lo:
+			x_offset = n - (subrange.lo % n)
+		else:
+			x_offset = 0.0
+		x = subrange.lo + x_offset
+		i = (x / n) % 10
+		self.PaintMarks(painter, 0, x, subrange.hi, n, i)
+
+	def ScaleDimensions(self):
+		n = self.Step()
+		attrs = self.parentItem().attrs
+		lo = attrs.subrange.x.lo
+		hi = (n * 10.0) + lo
+		width = attrs.XToPixel(hi)
+		if width > 500:
+			width = 0
+		return (n, lo, hi, width)
+
+	def PaintScale(self, painter, at_x, at_y):
+		n, lo, hi, width = self.ScaleDimensions()
+		if not width:
+			return
+		painter.drawLine(at_x, at_y, at_x + width, at_y)
+		self.PaintMarks(painter, at_y, lo, hi, n, 0)
+
+	def ScaleWidth(self):
+		n, lo, hi, width = self.ScaleDimensions()
+		return width
+
+	def ScaleHeight(self):
+		return self.height
+
+	def ScaleUnit(self):
+		return self.Step() * 10
+
+# Scale graphics item base class
+
+class ScaleGraphicsItem(QGraphicsItem):
+
+	def __init__(self, axis, parent=None):
+		super(ScaleGraphicsItem, self).__init__(parent)
+		self.axis = axis
+
+	def boundingRect(self):
+		scale_width = self.axis.ScaleWidth()
+		if not scale_width:
+			return QRectF()
+		return QRectF(0, 0, self.axis.ScaleWidth() + 100, self.axis.ScaleHeight())
+
+	def paint(self, painter, option, widget):
+		scale_width = self.axis.ScaleWidth()
+		if not scale_width:
+			return
+		self.axis.PaintScale(painter, 0, 5)
+		x = scale_width + 4
+		painter.drawText(QPointF(x, 10), self.Text())
+
+	def Unit(self):
+		return self.axis.ScaleUnit()
+
+	def Text(self):
+		return ""
+
+# Switch graph scale graphics item
+
+class SwitchScaleGraphicsItem(ScaleGraphicsItem):
+
+	def __init__(self, axis, parent=None):
+		super(SwitchScaleGraphicsItem, self).__init__(axis, parent)
+
+	def Text(self):
+		unit = self.Unit()
+		if unit >= 1000000000:
+			unit = int(unit / 1000000000)
+			us = "s"
+		elif unit >= 1000000:
+			unit = int(unit / 1000000)
+			us = "ms"
+		elif unit >= 1000:
+			unit = int(unit / 1000)
+			us = "us"
+		else:
+			unit = int(unit)
+			us = "ns"
+		return " = " + str(unit) + " " + us
+
+# Switch graph graphics item contains graph title, scale, x/y-axis, and the graphed data
+
+class SwitchGraphGraphicsItem(QGraphicsItem):
+
+	def __init__(self, collection, data, attrs, event_handler, first, parent=None):
+		super(SwitchGraphGraphicsItem, self).__init__(parent)
+		self.collection = collection
+		self.data = data
+		self.attrs = attrs
+		self.event_handler = event_handler
+
+		margin = 20
+		title_width = 50
+
+		self.title_graphics = QGraphicsSimpleTextItem(data.title, self)
+
+		self.title_graphics.setPos(margin, margin)
+		graph_width = attrs.XToPixel(attrs.subrange.x.hi) + 1
+		graph_height = attrs.YToPixel(attrs.subrange.y.hi) + 1
+
+		self.graph_origin_x = margin + title_width + margin
+		self.graph_origin_y = graph_height + margin
+
+		x_axis_size = 1
+		y_axis_size = 1
+		self.yline = QGraphicsLineItem(0, 0, 0, graph_height, self)
+
+		self.x_axis = XAxisGraphicsItem(graph_width, self)
+		self.x_axis.setPos(self.graph_origin_x, self.graph_origin_y + 1)
+
+		if first:
+			self.scale_item = SwitchScaleGraphicsItem(self.x_axis, self)
+			self.scale_item.setPos(self.graph_origin_x, self.graph_origin_y + 10)
+
+		self.yline.setPos(self.graph_origin_x - y_axis_size, self.graph_origin_y - graph_height)
+
+		self.axis_point = QGraphicsLineItem(0, 0, 0, 0, self)
+		self.axis_point.setPos(self.graph_origin_x - 1, self.graph_origin_y +1)
+
+		self.width = self.graph_origin_x + graph_width + margin
+		self.height = self.graph_origin_y + margin
+
+		self.graph = SwitchGraphDataGraphicsItem(data, graph_width, graph_height, attrs, event_handler, self)
+		self.graph.setPos(self.graph_origin_x, self.graph_origin_y - graph_height)
+
+		if parent and 'EnableRubberBand' in dir(parent):
+			parent.EnableRubberBand(self.graph_origin_x, self.graph_origin_x + graph_width - 1, self)
+
+	def boundingRect(self):
+		return QRectF(0, 0, self.width, self.height)
+
+	def paint(self, painter, option, widget):
+		pass
+
+	def RBXToPixel(self, x):
+		return self.attrs.PixelToX(x - self.graph_origin_x)
+
+	def RBXRangeToPixel(self, x0, x1):
+		return (self.RBXToPixel(x0), self.RBXToPixel(x1 + 1))
+
+	def RBPixelToTime(self, x):
+		if x < self.data.points[0].x:
+			return self.data.XToData(0)
+		return self.data.XToData(x)
+
+	def RBEventTimes(self, x0, x1):
+		x0, x1 = self.RBXRangeToPixel(x0, x1)
+		time_from = self.RBPixelToTime(x0)
+		time_to = self.RBPixelToTime(x1)
+		return (time_from, time_to)
+
+	def RBEvent(self, x0, x1):
+		time_from, time_to = self.RBEventTimes(x0, x1)
+		self.event_handler.RangeEvent(time_from, time_to)
+
+	def RBMoveEvent(self, x0, x1):
+		if x1 < x0:
+			x0, x1 = x1, x0
+		self.RBEvent(x0, x1)
+
+	def RBReleaseEvent(self, x0, x1, selection_state):
+		if x1 < x0:
+			x0, x1 = x1, x0
+		x0, x1 = self.RBXRangeToPixel(x0, x1)
+		self.event_handler.SelectEvent(x0, x1, selection_state)
+
+# Graphics item to draw a vertical bracket (used to highlight "forward" sub-range)
+
+class VerticalBracketGraphicsItem(QGraphicsItem):
+
+	def __init__(self, parent=None):
+		super(VerticalBracketGraphicsItem, self).__init__(parent)
+
+		self.width = 0
+		self.height = 0
+		self.hide()
+
+	def SetSize(self, width, height):
+		self.width = width + 1
+		self.height = height + 1
+
+	def boundingRect(self):
+		return QRectF(0, 0, self.width, self.height)
+
+	def paint(self, painter, option, widget):
+		colour = QColor(255, 255, 0, 32)
+		painter.fillRect(0, 0, self.width, self.height, colour)
+		x1 = self.width - 1
+		y1 = self.height - 1
+		painter.drawLine(0, 0, x1, 0)
+		painter.drawLine(0, 0, 0, 3)
+		painter.drawLine(x1, 0, x1, 3)
+		painter.drawLine(0, y1, x1, y1)
+		painter.drawLine(0, y1, 0, y1 - 3)
+		painter.drawLine(x1, y1, x1, y1 - 3)
+
+# Graphics item to contain graphs arranged vertically
+
+class VertcalGraphSetGraphicsItem(QGraphicsItem):
+
+	def __init__(self, collection, attrs, event_handler, child_class, parent=None):
+		super(VertcalGraphSetGraphicsItem, self).__init__(parent)
+
+		self.collection = collection
+
+		self.top = 10
+
+		self.width = 0
+		self.height = self.top
+
+		self.rubber_band = None
+		self.rb_enabled = False
+
+		first = True
+		for data in collection.data:
+			child = child_class(collection, data, attrs, event_handler, first, self)
+			child.setPos(0, self.height + 1)
+			rect = child.boundingRect()
+			if rect.right() > self.width:
+				self.width = rect.right()
+			self.height = self.height + rect.bottom() + 1
+			first = False
+
+		self.bracket = VerticalBracketGraphicsItem(self)
+
+	def EnableRubberBand(self, xlo, xhi, rb_event_handler):
+		if self.rb_enabled:
+			return
+		self.rb_enabled = True
+		self.rb_in_view = False
+		self.setAcceptedMouseButtons(Qt.LeftButton)
+		self.rb_xlo = xlo
+		self.rb_xhi = xhi
+		self.rb_event_handler = rb_event_handler
+		self.mousePressEvent = self.MousePressEvent
+		self.mouseMoveEvent = self.MouseMoveEvent
+		self.mouseReleaseEvent = self.MouseReleaseEvent
+
+	def boundingRect(self):
+		return QRectF(0, 0, self.width, self.height)
+
+	def paint(self, painter, option, widget):
+		pass
+
+	def RubberBandParent(self):
+		scene = self.scene()
+		view = scene.views()[0]
+		viewport = view.viewport()
+		return viewport
+
+	def RubberBandSetGeometry(self, rect):
+		scene_rectf = self.mapRectToScene(QRectF(rect))
+		scene = self.scene()
+		view = scene.views()[0]
+		poly = view.mapFromScene(scene_rectf)
+		self.rubber_band.setGeometry(poly.boundingRect())
+
+	def SetSelection(self, selection_state):
+		if self.rubber_band:
+			if selection_state:
+				self.RubberBandSetGeometry(selection_state)
+				self.rubber_band.show()
+			else:
+				self.rubber_band.hide()
+
+	def SetBracket(self, rect):
+		if rect:
+			x, y, width, height = rect.x(), rect.y(), rect.width(), rect.height()
+			self.bracket.setPos(x, y)
+			self.bracket.SetSize(width, height)
+			self.bracket.show()
+		else:
+			self.bracket.hide()
+
+	def RubberBandX(self, event):
+		x = event.pos().toPoint().x()
+		if x < self.rb_xlo:
+			x = self.rb_xlo
+		elif x > self.rb_xhi:
+			x = self.rb_xhi
+		else:
+			self.rb_in_view = True
+		return x
+
+	def RubberBandRect(self, x):
+		if self.rb_origin.x() <= x:
+			width = x - self.rb_origin.x()
+			rect = QRect(self.rb_origin, QSize(width, self.height))
+		else:
+			width = self.rb_origin.x() - x
+			top_left = QPoint(self.rb_origin.x() - width, self.rb_origin.y())
+			rect = QRect(top_left, QSize(width, self.height))
+		return rect
+
+	def MousePressEvent(self, event):
+		self.rb_in_view = False
+		x = self.RubberBandX(event)
+		self.rb_origin = QPoint(x, self.top)
+		if self.rubber_band is None:
+			self.rubber_band = QRubberBand(QRubberBand.Rectangle, self.RubberBandParent())
+		self.RubberBandSetGeometry(QRect(self.rb_origin, QSize(0, self.height)))
+		if self.rb_in_view:
+			self.rubber_band.show()
+			self.rb_event_handler.RBMoveEvent(x, x)
+		else:
+			self.rubber_band.hide()
+
+	def MouseMoveEvent(self, event):
+		x = self.RubberBandX(event)
+		rect = self.RubberBandRect(x)
+		self.RubberBandSetGeometry(rect)
+		if self.rb_in_view:
+			self.rubber_band.show()
+			self.rb_event_handler.RBMoveEvent(self.rb_origin.x(), x)
+
+	def MouseReleaseEvent(self, event):
+		x = self.RubberBandX(event)
+		if self.rb_in_view:
+			selection_state = self.RubberBandRect(x)
+		else:
+			selection_state = None
+		self.rb_event_handler.RBReleaseEvent(self.rb_origin.x(), x, selection_state)
+
+# Switch graph legend data model
+
+class SwitchGraphLegendModel(QAbstractTableModel):
+
+	def __init__(self, collection, region_attributes, parent=None):
+		super(SwitchGraphLegendModel, self).__init__(parent)
+
+		self.region_attributes = region_attributes
+
+		self.child_items = sorted(collection.hregions.values(), key=GraphDataRegionOrdinal)
+		self.child_count = len(self.child_items)
+
+		self.highlight_set = set()
+
+		self.column_headers = ("pid", "tid", "comm")
+
+	def rowCount(self, parent):
+		return self.child_count
+
+	def headerData(self, section, orientation, role):
+		if role != Qt.DisplayRole:
+			return None
+		if orientation != Qt.Horizontal:
+			return None
+		return self.columnHeader(section)
+
+	def index(self, row, column, parent):
+		return self.createIndex(row, column, self.child_items[row])
+
+	def columnCount(self, parent=None):
+		return len(self.column_headers)
+
+	def columnHeader(self, column):
+		return self.column_headers[column]
+
+	def data(self, index, role):
+		if role == Qt.BackgroundRole:
+			child = self.child_items[index.row()]
+			if child in self.highlight_set:
+				return self.region_attributes[child.key].colour
+			return None
+		if role == Qt.ForegroundRole:
+			child = self.child_items[index.row()]
+			if child in self.highlight_set:
+				return QColor(255, 255, 255)
+			return self.region_attributes[child.key].colour
+		if role != Qt.DisplayRole:
+			return None
+		hregion = self.child_items[index.row()]
+		col = index.column()
+		if col == 0:
+			return hregion.pid
+		if col == 1:
+			return hregion.tid
+		if col == 2:
+			return hregion.comm
+		return None
+
+	def SetHighlight(self, row, set_highlight):
+		child = self.child_items[row]
+		top_left = self.createIndex(row, 0, child)
+		bottom_right = self.createIndex(row, len(self.column_headers) - 1, child)
+		self.dataChanged.emit(top_left, bottom_right)
+
+	def Highlight(self, highlight_set):
+		for row in xrange(self.child_count):
+			child = self.child_items[row]
+			if child in self.highlight_set:
+				if child not in highlight_set:
+					self.SetHighlight(row, False)
+			elif child in highlight_set:
+				self.SetHighlight(row, True)
+		self.highlight_set = highlight_set
+
+# Switch graph legend is a table
+
+class SwitchGraphLegend(QWidget):
+
+	def __init__(self, collection, region_attributes, parent=None):
+		super(SwitchGraphLegend, self).__init__(parent)
+
+		self.data_model = SwitchGraphLegendModel(collection, region_attributes)
+
+		self.model = QSortFilterProxyModel()
+		self.model.setSourceModel(self.data_model)
+
+		self.view = QTableView()
+		self.view.setModel(self.model)
+		self.view.setEditTriggers(QAbstractItemView.NoEditTriggers)
+		self.view.verticalHeader().setVisible(False)
+		self.view.sortByColumn(-1, Qt.AscendingOrder)
+		self.view.setSortingEnabled(True)
+		self.view.resizeColumnsToContents()
+		self.view.resizeRowsToContents()
+
+		self.vbox = VBoxLayout(self.view)
+		self.setLayout(self.vbox)
+
+		sz1 = self.view.columnWidth(0) + self.view.columnWidth(1) + self.view.columnWidth(2) + 2
+		sz1 = sz1 + self.view.verticalScrollBar().sizeHint().width()
+		self.saved_size = sz1
+
+	def resizeEvent(self, event):
+		self.saved_size = self.size().width()
+		super(SwitchGraphLegend, self).resizeEvent(event)
+
+	def Highlight(self, highlight_set):
+		self.data_model.Highlight(highlight_set)
+		self.update()
+
+	def changeEvent(self, event):
+		if event.type() == QEvent.FontChange:
+			self.view.resizeRowsToContents()
+			self.view.resizeColumnsToContents()
+			# Need to resize rows again after column resize
+			self.view.resizeRowsToContents()
+		super(SwitchGraphLegend, self).changeEvent(event)
+
+# Random colour generation
+
+def RGBColourTooLight(r, g, b):
+	if g > 230:
+		return True
+	if g <= 160:
+		return False
+	if r <= 180 and g <= 180:
+		return False
+	if r < 60:
+		return False
+	return True
+
+def GenerateColours(x):
+	cs = [0]
+	for i in xrange(1, x):
+		cs.append(int((255.0 / i) + 0.5))
+	colours = []
+	for r in cs:
+		for g in cs:
+			for b in cs:
+				# Exclude black and colours that look too light against a white background
+				if (r, g, b) == (0, 0, 0) or RGBColourTooLight(r, g, b):
+					continue
+				colours.append(QColor(r, g, b))
+	return colours
+
+def GenerateNColours(n):
+	for x in xrange(2, n + 2):
+		colours = GenerateColours(x)
+		if len(colours) >= n:
+			return colours
+	return []
+
+def GenerateNRandomColours(n, seed):
+	colours = GenerateNColours(n)
+	random.seed(seed)
+	random.shuffle(colours)
+	return colours
+
+# Graph attributes, in particular the scale and subrange that change when zooming
+
+class GraphAttributes():
+
+	def __init__(self, scale, subrange, region_attributes, dp):
+		self.scale = scale
+		self.subrange = subrange
+		self.region_attributes = region_attributes
+		# Rounding avoids errors due to finite floating point precision
+		self.dp = dp	# data decimal places
+		self.Update()
+
+	def XToPixel(self, x):
+		return int(round((x - self.subrange.x.lo) * self.scale.x, self.pdp.x))
+
+	def YToPixel(self, y):
+		return int(round((y - self.subrange.y.lo) * self.scale.y, self.pdp.y))
+
+	def PixelToXRounded(self, px):
+		return round((round(px, 0) / self.scale.x), self.dp.x) + self.subrange.x.lo
+
+	def PixelToYRounded(self, py):
+		return round((round(py, 0) / self.scale.y), self.dp.y) + self.subrange.y.lo
+
+	def PixelToX(self, px):
+		x = self.PixelToXRounded(px)
+		if self.pdp.x == 0:
+			rt = self.XToPixel(x)
+			if rt > px:
+				return x - 1
+		return x
+
+	def PixelToY(self, py):
+		y = self.PixelToYRounded(py)
+		if self.pdp.y == 0:
+			rt = self.YToPixel(y)
+			if rt > py:
+				return y - 1
+		return y
+
+	def ToPDP(self, dp, scale):
+		# Calculate pixel decimal places:
+		#    (10 ** dp) is the minimum delta in the data
+		#    scale it to get the minimum delta in pixels
+		#    log10 gives the number of decimals places negatively
+		#    subtrace 1 to divide by 10
+		#    round to the lower negative number
+		#    change the sign to get the number of decimals positively
+		x = math.log10((10 ** dp) * scale)
+		if x < 0:
+			x -= 1
+			x = -int(math.floor(x) - 0.1)
+		else:
+			x = 0
+		return x
+
+	def Update(self):
+		x = self.ToPDP(self.dp.x, self.scale.x)
+		y = self.ToPDP(self.dp.y, self.scale.y)
+		self.pdp = XY(x, y) # pixel decimal places
+
+# Switch graph splitter which divides the CPU graphs from the legend
+
+class SwitchGraphSplitter(QSplitter):
+
+	def __init__(self, parent=None):
+		super(SwitchGraphSplitter, self).__init__(parent)
+
+		self.first_time = False
+
+	def resizeEvent(self, ev):
+		if self.first_time:
+			self.first_time = False
+			sz1 = self.widget(1).view.columnWidth(0) + self.widget(1).view.columnWidth(1) + self.widget(1).view.columnWidth(2) + 2
+			sz1 = sz1 + self.widget(1).view.verticalScrollBar().sizeHint().width()
+			sz0 = self.size().width() - self.handleWidth() - sz1
+			self.setSizes([sz0, sz1])
+		elif not(self.widget(1).saved_size is None):
+			sz1 = self.widget(1).saved_size
+			sz0 = self.size().width() - self.handleWidth() - sz1
+			self.setSizes([sz0, sz1])
+		super(SwitchGraphSplitter, self).resizeEvent(ev)
+
+# Graph widget base class
+
+class GraphWidget(QWidget):
+
+	graph_title_changed = Signal(object)
+
+	def __init__(self, parent=None):
+		super(GraphWidget, self).__init__(parent)
+
+	def GraphTitleChanged(self, title):
+		self.graph_title_changed.emit(title)
+
+	def Title(self):
+		return ""
+
+# Display time in s, ms, us or ns
+
+def ToTimeStr(val):
+	val = Decimal(val)
+	if val >= 1000000000:
+		return "{} s".format((val / 1000000000).quantize(Decimal("0.000000001")))
+	if val >= 1000000:
+		return "{} ms".format((val / 1000000).quantize(Decimal("0.000001")))
+	if val >= 1000:
+		return "{} us".format((val / 1000).quantize(Decimal("0.001")))
+	return "{} ns".format(val.quantize(Decimal("1")))
+
+# Switch (i.e. context switch i.e. Time Chart by CPU) graph widget which contains the CPU graphs and the legend and control buttons
+
+class SwitchGraphWidget(GraphWidget):
+
+	def __init__(self, glb, collection, parent=None):
+		super(SwitchGraphWidget, self).__init__(parent)
+
+		self.glb = glb
+		self.collection = collection
+
+		self.back_state = []
+		self.forward_state = []
+		self.selection_state = (None, None)
+		self.fwd_rect = None
+		self.start_time = self.glb.StartTime(collection.machine_id)
+
+		i = 0
+		hregions = collection.hregions.values()
+		colours = GenerateNRandomColours(len(hregions), 1013)
+		region_attributes = {}
+		for hregion in hregions:
+			if hregion.pid == 0 and hregion.tid == 0:
+				region_attributes[hregion.key] = GraphRegionAttribute(QColor(0, 0, 0))
+			else:
+				region_attributes[hregion.key] = GraphRegionAttribute(colours[i])
+				i = i + 1
+
+		# Default to entire range
+		xsubrange = Subrange(0.0, float(collection.xrangehi - collection.xrangelo) + 1.0)
+		ysubrange = Subrange(0.0, float(collection.yrangehi - collection.yrangelo) + 1.0)
+		subrange = XY(xsubrange, ysubrange)
+
+		scale = self.GetScaleForRange(subrange)
+
+		self.attrs = GraphAttributes(scale, subrange, region_attributes, collection.dp)
+
+		self.item = VertcalGraphSetGraphicsItem(collection, self.attrs, self, SwitchGraphGraphicsItem)
+
+		self.scene = QGraphicsScene()
+		self.scene.addItem(self.item)
+
+		self.view = QGraphicsView(self.scene)
+		self.view.centerOn(0, 0)
+		self.view.setAlignment(Qt.AlignLeft | Qt.AlignTop)
+
+		self.legend = SwitchGraphLegend(collection, region_attributes)
+
+		self.splitter = SwitchGraphSplitter()
+		self.splitter.addWidget(self.view)
+		self.splitter.addWidget(self.legend)
+
+		self.point_label = QLabel("")
+		self.point_label.setSizePolicy(QSizePolicy.Preferred, QSizePolicy.Fixed)
+
+		self.back_button = QToolButton()
+		self.back_button.setIcon(self.style().standardIcon(QStyle.SP_ArrowLeft))
+		self.back_button.setDisabled(True)
+		self.back_button.released.connect(lambda: self.Back())
+
+		self.forward_button = QToolButton()
+		self.forward_button.setIcon(self.style().standardIcon(QStyle.SP_ArrowRight))
+		self.forward_button.setDisabled(True)
+		self.forward_button.released.connect(lambda: self.Forward())
+
+		self.zoom_button = QToolButton()
+		self.zoom_button.setText("Zoom")
+		self.zoom_button.setDisabled(True)
+		self.zoom_button.released.connect(lambda: self.Zoom())
+
+		self.hbox = HBoxLayout(self.back_button, self.forward_button, self.zoom_button, self.point_label)
+
+		self.vbox = VBoxLayout(self.splitter, self.hbox)
+
+		self.setLayout(self.vbox)
+
+	def GetScaleForRangeX(self, xsubrange):
+		# Default graph 1000 pixels wide
+		dflt = 1000.0
+		r = xsubrange.hi - xsubrange.lo
+		return dflt / r
+
+	def GetScaleForRangeY(self, ysubrange):
+		# Default graph 50 pixels high
+		dflt = 50.0
+		r = ysubrange.hi - ysubrange.lo
+		return dflt / r
+
+	def GetScaleForRange(self, subrange):
+		# Default graph 1000 pixels wide, 50 pixels high
+		xscale = self.GetScaleForRangeX(subrange.x)
+		yscale = self.GetScaleForRangeY(subrange.y)
+		return XY(xscale, yscale)
+
+	def PointEvent(self, cpu, time_from, time_to, hregions):
+		text = "CPU: " + str(cpu)
+		time_from = time_from.quantize(Decimal(1))
+		rel_time_from = time_from - self.glb.StartTime(self.collection.machine_id)
+		text = text + " Time: " + str(time_from) + " (+" + ToTimeStr(rel_time_from) + ")"
+		self.point_label.setText(text)
+		self.legend.Highlight(hregions)
+
+	def RightClickEvent(self, cpu, hregion_times, pos):
+		if not IsSelectable(self.glb.db, "calls", "WHERE parent_id >= 0"):
+			return
+		menu = QMenu(self.view)
+		for hregion, time in hregion_times:
+			thread_at_time = (hregion.exec_comm_id, hregion.thread_id, time)
+			menu_text = "Show Call Tree for {} {}:{} at {}".format(hregion.comm, hregion.pid, hregion.tid, time)
+			menu.addAction(CreateAction(menu_text, "Show Call Tree", lambda a=None, args=thread_at_time: self.RightClickSelect(args), self.view))
+		menu.exec_(pos)
+
+	def RightClickSelect(self, args):
+		CallTreeWindow(self.glb, self.glb.mainwindow, thread_at_time=args)
+
+	def NoPointEvent(self):
+		self.point_label.setText("")
+		self.legend.Highlight({})
+
+	def RangeEvent(self, time_from, time_to):
+		time_from = time_from.quantize(Decimal(1))
+		time_to = time_to.quantize(Decimal(1))
+		if time_to <= time_from:
+			self.point_label.setText("")
+			return
+		rel_time_from = time_from - self.start_time
+		rel_time_to = time_to - self.start_time
+		text = " Time: " + str(time_from) + " (+" + ToTimeStr(rel_time_from) + ") to: " + str(time_to) + " (+" + ToTimeStr(rel_time_to) + ")"
+		text = text + " duration: " + ToTimeStr(time_to - time_from)
+		self.point_label.setText(text)
+
+	def BackState(self):
+		return (self.attrs.subrange, self.attrs.scale, self.selection_state, self.fwd_rect)
+
+	def PushBackState(self):
+		state = copy.deepcopy(self.BackState())
+		self.back_state.append(state)
+		self.back_button.setEnabled(True)
+
+	def PopBackState(self):
+		self.attrs.subrange, self.attrs.scale, self.selection_state, self.fwd_rect = self.back_state.pop()
+		self.attrs.Update()
+		if not self.back_state:
+			self.back_button.setDisabled(True)
+
+	def PushForwardState(self):
+		state = copy.deepcopy(self.BackState())
+		self.forward_state.append(state)
+		self.forward_button.setEnabled(True)
+
+	def PopForwardState(self):
+		self.attrs.subrange, self.attrs.scale, self.selection_state, self.fwd_rect = self.forward_state.pop()
+		self.attrs.Update()
+		if not self.forward_state:
+			self.forward_button.setDisabled(True)
+
+	def Title(self):
+		time_from = self.collection.xrangelo + Decimal(self.attrs.subrange.x.lo)
+		time_to = self.collection.xrangelo + Decimal(self.attrs.subrange.x.hi)
+		rel_time_from = time_from - self.start_time
+		rel_time_to = time_to - self.start_time
+		title = "+" + ToTimeStr(rel_time_from) + " to +" + ToTimeStr(rel_time_to)
+		title = title + " (" + ToTimeStr(time_to - time_from) + ")"
+		return title
+
+	def Update(self):
+		selected_subrange, selection_state = self.selection_state
+		self.item.SetSelection(selection_state)
+		self.item.SetBracket(self.fwd_rect)
+		self.zoom_button.setDisabled(selected_subrange is None)
+		self.GraphTitleChanged(self.Title())
+		self.item.update(self.item.boundingRect())
+
+	def Back(self):
+		if not self.back_state:
+			return
+		self.PushForwardState()
+		self.PopBackState()
+		self.Update()
+
+	def Forward(self):
+		if not self.forward_state:
+			return
+		self.PushBackState()
+		self.PopForwardState()
+		self.Update()
+
+	def SelectEvent(self, x0, x1, selection_state):
+		if selection_state is None:
+			selected_subrange = None
+		else:
+			if x1 - x0 < 1.0:
+				x1 += 1.0
+			selected_subrange = Subrange(x0, x1)
+		self.selection_state = (selected_subrange, selection_state)
+		self.zoom_button.setDisabled(selected_subrange is None)
+
+	def Zoom(self):
+		selected_subrange, selection_state = self.selection_state
+		if selected_subrange is None:
+			return
+		self.fwd_rect = selection_state
+		self.item.SetSelection(None)
+		self.PushBackState()
+		self.attrs.subrange.x = selected_subrange
+		self.forward_state = []
+		self.forward_button.setDisabled(True)
+		self.selection_state = (None, None)
+		self.fwd_rect = None
+		self.attrs.scale.x = self.GetScaleForRangeX(self.attrs.subrange.x)
+		self.attrs.Update()
+		self.Update()
+
+# Slow initialization - perform non-GUI initialization in a separate thread and put up a modal message box while waiting
+
+class SlowInitClass():
+
+	def __init__(self, glb, title, init_fn):
+		self.init_fn = init_fn
+		self.done = False
+		self.result = None
+
+		self.msg_box = QMessageBox(glb.mainwindow)
+		self.msg_box.setText("Initializing " + title + ". Please wait.")
+		self.msg_box.setWindowTitle("Initializing " + title)
+		self.msg_box.setWindowIcon(glb.mainwindow.style().standardIcon(QStyle.SP_MessageBoxInformation))
+
+		self.init_thread = Thread(self.ThreadFn, glb)
+		self.init_thread.done.connect(lambda: self.Done(), Qt.QueuedConnection)
+
+		self.init_thread.start()
+
+	def Done(self):
+		self.msg_box.done(0)
+
+	def ThreadFn(self, glb):
+		conn_name = "SlowInitClass" + str(os.getpid())
+		db, dbname = glb.dbref.Open(conn_name)
+		self.result = self.init_fn(db)
+		self.done = True
+		return (True, 0)
+
+	def Result(self):
+		while not self.done:
+			self.msg_box.exec_()
+		self.init_thread.wait()
+		return self.result
+
+def SlowInit(glb, title, init_fn):
+	init = SlowInitClass(glb, title, init_fn)
+	return init.Result()
+
+# Time chart by CPU window
+
+class TimeChartByCPUWindow(QMdiSubWindow):
+
+	def __init__(self, glb, parent=None):
+		super(TimeChartByCPUWindow, self).__init__(parent)
+
+		self.glb = glb
+		self.machine_id = glb.HostMachineId()
+		self.collection_name = "SwitchGraphDataCollection " + str(self.machine_id)
+
+		collection = LookupModel(self.collection_name)
+		if collection is None:
+			collection = SlowInit(glb, "Time Chart", self.Init)
+
+		self.widget = SwitchGraphWidget(glb, collection, self)
+		self.view = self.widget
+
+		self.base_title = "Time Chart by CPU"
+		self.setWindowTitle(self.base_title + self.widget.Title())
+		self.widget.graph_title_changed.connect(self.GraphTitleChanged)
+
+		self.setWidget(self.widget)
+
+		AddSubWindow(glb.mainwindow.mdi_area, self, self.windowTitle())
+
+	def Init(self, db):
+		return LookupCreateModel(self.collection_name, lambda : SwitchGraphDataCollection(self.glb, db, self.machine_id))
+
+	def GraphTitleChanged(self, title):
+		self.setWindowTitle(self.base_title + " : " + title)
+
 # Child data item  finder
 
 class ChildDataItemFinder():
@@ -3025,7 +4323,9 @@ p.c2 {
 <p class=c2><a href=#allbranches>1.3 All branches</a></p>
 <p class=c2><a href=#selectedbranches>1.4 Selected branches</a></p>
 <p class=c2><a href=#topcallsbyelapsedtime>1.5 Top calls by elapsed time</a></p>
-<p class=c1><a href=#tables>2. Tables</a></p>
+<p class=c1><a href=#charts>2. Charts</a></p>
+<p class=c2><a href=#timechartbycpu>2.1 Time chart by CPU</a></p>
+<p class=c1><a href=#tables>3. Tables</a></p>
 <h1 id=reports>1. Reports</h1>
 <h2 id=callgraph>1.1 Context-Sensitive Call Graph</h2>
 The result is a GUI window with a tree representing a context-sensitive
@@ -3113,7 +4413,29 @@ N.B. Due to the granularity of timestamps, there could be no branches in any giv
 The Top calls by elapsed time report displays calls in descending order of time elapsed between when the function was called and when it returned.
 The data is reduced by various selection criteria. A dialog box displays available criteria which are AND'ed together.
 If not all data is fetched, a Fetch bar is provided. Ctrl-F displays a Find bar.
-<h1 id=tables>2. Tables</h1>
+<h1 id=charts>2. Charts</h1>
+<h2 id=timechartbycpu>2.1 Time chart by CPU</h2>
+This chart displays context switch information when that data is available. Refer to context_switches_view on the Tables menu.
+<h3>Features</h3>
+<ol>
+<li>Mouse over to highight the task and show the time</li>
+<li>Drag the mouse to select a region and zoom by pushing the Zoom button</li>
+<li>Go back and forward by pressing the arrow buttons</li>
+<li>If call information is available, right-click to show a call tree opened to that task and time.
+Note, the call tree may take some time to appear, and there may not be call information for the task or time selected.
+</li>
+</ol>
+<h3>Important</h3>
+The graph can be misleading in the following respects:
+<ol>
+<li>The graph shows the first task on each CPU as running from the beginning of the time range.
+Because tracing might start on different CPUs at different times, that is not necessarily the case.
+Refer to context_switches_view on the Tables menu to understand what data the graph is based upon.</li>
+<li>Similarly, the last task on each CPU can be showing running longer than it really was.
+Again, refer to context_switches_view on the Tables menu to understand what data the graph is based upon.</li>
+<li>When the mouse is over a task, the highlighted task might not be visible on the legend without scrolling if the legend does not fit fully in the window</li>
+</ol>
+<h1 id=tables>3. Tables</h1>
 The Tables menu shows all tables and views in the database. Most tables have an associated view
 which displays the information in a more friendly way. Not all data for large tables is fetched
 immediately. More records can be fetched using the Fetch bar provided. Columns can be sorted,
@@ -3309,6 +4631,10 @@ class MainWindow(QMainWindow):
 		if IsSelectable(glb.db, "calls"):
 			reports_menu.addAction(CreateAction("&Top calls by elapsed time", "Create a new window displaying top calls by elapsed time", self.NewTopCalls, self))
 
+		if IsSelectable(glb.db, "context_switches"):
+			charts_menu = menu.addMenu("&Charts")
+			charts_menu.addAction(CreateAction("&Time chart by CPU", "Create a new window displaying time charts by CPU", self.TimeChartByCPU, self))
+
 		self.TableMenu(GetTableList(glb), menu)
 
 		self.window_menu = WindowMenu(self.mdi_area, menu)
@@ -3369,6 +4695,9 @@ class MainWindow(QMainWindow):
 				label = "Selected branches" if branches_events == 1 else "Selected branches " + "(id=" + dbid + ")"
 				reports_menu.addAction(CreateAction(label, "Create a new window displaying branch events", lambda a=None,x=dbid: self.NewSelectedBranchView(x), self))
 
+	def TimeChartByCPU(self):
+		TimeChartByCPUWindow(self.glb, self)
+
 	def TableMenu(self, tables, menu):
 		table_menu = menu.addMenu("&Tables")
 		for table in tables:
-- 
2.17.1

