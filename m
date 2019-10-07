Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1589BC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA84721721
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570452954;
	bh=dT2PV2y5VAfcZAMOsawykEoLRF4tltjrOyQzVukVfSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sJbgGjyCeyIzau+nOrssTlZJQon+Op2+ihFASOYXJQTJgW8LBToWSjibKVztCvlKM
	 16fBNfKU5CDx4i+ATXDJXP6QRmOEgDOt1HbYF2p31SXjl7LBQidFLQunRKUerZZ4pV
	 ++RCSxdawGY+i6PiD2N2kbvRcPml0jWlEbR+eLNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbfJGMzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:55:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59480 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbfJGMyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:54:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B1070883853;
        Mon,  7 Oct 2019 12:54:20 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F2405D9CC;
        Mon,  7 Oct 2019 12:54:17 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 15/36] libperf: Add perf_evlist_mmap_ops::idx callback
Date:   Mon,  7 Oct 2019 14:53:23 +0200
Message-Id: <20191007125344.14268-16-jolsa@kernel.org>
In-Reply-To: <20191007125344.14268-1-jolsa@kernel.org>
References: <20191007125344.14268-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Mon, 07 Oct 2019 12:54:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the perf_evlist_mmap_ops::idx callback to be called in mmap_per_cpu
and mmap_per_thread with current cpu and thread indexes.

It's used by current aux code, so perf will use this callback to set the
aux index.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-55-jolsa@kernel.org
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

