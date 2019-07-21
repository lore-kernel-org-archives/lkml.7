Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C43FC76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054392147A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708739;
	bh=Rzys6/hk+eHYgmVVOVD8rJx5ouCVSGb+3lZH80+fhaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s+DO+7gJlXjV6p9gPABeUrVQ8YfNKs5bUvZnSq/8tRXipb7FSfQ8nD0p/2fOWuz5B
	 bV1M5OYNw3PHmJbSmdE+HX1JJA07HlCFJNqkbVZFv2Tuxfc/0/XgVjiV+HNthC85IB
	 JfwoeUEkfkxDzFjEFk2JrjHf0az3NYURVJm4ewd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfGULcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:32:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfGULcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:32:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A06A6307D935;
        Sun, 21 Jul 2019 11:32:16 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85D275D9D3;
        Sun, 21 Jul 2019 11:32:12 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 67/79] libperf: Add perf_evsel__cpus/threads functions
Date:   Sun, 21 Jul 2019 13:24:54 +0200
Message-Id: <20190721112506.12306-68-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Sun, 21 Jul 2019 11:32:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding following functions:
  perf_evsel__cpus
  perf_evsel__threads

to access evsel's cpus and threads objects

Link: http://lkml.kernel.org/n/tip-av17t1gqrv3nc2rwkiq03g7u@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evsel.c              | 10 ++++++++++
 tools/perf/lib/include/perf/evsel.h |  2 ++
 tools/perf/lib/libperf.map          |  2 ++
 tools/perf/util/evsel.h             |  2 +-
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index c3f3722e9f91..8dbe0e841b8f 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -215,3 +215,13 @@ int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter)
 				     PERF_EVENT_IOC_SET_FILTER,
 				     (void *)filter);
 }
+
+struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel)
+{
+	return evsel->cpus;
+}
+
+struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel)
+{
+	return evsel->threads;
+}
diff --git a/tools/perf/lib/include/perf/evsel.h b/tools/perf/lib/include/perf/evsel.h
index d1cbd77d5463..af5277debb81 100644
--- a/tools/perf/lib/include/perf/evsel.h
+++ b/tools/perf/lib/include/perf/evsel.h
@@ -32,5 +32,7 @@ LIBPERF_API int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
 				 struct perf_counts_values *count);
 LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
 LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
+LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
+LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
 
 #endif /* __LIBPERF_EVSEL_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index d4d34bea0b40..9f43b5cda031 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -21,6 +21,8 @@ LIBPERF_0.0.1 {
 		perf_evsel__open;
 		perf_evsel__close;
 		perf_evsel__read;
+		perf_evsel__cpus;
+		perf_evsel__threads;
 		perf_evlist__new;
 		perf_evlist__delete;
 		perf_evlist__init;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 0989fb2eb1ec..3cf35aa782b9 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -193,7 +193,7 @@ struct record_opts;
 
 static inline struct perf_cpu_map *evsel__cpus(struct evsel *evsel)
 {
-	return evsel->core.cpus;
+	return perf_evsel__cpus(&evsel->core);
 }
 
 static inline int perf_evsel__nr_cpus(struct evsel *evsel)
-- 
2.21.0

