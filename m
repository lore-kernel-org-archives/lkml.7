Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0BEC4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4200720640
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381244;
	bh=iIbDka8HdZHPiYziEfEva7F17ZHjqhU7bkm3/SECReg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eAO7tTd/wHgO3SX7qlR6mHLOWgSW77QuBVpp3R9lP1oLhALbbvfwzkI/js1tsNjJv
	 xIPWb6cMZSN3+8OYJrPk4lvmADN4u0v7zg8fxGjGdiDRceQ4K4RgfA/2PXl6zXH5S+
	 Hr+FcZZwctZ9Gd38HMSKjWf5YB2OP7CbRXrmy/XA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390823AbfIMN0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:26:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403805AbfIMN01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:26:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9A76A30860C0;
        Fri, 13 Sep 2019 13:26:27 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3AC55C1D4;
        Fri, 13 Sep 2019 13:26:25 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 61/73] libperf: Move pollfd allocation to libperf
Date:   Fri, 13 Sep 2019 15:23:43 +0200
Message-Id: <20190913132355.21634-62-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 13 Sep 2019 13:26:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's needed in libperf only, moving it to
perf_evlist__mmap_ops function.

Link: http://lkml.kernel.org/n/tip-7lmjzpk6k2wfhh1os8qw1dxz@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evlist.c  | 5 +++++
 tools/perf/util/evlist.c | 4 ----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index ec83022cd62f..e27fe1fcef3d 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -32,6 +32,7 @@ void perf_evlist__init(struct perf_evlist *evlist)
 		INIT_HLIST_HEAD(&evlist->heads[i]);
 	INIT_LIST_HEAD(&evlist->entries);
 	evlist->nr_entries = 0;
+	fdarray__init(&evlist->pollfd, 64);
 }
 
 static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
@@ -110,6 +111,7 @@ void perf_evlist__delete(struct perf_evlist *evlist)
 {
 	free(evlist->mmap);
 	free(evlist->mmap_ovw);
+	fdarray__exit(&evlist->pollfd);
 	free(evlist);
 }
 
@@ -489,6 +491,9 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 			return -ENOMEM;
 	}
 
+	if (evlist->pollfd.entries == NULL && perf_evlist__alloc_pollfd(evlist) < 0)
+		return -ENOMEM;
+
 	if (perf_cpu_map__empty(cpus))
 		return mmap_per_thread(evlist, ops, mp);
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 94d8a1d96b81..728a15cddda7 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -57,7 +57,6 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 {
 	perf_evlist__init(&evlist->core);
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
-	fdarray__init(&evlist->core.pollfd, 64);
 	evlist->workload.pid = -1;
 	evlist->bkw_mmap_state = BKW_MMAP_NOTREADY;
 }
@@ -804,9 +803,6 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 	if (!evlist->mmap)
 		return -ENOMEM;
 
-	if (evlist->core.pollfd.entries == NULL && perf_evlist__alloc_pollfd(&evlist->core) < 0)
-		return -ENOMEM;
-
 	evlist->core.mmap_len = evlist__mmap_size(pages);
 	pr_debug("mmap size %zuB\n", evlist->core.mmap_len);
 	mp.core.mask = evlist->core.mmap_len - page_size - 1;
-- 
2.21.0

