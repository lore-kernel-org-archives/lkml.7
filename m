Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E3CC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8866320661
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980741;
	bh=p4UsUUNk+k3Pd0FmAEBdZQfub55g6inChRVqyM75qTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u2agTW9JyzPhJxvrSP/kNL78lVBAP+wvGHWM7RUFAuSU8PTiM6oQAKsgsg2L5BSVH
	 G7ku2uf+qeVkQ4q4TIwoEyV5yYUMiXStFN0Yap5pZO3SCCdBvyZ3Yvf/Q8r2LZiHtv
	 rJNvVCXUhjlNDGoOC6lgRNkRBFuxg6EunH6lVr+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfCGRpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:45:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:37744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbfCGRpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:45:39 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABB302087C;
        Thu,  7 Mar 2019 17:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551980738;
        bh=p4UsUUNk+k3Pd0FmAEBdZQfub55g6inChRVqyM75qTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k3uAq/4X0AcpDUyuFkfAA4Egz/qgX7JzasSyFWgl9O1b/7PTD6KGIRRblbgNdZKti
         W+530USuEwfmYERauH59oPJ+Qo9vNJVvgOljyM3jCxlxGICz8z8ygHQ1MCh3J/oogV
         FhpShO8/ZRS1Uj6AjiXyR/ebMhtxXWsnVt3zMhsI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/35] perf scripts python: exported-sql-viewer.py: Factor out TreeWindowBase
Date:   Thu,  7 Mar 2019 14:44:10 -0300
Message-Id: <20190307174433.28819-13-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Factor out a base class TreeWindowBase from CallGraphWindow, so that
TreeWindowBase can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: https://lkml.kernel.org/n/tip-ifirw0c0mhkwxg6l12lk6k4p@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/exported-sql-viewer.py     | 50 ++++++++++++-------
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
-- 
2.20.1

