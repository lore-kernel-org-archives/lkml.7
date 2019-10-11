Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D372C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D3120673
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824679;
	bh=5lJJeeZBUm/4jKagwHdSWBTJsGqg1Kqv/NfYFI31uOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GuGZuplFa621SHxk15ybf6bKyriPQKZAsjbLGNgzo/ff7aildDB4NoxDTq6bK0vOf
	 0QBT4LL9k1d9tZN4OiE+9Ur0I32a6gXQBtRuS5SF2D9MKFiAcegkT13bPNsKegx2RZ
	 ERRXQh0/zxpvbPeltxnwJUBHLEXaZsdRUUEKWSF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbfJKULR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:11:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729744AbfJKULQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:11:16 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28E9A2196E;
        Fri, 11 Oct 2019 20:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824675;
        bh=5lJJeeZBUm/4jKagwHdSWBTJsGqg1Kqv/NfYFI31uOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lSx9uzXT0PRkOc1+5+YVLr6++KUqCybEE/9qYbBEoGpe9gBJoRL+9MzDo57N5cYtL
         vUY0qD0SkrsNCW6UckYbt50DMWXbbvG/f/igv/97gdSREN3eNpkq9DB+shHQzvVRn7
         PweskfWW0f/dTsyCkc3CZV1OdlZGA6GbFWK2OhxI=
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
Subject: [PATCH 58/69] libperf: Introduce perf_evlist_mmap_ops::mmap callback
Date:   Fri, 11 Oct 2019 17:05:48 -0300
Message-Id: <20191011200559.7156-59-acme@kernel.org>
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

Add the perf_evlist_mmap_ops::mmap callback to be called in
mmap_per_evsel() to actually mmap the map.

Add libperf's perf_evlist__mmap_cb_mmap() function as libperf's mmap
callback.

New mmaped map gets refcount set to 2 in mmap__mmap(), we follow that in
mmap callback. We will move this to common place after we switch to
perf_evlist__mmap().

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-18-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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

