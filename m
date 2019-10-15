Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC517ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE22421925
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbfJOFev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:34:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42070 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728492AbfJOFcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:03 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFR0-0000A8-QS; Tue, 15 Oct 2019 07:31:50 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3EDE01C04D3;
        Tue, 15 Oct 2019 07:31:41 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:41 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Adopt perf_mmap__mmap() function from tools/perf
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191007125344.14268-5-jolsa@kernel.org>
References: <20191007125344.14268-5-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <157111750117.12254.5257253917922972771.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     32c261c070c222858148c2171698d2954242ddd9
Gitweb:        https://git.kernel.org/tip/32c261c070c222858148c2171698d2954242ddd9
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Mon, 07 Oct 2019 14:53:12 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 10 Oct 2019 09:42:59 -03:00

libperf: Adopt perf_mmap__mmap() function from tools/perf

Move perf_mmap__mmap() from tools/perf to libperf, it will be used in
the following patches. And rename the existing perf's function to
mmap__mmap().

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/mmap.h |  2 ++
 tools/perf/lib/mmap.c                  | 18 ++++++++++++++++++
 tools/perf/util/evlist.c               |  2 +-
 tools/perf/util/mmap.c                 | 12 +++---------
 tools/perf/util/mmap.h                 |  2 +-
 5 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index e7a6726..7067b70 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -37,5 +37,7 @@ struct perf_mmap_param {
 size_t perf_mmap__mmap_len(struct perf_mmap *map);
 
 void perf_mmap__init(struct perf_mmap *map, bool overwrite);
+int perf_mmap__mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
+		    int fd, int cpu);
 
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/lib/mmap.c b/tools/perf/lib/mmap.c
index cc4284d..b216a7d 100644
--- a/tools/perf/lib/mmap.c
+++ b/tools/perf/lib/mmap.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <sys/mman.h>
 #include <internal/mmap.h>
 #include <internal/lib.h>
 
@@ -13,3 +14,20 @@ size_t perf_mmap__mmap_len(struct perf_mmap *map)
 {
 	return map->mask + 1 + page_size;
 }
+
+int perf_mmap__mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
+		    int fd, int cpu)
+{
+	map->prev = 0;
+	map->mask = mp->mask;
+	map->base = mmap(NULL, perf_mmap__mmap_len(map), mp->prot,
+			 MAP_SHARED, fd, 0);
+	if (map->base == MAP_FAILED) {
+		map->base = NULL;
+		return -1;
+	}
+
+	map->fd  = fd;
+	map->cpu = cpu;
+	return 0;
+}
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 3a19a7c..f9781de 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -695,7 +695,7 @@ static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 		if (*output == -1) {
 			*output = fd;
 
-			if (perf_mmap__mmap(&maps[idx], mp, *output, evlist_cpu) < 0)
+			if (mmap__mmap(&maps[idx], mp, *output, evlist_cpu) < 0)
 				return -1;
 		} else {
 			if (ioctl(fd, PERF_EVENT_IOC_SET_OUTPUT, *output) != 0)
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index a8e81c4..acef6e3 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -353,7 +353,7 @@ static void perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params 
 		CPU_SET(map->core.cpu, &map->affinity_mask);
 }
 
-int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
+int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 {
 	/*
 	 * The last one will be done at perf_mmap__consume(), so that we
@@ -369,18 +369,12 @@ int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 	 * perf_evlist__filter_pollfd().
 	 */
 	refcount_set(&map->core.refcnt, 2);
-	map->core.prev = 0;
-	map->core.mask = mp->core.mask;
-	map->core.base = mmap(NULL, mmap__mmap_len(map), mp->core.prot,
-			 MAP_SHARED, fd, 0);
-	if (map->core.base == MAP_FAILED) {
+
+	if (perf_mmap__mmap(&map->core, &mp->core, fd, cpu)) {
 		pr_debug2("failed to mmap perf event ring buffer, error %d\n",
 			  errno);
-		map->core.base = NULL;
 		return -1;
 	}
-	map->core.fd = fd;
-	map->core.cpu = cpu;
 
 	perf_mmap__setup_affinity_mask(map, mp);
 
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 2b97dc6..a60e6ea 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -42,7 +42,7 @@ struct mmap_params {
 	struct auxtrace_mmap_params auxtrace_mp;
 };
 
-int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu);
+int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu);
 void perf_mmap__munmap(struct mmap *map);
 
 void perf_mmap__get(struct mmap *map);
