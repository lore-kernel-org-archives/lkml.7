Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEF1ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDFA2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbfJOFcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:32:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42198 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfJOFcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:16 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFRJ-0000Sk-J6; Tue, 15 Oct 2019 07:32:09 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 22CFE1C06D6;
        Tue, 15 Oct 2019 07:31:50 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:50 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf scripts python: exported-sql-viewer.py: Tidy up
 Call tree call_time
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821083216.1340-5-adrian.hunter@intel.com>
References: <20190821083216.1340-5-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <157111751002.12254.2811140358205091894.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     da4264f5cf8a6b798bf5494e08a5dae85a61c4c3
Gitweb:        https://git.kernel.org/tip/da4264f5cf8a6b798bf5494e08a5dae85a61c4c3
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Wed, 21 Aug 2019 11:32:14 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 07 Oct 2019 12:22:17 -03:00

perf scripts python: exported-sql-viewer.py: Tidy up Call tree call_time

Record call_time on tree nodes and re-name the misnamed "count" parameter.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20190821083216.1340-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 0dcc9a0..06b8d55 100755
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
