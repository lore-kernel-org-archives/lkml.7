Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A399C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CFD2173E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562034436;
	bh=RMKQHrkXimhUl3unqAy9V7qFshUvxyiDcfCIz/1kerc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FVNI67Wd1H95aTDFZul1KdaJFyY+0KRNux9b+AgqAoebziL/9M+90FOKru5JXobaa
	 LkXoDWxlSU4GN80ouLlU75LPDZ7mbf3/q54dXwSjmFBRe6i87GAXHfkkTx9MMc01XZ
	 MgfTBiSYT0flstVQafyxt/SrCJz8hizxsMwnQRjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfGBC1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:27:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727279AbfGBC1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:27:12 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93AFF2184B;
        Tue,  2 Jul 2019 02:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034430;
        bh=RMKQHrkXimhUl3unqAy9V7qFshUvxyiDcfCIz/1kerc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q3NG88HcJwN7/LPuDdiqr0z2QKh14rFoPs5oDAiDi6WjGGobOqe/KYyjgVuYnCCQS
         dgcRn4GQnTiz3Wqy5cn0Lb9zSvqUXd1qr1pyT9U2ccW567iGM36lr9jY6uGhPJam5s
         3AjOZ09QyRK4v0w5W2mbGszQXMqnZl2sgdWzM2Xs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 15/43] perf string: Move 'dots' and 'graph_dotted_line' out of sane_ctype.h
Date:   Mon,  1 Jul 2019 23:25:48 -0300
Message-Id: <20190702022616.1259-16-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Those are not in that file in the git repo, lets move it from there so
that we get that sane ctype code fully isolated to allow getting it in
sync either with the git sources or better with the kernel sources
(include/linux/ctype.h + lib/ctype.h), that way we can use
check_headers.h to get notified when changes are made in the original
code so that we can cherry-pick.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ioh5sghn3943j0rxg6lb2dgs@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-kmem.c    | 1 +
 tools/perf/builtin-sched.c   | 1 +
 tools/perf/builtin-top.c     | 1 +
 tools/perf/util/ctype.c      | 9 ---------
 tools/perf/util/evsel.c      | 1 +
 tools/perf/util/sane_ctype.h | 3 ---
 tools/perf/util/string.c     | 9 +++++++++
 tools/perf/util/string2.h    | 3 +++
 8 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index b80eee455111..b833b03d7195 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -21,6 +21,7 @@
 #include "util/cpumap.h"
 
 #include "util/debug.h"
+#include "util/string2.h"
 
 #include <linux/kernel.h>
 #include <linux/rbtree.h>
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 275f2d92a7bf..79577b67c898 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -15,6 +15,7 @@
 #include "util/thread_map.h"
 #include "util/color.h"
 #include "util/stat.h"
+#include "util/string2.h"
 #include "util/callchain.h"
 #include "util/time-utils.h"
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 12b6b15a9675..4ef02e6888ff 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -40,6 +40,7 @@
 #include "util/cpumap.h"
 #include "util/xyarray.h"
 #include "util/sort.h"
+#include "util/string2.h"
 #include "util/term.h"
 #include "util/intlist.h"
 #include "util/parse-branch-options.h"
diff --git a/tools/perf/util/ctype.c b/tools/perf/util/ctype.c
index 75c0da59c230..f84ecd9e5329 100644
--- a/tools/perf/util/ctype.c
+++ b/tools/perf/util/ctype.c
@@ -30,12 +30,3 @@ unsigned char sane_ctype[256] = {
 	A, A, A, A, A, A, A, A, A, A, A, R, R, P, P, 0,		/* 112..127 */
 	/* Nothing in the 128.. range */
 };
-
-const char *graph_dotted_line =
-	"---------------------------------------------------------------------"
-	"---------------------------------------------------------------------"
-	"---------------------------------------------------------------------";
-const char *dots =
-	"....................................................................."
-	"....................................................................."
-	".....................................................................";
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 04c4ed1573cb..4b175166d264 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -35,6 +35,7 @@
 #include "debug.h"
 #include "trace-event.h"
 #include "stat.h"
+#include "string2.h"
 #include "memswap.h"
 #include "util/parse-branch-options.h"
 
diff --git a/tools/perf/util/sane_ctype.h b/tools/perf/util/sane_ctype.h
index a2bb3890864f..c4dce9e3001b 100644
--- a/tools/perf/util/sane_ctype.h
+++ b/tools/perf/util/sane_ctype.h
@@ -2,9 +2,6 @@
 #ifndef _PERF_SANE_CTYPE_H
 #define _PERF_SANE_CTYPE_H
 
-extern const char *graph_dotted_line;
-extern const char *dots;
-
 /* Sane ctype - no locale, and works with signed chars */
 #undef isascii
 #undef isspace
diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
index d8bfd0c4d2cb..b18884bd673b 100644
--- a/tools/perf/util/string.c
+++ b/tools/perf/util/string.c
@@ -6,6 +6,15 @@
 
 #include "sane_ctype.h"
 
+const char *graph_dotted_line =
+	"---------------------------------------------------------------------"
+	"---------------------------------------------------------------------"
+	"---------------------------------------------------------------------";
+const char *dots =
+	"....................................................................."
+	"....................................................................."
+	".....................................................................";
+
 #define K 1024LL
 /*
  * perf_atoll()
diff --git a/tools/perf/util/string2.h b/tools/perf/util/string2.h
index 4c68a09b97e8..07fd37568543 100644
--- a/tools/perf/util/string2.h
+++ b/tools/perf/util/string2.h
@@ -6,6 +6,9 @@
 #include <stddef.h>
 #include <string.h>
 
+extern const char *graph_dotted_line;
+extern const char *dots;
+
 s64 perf_atoll(const char *str);
 char **argv_split(const char *str, int *argcp);
 void argv_free(char **argv);
-- 
2.20.1

