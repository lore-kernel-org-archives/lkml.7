Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F248C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ADE020863
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733226AbfETLiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:38:14 -0400
Received: from mga04.intel.com ([192.55.52.120]:48121 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733197AbfETLiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:38:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 04:38:10 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga004.fm.intel.com with ESMTP; 20 May 2019 04:38:09 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 19/22] perf scripts python: exported-sql-viewer.py: Add CallGraphModelParams
Date:   Mon, 20 May 2019 14:37:25 +0300
Message-Id: <20190520113728.14389-20-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190520113728.14389-1-adrian.hunter@intel.com>
References: <20190520113728.14389-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a parameter to call graph and call tree, to determine whether IPC
information is available.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripts/python/exported-sql-viewer.py     | 73 +++++++++++--------
 1 file changed, 41 insertions(+), 32 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index a607235c8cd9..b3508bd4eb00 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -200,9 +200,10 @@ class Thread(QThread):
 
 class TreeModel(QAbstractItemModel):
 
-	def __init__(self, glb, parent=None):
+	def __init__(self, glb, params, parent=None):
 		super(TreeModel, self).__init__(parent)
 		self.glb = glb
+		self.params = params
 		self.root = self.GetRoot()
 		self.last_row_read = 0
 
@@ -463,8 +464,9 @@ class FindBar():
 
 class CallGraphLevelItemBase(object):
 
-	def __init__(self, glb, row, parent_item):
+	def __init__(self, glb, params, row, parent_item):
 		self.glb = glb
+		self.params = params
 		self.row = row
 		self.parent_item = parent_item
 		self.query_done = False;
@@ -503,8 +505,8 @@ class CallGraphLevelItemBase(object):
 
 class CallGraphLevelTwoPlusItemBase(CallGraphLevelItemBase):
 
-	def __init__(self, glb, row, comm_id, thread_id, call_path_id, time, branch_count, parent_item):
-		super(CallGraphLevelTwoPlusItemBase, self).__init__(glb, row, parent_item)
+	def __init__(self, glb, params, row, comm_id, thread_id, call_path_id, time, branch_count, parent_item):
+		super(CallGraphLevelTwoPlusItemBase, self).__init__(glb, params, row, parent_item)
 		self.comm_id = comm_id
 		self.thread_id = thread_id
 		self.call_path_id = call_path_id
@@ -525,7 +527,7 @@ class CallGraphLevelTwoPlusItemBase(CallGraphLevelItemBase):
 					" GROUP BY call_path_id, name, short_name"
 					" ORDER BY call_path_id")
 		while query.next():
-			child_item = CallGraphLevelThreeItem(self.glb, self.child_count, self.comm_id, self.thread_id, query.value(0), query.value(1), query.value(2), query.value(3), int(query.value(4)), int(query.value(5)), self)
+			child_item = CallGraphLevelThreeItem(self.glb, self.params, self.child_count, self.comm_id, self.thread_id, query.value(0), query.value(1), query.value(2), query.value(3), int(query.value(4)), int(query.value(5)), self)
 			self.child_items.append(child_item)
 			self.child_count += 1
 
@@ -533,8 +535,8 @@ class CallGraphLevelTwoPlusItemBase(CallGraphLevelItemBase):
 
 class CallGraphLevelThreeItem(CallGraphLevelTwoPlusItemBase):
 
-	def __init__(self, glb, row, comm_id, thread_id, call_path_id, name, dso, count, time, branch_count, parent_item):
-		super(CallGraphLevelThreeItem, self).__init__(glb, row, comm_id, thread_id, call_path_id, time, branch_count, parent_item)
+	def __init__(self, glb, params, row, comm_id, thread_id, call_path_id, name, dso, count, time, branch_count, parent_item):
+		super(CallGraphLevelThreeItem, self).__init__(glb, params, row, comm_id, thread_id, call_path_id, time, branch_count, parent_item)
 		dso = dsoname(dso)
 		self.data = [ name, dso, str(count), str(time), PercentToOneDP(time, parent_item.time), str(branch_count), PercentToOneDP(branch_count, parent_item.branch_count) ]
 		self.dbid = call_path_id
@@ -543,8 +545,8 @@ class CallGraphLevelThreeItem(CallGraphLevelTwoPlusItemBase):
 
 class CallGraphLevelTwoItem(CallGraphLevelTwoPlusItemBase):
 
-	def __init__(self, glb, row, comm_id, thread_id, pid, tid, parent_item):
-		super(CallGraphLevelTwoItem, self).__init__(glb, row, comm_id, thread_id, 1, 0, 0, parent_item)
+	def __init__(self, glb, params, row, comm_id, thread_id, pid, tid, parent_item):
+		super(CallGraphLevelTwoItem, self).__init__(glb, params, row, comm_id, thread_id, 1, 0, 0, parent_item)
 		self.data = [str(pid) + ":" + str(tid), "", "", "", "", "", ""]
 		self.dbid = thread_id
 
