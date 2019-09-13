Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B11AC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBD6206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381072;
	bh=vPgZn9SX/D5UevHz2dZp6b9pGMTj8B94gk1y+7l/M5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aid92xQWuU3LOuQn/gMe/fgr5Fl4CtFqfRs1nlWIkFRQgRACwHykG+cU3ZZkR+5mv
	 7tR82vJDXYYgz4DN4yR1BpbJbsvxdDvzX2R5+D3oCEHnDe1WTtxGsBFtj3EEzicynF
	 mRHNGdOkTf4h6R4UvPIvAI1wkk73vJ3JfHbKybmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391171AbfIMNYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:24:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55222 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391150AbfIMNY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:24:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB8F418C891D;
        Fri, 13 Sep 2019 13:24:25 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F50C5C1D4;
        Fri, 13 Sep 2019 13:24:23 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 10/73] libperf: Add perf_mmap struct
Date:   Fri, 13 Sep 2019 15:22:52 +0200
Message-Id: <20190913132355.21634-11-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Fri, 13 Sep 2019 13:24:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the perf_mmap to libperf.

The definition is added into:

  include/internal/mmap.h

which is not to be included by users, but shared
within perf and libperf.

Link: http://lkml.kernel.org/n/tip-qdhqbwgaujfghfmmhbbp4vcd@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/arch/x86/tests/perf-time-to-tsc.c |  2 +-
 tools/perf/arch/x86/util/intel-bts.c         |  2 +-
 tools/perf/arch/x86/util/intel-pt.c          |  2 +-
 tools/perf/builtin-record.c                  | 14 ++++++-------
 tools/perf/lib/include/internal/mmap.h       | 19 +++++++++++++++++
 tools/perf/util/mmap.c                       | 22 ++++++++++----------
 tools/perf/util/mmap.h                       |  7 ++++---
 7 files changed, 44 insertions(+), 24 deletions(-)
 create mode 100644 tools/perf/lib/include/internal/mmap.h

diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index 3644ebd45a46..42725e6882e9 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -93,7 +93,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 
 	CHECK__(evlist__mmap(evlist, UINT_MAX));
 
