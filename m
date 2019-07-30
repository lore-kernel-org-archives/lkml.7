Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02187C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC4D9217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455565;
	bh=9TU0UG6rrwIAmD71SPtS/kArSRm98x0VbuTTlEdSCFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qenVhSosINI5LovHD9brBT95DCARYy/We+oEDCqeHJLgtnYDYhbYnQaEyP5d2ze/f
	 glxWV0evwpN5AduhT78xlZNrRT9dgPPAN3Lj9yZCT902NAsg0Kvfn++ZREF+6lkSub
	 nuUFnFTAx9fubM2XIXl5qx8FlWaCU7s0kOgqjJzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732211AbfG3C7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:59:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732186AbfG3C7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:59:22 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86DB42070B;
        Tue, 30 Jul 2019 02:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455561;
        bh=9TU0UG6rrwIAmD71SPtS/kArSRm98x0VbuTTlEdSCFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Qsf+ng030Pg3InOlD5pERaq5DiHrJ1NPhHD0nHssH2vcIgIjq1axWqHI/i3H4uJJ
         i5ujfv1NOYTsi4YVDLpoIJu8hDNYyj5iNHdqycYtChTLP+XN/btNm7exkMWTodGOrL
         470F7G6z2aGuJenyHUSdorJEXWB0+97KvtxLDYSs=
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
Subject: [PATCH 055/107] libperf: Add perf_cpu_map struct
Date:   Mon, 29 Jul 2019 23:55:18 -0300
Message-Id: <20190730025610.22603-56-acme@kernel.org>
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

Add perf_cpu_map struct to libperf.

It's added as a declaration into:

  include/perf/cpumap.h

which will be included by users.

The perf_cpu_map struct definition is added into:

  include/internal/cpumap.h

which is not to be included by users, but shared within perf and
libperf.

We tried the total separation of the perf_cpu_map struct in libperf, but
it lead to complications and much bigger changes in perf code, so we
decided to share the declaration.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-29-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/Build                     |  1 +
 tools/perf/lib/cpumap.c                  |  5 +++++
 tools/perf/lib/include/internal/cpumap.h | 13 +++++++++++++
 tools/perf/lib/include/perf/cpumap.h     |  7 +++++++
 tools/perf/util/cpumap.h                 |  7 +------
 5 files changed, 27 insertions(+), 6 deletions(-)
 create mode 100644 tools/perf/lib/cpumap.c
 create mode 100644 tools/perf/lib/include/internal/cpumap.h
 create mode 100644 tools/perf/lib/include/perf/cpumap.h

diff --git a/tools/perf/lib/Build b/tools/perf/lib/Build
index 5196958cec01..195b274db49a 100644
--- a/tools/perf/lib/Build
+++ b/tools/perf/lib/Build
@@ -1 +1,2 @@
 libperf-y += core.o
+libperf-y += cpumap.o
diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
new file mode 100644
index 000000000000..86a199c26f20
--- /dev/null
+++ b/tools/perf/lib/cpumap.c
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <perf/cpumap.h>
+#include <stdlib.h>
+#include <linux/refcount.h>
+#include <internal/cpumap.h>
diff --git a/tools/perf/lib/include/internal/cpumap.h b/tools/perf/lib/include/internal/cpumap.h
new file mode 100644
index 000000000000..53ce95374b05
--- /dev/null
+++ b/tools/perf/lib/include/internal/cpumap.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_CPUMAP_H
+#define __LIBPERF_INTERNAL_CPUMAP_H
+
+#include <linux/refcount.h>
+
+struct perf_cpu_map {
+	refcount_t	refcnt;
+	int		nr;
+	int		map[];
+};
+
+#endif /* __LIBPERF_INTERNAL_CPUMAP_H */
diff --git a/tools/perf/lib/include/perf/cpumap.h b/tools/perf/lib/include/perf/cpumap.h
new file mode 100644
index 000000000000..8355d3ce7d0c
--- /dev/null
+++ b/tools/perf/lib/include/perf/cpumap.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_CPUMAP_H
+#define __LIBPERF_CPUMAP_H
+
+struct perf_cpu_map;
+
+#endif /* __LIBPERF_CPUMAP_H */
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 22729beae959..c2ba9ae195f7 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -5,16 +5,11 @@
 #include <stdio.h>
 #include <stdbool.h>
 #include <linux/refcount.h>
+#include <internal/cpumap.h>
 
 #include "perf.h"
 #include "util/debug.h"
 
-struct perf_cpu_map {
-	refcount_t refcnt;
-	int nr;
-	int map[];
-};
-
 struct perf_cpu_map *cpu_map__new(const char *cpu_list);
 struct perf_cpu_map *cpu_map__empty_new(int nr);
 struct perf_cpu_map *cpu_map__dummy_new(void);
-- 
2.21.0