@@ -561,8 +563,8 @@ class CallGraphLevelTwoItem(CallGraphLevelTwoPlusItemBase):
 
 class CallGraphLevelOneItem(CallGraphLevelItemBase):
 
-	def __init__(self, glb, row, comm_id, comm, parent_item):
-		super(CallGraphLevelOneItem, self).__init__(glb, row, parent_item)
+	def __init__(self, glb, params, row, comm_id, comm, parent_item):
+		super(CallGraphLevelOneItem, self).__init__(glb, params, row, parent_item)
 		self.data = [comm, "", "", "", "", "", ""]
 		self.dbid = comm_id
 
@@ -574,7 +576,7 @@ class CallGraphLevelOneItem(CallGraphLevelItemBase):
 					" INNER JOIN threads ON thread_id = threads.id"
 					" WHERE comm_id = " + str(self.dbid))
 		while query.next():
-			child_item = CallGraphLevelTwoItem(self.glb, self.child_count, self.dbid, query.value(0), query.value(1), query.value(2), self)
+			child_item = CallGraphLevelTwoItem(self.glb, self.params, self.child_count, self.dbid, query.value(0), query.value(1), query.value(2), self)
 			self.child_items.append(child_item)
 			self.child_count += 1
 
@@ -582,8 +584,8 @@ class CallGraphLevelOneItem(CallGraphLevelItemBase):
 
 class CallGraphRootItem(CallGraphLevelItemBase):
 
-	def __init__(self, glb):
-		super(CallGraphRootItem, self).__init__(glb, 0, None)
+	def __init__(self, glb, params):
+		super(CallGraphRootItem, self).__init__(glb, params, 0, None)
 		self.dbid = 0
 		self.query_done = True;
 		query = QSqlQuery(glb.db)
@@ -591,16 +593,23 @@ class CallGraphRootItem(CallGraphLevelItemBase):
 		while query.next():
 			if not query.value(0):
 				continue
-			child_item = CallGraphLevelOneItem(glb, self.child_count, query.value(0), query.value(1), self)
+			child_item = CallGraphLevelOneItem(glb, params, self.child_count, query.value(0), query.value(1), self)
 			self.child_items.append(child_item)
 			self.child_count += 1
 
+# Call graph model parameters
+
+class CallGraphModelParams():
+
+	def __init__(self, glb, parent=None):
+		self.have_ipc = IsSelectable(glb.db, "calls", columns = "insn_count, cyc_count")
+
 # Context-sensitive call graph data model base
 
 class CallGraphModelBase(TreeModel):
 
 	def __init__(self, glb, parent=None):
-		super(CallGraphModelBase, self).__init__(glb, parent)
+		super(CallGraphModelBase, self).__init__(glb, CallGraphModelParams(glb), parent)
 
 	def FindSelect(self, value, pattern, query):
 		if pattern:
@@ -682,7 +691,7 @@ class CallGraphModel(CallGraphModelBase):
 		super(CallGraphModel, self).__init__(glb, parent)
 
 	def GetRoot(self):
-		return CallGraphRootItem(self.glb)
+		return CallGraphRootItem(self.glb, self.params)
 
 	def columnCount(self, parent=None):
 		return 7
@@ -729,8 +738,8 @@ class CallGraphModel(CallGraphModelBase):
 
 class CallTreeLevelTwoPlusItemBase(CallGraphLevelItemBase):
 
-	def __init__(self, glb, row, comm_id, thread_id, calls_id, time, branch_count, parent_item):
-		super(CallTreeLevelTwoPlusItemBase, self).__init__(glb, row, parent_item)
+	def __init__(self, glb, params, row, comm_id, thread_id, calls_id, time, branch_count, parent_item):
+		super(CallTreeLevelTwoPlusItemBase, self).__init__(glb, params, row, parent_item)
 		self.comm_id = comm_id
 		self.thread_id = thread_id
 		self.calls_id = calls_id
@@ -752,7 +761,7 @@ class CallTreeLevelTwoPlusItemBase(CallGraphLevelItemBase):
 					" WHERE calls.parent_id = " + str(self.calls_id) + comm_thread +
 					" ORDER BY call_time, calls.id")
 		while query.next():
-			child_item = CallTreeLevelThreeItem(self.glb, self.child_count, self.comm_id, self.thread_id, query.value(0), query.value(1), query.value(2), query.value(3), int(query.value(4)), int(query.value(5)), self)
+			child_item = CallTreeLevelThreeItem(self.glb, self.params, self.child_count, self.comm_id, self.thread_id, query.value(0), query.value(1), query.value(2), query.value(3), int(query.value(4)), int(query.value(5)), self)
 			self.child_items.append(child_item)
 			self.child_count += 1
 
