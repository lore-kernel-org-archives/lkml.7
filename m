Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9E4C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56AC2237C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458115;
	bh=84K9OP5/KEY79rRDdoAJs5BPv8pw8zdz8c2pmwu9rCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pRgoIH0a1ki4/8NSFQPIQksE3Ufu3Dz299j5O2RSFHmUuWt/MN1n47At1PkY1BXbY
	 gUngbSLMkwZNnrJeJ091D4o5GzjKSkffEZZ6gPRUJfCuSa9CbqxGXz8+Q4MClqbpE8
	 1WXmEFIfQSc933xt3RGYBMZPJzlrxM+z2paGxxik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389455AbfIZAfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389070AbfIZAfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:35:13 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B6D5222C1;
        Thu, 26 Sep 2019 00:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458112;
        bh=84K9OP5/KEY79rRDdoAJs5BPv8pw8zdz8c2pmwu9rCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X2S8QLLuGjlOf9v8SsbUKhnztvKyNsVjngR61wQQIBAegn3W/5wBqKOFDFQ4BEPXO
         sggprYxUf8zi7ioK5Y5KaIaVAJHQMzXQgbzmuE+Jfrm3357G0s0xhkOb2VC+ukNpaA
         3Y6kkgeqip8sck8Kf0liUmP/gJc5GX+i5hDPgL50=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 37/66] libperf: Move 'sample_id' from 'struct evsel' to 'struct perf_evsel'
Date:   Wed, 25 Sep 2019 21:32:15 -0300
Message-Id: <20190926003244.13962-38-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move 'sample_id' array from 'struct evsel' to libperf's 'struct perf_evsel'.

Committer notes:

Removed the 'struct xyarray' from util/evsel.h, not needed anymore
there.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-24-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c               |  2 +-
 tools/perf/lib/include/internal/evsel.h |  1 +
 tools/perf/util/evlist.c                |  4 ++--
 tools/perf/util/evsel.c                 | 12 ++++++------
 tools/perf/util/evsel.h                 |  2 --
 5 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 0d55eb6bd6e2..468fc49420ce 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -235,7 +235,7 @@ static int write_stat_round_event(u64 tm, u64 type)
 #define WRITE_STAT_ROUND_EVENT(time, interval) \
 	write_stat_round_event(time, PERF_STAT_ROUND_TYPE__ ## interval)
 
-#define SID(e, x, y) xyarray__entry(e->sample_id, x, y)
+#define SID(e, x, y) xyarray__entry(e->core.sample_id, x, y)
 
 static int
 perf_evsel__write_stat_event(struct evsel *counter, u32 cpu, u32 thread,
diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
index 60daee6db914..1ddb969f7807 100644
--- a/tools/perf/lib/include/internal/evsel.h
+++ b/tools/perf/lib/include/internal/evsel.h
@@ -17,6 +17,7 @@ struct perf_evsel {
 	struct perf_cpu_map	*own_cpus;
 	struct perf_thread_map	*threads;
 	struct xyarray		*fd;
+	struct xyarray		*sample_id;
 
 	/* parse modifier helper */
 	int			 nr_members;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 13595e8e6b4b..84b409802298 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -50,7 +50,7 @@ int sigqueue(pid_t pid, int sig, const union sigval value);
 #endif
 
 #define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
-#define SID(e, x, y) xyarray__entry(e->sample_id, x, y)
+#define SID(e, x, y) xyarray__entry(e->core.sample_id, x, y)
 
 void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 		  struct perf_thread_map *threads)
@@ -1021,7 +1021,7 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 
 	evlist__for_each_entry(evlist, evsel) {
 		if ((evsel->core.attr.read_format & PERF_FORMAT_ID) &&
-		    evsel->sample_id == NULL &&
+		    evsel->core.sample_id == NULL &&
 		    perf_evsel__alloc_id(evsel, perf_cpu_map__nr(cpus), threads->nr) < 0)
 			return -ENOMEM;
 	}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 566c9413246c..cb1ada8cf4a4 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1235,14 +1235,14 @@ int perf_evsel__alloc_id(struct evsel *evsel, int ncpus, int nthreads)
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
 
@@ -1251,8 +1251,8 @@ int perf_evsel__alloc_id(struct evsel *evsel, int ncpus, int nthreads)
 
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
index f757ff449a17..2d2c6cad81f8 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -96,7 +96,6 @@ enum perf_tool_event {
 
 struct bpf_object;
 struct perf_counts;
-struct xyarray;
 
 /** struct evsel - event selector
  *
@@ -117,7 +116,6 @@ struct evsel {
 	struct perf_evsel	core;
 	struct evlist	*evlist;
 	char			*filter;
-	struct xyarray		*sample_id;
 	u64			*id;
 	struct perf_counts	*counts;
 	struct perf_counts	*prev_raw_counts;
-- 
2.21.0

