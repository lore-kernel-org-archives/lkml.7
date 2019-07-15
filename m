Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44285C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174A120449
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563225234;
	bh=u8HmPjb9vdeIErA/q6QPz73EAgZCBI+F0I6wcg7zwyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=faG9WYhbW/RcK5qK/RIZclgRLKjBl+zFop32gJJGHIiwxEtiMYy7BjGfTOvC/lJbp
	 QubyAStP91AiCC+y9Fr0XAj1htA3LR7sHa71tl4U2iT3Bb7vT/xYO6NB295HYv47Qk
	 togIvGsXP0V9jgTiEpO7XUNM4rlmvB9lRxTo3ziM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733247AbfGOVNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:13:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731381AbfGOVNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:13:51 -0400
Received: from quaco.ghostprotocols.net (179-240-129-12.3g.claro.net.br [179.240.129.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18D8920665;
        Mon, 15 Jul 2019 21:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563225230;
        bh=u8HmPjb9vdeIErA/q6QPz73EAgZCBI+F0I6wcg7zwyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qiJ8Mq6i9c/qcuCsOjlRdVGCv+fmBlX2Oo8lF53jHiGbOuQhDYEnyNQgEuRn6vzX6
         dQnlSYvlVHHtCbrwqd63CvRr/kU6JKCSj1q9SRInVD79++t8bNzMaMORgtSWox+ZeA
         K91fprSpznD9j7if1q8OLab2IHq//xxXzz39e5ik=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 19/28] perf scripts python: exported-sql-viewer.py: Use new 'has_calls' column
Date:   Mon, 15 Jul 2019 18:11:51 -0300
Message-Id: <20190715211200.10984-20-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190715211200.10984-1-acme@kernel.org>
References: <20190715211200.10984-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

If the new 'has_calls' column is present, use it with the call graph and
call tree to select only comms that have calls.

Committer testing:

Just started the exported-sql-view.py and accessed all the reports, no
backtraces.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-17-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index dbbd7a5d9b60..61b3911d91e6 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -623,8 +623,11 @@ class CallGraphRootItem(CallGraphLevelItemBase):
 		super(CallGraphRootItem, self).__init__(glb, params, 0, None)
 		self.dbid = 0
 		self.query_done = True
+		if_has_calls = ""
+		if IsSelectable(glb.db, "comms", columns = "has_calls"):
+			if_has_calls = " WHERE has_calls = TRUE"
 		query = QSqlQuery(glb.db)
-		QueryExec(query, "SELECT id, comm FROM comms")
+		QueryExec(query, "SELECT id, comm FROM comms" + if_has_calls)
 		while query.next():
 			if not query.value(0):
 				continue
@@ -900,8 +903,11 @@ class CallTreeRootItem(CallGraphLevelItemBase):
 		super(CallTreeRootItem, self).__init__(glb, params, 0, None)
 		self.dbid = 0
 		self.query_done = True
+		if_has_calls = ""
+		if IsSelectable(glb.db, "comms", columns = "has_calls"):
+			if_has_calls = " WHERE has_calls = TRUE"
 		query = QSqlQuery(glb.db)
-		QueryExec(query, "SELECT id, comm FROM comms")
+		QueryExec(query, "SELECT id, comm FROM comms" + if_has_calls)
 		while query.next():
 			if not query.value(0):
 				continue
-- 
2.21.0

