Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C54C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4372120693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="S2RikUcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388479AbfG3SuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:50:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39887 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388418AbfG3SuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:50:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UInwsJ3335515
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:49:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UInwsJ3335515
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564512599;
        bh=WXjuyk2IY+kTbglEz6/IJipMdwmqlisUECfmvP6aZLM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=S2RikUcXsOn1cdXjtPqslFaLxJbS52ibV9tTnvsIXs1OArwJBM8ri9seSqJ796uHS
         SY3JOzf6/DmMSHR09t567pJcgm/NtISNkvmbSdQJJyBUtGzkn5ZZiH8e9a35b9frqB
         Djb4zlpA6A3YrDpEl6JZwo77k9krTHR7pERoAzH7Ne3RS+9bI+EuskhbaALrplXolj
         UfC0VNWt8X1sXKAaBEaPXboxva5NYAovfMP1WSz4wtqS+WfuEKLHHaBCGsVtlHN8Pc
         swYZ58qBGMWErZkyb7L9w4V3yb0JFVlfRxRtEWZbKuMDQXB4z7swGxOiFPbrOha9ky
         3f28CHn3y5bGQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UInupF3335511;
        Tue, 30 Jul 2019 11:49:56 -0700
Date:   Tue, 30 Jul 2019 11:49:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-4b247fa7314ce48282f3da400a9ffb7f3fd3f863@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, alexey.budankov@linux.intel.com,
        namhyung@kernel.org, mpetlan@redhat.com, mingo@kernel.org,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, acme@redhat.com, ak@linux.intel.com,
        peterz@infradead.org, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, alexey.budankov@linux.intel.com,
          namhyung@kernel.org, mpetlan@redhat.com, mingo@kernel.org,
          alexander.shishkin@linux.intel.com, tglx@linutronix.de,
          acme@redhat.com, jolsa@kernel.org, peterz@infradead.org,
          ak@linux.intel.com, hpa@zytor.com
In-Reply-To: <20190721112506.12306-58-jolsa@kernel.org>
References: <20190721112506.12306-58-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Adopt xyarray class from perf
Git-Commit-ID: 4b247fa7314ce48282f3da400a9ffb7f3fd3f863
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

Commit-ID:  4b247fa7314ce48282f3da400a9ffb7f3fd3f863
Gitweb:     https://git.kernel.org/tip/4b247fa7314ce48282f3da400a9ffb7f3fd3f863
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:44 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:45 -0300

libperf: Adopt xyarray class from perf

Move the xyarray class from perf to libperf, because it's going to be
used in both.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-58-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c                            | 1 -
 tools/perf/lib/Build                                | 1 +
 tools/perf/{util => lib/include/internal}/xyarray.h | 6 +++---
 tools/perf/{util => lib}/xyarray.c                  | 4 ++--
 tools/perf/util/Build                               | 1 -
 tools/perf/util/counts.h                            | 2 +-
 tools/perf/util/evsel.h                             | 2 +-
 tools/perf/util/python-ext-sources                  | 1 -
 tools/perf/util/stat.h                              | 1 -
 9 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index c69ddc67c672..1a4615a5f6c9 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -38,7 +38,6 @@
 #include <subcmd/parse-options.h>
 #include "util/parse-events.h"
 #include "util/cpumap.h"
-#include "util/xyarray.h"
 #include "util/sort.h"
 #include "util/string2.h"
 #include "util/term.h"
diff --git a/tools/perf/lib/Build b/tools/perf/lib/Build
index faf64db13e37..4f78ec0b4e10 100644
--- a/tools/perf/lib/Build
+++ b/tools/perf/lib/Build
@@ -4,6 +4,7 @@ libperf-y += threadmap.o
 libperf-y += evsel.o
 libperf-y += evlist.o
 libperf-y += zalloc.o
+libperf-y += xyarray.o
 
 $(OUTPUT)zalloc.o: ../../lib/zalloc.c FORCE
 	$(call rule_mkdir)
diff --git a/tools/perf/util/xyarray.h b/tools/perf/lib/include/internal/xyarray.h
similarity index 84%
rename from tools/perf/util/xyarray.h
rename to tools/perf/lib/include/internal/xyarray.h
index 7ffe562e7ae7..3bf70e4d474c 100644
--- a/tools/perf/util/xyarray.h
+++ b/tools/perf/lib/include/internal/xyarray.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _PERF_XYARRAY_H_
-#define _PERF_XYARRAY_H_ 1
+#ifndef __LIBPERF_INTERNAL_XYARRAY_H
+#define __LIBPERF_INTERNAL_XYARRAY_H
 
 #include <sys/types.h>
 
@@ -32,4 +32,4 @@ static inline int xyarray__max_x(struct xyarray *xy)
 	return xy->max_x;
 }
 
-#endif /* _PERF_XYARRAY_H_ */
+#endif /* __LIBPERF_INTERNAL_XYARRAY_H */
diff --git a/tools/perf/util/xyarray.c b/tools/perf/lib/xyarray.c
similarity index 95%
copy from tools/perf/util/xyarray.c
copy to tools/perf/lib/xyarray.c
index 86889ebc3514..dcd901d154bb 100644
--- a/tools/perf/util/xyarray.c
+++ b/tools/perf/lib/xyarray.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "xyarray.h"
+#include <internal/xyarray.h>
+#include <linux/zalloc.h>
 #include <stdlib.h>
 #include <string.h>
-#include <linux/zalloc.h>
 
 struct xyarray *xyarray__new(int xlen, int ylen, size_t entry_size)
 {
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 08f670d21615..7abf05131889 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -69,7 +69,6 @@ perf-y += svghelper.o
 perf-y += sort.o
 perf-y += hist.o
 perf-y += util.o
-perf-y += xyarray.o
 perf-y += cpumap.o
 perf-y += cputopo.o
 perf-y += cgroup.o
diff --git a/tools/perf/util/counts.h b/tools/perf/util/counts.h
index 0f0cb2d8f70d..bbfac9ecf642 100644
--- a/tools/perf/util/counts.h
+++ b/tools/perf/util/counts.h
@@ -2,7 +2,7 @@
 #ifndef __PERF_COUNTS_H
 #define __PERF_COUNTS_H
 
-#include "xyarray.h"
+#include <internal/xyarray.h>
 
 struct perf_counts_values {
 	union {
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 57b5523b480c..1f9f66fe43f4 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -8,7 +8,7 @@
 #include <linux/perf_event.h>
 #include <linux/types.h>
 #include <internal/evsel.h>
-#include "xyarray.h"
+#include <internal/xyarray.h>
 #include "symbol_conf.h"
 #include "cpumap.h"
 #include "counts.h"
diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index 2237bac9fadb..235bd9803390 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -20,7 +20,6 @@ util/namespaces.c
 ../lib/vsprintf.c
 util/thread_map.c
 util/util.c
-util/xyarray.c
 util/cgroup.c
 util/parse-branch-options.c
 util/rblist.c
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 95b4de7a9d51..bcb376e1b3a7 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -8,7 +8,6 @@
 #include <sys/time.h>
 #include <sys/resource.h>
 #include <sys/wait.h>
-#include "xyarray.h"
 #include "rblist.h"
 #include "perf.h"
 #include "event.h"
