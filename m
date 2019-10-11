Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56330ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25DA621D56
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824451;
	bh=HRU6WzGIPI6xOURl4Pr07yFsC5FYkOx97aRhyWrt9EI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gMqggDK3yZ87Gv9VizSRql428ehZbuyv+BsRsWDG+uITVxFpav0FVXMRO1dBprPl8
	 cnh/uCk8q6hIZBJQqofuvhsQneFlP/9MKeSPOxAgCLkEbtOigaNOfXnGcJTNm4xJKQ
	 GuL/Annn8HCyquvFK42Hgl5qHes7zXoNyCAOw2cU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbfJKUHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:07:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729055AbfJKUH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:07:29 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1983021D7C;
        Fri, 11 Oct 2019 20:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824448;
        bh=HRU6WzGIPI6xOURl4Pr07yFsC5FYkOx97aRhyWrt9EI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CZXOUPF1+YFivm2/JyzxzNE+qXqIgXK5pfci5aEt7xjfOs0ouERqSEaounlj5mH7v
         dTe3BnwXOZ+KwYGixjHFrN1vejCufikdaj7JMGmp4fEZIHxw0d2ZSReGTRGdPnSuG7
         tcB6F+rLJBmmj5OWkxGgAR0Jn5KXUieDjvfJipAw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/69] perf scripts python: exported-sql-viewer.py: Tidy up Call tree call_time
Date:   Fri, 11 Oct 2019 17:05:02 -0300
Message-Id: <20191011200559.7156-13-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Record call_time on tree nodes and re-name the misnamed "count" parameter.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20190821083216.1340-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.21.0

