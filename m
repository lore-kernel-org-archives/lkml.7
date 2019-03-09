Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE8FC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E929020652
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfCIT4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 14:56:44 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52887 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfCIT4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 14:56:43 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29JuHoZ3202710
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 11:56:17 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29JuHUs3202704;
        Sat, 9 Mar 2019 11:56:17 -0800
Date:   Sat, 9 Mar 2019 11:56:17 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-enf0w96gqzfpv4fi16pw9ovc@git.kernel.org>
Cc:     acme@redhat.com, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, jolsa@redhat.com
Reply-To: adrian.hunter@intel.com, jolsa@redhat.com, hpa@zytor.com,
          mingo@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: exported-sql-viewer.py: Add
 call tree
Git-Commit-ID: ae8b887c00d3fe4ca8c2cba16ae452b5df4c19e2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ae8b887c00d3fe4ca8c2cba16ae452b5df4c19e2
Gitweb:     https://git.kernel.org/tip/ae8b887c00d3fe4ca8c2cba16ae452b5df4c19e2
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Thu, 28 Feb 2019 15:00:31 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 1 Mar 2019 15:04:16 -0300

perf scripts python: exported-sql-viewer.py: Add call tree

Add a new report to display a call tree. The Call Tree report is very
similar to the Context-Sensitive Call Graph, but the data is not
aggregated. Also the 'Count' column, which would be always 1, is replaced
by the 'Call Time'.

Committer testing:

  $ cat simple-retpoline.c
  /*

    https://lkml.kernel.org/r/20190109091835.5570-6-adrian.hunter@intel.com

  $ gcc -ggdb3 -Wall -Wextra -O2 -o simple-retpoline simple-retpoline.c
  $ objdump -d simple-retpoline
  */

  __attribute__((noinline)) int bar(void)
  {
          return -1;
  }

  int foo(void)
  {
          return bar() + 1;
  }

  __attribute__((indirect_branch("thunk"))) int main()
  {
          int (*volatile fn)(void) = foo;

          fn();
          return fn();
  }
  $
  $ perf record -o simple-retpoline.perf.data -e intel_pt/cyc/u ./simple-retpoline
  $ perf script -i simple-retpoline.perf.data --itrace=be -s ~acme/libexec/perf-core/scripts/python/export-to-sqlite.py simple-retpoline.db branches calls
  $ python ~acme/libexec/perf-core/scripts/python/exported-sql-viewer.py simple-retpoline.db

And in the GUI select:

    "Reports"
      "Call Tree"

    Call Path                 | Object          | Call Time (ns) | Time (ns) | Time (%) | Branch Count | Brach Count (%) |
    > simple-retpolin
      > PID:TID
        > _start                ld-2.28.so       2193855505777      156267      100.0       10602          100.0
            unknown             unknown          2193855506010        2276        1.5           1            0.0
          > _dl_start           ld-2.28.so       2193855508286      137047       87.7       10088           95.2
          > _dl_init            ld-2.28.so       2193855645444        9142        5.9         326            3.1
          > _start              simple-retpoline 2193855654587        7457        4.8         182            1.7
            > __libc_start_main <SNIP>
              <SNIP>
              > main            simple-retpoline 2193855657493          32        0.5          12            6.7
                > foo           simple-retpoline 2193855657493          14       43.8           5           41.7
              <SNIP>

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: https://lkml.kernel.org/n/tip-enf0w96gqzfpv4fi16pw9ovc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 195 +++++++++++++++++++++--
 1 file changed, 186 insertions(+), 9 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index c4a2134d85f5..afec9479ca7f 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -688,6 +688,150 @@ class CallGraphModel(CallGraphModelBase):
 		ids.insert(0, query.value(1))
 		return ids
 
