Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98C2C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD67C222C1
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458080;
	bh=p5dDMFunpyUJSmcDZ0TJqSfT7AiHaHT7q+vDqtOm/JE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bHTeC3REfN8Mmozr/V+/9jmdABu3d2lX9Z83Uo0YQnkCz8+UcEEl7oA/55KEbPmK+
	 OSQVROOxVtg1siWXM44X2cSDQ+5HeaHUR4M0AuGddIZnFw9EnOrlK3Ye0ahlDSH3ZO
	 mE24Oy9aqdGd4cEFaJx0JU86GGvWtV0HYSQ0rudY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388767AbfIZAej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:34:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388701AbfIZAeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:34:36 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B09D7222C2;
        Thu, 26 Sep 2019 00:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458075;
        bh=p5dDMFunpyUJSmcDZ0TJqSfT7AiHaHT7q+vDqtOm/JE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m38SWscGwlABPf1RQlhJ5L/xmTxef8v7qiML1A31Wi2zVxzAq2/YmkW1IwEu63ejE
         CnhOlL9ejB87g51byDS2RioOa6J7hKO4glYUjk0ueFxSrLiXuXTcC1jQ1kkYkNv+aC
         k5rGDSAKinehtpY5IO4Chf8Ye5/PZj1BmssSs53Y=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 26/66] libperf: Add 'cpu' to struct perf_mmap
Date:   Wed, 25 Sep 2019 21:32:04 -0300
Message-Id: <20190926003244.13962-27-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move 'cpu' from tools/perf's mmap to libperf's perf_mmap struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-14-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/mmap.h | 1 +
 tools/perf/util/mmap.c                 | 8 ++++----
 tools/perf/util/mmap.h                 | 1 -
 tools/perf/util/python.c               | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index 892cbd401d8d..f7d1809fa34c 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -11,6 +11,7 @@ struct perf_mmap {
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
index de991194af8d..8ab779c98f4d 100644
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
index 60a6b6e8e176..ba4085d7ae9f 100644
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

