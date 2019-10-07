Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C9CC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB6E20867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570452967;
	bh=1MZ/l6uuu7Cqc9S5ukpxXs7IiWud8DMwhrEnBlntDH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AjiDDI+0pByyi6VJzZxtnB7Mmi4FwAK41JmCCisbj85vUPDSGfCWEGLPkbup1YJrm
	 Qv3r20YD3yfKsNHlJXZtta88imYveKdBtvGnX/nL+6z8fDfLk9xpWtIo134F/TO4b5
	 8HUiqC/E91SgfDsGMu7sa9SAjR8jDWjQHRFPpKSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfJGMyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:54:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbfJGMx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:53:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 049D018C8921;
        Mon,  7 Oct 2019 12:53:56 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D98F5D9CC;
        Mon,  7 Oct 2019 12:53:54 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 04/36] libperf: Add perf_mmap__mmap() function
Date:   Mon,  7 Oct 2019 14:53:12 +0200
Message-Id: <20191007125344.14268-5-jolsa@kernel.org>
In-Reply-To: <20191007125344.14268-1-jolsa@kernel.org>
References: <20191007125344.14268-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Mon, 07 Oct 2019 12:53:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move perf_mmap__mmap() from tools/perf to libperf, it will be used in
the following patches. And rename the existing perf's function to
mmap__mmap().

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-43-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/mmap.h |  2 ++
 tools/perf/lib/mmap.c                  | 18 ++++++++++++++++++
 tools/perf/util/evlist.c               |  2 +-
 tools/perf/util/mmap.c                 | 12 +++---------
 tools/perf/util/mmap.h                 |  2 +-
 5 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index e7a67260940c..7067b70c6f61 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -37,5 +37,7 @@ struct perf_mmap_param {
 size_t perf_mmap__mmap_len(struct perf_mmap *map);
 
 void perf_mmap__init(struct perf_mmap *map, bool overwrite);
+int perf_mmap__mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
+		    int fd, int cpu);
 
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/lib/mmap.c b/tools/perf/lib/mmap.c
index cc4284da4d99..b216a7db857f 100644
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
index 666339d4d1cd..055f625dc630 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -671,7 +671,7 @@ static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 		if (*output == -1) {
 			*output = fd;
 
-			if (perf_mmap__mmap(&maps[idx], mp, *output, evlist_cpu) < 0)
+			if (mmap__mmap(&maps[idx], mp, *output, evlist_cpu) < 0)
 				return -1;
 		} else {
 			if (ioctl(fd, PERF_EVENT_IOC_SET_OUTPUT, *output) != 0)
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index a8e81c4cbae8..acef6e3f6b80 100644
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
index 2b97dc6d9ee2..a60e6ead7255 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -42,7 +42,7 @@ struct mmap_params {
 	struct auxtrace_mmap_params auxtrace_mp;
 };
 
-int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu);
+int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu);
 void perf_mmap__munmap(struct mmap *map);
 
 void perf_mmap__get(struct mmap *map);
-- 
2.21.0

