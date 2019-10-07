Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B8DC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4871321D6C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570452863;
	bh=ciKKPaUEV2sCRAD5Dgty9sg2qmGnwdlWp3sZ+9KeGHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uFefivvrl4Bc2aD63rGEV1olMv18wb3mdlNOAQWv9RFreZ4GXG7HAoF+AI6S9lD43
	 7hUGkHMgtXaFht3d/TId2g7HAa2U8duAxtbNyB7qgDMNweC6+rzmoM0BzDJIs839Br
	 jxgfRNNC1+Avs1QRae2Vbda/+8BcOuOyTCjO8eK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfJGMyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:54:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728207AbfJGMyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:54:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4CE99308FC4B;
        Mon,  7 Oct 2019 12:54:17 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A79C75ED21;
        Mon,  7 Oct 2019 12:54:15 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 14/36] libperf: Add perf_evlist__mmap_ops function
Date:   Mon,  7 Oct 2019 14:53:22 +0200
Message-Id: <20191007125344.14268-15-jolsa@kernel.org>
In-Reply-To: <20191007125344.14268-1-jolsa@kernel.org>
References: <20191007125344.14268-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 07 Oct 2019 12:54:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be able to pass specific callbacks to evlist's mmap.  There will be
specific call to this function from perf's evlist__mmap() and libperf's
perf_evlist__mmap() functions in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-54-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c                  | 24 ++++++++++++++++++------
 tools/perf/lib/include/internal/evlist.h |  8 ++++++++
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 250ad5752589..88d63f5cd9ca 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -472,12 +472,16 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_mmap_param *mp)
 	return -1;
 }
 
-int perf_evlist__mmap(struct perf_evlist *evlist, int pages)
+int perf_evlist__mmap_ops(struct perf_evlist *evlist,
+			  struct perf_evlist_mmap_ops *ops,
+			  struct perf_mmap_param *mp)
 {
 	struct perf_evsel *evsel;
 	const struct perf_cpu_map *cpus = evlist->cpus;
 	const struct perf_thread_map *threads = evlist->threads;
-	struct perf_mmap_param mp;
+
+	if (!ops)
+		return -EINVAL;
 
 	if (!evlist->mmap)
 		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
@@ -491,13 +495,21 @@ int perf_evlist__mmap(struct perf_evlist *evlist, int pages)
 			return -ENOMEM;
 	}
 
+	if (perf_cpu_map__empty(cpus))
+		return mmap_per_thread(evlist, mp);
+
+	return mmap_per_cpu(evlist, mp);
+}
+
+int perf_evlist__mmap(struct perf_evlist *evlist, int pages)
+{
+	struct perf_mmap_param mp;
+	struct perf_evlist_mmap_ops ops;
+
 	evlist->mmap_len = (pages + 1) * page_size;
 	mp.mask = evlist->mmap_len - page_size - 1;
 
-	if (perf_cpu_map__empty(cpus))
-		return mmap_per_thread(evlist, &mp);
-
-	return mmap_per_cpu(evlist, &mp);
+	return perf_evlist__mmap_ops(evlist, &ops, &mp);
 }
 
 void perf_evlist__munmap(struct perf_evlist *evlist)
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 4438a19ceba3..e5f092ff6202 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -11,6 +11,7 @@
 
 struct perf_cpu_map;
 struct perf_thread_map;
+struct perf_mmap_param;
 
 struct perf_evlist {
 	struct list_head	 entries;
@@ -26,10 +27,17 @@ struct perf_evlist {
 	struct perf_mmap	*mmap_ovw;
 };
 
+struct perf_evlist_mmap_ops {
+};
+
 int perf_evlist__alloc_pollfd(struct perf_evlist *evlist);
 int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd,
 			    void *ptr, short revent);
 
+int perf_evlist__mmap_ops(struct perf_evlist *evlist,
+			  struct perf_evlist_mmap_ops *ops,
+			  struct perf_mmap_param *mp);
+
 /**
  * __perf_evlist__for_each_entry - iterate thru all the evsels
  * @list: list_head instance to iterate
-- 
2.21.0

