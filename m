Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674DCC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB2520863
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733259AbfETLi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:38:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:48121 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733219AbfETLiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:38:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 04:38:13 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga004.fm.intel.com with ESMTP; 20 May 2019 04:38:12 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 21/22] perf scripts python: exported-sql-viewer.py: Add IPC information to Call Tree
Date:   Mon, 20 May 2019 14:37:27 +0300
Message-Id: <20190520113728.14389-22-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190520113728.14389-1-adrian.hunter@intel.com>
References: <20190520113728.14389-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enhance the call tree to display IPC information if it is available.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripts/python/exported-sql-viewer.py     | 69 +++++++++++++++----
 1 file changed, 56 insertions(+), 13 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index f5b1b63995b0..94489cf2ce0e 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -781,11 +781,13 @@ class CallGraphModel(CallGraphModelBase):
 
 class CallTreeLevelTwoPlusItemBase(CallGraphLevelItemBase):
 
-	def __init__(self, glb, params, row, comm_id, thread_id, calls_id, time, branch_count, parent_item):
+	def __init__(self, glb, params, row, comm_id, thread_id, calls_id, time, insn_cnt, cyc_cnt, branch_count, parent_item):
 		super(CallTreeLevelTwoPlusItemBase, self).__init__(glb, params, row, parent_item)
 		self.comm_id = comm_id
 		self.thread_id = thread_id
 		self.calls_id = calls_id
+		self.insn_cnt = insn_cnt
+		self.cyc_cnt = cyc_cnt
 		self.branch_count = branch_count
 		self.time = time
 
@@ -795,8 +797,12 @@ class CallTreeLevelTwoPlusItemBase(CallGraphLevelItemBase):
 			comm_thread = " AND comm_id = " + str(self.comm_id) + " AND thread_id = " + str(self.thread_id)
 		else:
 			comm_thread = ""
+		if self.params.have_ipc:
+			ipc_str = ", insn_count, cyc_count"
+		else:
+			ipc_str = ""
 		query = QSqlQuery(self.glb.db)
