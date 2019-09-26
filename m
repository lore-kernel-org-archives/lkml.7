Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4DAC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32DC222C7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458070;
	bh=jd0/wYtU74Ibv2jIGIQ+aPc0d8QkGylTDs6Kfd4C/FY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QSjpC/Xm/ZsId3Nxlz86MkBgcuFEbuu5e68+RUBq/l5R+X6rRD/vnK44H16X5k1Ad
	 R/aeWqgJPzLVbe+DCfNB39i9p6GBruEl+ceZM0Q26TYI/VszLWzISPucGZgf5Ys3lJ
	 UbMy2YA7qXHVKmjkTd1LpfR5CVyWdeWruQlcga/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388639AbfIZAe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:34:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388557AbfIZAe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:34:26 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FC0B222C2;
        Thu, 26 Sep 2019 00:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458065;
        bh=jd0/wYtU74Ibv2jIGIQ+aPc0d8QkGylTDs6Kfd4C/FY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P4SZcWhG5ZmbQmQtMLqdcUk3VHkltNw/i0iVkosRoi6q0zYj1DJynQvXAnr7A91tg
         rHELBOETQARx+dWJmSSu87bzrJsuo3FR71qYcT0gXX4PoAEAS/Uc+NNBMusrZ6jONZ
         n+RTnlR/oA9TZ99D7Z5+5abHIWxmgZJj0r5CwJoQ=
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
Subject: [PATCH 23/66] libperf: Add perf_mmap struct
Date:   Wed, 25 Sep 2019 21:32:01 -0300
Message-Id: <20190926003244.13962-24-acme@kernel.org>
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

Add the perf_mmap struct to libperf.

The definition is added into:

  include/internal/mmap.h

which is not to be included by users, but shared within perf and
libperf.

Committer notes:

Remove unnecessary includes from tools/perf/lib/include/internal/mmap.h,
those will be readded as they become necessary, later in the series.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-11-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/tests/perf-time-to-tsc.c |  2 +-
 tools/perf/arch/x86/util/intel-bts.c         |  2 +-
 tools/perf/arch/x86/util/intel-pt.c          |  2 +-
 tools/perf/builtin-record.c                  | 14 ++++++-------
 tools/perf/lib/include/internal/mmap.h       | 14 +++++++++++++
 tools/perf/util/mmap.c                       | 22 ++++++++++----------
 tools/perf/util/mmap.h                       |  7 ++++---
 7 files changed, 39 insertions(+), 24 deletions(-)
 create mode 100644 tools/perf/lib/include/internal/mmap.h

diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index e1dd5f8894ba..bd404db94b3a 100644
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
index 64b409dad6e2..130925141369 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -78,7 +78,7 @@ static int intel_bts_info_fill(struct auxtrace_record *itr,
 	if (!session->evlist->nr_mmaps)
 		return -EINVAL;
 
-	pc = session->evlist->mmap[0].base;
+	pc = session->evlist->mmap[0].core.base;
 	if (pc) {
 		err = perf_read_tsc_conversion(pc, &tc);
 		if (err) {
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 6c139611d231..34d7118bf390 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -355,7 +355,7 @@ static int intel_pt_info_fill(struct auxtrace_record *itr,
 	if (!session->evlist->nr_mmaps)
 		return -EINVAL;
 
-	pc = session->evlist->mmap[0].base;
+	pc = session->evlist->mmap[0].core.base;
 	if (pc) {
 		err = perf_read_tsc_conversion(pc, &tc);
 		if (err) {
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 1bb3d91c6599..2520c0212275 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -261,7 +261,7 @@ static int record__aio_pushfn(struct mmap *map, void *to, void *buf, size_t size
 	struct record_aio *aio = to;
 
 	/*
-	 * map->base data pointed by buf is copied into free map->aio.data[] buffer
+	 * map->core.base data pointed by buf is copied into free map->aio.data[] buffer
 	 * to release space in the kernel buffer as fast as possible, calling
 	 * perf_mmap__consume() from perf_mmap__push() function.
 	 *
@@ -360,7 +360,7 @@ static void record__aio_mmap_read_sync(struct record *rec)
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		struct mmap *map = &maps[i];
 
-		if (map->base)
+		if (map->core.base)
 			record__aio_sync(map, true);
 	}
 }
@@ -970,7 +970,7 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
 		u64 flush = 0;
 		struct mmap *map = &maps[i];
 
-		if (map->base) {
+		if (map->core.base) {
 			record__adjust_affinity(rec, map);
 			if (synch) {
 				flush = map->flush;
@@ -1198,10 +1198,10 @@ static const struct perf_event_mmap_page *
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
index 000000000000..2ef051901f48
--- /dev/null
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_MMAP_H
+#define __LIBPERF_INTERNAL_MMAP_H
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
index ab086ede044a..d2f0ce581e2c 100644
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
@@ -60,12 +61,12 @@ void perf_mmap__consume(struct mmap *map);
 
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

