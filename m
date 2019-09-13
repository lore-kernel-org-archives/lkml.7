Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC1FC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E582186A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381256;
	bh=Bsg/a9hvjD13As6I0LClCcdlYxm02c8kQyspIobRWyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C30cNWDIWwjVmWBRvRR+81t3yIJQU0jCgnrz6AReIQf5BoXT8vblaapfoDEJbVTjU
	 N01DAaHsEIojJQI4MJ8q5C5Fmxitb4U//a2O0RiH8FQEYXQy9pQozCFHEthQcqwl3b
	 iFqNWu65WJRYtMukCNkpILe0zCbvdEOP+LvCX5Uc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391559AbfIMN0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:26:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49636 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391546AbfIMN0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:26:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 67C2781129;
        Fri, 13 Sep 2019 13:26:16 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ADEC55C1D4;
        Fri, 13 Sep 2019 13:26:13 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 56/73] libperf: Add perf_evlist_mmap_ops::mmap callback
Date:   Fri, 13 Sep 2019 15:23:38 +0200
Message-Id: <20190913132355.21634-57-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 13 Sep 2019 13:26:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_evlist_mmap_ops::mmap callback to be called
in mmap_per_evsel to actually mmap the map.

Adding libperf's perf_evlist__mmap_cb_mmap function as
libperf's mmap callback.

Link: http://lkml.kernel.org/n/tip-9cksnv3xbb1eset7ge67at4a@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evlist.c                  | 15 ++++++++++++---
 tools/perf/lib/include/internal/evlist.h |  3 +++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 8caced7d489a..ec83022cd62f 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -341,6 +341,14 @@ perf_evlist__mmap_cb_new(struct perf_evlist *evlist, bool overwrite, int idx)
 	return map;
 }
 
+static int
+perf_evlist__mmap_cb_mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
+			  int output, int cpu)
+{
+	refcount_set(&map->refcnt, 2);
+	return perf_mmap__mmap(map, mp, output, cpu);
+}
+
 static int
 mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 	       int idx, struct perf_mmap_param *mp, int cpu_idx,
@@ -379,7 +387,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 		if (*output == -1) {
 			*output = fd;
 
-			if (perf_mmap__mmap(map, mp, *output, evlist_cpu) < 0)
+			if (ops->mmap(map, mp, *output, evlist_cpu) < 0)
 				return -1;
 		} else {
 			if (ioctl(fd, PERF_EVENT_IOC_SET_OUTPUT, *output) != 0)
@@ -471,7 +479,7 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 	const struct perf_cpu_map *cpus = evlist->cpus;
 	const struct perf_thread_map *threads = evlist->threads;
 
-	if (!ops || !ops->new)
+	if (!ops || !ops->new || !ops->mmap)
 		return -EINVAL;
 
 	perf_evlist__for_each_entry(evlist, evsel) {
@@ -491,7 +499,8 @@ int perf_evlist__mmap(struct perf_evlist *evlist, int pages)
 {
 	struct perf_mmap_param mp;
 	struct perf_evlist_mmap_ops ops = {
-		.new = perf_evlist__mmap_cb_new,
+		.new  = perf_evlist__mmap_cb_new,
+		.mmap = perf_evlist__mmap_cb_mmap,
 	};
 
 	if (!evlist->mmap && perf_evlist__alloc_maps(evlist))
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 3cb836912ee6..851837ce4ff8 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -31,10 +31,13 @@ typedef void
 (*perf_evlist_mmap__cb_idx_t)(struct perf_evlist*, struct perf_mmap_param*, int, bool);
 typedef struct perf_mmap*
 (*perf_evlist_mmap__cb_new_t)(struct perf_evlist*, bool, int);
+typedef int
+(*perf_evlist_mmap__cb_mmap_t)(struct perf_mmap*, struct perf_mmap_param*, int, int);
 
 struct perf_evlist_mmap_ops {
 	perf_evlist_mmap__cb_idx_t	idx;
 	perf_evlist_mmap__cb_new_t	new;
+	perf_evlist_mmap__cb_mmap_t	mmap;
 };
 
 int perf_evlist__alloc_pollfd(struct perf_evlist *evlist);
-- 
2.21.0

