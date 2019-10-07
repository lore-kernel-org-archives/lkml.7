Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2F4ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7558E205F4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570452865;
	bh=Wr8BPMSeF3S/agiUbnji2f3El4lPSBnnn/WxCXf49dE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zEPg5J6uO5n3J5n9Dpablq+ffFUexw6/3KUk1ttDk8Li6RN51zgWws0bmAistv9zt
	 iocIjGCLqdTnSXtyEJXbsu+ClEu8DzRKKgaadrVU2r6Nzu6mdGVhnTH5vfJ7+PQ9PG
	 msU3+JvM0BJKWMJdGXCabld/JfM7hP+fLd3Rjzvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfJGMyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:54:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbfJGMyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:54:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A10B318C891A;
        Mon,  7 Oct 2019 12:54:22 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A70E5D9CC;
        Mon,  7 Oct 2019 12:54:20 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 16/36] libperf: Add perf_evlist_mmap_ops::get callback
Date:   Mon,  7 Oct 2019 14:53:24 +0200
Message-Id: <20191007125344.14268-17-jolsa@kernel.org>
In-Reply-To: <20191007125344.14268-1-jolsa@kernel.org>
References: <20191007125344.14268-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Mon, 07 Oct 2019 12:54:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the perf_evlist_mmap_ops::get callback to be called in
mmap_per_evsel to get/allocate the 'struct perf_mmap' object.

Add the libperf's perf_evlist__mmap_cb_get() function as libperf's
get callback.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-56-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c                  | 18 ++++++++++--------
 tools/perf/lib/include/internal/evlist.h |  3 +++
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 3832d3e9a3b4..4f49de5e8f7c 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -340,7 +340,7 @@ static void perf_evlist__set_sid_idx(struct perf_evlist *evlist,
 }
 
 static struct perf_mmap*
-perf_evlist__map_get(struct perf_evlist *evlist, bool overwrite, int idx)
+perf_evlist__mmap_cb_get(struct perf_evlist *evlist, bool overwrite, int idx)
 {
 	struct perf_mmap *map = &evlist->mmap[idx];
 
@@ -359,8 +359,8 @@ perf_evlist__map_get(struct perf_evlist *evlist, bool overwrite, int idx)
 #define FD(e, x, y) (*(int *) xyarray__entry(e->fd, x, y))
 
 static int
-mmap_per_evsel(struct perf_evlist *evlist, int idx,
-	       struct perf_mmap_param *mp, int cpu_idx,
+mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
+	       int idx, struct perf_mmap_param *mp, int cpu_idx,
 	       int thread, int *_output, int *_output_overwrite)
 {
 	int evlist_cpu = perf_cpu_map__cpu(evlist->cpus, cpu_idx);
@@ -379,7 +379,7 @@ mmap_per_evsel(struct perf_evlist *evlist, int idx,
 		if (cpu == -1)
 			continue;
 
-		map = perf_evlist__map_get(evlist, overwrite, idx);
+		map = ops->get(evlist, overwrite, idx);
 		if (map == NULL)
 			return -ENOMEM;
 
@@ -439,7 +439,7 @@ mmap_per_thread(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 		if (ops->idx)
 			ops->idx(evlist, mp, thread, false);
 
-		if (mmap_per_evsel(evlist, thread, mp, 0, thread,
+		if (mmap_per_evsel(evlist, ops, thread, mp, 0, thread,
 				   &output, &output_overwrite))
 			goto out_unmap;
 	}
@@ -467,7 +467,7 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 			ops->idx(evlist, mp, cpu, true);
 
 		for (thread = 0; thread < nr_threads; thread++) {
-			if (mmap_per_evsel(evlist, cpu, mp, cpu,
+			if (mmap_per_evsel(evlist, ops, cpu, mp, cpu,
 					   thread, &output, &output_overwrite))
 				goto out_unmap;
 		}
@@ -488,7 +488,7 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 	const struct perf_cpu_map *cpus = evlist->cpus;
 	const struct perf_thread_map *threads = evlist->threads;
 
-	if (!ops)
+	if (!ops || !ops->get)
 		return -EINVAL;
 
 	if (!evlist->mmap)
@@ -512,7 +512,9 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 int perf_evlist__mmap(struct perf_evlist *evlist, int pages)
 {
 	struct perf_mmap_param mp;
-	struct perf_evlist_mmap_ops ops = { 0 };
+	struct perf_evlist_mmap_ops ops = {
+		.get = perf_evlist__mmap_cb_get,
+	};
 
 	evlist->mmap_len = (pages + 1) * page_size;
 	mp.mask = evlist->mmap_len - page_size - 1;
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 053f620696f3..9bc3a21643ea 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -29,9 +29,12 @@ struct perf_evlist {
 
 typedef void
 (*perf_evlist_mmap__cb_idx_t)(struct perf_evlist*, struct perf_mmap_param*, int, bool);
+typedef struct perf_mmap*
+(*perf_evlist_mmap__cb_get_t)(struct perf_evlist*, bool, int);
 
 struct perf_evlist_mmap_ops {
 	perf_evlist_mmap__cb_idx_t	idx;
+	perf_evlist_mmap__cb_get_t	get;
 };
 
 int perf_evlist__alloc_pollfd(struct perf_evlist *evlist);
-- 
2.21.0

