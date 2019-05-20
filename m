Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9C8C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B8A20863
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733215AbfETLiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:38:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:48121 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733190AbfETLiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:38:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 04:38:09 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga004.fm.intel.com with ESMTP; 20 May 2019 04:38:07 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 18/22] perf scripts python: exported-sql-viewer.py: Add IPC information to the Branch reports
Date:   Mon, 20 May 2019 14:37:24 +0300
Message-Id: <20190520113728.14389-19-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190520113728.14389-1-adrian.hunter@intel.com>
References: <20190520113728.14389-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enhance the "All branches" and "Selected branches" reports to display IPC
information if it is available.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripts/python/exported-sql-viewer.py     | 102 ++++++++++++++----
 1 file changed, 83 insertions(+), 19 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 6fe553258ce5..a607235c8cd9 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1369,11 +1369,11 @@ class FetchMoreRecordsBar():
 
 class BranchLevelTwoItem():
 
-	def __init__(self, row, text, parent_item):
+	def __init__(self, row, col, text, parent_item):
 		self.row = row
 		self.parent_item = parent_item
-		self.data = [""] * 8
-		self.data[7] = text
+		self.data = [""] * (col + 1)
+		self.data[col] = text
 		self.level = 2
 
 	def getParentItem(self):
@@ -1405,6 +1405,7 @@ class BranchLevelOneItem():
 		self.dbid = data[0]
 		self.level = 1
 		self.query_done = False
+		self.br_col = len(self.data) - 1
 
 	def getChildItem(self, row):
 		return self.child_items[row]
@@ -1485,7 +1486,7 @@ class BranchLevelOneItem():
 				while k < 15:
 					byte_str += "   "
 					k += 1
-				self.child_items.append(BranchLevelTwoItem(0, byte_str + " " + text, self))
+				self.child_items.append(BranchLevelTwoItem(0, self.br_col, byte_str + " " + text, self))
 				self.child_count += 1
 			else:
 				return
@@ -1536,16 +1537,37 @@ class BranchRootItem():
 	def getData(self, column):
 		return ""
 
+# Calculate instructions per cycle
+
+def CalcIPC(cyc_cnt, insn_cnt):
+	if cyc_cnt and insn_cnt:
+		ipc = Decimal(float(insn_cnt) / cyc_cnt)
+		ipc = str(ipc.quantize(Decimal(".01"), rounding=ROUND_HALF_UP))
+	else:
+		ipc = "0"
+	return ipc
+
 # Branch data preparation
 
-def BranchDataPrep(query):
-	data = []
-	for i in xrange(0, 8):
-		data.append(query.value(i))
+def BranchDataPrepBr(query, data):
 	data.append(tohex(query.value(8)).rjust(16) + " " + query.value(9) + offstr(query.value(10)) +
 			" (" + dsoname(query.value(11)) + ")" + " -> " +
 			tohex(query.value(12)) + " " + query.value(13) + offstr(query.value(14)) +
 			" (" + dsoname(query.value(15)) + ")")
+
+def BranchDataPrepIPC(query, data):
+	insn_cnt = query.value(16)
+	cyc_cnt = query.value(17)
+	ipc = CalcIPC(cyc_cnt, insn_cnt)
+	data.append(insn_cnt)
+	data.append(cyc_cnt)
+	data.append(ipc)
+
+def BranchDataPrep(query):
+	data = []
+	for i in xrange(0, 8):
+		data.append(query.value(i))
+	BranchDataPrepBr(query, data)
 	return data
 
 def BranchDataPrepWA(query):
@@ -1555,10 +1577,26 @@ def BranchDataPrepWA(query):
 	data.append("{:>19}".format(query.value(1)))
 	for i in xrange(2, 8):
 		data.append(query.value(i))
-	data.append(tohex(query.value(8)).rjust(16) + " " + query.value(9) + offstr(query.value(10)) +
-			" (" + dsoname(query.value(11)) + ")" + " -> " +
-			tohex(query.value(12)) + " " + query.value(13) + offstr(query.value(14)) +
-			" (" + dsoname(query.value(15)) + ")")
+	BranchDataPrepBr(query, data)
+	return data
+
+def BranchDataWithIPCPrep(query):
+	data = []
+	for i in xrange(0, 8):
+		data.append(query.value(i))
+	BranchDataPrepIPC(query, data)
+	BranchDataPrepBr(query, data)
+	return data
+
+def BranchDataWithIPCPrepWA(query):
+	data = []
+	data.append(query.value(0))
+	# Workaround pyside failing to handle large integers (i.e. time) in python3 by converting to a string
+	data.append("{:>19}".format(query.value(1)))
+	for i in xrange(2, 8):
+		data.append(query.value(i))
+	BranchDataPrepIPC(query, data)
+	BranchDataPrepBr(query, data)
 	return data
 
 # Branch data model
