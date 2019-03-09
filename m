Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E415C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719DE20815
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfCITyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 14:54:19 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46103 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfCITyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 14:54:19 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29JsCMX3201562
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 11:54:12 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29JsCQU3201559;
        Sat, 9 Mar 2019 11:54:12 -0800
Date:   Sat, 9 Mar 2019 11:54:12 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-ifirw0c0mhkwxg6l12lk6k4p@git.kernel.org>
Cc:     acme@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com, tglx@linutronix.de,
        jolsa@redhat.com
Reply-To: tglx@linutronix.de, hpa@zytor.com, jolsa@redhat.com,
          linux-kernel@vger.kernel.org, acme@redhat.com,
          adrian.hunter@intel.com, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: exported-sql-viewer.py:
 Factor out TreeWindowBase
Git-Commit-ID: a731cc4c990a90d9d42a2081ca93fb4310680ae2
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

Commit-ID:  a731cc4c990a90d9d42a2081ca93fb4310680ae2
Gitweb:     https://git.kernel.org/tip/a731cc4c990a90d9d42a2081ca93fb4310680ae2
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Thu, 28 Feb 2019 15:00:28 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 1 Mar 2019 14:54:39 -0300

perf scripts python: exported-sql-viewer.py: Factor out TreeWindowBase

Factor out a base class TreeWindowBase from CallGraphWindow, so that
TreeWindowBase can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: https://lkml.kernel.org/n/tip-ifirw0c0mhkwxg6l12lk6k4p@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 50 +++++++++++++++---------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 09ce73b07d35..df854f0a69f0 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -693,28 +693,16 @@ class VBox():
 	def Widget(self):
 		return self.vbox
 
-# Context-sensitive call graph window
-
-class CallGraphWindow(QMdiSubWindow):
-
-	def __init__(self, glb, parent=None):
-		super(CallGraphWindow, self).__init__(parent)
+# Tree window base
 
-		self.model = LookupCreateModel("Context-Sensitive Call Graph", lambda x=glb: CallGraphModel(x))
+class TreeWindowBase(QMdiSubWindow):
 
-		self.view = QTreeView()
-		self.view.setModel(self.model)
-
-		for c, w in ((0, 250), (1, 100), (2, 60), (3, 70), (4, 70), (5, 100)):
-			self.view.setColumnWidth(c, w)
-
-		self.find_bar = FindBar(self, self)
-
-		self.vbox = VBox(self.view, self.find_bar.Widget())
-
-		self.setWidget(self.vbox.Widget())
+	def __init__(self, parent=None):
+		super(TreeWindowBase, self).__init__(parent)
 
-		AddSubWindow(glb.mainwindow.mdi_area, self, "Context-Sensitive Call Graph")
+		self.model = None
+		self.view = None
+		self.find_bar = None
 
 	def DisplayFound(self, ids):
 		if not len(ids):
@@ -747,6 +735,30 @@ class CallGraphWindow(QMdiSubWindow):
 		if not found:
 			self.find_bar.NotFound()
 
+
+# Context-sensitive call graph window
+
+class CallGraphWindow(TreeWindowBase):
+
+	def __init__(self, glb, parent=None):
+		super(CallGraphWindow, self).__init__(parent)
+
+		self.model = LookupCreateModel("Context-Sensitive Call Graph", lambda x=glb: CallGraphModel(x))
+
+		self.view = QTreeView()
+		self.view.setModel(self.model)
+
+		for c, w in ((0, 250), (1, 100), (2, 60), (3, 70), (4, 70), (5, 100)):
+			self.view.setColumnWidth(c, w)
+
+		self.find_bar = FindBar(self, self)
+
+		self.vbox = VBox(self.view, self.find_bar.Widget())
+
+		self.setWidget(self.vbox.Widget())
+
+		AddSubWindow(glb.mainwindow.mdi_area, self, "Context-Sensitive Call Graph")
+
 # Child data item  finder
 
 class ChildDataItemFinder():
