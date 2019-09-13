Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02B2C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B6F20717
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381074;
	bh=FQxumubEx9TIhlKwSY97grnJDOvLkJ8AW8xVIXpZV6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b+lZ9nZppQDjf4/pCHur78QAf6DQF2j5tIsS9bgoI/W8hf+/mlCR1cdV234tlM+47
	 s89PL4+64lt4dxQTDejPJ5FtHfYjWx/Iafy9j6aY667ccz0gFFPrnn+aVSwRCjZFhy
	 YuPN221FAV4urSpDYe3kRepB9DnfTV36DAvKnwNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391180AbfIMNYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:24:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59396 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391158AbfIMNY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:24:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9FCDF18CB8E7;
        Fri, 13 Sep 2019 13:24:27 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0781A5C1D4;
        Fri, 13 Sep 2019 13:24:25 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 11/73] libperf: Add mask to struct perf_mmap
Date:   Fri, 13 Sep 2019 15:22:53 +0200
Message-Id: <20190913132355.21634-12-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Fri, 13 Sep 2019 13:24:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move mask from tools/perf's mmap to libperf's perf_mmap struct.

Link: http://lkml.kernel.org/n/tip-a8j8j5an8wyvgo9v8g26hmc1@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/internal/mmap.h |  1 +
 tools/perf/util/mmap.c                 | 24 ++++++++++++------------
 tools/perf/util/mmap.h                 |  1 -
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index 8d10559dee49..a6a464097f14 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -14,6 +14,7 @@
  */
 struct perf_mmap {
 	void		*base;
+	int		 mask;
 };
 
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 76190b2edd78..702e8e0b90ea 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -24,7 +24,7 @@
 
 size_t perf_mmap__mmap_len(struct mmap *map)
 {
-	return map->mask + 1 + page_size;
+	return map->core.mask + 1 + page_size;
 }
 
 /* When check_messup is true, 'end' must points to a good entry */
@@ -38,7 +38,7 @@ static union perf_event *perf_mmap__read(struct mmap *map,
 	if (diff >= (int)sizeof(event->header)) {
 		size_t size;
 
-		event = (union perf_event *)&data[*startp & map->mask];
+		event = (union perf_event *)&data[*startp & map->core.mask];
 		size = event->header.size;
 
 		if (size < sizeof(event->header) || diff < (int)size)
@@ -48,14 +48,14 @@ static union perf_event *perf_mmap__read(struct mmap *map,
 		 * Event straddles the mmap boundary -- header should always
 		 * be inside due to u64 alignment of output.
 		 */
-		if ((*startp & map->mask) + size != ((*startp + size) & map->mask)) {
+		if ((*startp & map->core.mask) + size != ((*startp + size) & map->core.mask)) {
 			unsigned int offset = *startp;
 			unsigned int len = min(sizeof(*event), size), cpy;
 			void *dst = map->event_copy;
 
 			do {
-				cpy = min(map->mask + 1 - (offset & map->mask), len);
-				memcpy(dst, &data[offset & map->mask], cpy);
+				cpy = min(map->core.mask + 1 - (offset & map->core.mask), len);
+				memcpy(dst, &data[offset & map->core.mask], cpy);
 				offset += cpy;
 				dst += cpy;
 				len -= cpy;
@@ -369,7 +369,7 @@ int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 	 */
 	refcount_set(&map->refcnt, 2);
 	map->prev = 0;
-	map->mask = mp->mask;
+	map->core.mask = mp->mask;
 	map->core.base = mmap(NULL, perf_mmap__mmap_len(map), mp->prot,
 			 MAP_SHARED, fd, 0);
 	if (map->core.base == MAP_FAILED) {
@@ -454,7 +454,7 @@ static int __perf_mmap__read_init(struct mmap *md)
 		return -EAGAIN;
 
 	size = md->end - md->start;
-	if (size > (unsigned long)(md->mask) + 1) {
+	if (size > (unsigned long)(md->core.mask) + 1) {
 		if (!md->overwrite) {
 			WARN_ONCE(1, "failed to keep up with mmap data. (warn only once)\n");
 
@@ -467,7 +467,7 @@ static int __perf_mmap__read_init(struct mmap *md)
 		 * Backward ring buffer is full. We still have a chance to read
 		 * most of data from it.
 		 */
-		if (overwrite_rb_find_range(data, md->mask, &md->start, &md->end))
+		if (overwrite_rb_find_range(data, md->core.mask, &md->start, &md->end))
 			return -EINVAL;
 	}
 
@@ -500,9 +500,9 @@ int perf_mmap__push(struct mmap *md, void *to,
 
 	size = md->end - md->start;
 
-	if ((md->start & md->mask) + size != (md->end & md->mask)) {
-		buf = &data[md->start & md->mask];
-		size = md->mask + 1 - (md->start & md->mask);
+	if ((md->start & md->core.mask) + size != (md->end & md->core.mask)) {
+		buf = &data[md->start & md->core.mask];
+		size = md->core.mask + 1 - (md->start & md->core.mask);
 		md->start += size;
 
 		if (push(md, to, buf, size) < 0) {
@@ -511,7 +511,7 @@ int perf_mmap__push(struct mmap *md, void *to,
 		}
 	}
 
-	buf = &data[md->start & md->mask];
+	buf = &data[md->start & md->core.mask];
 	size = md->end - md->start;
 	md->start += size;
 
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 9028b0e8a0ed..a6e60596f889 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -22,7 +22,6 @@ struct aiocb;
  */
 struct mmap {
 	struct perf_mmap	core;
-	int		 mask;
 	int		 fd;
 	int		 cpu;
 	refcount_t	 refcnt;
-- 
2.21.0