-	pc = evlist->mmap[0].base;
+	pc = evlist->mmap[0].core.base;
 	ret = perf_read_tsc_conversion(pc, &tc);
 	if (ret) {
 		if (ret == -EOPNOTSUPP) {
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index d263430c045f..aa13df948049 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -77,7 +77,7 @@ static int intel_bts_info_fill(struct auxtrace_record *itr,
 	if (!session->evlist->nr_mmaps)
 		return -EINVAL;
 
-	pc = session->evlist->mmap[0].base;
+	pc = session->evlist->mmap[0].core.base;
 	if (pc) {
 		err = perf_read_tsc_conversion(pc, &tc);
 		if (err) {
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index cb7cf16af79c..c0a7535cfd0e 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -354,7 +354,7 @@ static int intel_pt_info_fill(struct auxtrace_record *itr,
 	if (!session->evlist->nr_mmaps)
 		return -EINVAL;
 
-	pc = session->evlist->mmap[0].base;
+	pc = session->evlist->mmap[0].core.base;
 	if (pc) {
 		err = perf_read_tsc_conversion(pc, &tc);
 		if (err) {
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index df16e1ca1f36..6c0349dcb20c 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -258,7 +258,7 @@ static int record__aio_pushfn(struct mmap *map, void *to, void *buf, size_t size
 	struct record_aio *aio = to;
 
 	/*
-	 * map->base data pointed by buf is copied into free map->aio.data[] buffer
+	 * map->core.base data pointed by buf is copied into free map->aio.data[] buffer
 	 * to release space in the kernel buffer as fast as possible, calling
 	 * perf_mmap__consume() from perf_mmap__push() function.
 	 *
@@ -357,7 +357,7 @@ static void record__aio_mmap_read_sync(struct record *rec)
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		struct mmap *map = &maps[i];
 
-		if (map->base)
+		if (map->core.base)
 			record__aio_sync(map, true);
 	}
 }
@@ -956,7 +956,7 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
 		u64 flush = 0;
 		struct mmap *map = &maps[i];
 
-		if (map->base) {
+		if (map->core.base) {
 			record__adjust_affinity(rec, map);
 			if (synch) {
 				flush = map->flush;
@@ -1193,10 +1193,10 @@ static const struct perf_event_mmap_page *
 perf_evlist__pick_pc(struct evlist *evlist)
 {
 	if (evlist) {
-		if (evlist->mmap && evlist->mmap[0].base)
-			return evlist->mmap[0].base;
-		if (evlist->overwrite_mmap && evlist->overwrite_mmap[0].base)
-			return evlist->overwrite_mmap[0].base;
+		if (evlist->mmap && evlist->mmap[0].core.base)
+			return evlist->mmap[0].core.base;
+		if (evlist->overwrite_mmap && evlist->overwrite_mmap[0].core.base)
+			return evlist->overwrite_mmap[0].core.base;
 	}
 	return NULL;
 }
diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
new file mode 100644
index 000000000000..8d10559dee49
--- /dev/null
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_MMAP_H
+#define __LIBPERF_INTERNAL_MMAP_H
+
+#include <linux/refcount.h>
+#include <linux/compiler.h>
+#include <stdlib.h>
+#include <stdbool.h>
+
+/**
+ * struct perf_mmap - perf's ring buffer mmap details
+ *
+ * @refcnt - e.g. code using PERF_EVENT_IOC_SET_OUTPUT to share this
+ */
+struct perf_mmap {
+	void		*base;
+};
+
+#endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index f3b7c8b0fa90..76190b2edd78 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -31,7 +31,7 @@ size_t perf_mmap__mmap_len(struct mmap *map)
 static union perf_event *perf_mmap__read(struct mmap *map,
 					 u64 *startp, u64 end)
 {
-	unsigned char *data = map->base + page_size;
+	unsigned char *data = map->core.base + page_size;
 	union perf_event *event = NULL;
 	int diff = end - *startp;
 
@@ -116,7 +116,7 @@ void perf_mmap__get(struct mmap *map)
 
 void perf_mmap__put(struct mmap *map)
 {
-	BUG_ON(map->base && refcount_read(&map->refcnt) == 0);
+	BUG_ON(map->core.base && refcount_read(&map->refcnt) == 0);
 
 	if (refcount_dec_and_test(&map->refcnt))
 		perf_mmap__munmap(map);
@@ -317,9 +317,9 @@ void perf_mmap__munmap(struct mmap *map)
 		munmap(map->data, perf_mmap__mmap_len(map));
 		map->data = NULL;
 	}
-	if (map->base != NULL) {
-		munmap(map->base, perf_mmap__mmap_len(map));
-		map->base = NULL;
+	if (map->core.base != NULL) {
+		munmap(map->core.base, perf_mmap__mmap_len(map));
+		map->core.base = NULL;
 		map->fd = -1;
 		refcount_set(&map->refcnt, 0);
 	}
@@ -370,12 +370,12 @@ int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 	refcount_set(&map->refcnt, 2);
 	map->prev = 0;
 	map->mask = mp->mask;
-	map->base = mmap(NULL, perf_mmap__mmap_len(map), mp->prot,
+	map->core.base = mmap(NULL, perf_mmap__mmap_len(map), mp->prot,
 			 MAP_SHARED, fd, 0);
-	if (map->base == MAP_FAILED) {
+	if (map->core.base == MAP_FAILED) {
 		pr_debug2("failed to mmap perf event ring buffer, error %d\n",
 			  errno);
-		map->base = NULL;
+		map->core.base = NULL;
 		return -1;
 	}
 	map->fd = fd;
@@ -399,7 +399,7 @@ int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 	}
 
 	if (auxtrace_mmap__mmap(&map->auxtrace_mmap,
-				&mp->auxtrace_mp, map->base, fd))
+				&mp->auxtrace_mp, map->core.base, fd))
 		return -1;
 
 	return perf_mmap__aio_mmap(map, mp);
@@ -444,7 +444,7 @@ static int __perf_mmap__read_init(struct mmap *md)
 {
 	u64 head = perf_mmap__read_head(md);
 	u64 old = md->prev;
-	unsigned char *data = md->base + page_size;
+	unsigned char *data = md->core.base + page_size;
 	unsigned long size;
 
 	md->start = md->overwrite ? head : old;
@@ -489,7 +489,7 @@ int perf_mmap__push(struct mmap *md, void *to,
 		    int push(struct mmap *map, void *to, void *buf, size_t size))
 {
 	u64 head = perf_mmap__read_head(md);
-	unsigned char *data = md->base + page_size;
+	unsigned char *data = md->core.base + page_size;
 	unsigned long size;
 	void *buf;
 	int rc = 0;
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 01524608a984..9028b0e8a0ed 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -1,6 +1,7 @@
 #ifndef __PERF_MMAP_H
 #define __PERF_MMAP_H 1
 
+#include <internal/mmap.h>
 #include <linux/compiler.h>
 #include <linux/refcount.h>
 #include <linux/types.h>
@@ -20,7 +21,7 @@ struct aiocb;
  * @refcnt - e.g. code using PERF_EVENT_IOC_SET_OUTPUT to share this
  */
 struct mmap {
-	void		 *base;
+	struct perf_mmap	core;
 	int		 mask;
 	int		 fd;
 	int		 cpu;
@@ -88,12 +89,12 @@ void perf_mmap__consume(struct mmap *map);
 
 static inline u64 perf_mmap__read_head(struct mmap *mm)
 {
-	return ring_buffer_read_head(mm->base);
+	return ring_buffer_read_head(mm->core.base);
 }
 
 static inline void perf_mmap__write_tail(struct mmap *md, u64 tail)
 {
-	ring_buffer_write_tail(md->base, tail);
+	ring_buffer_write_tail(md->core.base, tail);
 }
 
 union perf_event *perf_mmap__read_forward(struct mmap *map);
-- 
2.21.0

