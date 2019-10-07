Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F64DECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6794021D6C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570452895;
	bh=QFNCIrkTXDmXyOc/3L18eV24WX4hBDkCJ7GU4jlyiQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YnJ8gv7Gl/dzZ6JSSAs0g1yf7BnDj31mjW0Gs3+IvYqNDklboaDRnVHqhYaYnqaeY
	 0MMGxTQZDuW1EpBFfsjdxOFO/1A7iALikwRtJlol23LBC477HTDbi7CGFJNU5cxMzx
	 7IiI0xQCqQmmu6XmxRS4z/acoxArxcV2/mSsNf+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfJGMyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:54:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42878 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728372AbfJGMyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:54:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 843937F752;
        Mon,  7 Oct 2019 12:54:51 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CCD65D9CC;
        Mon,  7 Oct 2019 12:54:49 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 27/36] libperf: Add perf_evlist__for_each_mmap function
Date:   Mon,  7 Oct 2019 14:53:35 +0200
Message-Id: <20191007125344.14268-28-jolsa@kernel.org>
In-Reply-To: <20191007125344.14268-1-jolsa@kernel.org>
References: <20191007125344.14268-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Mon, 07 Oct 2019 12:54:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_evlist__for_each_mmap function and exporting
it in perf/evlist.h header, so user can iterate through
'struct perf_mmap' objects.

Adding internal perf_mmap__link function to do the actual
linking.

Link: http://lkml.kernel.org/n/tip-5h62ytvpxgozhqix2y41cvex@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evlist.c                  | 26 +++++++++++++++++++++++-
 tools/perf/lib/include/internal/evlist.h |  2 ++
 tools/perf/lib/include/internal/mmap.h   |  5 +++--
 tools/perf/lib/include/perf/evlist.h     |  9 ++++++++
 tools/perf/lib/libperf.map               |  1 +
 tools/perf/lib/mmap.c                    |  6 ++++--
 tools/perf/util/evlist.c                 |  4 +++-
 7 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 65045614c938..4e85d9bb92bf 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -347,6 +347,8 @@ static struct perf_mmap* perf_evlist__alloc_mmap(struct perf_evlist *evlist, boo
 		return NULL;
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
+		struct perf_mmap *prev = i ? &map[i - 1] : NULL;
+
 		/*
 		 * When the perf_mmap() call is made we grab one refcount, plus
 		 * one extra to let perf_mmap__consume() get the last
@@ -356,7 +358,7 @@ static struct perf_mmap* perf_evlist__alloc_mmap(struct perf_evlist *evlist, boo
 		 * Each PERF_EVENT_IOC_SET_OUTPUT points to this mmap and
 		 * thus does perf_mmap__get() on it.
 		 */
-		perf_mmap__init(&map[i], overwrite, NULL);
+		perf_mmap__init(&map[i], prev, overwrite, NULL);
 	}
 
 	return map;
@@ -405,6 +407,15 @@ perf_evlist__mmap_cb_mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
 	return perf_mmap__mmap(map, mp, output, cpu);
 }
 
+static void perf_evlist__set_mmap0(struct perf_evlist *evlist, struct perf_mmap *map,
+				   bool overwrite)
+{
+	if (overwrite)
+		evlist->mmap_ovw0 = map;
+	else
+		evlist->mmap0 = map;
+}
+
 static int
 mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 	       int idx, struct perf_mmap_param *mp, int cpu_idx,
@@ -460,6 +471,9 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 
 			if (ops->mmap(map, mp, *output, evlist_cpu) < 0)
 				return -1;
+
+			if (!idx)
+				perf_evlist__set_mmap0(evlist, map, overwrite);
 		} else {
 			if (ioctl(fd, PERF_EVENT_IOC_SET_OUTPUT, *output) != 0)
 				return -1;
@@ -605,3 +619,13 @@ void perf_evlist__munmap(struct perf_evlist *evlist)
 	zfree(&evlist->mmap);
 	zfree(&evlist->mmap_ovw);
 }
+
+struct perf_mmap*
+perf_evlist__next_mmap(struct perf_evlist *evlist, struct perf_mmap *map,
+		       bool overwrite)
+{
+	if (map)
+		return map->next;
+
+	return overwrite ? evlist->mmap_ovw0 : evlist->mmap0;
+}
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index be0b25a70730..513a85cb7bfe 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -25,6 +25,8 @@ struct perf_evlist {
 	struct hlist_head	 heads[PERF_EVLIST__HLIST_SIZE];
 	struct perf_mmap	*mmap;
 	struct perf_mmap	*mmap_ovw;
+	struct perf_mmap	*mmap0;
+	struct perf_mmap	*mmap_ovw0;
 };
 
 typedef void
diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index b328332b6ccf..f5b4f902b453 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -33,6 +33,7 @@ struct perf_mmap {
 	u64			 flush;
 	libperf_unmap_cb_t	 unmap_cb;
 	char			 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
+	struct perf_mmap	*next;
 };
 
 struct perf_mmap_param {
@@ -42,8 +43,8 @@ struct perf_mmap_param {
 
 size_t perf_mmap__mmap_len(struct perf_mmap *map);
 
-void perf_mmap__init(struct perf_mmap *map, bool overwrite,
-		     libperf_unmap_cb_t unmap_cb);
+void perf_mmap__init(struct perf_mmap *map, struct perf_mmap *prev,
+		     bool overwrite, libperf_unmap_cb_t unmap_cb);
 int perf_mmap__mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
 		    int fd, int cpu);
 void perf_mmap__munmap(struct perf_mmap *map);
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
index 16f526e74d13..8c4b3c28535e 100644
--- a/tools/perf/lib/include/perf/evlist.h
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -3,6 +3,7 @@
 #define __LIBPERF_EVLIST_H
 
 #include <perf/core.h>
+#include <stdbool.h>
 
 struct perf_evlist;
 struct perf_evsel;
@@ -38,4 +39,12 @@ LIBPERF_API int perf_evlist__filter_pollfd(struct perf_evlist *evlist,
 LIBPERF_API int perf_evlist__mmap(struct perf_evlist *evlist, int pages);
 LIBPERF_API void perf_evlist__munmap(struct perf_evlist *evlist);
 
+LIBPERF_API struct perf_mmap *perf_evlist__next_mmap(struct perf_evlist *evlist,
+						     struct perf_mmap *map,
+						     bool overwrite);
+#define perf_evlist__for_each_mmap(evlist, pos, overwrite)		\
+	for ((pos) = perf_evlist__next_mmap((evlist), NULL, overwrite);	\
+	     (pos) != NULL;						\
+	     (pos) = perf_evlist__next_mmap((evlist), (pos), overwrite))
+
 #endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 2184aba36c3f..8be02afc324b 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -43,6 +43,7 @@ LIBPERF_0.0.1 {
 		perf_evlist__mmap;
 		perf_evlist__munmap;
 		perf_evlist__filter_pollfd;
+		perf_evlist__next_mmap;
 		perf_mmap__consume;
 		perf_mmap__read_init;
 		perf_mmap__read_done;
diff --git a/tools/perf/lib/mmap.c b/tools/perf/lib/mmap.c
index fe9e1b095fd7..fe7e9ef8a68c 100644
--- a/tools/perf/lib/mmap.c
+++ b/tools/perf/lib/mmap.c
@@ -12,13 +12,15 @@
 #include <internal/lib.h>
 #include "internal.h"
 
-void perf_mmap__init(struct perf_mmap *map, bool overwrite,
-		     libperf_unmap_cb_t unmap_cb)
+void perf_mmap__init(struct perf_mmap *map, struct perf_mmap *prev,
+		     bool overwrite, libperf_unmap_cb_t unmap_cb)
 {
 	map->fd = -1;
 	map->overwrite = overwrite;
 	map->unmap_cb  = unmap_cb;
 	refcount_set(&map->refcnt, 0);
+	if (prev)
+		prev->next = map;
 }
 
 size_t perf_mmap__mmap_len(struct perf_mmap *map)
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 4910ae711b13..469a5476ef1a 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -582,6 +582,8 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 		return NULL;
 
 	for (i = 0; i < evlist->core.nr_mmaps; i++) {
+		struct perf_mmap *prev = i ? &map[i - 1].core : NULL;
+
 		/*
 		 * When the perf_mmap() call is made we grab one refcount, plus
 		 * one extra to let perf_mmap__consume() get the last
@@ -591,7 +593,7 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 		 * Each PERF_EVENT_IOC_SET_OUTPUT points to this mmap and
 		 * thus does perf_mmap__get() on it.
 		 */
-		perf_mmap__init(&map[i].core, overwrite, perf_mmap__unmap_cb);
+		perf_mmap__init(&map[i].core, prev, overwrite, perf_mmap__unmap_cb);
 	}
 
 	return map;
-- 
2.21.0

