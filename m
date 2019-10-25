Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10A4CA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 18:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8FA21D7F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 18:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388382AbfJYSOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 14:14:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:12175 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388217AbfJYSO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 14:14:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 11:14:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,229,1569308400"; 
   d="scan'208";a="400193953"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga006.fm.intel.com with ESMTP; 25 Oct 2019 11:14:24 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id D7F2B300B2B; Fri, 25 Oct 2019 11:14:24 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, eranian@google.com, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v3 3/7] perf evsel: Add iterator to iterate over events ordered by CPU
Date:   Fri, 25 Oct 2019 11:14:13 -0700
Message-Id: <20191025181417.10670-4-andi@firstfloor.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025181417.10670-1-andi@firstfloor.org>
References: <20191025181417.10670-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add some common code that is needed to iterate over all events
in CPU order. Used in followon patches

Signed-off-by: Andi Kleen <ak@linux.intel.com>

---

v2: Add cpumap__for_each_cpu macro to factor out some common code
---
 tools/perf/util/cpumap.h |  8 ++++++++
 tools/perf/util/evlist.c | 33 +++++++++++++++++++++++++++++++++
 tools/perf/util/evlist.h |  4 ++++
 tools/perf/util/evsel.h  |  1 +
 4 files changed, 46 insertions(+)

diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 2553bef1279d..a9b13d72fd29 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -60,4 +60,12 @@ int cpu_map__build_map(struct perf_cpu_map *cpus, struct perf_cpu_map **res,
 
 int cpu_map__cpu(struct perf_cpu_map *cpus, int idx);
 bool cpu_map__has(struct perf_cpu_map *cpus, int cpu);
+
+#define __cpumap__for_each_cpu(cpus, index, cpu, maxcpu)\
+	for ((index) = 0; 				\
+	     (cpu) = (index) < (maxcpu) ? (cpus)->map[index] : -1, (index) < (maxcpu); \
+	     (index)++)
+#define cpumap__for_each_cpu(cpus, index, cpu) \
+	__cpumap__for_each_cpu(cpus, index, cpu, (cpus)->nr)
+
 #endif /* __PERF_CPUMAP_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index fdce590d2278..da3c8f8ef68e 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -342,6 +342,39 @@ static int perf_evlist__nr_threads(struct evlist *evlist,
 		return perf_thread_map__nr(evlist->core.threads);
 }
 
+struct perf_cpu_map *evlist__cpu_iter_start(struct evlist *evlist)
+{
+	struct perf_cpu_map *cpus;
+	struct evsel *pos;
+
+	/*
+	 * evlist->cpus is not necessarily a superset of all the
+	 * event's cpus, so compute our own super set. This
+	 * assume that there is a super set
+	 */
+	cpus = evlist->core.cpus;
+	evlist__for_each_entry(evlist, pos) {
+		pos->cpu_index = 0;
+		if (pos->core.cpus->nr > cpus->nr)
+			cpus = pos->core.cpus;
+	}
+	return cpus;
+}
+
+bool evlist__cpu_iter_skip(struct evsel *ev, int cpu)
+{
+	if (ev->cpu_index >= ev->core.cpus->nr)
+		return true;
+	if (cpu >= 0 && ev->core.cpus->map[ev->cpu_index] != cpu)
+		return true;
+	return false;
+}
+
+void evlist__cpu_iter_next(struct evsel *ev)
+{
+	ev->cpu_index++;
+}
+
 void evlist__disable(struct evlist *evlist)
 {
 	struct evsel *pos;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 13051409fd22..c1deb8ebdcea 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -336,6 +336,10 @@ void perf_evlist__to_front(struct evlist *evlist,
 void perf_evlist__set_tracking_event(struct evlist *evlist,
 				     struct evsel *tracking_evsel);
 
+struct perf_cpu_map *evlist__cpu_iter_start(struct evlist *evlist);
+bool evlist__cpu_iter_skip(struct evsel *ev, int cpu);
+void evlist__cpu_iter_next(struct evsel *ev);
+
 struct evsel *
 perf_evlist__find_evsel_by_str(struct evlist *evlist, const char *str);
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index ddc5ee6f6592..cf90019ae744 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -95,6 +95,7 @@ struct evsel {
 	bool			collect_stat;
 	bool			weak_group;
 	bool			percore;
+	int			cpu_index;
 	const char		*pmu_name;
 	struct {
 		perf_evsel__sb_cb_t	*cb;
-- 
2.21.0

