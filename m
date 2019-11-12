Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8AAC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278CA2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfKLBAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:00:10 -0500
Received: from mga14.intel.com ([192.55.52.115]:61337 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727254AbfKLA7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 19:59:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 16:59:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,294,1569308400"; 
   d="scan'208";a="215864798"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga002.jf.intel.com with ESMTP; 11 Nov 2019 16:59:43 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 168DE301AFA; Mon, 11 Nov 2019 16:59:43 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     jolsa@kernel.org
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v6 05/12] perf evsel: Add iterator to iterate over events ordered by CPU
Date:   Mon, 11 Nov 2019 16:59:34 -0800
Message-Id: <20191112005941.649137-6-andi@firstfloor.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191112005941.649137-1-andi@firstfloor.org>
References: <20191112005941.649137-1-andi@firstfloor.org>
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
Don't compute cpus nr in cpu_index iterator init, just use all_cpus
v4:
Remove __next, move into skip
Add _no_inc
Move initialization into iterator macro
Rename cpu_index to cpu_iter
---
 tools/perf/util/cpumap.h |  1 +
 tools/perf/util/evlist.c | 32 ++++++++++++++++++++++++++++++++
 tools/perf/util/evlist.h |  8 ++++++++
 tools/perf/util/evsel.h  |  1 +
 4 files changed, 42 insertions(+)

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
index fdce590d2278..dae6e846b2f8 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -342,6 +342,38 @@ static int perf_evlist__nr_threads(struct evlist *evlist,
 		return perf_thread_map__nr(evlist->core.threads);
 }
 
+void evlist__cpu_iter_start(struct evlist *evlist)
+{
+	struct evsel *pos;
+
+	/*
+	 * Reset the per evsel cpu_iter. This is needed because
+	 * each evsel's cpumap may have a different index space,
+	 * and some operations need the index to modify
+	 * the FD xyarray (e.g. open, close)
+	 */
+	evlist__for_each_entry(evlist, pos)
+		pos->cpu_iter = 0;
+}
+
+bool evsel__cpu_iter_skip_no_inc(struct evsel *ev, int cpu)
+{
+	if (ev->cpu_iter >= ev->core.cpus->nr)
+		return true;
+	if (cpu >= 0 && ev->core.cpus->map[ev->cpu_iter] != cpu)
+		return true;
+	return false;
+}
+
+bool evsel__cpu_iter_skip(struct evsel *ev, int cpu)
+{
+	if (!evsel__cpu_iter_skip_no_inc(ev, cpu)) {
+		ev->cpu_iter++;
+		return false;
+	}
+	return true;
+}
+
 void evlist__disable(struct evlist *evlist)
 {
 	struct evsel *pos;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 13051409fd22..12606efc1f7c 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -333,9 +333,17 @@ void perf_evlist__to_front(struct evlist *evlist,
 #define evlist__for_each_entry_safe(evlist, tmp, evsel) \
 	__evlist__for_each_entry_safe(&(evlist)->core.entries, tmp, evsel)
 
+#define evlist__for_each_cpu(evlist, index, cpu)	\
+	evlist__cpu_iter_start(evlist);			\
+	perf_cpu_map__for_each_cpu (cpu, index, (evlist)->core.all_cpus)
+
 void perf_evlist__set_tracking_event(struct evlist *evlist,
 				     struct evsel *tracking_evsel);
 
+void evlist__cpu_iter_start(struct evlist *evlist);
+bool evsel__cpu_iter_skip(struct evsel *ev, int cpu);
+bool evsel__cpu_iter_skip_no_inc(struct evsel *ev, int cpu);
+
 struct evsel *
 perf_evlist__find_evsel_by_str(struct evlist *evlist, const char *str);
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index ddc5ee6f6592..b10d5ba21966 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -95,6 +95,7 @@ struct evsel {
 	bool			collect_stat;
 	bool			weak_group;
 	bool			percore;
+	int			cpu_iter;
 	const char		*pmu_name;
 	struct {
 		perf_evsel__sb_cb_t	*cb;
-- 
2.23.0