@@ -760,8 +769,8 @@ class CallTreeLevelTwoPlusItemBase(CallGraphLevelItemBase):
 
 class CallTreeLevelThreeItem(CallTreeLevelTwoPlusItemBase):
 
-	def __init__(self, glb, row, comm_id, thread_id, calls_id, name, dso, count, time, branch_count, parent_item):
-		super(CallTreeLevelThreeItem, self).__init__(glb, row, comm_id, thread_id, calls_id, time, branch_count, parent_item)
+	def __init__(self, glb, params, row, comm_id, thread_id, calls_id, name, dso, count, time, branch_count, parent_item):
+		super(CallTreeLevelThreeItem, self).__init__(glb, params, row, comm_id, thread_id, calls_id, time, branch_count, parent_item)
 		dso = dsoname(dso)
 		self.data = [ name, dso, str(count), str(time), PercentToOneDP(time, parent_item.time), str(branch_count), PercentToOneDP(branch_count, parent_item.branch_count) ]
 		self.dbid = calls_id
@@ -770,8 +779,8 @@ class CallTreeLevelThreeItem(CallTreeLevelTwoPlusItemBase):
 
 class CallTreeLevelTwoItem(CallTreeLevelTwoPlusItemBase):
 
-	def __init__(self, glb, row, comm_id, thread_id, pid, tid, parent_item):
-		super(CallTreeLevelTwoItem, self).__init__(glb, row, comm_id, thread_id, 0, 0, 0, parent_item)
+	def __init__(self, glb, params, row, comm_id, thread_id, pid, tid, parent_item):
+		super(CallTreeLevelTwoItem, self).__init__(glb, params, row, comm_id, thread_id, 0, 0, 0, parent_item)
 		self.data = [str(pid) + ":" + str(tid), "", "", "", "", "", ""]
 		self.dbid = thread_id
 
@@ -788,8 +797,8 @@ class CallTreeLevelTwoItem(CallTreeLevelTwoPlusItemBase):
 
 class CallTreeLevelOneItem(CallGraphLevelItemBase):
 
-	def __init__(self, glb, row, comm_id, comm, parent_item):
-		super(CallTreeLevelOneItem, self).__init__(glb, row, parent_item)
+	def __init__(self, glb, params, row, comm_id, comm, parent_item):
+		super(CallTreeLevelOneItem, self).__init__(glb, params, row, parent_item)
 		self.data = [comm, "", "", "", "", "", ""]
 		self.dbid = comm_id
 
@@ -801,7 +810,7 @@ class CallTreeLevelOneItem(CallGraphLevelItemBase):
 					" INNER JOIN threads ON thread_id = threads.id"
 					" WHERE comm_id = " + str(self.dbid))
 		while query.next():
-			child_item = CallTreeLevelTwoItem(self.glb, self.child_count, self.dbid, query.value(0), query.value(1), query.value(2), self)
+			child_item = CallTreeLevelTwoItem(self.glb, self.params, self.child_count, self.dbid, query.value(0), query.value(1), query.value(2), self)
 			self.child_items.append(child_item)
 			self.child_count += 1
 
@@ -809,8 +818,8 @@ class CallTreeLevelOneItem(CallGraphLevelItemBase):
 
 class CallTreeRootItem(CallGraphLevelItemBase):
 
-	def __init__(self, glb):
-		super(CallTreeRootItem, self).__init__(glb, 0, None)
+	def __init__(self, glb, params):
+		super(CallTreeRootItem, self).__init__(glb, params, 0, None)
 		self.dbid = 0
 		self.query_done = True;
 		query = QSqlQuery(glb.db)
@@ -818,7 +827,7 @@ class CallTreeRootItem(CallGraphLevelItemBase):
 		while query.next():
 			if not query.value(0):
 				continue
-			child_item = CallTreeLevelOneItem(glb, self.child_count, query.value(0), query.value(1), self)
+			child_item = CallTreeLevelOneItem(glb, params, self.child_count, query.value(0), query.value(1), self)
 			self.child_items.append(child_item)
 			self.child_count += 1
 
@@ -830,7 +839,7 @@ class CallTreeModel(CallGraphModelBase):
 		super(CallTreeModel, self).__init__(glb, parent)
 
 	def GetRoot(self):
-		return CallTreeRootItem(self.glb)
+		return CallTreeRootItem(self.glb, self.params)
 
 	def columnCount(self, parent=None):
 		return 7
@@ -1606,7 +1615,7 @@ class BranchModel(TreeModel):
 	progress = Signal(object)
 
 	def __init__(self, glb, event_id, where_clause, parent=None):
-		super(BranchModel, self).__init__(glb, parent)
+		super(BranchModel, self).__init__(glb, None, parent)
 		self.event_id = event_id
 		self.more = True
 		self.populated = 0
-- 
2.17.1

