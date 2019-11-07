Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D0AC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 18:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F36C21882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 18:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbfKGSRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 13:17:01 -0500
Received: from mga01.intel.com ([192.55.52.88]:60752 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729922AbfKGSQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 13:16:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 10:16:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,278,1569308400"; 
   d="scan'208";a="286064059"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga001.jf.intel.com with ESMTP; 07 Nov 2019 10:16:49 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id CB832301BE9; Thu,  7 Nov 2019 10:16:49 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     jolsa@kernel.org
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v5 10/13] perf stat: Use affinity for opening events
Date:   Thu,  7 Nov 2019 10:16:43 -0800
Message-Id: <20191107181646.506734-11-andi@firstfloor.org>
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

Restructure the event opening in perf stat to cycle through
the events by CPU after setting affinity to that CPU.
This eliminates IPI overhead in the perf API.

We have to loop through the CPU in the outter builtin-stat
code instead of leaving that to low level functions.

It has to change the weak group fallback strategy slightly.
Since we cannot easily undo the opens for other CPUs
move the weak group retry to a separate loop.

Before with a large test case with 94 CPUs:

% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 42.75    4.050910          67     60046       110 perf_event_open

After:

 26.86    0.944396          16     58069       110 perf_event_open

(the number changes slightly because the weak group retries
work differently and the test case relies on weak groups)

Signed-off-by: Andi Kleen <ak@linux.intel.com>

---

v2: Use new iterator macros.
Fix bug that caused unnecessary retry for errored events.
Add extra assert to check assumption that cpumaps are always subsets
v3:
Use new iterator macros
Factored out code movement for error handling.
v4:
Update iterator macros again
Fix minor bug with errored events
---
 tools/perf/builtin-record.c |   2 +-
 tools/perf/builtin-stat.c   | 118 ++++++++++++++++++++++++++++++------
 tools/perf/util/evlist.c    |   6 +-
 tools/perf/util/evlist.h    |   3 +-
 tools/perf/util/evsel.h     |   2 +
 tools/perf/util/stat.c      |   5 +-
 tools/perf/util/stat.h      |   3 +-
 7 files changed, 113 insertions(+), 26 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 2fb83aabbef5..9f8a9393ce4a 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -776,7 +776,7 @@ static int record__open(struct record *rec)
 			if ((errno == EINVAL || errno == EBADF) &&
 			    pos->leader != pos &&
 			    pos->weak_group) {
-			        pos = perf_evlist__reset_weak_group(evlist, pos);
+			        pos = perf_evlist__reset_weak_group(evlist, pos, true);
 				goto try_again;
 			}
 			rc = -errno;
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 1a586009e5a7..7f9ec41d8f62 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -65,6 +65,7 @@
 #include "util/target.h"
 #include "util/time-utils.h"
 #include "util/top.h"
+#include "util/affinity.h"
 #include "asm/bug.h"
 
 #include <linux/time64.h>
@@ -440,6 +441,7 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
 			ui__warning("%s event is not supported by the kernel.\n",
 				    perf_evsel__name(counter));
 		counter->supported = false;
+		counter->errored = true;
 
 		if ((counter->leader != counter) ||
 		    !(counter->leader->core.nr_members > 1))
@@ -484,6 +486,9 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	int status = 0;
 	const bool forks = (argc > 0);
 	bool is_pipe = STAT_RECORD ? perf_stat.data.is_pipe : false;
