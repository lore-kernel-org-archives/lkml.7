Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE72C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B0C206BF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="IO+1X5uK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbfERIym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 04:54:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60705 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfERIym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 04:54:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I8sZjJ1732865
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 01:54:35 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I8sZjJ1732865
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558169675;
        bh=7VRGtmWIpRGR1h7TAHFhKjIZYVFsZqpQ7zlH7GRdYtw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=IO+1X5uKk6VQhYhA/0VhHPGiFOBBZN2ydN4LdeY98ei2YTYu0tMQKy5zf5ZJCSRQC
         GgtbunHzg3lbEtQP8M7PVHcwiSJbPt9yABi4oF3krYVzMyvrU7fJM99etKDJaTf7PF
         Tc1lqkjovaynzfq+sUe501UamshIHnnmPLFarEGUBduFyuVEvRw5YAxbzFP3+wfaQN
         HAPZq6yUQa+OBZSNN/1/D1C1gckb9/K252jKQkFsEIj1uCMoGfkgt2t0O6WoEcIxlT
         YaSkUe9O0pyiTkCfG4ARUoysRqWPotffEww+fSpPlD/qkGdq8H9fD8HI/p7tAVnlZQ
         fc2gVuAYzfYZA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I8sYli1732862;
        Sat, 18 May 2019 01:54:34 -0700
Date:   Sat, 18 May 2019 01:54:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-be6e747136a4dc8aad99259e47fd6f7362a43996@git.kernel.org>
Cc:     jolsa@redhat.com, hpa@zytor.com, acme@redhat.com, mingo@kernel.org,
        adrian.hunter@intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Reply-To: jolsa@redhat.com, adrian.hunter@intel.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, acme@redhat.com, hpa@zytor.com,
          mingo@kernel.org
In-Reply-To: <20190503120828.25326-3-adrian.hunter@intel.com>
References: <20190503120828.25326-3-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf scripts python: exported-sql-viewer.py: Move
 view creation
Git-Commit-ID: be6e747136a4dc8aad99259e47fd6f7362a43996
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

Commit-ID:  be6e747136a4dc8aad99259e47fd6f7362a43996
Gitweb:     https://git.kernel.org/tip/be6e747136a4dc8aad99259e47fd6f7362a43996
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Fri, 3 May 2019 15:08:24 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:47 -0300

perf scripts python: exported-sql-viewer.py: Move view creation

As preparation for adding support for copying to clipboard, create view
in TreeWindowBase instead of derived classes.

Committer testing:

Tested using an old .db used to test some older patches:

  $ python ~acme/libexec/perf-core/scripts/python/exported-sql-viewer.py ~/c/adrian.hunter/simple-retpoline.db

Nothing breaks.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190503120828.25326-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 74ef92f1d19a..db4655168ab1 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -877,9 +877,10 @@ class TreeWindowBase(QMdiSubWindow):
 		super(TreeWindowBase, self).__init__(parent)
 
 		self.model = None
-		self.view = None
 		self.find_bar = None
 
+		self.view = QTreeView()
+
 	def DisplayFound(self, ids):
 		if not len(ids):
 			return False
@@ -921,7 +922,6 @@ class CallGraphWindow(TreeWindowBase):
 
 		self.model = LookupCreateModel("Context-Sensitive Call Graph", lambda x=glb: CallGraphModel(x))
 
-		self.view = QTreeView()
 		self.view.setModel(self.model)
 
 		for c, w in ((0, 250), (1, 100), (2, 60), (3, 70), (4, 70), (5, 100)):
@@ -944,7 +944,6 @@ class CallTreeWindow(TreeWindowBase):
 
 		self.model = LookupCreateModel("Call Tree", lambda x=glb: CallTreeModel(x))
 
-		self.view = QTreeView()
 		self.view.setModel(self.model)
 
 		for c, w in ((0, 230), (1, 100), (2, 100), (3, 70), (4, 70), (5, 100)):
