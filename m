Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D76C3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22AF2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbfH0I0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:26:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42690 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbfH0I0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:26:19 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2Wnq-0007lo-Op; Tue, 27 Aug 2019 10:26:10 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6BD2D1C0DDE;
        Tue, 27 Aug 2019 10:26:10 +0200 (CEST)
Date:   Tue, 27 Aug 2019 08:26:10 -0000
From:   tip-bot2 for Arnaldo Carvalho de Melo <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf cacheline: Move cacheline related routines to
 separate files
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-6kbf2cauas06rbqp15pyter5@git.kernel.org>
References: <tip-6kbf2cauas06rbqp15pyter5@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156689437029.24479.16720726998675578375.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     125009026bfc9ec929975d35344bf69d2c636e95
Gitweb:        https://git.kernel.org/tip/125009026bfc9ec929975d35344bf69d2c636e95
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 22 Aug 2019 16:58:29 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 26 Aug 2019 11:58:29 -03:00

perf cacheline: Move cacheline related routines to separate files

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
index 2111437..73782d9 100644
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
index b922c8c..2e38564 100644
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
index 0000000..9361d3f
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
index 0000000..dec8c0f
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
index f9a38a1..904ff4b 100644
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
index 5e34676..4ae155c 100644
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
index 6fd130a..44211e4 100644
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
index 0dab140..45a5c6f 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -34,7 +34,6 @@ int copyfile_offset(int ifd, loff_t off_in, int ofd, loff_t off_out, u64 size);
 size_t hex_width(u64 v);
 
 extern unsigned int page_size;
-int __pure cacheline_size(void);
 
 int sysctl__max_stack(void);
 
