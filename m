Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203E8C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9F9206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381178;
	bh=BAU2n/NPbBjDwgw5wDpjrL2l7oMsf63M+XRrGUno9Lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uFkNRl3NOmKKzbbOTaUl5QoLVDnZCq2fc60OegO+B8YDpakQd26P44nQYudau56N1
	 9RJnsWXHsS7w24i9stTpuexM5ugs+uIh+64lI2FphA/x/wLjgGWvSZen8iJkuFeMPN
	 Gbq12Hkzv7u7daWXXc+cydiQsj+ety8kM6Z/oYfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391549AbfIMN0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:26:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391526AbfIMN0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:26:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D89C308FBA9;
        Fri, 13 Sep 2019 13:26:13 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 00C255C1D4;
        Fri, 13 Sep 2019 13:26:10 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 55/73] libperf: Add perf_evlist_mmap_ops::new callback
Date:   Fri, 13 Sep 2019 15:23:37 +0200
Message-Id: <20190913132355.21634-56-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 13 Sep 2019 13:26:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_evlist_mmap_ops::new callback to be called
in mmap_per_evsel to get/allocate the new 'struct perf_mmap'
object.

Adding libperf's perf_evlist__mmap_cb_new function as
libperf's new callback.

Link: http://lkml.kernel.org/n/tip-smr1w2e6j37ncbmsd1eet228@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evlist.c                  | 32 +++++++++++++++++-------
 tools/perf/lib/include/internal/evlist.h |  3 +++
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 67b5f14f738f..8caced7d489a 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -327,9 +327,23 @@ static void perf_evlist__set_sid_idx(struct perf_evlist *evlist,
 
 #define FD(e, x, y) (*(int *) xyarray__entry(e->fd, x, y))
 
+static struct perf_mmap*
+perf_evlist__mmap_cb_new(struct perf_evlist *evlist, bool overwrite, int idx)
+{
+	struct perf_mmap **maps, *map;
+
+	map = perf_mmap__new(overwrite, NULL);
+	if (map == NULL)
+		return NULL;
+
+	maps = overwrite ? evlist->mmap_ovw : evlist->mmap;
+	maps[idx] = map;
+	return map;
+}
+
 static int
-mmap_per_evsel(struct perf_evlist *evlist, int idx,
-	       struct perf_mmap_param *mp, int cpu_idx,
+mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
+	       int idx, struct perf_mmap_param *mp, int cpu_idx,
 	       int thread, int *_output, int *_output_overwrite)
 {
 	int evlist_cpu = perf_cpu_map__cpu(evlist->cpus, cpu_idx);
@@ -348,18 +362,16 @@ mmap_per_evsel(struct perf_evlist *evlist, int idx,
 		if (cpu == -1)
 			continue;
 
-		map = perf_mmap__new(overwrite, NULL);
+		map = ops->new(evlist, overwrite, idx);
 		if (map == NULL)
 			return -ENOMEM;
 
 		if (overwrite) {
 			mp->prot = PROT_READ;
 			output   = _output_overwrite;
-			evlist->mmap_ovw[idx] = map;
 		} else {
 			mp->prot = PROT_READ | PROT_WRITE;
 			output   = _output;
-			evlist->mmap[idx] = map;
 		}
 
 		fd = FD(evsel, cpu, thread);
@@ -410,7 +422,7 @@ mmap_per_thread(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 		if (ops->idx)
 			ops->idx(evlist, mp, thread, false);
 
-		if (mmap_per_evsel(evlist, thread, mp, 0, thread,
+		if (mmap_per_evsel(evlist, ops, thread, mp, 0, thread,
 				   &output, &output_overwrite))
 			goto out_unmap;
 	}
@@ -438,7 +450,7 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 			ops->idx(evlist, mp, cpu, true);
 
 		for (thread = 0; thread < nr_threads; thread++) {
-			if (mmap_per_evsel(evlist, cpu, mp, cpu,
+			if (mmap_per_evsel(evlist, ops, cpu, mp, cpu,
 					   thread, &output, &output_overwrite))
 				goto out_unmap;
 		}
@@ -459,7 +471,7 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 	const struct perf_cpu_map *cpus = evlist->cpus;
 	const struct perf_thread_map *threads = evlist->threads;
 
-	if (!ops)
+	if (!ops || !ops->new)
 		return -EINVAL;
 
 	perf_evlist__for_each_entry(evlist, evsel) {
@@ -478,7 +490,9 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 int perf_evlist__mmap(struct perf_evlist *evlist, int pages)
 {
 	struct perf_mmap_param mp;
-	struct perf_evlist_mmap_ops ops = { 0 };
+	struct perf_evlist_mmap_ops ops = {
+		.new = perf_evlist__mmap_cb_new,
+	};
 
 	if (!evlist->mmap && perf_evlist__alloc_maps(evlist))
 		return -ENOMEM;
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 64522b8237be..3cb836912ee6 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -29,9 +29,12 @@ struct perf_evlist {
 
 typedef void
 (*perf_evlist_mmap__cb_idx_t)(struct perf_evlist*, struct perf_mmap_param*, int, bool);
+typedef struct perf_mmap*
+(*perf_evlist_mmap__cb_new_t)(struct perf_evlist*, bool, int);
 
 struct perf_evlist_mmap_ops {
 	perf_evlist_mmap__cb_idx_t	idx;
+	perf_evlist_mmap__cb_new_t	new;
 };
 
 int perf_evlist__alloc_pollfd(struct perf_evlist *evlist);
-- 
2.21.0

