Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29285C76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F091D21738
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708518;
	bh=fahNAPQu0yjdYYRRzob/rTOlHyYN3a6Tg9TMFz8zzNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GF8lb5ejHroQI3q+x9h3XXEjlP/xjCY4OmQBmtI3PLGUbFtz6ehsjS3IKmSE9S84X
	 yEYH9XWAs83JKKf+2HldpX+ncEv2JlRYeVsrs5hTYam89In7Z/+dX/GpUiHM1SLdBp
	 VKMBISBoZtauMf35QjbC06np6xB3PWeeiWQQlgrs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfGUL2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:28:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbfGUL2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:28:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6CB5F3082132;
        Sun, 21 Jul 2019 11:28:35 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 230F75D9D3;
        Sun, 21 Jul 2019 11:28:30 +0000 (UTC)
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
Subject: [PATCH 28/79] libperf: Add perf_cpu_map struct
Date:   Sun, 21 Jul 2019 13:24:15 +0200
Message-Id: <20190721112506.12306-29-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Sun, 21 Jul 2019 11:28:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_cpu_map struct into libperf.

It's added as a declaration into into:
  include/perf/cpumap.h
which will be included by users.

The perf_cpu_map struct definition is added into:
  include/internal/cpumap.h

which is not to be included by users, but shared
within perf and libperf.

We tried the total separation of the perf_cpu_map struct
in libperf, but it lead to complications and much bigger
changes in perf code, so we decided to share the declaration.

Link: http://lkml.kernel.org/n/tip-vhtr6a8apr7vkh2tou0r8896@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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

