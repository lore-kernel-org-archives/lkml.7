Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE04C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBFA20640
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381290;
	bh=E+2GyDF2GpOdDe1jvJJqYR6qDgBAdOdvnLQWd2ZCtrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hVhxEn5h28iK0cZ4cNDlovPClInxdVvK/+hBs1Hj0wXP9wr9Ee8+2UJilHsG8JCoD
	 Y4ePYJ3SArqjxOHeQaZpUhv5LqzZny5f13NuKtDMHxps+MXFwzYTpHpwt73FN+Cgyn
	 MreO1Fm16yGjZoNHGLGdYyOJDuyUP01V9eWto5VU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391013AbfIMNZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:25:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391379AbfIMNZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:25:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F41210DCC80;
        Fri, 13 Sep 2019 13:25:31 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10B495C1D4;
        Fri, 13 Sep 2019 13:25:28 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 36/73] libperf: Add perf_evlist__alloc_pollfd function
Date:   Fri, 13 Sep 2019 15:23:18 +0200
Message-Id: <20190913132355.21634-37-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Fri, 13 Sep 2019 13:25:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move perf_evlist__alloc_pollfd function under libperf,
it will be used in following patches.

Link: http://lkml.kernel.org/n/tip-ak1oqlj43qsbioo7q9m5fg9t@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evlist.c                  | 21 +++++++++++++++++++++
 tools/perf/lib/include/internal/evlist.h |  2 ++
 tools/perf/util/evlist.c                 | 23 +----------------------
 tools/perf/util/evlist.h                 |  1 -
 4 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 35467d99cea5..0f84f5dc519f 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -237,3 +237,24 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist,
 	perf_evlist__id_add(evlist, evsel, cpu, thread, id);
 	return 0;
 }
+
+int perf_evlist__alloc_pollfd(struct perf_evlist *evlist)
+{
+	int nr_cpus = perf_cpu_map__nr(evlist->cpus);
+	int nr_threads = perf_thread_map__nr(evlist->threads);
+	int nfds = 0;
+	struct perf_evsel *evsel;
+
+	perf_evlist__for_each_entry(evlist, evsel) {
+		if (evsel->system_wide)
+			nfds += nr_cpus;
+		else
+			nfds += nr_cpus * nr_threads;
+	}
+
+	if (fdarray__available_entries(&evlist->pollfd) < nfds &&
+	    fdarray__grow(&evlist->pollfd, nfds) < 0)
+		return -ENOMEM;
+
+	return 0;
+}
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 7d64185cfabd..88c0dfaf0ddc 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -24,6 +24,8 @@ struct perf_evlist {
 	struct hlist_head	 heads[PERF_EVLIST__HLIST_SIZE];
 };
 
+int perf_evlist__alloc_pollfd(struct perf_evlist *evlist);
+
 /**
  * __perf_evlist__for_each_entry - iterate thru all the evsels
  * @list: list_head instance to iterate
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 433e9af6e063..664c8e87ec96 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -397,27 +397,6 @@ int perf_evlist__enable_event_idx(struct evlist *evlist,
 		return perf_evlist__enable_event_thread(evlist, evsel, idx);
 }
 
-int perf_evlist__alloc_pollfd(struct evlist *evlist)
-{
-	int nr_cpus = perf_cpu_map__nr(evlist->core.cpus);
-	int nr_threads = perf_thread_map__nr(evlist->core.threads);
-	int nfds = 0;
-	struct evsel *evsel;
-
-	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->core.system_wide)
-			nfds += nr_cpus;
-		else
-			nfds += nr_cpus * nr_threads;
-	}
-
-	if (fdarray__available_entries(&evlist->core.pollfd) < nfds &&
-	    fdarray__grow(&evlist->core.pollfd, nfds) < 0)
-		return -ENOMEM;
-
-	return 0;
-}
-
 static int __perf_evlist__add_pollfd(struct evlist *evlist, int fd,
 				     struct mmap *map, short revent)
 {
@@ -943,7 +922,7 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 	if (!evlist->mmap)
 		return -ENOMEM;
 
-	if (evlist->core.pollfd.entries == NULL && perf_evlist__alloc_pollfd(evlist) < 0)
+	if (evlist->core.pollfd.entries == NULL && perf_evlist__alloc_pollfd(&evlist->core) < 0)
 		return -ENOMEM;
 
 	evlist->core.mmap_len = evlist__mmap_size(pages);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 204315516c32..9c90df51ce08 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -114,7 +114,6 @@ perf_evlist__find_tracepoint_by_name(struct evlist *evlist,
 				     const char *name);
 
 int perf_evlist__add_pollfd(struct evlist *evlist, int fd);
-int perf_evlist__alloc_pollfd(struct evlist *evlist);
 int perf_evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask);
 
 int perf_evlist__poll(struct evlist *evlist, int timeout);
-- 
2.21.0

