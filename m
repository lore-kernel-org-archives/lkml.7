Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CAAECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8310221D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824622;
	bh=CNN4koHSslyI9AFmmXx+uiKLYL3fP/DJwINQ09IkJsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VQyo9jtMNcflFToLhslm00DCYRvilpCygQNE13QX8zciMESSUji/XL93nF7/8rPFw
	 HOBoGO2OGvUOfoafHZ8+N6Qbwn8vcY7AwrS3G6W63X/2KfgV5bMA2lv2CQdpgjUcBU
	 DNwZL7g6aO0MWRdo51XtZdKsVCkdEzE8CUzghUlI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbfJKUKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:10:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729088AbfJKUKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:10:19 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34A27214E0;
        Fri, 11 Oct 2019 20:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824617;
        bh=CNN4koHSslyI9AFmmXx+uiKLYL3fP/DJwINQ09IkJsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J/Yzo/9aRAXJgXEmqcRZWEoj43CEJ1xCAovbbRtA0J5BnQf97Jqjyn+KKb5mLfBXC
         wfQWMFGoZ2Mdvl3Ztbg26e8P994mJVHxFwdbOCMYkpQ9/BXuLlECsENS0oHns7v8ez
         sjkKR0jYnJnEcvwX+3C+bH7d6TNQKQRHtOkmvj1M=
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
Subject: [PATCH 43/69] libperf: Add 'struct perf_mmap_param'
Date:   Fri, 11 Oct 2019 17:05:33 -0300
Message-Id: <20191011200559.7156-44-acme@kernel.org>
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

Add libperf's version of mmap params 'struct perf_mmap_param' object
with the basics: 'prot' and 'mask'.  Encapsulate it in the current
'struct mmap_params' object.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/mmap.h |  5 +++++
 tools/perf/util/evlist.c               | 14 +++++++++-----
 tools/perf/util/mmap.c                 |  4 ++--
 tools/perf/util/mmap.h                 |  3 ++-
 4 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index e25890de6a55..b26806b36bb6 100644
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
index 6c8de0865670..3a19a7cb95b1 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -667,7 +667,7 @@ static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 		int fd;
 		int cpu;
 
-		mp->prot = PROT_READ | PROT_WRITE;
+		mp->core.prot = PROT_READ | PROT_WRITE;
 		if (evsel->core.attr.write_backward) {
 			output = _output_overwrite;
 			maps = evlist->overwrite_mmap;
@@ -680,7 +680,7 @@ static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 				if (evlist->bkw_mmap_state == BKW_MMAP_NOTREADY)
 					perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_RUNNING);
 			}
-			mp->prot &= ~PROT_WRITE;
+			mp->core.prot &= ~PROT_WRITE;
 		}
 
 		if (evsel->core.system_wide && thread)
@@ -921,8 +921,12 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
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
@@ -934,7 +938,7 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 
 	evlist->core.mmap_len = evlist__mmap_size(pages);
 	pr_debug("mmap size %zuB\n", evlist->core.mmap_len);
-	mp.mask = evlist->core.mmap_len - page_size - 1;
+	mp.core.mask = evlist->core.mmap_len - page_size - 1;
 
 	auxtrace_mmap_params__init(&mp.auxtrace_mp, evlist->core.mmap_len,
 				   auxtrace_pages, auxtrace_overwrite);
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index a35dc57d5995..a496ced5ed2a 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -370,8 +370,8 @@ int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
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
index e567c1c875bd..4ff75d8aeb05 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -37,7 +37,8 @@ struct mmap {
 };
 
 struct mmap_params {
-	int prot, mask, nr_cblocks, affinity, flush, comp_level;
+	struct perf_mmap_param core;
+	int nr_cblocks, affinity, flush, comp_level;
 	struct auxtrace_mmap_params auxtrace_mp;
 };
 
-- 
2.21.0

