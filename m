Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BD1C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17BD2342E
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340676;
	bh=rmxXmj6cfM0Q1TcVVTx2EvQw0IA3BZrb3YUX9vP4Lfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ORy4s5bKnJM6ybhKc/MDFp1JLOGFlUb3H543FQzz1WOxGd2KyuWybLYm0wzEX+Bj6
	 T9KfH6LkFQmOINmjd5twBO6uI4nquI6w+Zk2EbaeHL0KcguU1uHTUclXV/SMJ2IMj9
	 XN53GkvUjC/B1Zy7YTtrGzJDWg3J/5TGHNKlqV6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbfIAMYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:24:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729049AbfIAMYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:24:30 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ACE42377D;
        Sun,  1 Sep 2019 12:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340669;
        bh=rmxXmj6cfM0Q1TcVVTx2EvQw0IA3BZrb3YUX9vP4Lfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ql1XAy8nE1fA3BQY/Sh2YEAju6JYCYBd1NxAoFdX8jWMcAZBh28Sc5Kqg+4GMQG7F
         pe5eyKnrSXlz0oXlPz63PizTPFIkDT9ie/f2tlsoc5x5WxNOVdzzHWFdb+gb3AXr7U
         6qGQKIlqL1QlAmsX2u8ZNb+72RaN3AdBrQXXxfRU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 18/47] perf event: Remove needless include directives from event.h
Date:   Sun,  1 Sep 2019 09:22:57 -0300
Message-Id: <20190901122326.5793-19-acme@kernel.org>
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

bpf.h and build-id.h are not needed at all in event.h, remove them.

And fixup the fallout of files that were getting needed stuff from this
now pruned include.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-rdm3dgtlrndmmnlc4bafsg3b@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/unwind-libdw.c |  1 +
 tools/perf/arch/x86/util/perf_regs.c        |  1 +
 tools/perf/perf.c                           |  1 +
 tools/perf/util/bpf-event.h                 |  1 +
 tools/perf/util/callchain.h                 |  1 +
 tools/perf/util/config.c                    |  2 ++
 tools/perf/util/debug.c                     |  1 +
 tools/perf/util/event.h                     | 18 ++++++++++++------
 8 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/unwind-libdw.c b/tools/perf/arch/powerpc/util/unwind-libdw.c
index 7a1f05ef2fc0..abf2dbc7f829 100644
--- a/tools/perf/arch/powerpc/util/unwind-libdw.c
+++ b/tools/perf/arch/powerpc/util/unwind-libdw.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <elfutils/libdwfl.h>
+#include <linux/kernel.h>
 #include "../../util/unwind-libdw.h"
 #include "../../util/perf_regs.h"
 #include "../../util/event.h"
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index 99ea60211e16..c218b83e063b 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -2,6 +2,7 @@
 #include <errno.h>
 #include <string.h>
 #include <regex.h>
+#include <linux/kernel.h>
 #include <linux/zalloc.h>
 
 #include "../../perf-sys.h"
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index e0910637a82d..8763b2c0fbfd 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -10,6 +10,7 @@
 #include "builtin.h"
 #include "perf.h"
 
+#include "util/build-id.h"
 #include "util/cache.h"
 #include "util/env.h"
 #include <subcmd/exec-cmd.h>
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index 417b78835ea0..a01c2fd68c03 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -13,6 +13,7 @@ struct machine;
 union perf_event;
 struct perf_env;
 struct perf_sample;
+struct perf_session;
 struct record_opts;
 struct evlist;
 struct target;
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 45b9ed49e2b1..b042ceef4114 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -8,6 +8,7 @@
 #include "map_symbol.h"
 #include "branch.h"
 
+struct evsel;
 struct map;
 
 #define HELP_PAD "\t\t\t\t"
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index eb5308c41ed1..7ebf9e31ae22 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -17,6 +17,8 @@
 #include "util/event.h"  /* proc_map_timeout */
 #include "util/hist.h"  /* perf_hist_config */
 #include "util/llvm-utils.h"   /* perf_llvm_config */
+#include "build-id.h"
+#include "debug.h"
 #include "config.h"
 #include "debug.h"
 #include <sys/types.h>
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 522887ee4c02..143d379d4608 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -8,6 +8,7 @@
 #include <stdlib.h>
 #include <sys/wait.h>
 #include <api/debug.h>
+#include <linux/kernel.h>
 #include <linux/time64.h>
 #ifdef HAVE_BACKTRACE_SUPPORT
 #include <execinfo.h>
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index f56d268f06e3..006aa432be19 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -1,17 +1,23 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __PERF_RECORD_H
 #define __PERF_RECORD_H
-
-#include <limits.h>
+/*
+ * The linux/stddef.h isn't need here, but is needed for __always_inline used
+ * in files included from uapi/linux/perf_event.h such as
+ * /usr/include/linux/swab.h and /usr/include/linux/byteorder/little_endian.h,
+ * detected in at least musl libc, used in Alpine Linux. -acme
+ */
 #include <stdio.h>
-#include <linux/kernel.h>
-#include <linux/bpf.h>
-#include <linux/perf_event.h>
+#include <linux/stddef.h>
 #include <perf/event.h>
+#include <linux/types.h>
 
-#include "build-id.h"
 #include "perf_regs.h"
 
+struct dso;
+struct machine;
+struct perf_event_attr;
+
 #ifdef __LP64__
 /*
  * /usr/include/inttypes.h uses just 'lu' for PRIu64, but we end up defining
-- 
2.21.0

