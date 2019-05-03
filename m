Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC431C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 12:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0BF2075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 12:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfECMKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 08:10:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:1063 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbfECMKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 08:10:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 05:09:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,425,1549958400"; 
   d="scan'208";a="343043091"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga005.fm.intel.com with ESMTP; 03 May 2019 05:09:58 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] perf scripts python: exported-sql-viewer.py: Add copy to clipboard
Date:   Fri,  3 May 2019 15:08:26 +0300
Message-Id: <20190503120828.25326-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190503120828.25326-1-adrian.hunter@intel.com>
References: <20190503120828.25326-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for copying to clipboard. Two menu options are added to copy the
selected rows / columns with normal spacing, or as comma-separated-values.
In the case of trees, only entire rows can be copied.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripts/python/exported-sql-viewer.py     | 217 ++++++++++++++++++
 1 file changed, 217 insertions(+)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index c0fb88d440ba..5804d9705ab7 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -898,6 +898,8 @@ class TreeWindowBase(QMdiSubWindow):
 		self.find_bar = None
 
 		self.view = QTreeView()
+		self.view.setSelectionMode(QAbstractItemView.ContiguousSelection)
+		self.view.CopyCellsToClipboard = CopyTreeCellsToClipboard
 
 	def DisplayFound(self, ids):
 		if not len(ids):
@@ -1666,6 +1668,8 @@ class BranchWindow(QMdiSubWindow):
 
 		self.view = QTreeView()
 		self.view.setUniformRowHeights(True)
+		self.view.setSelectionMode(QAbstractItemView.ContiguousSelection)
+		self.view.CopyCellsToClipboard = CopyTreeCellsToClipboard
 		self.view.setModel(self.model)
 
 		self.ResizeColumnsToContents()
@@ -2278,6 +2282,207 @@ class ResizeColumnsToContentsBase(QObject):
 		self.data_model.rowsInserted.disconnect(self.UpdateColumnWidths)
 		self.ResizeColumnsToContents()
 
+# Convert value to CSV
+
+def ToCSValue(val):
+	if '"' in val:
+		val = val.replace('"', '""')
+	if "," in val or '"' in val:
+		val = '"' + val + '"'
+	return val
+
+# Key to sort table model indexes by row / column, assuming fewer than 1000 columns
+
+glb_max_cols = 1000
+
+def RowColumnKey(a):
+	return a.row() * glb_max_cols + a.column()
+
+# Copy selected table cells to clipboard
+
+def CopyTableCellsToClipboard(view, as_csv=False, with_hdr=False):
+	indexes = sorted(view.selectedIndexes(), key=RowColumnKey)
+	idx_cnt = len(indexes)
+	if not idx_cnt:
+		return
+	if idx_cnt == 1:
+		with_hdr=False
+	min_row = indexes[0].row()
+	max_row = indexes[0].row()
+	min_col = indexes[0].column()
+	max_col = indexes[0].column()
+	for i in indexes:
+		min_row = min(min_row, i.row())
+		max_row = max(max_row, i.row())
+		min_col = min(min_col, i.column())
+		max_col = max(max_col, i.column())
+	if max_col > glb_max_cols:
+		raise RuntimeError("glb_max_cols is too low")
+	max_width = [0] * (1 + max_col - min_col)
+	for i in indexes:
+		c = i.column() - min_col
+		max_width[c] = max(max_width[c], len(str(i.data())))
+	text = ""
+	pad = ""
+	sep = ""
+	if with_hdr:
+		model = indexes[0].model()
+		for col in range(min_col, max_col + 1):
+			val = model.headerData(col, Qt.Horizontal)
+			if as_csv:
+				text += sep + ToCSValue(val)
+				sep = ","
+			else:
+				c = col - min_col
+				max_width[c] = max(max_width[c], len(val))
+				width = max_width[c]
+				align = model.headerData(col, Qt.Horizontal, Qt.TextAlignmentRole)
+				if align & Qt.AlignRight:
+					val = val.rjust(width)
+				text += pad + sep + val
+				pad = " " * (width - len(val))
+				sep = "  "
+		text += "\n"
+		pad = ""
+		sep = ""
+	last_row = min_row
+	for i in indexes:
+		if i.row() > last_row:
+			last_row = i.row()
+			text += "\n"
+			pad = ""
+			sep = ""
+		if as_csv:
+			text += sep + ToCSValue(str(i.data()))
+			sep = ","
+		else:
+			width = max_width[i.column() - min_col]
+			if i.data(Qt.TextAlignmentRole) & Qt.AlignRight:
+				val = str(i.data()).rjust(width)
+			else:
+				val = str(i.data())
+			text += pad + sep + val
+			pad = " " * (width - len(val))
+			sep = "  "
+	QApplication.clipboard().setText(text)
+
+def CopyTreeCellsToClipboard(view, as_csv=False, with_hdr=False):
+	indexes = view.selectedIndexes()
+	if not len(indexes):
+		return
+
+	selection = view.selectionModel()
+
+	first = None
+	for i in indexes:
+		above = view.indexAbove(i)
+		if not selection.isSelected(above):
+			first = i
+			break
+
+	if first is None:
+		raise RuntimeError("CopyTreeCellsToClipboard internal error")
+
+	model = first.model()
+	row_cnt = 0
+	col_cnt = model.columnCount(first)
+	max_width = [0] * col_cnt
+
+	indent_sz = 2
+	indent_str = " " * indent_sz
+
+	expanded_mark_sz = 2
+	if sys.version_info[0] == 3:
+		expanded_mark = "\u25BC "
+		not_expanded_mark = "\u25B6 "
+	else:
+		expanded_mark = unicode(chr(0xE2) + chr(0x96) + chr(0xBC) + " ", "utf-8")
+		not_expanded_mark =  unicode(chr(0xE2) + chr(0x96) + chr(0xB6) + " ", "utf-8")
+	leaf_mark = "  "
+
+	if not as_csv:
+		pos = first
+		while True:
+			row_cnt += 1
+			row = pos.row()
+			for c in range(col_cnt):
+				i = pos.sibling(row, c)
+				if c:
+					n = len(str(i.data()))
+				else:
+					n = len(str(i.data()).strip())
+					n += (i.internalPointer().level - 1) * indent_sz
+					n += expanded_mark_sz
+				max_width[c] = max(max_width[c], n)
+			pos = view.indexBelow(pos)
+			if not selection.isSelected(pos):
+				break
+
+	text = ""
+	pad = ""
+	sep = ""
+	if with_hdr:
+		for c in range(col_cnt):
+			val = model.headerData(c, Qt.Horizontal, Qt.DisplayRole).strip()
+			if as_csv:
+				text += sep + ToCSValue(val)
+				sep = ","
+			else:
+				max_width[c] = max(max_width[c], len(val))
+				width = max_width[c]
+				align = model.headerData(c, Qt.Horizontal, Qt.TextAlignmentRole)
+				if align & Qt.AlignRight:
+					val = val.rjust(width)
+				text += pad + sep + val
+				pad = " " * (width - len(val))
+				sep = "   "
+		text += "\n"
+		pad = ""
+		sep = ""
+
+	pos = first
+	while True:
+		row = pos.row()
+		for c in range(col_cnt):
+			i = pos.sibling(row, c)
+			val = str(i.data())
+			if not c:
+				if model.hasChildren(i):
+					if view.isExpanded(i):
+						mark = expanded_mark
+					else:
+						mark = not_expanded_mark
+				else:
+					mark = leaf_mark
+				val = indent_str * (i.internalPointer().level - 1) + mark + val.strip()
+			if as_csv:
+				text += sep + ToCSValue(val)
+				sep = ","
+			else:
+				width = max_width[c]
+				if c and i.data(Qt.TextAlignmentRole) & Qt.AlignRight:
+					val = val.rjust(width)
+				text += pad + sep + val
+				pad = " " * (width - len(val))
+				sep = "   "
+		pos = view.indexBelow(pos)
+		if not selection.isSelected(pos):
+			break
+		text = text.rstrip() + "\n"
+		pad = ""
+		sep = ""
+
+	QApplication.clipboard().setText(text)
+
+def CopyCellsToClipboard(view, as_csv=False, with_hdr=False):
+	view.CopyCellsToClipboard(view, as_csv, with_hdr)
+
+def CopyCellsToClipboardHdr(view):
+	CopyCellsToClipboard(view, False, True)
+
+def CopyCellsToClipboardCSV(view):
+	CopyCellsToClipboard(view, True, True)
+
 # Table window
 
 class TableWindow(QMdiSubWindow, ResizeColumnsToContentsBase):
