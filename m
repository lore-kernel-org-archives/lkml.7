Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDBBFA3736
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1EA21835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571309973;
	bh=ck+tk6Ou5YJ5sneDMWh2Q6tu5DRqVs64ilV4DHYuQb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aSBorVSSufgCTJncd/Ot5/EWSkjGhVayrI7O+mjKyThcqS64Ht8HWDJk2dHDRErIB
	 ucrWAxUtV9kFUoo78IeC+8wr4N7yPuGI0IqWEm8uWKRoghQejiKJ7QLKaDeA2RFqBe
	 Ls/h5iJtpZEOSnkOT0FruvQzlG/Ss69TLGX1Efpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409210AbfJQK7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 06:59:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41382 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729441AbfJQK7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 06:59:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D967F8980E9;
        Thu, 17 Oct 2019 10:59:29 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 990205D70D;
        Thu, 17 Oct 2019 10:59:27 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 03/10] libperf: Move mask setup to perf_evlist__mmap_ops function
Date:   Thu, 17 Oct 2019 12:59:11 +0200
Message-Id: <20191017105918.20873-4-jolsa@kernel.org>
In-Reply-To: <20191017105918.20873-1-jolsa@kernel.org>
References: <20191017105918.20873-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Thu, 17 Oct 2019 10:59:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving mask setup to perf_evlist__mmap_ops function,
because it's same on both perf and libperf path.

Link: http://lkml.kernel.org/n/tip-z31pepohuxlgecf6400wbvt0@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evlist.c  | 3 ++-
 tools/perf/util/evlist.c | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 73aac6bb2ac5..205ddbb80bc1 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -578,6 +578,8 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 	if (!ops || !ops->get || !ops->mmap)
 		return -EINVAL;
 
+	mp->mask = evlist->mmap_len - page_size - 1;
+
 	evlist->nr_mmaps = perf_evlist__nr_mmaps(evlist);
 
 	perf_evlist__for_each_entry(evlist, evsel) {
@@ -605,7 +607,6 @@ int perf_evlist__mmap(struct perf_evlist *evlist, int pages)
 	};
 
 	evlist->mmap_len = (pages + 1) * page_size;
-	mp.mask = evlist->mmap_len - page_size - 1;
 
 	return perf_evlist__mmap_ops(evlist, &ops, &mp);
 }
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 5cded4ec5806..fdce590d2278 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -813,7 +813,6 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 
 	evlist->core.mmap_len = evlist__mmap_size(pages);
 	pr_debug("mmap size %zuB\n", evlist->core.mmap_len);
-	mp.core.mask = evlist->core.mmap_len - page_size - 1;
 
 	auxtrace_mmap_params__init(&mp.auxtrace_mp, evlist->core.mmap_len,
 				   auxtrace_pages, auxtrace_overwrite);
-- 
2.21.0

