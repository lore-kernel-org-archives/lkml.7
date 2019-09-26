Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D644C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430EC222C6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458074;
	bh=TH2hgnRELhXyQRLRAh/iMIkSGSQuHxUN+dsBAP37HgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=idUsS7gwZBw3nmspSHZUjXQriR10uoKg7cqprymuKORz1uL2fRcRIKcD3OPQDOohp
	 yoy0TWtqf4IFP2pbcI8A3T9N9CYcHiNLul7NG96fYsj85qUcyOYUDpJ14pi3jALDGS
	 aOlMqrM46vN5m+ZL77gqJk0dmsJAB5zgHACWTZhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388666AbfIZAed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:34:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388608AbfIZAe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:34:29 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1A57217F4;
        Thu, 26 Sep 2019 00:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458068;
        bh=TH2hgnRELhXyQRLRAh/iMIkSGSQuHxUN+dsBAP37HgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BXX2cRzSOnRFWnFGNsdyBM0HCHpIs5QFl4JO0aGBtiO5yD8P0JMmGCU3jX2YEMLWM
         ii/cy+L6QKA/OhQuVqgBxzxjB4WLnP8Q+t2CCVXzTtdy1OG6KFpgHJxyOMcMnudDNx
         1LzJ5FOJPzNY/mQrkJJkSJDRbI/lo83NFn7LHlQ8=
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
Subject: [PATCH 24/66] libperf: Add 'mask' to struct perf_mmap
Date:   Wed, 25 Sep 2019 21:32:02 -0300
Message-Id: <20190926003244.13962-25-acme@kernel.org>
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

Move 'mask' from tools/perf's mmap to libperf's perf_mmap struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-12-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/mmap.h |  1 +
 tools/perf/util/mmap.c                 | 24 ++++++++++++------------
 tools/perf/util/mmap.h                 |  1 -
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index 2ef051901f48..1caa1e8ee5c6 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -9,6 +9,7 @@
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
index d2f0ce581e2c..370138e395fc 100644
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

