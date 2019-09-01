Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC91C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D722377D
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340667;
	bh=euylgx4DEH+JxcNcNulJzXxRtpvvnOVOENsLorfNFq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e125C/SBq0W4lbAu5S9GAiBYTUZPZ6aFQ2EVLWZkYMBORC6vDSgQ1e6AfMKhS+dSH
	 WFmXQyAc4GHVeQMy8QGkKOet+CHGhIEGzYJY+7LRXPSAiu8fGiQ53R5j6kD0JSg0bv
	 BrDzijTPVfxrOk/p1d0fxTt/GzDm7RWy/UURvX1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbfIAMYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:24:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729003AbfIAMYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:24:22 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B08622377B;
        Sun,  1 Sep 2019 12:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340661;
        bh=euylgx4DEH+JxcNcNulJzXxRtpvvnOVOENsLorfNFq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sSJJAtyvtHBJ23WbwypgLRMYDp94lt5oDNLcNpEdfwPx+Vm59KT2rvCAR3jKJFmo+
         SN8sCLdD/dqU/WY6L6YGADdaQYjmZbEak4IhEFxG5/iM2bV0syqLaeF5/xbOa/OuYy
         03daAJE3hc0T1GlDxG/9+5HEeErfbXLCiECzKaB8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 15/47] perf tools: Remove debug.h from header files not needing it
Date:   Sun,  1 Sep 2019 09:22:54 -0300
Message-Id: <20190901122326.5793-16-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

And fix the fallout, adding it to places that must have it since they
use its definitions.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-1s3jel4i26chq2g0lydoz7i3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/auxtrace.c          | 1 +
 tools/perf/arch/arm/util/cs-etm.c            | 1 +
 tools/perf/arch/x86/tests/perf-time-to-tsc.c | 1 +
 tools/perf/tests/code-reading.c              | 1 +
 tools/perf/tests/keep-tracking.c             | 1 +
 tools/perf/tests/mmap-basic.c                | 1 +
 tools/perf/tests/sw-clock.c                  | 2 ++
 tools/perf/tests/switch-tracking.c           | 1 +
 tools/perf/tests/task-exit.c                 | 1 +
 tools/perf/ui/browsers/annotate.c            | 1 +
 tools/perf/ui/browsers/hists.c               | 1 +
 tools/perf/ui/hist.c                         | 1 +
 tools/perf/util/auxtrace.h                   | 2 +-
 tools/perf/util/config.c                     | 1 +
 tools/perf/util/hist.c                       | 1 +
 tools/perf/util/llvm-utils.h                 | 2 +-
 tools/perf/util/metricgroup.c                | 2 ++
 tools/perf/util/python.c                     | 1 +
 tools/perf/util/record.c                     | 1 +
 tools/perf/util/session.c                    | 1 +
 tools/perf/util/sort.c                       | 1 +
 tools/perf/util/stat.c                       | 1 +
 tools/perf/util/trigger.h                    | 1 -
 23 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index 41b78f74599f..0a6e75b8777a 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -9,6 +9,7 @@
 #include <linux/zalloc.h>
 
 #include "../../util/auxtrace.h"
+#include "../../util/debug.h"
 #include "../../util/evlist.h"
 #include "../../util/pmu.h"
 #include "cs-etm.h"
diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 9644e2d405f7..b74fd408d496 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -15,6 +15,7 @@
 #include <linux/zalloc.h>
 
 #include "cs-etm.h"
+#include "../../util/debug.h"
 #include "../../util/record.h"
 #include "../../util/auxtrace.h"
 #include "../../util/cpumap.h"
diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index 02776109ba46..2d1f4713b728 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -9,6 +9,7 @@
 #include <perf/cpumap.h>
 #include <perf/evlist.h>
 
+#include "debug.h"
 #include "parse-events.h"
 #include "evlist.h"
 #include "evsel.h"
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index fe671b860086..c4b73bb4b113 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -11,6 +11,7 @@
 #include <perf/cpumap.h>
 #include <perf/evlist.h>
 
+#include "debug.h"
 #include "parse-events.h"
 #include "evlist.h"
 #include "evsel.h"
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index 2af6faf1bbd6..c758798d3774 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -5,6 +5,7 @@
 #include <perf/cpumap.h>
 #include <perf/evlist.h>
 
+#include "debug.h"
 #include "parse-events.h"
 #include "evlist.h"
 #include "evsel.h"
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 7327694fbde0..fe91350fd5ab 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -5,6 +5,7 @@
 #include <pthread.h>
 #include <perf/cpumap.h>
 
+#include "debug.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "thread_map.h"
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index c5f1a9f83380..97694a040986 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -5,8 +5,10 @@
 #include <stdlib.h>
 #include <signal.h>
 #include <sys/mman.h>
+#include <linux/string.h>
 
 #include "tests.h"
