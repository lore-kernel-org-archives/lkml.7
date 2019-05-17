Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A80FC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4677D21743
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558121845;
	bh=Z4fY7mp2mu8VLHGxrCMrmWhmYvCmDhMNzYfZhkUnfMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zjvsZdM+cCHgFD/WC+gwwVNXYUcEykcwu4KfS637S9zibYTJVJUBMUf8hRlqmxN7B
	 lBBBVZyDfPgn+R1QlXJMVmOx7IorrXFkJWhfbXrv/a1Y+ts1c4rY/f9a8ecqpOlSBa
	 IOaFUkFdyTDs3UQZ4sXvmhW3DFDzymSqatYPBVlg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbfEQThY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:37:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727225AbfEQThW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:37:22 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB76521726;
        Fri, 17 May 2019 19:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558121842;
        bh=Z4fY7mp2mu8VLHGxrCMrmWhmYvCmDhMNzYfZhkUnfMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xBBjJZVmmp+8lqmcsEPufxuFpVF+quyFRjfhkGv9o5gK/KJHjaXgRtK+QWg+dDQIh
         Akoc2f54NEBXQKe6RMyxlBWNmvN2dQ19vE+KuyyEcpyjHtzPsf7Xog/dTnMXbUI2mE
         gfYg3poaimSfP7+7PseKID2I9LcMByiOnNY23mbY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 13/73] perf scripts python: exported-sql-viewer.py: Move view creation
Date:   Fri, 17 May 2019 16:35:11 -0300
Message-Id: <20190517193611.4974-14-acme@kernel.org>
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
-- 
2.20.1

