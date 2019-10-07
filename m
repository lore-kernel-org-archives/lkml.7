Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B03ECE58D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D5721721
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570452869;
	bh=PbgVQdaY+wZyYuFB7JU0Y9deb8xzIRNbThtM+c6CG14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Stf6XJ2kD2ya1bqRTmFe38nOE1PHNEAAvzAQ26uI8df49/hyiWR2Z0k7TwFqB2E5g
	 Hc0jRdcUQyafcwgbmxjGTKVDYoD140wHV1tn2Fv4/ZtlBTJXj1Fja1MbohOzhEWFCl
	 vW+OVnFr3GUEETYOCGIdcTjAPZr/B3KXkL8zgeqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfJGMy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:54:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42582 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728273AbfJGMyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:54:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 27B2920FE;
        Mon,  7 Oct 2019 12:54:25 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F19EF5DC1E;
        Mon,  7 Oct 2019 12:54:22 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 17/36] libperf: Add perf_evlist_mmap_ops::mmap callback
Date:   Mon,  7 Oct 2019 14:53:25 +0200
Message-Id: <20191007125344.14268-18-jolsa@kernel.org>
In-Reply-To: <20191007125344.14268-1-jolsa@kernel.org>
References: <20191007125344.14268-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Mon, 07 Oct 2019 12:54:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_evlist_mmap_ops::mmap callback to be called
in mmap_per_evsel to actually mmap the map.

Adding libperf's perf_evlist__mmap_cb_mmap function as
libperf's mmap callback.

New mmaped map gets refcount set to 2 in mmap__mmap,
we follow that in mmap callback. We will move this to
common place after we switch to perf_evlist__mmap.

Link: http://lkml.kernel.org/n/tip-9cksnv3xbb1eset7ge67at4a@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evlist.c                  | 29 +++++++++++++++++++++---
 tools/perf/lib/include/internal/evlist.h |  3 +++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 4f49de5e8f7c..b69722627779 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -358,6 +358,28 @@ perf_evlist__mmap_cb_get(struct perf_evlist *evlist, bool overwrite, int idx)
 
 #define FD(e, x, y) (*(int *) xyarray__entry(e->fd, x, y))
 
+static int
+perf_evlist__mmap_cb_mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
+			  int output, int cpu)
+{
+	/*
+	 * The last one will be done at perf_mmap__consume(), so that we
+	 * make sure we don't prevent tools from consuming every last event in
+	 * the ring buffer.
+	 *
+	 * I.e. we can get the POLLHUP meaning that the fd doesn't exist
+	 * anymore, but the last events for it are still in the ring buffer,
+	 * waiting to be consumed.
+	 *
+	 * Tools can chose to ignore this at their own discretion, but the
+	 * evlist layer can't just drop it when filtering events in
+	 * perf_evlist__filter_pollfd().
+	 */
+	refcount_set(&map->refcnt, 2);
+
+	return perf_mmap__mmap(map, mp, output, cpu);
+}
+
 static int
 mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 	       int idx, struct perf_mmap_param *mp, int cpu_idx,
@@ -396,7 +418,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 		if (*output == -1) {
 			*output = fd;
 
-			if (perf_mmap__mmap(map, mp, *output, evlist_cpu) < 0)
+			if (ops->mmap(map, mp, *output, evlist_cpu) < 0)
 				return -1;
 		} else {
 			if (ioctl(fd, PERF_EVENT_IOC_SET_OUTPUT, *output) != 0)
@@ -488,7 +510,7 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 	const struct perf_cpu_map *cpus = evlist->cpus;
 	const struct perf_thread_map *threads = evlist->threads;
 
-	if (!ops || !ops->get)
+	if (!ops || !ops->get || !ops->mmap)
 		return -EINVAL;
 
 	if (!evlist->mmap)
@@ -513,7 +535,8 @@ int perf_evlist__mmap(struct perf_evlist *evlist, int pages)
 {
 	struct perf_mmap_param mp;
 	struct perf_evlist_mmap_ops ops = {
-		.get = perf_evlist__mmap_cb_get,
+		.get  = perf_evlist__mmap_cb_get,
+		.mmap = perf_evlist__mmap_cb_mmap,
 	};
 
 	evlist->mmap_len = (pages + 1) * page_size;
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 9bc3a21643ea..b2019700cdc0 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -31,10 +31,13 @@ typedef void
 (*perf_evlist_mmap__cb_idx_t)(struct perf_evlist*, struct perf_mmap_param*, int, bool);
 typedef struct perf_mmap*
 (*perf_evlist_mmap__cb_get_t)(struct perf_evlist*, bool, int);
+typedef int
+(*perf_evlist_mmap__cb_mmap_t)(struct perf_mmap*, struct perf_mmap_param*, int, int);
 
 struct perf_evlist_mmap_ops {
 	perf_evlist_mmap__cb_idx_t	idx;
 	perf_evlist_mmap__cb_get_t	get;
+	perf_evlist_mmap__cb_mmap_t	mmap;
 };
 
 int perf_evlist__alloc_pollfd(struct perf_evlist *evlist);
-- 
2.21.0

