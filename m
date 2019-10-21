Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4600FCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B4C214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665349;
	bh=Usxunuk261gboL0dCznrFi0/bCjx3drkGPnqjiqb31s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xDWfxwRcczEJjMwb7KCflMioR5rPDB9ycv6zK7l002v6nSUXfCYse5P1OgNeEZj3V
	 2BLonEgVgVZPm4k5bW99TTMUcwdGglke07OoGBLQD++Op3fxayVPRBlqC0Z2r3amEt
	 BduaNn51V0gVouGww9p4/0SPiqjQFR6K2+3SJLu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbfJUNmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:42:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729001AbfJUNlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:41:07 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15FE921906;
        Mon, 21 Oct 2019 13:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665266;
        bh=Usxunuk261gboL0dCznrFi0/bCjx3drkGPnqjiqb31s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i4O28w7Sg+bj+e31ZgMa7EkTWL83CoDmFWb9/ezjNxl/P4WWYlcBiXEY3MIMy1GiC
         CmrINNdoRkLx7i3kIj8QbYyhcslEbn0x7nnff6gt0s1cg0RZtOXRgwUxts094XzV+w
         KkOUHDXaeB+IUCjnEWmLfxUcNBdb3t42ONIeai3E=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 44/57] libperf: Move mmap allocation to perf_evlist__mmap_ops::get
Date:   Mon, 21 Oct 2019 10:38:21 -0300
Message-Id: <20191021133834.25998-45-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move allocation of the mmap array into perf_evlist__mmap_ops::get, to
centralize the mmap allocation.

Also move nr_mmap setup to perf_evlist__mmap_ops so it's centralized and
shared by both perf and libperf mmap code.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20191017105918.20873-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c  | 42 ++++++++++++++++++++++++----------------
 tools/perf/util/evlist.c | 24 +++++++++--------------
 2 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 854efff1519d..73aac6bb2ac5 100644
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
index 6cda5a311ba5..5cded4ec5806 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -599,9 +599,6 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 	int i;
 	struct mmap *map;
 
-	evlist->core.nr_mmaps = perf_cpu_map__nr(evlist->core.cpus);
-	if (perf_cpu_map__empty(evlist->core.cpus))
-		evlist->core.nr_mmaps = perf_thread_map__nr(evlist->core.threads);
 	map = zalloc(evlist->core.nr_mmaps * sizeof(struct mmap));
 	if (!map)
 		return NULL;
@@ -639,19 +636,21 @@ static struct perf_mmap*
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
 
@@ -812,11 +811,6 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
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

