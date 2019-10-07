Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C036ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497B420867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570452846;
	bh=Pwq4kbUMYf06x53SIx85vT1lqTfdTKgmTTNlNkoiNsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dnREYrgUzogNx1lHwVBQy0pd/+BTJJD9QST/n1TKCJC+1+SF3NqCRQrUdZA5U5qgA
	 Mb2RBN571rpPKyyX/MqTKq/bT3va8Ip7xfe5KcAxBsLdHrwVRAe1rKkm35+/nJNwPP
	 eMexP+8yXaim9cBBjjM92o9/KykUfHHRm6WV3hio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfJGMyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:54:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728073AbfJGMyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:54:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D1E713001FEB;
        Mon,  7 Oct 2019 12:54:01 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 396185D9CC;
        Mon,  7 Oct 2019 12:54:00 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 07/36] libperf: Add perf_mmap__put() function
Date:   Mon,  7 Oct 2019 14:53:15 +0200
Message-Id: <20191007125344.14268-8-jolsa@kernel.org>
In-Reply-To: <20191007125344.14268-1-jolsa@kernel.org>
References: <20191007125344.14268-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 07 Oct 2019 12:54:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move perf_mmap__put() from tools/perf to libperf.

Once perf_mmap__put() is moved, we need a way to call application related
unmap code (AIO and aux related code for eprf), when the map goes away.

Add the perf_mmap::unmap callback to do that.

The unmap path from perf is:

  perf_mmap__put                           (libperf)
    perf_mmap__munmap                      (libperf)
      map->unmap_cb -> perf_mmap__unmap_cb (perf)
        mmap__munmap                       (perf)

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-46-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c            |  4 ++--
 tools/perf/lib/include/internal/mmap.h | 31 ++++++++++++++++----------
 tools/perf/lib/mmap.c                  | 14 +++++++++++-
 tools/perf/util/evlist.c               | 17 +++++++++-----
 tools/perf/util/mmap.c                 | 11 +--------
 tools/perf/util/mmap.h                 |  2 --
 6 files changed, 47 insertions(+), 32 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 025a12b57325..2fb83aabbef5 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -197,7 +197,7 @@ static int record__aio_complete(struct mmap *md, struct aiocb *cblock)
 		 * every aio write request started in record__aio_push() so
 		 * decrement it because the request is now complete.
 		 */
-		perf_mmap__put(md);
+		perf_mmap__put(&md->core);
 		rc = 1;
 	} else {
 		/*
@@ -332,7 +332,7 @@ static int record__aio_push(struct record *rec, struct mmap *map, off_t *off)
 		 * map->refcount is decremented in record__aio_complete() after
 		 * aio write operation finishes successfully.
 		 */
-		perf_mmap__put(map);
+		perf_mmap__put(&map->core);
 	}
 
 	return ret;
diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index 5c2ca9ab12cd..bf9cc7d005ab 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -10,23 +10,28 @@
 /* perf sample has 16 bits size limit */
 #define PERF_SAMPLE_MAX_SIZE (1 << 16)
 
+struct perf_mmap;
+
+typedef void (*libperf_unmap_cb_t)(struct perf_mmap *map);
+
 /**
  * struct perf_mmap - perf's ring buffer mmap details
  *
  * @refcnt - e.g. code using PERF_EVENT_IOC_SET_OUTPUT to share this
  */
 struct perf_mmap {
-	void		*base;
-	int		 mask;
-	int		 fd;
-	int		 cpu;
-	refcount_t	 refcnt;
-	u64		 prev;
-	u64		 start;
-	u64		 end;
-	bool		 overwrite;
-	u64		 flush;
-	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
+	void			*base;
+	int			 mask;
+	int			 fd;
+	int			 cpu;
+	refcount_t		 refcnt;
+	u64			 prev;
+	u64			 start;
+	u64			 end;
+	bool			 overwrite;
+	u64			 flush;
+	libperf_unmap_cb_t	 unmap_cb;
+	char			 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
 };
 
 struct perf_mmap_param {
@@ -36,10 +41,12 @@ struct perf_mmap_param {
 
 size_t perf_mmap__mmap_len(struct perf_mmap *map);
 
-void perf_mmap__init(struct perf_mmap *map, bool overwrite);
+void perf_mmap__init(struct perf_mmap *map, bool overwrite,
+		     libperf_unmap_cb_t unmap_cb);
 int perf_mmap__mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
 		    int fd, int cpu);
 void perf_mmap__munmap(struct perf_mmap *map);
 void perf_mmap__get(struct perf_mmap *map);
+void perf_mmap__put(struct perf_mmap *map);
 
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/lib/mmap.c b/tools/perf/lib/mmap.c
index 6eb228d89206..ea46f325fa98 100644
--- a/tools/perf/lib/mmap.c
+++ b/tools/perf/lib/mmap.c
@@ -3,10 +3,12 @@
 #include <internal/mmap.h>
 #include <internal/lib.h>
 
-void perf_mmap__init(struct perf_mmap *map, bool overwrite)
+void perf_mmap__init(struct perf_mmap *map, bool overwrite,
+		     libperf_unmap_cb_t unmap_cb)
 {
 	map->fd = -1;
 	map->overwrite = overwrite;
+	map->unmap_cb  = unmap_cb;
 	refcount_set(&map->refcnt, 0);
 }
 
@@ -40,9 +42,19 @@ void perf_mmap__munmap(struct perf_mmap *map)
 		map->fd = -1;
 		refcount_set(&map->refcnt, 0);
 	}
