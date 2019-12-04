Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6563CC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CB92084F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfLDHzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:55:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56107 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfLDHyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 02:54:04 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1icPTy-0004Vs-Op; Wed, 04 Dec 2019 08:53:58 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 747A31C264B;
        Wed,  4 Dec 2019 08:53:54 +0100 (CET)
Date:   Wed, 04 Dec 2019 07:53:54 -0000
From:   "tip-bot2 for Andi Kleen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf stat: Use affinity for reading
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191121001522.180827-11-andi@firstfloor.org>
References: <20191121001522.180827-11-andi@firstfloor.org>
MIME-Version: 1.0
Message-ID: <157544603437.21853.15835096734986773458.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     4b49ab708d1804bc8b2fcdde79844b8bc98f7ef6
Gitweb:        https://git.kernel.org/tip/4b49ab708d1804bc8b2fcdde79844b8bc98f7ef6
Author:        Andi Kleen <ak@linux.intel.com>
AuthorDate:    Wed, 20 Nov 2019 16:15:20 -08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 29 Nov 2019 12:20:45 -03:00

perf stat: Use affinity for reading

Restructure event reading to use affinity to minimize the number of IPIs
needed.

Before on a large test case with 94 CPUs:

  % time     seconds  usecs/call     calls    errors syscall
  ------ ----------- ----------- --------- --------- ----------------
    3.16    0.106079           4     22082           read

After:

    3.43    0.081295           3     22082           read

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20191121001522.180827-11-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 97 +++++++++++++++++++++-----------------
 tools/perf/util/evsel.h   |  1 +-
 2 files changed, 57 insertions(+), 41 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index cf8516e..a098c2e 100644
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
+		 * (via perf_evsel__read_counter()) and sets their count->loaded.
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
@@ -325,15 +318,37 @@ static int read_counter(struct evsel *counter, struct timespec *rs)
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
+	ncpus = perf_cpu_map__nr(evsel_list->core.all_cpus);
+	if (!target__has_cpu(&target) || target__has_per_thread(&target))
+		ncpus = 1;
+	evlist__for_each_cpu(evsel_list, i, cpu) {
+		if (i >= ncpus)
+			break;
+		affinity__set(&affinity, cpu);
+
+		evlist__for_each_entry(evsel_list, counter) {
+			if (evsel__cpu_iter_skip(counter, cpu))
+				continue;
+			if (!counter->err) {
+				counter->err = read_counter_cpu(counter, rs,
+								counter->cpu_iter - 1);
+			}
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
index ca82a93..c8af4bc 100644
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
