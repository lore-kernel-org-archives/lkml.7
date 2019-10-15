Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3089ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BE721835
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbfJOFcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:32:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41952 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbfJOFbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:31:55 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFQv-00008c-C4; Tue, 15 Oct 2019 07:31:45 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8FE021C04D0;
        Tue, 15 Oct 2019 07:31:40 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:40 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Adopt perf_mmap__put() function from tools/perf
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191007125344.14268-8-jolsa@kernel.org>
References: <20191007125344.14268-8-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <157111750050.12254.2005571943584191914.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     80e53d1148231d7d4fdc4cd89e5393616b33bf82
Gitweb:        https://git.kernel.org/tip/80e53d1148231d7d4fdc4cd89e5393616b33bf82
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Mon, 07 Oct 2019 14:53:15 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 10 Oct 2019 10:09:25 -03:00

libperf: Adopt perf_mmap__put() function from tools/perf

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
 tools/perf/builtin-record.c            |  4 +--
 tools/perf/lib/include/internal/mmap.h | 31 +++++++++++++++----------
 tools/perf/lib/mmap.c                  | 15 +++++++++++-
 tools/perf/util/evlist.c               | 17 +++++++++-----
 tools/perf/util/mmap.c                 | 11 +---------
 tools/perf/util/mmap.h                 |  2 +--
 6 files changed, 48 insertions(+), 32 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 025a12b..2fb83aa 100644
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
index 5c2ca9a..bf9cc7d 100644
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
index 6eb228d..89c1e0e 100644
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
index 0b877d3..4394a5a 100644
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
index 2c73b5b..9f150d5 100644
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
index 6a18b29..78e3c44 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -45,8 +45,6 @@ struct mmap_params {
 int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu);
 void mmap__munmap(struct mmap *map);
 
-void perf_mmap__put(struct mmap *map);
-
 void perf_mmap__consume(struct mmap *map);
 
 static inline u64 perf_mmap__read_head(struct mmap *mm)
