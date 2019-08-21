Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40035C3A5A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DABF22DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfHUIdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 04:33:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:34007 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbfHUIdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 04:33:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 01:33:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="195953490"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.122])
  by fmsmga001.fm.intel.com with ESMTP; 21 Aug 2019 01:33:37 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] perf scripts python: exported-sql-viewer.py: Add ability for Call tree to open at a specified task and time
Date:   Wed, 21 Aug 2019 11:32:15 +0300
Message-Id: <20190821083216.1340-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821083216.1340-1-adrian.hunter@intel.com>
References: <20190821083216.1340-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ability for Call tree to open at a specified task and time.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripts/python/exported-sql-viewer.py     | 44 ++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 06b8d55977bc..a5af52f422e6 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1094,7 +1094,7 @@ class CallGraphWindow(TreeWindowBase):
 
 class CallTreeWindow(TreeWindowBase):
 
-	def __init__(self, glb, parent=None):
+	def __init__(self, glb, parent=None, thread_at_time=None):
 		super(CallTreeWindow, self).__init__(parent)
 
 		self.model = LookupCreateModel("Call Tree", lambda x=glb: CallTreeModel(x))
@@ -1112,6 +1112,48 @@ class CallTreeWindow(TreeWindowBase):
 
 		AddSubWindow(glb.mainwindow.mdi_area, self, "Call Tree")
 
+		if thread_at_time:
+			self.DisplayThreadAtTime(*thread_at_time)
+
+	def DisplayThreadAtTime(self, comm_id, thread_id, time):
+		parent = QModelIndex()
+		for dbid in (comm_id, thread_id):
+			found = False
+			n = self.model.rowCount(parent)
+			for row in xrange(n):
+				child = self.model.index(row, 0, parent)
+				if child.internalPointer().dbid == dbid:
+					found = True
+					self.view.setCurrentIndex(child)
+					parent = child
+					break
+			if not found:
+				return
+		found = False
+		while True:
+			n = self.model.rowCount(parent)
+			if not n:
+				return
+			last_child = None
+			for row in xrange(n):
+				child = self.model.index(row, 0, parent)
+				child_call_time = child.internalPointer().call_time
+				if child_call_time < time:
+					last_child = child
+				elif child_call_time == time:
+					self.view.setCurrentIndex(child)
+					return
+				elif child_call_time > time:
+					break
+			if not last_child:
+				if not found:
+					child = self.model.index(0, 0, parent)
+					self.view.setCurrentIndex(child)
+				return
+			found = True
+			self.view.setCurrentIndex(last_child)
+			parent = last_child
+
 # Child data item  finder
 
 class ChildDataItemFinder():
-- 
2.17.1

