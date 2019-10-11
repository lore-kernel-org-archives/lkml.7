Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B07C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A38214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824456;
	bh=cLOfjP0Af14EmY17HRyTtfiR30BI2YM7lVdlnBsb6kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FDQWLvw0569RLrxjw8/gi8s1CkdbdkgohcHObgbNqYUuaUfpfh8YgHiuXy/PKbLiG
	 Zq5sIwc2XuBNWoamG0iUJI/pp80Wnsi5cNitHpG4cnuUDvj0LgwVJu+gaW2oDMXeTa
	 4mra7pjxqvMVO4+bEtF91kOp22WLQGhejZj9v9k0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbfJKUHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:07:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729055AbfJKUHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:07:34 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B348222C3;
        Fri, 11 Oct 2019 20:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824453;
        bh=cLOfjP0Af14EmY17HRyTtfiR30BI2YM7lVdlnBsb6kw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RIUQO/hMN6q4nSKGn9r4L4i4i27q8bF4uk0J+fRh7Ejf3bLuvZfDiLJt4VG89yWQa
         ZK+Gh1+CbpDdd1KOaD/8E5F/n9NTQZWURh8/Ss5lZWq1yNeFq2ci5XPKMpNY+xmwil
         7gW8I0xLhND0iCE1tHR57HTRK1207WBCflLswYaw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 13/69] perf scripts python: exported-sql-viewer.py: Add ability for Call tree to open at a specified task and time
Date:   Fri, 11 Oct 2019 17:05:03 -0300
Message-Id: <20191011200559.7156-14-acme@kernel.org>
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

Add ability for Call tree to open at a specified task and time.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20190821083216.1340-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.21.0