+# Call tree data model level 2+ item base
+
+class CallTreeLevelTwoPlusItemBase(CallGraphLevelItemBase):
+
+	def __init__(self, glb, row, comm_id, thread_id, calls_id, time, branch_count, parent_item):
+		super(CallTreeLevelTwoPlusItemBase, self).__init__(glb, row, parent_item)
+		self.comm_id = comm_id
+		self.thread_id = thread_id
+		self.calls_id = calls_id
+		self.branch_count = branch_count
+		self.time = time
+
+	def Select(self):
+		self.query_done = True;
+		if self.calls_id == 0:
+			comm_thread = " AND comm_id = " + str(self.comm_id) + " AND thread_id = " + str(self.thread_id)
+		else:
+			comm_thread = ""
+		query = QSqlQuery(self.glb.db)
+		QueryExec(query, "SELECT calls.id, name, short_name, call_time, return_time - call_time, branch_count"
+					" FROM calls"
+					" INNER JOIN call_paths ON calls.call_path_id = call_paths.id"
+					" INNER JOIN symbols ON call_paths.symbol_id = symbols.id"
+					" INNER JOIN dsos ON symbols.dso_id = dsos.id"
+					" WHERE calls.parent_id = " + str(self.calls_id) + comm_thread +
+					" ORDER BY call_time, calls.id")
+		while query.next():
+			child_item = CallTreeLevelThreeItem(self.glb, self.child_count, self.comm_id, self.thread_id, query.value(0), query.value(1), query.value(2), query.value(3), int(query.value(4)), int(query.value(5)), self)
+			self.child_items.append(child_item)
+			self.child_count += 1
+
+# Call tree data model level three item
+
+class CallTreeLevelThreeItem(CallTreeLevelTwoPlusItemBase):
+
+	def __init__(self, glb, row, comm_id, thread_id, calls_id, name, dso, count, time, branch_count, parent_item):
+		super(CallTreeLevelThreeItem, self).__init__(glb, row, comm_id, thread_id, calls_id, time, branch_count, parent_item)
+		dso = dsoname(dso)
+		self.data = [ name, dso, str(count), str(time), PercentToOneDP(time, parent_item.time), str(branch_count), PercentToOneDP(branch_count, parent_item.branch_count) ]
+		self.dbid = calls_id
+
+# Call tree data model level two item
+
+class CallTreeLevelTwoItem(CallTreeLevelTwoPlusItemBase):
+
+	def __init__(self, glb, row, comm_id, thread_id, pid, tid, parent_item):
+		super(CallTreeLevelTwoItem, self).__init__(glb, row, comm_id, thread_id, 0, 0, 0, parent_item)
+		self.data = [str(pid) + ":" + str(tid), "", "", "", "", "", ""]
+		self.dbid = thread_id
+
+	def Select(self):
+		super(CallTreeLevelTwoItem, self).Select()
+		for child_item in self.child_items:
+			self.time += child_item.time
+			self.branch_count += child_item.branch_count
+		for child_item in self.child_items:
+			child_item.data[4] = PercentToOneDP(child_item.time, self.time)
+			child_item.data[6] = PercentToOneDP(child_item.branch_count, self.branch_count)
+
+# Call tree data model level one item
+
+class CallTreeLevelOneItem(CallGraphLevelItemBase):
+
+	def __init__(self, glb, row, comm_id, comm, parent_item):
+		super(CallTreeLevelOneItem, self).__init__(glb, row, parent_item)
+		self.data = [comm, "", "", "", "", "", ""]
+		self.dbid = comm_id
+
+	def Select(self):
+		self.query_done = True;
+		query = QSqlQuery(self.glb.db)
+		QueryExec(query, "SELECT thread_id, pid, tid"
+					" FROM comm_threads"
+					" INNER JOIN threads ON thread_id = threads.id"
+					" WHERE comm_id = " + str(self.dbid))
+		while query.next():
+			child_item = CallTreeLevelTwoItem(self.glb, self.child_count, self.dbid, query.value(0), query.value(1), query.value(2), self)
+			self.child_items.append(child_item)
+			self.child_count += 1
+
+# Call tree data model root item
+
+class CallTreeRootItem(CallGraphLevelItemBase):
+
+	def __init__(self, glb):
+		super(CallTreeRootItem, self).__init__(glb, 0, None)
+		self.dbid = 0
+		self.query_done = True;
+		query = QSqlQuery(glb.db)
+		QueryExec(query, "SELECT id, comm FROM comms")
+		while query.next():
+			if not query.value(0):
+				continue
+			child_item = CallTreeLevelOneItem(glb, self.child_count, query.value(0), query.value(1), self)
+			self.child_items.append(child_item)
+			self.child_count += 1
+
+# Call Tree data model
+
+class CallTreeModel(CallGraphModelBase):
+
+	def __init__(self, glb, parent=None):
+		super(CallTreeModel, self).__init__(glb, parent)
+
+	def GetRoot(self):
+		return CallTreeRootItem(self.glb)
+
+	def columnCount(self, parent=None):
+		return 7
+
+	def columnHeader(self, column):
+		headers = ["Call Path", "Object", "Call Time", "Time (ns) ", "Time (%) ", "Branch Count ", "Branch Count (%) "]
+		return headers[column]
+
+	def columnAlignment(self, column):
+		alignment = [ Qt.AlignLeft, Qt.AlignLeft, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight ]
+		return alignment[column]
+
+	def DoFindSelect(self, query, match):
+		QueryExec(query, "SELECT calls.id, comm_id, thread_id"
+						" FROM calls"
+						" INNER JOIN call_paths ON calls.call_path_id = call_paths.id"
+						" INNER JOIN symbols ON call_paths.symbol_id = symbols.id"
+						" WHERE symbols.name" + match +
+						" ORDER BY comm_id, thread_id, call_time, calls.id")
+
+	def FindPath(self, query):
+		# Turn the query result into a list of ids that the tree view can walk
+		# to open the tree at the right place.
+		ids = []
+		parent_id = query.value(0)
+		while parent_id:
+			ids.insert(0, parent_id)
+			q2 = QSqlQuery(self.glb.db)
+			QueryExec(q2, "SELECT parent_id"
+					" FROM calls"
+					" WHERE id = " + str(parent_id))
+			if not q2.next():
+				break
+			parent_id = q2.value(0)
+		ids.insert(0, query.value(2))
+		ids.insert(0, query.value(1))
+		return ids
+
 # Vertical widget layout
 
 class VBox():
