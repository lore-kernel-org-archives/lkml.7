Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E346C73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4902173C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562697159;
	bh=wXhP+ymiRqhZa+xy4KUDYrHPp6ger1vS4kpZxGglTBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SqEwv4QuaVtG+tknzOhm908LzqmFTg27FhraRsifWFEL6cX2623yxlfCxbxr/7HFn
	 Q5r4qYDSJT4KGe+72QL4mPnelikCOsbwQPV7/TNS4aJmaXd72a2s+sfYuU7VASnvs6
	 xk1lEC6umk2VgQHi+zgcclyuN11M0chDJe+HMZrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbfGISci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:32:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbfGIScf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:32:35 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8623C21537;
        Tue,  9 Jul 2019 18:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562697154;
        bh=wXhP+ymiRqhZa+xy4KUDYrHPp6ger1vS4kpZxGglTBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M/J0jUbaUG8zU1cCB/z18sYQyafAoCGouyMIcO1Y0st4kg9wY8gXQRITShXdTpWE2
         c0W9sugqSAeZ+5O/xu1zLmfHYdlvJnQUNqY80xWQV/TxEkeoHnXh0Kp+fXnvMwf5ZY
         3sLRRoBWZcquiJB3yx0FC8ypMYusMh7bE/BZQru4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 11/25] perf namespaces: Move the conditional setns() prototype to namespaces.h
Date:   Tue,  9 Jul 2019 15:31:12 -0300
Message-Id: <20190709183126.30257-12-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190709183126.30257-1-acme@kernel.org>
References: <20190709183126.30257-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Out of util.h, to reduce its scope, and since we have a namespaces.h
header, much better to have it there, where it is related to.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-zlu81bbtccuzygh7m8nmgybc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/namespaces.h | 4 ++++
 tools/perf/util/setns.c      | 4 +++-
 tools/perf/util/util.h       | 4 ----
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index 15a5a276c478..004430c0de93 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -13,6 +13,10 @@
 #include <linux/refcount.h>
 #include <linux/types.h>
 
+#ifndef HAVE_SETNS_SUPPORT
+int setns(int fd, int nstype);
+#endif
+
 struct namespaces_event;
 
 struct namespaces {
diff --git a/tools/perf/util/setns.c b/tools/perf/util/setns.c
index ce8fc290fce8..48f9c0af63b2 100644
--- a/tools/perf/util/setns.c
+++ b/tools/perf/util/setns.c
@@ -1,4 +1,6 @@
-#include "util.h"
+// SPDX-License-Identifier: LGPL-2.1
+
+#include "namespaces.h"
 #include <unistd.h>
 #include <sys/syscall.h>
 
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 125e215dd3d8..59fe33708090 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -67,10 +67,6 @@ char *get_current_dir_name(void);
 int sched_getcpu(void);
 #endif
 
-#ifndef HAVE_SETNS_SUPPORT
-int setns(int fd, int nstype);
-#endif
-
 extern bool perf_singlethreaded;
 
 void perf_set_singlethreaded(void);
-- 
2.21.0

