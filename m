Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27A9C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7531020661
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980746;
	bh=BE+h+0fMQNSj3jSlS6oTxyVB8VEoA28cmDbU4H8cl+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yy4+QPa7EoPytu6ZqDxnxBwCcKDCT41we7E55j5lAexMHSmhVTWur9JLJr2Y/Dl52
	 BcZ8frk68ozt8WuZH7zPU2SCwLhaTcf50F2uujXfl089znEtCrbcS4hNPLkJArm+ST
	 q9ejGvqeSwDNpuBHuRJWsp8t8oOeGlgpueFdnNz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfCGRpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:45:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:37794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbfCGRpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:45:42 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DF5C20854;
        Thu,  7 Mar 2019 17:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551980741;
        bh=BE+h+0fMQNSj3jSlS6oTxyVB8VEoA28cmDbU4H8cl+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IarQuWVtq1mCX3BjoMiswx9uIB2LqfrIMbCM/eJ0EZQf8Yx2xyzjvhGcY46jbToEe
         oSfAPlnLFUGMryCjCTeJA7uOJD4muvt8t0ID8C0MSw3Cv4WmOPWO3e95PVi3bgnz84
         lNLqniB6zIX1DAekrq+TK4G2EIEVhrrVntKQ1FvU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 13/35] perf scripts python: exported-sql-viewer.py: Improve TreeModel abstraction
Date:   Thu,  7 Mar 2019 14:44:11 -0300
Message-Id: <20190307174433.28819-14-acme@kernel.org>
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

Instead of passing the tree root, get it from a method that can be
implemented in any derived class.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: https://lkml.kernel.org/n/tip-ovcv28bg4mt9swk36ypdyz14@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/scripts/python/exported-sql-viewer.py  | 17 +++++++++++------
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
 
-- 
2.20.1

