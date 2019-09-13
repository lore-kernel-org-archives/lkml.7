Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11E2C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56B820640
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381286;
	bh=UjVUhRZZHA26cnmxF8lG2Y2GWqAHEATtw10n20xtscM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k0xoPqDGQlOXZ971SzOpCmWOpm92oyDTaxgrGs0CMbnG4gFYuTWljjIEHtz68gVQ9
	 hxss4BGgELEPN6dYdh8+Y6Ld1ZIwWAbULl8qn4jhQLzi9p6uDlqu+x4dvPFz55RiAd
	 sEBu7hoiBtEPUxCHykSCZkkOAGwnSTj3qVrT7XU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391165AbfIMN2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:28:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391404AbfIMNZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:25:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2EACC308218D;
        Fri, 13 Sep 2019 13:25:39 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 866A15C1D4;
        Fri, 13 Sep 2019 13:25:37 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 40/73] libperf: Add struct perf_mmap_param
Date:   Fri, 13 Sep 2019 15:23:22 +0200
Message-Id: <20190913132355.21634-41-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 13 Sep 2019 13:25:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding libperf's version of mmap params 'struct perf_mmap_param'
object with the basics: prot and mask. It's encapsulated in current
struct mmap_params object.

Link: http://lkml.kernel.org/n/tip-jl518fuinj826rsmve5qhrff@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/internal/mmap.h |  5 +++++
 tools/perf/util/evlist.c               | 14 +++++++++-----
 tools/perf/util/mmap.c                 |  4 ++--
 tools/perf/util/mmap.h                 |  3 ++-
 4 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index e95fc51e5bd0..8e06eb840c47 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -29,6 +29,11 @@ struct perf_mmap {
 	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
 };
 
+struct perf_mmap_param {
+	int	prot;
+	int	mask;
+};
+
 void perf_mmap__init(struct perf_mmap *map, bool overwrite);
 
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 0d1ae00d22f3..c0c0882dc343 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -642,7 +642,7 @@ static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 		int fd;
 		int cpu;
 
-		mp->prot = PROT_READ | PROT_WRITE;
+		mp->core.prot = PROT_READ | PROT_WRITE;
 		if (evsel->core.attr.write_backward) {
 			output = _output_overwrite;
 			maps = evlist->overwrite_mmap;
@@ -655,7 +655,7 @@ static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 				if (evlist->bkw_mmap_state == BKW_MMAP_NOTREADY)
 					perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_RUNNING);
 			}
-			mp->prot &= ~PROT_WRITE;
+			mp->core.prot &= ~PROT_WRITE;
 		}
 
 		if (evsel->core.system_wide && thread)
@@ -896,8 +896,12 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 	 * Its value is decided by evsel's write_backward.
 	 * So &mp should not be passed through const pointer.
 	 */
-	struct mmap_params mp = { .nr_cblocks = nr_cblocks, .affinity = affinity, .flush = flush,
-				  .comp_level = comp_level };
+	struct mmap_params mp = {
+		.nr_cblocks	= nr_cblocks,
+		.affinity	= affinity,
+		.flush		= flush,
+		.comp_level	= comp_level
+	};
 
 	if (!evlist->mmap)
 		evlist->mmap = evlist__alloc_mmap(evlist, false);
@@ -909,7 +913,7 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 
 	evlist->core.mmap_len = evlist__mmap_size(pages);
 	pr_debug("mmap size %zuB\n", evlist->core.mmap_len);
-	mp.mask = evlist->core.mmap_len - page_size - 1;
+	mp.core.mask = evlist->core.mmap_len - page_size - 1;
 
 	auxtrace_mmap_params__init(&mp.auxtrace_mp, evlist->core.mmap_len,
 				   auxtrace_pages, auxtrace_overwrite);
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 4cc3b54b2f73..2f34a93a72f4 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -369,8 +369,8 @@ int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 	 */
 	refcount_set(&map->core.refcnt, 2);
 	map->core.prev = 0;
-	map->core.mask = mp->mask;
-	map->core.base = mmap(NULL, perf_mmap__mmap_len(map), mp->prot,
+	map->core.mask = mp->core.mask;
+	map->core.base = mmap(NULL, perf_mmap__mmap_len(map), mp->core.prot,
 			 MAP_SHARED, fd, 0);
 	if (map->core.base == MAP_FAILED) {
 		pr_debug2("failed to mmap perf event ring buffer, error %d\n",
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index e335c341d073..965acb46df81 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -65,7 +65,8 @@ enum bkw_mmap_state {
 };
 
 struct mmap_params {
-	int prot, mask, nr_cblocks, affinity, flush, comp_level;
+	struct perf_mmap_param core;
+	int nr_cblocks, affinity, flush, comp_level;
 	struct auxtrace_mmap_params auxtrace_mp;
 };
 
-- 
2.21.0