+	struct affinity affinity;
+	int i, cpu;
+	bool second_pass = false;
 
 	if (interval) {
 		ts.tv_sec  = interval / USEC_PER_MSEC;
@@ -508,30 +513,105 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	if (group)
 		perf_evlist__set_leader(evsel_list);
 
-	evlist__for_each_entry(evsel_list, counter) {
+	if (affinity__setup(&affinity) < 0)
+		return -1;
+
+	evlist__for_each_cpu (evsel_list, i, cpu) {
+		affinity__set(&affinity, cpu);
+
+		evlist__for_each_entry(evsel_list, counter) {
+			if (evsel__cpu_iter_skip(counter, cpu))
+				continue;
+			if (counter->reset_group || counter->errored)
+				continue;
 try_again:
-		if (create_perf_stat_counter(counter, &stat_config, &target) < 0) {
-
-			/* Weak group failed. Reset the group. */
-			if ((errno == EINVAL || errno == EBADF) &&
-			    counter->leader != counter &&
-			    counter->weak_group) {
-				counter = perf_evlist__reset_weak_group(evsel_list, counter);
-				goto try_again;
+			if (create_perf_stat_counter(counter, &stat_config, &target,
+						     counter->cpu_iter - 1) < 0) {
+
+				/*
+				 * Weak group failed. We cannot just undo this here
+				 * because earlier CPUs might be in group mode, and the kernel
+				 * doesn't support mixing group and non group reads. Defer
+				 * it to later.
+				 * Don't close here because we're in the wrong affinity.
+				 */
+				if ((errno == EINVAL || errno == EBADF) &&
+				    counter->leader != counter &&
+				    counter->weak_group) {
+					perf_evlist__reset_weak_group(evsel_list, counter, false);
+					assert(counter->reset_group);
+					second_pass = true;
+					continue;
+				}
+
+				switch (stat_handle_error(counter)) {
+				case COUNTER_FATAL:
+					return -1;
+				case COUNTER_RETRY:
+					goto try_again;
+				case COUNTER_SKIP:
+					continue;
+				default:
+					break;
+				}
+
 			}
+			counter->supported = true;
+		}
+	}
 
-			switch (stat_handle_error(counter)) {
-			case COUNTER_FATAL:
-				return -1;
-			case COUNTER_RETRY:
-				goto try_again;
-			case COUNTER_SKIP:
-				continue;
-			default:
-				break;
+	if (second_pass) {
+		/*
+		 * Now redo all the weak group after closing them,
+		 * and also close errored counters.
+		 */
+
+		evlist__cpu_iter_start(evsel_list);
+		evlist__for_each_cpu (evsel_list, i, cpu) {
+			affinity__set(&affinity, cpu);
+			/* First close errored or weak retry */
+			evlist__for_each_entry(evsel_list, counter) {
+				if (!counter->reset_group && !counter->errored)
+					continue;
+				if (evsel__cpu_iter_skip_no_inc(counter, cpu))
+					continue;
+				perf_evsel__close_cpu(&counter->core, counter->cpu_iter);
 			}
+			/* Now reopen weak */
+			evlist__for_each_entry(evsel_list, counter) {
+				if (!counter->reset_group && !counter->errored)
+					continue;
+				if (evsel__cpu_iter_skip(counter, cpu))
+					continue;
+				if (!counter->reset_group)
+					continue;
+try_again_reset:
+				pr_debug2("reopening weak %s\n", perf_evsel__name(counter));
+				if (create_perf_stat_counter(counter, &stat_config, &target,
+							     counter->cpu_iter - 1) < 0) {
+
+					switch (stat_handle_error(counter)) {
+					case COUNTER_FATAL:
+						return -1;
+					case COUNTER_RETRY:
+						goto try_again_reset;
+					case COUNTER_SKIP:
+						continue;
+					default:
+						break;
+					}
+				}
+				counter->supported = true;
+			}
+		}
+	}
+	affinity__cleanup(&affinity);
+
+	evlist__for_each_entry(evsel_list, counter) {
+		if (!counter->supported) {
+			perf_evsel__free_fd(&counter->core);
+			continue;
 		}
-		counter->supported = true;
 
 		l = strlen(counter->unit);
 		if (l > stat_config.unit_width)
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 0dcea66329e2..33080f79b977 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1632,7 +1632,8 @@ void perf_evlist__force_leader(struct evlist *evlist)
 }
 
 struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
-						 struct evsel *evsel)
+						 struct evsel *evsel,
+						bool close)
 {
 	struct evsel *c2, *leader;
 	bool is_open = true;
@@ -1649,10 +1650,11 @@ struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
 		if (c2 == evsel)
 			is_open = false;
 		if (c2->leader == leader) {
-			if (is_open)
+			if (is_open && close)
 				perf_evsel__close(&c2->core);
 			c2->leader = c2;
 			c2->core.nr_members = 0;
+			c2->reset_group = true;
 		}
 	}
 	return leader;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 12606efc1f7c..ad77091d1e1e 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -355,5 +355,6 @@ bool perf_evlist__exclude_kernel(struct evlist *evlist);
 void perf_evlist__force_leader(struct evlist *evlist);
 
 struct evsel *perf_evlist__reset_weak_group(struct evlist *evlist,
-						 struct evsel *evsel);
+						 struct evsel *evsel,
+						bool close);
 #endif /* __PERF_EVLIST_H */
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 54513d70c109..ca82a93960cd 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -94,6 +94,8 @@ struct evsel {
 	struct evsel		*metric_leader;
 	bool			collect_stat;
 	bool			weak_group;
+	bool			reset_group;
+	bool			errored;
 	bool			percore;
 	int			cpu_iter;
 	const char		*pmu_name;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 36dc95032e4c..3aebe732e886 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -463,7 +463,8 @@ size_t perf_event__fprintf_stat_config(union perf_event *event, FILE *fp)
 
 int create_perf_stat_counter(struct evsel *evsel,
 			     struct perf_stat_config *config,
-			     struct target *target)
+			     struct target *target,
+			     int cpu)
 {
 	struct perf_event_attr *attr = &evsel->core.attr;
 	struct evsel *leader = evsel->leader;
@@ -517,7 +518,7 @@ int create_perf_stat_counter(struct evsel *evsel,
 	}
 
 	if (target__has_cpu(target) && !target__has_per_thread(target))
-		return perf_evsel__open_per_cpu(evsel, evsel__cpus(evsel), -1);
+		return perf_evsel__open_per_cpu(evsel, evsel__cpus(evsel), cpu);
 
 	return perf_evsel__open_per_thread(evsel, evsel->core.threads);
 }
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 081c4a5113c6..4c9a7b68c3e7 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -213,7 +213,8 @@ size_t perf_event__fprintf_stat_config(union perf_event *event, FILE *fp);
 
 int create_perf_stat_counter(struct evsel *evsel,
 			     struct perf_stat_config *config,
-			     struct target *target);
+			     struct target *target,
+			     int cpu);
 void
 perf_evlist__print_counters(struct evlist *evlist,
 			    struct perf_stat_config *config,
-- 
2.23.0

