Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE806C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D1521D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824437;
	bh=XLQ7h6j1rBX939uxUO1hOMpyPpYI8mR6cTzLZ8tURbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lEUlHfB2m7g0jtE/GU5FdS3D9Jv3WcuvqSoewV/2k2omK6msjTiQiuLLYV9fPoOI0
	 AJ6BKysafEodBUHXl1BnLM0zh+hqHn+VyrDqnj9DUdiuDCYF76p0Hx1vPuivV4B9Dm
	 CLgOM2ModcH5hldLhpyY/bMcGm9NlzJdiPWzPtFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfJKUHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:07:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728854AbfJKUHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:07:15 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D123B222BE;
        Fri, 11 Oct 2019 20:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824435;
        bh=XLQ7h6j1rBX939uxUO1hOMpyPpYI8mR6cTzLZ8tURbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JigIa/w6cEaEi2Wrb0bStcXimwx95BLYLlZAAjD8Zf/pWz3w1xhgufEXGodPaa1rs
         Yi80n0v36ZNunZIBPJS6wg6a/SJC2OX3+EVd0zzPY55/kLPx1D3n6LUU50dY7dzWDj
         noT1CHkjKDo4uOzkbqn0O8+UXuCO25hMip/efOtk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/69] perf scripts python: exported-sql-viewer.py: Add HBoxLayout and VBoxLayout
Date:   Fri, 11 Oct 2019 17:05:00 -0300
Message-Id: <20191011200559.7156-11-acme@kernel.org>
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

Add layout classes HBoxLayout and VBoxLayout.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20190821083216.1340-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.21.0

