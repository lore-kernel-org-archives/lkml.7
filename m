Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCE5C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C8D206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381103;
	bh=Nc5xFNdnqDzNILwVETfwrGMbtyPW5kvs8szg2wKpJTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RKULm2GGBB3fuslZbB0HZ0a01j0XdqwIObqhElGJBg+Q0886p/OpWZ3fW/ndZOdWH
	 OjPmCRW4Xr/qGED+RGat+Gu2pAVTZAPfb0gDdyjxZ2vFRnVi2+h0+axwwR4OeLScv0
	 J7pQ4qLQ0WNARyTiFdgmGzvqT02ous/sEyU8OmxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391275AbfIMNZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:25:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391253AbfIMNY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:24:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0FB77301E13F;
        Fri, 13 Sep 2019 13:24:56 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69C645C22F;
        Fri, 13 Sep 2019 13:24:54 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 23/73] libperf: Move sample_id from struct evsel to struct perf_evsel
Date:   Fri, 13 Sep 2019 15:23:05 +0200
Message-Id: <20190913132355.21634-24-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 13 Sep 2019 13:24:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move sample_id array from struct evsel to libperf's struct perf_evsel.

Link: http://lkml.kernel.org/n/tip-kmjcz9zfed37v38vk3euvp8w@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c               |  2 +-
 tools/perf/lib/include/internal/evsel.h |  1 +
 tools/perf/util/evlist.c                |  4 ++--
 tools/perf/util/evsel.c                 | 12 ++++++------
 tools/perf/util/evsel.h                 |  1 -
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 35897048ba53..292fccf8f13c 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -233,7 +233,7 @@ static int write_stat_round_event(u64 tm, u64 type)
 #define WRITE_STAT_ROUND_EVENT(time, interval) \
 	write_stat_round_event(time, PERF_STAT_ROUND_TYPE__ ## interval)
 
-#define SID(e, x, y) xyarray__entry(e->sample_id, x, y)
+#define SID(e, x, y) xyarray__entry(e->core.sample_id, x, y)
 
 static int
 perf_evsel__write_stat_event(struct evsel *counter, u32 cpu, u32 thread,
diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
index 220cb2e2b54e..d284825383af 100644
--- a/tools/perf/lib/include/internal/evsel.h
+++ b/tools/perf/lib/include/internal/evsel.h
@@ -15,6 +15,7 @@ struct perf_evsel {
 	struct perf_cpu_map	*own_cpus;
 	struct perf_thread_map	*threads;
 	struct xyarray		*fd;
+	struct xyarray		*sample_id;
 
 	/* parse modifier helper */
 	int			 nr_members;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 8f5b28eefde7..4018f0ff75c8 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -49,7 +49,7 @@ int sigqueue(pid_t pid, int sig, const union sigval value);
 #endif
 
 #define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
-#define SID(e, x, y) xyarray__entry(e->sample_id, x, y)
+#define SID(e, x, y) xyarray__entry(e->core.sample_id, x, y)
 
 void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 		  struct perf_thread_map *threads)
@@ -1020,7 +1020,7 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 
 	evlist__for_each_entry(evlist, evsel) {
 		if ((evsel->core.attr.read_format & PERF_FORMAT_ID) &&
-		    evsel->sample_id == NULL &&
+		    evsel->core.sample_id == NULL &&
 		    perf_evsel__alloc_id(evsel, perf_cpu_map__nr(cpus), threads->nr) < 0)
 			return -ENOMEM;
 	}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 9dcee5a8875e..db89f98bb357 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1234,14 +1234,14 @@ int perf_evsel__alloc_id(struct evsel *evsel, int ncpus, int nthreads)
 	if (evsel->core.system_wide)
 		nthreads = 1;
 
-	evsel->sample_id = xyarray__new(ncpus, nthreads, sizeof(struct perf_sample_id));
-	if (evsel->sample_id == NULL)
+	evsel->core.sample_id = xyarray__new(ncpus, nthreads, sizeof(struct perf_sample_id));
+	if (evsel->core.sample_id == NULL)
 		return -ENOMEM;
 
 	evsel->id = zalloc(ncpus * nthreads * sizeof(u64));
 	if (evsel->id == NULL) {
-		xyarray__delete(evsel->sample_id);
-		evsel->sample_id = NULL;
+		xyarray__delete(evsel->core.sample_id);
+		evsel->core.sample_id = NULL;
 		return -ENOMEM;
 	}
 
@@ -1250,8 +1250,8 @@ int perf_evsel__alloc_id(struct evsel *evsel, int ncpus, int nthreads)
 
 static void perf_evsel__free_id(struct evsel *evsel)
 {
-	xyarray__delete(evsel->sample_id);
-	evsel->sample_id = NULL;
+	xyarray__delete(evsel->core.sample_id);
+	evsel->core.sample_id = NULL;
 	zfree(&evsel->id);
 	evsel->ids = 0;
 }
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index eb4d03cd0b17..9934e99e0c64 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -117,7 +117,6 @@ struct evsel {
 	struct perf_evsel	core;
 	struct evlist	*evlist;
 	char			*filter;
-	struct xyarray		*sample_id;
 	u64			*id;
 	struct perf_counts	*counts;
 	struct perf_counts	*prev_raw_counts;
-- 
2.21.0

