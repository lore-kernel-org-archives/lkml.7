Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C88C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25D9206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381056;
	bh=mRZ/DVBNNqn8hyak6QKrB9vnGwoQnxEz8pcY7rHAE/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FjUyLMbt/pBuPzwJCaMcDGhoqV6HMotwJATkxJYsywxZCymsL0uUTkujlXiO/7oZi
	 DyvincEDqGgL0Kcumjz25N5znYhrgzV3DbkWEjT0rRRSC+gXvkMLLvD5jSeGojtyTn
	 yH1Jaqt6YJfkK7NXt1d1ALY+6kBtamUb0RknXnOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391126AbfIMNYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:24:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391115AbfIMNYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:24:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C09AA8AC6FF;
        Fri, 13 Sep 2019 13:24:12 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A5065C1D4;
        Fri, 13 Sep 2019 13:24:10 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 05/73] perf tools: Rename perf_evlist__munmap() to evlist__munmap()
Date:   Fri, 13 Sep 2019 15:22:47 +0200
Message-Id: <20190913132355.21634-6-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Fri, 13 Sep 2019 13:24:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename perf_evlist__munmap() to evlist__munmap(), so we don't have a
name clash when we add perf_evlist__munmap() in libperf.

Link: http://lkml.kernel.org/n/tip-h4rbsk52cvvj0kapg6ugstmj@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/backward-ring-buffer.c |  2 +-
 tools/perf/util/evlist.c                | 12 ++++++------
 tools/perf/util/evlist.h                |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index f1eb7e9c1d7d..3073a68d17b9 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -75,7 +75,7 @@ static int do_test(struct evlist *evlist, int mmap_pages,
 	evlist__disable(evlist);
 
 	err = count_samples(evlist, sample_count, comm_count);
-	perf_evlist__munmap(evlist);
+	evlist__munmap(evlist);
 	return err;
 }
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 5ca726c15cce..cc11b1a22042 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -149,7 +149,7 @@ void evlist__delete(struct evlist *evlist)
 	if (evlist == NULL)
 		return;
 
-	perf_evlist__munmap(evlist);
+	evlist__munmap(evlist);
 	evlist__close(evlist);
 	perf_cpu_map__put(evlist->core.cpus);
 	perf_thread_map__put(evlist->core.threads);
@@ -673,7 +673,7 @@ static int perf_evlist__resume(struct evlist *evlist)
 	return perf_evlist__set_paused(evlist, false);
 }
 
-static void perf_evlist__munmap_nofree(struct evlist *evlist)
+static void evlist__munmap_nofree(struct evlist *evlist)
 {
 	int i;
 
@@ -686,9 +686,9 @@ static void perf_evlist__munmap_nofree(struct evlist *evlist)
 			perf_mmap__munmap(&evlist->overwrite_mmap[i]);
 }
 
-void perf_evlist__munmap(struct evlist *evlist)
+void evlist__munmap(struct evlist *evlist)
 {
-	perf_evlist__munmap_nofree(evlist);
+	evlist__munmap_nofree(evlist);
 	zfree(&evlist->mmap);
 	zfree(&evlist->overwrite_mmap);
 }
@@ -835,7 +835,7 @@ static int evlist__mmap_per_cpu(struct evlist *evlist,
 	return 0;
 
 out_unmap:
-	perf_evlist__munmap_nofree(evlist);
+	evlist__munmap_nofree(evlist);
 	return -1;
 }
 
@@ -861,7 +861,7 @@ static int evlist__mmap_per_thread(struct evlist *evlist,
 	return 0;
 
 out_unmap:
-	perf_evlist__munmap_nofree(evlist);
+	evlist__munmap_nofree(evlist);
 	return -1;
 }
 
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index aaf06182c1b8..f07501602353 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -175,7 +175,7 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 			 bool auxtrace_overwrite, int nr_cblocks,
 			 int affinity, int flush, int comp_level);
 int evlist__mmap(struct evlist *evlist, unsigned int pages);
-void perf_evlist__munmap(struct evlist *evlist);
+void evlist__munmap(struct evlist *evlist);
 
 size_t evlist__mmap_size(unsigned long pages);
 
-- 
2.21.0

