Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC4EC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE46020640
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381193;
	bh=ENYyIfhEYMlDNZDuy7Hc5+sYFZRWRY0WEdWrneNLE1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uS4QhKH9wWwcjtGarQsE6pdSFBL+oEuUdkjm5rUfpLckmvn1F8+CRfgZNqb/pWxtl
	 d6dMZvYeVxKHWz2FbFDBDu7nswdE+tIH20xMjpP9zvpiyWmh8749Yfle/MOmA81/1j
	 Wugr27pCG3NdBzqtzljuB9eX6OoYhOqLijZBW1UY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391076AbfIMN0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:26:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59738 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403815AbfIMN0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:26:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 90D9D18C427D;
        Fri, 13 Sep 2019 13:26:29 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB3AB5C1D4;
        Fri, 13 Sep 2019 13:26:27 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 62/73] libperf: Add perf_evlist__exit function
Date:   Fri, 13 Sep 2019 15:23:44 +0200
Message-Id: <20190913132355.21634-63-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Fri, 13 Sep 2019 13:26:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_evlist__exit function, so far it's not
exported and added only for internal use for perf
and libperf.

Using it to release cpus/threads and pollfd array.

Link: http://lkml.kernel.org/n/tip-1n61vkdnvfqaeb7k4mwlvs1h@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evlist.c                  | 15 ++++++++++++---
 tools/perf/lib/include/internal/evlist.h |  2 ++
 tools/perf/util/evlist.c                 |  6 +-----
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index e27fe1fcef3d..b9dd040a6162 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -107,11 +107,20 @@ perf_evlist__next(struct perf_evlist *evlist, struct perf_evsel *prev)
 	return next;
 }
 
-void perf_evlist__delete(struct perf_evlist *evlist)
+void perf_evlist__exit(struct perf_evlist *evlist)
 {
-	free(evlist->mmap);
-	free(evlist->mmap_ovw);
+	perf_cpu_map__put(evlist->cpus);
+	perf_thread_map__put(evlist->threads);
+	evlist->cpus = NULL;
+	evlist->threads = NULL;
+	zfree(&evlist->mmap);
+	zfree(&evlist->mmap_ovw);
 	fdarray__exit(&evlist->pollfd);
+}
+
+void perf_evlist__delete(struct perf_evlist *evlist)
+{
+	perf_evlist__exit(evlist);
 	free(evlist);
 }
 
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 851837ce4ff8..1ca822eeab1d 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -48,6 +48,8 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 			  struct perf_evlist_mmap_ops *ops,
 			  struct perf_mmap_param *mp);
 
+void perf_evlist__exit(struct perf_evlist *evlist);
+
 /**
  * __perf_evlist__for_each_entry - iterate thru all the evsels
  * @list: list_head instance to iterate
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 728a15cddda7..0c69621e2b2e 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -137,7 +137,7 @@ void evlist__exit(struct evlist *evlist)
 {
 	zfree(&evlist->mmap);
 	zfree(&evlist->overwrite_mmap);
-	fdarray__exit(&evlist->core.pollfd);
+	perf_evlist__exit(&evlist->core);
 }
 
 void evlist__delete(struct evlist *evlist)
@@ -147,10 +147,6 @@ void evlist__delete(struct evlist *evlist)
 
 	evlist__munmap(evlist);
 	evlist__close(evlist);
-	perf_cpu_map__put(evlist->core.cpus);
-	perf_thread_map__put(evlist->core.threads);
-	evlist->core.cpus = NULL;
-	evlist->core.threads = NULL;
 	evlist__purge(evlist);
 	evlist__exit(evlist);
 	free(evlist);
-- 
2.21.0

