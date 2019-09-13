Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF991C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACEB320CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381077;
	bh=UFKPpWdDVLLXdWE4Ohs5ugHPTcMMVY03uq7xtUJsIlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TAid4W5w3MeSbBoqvtnDQD6syvh+HAYAGqZ2Hfb1H58osd6EA2NzX3pE38ITe5PHN
	 HNPdV8RdseyH1YvfjyUe0mGunvvWG9Neo7swjfP5voQxJhhWoj3DOwwI5TntVM3Uaa
	 T6KRkR0aUH/MzGBLuz3TMtOC6RyG9sBLpV42y3jE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390564AbfIMNYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:24:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39502 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391166AbfIMNYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:24:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 95C8D307CDEA;
        Fri, 13 Sep 2019 13:24:29 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC0105C1D4;
        Fri, 13 Sep 2019 13:24:27 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 12/73] libperf: Add fd to struct perf_mmap
Date:   Fri, 13 Sep 2019 15:22:54 +0200
Message-Id: <20190913132355.21634-13-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 13 Sep 2019 13:24:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move fd from tools/perf's mmap to libperf's perf_mmap struct.

Link: http://lkml.kernel.org/n/tip-y7digcgafmpu8seq13mt64aw@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/internal/mmap.h | 1 +
 tools/perf/util/evlist.c               | 4 ++--
 tools/perf/util/mmap.c                 | 4 ++--
 tools/perf/util/mmap.h                 | 1 -
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index a6a464097f14..2cbe2c463c0a 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -15,6 +15,7 @@
 struct perf_mmap {
 	void		*base;
 	int		 mask;
+	int		 fd;
 };
 
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ac738b90a71f..57b117532ade 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -651,7 +651,7 @@ static int perf_evlist__set_paused(struct evlist *evlist, bool value)
 		return 0;
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
-		int fd = evlist->overwrite_mmap[i].fd;
+		int fd = evlist->overwrite_mmap[i].core.fd;
 		int err;
 
 		if (fd < 0)
@@ -707,7 +707,7 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 		return NULL;
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
-		map[i].fd = -1;
+		map[i].core.fd = -1;
 		map[i].overwrite = overwrite;
 		/*
 		 * When the perf_mmap() call is made we grab one refcount, plus
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 702e8e0b90ea..40bf124cb658 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -320,7 +320,7 @@ void perf_mmap__munmap(struct mmap *map)
 	if (map->core.base != NULL) {
 		munmap(map->core.base, perf_mmap__mmap_len(map));
 		map->core.base = NULL;
-		map->fd = -1;
+		map->core.fd = -1;
 		refcount_set(&map->refcnt, 0);
 	}
 	auxtrace_mmap__munmap(&map->auxtrace_mmap);
@@ -378,7 +378,7 @@ int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 		map->core.base = NULL;
 		return -1;
 	}
-	map->fd = fd;
+	map->core.fd = fd;
 	map->cpu = cpu;
 
 	perf_mmap__setup_affinity_mask(map, mp);
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index a6e60596f889..6eb7a4c6b14a 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -22,7 +22,6 @@ struct aiocb;
  */
 struct mmap {
 	struct perf_mmap	core;
-	int		 fd;
 	int		 cpu;
 	refcount_t	 refcnt;
 	u64		 prev;
-- 
2.21.0

