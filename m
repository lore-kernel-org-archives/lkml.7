Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0C3C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623CE20640
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381329;
	bh=WCj7s8xZAyaMhoBLqyCOGzPjTpJM19qnkFdfpmSJV8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EbOB4+rLU2Ry+fiHGA7sLMFbwXTTT6bxrl/FdPNlXWBC6szm4yR3AfDK4zuCe2S7d
	 wOzXoKEas8Giratk/MGiQC9XCuuNbRX+bPgKjcU4x3XwgpfsWE9pJaHNKtuTYoM4To
	 hemJk8kzoLyx8wGbX0L+OaKUzFU9Dfn1DsnIX+NA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391404AbfIMN2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:28:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391158AbfIMNYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:24:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E2E63082E72;
        Fri, 13 Sep 2019 13:24:35 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D85D75C1D4;
        Fri, 13 Sep 2019 13:24:31 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 14/73] libperf: Add refcnt to struct perf_mmap
Date:   Fri, 13 Sep 2019 15:22:56 +0200
Message-Id: <20190913132355.21634-15-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 13 Sep 2019 13:24:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move refcnt from tools/perf's mmap to libperf's perf_mmap struct.

Link: http://lkml.kernel.org/n/tip-re5o204iamdxla8iw277b301@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/internal/mmap.h |  1 +
 tools/perf/util/evlist.c               |  2 +-
 tools/perf/util/mmap.c                 | 18 +++++++++---------
 tools/perf/util/mmap.h                 |  1 -
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index 153348724bf3..96a8a278340c 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -17,6 +17,7 @@ struct perf_mmap {
 	int		 mask;
 	int		 fd;
 	int		 cpu;
+	refcount_t	 refcnt;
 };
 
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 57b117532ade..f6e0bceec156 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -718,7 +718,7 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 		 * Each PERF_EVENT_IOC_SET_OUTPUT points to this mmap and
 		 * thus does perf_mmap__get() on it.
 		 */
-		refcount_set(&map[i].refcnt, 0);
+		refcount_set(&map[i].core.refcnt, 0);
 	}
 	return map;
 }
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index dc8320891344..d6406d216cfe 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -89,7 +89,7 @@ union perf_event *perf_mmap__read_event(struct mmap *map)
 	/*
 	 * Check if event was unmapped due to a POLLHUP/POLLERR.
 	 */
-	if (!refcount_read(&map->refcnt))
+	if (!refcount_read(&map->core.refcnt))
 		return NULL;
 
 	/* non-overwirte doesn't pause the ringbuffer */
@@ -111,14 +111,14 @@ static bool perf_mmap__empty(struct mmap *map)
 
 void perf_mmap__get(struct mmap *map)
 {
-	refcount_inc(&map->refcnt);
+	refcount_inc(&map->core.refcnt);
 }
 
 void perf_mmap__put(struct mmap *map)
 {
-	BUG_ON(map->core.base && refcount_read(&map->refcnt) == 0);
+	BUG_ON(map->core.base && refcount_read(&map->core.refcnt) == 0);
 
-	if (refcount_dec_and_test(&map->refcnt))
+	if (refcount_dec_and_test(&map->core.refcnt))
 		perf_mmap__munmap(map);
 }
 
@@ -130,7 +130,7 @@ void perf_mmap__consume(struct mmap *map)
 		perf_mmap__write_tail(map, old);
 	}
 
-	if (refcount_read(&map->refcnt) == 1 && perf_mmap__empty(map))
+	if (refcount_read(&map->core.refcnt) == 1 && perf_mmap__empty(map))
 		perf_mmap__put(map);
 }
 
@@ -321,7 +321,7 @@ void perf_mmap__munmap(struct mmap *map)
 		munmap(map->core.base, perf_mmap__mmap_len(map));
 		map->core.base = NULL;
 		map->core.fd = -1;
-		refcount_set(&map->refcnt, 0);
+		refcount_set(&map->core.refcnt, 0);
 	}
 	auxtrace_mmap__munmap(&map->auxtrace_mmap);
 }
@@ -367,7 +367,7 @@ int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 	 * evlist layer can't just drop it when filtering events in
 	 * perf_evlist__filter_pollfd().
 	 */
-	refcount_set(&map->refcnt, 2);
+	refcount_set(&map->core.refcnt, 2);
 	map->prev = 0;
 	map->core.mask = mp->mask;
 	map->core.base = mmap(NULL, perf_mmap__mmap_len(map), mp->prot,
@@ -479,7 +479,7 @@ int perf_mmap__read_init(struct mmap *map)
 	/*
 	 * Check if event was unmapped due to a POLLHUP/POLLERR.
 	 */
-	if (!refcount_read(&map->refcnt))
+	if (!refcount_read(&map->core.refcnt))
 		return -ENOENT;
 
 	return __perf_mmap__read_init(map);
@@ -537,7 +537,7 @@ void perf_mmap__read_done(struct mmap *map)
 	/*
 	 * Check if event was unmapped due to a POLLHUP/POLLERR.
 	 */
-	if (!refcount_read(&map->refcnt))
+	if (!refcount_read(&map->core.refcnt))
 		return;
 
 	map->prev = perf_mmap__read_head(map);
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index bab46642e639..117ba39f0f7a 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -22,7 +22,6 @@ struct aiocb;
  */
 struct mmap {
 	struct perf_mmap	core;
-	refcount_t	 refcnt;
 	u64		 prev;
 	u64		 start;
 	u64		 end;
-- 
2.21.0

