Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E18C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AD22171F
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708690;
	bh=NClD45YVQXHk8KqMnLKU7qukNAmXjznms2zJrOyZXnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YPh/0PnNkhJIvSQVOB3afRXH6dDNInAqpkSuunoQeHR0eb/E2E7mxoNk7ev+vfB/O
	 m4+m9072Z9+QRXe75LYClY9wuIAuIw1n8MVlnwZpcvvnCqkeI0InUgPmsWf7Q8uoTu
	 Uz9DjI88c6C6TxKpk56IzOE9ZkXY1ai+aos3l6xM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfGULb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:31:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfGULb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:31:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1B10F308FC4B;
        Sun, 21 Jul 2019 11:31:27 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DBD995D9D3;
        Sun, 21 Jul 2019 11:31:22 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 57/79] libperf: Add xyarray object
Date:   Sun, 21 Jul 2019 13:24:44 +0200
Message-Id: <20190721112506.12306-58-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Sun, 21 Jul 2019 11:31:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving xyarray object from perf to libperf,
because it's going to be used in both.

Link: http://lkml.kernel.org/n/tip-y9609h8rl7kegpc3pdll9w3z@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-top.c                  |  1 -
 tools/perf/lib/Build                      |  1 +
 tools/perf/lib/include/internal/xyarray.h | 35 +++++++++++++++++++++++
 tools/perf/lib/xyarray.c                  | 33 +++++++++++++++++++++
 tools/perf/util/Build                     |  1 -
 tools/perf/util/counts.h                  |  2 +-
 tools/perf/util/evsel.h                   |  2 +-
 tools/perf/util/python-ext-sources        |  1 -
 tools/perf/util/stat.h                    |  1 -
 tools/perf/util/xyarray.h                 | 35 -----------------------
 10 files changed, 71 insertions(+), 41 deletions(-)
 create mode 100644 tools/perf/lib/include/internal/xyarray.h
 create mode 100644 tools/perf/lib/xyarray.c
 delete mode 100644 tools/perf/util/xyarray.h

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
diff --git a/tools/perf/lib/include/internal/xyarray.h b/tools/perf/lib/include/internal/xyarray.h
new file mode 100644
index 000000000000..3bf70e4d474c
--- /dev/null
+++ b/tools/perf/lib/include/internal/xyarray.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_XYARRAY_H
+#define __LIBPERF_INTERNAL_XYARRAY_H
+
+#include <sys/types.h>
+
+struct xyarray {
+	size_t row_size;
+	size_t entry_size;
+	size_t entries;
+	size_t max_x;
+	size_t max_y;
+	char contents[];
+};
+
+struct xyarray *xyarray__new(int xlen, int ylen, size_t entry_size);
+void xyarray__delete(struct xyarray *xy);
+void xyarray__reset(struct xyarray *xy);
+
+static inline void *xyarray__entry(struct xyarray *xy, int x, int y)
+{
+	return &xy->contents[x * xy->row_size + y * xy->entry_size];
+}
+
+static inline int xyarray__max_y(struct xyarray *xy)
+{
+	return xy->max_y;
+}
+
+static inline int xyarray__max_x(struct xyarray *xy)
+{
+	return xy->max_x;
+}
+
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
diff --git a/tools/perf/util/xyarray.h b/tools/perf/util/xyarray.h
deleted file mode 100644
index 7ffe562e7ae7..000000000000
--- a/tools/perf/util/xyarray.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _PERF_XYARRAY_H_
-#define _PERF_XYARRAY_H_ 1
-
-#include <sys/types.h>
-
-struct xyarray {
-	size_t row_size;
-	size_t entry_size;
-	size_t entries;
-	size_t max_x;
-	size_t max_y;
-	char contents[];
-};
-
-struct xyarray *xyarray__new(int xlen, int ylen, size_t entry_size);
-void xyarray__delete(struct xyarray *xy);
-void xyarray__reset(struct xyarray *xy);
-
-static inline void *xyarray__entry(struct xyarray *xy, int x, int y)
-{
-	return &xy->contents[x * xy->row_size + y * xy->entry_size];
-}
-
-static inline int xyarray__max_y(struct xyarray *xy)
-{
-	return xy->max_y;
-}
-
-static inline int xyarray__max_x(struct xyarray *xy)
-{
-	return xy->max_x;
-}
-
-#endif /* _PERF_XYARRAY_H_ */
-- 
2.21.0

