Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32B0ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CC521D56
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824641;
	bh=H/gFuf3AcruOMB86B80fCiKimKs2SYZn0Kcso+oAbjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qCfyKZ0UQUwsByR+NlGDcUxy8qGfjLr7Ptv/3x9KzI1j1a0g/WMjpHwaP2pCww+EG
	 XJ1nYtzOSVV7X3fbAiU5ZwoCIoPPp/CFsiW5jn1CUDY4N4feBTuy57OpZNltM27WM1
	 WcpHyXOWzir9jaC277W06fDfiFmKF++1dOzDTkBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbfJKUKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:10:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:46484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729677AbfJKUKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:10:37 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A8902247A;
        Fri, 11 Oct 2019 20:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824636;
        bh=H/gFuf3AcruOMB86B80fCiKimKs2SYZn0Kcso+oAbjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vc+VjnDbpKyhba0tiGjocgbp/QeYR+HyH7bbDOaA8UDWh6oHaN5u135jawWt6ritK
         6r9DacW7A0Fh0a1l4nFMzdakGKXk99H/JauqlFKbrI42OrTaflBxY+0LeqtNOhTXW7
         CeIQgS9FvEknK71WOrshhlRp5C1YT+Y/d4icPl7Y=
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
Subject: [PATCH 48/69] libperf: Adopt perf_mmap__put() function from tools/perf
Date:   Fri, 11 Oct 2019 17:05:38 -0300
Message-Id: <20191011200559.7156-49-acme@kernel.org>
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

Move perf_mmap__put() from tools/perf to libperf.

Once perf_mmap__put() is moved, we need a way to call application
related unmap code (AIO and aux related code for eprf), when the map
goes away.

Add the perf_mmap::unmap callback to do that.

The unmap path from perf is:

  perf_mmap__put                           (libperf)
    perf_mmap__munmap                      (libperf)
      map->unmap_cb -> perf_mmap__unmap_cb (perf)
        mmap__munmap                       (perf)

Committer notes:

Add missing linux/kernel.h to tools/perf/lib/mmap.c to get the BUG_ON
definition.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c            |  4 ++--
 tools/perf/lib/include/internal/mmap.h | 31 ++++++++++++++++----------
 tools/perf/lib/mmap.c                  | 15 ++++++++++++-
 tools/perf/util/evlist.c               | 17 +++++++++-----
 tools/perf/util/mmap.c                 | 11 +--------
 tools/perf/util/mmap.h                 |  2 --
 6 files changed, 48 insertions(+), 32 deletions(-)

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
index 6eb228d89206..89c1e0e8b897 100644
--- a/tools/perf/lib/mmap.c
+++ b/tools/perf/lib/mmap.c
@@ -2,11 +2,14 @@
 #include <sys/mman.h>
 #include <internal/mmap.h>
 #include <internal/lib.h>
+#include <linux/kernel.h>
 
-void perf_mmap__init(struct perf_mmap *map, bool overwrite)
+void perf_mmap__init(struct perf_mmap *map, bool overwrite,
+		     libperf_unmap_cb_t unmap_cb)
 {
 	map->fd = -1;
 	map->overwrite = overwrite;
+	map->unmap_cb  = unmap_cb;
 	refcount_set(&map->refcnt, 0);
 }
 
@@ -40,9 +43,19 @@ void perf_mmap__munmap(struct perf_mmap *map)
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
index 0b877d39a660..4394a5a10ce9 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -433,7 +433,7 @@ static void perf_evlist__munmap_filtered(struct fdarray *fda, int fd,
 	struct mmap *map = fda->priv[fd].ptr;
 
 	if (map)
-		perf_mmap__put(map);
+		perf_mmap__put(&map->core);
 }
 
 int evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask)
@@ -601,11 +601,11 @@ static void evlist__munmap_nofree(struct evlist *evlist)
 
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
@@ -615,6 +615,13 @@ void evlist__munmap(struct evlist *evlist)
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
@@ -638,7 +645,7 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 		 * Each PERF_EVENT_IOC_SET_OUTPUT points to this mmap and
 		 * thus does perf_mmap__get() on it.
 		 */
-		perf_mmap__init(&map[i].core, overwrite);
+		perf_mmap__init(&map[i].core, overwrite, perf_mmap__unmap_cb);
 	}
 
 	return map;
@@ -715,7 +722,7 @@ static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
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

