Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C38C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996E7222C1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824631;
	bh=EKnoZrhokqFVAY1gtWhunxd00LfQ3A9P++yJOgbYfBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZHbWg+5jsD+Ex2tZGeHxd0ulexS/Rlc+rH7nk3bKMzO8Mbh5sjWeVQ5dMUaRoxIMR
	 IIP7AZMnmDS0G4KOk2qaay9rAk9XF2ToT0dgBAdfhTMcvIEfA6iveEO0KyqlpVJWGh
	 PXihkfMgIh4oHgw7WMqoX198eg8Bqj9qS4jt8iro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbfJKUK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:10:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729088AbfJKUK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:10:26 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 396A7222BE;
        Fri, 11 Oct 2019 20:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824625;
        bh=EKnoZrhokqFVAY1gtWhunxd00LfQ3A9P++yJOgbYfBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UasxcNQ2xuR+DOSAyC4e0PTSqbLYwDgFpyetu7IhB8uiD5MVjMHZlm5W0OPzgX1hN
         25LSGsDOTQXGsXyIZtevvINELzYp9tQPobnufzRWV3hA1sAIcCvPQ1Xyu0ecYrDyN3
         jsy1p2MAqFqAkK8FJLLZvKKAUqqQXjeSiC1vPErk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 45/69] libperf: Adopt perf_mmap__mmap() function from tools/perf
Date:   Fri, 11 Oct 2019 17:05:35 -0300
Message-Id: <20191011200559.7156-46-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
index 3a19a7cb95b1..f9781de0e61e 100644
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