+	if (map && map->unmap_cb)
+		map->unmap_cb(map);
 }
 
 void perf_mmap__get(struct perf_mmap *map)
 {
 	refcount_inc(&map->refcnt);
 }
+
+void perf_mmap__put(struct perf_mmap *map)
+{
+	BUG_ON(map->base && refcount_read(&map->refcnt) == 0);
+
+	if (refcount_dec_and_test(&map->refcnt))
+		perf_mmap__munmap(map);
+}
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 2e5eaac6325e..bcfe0d1b6e63 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -409,7 +409,7 @@ static void perf_evlist__munmap_filtered(struct fdarray *fda, int fd,
 	struct mmap *map = fda->priv[fd].ptr;
 
 	if (map)
-		perf_mmap__put(map);
+		perf_mmap__put(&map->core);
 }
 
 int evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask)
@@ -577,11 +577,11 @@ static void evlist__munmap_nofree(struct evlist *evlist)
 
 	if (evlist->mmap)
 		for (i = 0; i < evlist->core.nr_mmaps; i++)
-			mmap__munmap(&evlist->mmap[i]);
+			perf_mmap__munmap(&evlist->mmap[i].core);
 
 	if (evlist->overwrite_mmap)
 		for (i = 0; i < evlist->core.nr_mmaps; i++)
-			mmap__munmap(&evlist->overwrite_mmap[i]);
+			perf_mmap__munmap(&evlist->overwrite_mmap[i].core);
 }
 
 void evlist__munmap(struct evlist *evlist)
@@ -591,6 +591,13 @@ void evlist__munmap(struct evlist *evlist)
 	zfree(&evlist->overwrite_mmap);
 }
 
+static void perf_mmap__unmap_cb(struct perf_mmap *map)
+{
+	struct mmap *m = container_of(map, struct mmap, core);
+
+	mmap__munmap(m);
+}
+
 static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 				       bool overwrite)
 {
@@ -614,7 +621,7 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 		 * Each PERF_EVENT_IOC_SET_OUTPUT points to this mmap and
 		 * thus does perf_mmap__get() on it.
 		 */
-		perf_mmap__init(&map[i].core, overwrite);
+		perf_mmap__init(&map[i].core, overwrite, perf_mmap__unmap_cb);
 	}
 
 	return map;
@@ -691,7 +698,7 @@ static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 		 */
 		if (!evsel->core.system_wide &&
 		     perf_evlist__add_pollfd(&evlist->core, fd, &maps[idx], revent) < 0) {
-			perf_mmap__put(&maps[idx]);
+			perf_mmap__put(&maps[idx].core);
 			return -1;
 		}
 
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 2c73b5bcf74e..9f150d50cea5 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -110,14 +110,6 @@ static bool perf_mmap__empty(struct mmap *map)
 	return perf_mmap__read_head(map) == map->core.prev && !map->auxtrace_mmap.base;
 }
 
-void perf_mmap__put(struct mmap *map)
-{
-	BUG_ON(map->core.base && refcount_read(&map->core.refcnt) == 0);
-
-	if (refcount_dec_and_test(&map->core.refcnt))
-		mmap__munmap(map);
-}
-
 void perf_mmap__consume(struct mmap *map)
 {
 	if (!map->core.overwrite) {
@@ -127,7 +119,7 @@ void perf_mmap__consume(struct mmap *map)
 	}
 
 	if (refcount_read(&map->core.refcnt) == 1 && perf_mmap__empty(map))
-		perf_mmap__put(map);
+		perf_mmap__put(&map->core);
 }
 
 int __weak auxtrace_mmap__mmap(struct auxtrace_mmap *mm __maybe_unused,
@@ -308,7 +300,6 @@ static void perf_mmap__aio_munmap(struct mmap *map __maybe_unused)
 
 void mmap__munmap(struct mmap *map)
 {
-	perf_mmap__munmap(&map->core);
 	perf_mmap__aio_munmap(map);
 	if (map->data != NULL) {
 		munmap(map->data, mmap__mmap_len(map));
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 6a18b2990059..78e3c4436ce8 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -45,8 +45,6 @@ struct mmap_params {
 int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu);
 void mmap__munmap(struct mmap *map);
 
-void perf_mmap__put(struct mmap *map);
-
 void perf_mmap__consume(struct mmap *map);
 
 static inline u64 perf_mmap__read_head(struct mmap *mm)
-- 
2.21.0

