Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F31ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC455217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbfJOFdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:33:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42226 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728646AbfJOFcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:18 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFRN-0000Re-7h; Tue, 15 Oct 2019 07:32:13 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D98FB1C04D5;
        Tue, 15 Oct 2019 07:31:49 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:49 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf scripts python: exported-sql-viewer.py: Add
 ability for Call tree to open at a specified task and time
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821083216.1340-6-adrian.hunter@intel.com>
References: <20190821083216.1340-6-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <157111750975.12254.3870071299889679053.tip-bot2@tip-bot2>
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

Commit-ID:     e69d5df75d74da14cbc8c96bbc1d9e86cc91ad0b
Gitweb:        https://git.kernel.org/tip/e69d5df75d74da14cbc8c96bbc1d9e86cc91ad0b
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Wed, 21 Aug 2019 11:32:15 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 07 Oct 2019 12:22:17 -03:00

perf scripts python: exported-sql-viewer.py: Add ability for Call tree to open at a specified task and time

Add ability for Call tree to open at a specified task and time.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20190821083216.1340-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 44 ++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 06b8d55..a5af52f 100755
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
