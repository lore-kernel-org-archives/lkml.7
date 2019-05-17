Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44E8C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61A42087B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558121848;
	bh=8XyQur79zucVv35e5AEkV4vuSKj00EZgHKNytxRPkoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rmrh9RHjaxS5hpS6IhEUANU92stYDTR8eOnow17zg6RkbC2SNBoOibSNpWiq4bUGS
	 KRccrdqivBnKcSErtmoadasCcx/et1jZnV3BIUHnM+m3BC/oMWDbd+JaoWjNBhBJY5
	 psZOsTdsZ9CAI4YPe+ErAtCj3c9t3I2cYK2Ke8Gg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbfEQTh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:37:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727225AbfEQThZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:37:25 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EBE721734;
        Fri, 17 May 2019 19:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558121845;
        bh=8XyQur79zucVv35e5AEkV4vuSKj00EZgHKNytxRPkoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Alclc1G/04YyEk8P193X2ayIqP0Xh41JuC65hwVOgV44OLzhbYgVR2t5tNt5+9EH8
         xqufobDHNcQS4jCN7P3I+UkfJswMLuB0MODQES2uI10Kqb313vvCkfPcHnRg1GyG5t
         agjf5UL3Wfnkz+cswG6jZa3lS/UDoMNqsRw5jLhw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 14/73] perf scripts python: exported-sql-viewer.py: Fix error when shrinking / enlarging font
Date:   Fri, 17 May 2019 16:35:12 -0300
Message-Id: <20190517193611.4974-15-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Fix the following error if shrink / enlarge font is used with the help
window.

  Traceback (most recent call last):
    File "tools/perf/scripts/python/exported-sql-viewer.py", line 2791, in ShrinkFont
      ShrinkFont(win.view)
  AttributeError: 'HelpWindow' object has no attribute 'view'

Committer testing:

Before, matches above output:

  $ python ~acme/libexec/perf-core/scripts/python/exported-sql-viewer.py ~/c/adrian.hunter/simple-retpoline.db
  Traceback (most recent call last):
    File "/home/acme/libexec/perf-core/scripts/python/exported-sql-viewer.py", line 2780, in EnlargeFont
      EnlargeFont(win.view)
  AttributeError: 'HelpWindow' object has no attribute 'view'
  $

After:

No more tracebacks, but the fonts don't get enlarged, which is kinda
frustrating...

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190503120828.25326-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index db4655168ab1..fd073e4af8da 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -2755,6 +2755,14 @@ class MainWindow(QMainWindow):
 		help_menu = menu.addMenu("&Help")
 		help_menu.addAction(CreateAction("&Exported SQL Viewer Help", "Helpful information", self.Help, self, QKeySequence.HelpContents))
 
+	def Try(self, fn):
+		win = self.mdi_area.activeSubWindow()
+		if win:
+			try:
+				fn(win.view)
+			except:
+				pass
+
 	def Find(self):
 		win = self.mdi_area.activeSubWindow()
 		if win:
@@ -2772,12 +2780,10 @@ class MainWindow(QMainWindow):
 				pass
 
 	def ShrinkFont(self):
-		win = self.mdi_area.activeSubWindow()
-		ShrinkFont(win.view)
+		self.Try(ShrinkFont)
 
 	def EnlargeFont(self):
-		win = self.mdi_area.activeSubWindow()
-		EnlargeFont(win.view)
+		self.Try(EnlargeFont)
 
 	def EventMenu(self, events, reports_menu):
 		branches_events = 0
-- 
2.20.1