@@ -1572,10 +1610,20 @@ class BranchModel(TreeModel):
 		self.event_id = event_id
 		self.more = True
 		self.populated = 0
+		self.have_ipc = IsSelectable(glb.db, "samples", columns = "insn_count, cyc_count")
+		if self.have_ipc:
+			select_ipc = ", insn_count, cyc_count"
+			prep_fn = BranchDataWithIPCPrep
+			prep_wa_fn = BranchDataWithIPCPrepWA
+		else:
+			select_ipc = ""
+			prep_fn = BranchDataPrep
+			prep_wa_fn = BranchDataPrepWA
 		sql = ("SELECT samples.id, time, cpu, comm, pid, tid, branch_types.name,"
 			" CASE WHEN in_tx = '0' THEN 'No' ELSE 'Yes' END,"
 			" ip, symbols.name, sym_offset, dsos.short_name,"
 			" to_ip, to_symbols.name, to_sym_offset, to_dsos.short_name"
+			+ select_ipc +
 			" FROM samples"
 			" INNER JOIN comms ON comm_id = comms.id"
 			" INNER JOIN threads ON thread_id = threads.id"
@@ -1589,9 +1637,9 @@ class BranchModel(TreeModel):
 			" ORDER BY samples.id"
 			" LIMIT " + str(glb_chunk_sz))
 		if pyside_version_1 and sys.version_info[0] == 3:
-			prep = BranchDataPrepWA
+			prep = prep_fn
 		else:
-			prep = BranchDataPrep
+			prep = prep_wa_fn
 		self.fetcher = SQLFetcher(glb, sql, prep, self.AddSample)
 		self.fetcher.done.connect(self.Update)
 		self.fetcher.Fetch(glb_chunk_sz)
@@ -1600,13 +1648,23 @@ class BranchModel(TreeModel):
 		return BranchRootItem()
 
 	def columnCount(self, parent=None):
-		return 8
+		if self.have_ipc:
+			return 11
+		else:
+			return 8
 
 	def columnHeader(self, column):
-		return ("Time", "CPU", "Command", "PID", "TID", "Branch Type", "In Tx", "Branch")[column]
+		if self.have_ipc:
+			return ("Time", "CPU", "Command", "PID", "TID", "Branch Type", "In Tx", "Insn Cnt", "Cyc Cnt", "IPC", "Branch")[column]
+		else:
+			return ("Time", "CPU", "Command", "PID", "TID", "Branch Type", "In Tx", "Branch")[column]
 
 	def columnFont(self, column):
-		if column != 7:
+		if self.have_ipc:
+			br_col = 10
+		else:
+			br_col = 7
+		if column != br_col:
 			return None
 		return QFont("Monospace")
 
@@ -2114,10 +2172,10 @@ def GetEventList(db):
 
 # Is a table selectable
 
-def IsSelectable(db, table, sql = ""):
+def IsSelectable(db, table, sql = "", columns = "*"):
 	query = QSqlQuery(db)
 	try:
-		QueryExec(query, "SELECT * FROM " + table + " " + sql + " LIMIT 1")
+		QueryExec(query, "SELECT " + columns + " FROM " + table + " " + sql + " LIMIT 1")
 	except:
 		return False
 	return True
@@ -2854,6 +2912,12 @@ cd xed
 sudo ./mfile.py --prefix=/usr/local install
 sudo ldconfig
 </pre>
+<h3>Instructions per Cycle (IPC)</h3>
+If available, IPC information is displayed in columns 'insn_cnt', 'cyc_cnt' and 'IPC'.
+<p><b>Intel PT note:</b> The information applies to the blocks of code ending with, and including, that branch.
+Due to the granularity of timing information, the number of cycles for some code blocks will not be known.
+In that case, 'insn_cnt', 'cyc_cnt' and 'IPC' are zero, but when 'IPC' is displayed it covers the period
+since the previous displayed 'IPC'.
 <h3>Find</h3>
 Ctrl-F displays a Find bar which finds substrings by either an exact match or a regular expression match.
 Refer to Python documentation for the regular expression syntax.
-- 
2.17.1