@@ -2296,6 +2501,8 @@ class TableWindow(QMdiSubWindow, ResizeColumnsToContentsBase):
 		self.view.verticalHeader().setVisible(False)
 		self.view.sortByColumn(-1, Qt.AscendingOrder)
 		self.view.setSortingEnabled(True)
+		self.view.setSelectionMode(QAbstractItemView.ContiguousSelection)
+		self.view.CopyCellsToClipboard = CopyTableCellsToClipboard
 
 		self.ResizeColumnsToContents()
 
@@ -2412,6 +2619,8 @@ class TopCallsWindow(QMdiSubWindow, ResizeColumnsToContentsBase):
 		self.view.setModel(self.model)
 		self.view.setEditTriggers(QAbstractItemView.NoEditTriggers)
 		self.view.verticalHeader().setVisible(False)
+		self.view.setSelectionMode(QAbstractItemView.ContiguousSelection)
+		self.view.CopyCellsToClipboard = CopyTableCellsToClipboard
 
 		self.ResizeColumnsToContents()
 
@@ -2749,6 +2958,8 @@ class MainWindow(QMainWindow):
 		file_menu.addAction(CreateExitAction(glb.app, self))
 
 		edit_menu = menu.addMenu("&Edit")
+		edit_menu.addAction(CreateAction("&Copy", "Copy to clipboard", self.CopyToClipboard, self, QKeySequence.Copy))
+		edit_menu.addAction(CreateAction("Copy as CS&V", "Copy to clipboard as CSV", self.CopyToClipboardCSV, self))
 		edit_menu.addAction(CreateAction("&Find...", "Find items", self.Find, self, QKeySequence.Find))
 		edit_menu.addAction(CreateAction("Fetch &more records...", "Fetch more records", self.FetchMoreRecords, self, [QKeySequence(Qt.Key_F8)]))
 		edit_menu.addAction(CreateAction("&Shrink Font", "Make text smaller", self.ShrinkFont, self, [QKeySequence("Ctrl+-")]))
@@ -2781,6 +2992,12 @@ class MainWindow(QMainWindow):
 			except:
 				pass
 
+	def CopyToClipboard(self):
+		self.Try(CopyCellsToClipboardHdr)
+
+	def CopyToClipboardCSV(self):
+		self.Try(CopyCellsToClipboardCSV)
+
 	def Find(self):
 		win = self.mdi_area.activeSubWindow()
 		if win:
-- 
2.17.1

