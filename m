Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD3FC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBEDC21881
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="kj6dxrM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfGCOLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:11:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56607 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfGCOLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:11:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63EBIoE3321817
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:11:18 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63EBIoE3321817
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562163078;
        bh=AsIwBeoN2MjS/gaZp8CJYL3SJS04CyaVSJkZRrP4VwA=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=kj6dxrM1bZ72isfvmEH9famHWaDuAfBTy/c53PfG7+l5ddZXjXgf7oAjQUXnNEIpr
         o7ogfs9oSiSiW7tRogqAoaSnfxU5SUPAHsoS65zsaxexjn5aJgGYoOLQSQmXXCtz1b
         lTfqWmaMKzlKrcPFvI2dIIxZnZgGlbBwMnzRh+fn1Z2UO+dHo8dHGS/Deed8XNNpho
         6u63B3JqabyjFbsrUvwlQBt7pJpYeL+8coxFIh1f1YZz2Xuwpttb6H7qgXSjibrBG+
         ArifNf8dHCdV8YsmbIcT5GUAHPA4kjmHlgaFtu9XI0zpFT37ovQT3obRWD3UzSgbiy
         S3YLVOpQphpJQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EBHoc3321814;
        Wed, 3 Jul 2019 07:11:17 -0700
Date:   Wed, 3 Jul 2019 07:11:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ioh5sghn3943j0rxg6lb2dgs@git.kernel.org>
Cc:     adrian.hunter@intel.com, acme@redhat.com, tglx@linutronix.de,
        mingo@kernel.org, hpa@zytor.com, namhyung@kernel.org,
        jolsa@kernel.org, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, jolsa@kernel.org,
          namhyung@kernel.org, hpa@zytor.com, mingo@kernel.org,
          tglx@linutronix.de, adrian.hunter@intel.com, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf string: Move 'dots' and 'graph_dotted_line'
 out of sane_ctype.h
Git-Commit-ID: 6a9fa4e3bddedc027b691b6470c500d51d04e56c
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

Commit-ID:  6a9fa4e3bddedc027b691b6470c500d51d04e56c
Gitweb:     https://git.kernel.org/tip/6a9fa4e3bddedc027b691b6470c500d51d04e56c
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 25 Jun 2019 17:31:26 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 25 Jun 2019 17:31:26 -0300

perf string: Move 'dots' and 'graph_dotted_line' out of sane_ctype.h

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
