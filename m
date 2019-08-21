Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9FEC3A5A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27BF22DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfHUIdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 04:33:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:34007 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727717AbfHUIdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 04:33:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 01:33:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="195953472"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.122])
  by fmsmga001.fm.intel.com with ESMTP; 21 Aug 2019 01:33:32 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] perf scripts python: exported-sql-viewer.py: Add HBoxLayout and VBoxLayout
Date:   Wed, 21 Aug 2019 11:32:12 +0300
Message-Id: <20190821083216.1340-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821083216.1340-1-adrian.hunter@intel.com>
References: <20190821083216.1340-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add layout classes HBoxLayout and VBoxLayout.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripts/python/exported-sql-viewer.py     | 41 ++++++++++++++-----
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 18ad04654adc..9767a5f802e5 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -980,20 +980,41 @@ class CallTreeModel(CallGraphModelBase):
 		ids.insert(0, query.value(1))
 		return ids
 
-# Vertical widget layout
+# Vertical layout
 
-class VBox():
+class HBoxLayout(QHBoxLayout):
 
-	def __init__(self, w1, w2, w3=None):
-		self.vbox = QWidget()
-		self.vbox.setLayout(QVBoxLayout())
+	def __init__(self, *children):
+		super(HBoxLayout, self).__init__()
+
+		self.layout().setContentsMargins(0, 0, 0, 0)
+		for child in children:
+			if child.isWidgetType():
+				self.layout().addWidget(child)
+			else:
+				self.layout().addLayout(child)
+
+# Horizontal layout
+
+class VBoxLayout(QVBoxLayout):
 
-		self.vbox.layout().setContentsMargins(0, 0, 0, 0)
+	def __init__(self, *children):
+		super(VBoxLayout, self).__init__()
 
-		self.vbox.layout().addWidget(w1)
-		self.vbox.layout().addWidget(w2)
-		if w3:
-			self.vbox.layout().addWidget(w3)
+		self.layout().setContentsMargins(0, 0, 0, 0)
+		for child in children:
+			if child.isWidgetType():
+				self.layout().addWidget(child)
+			else:
+				self.layout().addLayout(child)
+
+# Vertical layout widget
+
+class VBox():
+
+	def __init__(self, *children):
+		self.vbox = QWidget()
+		self.vbox.setLayout(VBoxLayout(*children))
 
 	def Widget(self):
 		return self.vbox
-- 
2.17.1