-		QueryExec(query, "SELECT calls.id, name, short_name, call_time, return_time - call_time, branch_count"
+		QueryExec(query, "SELECT calls.id, name, short_name, call_time, return_time - call_time" + ipc_str + ", branch_count"
 					" FROM calls"
 					" INNER JOIN call_paths ON calls.call_path_id = call_paths.id"
 					" INNER JOIN symbols ON call_paths.symbol_id = symbols.id"
@@ -804,7 +810,15 @@ class CallTreeLevelTwoPlusItemBase(CallGraphLevelItemBase):
 					" WHERE calls.parent_id = " + str(self.calls_id) + comm_thread +
 					" ORDER BY call_time, calls.id")
 		while query.next():
-			child_item = CallTreeLevelThreeItem(self.glb, self.params, self.child_count, self.comm_id, self.thread_id, query.value(0), query.value(1), query.value(2), query.value(3), int(query.value(4)), int(query.value(5)), self)
+			if self.params.have_ipc:
+				insn_cnt = int(query.value(5))
+				cyc_cnt = int(query.value(6))
+				branch_count = int(query.value(7))
+			else:
+				insn_cnt = 0
+				cyc_cnt = 0
+				branch_count = int(query.value(5))
+			child_item = CallTreeLevelThreeItem(self.glb, self.params, self.child_count, self.comm_id, self.thread_id, query.value(0), query.value(1), query.value(2), query.value(3), int(query.value(4)), insn_cnt, cyc_cnt, branch_count, self)
 			self.child_items.append(child_item)
 			self.child_count += 1
 
@@ -812,10 +826,17 @@ class CallTreeLevelTwoPlusItemBase(CallGraphLevelItemBase):
 
 class CallTreeLevelThreeItem(CallTreeLevelTwoPlusItemBase):
 
-	def __init__(self, glb, params, row, comm_id, thread_id, calls_id, name, dso, count, time, branch_count, parent_item):
-		super(CallTreeLevelThreeItem, self).__init__(glb, params, row, comm_id, thread_id, calls_id, time, branch_count, parent_item)
+	def __init__(self, glb, params, row, comm_id, thread_id, calls_id, name, dso, count, time, insn_cnt, cyc_cnt, branch_count, parent_item):
+		super(CallTreeLevelThreeItem, self).__init__(glb, params, row, comm_id, thread_id, calls_id, time, insn_cnt, cyc_cnt, branch_count, parent_item)
 		dso = dsoname(dso)
-		self.data = [ name, dso, str(count), str(time), PercentToOneDP(time, parent_item.time), str(branch_count), PercentToOneDP(branch_count, parent_item.branch_count) ]
+		if self.params.have_ipc:
+			insn_pcnt = PercentToOneDP(insn_cnt, parent_item.insn_cnt)
+			cyc_pcnt = PercentToOneDP(cyc_cnt, parent_item.cyc_cnt)
+			br_pcnt = PercentToOneDP(branch_count, parent_item.branch_count)
+			ipc = CalcIPC(cyc_cnt, insn_cnt)
+			self.data = [ name, dso, str(count), str(time), PercentToOneDP(time, parent_item.time), str(insn_cnt), insn_pcnt, str(cyc_cnt), cyc_pcnt, ipc, str(branch_count), br_pcnt ]
+		else:
+			self.data = [ name, dso, str(count), str(time), PercentToOneDP(time, parent_item.time), str(branch_count), PercentToOneDP(branch_count, parent_item.branch_count) ]
 		self.dbid = calls_id
 
 # Call tree data model level two item
@@ -823,18 +844,28 @@ class CallTreeLevelThreeItem(CallTreeLevelTwoPlusItemBase):
 class CallTreeLevelTwoItem(CallTreeLevelTwoPlusItemBase):
 
 	def __init__(self, glb, params, row, comm_id, thread_id, pid, tid, parent_item):
-		super(CallTreeLevelTwoItem, self).__init__(glb, params, row, comm_id, thread_id, 0, 0, 0, parent_item)
-		self.data = [str(pid) + ":" + str(tid), "", "", "", "", "", ""]
+		super(CallTreeLevelTwoItem, self).__init__(glb, params, row, comm_id, thread_id, 0, 0, 0, 0, 0, parent_item)
+		if self.params.have_ipc:
+			self.data = [str(pid) + ":" + str(tid), "", "", "", "", "", "", "", "", "", "", ""]
+		else:
+			self.data = [str(pid) + ":" + str(tid), "", "", "", "", "", ""]
 		self.dbid = thread_id
 
 	def Select(self):
 		super(CallTreeLevelTwoItem, self).Select()
 		for child_item in self.child_items:
 			self.time += child_item.time
+			self.insn_cnt += child_item.insn_cnt
+			self.cyc_cnt += child_item.cyc_cnt
 			self.branch_count += child_item.branch_count
 		for child_item in self.child_items:
 			child_item.data[4] = PercentToOneDP(child_item.time, self.time)
-			child_item.data[6] = PercentToOneDP(child_item.branch_count, self.branch_count)
+			if self.params.have_ipc:
+				child_item.data[6] = PercentToOneDP(child_item.insn_cnt, self.insn_cnt)
+				child_item.data[8] = PercentToOneDP(child_item.cyc_cnt, self.cyc_cnt)
+				child_item.data[11] = PercentToOneDP(child_item.branch_count, self.branch_count)
+			else:
+				child_item.data[6] = PercentToOneDP(child_item.branch_count, self.branch_count)
 
 # Call tree data model level one item
 
@@ -842,7 +873,10 @@ class CallTreeLevelOneItem(CallGraphLevelItemBase):
 
 	def __init__(self, glb, params, row, comm_id, comm, parent_item):
 		super(CallTreeLevelOneItem, self).__init__(glb, params, row, parent_item)
-		self.data = [comm, "", "", "", "", "", ""]
+		if self.params.have_ipc:
+			self.data = [comm, "", "", "", "", "", "", "", "", "", "", ""]
+		else:
+			self.data = [comm, "", "", "", "", "", ""]
 		self.dbid = comm_id
 
 	def Select(self):
@@ -885,14 +919,23 @@ class CallTreeModel(CallGraphModelBase):
 		return CallTreeRootItem(self.glb, self.params)
 
 	def columnCount(self, parent=None):
-		return 7
+		if self.params.have_ipc:
+			return 12
+		else:
+			return 7
 
 	def columnHeader(self, column):
-		headers = ["Call Path", "Object", "Call Time", "Time (ns) ", "Time (%) ", "Branch Count ", "Branch Count (%) "]
+		if self.params.have_ipc:
+			headers = ["Call Path", "Object", "Call Time", "Time (ns) ", "Time (%) ", "Insn Cnt", "Insn Cnt (%)", "Cyc Cnt", "Cyc Cnt (%)", "IPC", "Branch Count ", "Branch Count (%) "]
+		else:
+			headers = ["Call Path", "Object", "Call Time", "Time (ns) ", "Time (%) ", "Branch Count ", "Branch Count (%) "]
 		return headers[column]
 
 	def columnAlignment(self, column):
-		alignment = [ Qt.AlignLeft, Qt.AlignLeft, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight ]
+		if self.params.have_ipc:
+			alignment = [ Qt.AlignLeft, Qt.AlignLeft, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight ]
+		else:
+			alignment = [ Qt.AlignLeft, Qt.AlignLeft, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight ]
 		return alignment[column]
 
 	def DoFindSelect(self, query, match):
-- 
2.17.1

