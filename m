Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A06CC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C7E20717
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381080;
	bh=S+nbkXZSsduLCeLOVKbJklHTCOtPERMFqQELFnS9Zc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vPxJEiSU3IbjO9dmsS6HzgOIpIZZeSceNOvfNA2c4NAPr4qnoUzMV3GFXPstezIQo
	 JnRihn1Y3PT+8Rwx2X2ISbyrRcPXiSMc7zwDw8Wlc5qGTqBbtz/WUk0hZOOcXJ1VU8
	 g6kMHK9EdlzFaMSWJNwwRsiJ+btv3OA6DO5gZX8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391201AbfIMNYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:24:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35828 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391175AbfIMNYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:24:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C8BF307CB3F;
        Fri, 13 Sep 2019 13:24:31 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFADB5C219;
        Fri, 13 Sep 2019 13:24:29 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 13/73] libperf: Add cpu to struct perf_mmap
Date:   Fri, 13 Sep 2019 15:22:55 +0200
Message-Id: <20190913132355.21634-14-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 13 Sep 2019 13:24:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move cpu from tools/perf's mmap to libperf's perf_mmap struct.

Link: http://lkml.kernel.org/n/tip-e98u3vvj1ch8rvrvg53gs8nk@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/internal/mmap.h | 1 +
 tools/perf/util/mmap.c                 | 8 ++++----
 tools/perf/util/mmap.h                 | 1 -
 tools/perf/util/python.c               | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index 2cbe2c463c0a..153348724bf3 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -16,6 +16,7 @@ struct perf_mmap {
 	void		*base;
 	int		 mask;
 	int		 fd;
+	int		 cpu;
 };
 
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 40bf124cb658..dc8320891344 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -256,7 +256,7 @@ static int perf_mmap__aio_mmap(struct mmap *map, struct mmap_params *mp)
 				pr_debug2("failed to allocate data buffer area, error %m");
 				return -1;
 			}
-			ret = perf_mmap__aio_bind(map, i, map->cpu, mp->affinity);
+			ret = perf_mmap__aio_bind(map, i, map->core.cpu, mp->affinity);
 			if (ret == -1)
 				return -1;
 			/*
@@ -347,9 +347,9 @@ static void perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params
 {
 	CPU_ZERO(&map->affinity_mask);
 	if (mp->affinity == PERF_AFFINITY_NODE && cpu__max_node() > 1)
-		build_node_mask(cpu__get_node(map->cpu), &map->affinity_mask);
+		build_node_mask(cpu__get_node(map->core.cpu), &map->affinity_mask);
 	else if (mp->affinity == PERF_AFFINITY_CPU)
-		CPU_SET(map->cpu, &map->affinity_mask);
+		CPU_SET(map->core.cpu, &map->affinity_mask);
 }
 
 int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
@@ -379,7 +379,7 @@ int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 		return -1;
 	}
 	map->core.fd = fd;
-	map->cpu = cpu;
+	map->core.cpu = cpu;
 
 	perf_mmap__setup_affinity_mask(map, mp);
 
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 6eb7a4c6b14a..bab46642e639 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -22,7 +22,6 @@ struct aiocb;
  */
 struct mmap {
 	struct perf_mmap	core;
-	int		 cpu;
 	refcount_t	 refcnt;
 	u64		 prev;
 	u64		 start;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 7e28f7e18d41..96100ed73dbe 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -991,7 +991,7 @@ static struct mmap *get_md(struct evlist *evlist, int cpu)
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		struct mmap *md = &evlist->mmap[i];
 
-		if (md->cpu == cpu)
+		if (md->core.cpu == cpu)
 			return md;
 	}
 
-- 
2.21.0

