Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF754C06508
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780A12186A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279648;
	bh=Bxt1DhFabB9KMEMNLQMoQzg1b8+aj6OOleBb2W6p5pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y4rfTz3AeiuFb6coJqswPs9POvguQ0NF4cFTvEAgjf6pztB6sf4ivlvOhLUA+tsHm
	 pxj/ySE4HOLXLTQehb9FqowMAiALW+uwIG1aoCiKuob9R7fLE6Yx4kp/abJe5Fh89x
	 3ek9SE+2UJnntLJQXgrGMNJgM0QxMvHg3e384Y/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392242AbfFKTAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:00:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391579AbfFKTAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:00:46 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 905162184C;
        Tue, 11 Jun 2019 19:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279646;
        bh=Bxt1DhFabB9KMEMNLQMoQzg1b8+aj6OOleBb2W6p5pg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jeoTRFsAwQuxeiOR56tfjxY4S9v5Z1wJZ54GxAXdECN4SDlSxcAXjtf97CkHxuNt4
         n6klYoWPPDYa+Ggzgc0FbH2HF6tJAivoFEeLyLA1OjzGZLhLt0p3w5tHrB2z0fW2jQ
         XEp3y34vrSEbK1x0ysFjAlthwm8VGxHsBvL6QxOU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 24/85] perf scripts python: exported-sql-viewer.py: Add IPC information to Call Tree
Date:   Tue, 11 Jun 2019 15:58:10 -0300
Message-Id: <20190611185911.11645-25-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Enhance the call tree to display IPC information if it is available.

Committer testing:

[acme@quaco adrian.hunter]$ python ~acme/libexec/perf-core/scripts/python/exported-sql-viewer.py ~/c/adrian.hunter/simple-retpoline.db

Reports -> Call Tree, then expand a few trees, then select with the
mouse and press control+C (copy):

Call Path                   Object        Call Time Time  Time(%) Insn  Insn   Cyc   Cyc   IPC Branch Branch
▼ simple-retpolin                                   (ns)          Cnt   Cnt(%) Cnt   Cnt(%)     Count Count(%)
  ▼ 23003:23003
    ▼ _start                ld-2.28.so    112195670 218295 100.0 127746 100.0 207320 100.0 0.62 13046 100.0
      ▶ unknown             unknown       112195987   3202   1.5      0   0.0      0   0.0    0     1   0.0
      ▶ _dl_start           ld-2.28.so    112199189 188471  86.3 123394  96.6 180007  86.8 0.69 12529  96.0
      ▼ _dl_init            ld-2.28.so    112387660  13406   6.1   3207   2.5  14868   7.2 0.22   327   2.5
        ▶ call_init.part.0  ld-2.28.so    112387773    117   0.9     70   2.2    639   4.3 0.11     3   0.9
        ▶ call_init.part.0  ld-2.28.so    112387890  13129  97.9   3103  96.8  14100  94.8 0.22   315  96.3
        ▶ call_init.part.0  ld-2.28.so    112401020      0   0.0      0   0.0      0   0.0    0     2   0.6
      ▼ _start              simple-retpol 112401066  12899   5.9   1142   0.9  11561   5.6 0.10   184   1.4
        ▶ unknown           unknown       112401388    846   6.6      0   0.0      0   0.0    0     1   0.5
        ▼ __libc_start_main libc-2.28.so  112402344  11621  90.1   1129  98.9  10350  89.5 0.11   181  98.4
          ▶ __cxa_atexit    libc-2.28.so  112402360   2302  19.8    101   8.9   1817  17.6 0.06    13   7.2
          ▶ __libc_csu_init simple-retpol 112404673    121   1.0     43   3.8    340   3.3 0.13     8   4.4
          ▶ _setjmp         libc-2.28.so  112404794     74   0.6     46   4.1    206   2.0 0.22     4   2.2
          ▼ main            simple-retpol 112404892     44   0.4     23   2.0    126   1.2 0.18    12   6.6
            ▼ foo           simple-retpol 112404892     19  43.2     12  52.2     55  43.7 0.22     5  41.7
                bar         simple-retpol 112404896     12  63.2      3  25.0     34  61.8 0.09     1  20.0
            ▼ foo           simple-retpol 112404911     25  56.8     11  47.8     71  56.3 0.15     5  41.7
              ▶ bar         simple-retpol 112404924     10  40.0      3  27.3     27  38.0 0.11     1  20.0
          ▶ exit            libc-2.28.so  112404936   9029  77.7    878  77.8   7765  75.0 0.11   139  76.8

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-22-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.20.1

