Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33312ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A1F2173B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570452900;
	bh=Rmhg5U8994pOLF8/wSrt2CjeM22v0Acb7LTG1dkcjwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=guBO+DuzY/of6DFNrI3B+Cbes78nqv+i1abcsna3H5X3ez8pnf7UDNVIEPF4ch1Gu
	 epsPEOeFtVZHW0L9hjykyg1bKN4pVndVl89axH8hW7Yu8YtdY4bgUH293jQxzISt1S
	 xn/Gepx+HX+00x9m1eL7QJnbCYR3y2+pO/3+fA6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbfJGMy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:54:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728428AbfJGMyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:54:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 71ABC879A9E;
        Mon,  7 Oct 2019 12:54:53 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE7C45D9CC;
        Mon,  7 Oct 2019 12:54:51 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 28/36] libperf: Move mmap allocation to perf_evlist__mmap_ops::get
Date:   Mon,  7 Oct 2019 14:53:36 +0200
Message-Id: <20191007125344.14268-29-jolsa@kernel.org>
In-Reply-To: <20191007125344.14268-1-jolsa@kernel.org>
References: <20191007125344.14268-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Mon, 07 Oct 2019 12:54:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving allocation of mmap array into perf_evlist__mmap_ops::get,
so we centralize the mmap allocation.

Moving also nr_mmap setup to perf_evlist__mmap_ops so it's
centralized and shared by both perf and libperf mmap code.

Link: http://lkml.kernel.org/n/tip-svp52oxqixph08fijuylugp7@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evlist.c  | 42 ++++++++++++++++++++++++----------------
 tools/perf/util/evlist.c | 24 +++++++++--------------
 2 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 4e85d9bb92bf..61ed27526e08 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -338,10 +338,6 @@ static struct perf_mmap* perf_evlist__alloc_mmap(struct perf_evlist *evlist, boo
 	int i;
 	struct perf_mmap *map;
 
-	evlist->nr_mmaps = perf_cpu_map__nr(evlist->cpus);
-	if (perf_cpu_map__empty(evlist->cpus))
-		evlist->nr_mmaps = perf_thread_map__nr(evlist->threads);
-
 	map = zalloc(evlist->nr_mmaps * sizeof(struct perf_mmap));
 	if (!map)
 		return NULL;
@@ -384,18 +380,22 @@ static void perf_evlist__set_sid_idx(struct perf_evlist *evlist,
 static struct perf_mmap*
 perf_evlist__mmap_cb_get(struct perf_evlist *evlist, bool overwrite, int idx)
 {
-	struct perf_mmap *map = &evlist->mmap[idx];
+	struct perf_mmap *maps;
 
-	if (overwrite) {
-		if (!evlist->mmap_ovw) {
-			evlist->mmap_ovw = perf_evlist__alloc_mmap(evlist, true);
-			if (!evlist->mmap_ovw)
-				return NULL;
-		}
-		map = &evlist->mmap_ovw[idx];
+	maps = overwrite ? evlist->mmap_ovw : evlist->mmap;
+
+	if (!maps) {
+		maps = perf_evlist__alloc_mmap(evlist, overwrite);
+		if (!maps)
+			return NULL;
+
+		if (overwrite)
+			evlist->mmap_ovw = maps;
+		else
+			evlist->mmap = maps;
 	}
 
-	return map;
+	return &maps[idx];
 }
 
 #define FD(e, x, y) (*(int *) xyarray__entry(e->fd, x, y))
@@ -556,6 +556,17 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 	return -1;
 }
 
+static int perf_evlist__nr_mmaps(struct perf_evlist *evlist)
+{
+	int nr_mmaps;
+
+	nr_mmaps = perf_cpu_map__nr(evlist->cpus);
+	if (perf_cpu_map__empty(evlist->cpus))
+		nr_mmaps = perf_thread_map__nr(evlist->threads);
+
+	return nr_mmaps;
+}
+
 int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 			  struct perf_evlist_mmap_ops *ops,
 			  struct perf_mmap_param *mp)
@@ -567,10 +578,7 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 	if (!ops || !ops->get || !ops->mmap)
 		return -EINVAL;
 
-	if (!evlist->mmap)
-		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
-	if (!evlist->mmap)
-		return -ENOMEM;
+	evlist->nr_mmaps = perf_evlist__nr_mmaps(evlist);
 
 	perf_evlist__for_each_entry(evlist, evsel) {
 		if ((evsel->attr.read_format & PERF_FORMAT_ID) &&
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 469a5476ef1a..b58ef3147163 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -574,9 +574,6 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 	int i;
 	struct mmap *map;
 
-	evlist->core.nr_mmaps = perf_cpu_map__nr(evlist->core.cpus);
-	if (perf_cpu_map__empty(evlist->core.cpus))
-		evlist->core.nr_mmaps = perf_thread_map__nr(evlist->core.threads);
 	map = zalloc(evlist->core.nr_mmaps * sizeof(struct mmap));
 	if (!map)
 		return NULL;
@@ -614,19 +611,21 @@ static struct perf_mmap*
 perf_evlist__mmap_cb_get(struct perf_evlist *_evlist, bool overwrite, int idx)
 {
 	struct evlist *evlist = container_of(_evlist, struct evlist, core);
-	struct mmap *maps = evlist->mmap;
+	struct mmap *maps;
 
-	if (overwrite) {
-		maps = evlist->overwrite_mmap;
+	maps = overwrite ? evlist->overwrite_mmap : evlist->mmap;
 
-		if (!maps) {
-			maps = evlist__alloc_mmap(evlist, true);
-			if (!maps)
-				return NULL;
+	if (!maps) {
+		maps = evlist__alloc_mmap(evlist, overwrite);
+		if (!maps)
+			return NULL;
 
+		if (overwrite) {
 			evlist->overwrite_mmap = maps;
 			if (evlist->bkw_mmap_state == BKW_MMAP_NOTREADY)
 				perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_RUNNING);
+		} else {
+			evlist->mmap = maps;
 		}
 	}
 
@@ -787,11 +786,6 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 		.mmap = perf_evlist__mmap_cb_mmap,
 	};
 
-	if (!evlist->mmap)
-		evlist->mmap = evlist__alloc_mmap(evlist, false);
-	if (!evlist->mmap)
-		return -ENOMEM;
-
 	evlist->core.mmap_len = evlist__mmap_size(pages);
 	pr_debug("mmap size %zuB\n", evlist->core.mmap_len);
 	mp.core.mask = evlist->core.mmap_len - page_size - 1;
-- 
2.21.0

