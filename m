Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F3FC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 18:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9700921D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 18:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbfKGSRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 13:17:18 -0500
Received: from mga01.intel.com ([192.55.52.88]:60752 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfKGSQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 13:16:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 10:16:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,278,1569308400"; 
   d="scan'208";a="286064058"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga001.jf.intel.com with ESMTP; 07 Nov 2019 10:16:49 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id C5529301BEF; Thu,  7 Nov 2019 10:16:49 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     jolsa@kernel.org
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v5 09/13] perf evsel: Support opening on a specific CPU
Date:   Thu,  7 Nov 2019 10:16:42 -0800
Message-Id: <20191107181646.506734-10-andi@firstfloor.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191107181646.506734-1-andi@firstfloor.org>
References: <20191107181646.506734-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Support opening an evsel on a specific CPU index. Fix up
all callers so far to still open on all CPUs.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/tests/event-times.c |  4 ++--
 tools/perf/util/evsel.c        | 18 +++++++++++++-----
 tools/perf/util/evsel.h        |  3 ++-
 tools/perf/util/stat.c         |  2 +-
 4 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index 1ee8704e2284..1e8a9f5c356d 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -125,7 +125,7 @@ static int attach__cpu_disabled(struct evlist *evlist)
 
 	evsel->core.attr.disabled = 1;
 
-	err = perf_evsel__open_per_cpu(evsel, cpus);
+	err = perf_evsel__open_per_cpu(evsel, cpus, -1);
 	if (err) {
 		if (err == -EACCES)
 			return TEST_SKIP;
@@ -152,7 +152,7 @@ static int attach__cpu_enabled(struct evlist *evlist)
 		return -1;
 	}
 
-	err = perf_evsel__open_per_cpu(evsel, cpus);
+	err = perf_evsel__open_per_cpu(evsel, cpus, -1);
 	if (err == -EACCES)
 		return TEST_SKIP;
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d4451846af93..7106f9a067df 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1569,8 +1569,9 @@ static int perf_event_open(struct evsel *evsel,
 	return fd;
 }
 
-int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
-		struct perf_thread_map *threads)
+static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
+		struct perf_thread_map *threads,
+		int start_cpu, int end_cpu)
 {
 	int cpu, thread, nthreads;
 	unsigned long flags = PERF_FLAG_FD_CLOEXEC;
@@ -1647,7 +1648,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 	display_attr(&evsel->core.attr);
 
-	for (cpu = 0; cpu < cpus->nr; cpu++) {
+	for (cpu = start_cpu; cpu < end_cpu; cpu++) {
 
 		for (thread = 0; thread < nthreads; thread++) {
 			int fd, group_fd;
@@ -1825,6 +1826,12 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	return err;
 }
 
+int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
+		struct perf_thread_map *threads)
+{
+	return evsel__open_cpu(evsel, cpus, threads, 0, cpus ? cpus->nr : 1);
+}
+
 void evsel__close(struct evsel *evsel)
 {
 	perf_evsel__close(&evsel->core);
@@ -1832,9 +1839,10 @@ void evsel__close(struct evsel *evsel)
 }
 
 int perf_evsel__open_per_cpu(struct evsel *evsel,
-			     struct perf_cpu_map *cpus)
+			     struct perf_cpu_map *cpus,
+			     int cpu)
 {
-	return evsel__open(evsel, cpus, NULL);
+	return evsel__open_cpu(evsel, cpus, NULL, cpu, cpu + 1);
 }
 
 int perf_evsel__open_per_thread(struct evsel *evsel,
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index b10d5ba21966..54513d70c109 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -223,7 +223,8 @@ int evsel__enable(struct evsel *evsel);
 int evsel__disable(struct evsel *evsel);
 
 int perf_evsel__open_per_cpu(struct evsel *evsel,
-			     struct perf_cpu_map *cpus);
+			     struct perf_cpu_map *cpus,
+			     int cpu);
 int perf_evsel__open_per_thread(struct evsel *evsel,
 				struct perf_thread_map *threads);
 int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 6822e4ffe224..36dc95032e4c 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -517,7 +517,7 @@ int create_perf_stat_counter(struct evsel *evsel,
 	}
 
 	if (target__has_cpu(target) && !target__has_per_thread(target))
-		return perf_evsel__open_per_cpu(evsel, evsel__cpus(evsel));
+		return perf_evsel__open_per_cpu(evsel, evsel__cpus(evsel), -1);
 
 	return perf_evsel__open_per_thread(evsel, evsel->core.threads);
 }
-- 
2.23.0