@@ -772,6 +916,29 @@ class CallGraphWindow(TreeWindowBase):
 
 		AddSubWindow(glb.mainwindow.mdi_area, self, "Context-Sensitive Call Graph")
 
+# Call tree window
+
+class CallTreeWindow(TreeWindowBase):
+
+	def __init__(self, glb, parent=None):
+		super(CallTreeWindow, self).__init__(parent)
+
+		self.model = LookupCreateModel("Call Tree", lambda x=glb: CallTreeModel(x))
+
+		self.view = QTreeView()
+		self.view.setModel(self.model)
+
+		for c, w in ((0, 230), (1, 100), (2, 100), (3, 70), (4, 70), (5, 100)):
+			self.view.setColumnWidth(c, w)
+
+		self.find_bar = FindBar(self, self)
+
+		self.vbox = VBox(self.view, self.find_bar.Widget())
+
+		self.setWidget(self.vbox.Widget())
+
+		AddSubWindow(glb.mainwindow.mdi_area, self, "Call Tree")
+
 # Child data item  finder
 
 class ChildDataItemFinder():
@@ -1890,10 +2057,10 @@ def GetEventList(db):
 
 # Is a table selectable
 
-def IsSelectable(db, table):
+def IsSelectable(db, table, sql = ""):
 	query = QSqlQuery(db)
 	try:
-		QueryExec(query, "SELECT * FROM " + table + " LIMIT 1")
+		QueryExec(query, "SELECT * FROM " + table + " " + sql + " LIMIT 1")
 	except:
 		return False
 	return True
