Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4790CC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B98206BA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfCITzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 14:55:12 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43471 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfCITzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 14:55:12 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29Jss7d3201893
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 11:54:54 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29JssUY3201882;
        Sat, 9 Mar 2019 11:54:54 -0800
Date:   Sat, 9 Mar 2019 11:54:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-ovcv28bg4mt9swk36ypdyz14@git.kernel.org>
Cc:     jolsa@redhat.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        adrian.hunter@intel.com, mingo@kernel.org, hpa@zytor.com,
        acme@redhat.com
Reply-To: jolsa@redhat.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, adrian.hunter@intel.com, mingo@kernel.org,
          hpa@zytor.com, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: exported-sql-viewer.py:
 Improve TreeModel abstraction
Git-Commit-ID: a448ba232a5f0176c226df1bab8877ec06a7c771
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

Commit-ID:  a448ba232a5f0176c226df1bab8877ec06a7c771
Gitweb:     https://git.kernel.org/tip/a448ba232a5f0176c226df1bab8877ec06a7c771
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Thu, 28 Feb 2019 15:00:29 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 1 Mar 2019 14:55:32 -0300

perf scripts python: exported-sql-viewer.py: Improve TreeModel abstraction

Instead of passing the tree root, get it from a method that can be
implemented in any derived class.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: https://lkml.kernel.org/n/tip-ovcv28bg4mt9swk36ypdyz14@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index df854f0a69f0..b2a22525549d 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -167,9 +167,10 @@ class Thread(QThread):
 
 class TreeModel(QAbstractItemModel):
 
-	def __init__(self, root, parent=None):
+	def __init__(self, glb, parent=None):
 		super(TreeModel, self).__init__(parent)
-		self.root = root
+		self.glb = glb
+		self.root = self.GetRoot()
 		self.last_row_read = 0
 
 	def Item(self, parent):
@@ -562,8 +563,10 @@ class CallGraphRootItem(CallGraphLevelItemBase):
 class CallGraphModel(TreeModel):
 
 	def __init__(self, glb, parent=None):
-		super(CallGraphModel, self).__init__(CallGraphRootItem(glb), parent)
-		self.glb = glb
+		super(CallGraphModel, self).__init__(glb, parent)
+
+	def GetRoot(self):
+		return CallGraphRootItem(self.glb)
 
 	def columnCount(self, parent=None):
 		return 7
@@ -1339,8 +1342,7 @@ class BranchModel(TreeModel):
 	progress = Signal(object)
 
 	def __init__(self, glb, event_id, where_clause, parent=None):
-		super(BranchModel, self).__init__(BranchRootItem(), parent)
-		self.glb = glb
+		super(BranchModel, self).__init__(glb, parent)
 		self.event_id = event_id
 		self.more = True
 		self.populated = 0
@@ -1364,6 +1366,9 @@ class BranchModel(TreeModel):
 		self.fetcher.done.connect(self.Update)
 		self.fetcher.Fetch(glb_chunk_sz)
 
+	def GetRoot(self):
+		return BranchRootItem()
+
 	def columnCount(self, parent=None):
 		return 8
 
