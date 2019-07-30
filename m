Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661DDC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390CF2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455670;
	bh=zEieap6oCfUamQZvFhNVok/22xVVpFa6fKWGI6V7tAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VVh6kwxpVrkI6rfJOObRc6oZfTwCWwWrW7Rczb+VP4GHVLgUVlxSdHQxylD0pyDEs
	 DaRyZI9d7eeJTQLGjtS3luNJeq0LKcEMF10OeBTvSJISUvyEcd92iOkKNlU9G81Njb
	 QMbcK5s4SMtaG1A8L3Tq+z5/j41wbDaprRp4K2/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfG3DBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:01:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732519AbfG3DBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:01:05 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BED1D2171F;
        Tue, 30 Jul 2019 03:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455664;
        bh=zEieap6oCfUamQZvFhNVok/22xVVpFa6fKWGI6V7tAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UyRqEYpvSzp1Auj8szF5jqhDmyZROKU/EdwxIxzHx4ySH7cP0iuSN4ze87RRHd31N
         qtuP6j+6JeJCspkYpfuSPYn//gWhwpvFa0abUKTy74flDmPXwzli3DLggBEkhIpT0t
         bgTMNJUD+SITEPqxoe6HO7A8xiJBH7GvySU9i9Zk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 084/107] libperf: Adopt xyarray class from perf
Date:   Mon, 29 Jul 2019 23:55:47 -0300
Message-Id: <20190730025610.22603-85-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
 tools/perf/builtin-top.c                      |  1 -
 tools/perf/lib/Build                          |  1 +
 .../{util => lib/include/internal}/xyarray.h  |  6 ++--
 tools/perf/lib/xyarray.c                      | 33 +++++++++++++++++++
 tools/perf/util/Build                         |  1 -
 tools/perf/util/counts.h                      |  2 +-
 tools/perf/util/evsel.h                       |  2 +-
 tools/perf/util/python-ext-sources            |  1 -
 tools/perf/util/stat.h                        |  1 -
 9 files changed, 39 insertions(+), 9 deletions(-)
 rename tools/perf/{util => lib/include/internal}/xyarray.h (84%)
 create mode 100644 tools/perf/lib/xyarray.c

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
diff --git a/tools/perf/lib/xyarray.c b/tools/perf/lib/xyarray.c
new file mode 100644
index 000000000000..dcd901d154bb
--- /dev/null
+++ b/tools/perf/lib/xyarray.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <internal/xyarray.h>
+#include <linux/zalloc.h>
+#include <stdlib.h>
+#include <string.h>
+
+struct xyarray *xyarray__new(int xlen, int ylen, size_t entry_size)
+{
+	size_t row_size = ylen * entry_size;
+	struct xyarray *xy = zalloc(sizeof(*xy) + xlen * row_size);
+
+	if (xy != NULL) {
+		xy->entry_size = entry_size;
+		xy->row_size   = row_size;
+		xy->entries    = xlen * ylen;
+		xy->max_x      = xlen;
+		xy->max_y      = ylen;
+	}
+
+	return xy;
+}
+
+void xyarray__reset(struct xyarray *xy)
+{
+	size_t n = xy->entries * xy->entry_size;
+
+	memset(xy->contents, 0, n);
+}
+
+void xyarray__delete(struct xyarray *xy)
+{
+	free(xy);
+}
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
-- 
2.21.0

