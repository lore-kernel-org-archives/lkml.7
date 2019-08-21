Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5F5C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B61233FD
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfHUIdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 04:33:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:34007 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727842AbfHUIdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 04:33:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 01:33:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="195953482"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.122])
  by fmsmga001.fm.intel.com with ESMTP; 21 Aug 2019 01:33:35 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] perf scripts python: exported-sql-viewer.py: Tidy up Call tree call_time
Date:   Wed, 21 Aug 2019 11:32:14 +0300
Message-Id: <20190821083216.1340-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821083216.1340-1-adrian.hunter@intel.com>
References: <20190821083216.1340-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Record call_time on tree nodes and re-name the misnamed "count" parameter.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 0dcc9a03b1b0..06b8d55977bc 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -794,15 +794,16 @@ class CallGraphModel(CallGraphModelBase):
 
 class CallTreeLevelTwoPlusItemBase(CallGraphLevelItemBase):
 
-	def __init__(self, glb, params, row, comm_id, thread_id, calls_id, time, insn_cnt, cyc_cnt, branch_count, parent_item):
+	def __init__(self, glb, params, row, comm_id, thread_id, calls_id, call_time, time, insn_cnt, cyc_cnt, branch_count, parent_item):
 		super(CallTreeLevelTwoPlusItemBase, self).__init__(glb, params, row, parent_item)
 		self.comm_id = comm_id
 		self.thread_id = thread_id
 		self.calls_id = calls_id
+		self.call_time = call_time
+		self.time = time
 		self.insn_cnt = insn_cnt
 		self.cyc_cnt = cyc_cnt
 		self.branch_count = branch_count
-		self.time = time
 
 	def Select(self):
 		self.query_done = True
@@ -839,17 +840,17 @@ class CallTreeLevelTwoPlusItemBase(CallGraphLevelItemBase):
 
 class CallTreeLevelThreeItem(CallTreeLevelTwoPlusItemBase):
 
-	def __init__(self, glb, params, row, comm_id, thread_id, calls_id, name, dso, count, time, insn_cnt, cyc_cnt, branch_count, parent_item):
-		super(CallTreeLevelThreeItem, self).__init__(glb, params, row, comm_id, thread_id, calls_id, time, insn_cnt, cyc_cnt, branch_count, parent_item)
+	def __init__(self, glb, params, row, comm_id, thread_id, calls_id, name, dso, call_time, time, insn_cnt, cyc_cnt, branch_count, parent_item):
+		super(CallTreeLevelThreeItem, self).__init__(glb, params, row, comm_id, thread_id, calls_id, call_time, time, insn_cnt, cyc_cnt, branch_count, parent_item)
 		dso = dsoname(dso)
 		if self.params.have_ipc:
 			insn_pcnt = PercentToOneDP(insn_cnt, parent_item.insn_cnt)
 			cyc_pcnt = PercentToOneDP(cyc_cnt, parent_item.cyc_cnt)
 			br_pcnt = PercentToOneDP(branch_count, parent_item.branch_count)
 			ipc = CalcIPC(cyc_cnt, insn_cnt)
-			self.data = [ name, dso, str(count), str(time), PercentToOneDP(time, parent_item.time), str(insn_cnt), insn_pcnt, str(cyc_cnt), cyc_pcnt, ipc, str(branch_count), br_pcnt ]
+			self.data = [ name, dso, str(call_time), str(time), PercentToOneDP(time, parent_item.time), str(insn_cnt), insn_pcnt, str(cyc_cnt), cyc_pcnt, ipc, str(branch_count), br_pcnt ]
 		else:
-			self.data = [ name, dso, str(count), str(time), PercentToOneDP(time, parent_item.time), str(branch_count), PercentToOneDP(branch_count, parent_item.branch_count) ]
+			self.data = [ name, dso, str(call_time), str(time), PercentToOneDP(time, parent_item.time), str(branch_count), PercentToOneDP(branch_count, parent_item.branch_count) ]
 		self.dbid = calls_id
 
 # Call tree data model level two item
@@ -857,7 +858,7 @@ class CallTreeLevelThreeItem(CallTreeLevelTwoPlusItemBase):
 class CallTreeLevelTwoItem(CallTreeLevelTwoPlusItemBase):
 
 	def __init__(self, glb, params, row, comm_id, thread_id, pid, tid, parent_item):
-		super(CallTreeLevelTwoItem, self).__init__(glb, params, row, comm_id, thread_id, 0, 0, 0, 0, 0, parent_item)
+		super(CallTreeLevelTwoItem, self).__init__(glb, params, row, comm_id, thread_id, 0, 0, 0, 0, 0, 0, parent_item)
 		if self.params.have_ipc:
 			self.data = [str(pid) + ":" + str(tid), "", "", "", "", "", "", "", "", "", "", ""]
 		else:
-- 
2.17.1

