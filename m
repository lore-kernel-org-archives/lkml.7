Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936BFC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E91020640
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381322;
	bh=j/7Q3v2Hz5IsH8jAP8Kr/os3GWLFcJI8alVHISyYTGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NNDi2mhsDFRMX07j9x5jHa/OX6QlsSZhaHfbFqTBdUQJZ4M15gm2Q1hlKJy0jo5Gs
	 2XSvuEn4bpl+UO/Udl231AnlvR/AMh4ntqLZu9jkRzKr9NJQtKvOFYiBKKlTFe8lNo
	 yf6L9kPBSCQqKF1oSIYPBfktv76X1VIpO7wMgTJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391048AbfIMNYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:24:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391195AbfIMNYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:24:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 80A13307D91F;
        Fri, 13 Sep 2019 13:24:37 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A0845C1D4;
        Fri, 13 Sep 2019 13:24:35 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 15/73] libperf: Add prev/start/end to struct perf_mmap
Date:   Fri, 13 Sep 2019 15:22:57 +0200
Message-Id: <20190913132355.21634-16-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 13 Sep 2019 13:24:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move prev/start/end from tools/perf's mmap to libperf's perf_mmap struct.

Link: http://lkml.kernel.org/n/tip-zkjt8cvmgevojh1tgn8yi52w@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/internal/mmap.h |  3 ++
 tools/perf/util/mmap.c                 | 50 +++++++++++++-------------
 tools/perf/util/mmap.h                 |  3 --
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index 96a8a278340c..5af28668913c 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -18,6 +18,9 @@ struct perf_mmap {
 	int		 fd;
 	int		 cpu;
 	refcount_t	 refcnt;
+	u64		 prev;
+	u64		 start;
+	u64		 end;
 };
 
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index d6406d216cfe..6ce70ff005cb 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -94,19 +94,19 @@ union perf_event *perf_mmap__read_event(struct mmap *map)
 
 	/* non-overwirte doesn't pause the ringbuffer */
 	if (!map->overwrite)
-		map->end = perf_mmap__read_head(map);
+		map->core.end = perf_mmap__read_head(map);
 
-	event = perf_mmap__read(map, &map->start, map->end);
+	event = perf_mmap__read(map, &map->core.start, map->core.end);
 
 	if (!map->overwrite)
-		map->prev = map->start;
+		map->core.prev = map->core.start;
 
 	return event;
 }
 
 static bool perf_mmap__empty(struct mmap *map)
 {
-	return perf_mmap__read_head(map) == map->prev && !map->auxtrace_mmap.base;
+	return perf_mmap__read_head(map) == map->core.prev && !map->auxtrace_mmap.base;
 }
 
 void perf_mmap__get(struct mmap *map)
@@ -125,7 +125,7 @@ void perf_mmap__put(struct mmap *map)
 void perf_mmap__consume(struct mmap *map)
 {
 	if (!map->overwrite) {
-		u64 old = map->prev;
+		u64 old = map->core.prev;
 
 		perf_mmap__write_tail(map, old);
 	}
@@ -368,7 +368,7 @@ int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 	 * perf_evlist__filter_pollfd().
 	 */
 	refcount_set(&map->core.refcnt, 2);
-	map->prev = 0;
+	map->core.prev = 0;
 	map->core.mask = mp->mask;
 	map->core.base = mmap(NULL, perf_mmap__mmap_len(map), mp->prot,
 			 MAP_SHARED, fd, 0);
@@ -443,22 +443,22 @@ static int overwrite_rb_find_range(void *buf, int mask, u64 *start, u64 *end)
 static int __perf_mmap__read_init(struct mmap *md)
 {
 	u64 head = perf_mmap__read_head(md);
-	u64 old = md->prev;
+	u64 old = md->core.prev;
 	unsigned char *data = md->core.base + page_size;
 	unsigned long size;
 
-	md->start = md->overwrite ? head : old;
-	md->end = md->overwrite ? old : head;
+	md->core.start = md->overwrite ? head : old;
+	md->core.end = md->overwrite ? old : head;
 
-	if ((md->end - md->start) < md->flush)
+	if ((md->core.end - md->core.start) < md->flush)
 		return -EAGAIN;
 
-	size = md->end - md->start;
+	size = md->core.end - md->core.start;
 	if (size > (unsigned long)(md->core.mask) + 1) {
 		if (!md->overwrite) {
 			WARN_ONCE(1, "failed to keep up with mmap data. (warn only once)\n");
 
-			md->prev = head;
+			md->core.prev = head;
 			perf_mmap__consume(md);
 			return -EAGAIN;
 		}
@@ -467,7 +467,7 @@ static int __perf_mmap__read_init(struct mmap *md)
 		 * Backward ring buffer is full. We still have a chance to read
 		 * most of data from it.
 		 */
-		if (overwrite_rb_find_range(data, md->core.mask, &md->start, &md->end))
+		if (overwrite_rb_find_range(data, md->core.mask, &md->core.start, &md->core.end))
 			return -EINVAL;
 	}
 
@@ -498,12 +498,12 @@ int perf_mmap__push(struct mmap *md, void *to,
 	if (rc < 0)
 		return (rc == -EAGAIN) ? 1 : -1;
 
-	size = md->end - md->start;
+	size = md->core.end - md->core.start;
 
-	if ((md->start & md->core.mask) + size != (md->end & md->core.mask)) {
-		buf = &data[md->start & md->core.mask];
-		size = md->core.mask + 1 - (md->start & md->core.mask);
-		md->start += size;
+	if ((md->core.start & md->core.mask) + size != (md->core.end & md->core.mask)) {
+		buf = &data[md->core.start & md->core.mask];
+		size = md->core.mask + 1 - (md->core.start & md->core.mask);
+		md->core.start += size;
 
 		if (push(md, to, buf, size) < 0) {
 			rc = -1;
@@ -511,16 +511,16 @@ int perf_mmap__push(struct mmap *md, void *to,
 		}
 	}
 
-	buf = &data[md->start & md->core.mask];
-	size = md->end - md->start;
-	md->start += size;
+	buf = &data[md->core.start & md->core.mask];
+	size = md->core.end - md->core.start;
+	md->core.start += size;
 
 	if (push(md, to, buf, size) < 0) {
 		rc = -1;
 		goto out;
 	}
 
-	md->prev = head;
+	md->core.prev = head;
 	perf_mmap__consume(md);
 out:
 	return rc;
@@ -529,8 +529,8 @@ int perf_mmap__push(struct mmap *md, void *to,
 /*
  * Mandatory for overwrite mode
  * The direction of overwrite mode is backward.
- * The last perf_mmap__read() will set tail to map->prev.
- * Need to correct the map->prev to head which is the end of next read.
+ * The last perf_mmap__read() will set tail to map->core.prev.
+ * Need to correct the map->core.prev to head which is the end of next read.
  */
 void perf_mmap__read_done(struct mmap *map)
 {
@@ -540,5 +540,5 @@ void perf_mmap__read_done(struct mmap *map)
 	if (!refcount_read(&map->core.refcnt))
 		return;
 
-	map->prev = perf_mmap__read_head(map);
+	map->core.prev = perf_mmap__read_head(map);
 }
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 117ba39f0f7a..16e4a5ca773d 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -22,9 +22,6 @@ struct aiocb;
  */
 struct mmap {
 	struct perf_mmap	core;
-	u64		 prev;
-	u64		 start;
-	u64		 end;
 	bool		 overwrite;
 	struct auxtrace_mmap auxtrace_mmap;
 	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
-- 
2.21.0

