Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11549CA9ED4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 00:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D679820717
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 00:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387604AbfKEAZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 19:25:30 -0500
Received: from mga05.intel.com ([192.55.52.43]:25037 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387464AbfKEAZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 19:25:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 16:25:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,268,1569308400"; 
   d="scan'208";a="212422264"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga001.fm.intel.com with ESMTP; 04 Nov 2019 16:25:28 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 11142301376; Mon,  4 Nov 2019 16:25:28 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v4 4/9] perf evsel: Add iterator to iterate over events ordered by CPU
Date:   Mon,  4 Nov 2019 16:25:17 -0800
Message-Id: <20191105002522.83803-5-andi@firstfloor.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191105002522.83803-1-andi@firstfloor.org>
References: <20191105002522.83803-1-andi@firstfloor.org>
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
v3: Drop cpumap__for_each_cpu macro again, replace with evlist__for_each_cpu
Add new evlist__for_each_cpu
Don't compute cpus nir in cpu_index iterator init, just use all_cpus
---
 tools/perf/util/cpumap.h |  1 +
 tools/perf/util/evlist.c | 28 ++++++++++++++++++++++++++++
 tools/perf/util/evlist.h |  7 +++++++
 tools/perf/util/evsel.h  |  1 +
 4 files changed, 37 insertions(+)

diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 2553bef1279d..dbc1d7e949ed 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -60,4 +60,5 @@ int cpu_map__build_map(struct perf_cpu_map *cpus, struct perf_cpu_map **res,
 
 int cpu_map__cpu(struct perf_cpu_map *cpus, int idx);
 bool cpu_map__has(struct perf_cpu_map *cpus, int cpu);
+
 #endif /* __PERF_CPUMAP_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index fdce590d2278..dccf96e0d01b 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -342,6 +342,34 @@ static int perf_evlist__nr_threads(struct evlist *evlist,
 		return perf_thread_map__nr(evlist->core.threads);
 }
 
+void evlist__cpu_iter_start(struct evlist *evlist)
+{
+	struct evsel *pos;
+
+	/*
+	 * Reset the per evsel cpu_index. This is needed because
+	 * each evsel's cpumap may have a different index space,
+	 * and some operations need the index to modify
+	 * the FD xyarray (e.g. open, close)
+	 */
+	evlist__for_each_entry(evlist, pos)
+		pos->cpu_index = 0;
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
index 13051409fd22..106dd04f88aa 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -333,9 +333,16 @@ void perf_evlist__to_front(struct evlist *evlist,
 #define evlist__for_each_entry_safe(evlist, tmp, evsel) \
 	__evlist__for_each_entry_safe(&(evlist)->core.entries, tmp, evsel)
 
+#define evlist__for_each_cpu(evlist, index, cpu) \
+	perf_cpu_map__for_each_cpu (cpu, index, (evlist)->core.all_cpus)
+
 void perf_evlist__set_tracking_event(struct evlist *evlist,
 				     struct evsel *tracking_evsel);
 
+void evlist__cpu_iter_start(struct evlist *evlist);
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
2.23.0