+#include "util/debug.h"
 #include "util/evsel.h"
 #include "util/evlist.h"
 #include "util/cpumap.h"
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index b63f02768724..4bed15aee1a8 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -8,6 +8,7 @@
 #include <perf/cpumap.h>
 #include <perf/evlist.h>
 
+#include "debug.h"
 #include "parse-events.h"
 #include "evlist.h"
 #include "evsel.h"
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index d79a22e2d8be..0e0e0627184e 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "debug.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "target.h"
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index e633eb42550d..715601f5fce3 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -4,6 +4,7 @@
 #include "../ui.h"
 #include "../util.h"
 #include "../../util/annotate.h"
+#include "../../util/debug.h"
 #include "../../util/hist.h"
 #include "../../util/sort.h"
 #include "../../util/map.h"
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index ccc37284860b..a14dda74f43a 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -11,6 +11,7 @@
 #include <linux/time64.h>
 #include <linux/zalloc.h>
 
+#include "../../util/debug.h"
 #include "../../util/callchain.h"
 #include "../../util/evsel.h"
 #include "../../util/evlist.h"
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index ae29f16979ac..bf90ce5b2cdf 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -4,6 +4,7 @@
 #include <linux/compiler.h>
 
 #include "../util/callchain.h"
+#include "../util/debug.h"
 #include "../util/hist.h"
 #include "../util/util.h"
 #include "../util/sort.h"
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index bc39cc5610a8..b5ac24c770d4 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -19,7 +19,6 @@
 
 #include "event.h"
 #include "session.h"
-#include "debug.h"
 
 union perf_event;
 struct perf_session;
@@ -614,6 +613,7 @@ void itrace_synth_opts__clear_time_range(struct itrace_synth_opts *opts)
 }
 
 #else
+#include "debug.h"
 
 static inline struct auxtrace_record *
 auxtrace_record__init(struct evlist *evlist __maybe_unused,
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 042ffbc8c53f..eb5308c41ed1 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -18,6 +18,7 @@
 #include "util/hist.h"  /* perf_hist_config */
 #include "util/llvm-utils.h"   /* perf_llvm_config */
 #include "config.h"
+#include "debug.h"
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index e0b149673a88..adae4134e972 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "callchain.h"
+#include "debug.h"
 #include "build-id.h"
 #include "hist.h"
 #include "map.h"
diff --git a/tools/perf/util/llvm-utils.h b/tools/perf/util/llvm-utils.h
index bf3f3f4c4fe2..7878a0e3fa98 100644
--- a/tools/perf/util/llvm-utils.h
+++ b/tools/perf/util/llvm-utils.h
@@ -6,7 +6,7 @@
 #ifndef __LLVM_UTILS_H
 #define __LLVM_UTILS_H
 
-#include "debug.h"
+#include <stdbool.h>
 
 struct llvm_param {
 	/* Path of clang executable */
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index aaf55444f81b..33f5e2101874 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -6,6 +6,7 @@
 /* Manage metrics and groups of metrics from JSON files */
 
 #include "metricgroup.h"
+#include "debug.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "strbuf.h"
@@ -18,6 +19,7 @@
 #include "strlist.h"
 #include <assert.h>
 #include <linux/ctype.h>
+#include <linux/string.h>
 #include <linux/zalloc.h>
 #include <subcmd/parse-options.h>
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 9dd83871aafe..9b350482c403 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -5,6 +5,7 @@
 #include <poll.h>
 #include <linux/err.h>
 #include <perf/cpumap.h>
+#include "debug.h"
 #include "evlist.h"
 #include "callchain.h"
 #include "evsel.h"
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index c67a51397bc7..ccad796bce5f 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "debug.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "cpumap.h"
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 82bd5d4361f0..a72774e4463f 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -12,6 +12,7 @@
 #include <sys/mman.h>
 #include <perf/cpumap.h>
 
+#include "debug.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "memswap.h"
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 83eb3fa6f941..23d0ab7c801c 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -4,6 +4,7 @@
 #include <regex.h>
 #include <linux/mman.h>
 #include <linux/time64.h>
+#include "debug.h"
 #include "sort.h"
 #include "hist.h"
 #include "cacheline.h"
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index f6eb6af5f151..f4a1edcec7b2 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -3,6 +3,7 @@
 #include <inttypes.h>
 #include <math.h>
 #include "counts.h"
+#include "debug.h"
 #include "stat.h"
 #include "target.h"
 #include "evlist.h"
diff --git a/tools/perf/util/trigger.h b/tools/perf/util/trigger.h
index 88223bc7c82b..33e997f9ccc8 100644
--- a/tools/perf/util/trigger.h
+++ b/tools/perf/util/trigger.h
@@ -2,7 +2,6 @@
 #ifndef __TRIGGER_H_
 #define __TRIGGER_H_ 1
 
-#include "util/debug.h"
 #include "asm/bug.h"
 
 /*
-- 
2.21.0

