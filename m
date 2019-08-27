Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFD6C3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29592186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566869818;
	bh=57iVDk97Zo88yn+EN5Od+hKJMfd08PnPHHA+Ly6GwlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xOUnUuyLd+AAyXqQZs5El0Soup2SE1+RaLwqAttYEzszPnAaS2YCQ14pwM3A5LOWe
	 HlAiQ8O+K/u8WPL+5Ay9NsHW+cBV0SyoQeiDJyhWX77ObW5Tse4nx1/0Njj8uRc7Co
	 KoJGjBr3d9i7gX1oibSHbJZWPQsN0qnq4UUp2iEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbfH0Bg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:36:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728607AbfH0Bgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:36:55 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48ADF22CBB;
        Tue, 27 Aug 2019 01:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566869814;
        bh=57iVDk97Zo88yn+EN5Od+hKJMfd08PnPHHA+Ly6GwlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vC+yWeyAeTQgcFkXAz2UPiGFN2UnkYtTwpoRg0N0gdYkOxiAHgU67n/HQmoUaHlR8
         MhmwEw6kTOalqnGFiEN6tO4WuV1436YNqGvDa56FDsEStdwEKWQeNksdfQaDA1E2aT
         np/p77xxofd4fAIXzLMpchYWOulDiYN9RheEjC/s=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 04/33] perf cacheline: Move cacheline related routines to separate files
Date:   Mon, 26 Aug 2019 22:36:05 -0300
Message-Id: <20190827013634.3173-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To disentangle util/sort.h a bit more.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-6kbf2cauas06rbqp15pyter5@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c    |  1 +
 tools/perf/util/Build       |  1 +
 tools/perf/util/cacheline.c | 26 ++++++++++++++++++++++++++
 tools/perf/util/cacheline.h | 21 +++++++++++++++++++++
 tools/perf/util/sort.c      |  1 +
 tools/perf/util/sort.h      | 12 ------------
 tools/perf/util/util.c      | 20 --------------------
 tools/perf/util/util.h      |  1 -
 8 files changed, 50 insertions(+), 33 deletions(-)
 create mode 100644 tools/perf/util/cacheline.c
 create mode 100644 tools/perf/util/cacheline.h

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 211143720078..73782d99ee5a 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -26,6 +26,7 @@
 #include "hist.h"
 #include "sort.h"
 #include "tool.h"
+#include "cacheline.h"
 #include "data.h"
 #include "event.h"
 #include "evlist.h"
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index b922c8c297ca..2e3856471e61 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -1,6 +1,7 @@
 perf-y += annotate.o
 perf-y += block-range.o
 perf-y += build-id.o
+perf-y += cacheline.o
 perf-y += config.o
 perf-y += ctype.o
 perf-y += db-export.o
diff --git a/tools/perf/util/cacheline.c b/tools/perf/util/cacheline.c
new file mode 100644
index 000000000000..9361d3f61f75
--- /dev/null
+++ b/tools/perf/util/cacheline.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "cacheline.h"
+#include "../perf.h"
+#include <unistd.h>
+
+#ifdef _SC_LEVEL1_DCACHE_LINESIZE
+#define cache_line_size(cacheline_sizep) *cacheline_sizep = sysconf(_SC_LEVEL1_DCACHE_LINESIZE)
+#else
+#include <api/fs/fs.h>
+#include "debug.h"
+static void cache_line_size(int *cacheline_sizep)
+{
+	if (sysfs__read_int("devices/system/cpu/cpu0/cache/index0/coherency_line_size", cacheline_sizep))
+		pr_debug("cannot determine cache line size");
+}
+#endif
+
+int cacheline_size(void)
+{
+	static int size;
+
+	if (!size)
+		cache_line_size(&size);
+
+	return size;
+}
diff --git a/tools/perf/util/cacheline.h b/tools/perf/util/cacheline.h
new file mode 100644
index 000000000000..dec8c0fb1f4a
--- /dev/null
+++ b/tools/perf/util/cacheline.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef PERF_CACHELINE_H
+#define PERF_CACHELINE_H
+
+#include <linux/compiler.h>
+
+int __pure cacheline_size(void);
+
+static inline u64 cl_address(u64 address)
+{
+	/* return the cacheline of the address */
+	return (address & ~(cacheline_size() - 1));
+}
+
+static inline u64 cl_offset(u64 address)
+{
+	/* return the cacheline of the address */
+	return (address & (cacheline_size() - 1));
+}
+
+#endif // PERF_CACHELINE_H
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index f9a38a1dd4d1..904ff4b2f57f 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -6,6 +6,7 @@
 #include <linux/time64.h>
 #include "sort.h"
 #include "hist.h"
+#include "cacheline.h"
 #include "comm.h"
 #include "map.h"
 #include "symbol.h"
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 5e34676a98e8..4ae155c6a808 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -204,18 +204,6 @@ static inline float hist_entry__get_percent_limit(struct hist_entry *he)
 	return period * 100.0 / total_period;
 }
 
-static inline u64 cl_address(u64 address)
-{
-	/* return the cacheline of the address */
-	return (address & ~(cacheline_size() - 1));
-}
-
-static inline u64 cl_offset(u64 address)
-{
-	/* return the cacheline of the address */
-	return (address & (cacheline_size() - 1));
-}
-
 enum sort_mode {
 	SORT_MODE__NORMAL,
 	SORT_MODE__BRANCH,
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 6fd130a5d8f2..44211e483fbf 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -43,26 +43,6 @@ void perf_set_multithreaded(void)
 
 unsigned int page_size;
 
-#ifdef _SC_LEVEL1_DCACHE_LINESIZE
-#define cache_line_size(cacheline_sizep) *cacheline_sizep = sysconf(_SC_LEVEL1_DCACHE_LINESIZE)
-#else
-static void cache_line_size(int *cacheline_sizep)
-{
-	if (sysfs__read_int("devices/system/cpu/cpu0/cache/index0/coherency_line_size", cacheline_sizep))
-		pr_debug("cannot determine cache line size");
-}
-#endif
-
-int cacheline_size(void)
-{
-	static int size;
-
-	if (!size)
-		cache_line_size(&size);
-
-	return size;
-}
-
 int sysctl_perf_event_max_stack = PERF_MAX_STACK_DEPTH;
 int sysctl_perf_event_max_contexts_per_stack = PERF_MAX_CONTEXTS_PER_STACK;
 
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 0dab140c6517..45a5c6f20197 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -34,7 +34,6 @@ int copyfile_offset(int ifd, loff_t off_in, int ofd, loff_t off_out, u64 size);
 size_t hex_width(u64 v);
 
 extern unsigned int page_size;
-int __pure cacheline_size(void);
 
 int sysctl__max_stack(void);
 
-- 
2.21.0