@@ -2302,9 +2469,10 @@ p.c2 {
 </style>
 <p class=c1><a href=#reports>1. Reports</a></p>
 <p class=c2><a href=#callgraph>1.1 Context-Sensitive Call Graph</a></p>
-<p class=c2><a href=#allbranches>1.2 All branches</a></p>
-<p class=c2><a href=#selectedbranches>1.3 Selected branches</a></p>
-<p class=c2><a href=#topcallsbyelapsedtime>1.4 Top calls by elapsed time</a></p>
+<p class=c2><a href=#calltree>1.2 Call Tree</a></p>
+<p class=c2><a href=#allbranches>1.3 All branches</a></p>
+<p class=c2><a href=#selectedbranches>1.4 Selected branches</a></p>
+<p class=c2><a href=#topcallsbyelapsedtime>1.5 Top calls by elapsed time</a></p>
 <p class=c1><a href=#tables>2. Tables</a></p>
 <h1 id=reports>1. Reports</h1>
 <h2 id=callgraph>1.1 Context-Sensitive Call Graph</h2>
@@ -2340,7 +2508,10 @@ v- ls
 <h3>Find</h3>
 Ctrl-F displays a Find bar which finds function names by either an exact match or a pattern match.
 The pattern matching symbols are ? for any character and * for zero or more characters.
-<h2 id=allbranches>1.2 All branches</h2>
+<h2 id=calltree>1.2 Call Tree</h2>
+The Call Tree report is very similar to the Context-Sensitive Call Graph, but the data is not aggregated.
+Also the 'Count' column, which would be always 1, is replaced by the 'Call Time'.
+<h2 id=allbranches>1.3 All branches</h2>
 The All branches report displays all branches in chronological order.
 Not all data is fetched immediately. More records can be fetched using the Fetch bar provided.
 <h3>Disassembly</h3>
@@ -2366,10 +2537,10 @@ sudo ldconfig
 Ctrl-F displays a Find bar which finds substrings by either an exact match or a regular expression match.
 Refer to Python documentation for the regular expression syntax.
 All columns are searched, but only currently fetched rows are searched.
-<h2 id=selectedbranches>1.3 Selected branches</h2>
+<h2 id=selectedbranches>1.4 Selected branches</h2>
 This is the same as the <a href=#allbranches>All branches</a> report but with the data reduced
 by various selection criteria. A dialog box displays available criteria which are AND'ed together.
-<h3>1.3.1 Time ranges</h3>
+<h3>1.4.1 Time ranges</h3>
 The time ranges hint text shows the total time range. Relative time ranges can also be entered in
 ms, us or ns. Also, negative values are relative to the end of trace.  Examples:
 <pre>
@@ -2380,7 +2551,7 @@ ms, us or ns. Also, negative values are relative to the end of trace.  Examples:
 	-10ms-			The last 10ms
 </pre>
 N.B. Due to the granularity of timestamps, there could be no branches in any given time range.
-<h2 id=topcallsbyelapsedtime>1.4 Top calls by elapsed time</h2>
+<h2 id=topcallsbyelapsedtime>1.5 Top calls by elapsed time</h2>
 The Top calls by elapsed time report displays calls in descending order of time elapsed between when the function was called and when it returned.
 The data is reduced by various selection criteria. A dialog box displays available criteria which are AND'ed together.
 If not all data is fetched, a Fetch bar is provided. Ctrl-F displays a Find bar.
@@ -2516,6 +2687,9 @@ class MainWindow(QMainWindow):
 		if IsSelectable(glb.db, "calls"):
 			reports_menu.addAction(CreateAction("Context-Sensitive Call &Graph", "Create a new window containing a context-sensitive call graph", self.NewCallGraph, self))
 
+		if IsSelectable(glb.db, "calls", "WHERE parent_id >= 0"):
+			reports_menu.addAction(CreateAction("Call &Tree", "Create a new window containing a call tree", self.NewCallTree, self))
+
 		self.EventMenu(GetEventList(glb.db), reports_menu)
 
 		if IsSelectable(glb.db, "calls"):
@@ -2576,6 +2750,9 @@ class MainWindow(QMainWindow):
 	def NewCallGraph(self):
 		CallGraphWindow(self.glb, self)
 
+	def NewCallTree(self):
+		CallTreeWindow(self.glb, self)
+
 	def NewTopCalls(self):
 		dialog = TopCallsDialog(self.glb, self)
 		ret = dialog.exec_()
