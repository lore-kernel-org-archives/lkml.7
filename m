Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B635C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BF521835
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824673;
	bh=skrCT3K/eqt15gi8/6EmFta2QOrmw+Yv/2qiuO/6mwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ELJr1OQeZacHvDnjbRwVfMAD0EPStl8kzZF95Ymqn11c0hXPt9s3BEGp2DhQE/IpD
	 WstezjIUocOygZqbwGWDIdLpcmKGDCi4wPFr0oiQqiR8gKpurPlKdCOVvmlIlzhkAX
	 vqsiXbzyRfS+TWjF8+9dFeTC4ih8gfA3ISvuSNg8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbfJKULL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:11:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729744AbfJKULJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:11:09 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 291C0222D2;
        Fri, 11 Oct 2019 20:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824668;
        bh=skrCT3K/eqt15gi8/6EmFta2QOrmw+Yv/2qiuO/6mwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NlI0sLL8VMp0CFzxWB66321rG0jSBk3OGeDpjVdwYnI9nsmT3e9Xp2WTtezNm98zl
         pGQmW2GPt0MkrcoDtxPHnedAmavVeuaPcYMgvA6a9N6asuJUBx3wfzQVIzUNsvVDbH
         Ij2Bv9/LTXElwLGZHD2VXZv0XCR9haRyF638vSoo=
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
Subject: [PATCH 56/69] libperf: Introduce perf_evlist_mmap_ops::idx callback
Date:   Fri, 11 Oct 2019 17:05:46 -0300
Message-Id: <20191011200559.7156-57-acme@kernel.org>
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

Add the perf_evlist_mmap_ops::idx callback to be called in
mmap_per_cpu() and mmap_per_thread() with current cpu and thread
indexes.

It's used by current aux code, so perf will use this callback to set the
aux index.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-16-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c                  | 18 +++++++++++++-----
 tools/perf/lib/include/internal/evlist.h |  4 ++++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 88d63f5cd9ca..3832d3e9a3b4 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -426,7 +426,8 @@ mmap_per_evsel(struct perf_evlist *evlist, int idx,
 }
 
 static int
-mmap_per_thread(struct perf_evlist *evlist, struct perf_mmap_param *mp)
+mmap_per_thread(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
+		struct perf_mmap_param *mp)
 {
 	int thread;
 	int nr_threads = perf_thread_map__nr(evlist->threads);
@@ -435,6 +436,9 @@ mmap_per_thread(struct perf_evlist *evlist, struct perf_mmap_param *mp)
 		int output = -1;
 		int output_overwrite = -1;
 
+		if (ops->idx)
+			ops->idx(evlist, mp, thread, false);
+
 		if (mmap_per_evsel(evlist, thread, mp, 0, thread,
 				   &output, &output_overwrite))
 			goto out_unmap;
@@ -448,7 +452,8 @@ mmap_per_thread(struct perf_evlist *evlist, struct perf_mmap_param *mp)
 }
 
 static int
-mmap_per_cpu(struct perf_evlist *evlist, struct perf_mmap_param *mp)
+mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
+	     struct perf_mmap_param *mp)
 {
 	int nr_threads = perf_thread_map__nr(evlist->threads);
 	int nr_cpus    = perf_cpu_map__nr(evlist->cpus);
@@ -458,6 +463,9 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_mmap_param *mp)
 		int output = -1;
 		int output_overwrite = -1;
 
+		if (ops->idx)
+			ops->idx(evlist, mp, cpu, true);
+
 		for (thread = 0; thread < nr_threads; thread++) {
 			if (mmap_per_evsel(evlist, cpu, mp, cpu,
 					   thread, &output, &output_overwrite))
@@ -496,15 +504,15 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 	}
 
 	if (perf_cpu_map__empty(cpus))
-		return mmap_per_thread(evlist, mp);
+		return mmap_per_thread(evlist, ops, mp);
 
-	return mmap_per_cpu(evlist, mp);
+	return mmap_per_cpu(evlist, ops, mp);
 }
 
 int perf_evlist__mmap(struct perf_evlist *evlist, int pages)
 {
 	struct perf_mmap_param mp;
-	struct perf_evlist_mmap_ops ops;
+	struct perf_evlist_mmap_ops ops = { 0 };
 
 	evlist->mmap_len = (pages + 1) * page_size;
 	mp.mask = evlist->mmap_len - page_size - 1;
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index e5f092ff6202..053f620696f3 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -27,7 +27,11 @@ struct perf_evlist {
 	struct perf_mmap	*mmap_ovw;
 };
 
+typedef void
+(*perf_evlist_mmap__cb_idx_t)(struct perf_evlist*, struct perf_mmap_param*, int, bool);
+
 struct perf_evlist_mmap_ops {
+	perf_evlist_mmap__cb_idx_t	idx;
 };
 
 int perf_evlist__alloc_pollfd(struct perf_evlist *evlist);
-- 
2.21.0

