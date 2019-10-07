Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44F6C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B67B222C5
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570452886;
	bh=YxJVDFh7s7zwJ4h8mW3Q1u8yVU4GCbqwLI9964sRRlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SJISlGgADgBwfnajgteR936Q8c/6G1XAcaMc8bG3VGSpmJX7+RTYawf58WVd1n4S5
	 wFl6SjsvEBy1z/U5K8Q8IiRlQUkDQd+zbWOl6LZ5sW1GmruxB2vafelzbSU0UdoL3g
	 7dgzVNL7OTRkL2CF1nau+TqKwlqNl1Jxp81w7FDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfJGMyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:54:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728372AbfJGMyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:54:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E3BE410DCC82;
        Mon,  7 Oct 2019 12:54:40 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95EA05D9CC;
        Mon,  7 Oct 2019 12:54:38 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 23/36] libperf: Move pollfd allocation to libperf
Date:   Mon,  7 Oct 2019 14:53:31 +0200
Message-Id: <20191007125344.14268-24-jolsa@kernel.org>
In-Reply-To: <20191007125344.14268-1-jolsa@kernel.org>
References: <20191007125344.14268-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Mon, 07 Oct 2019 12:54:41 +0000 (UTC)
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
index f9a802d2ceb5..5ae1da97d2e6 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -34,6 +34,7 @@ void perf_evlist__init(struct perf_evlist *evlist)
 		INIT_HLIST_HEAD(&evlist->heads[i]);
 	INIT_LIST_HEAD(&evlist->entries);
 	evlist->nr_entries = 0;
+	fdarray__init(&evlist->pollfd, 64);
 }
 
 static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
@@ -114,6 +115,7 @@ void perf_evlist__delete(struct perf_evlist *evlist)
 		return;
 
 	perf_evlist__munmap(evlist);
+	fdarray__exit(&evlist->pollfd);
 	free(evlist);
 }
 
@@ -525,6 +527,9 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 			return -ENOMEM;
 	}
 
+	if (evlist->pollfd.entries == NULL && perf_evlist__alloc_pollfd(evlist) < 0)
+		return -ENOMEM;
+
 	if (perf_cpu_map__empty(cpus))
 		return mmap_per_thread(evlist, ops, mp);
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index bbefb81a6364..71679cce7257 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -58,7 +58,6 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 {
 	perf_evlist__init(&evlist->core);
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
-	fdarray__init(&evlist->core.pollfd, 64);
 	evlist->workload.pid = -1;
 	evlist->bkw_mmap_state = BKW_MMAP_NOTREADY;
 }
@@ -805,9 +804,6 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
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

