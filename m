Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04789C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 05:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45552084D
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 05:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfKPFwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 00:52:55 -0500
Received: from mga12.intel.com ([192.55.52.136]:28365 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbfKPFwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 00:52:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 21:52:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,311,1569308400"; 
   d="scan'208";a="199421730"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga008.jf.intel.com with ESMTP; 15 Nov 2019 21:52:44 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 14DF2300FDE; Fri, 15 Nov 2019 21:52:44 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v7 10/12] perf stat: Use affinity for reading
Date:   Fri, 15 Nov 2019 21:52:27 -0800
Message-Id: <20191116055229.62002-11-andi@firstfloor.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191116055229.62002-1-andi@firstfloor.org>
References: <20191116055229.62002-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Restructure event reading to use affinity to minimize the number
of IPIs needed.

Before on a large test case with 94 CPUs:

% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
  3.16    0.106079           4     22082           read

After:

  3.43    0.081295           3     22082           read

Signed-off-by: Andi Kleen <ak@linux.intel.com>

---

v2: Use new iterator macros
v3: Use new iterator macros
v4: Change iterator macros even more
v5: Preserve counter->err in all cases
v6: Rename read_counter -> read_counter_cpu
---
 tools/perf/builtin-stat.c | 96 ++++++++++++++++++++++-----------------
 tools/perf/util/evsel.h   |  1 +
 2 files changed, 56 insertions(+), 41 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 6cb7d4f0f84c..402e23cc775e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -266,15 +266,10 @@ static int read_single_counter(struct evsel *counter, int cpu,
  * Read out the results of a single counter:
  * do not aggregate counts across CPUs in system-wide mode
  */
-static int read_counter(struct evsel *counter, struct timespec *rs)
+static int read_counter_cpu(struct evsel *counter, struct timespec *rs, int cpu)
 {
 	int nthreads = perf_thread_map__nr(evsel_list->core.threads);
-	int ncpus, cpu, thread;
-
-	if (target__has_cpu(&target) && !target__has_per_thread(&target))
-		ncpus = perf_evsel__nr_cpus(counter);
-	else
-		ncpus = 1;
+	int thread;
 
 	if (!counter->supported)
 		return -ENOENT;
@@ -283,40 +278,38 @@ static int read_counter(struct evsel *counter, struct timespec *rs)
 		nthreads = 1;
 
 	for (thread = 0; thread < nthreads; thread++) {
-		for (cpu = 0; cpu < ncpus; cpu++) {
-			struct perf_counts_values *count;
-
-			count = perf_counts(counter->counts, cpu, thread);
-
-			/*
-			 * The leader's group read loads data into its group members
-			 * (via perf_evsel__read_counter) and sets threir count->loaded.
-			 */
-			if (!perf_counts__is_loaded(counter->counts, cpu, thread) &&
-			    read_single_counter(counter, cpu, thread, rs)) {
-				counter->counts->scaled = -1;
-				perf_counts(counter->counts, cpu, thread)->ena = 0;
-				perf_counts(counter->counts, cpu, thread)->run = 0;
-				return -1;
-			}
+		struct perf_counts_values *count;
 
-			perf_counts__set_loaded(counter->counts, cpu, thread, false);
+		count = perf_counts(counter->counts, cpu, thread);
 
-			if (STAT_RECORD) {
-				if (perf_evsel__write_stat_event(counter, cpu, thread, count)) {
-					pr_err("failed to write stat event\n");
-					return -1;
-				}
-			}
+		/*
+		 * The leader's group read loads data into its group members
+		 * (via perf_evsel__read_counter) and sets threir count->loaded.
+		 */
+		if (!perf_counts__is_loaded(counter->counts, cpu, thread) &&
+		    read_single_counter(counter, cpu, thread, rs)) {
+			counter->counts->scaled = -1;
+			perf_counts(counter->counts, cpu, thread)->ena = 0;
+			perf_counts(counter->counts, cpu, thread)->run = 0;
+			return -1;
+		}
+
+		perf_counts__set_loaded(counter->counts, cpu, thread, false);
 
-			if (verbose > 1) {
-				fprintf(stat_config.output,
-					"%s: %d: %" PRIu64 " %" PRIu64 " %" PRIu64 "\n",
-						perf_evsel__name(counter),
-						cpu,
-						count->val, count->ena, count->run);
+		if (STAT_RECORD) {
+			if (perf_evsel__write_stat_event(counter, cpu, thread, count)) {
+				pr_err("failed to write stat event\n");
+				return -1;
 			}
 		}
+
+		if (verbose > 1) {
+			fprintf(stat_config.output,
+				"%s: %d: %" PRIu64 " %" PRIu64 " %" PRIu64 "\n",
+					perf_evsel__name(counter),
+					cpu,
+					count->val, count->ena, count->run);
+		}
 	}
 
 	return 0;
@@ -325,15 +318,36 @@ static int read_counter(struct evsel *counter, struct timespec *rs)
 static void read_counters(struct timespec *rs)
 {
 	struct evsel *counter;
-	int ret;
+	struct affinity affinity;
+	int i, ncpus, cpu;
+
+	if (affinity__setup(&affinity) < 0)
+		return;
+
+	ncpus = evsel_list->core.all_cpus->nr;
+	if (!target__has_cpu(&target) || target__has_per_thread(&target))
+		ncpus = 1;
+	evlist__for_each_cpu (evsel_list, i, cpu) {
+		if (i >= ncpus)
+			break;
+		affinity__set(&affinity, cpu);
+
+		evlist__for_each_entry(evsel_list, counter) {
+			if (evsel__cpu_iter_skip(counter, cpu))
+				continue;
+			if (!counter->err)
+				counter->err = read_counter_cpu(counter, rs,
+								counter->cpu_iter - 1);
+		}
+	}
+	affinity__cleanup(&affinity);
 
 	evlist__for_each_entry(evsel_list, counter) {
-		ret = read_counter(counter, rs);
-		if (ret)
+		if (counter->err)
 			pr_debug("failed to read counter %s\n", counter->name);
-
-		if (ret == 0 && perf_stat_process_counter(&stat_config, counter))
+		if (counter->err == 0 && perf_stat_process_counter(&stat_config, counter))
 			pr_warning("failed to process counter %s\n", counter->name);
+		counter->err = 0;
 	}
 }
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index ca82a93960cd..c8af4bc23f8f 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -86,6 +86,7 @@ struct evsel {
 	struct list_head	config_terms;
 	struct bpf_object	*bpf_obj;
 	int			bpf_fd;
+	int			err;
 	bool			auto_merge_stats;
 	bool			merged_stat;
 	const char *		metric_expr;
-- 
2.23.0

