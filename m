Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB79EC4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F2A206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381148;
	bh=w2mSwgQ4MPsC5RyfKosW9XcE3D8ISonTkxw4RWtsuj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BIIWY5R+wOipF5sXfj4MqnAil9YW+Xl0bznB2RaeoOphyJa/cpb+B1wrjESfWz+Uy
	 IKbTg8uGk7SI5YMyTaNrl7HttnSFoeIWreU1ccrwUU+1/OuZh3ogXBpgAaAtcKU3zP
	 +8SMQKvSqN2KVO0BDsPyaRhvUb8dbuZaWknDXxws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391436AbfIMNZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:25:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37480 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391419AbfIMNZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:25:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1614011A1F;
        Fri, 13 Sep 2019 13:25:43 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D3EF5C1D4;
        Fri, 13 Sep 2019 13:25:41 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 42/73] libperf: Add perf_mmap__mmap function
Date:   Fri, 13 Sep 2019 15:23:24 +0200
Message-Id: <20190913132355.21634-43-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 13 Sep 2019 13:25:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move perf_mmap__mmap function under libperf,
it will be used in following patches. And rename
the existing perf's function to mmap__mmap.

Link: http://lkml.kernel.org/n/tip-ze68z5bxg5d76983b63vf54m@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/internal/mmap.h |  2 ++
 tools/perf/lib/mmap.c                  | 18 ++++++++++++++++++
 tools/perf/util/evlist.c               |  2 +-
 tools/perf/util/mmap.c                 | 12 +++---------
 tools/perf/util/mmap.h                 |  2 +-
 5 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index 45ab791aa392..5452ed7dabfe 100644
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
index c0c0882dc343..8da573307734 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -670,7 +670,7 @@ static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 		if (*output == -1) {
 			*output = fd;
 
-			if (perf_mmap__mmap(&maps[idx], mp, *output, evlist_cpu) < 0)
+			if (mmap__mmap(&maps[idx], mp, *output, evlist_cpu) < 0)
 				return -1;
 		} else {
 			if (ioctl(fd, PERF_EVENT_IOC_SET_OUTPUT, *output) != 0)
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 4e2ef633d425..7096e9b130cd 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -352,7 +352,7 @@ static void perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params
 		CPU_SET(map->core.cpu, &map->affinity_mask);
 }
 
-int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
+int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 {
 	/*
 	 * The last one will be done at perf_mmap__consume(), so that we
@@ -368,18 +368,12 @@ int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
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
index 308492a59ea1..aeb94d128354 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -70,7 +70,7 @@ struct mmap_params {
 	struct auxtrace_mmap_params auxtrace_mp;
 };
 
-int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu);
+int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu);
 void perf_mmap__munmap(struct mmap *map);
 
 void perf_mmap__get(struct mmap *map);
-- 
2.21.0

