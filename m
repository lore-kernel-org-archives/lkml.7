Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2781C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B332720657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfCKOpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:45:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:14901 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbfCKOpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:45:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 07:45:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="121681632"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga007.jf.intel.com with ESMTP; 11 Mar 2019 07:45:10 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 14484301BF1; Mon, 11 Mar 2019 07:45:10 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v6 03/11] perf tools report: Support time sort key
Date:   Mon, 11 Mar 2019 07:44:54 -0700
Message-Id: <20190311144502.15423-4-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311144502.15423-1-andi@firstfloor.org>
References: <20190311144502.15423-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add a time sort key to perf report to display samples for
different time quantums separately. This allows easier
analysis of workloads that change over time, and also
will allow looking at the context of samples.

% perf record ...
% perf report --sort time,overhead,symbol --time-quantum 1ms --stdio
...
     0.67%  277061.87300  [.] _dl_start
     0.50%  277061.87300  [.] f1
     0.50%  277061.87300  [.] f2
     0.33%  277061.87300  [.] main
     0.29%  277061.87300  [.] _dl_lookup_symbol_x
     0.29%  277061.87300  [.] dl_main
     0.29%  277061.87300  [.] do_lookup_x
     0.17%  277061.87300  [.] _dl_debug_initialize
     0.17%  277061.87300  [.] _dl_init_paths
     0.08%  277061.87300  [.] check_match
     0.04%  277061.87300  [.] _dl_count_modids
     1.33%  277061.87400  [.] f1
     1.33%  277061.87400  [.] f2
     1.33%  277061.87400  [.] main
     1.17%  277061.87500  [.] main
     1.08%  277061.87500  [.] f1
     1.08%  277061.87500  [.] f2
     1.00%  277061.87600  [.] main
     0.83%  277061.87600  [.] f1
     0.83%  277061.87600  [.] f2
     1.00%  277061.87700  [.] main

Signed-off-by: Andi Kleen <ak@linux.intel.com>

---
v2:
Use symbol_conf.time_quantum
v3:
Use _PER_NSEC defines
Fix fallback path for zero quantum
---
 tools/perf/Documentation/perf-report.txt |  2 ++
 tools/perf/util/hist.c                   | 11 +++++++
 tools/perf/util/hist.h                   |  1 +
 tools/perf/util/sort.c                   | 39 ++++++++++++++++++++++++
 tools/perf/util/sort.h                   |  2 ++
 5 files changed, 55 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 9ec1702bccdd..546d87221ad8 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -105,6 +105,8 @@ OPTIONS
 	guest machine
 	- sample: Number of sample
 	- period: Raw number of event count of sample
+	- time: Separate the samples by time stamp with the resolution specified by
+	--time-quantum (default 100ms). Specify with overhead and before it.
 
 	By default, comm, dso and symbol keys are used.
 	(i.e. --sort comm,dso,symbol)
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index f9eb95bf3938..fd5d02c1a521 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -19,6 +19,7 @@
 #include <math.h>
 #include <inttypes.h>
 #include <sys/param.h>
+#include <linux/time64.h>
 
 static bool hists__filter_entry_by_dso(struct hists *hists,
 				       struct hist_entry *he);
@@ -192,6 +193,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 	hists__new_col_len(hists, HISTC_MEM_LVL, 21 + 3);
 	hists__new_col_len(hists, HISTC_LOCAL_WEIGHT, 12);
 	hists__new_col_len(hists, HISTC_GLOBAL_WEIGHT, 12);
+	hists__new_col_len(hists, HISTC_TIME, 12);
 
 	if (h->srcline) {
 		len = MAX(strlen(h->srcline), strlen(sort_srcline.se_header));
@@ -246,6 +248,14 @@ static void he_stat__add_cpumode_period(struct he_stat *he_stat,
 	}
 }
 
+static long hist_time(unsigned long time)
+{
+	unsigned long time_quantum = symbol_conf.time_quantum;
+	if (time_quantum)
+		return (time / time_quantum) * time_quantum;
+	return time;
+}
+
 static void he_stat__add_period(struct he_stat *he_stat, u64 period,
 				u64 weight)
 {
@@ -635,6 +645,7 @@ __hists__add_entry(struct hists *hists,
 		.raw_data = sample->raw_data,
 		.raw_size = sample->raw_size,
 		.ops = ops,
+		.time = hist_time(sample->time),
 	}, *he = hists__findnew_entry(hists, &entry, al, sample_self);
 
 	if (!hists->has_callchains && he && he->callchain_size != 0)
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 4af27fbab24f..6279eca56409 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -31,6 +31,7 @@ enum hist_filter {
 
 enum hist_column {
 	HISTC_SYMBOL,
+	HISTC_TIME,
 	HISTC_DSO,
 	HISTC_THREAD,
 	HISTC_COMM,
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index d2299e912e59..bdd30cab51cb 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -3,6 +3,7 @@
 #include <inttypes.h>
 #include <regex.h>
 #include <linux/mman.h>
+#include <linux/time64.h>
 #include "sort.h"
 #include "hist.h"
 #include "comm.h"
@@ -15,6 +16,7 @@
 #include <traceevent/event-parse.h>
 #include "mem-events.h"
 #include "annotate.h"
+#include "time-utils.h"
 #include <linux/kernel.h>
 
 regex_t		parent_regex;
@@ -654,6 +656,42 @@ struct sort_entry sort_socket = {
 	.se_width_idx	= HISTC_SOCKET,
 };
 
+/* --sort time */
+
+static int64_t
+sort__time_cmp(struct hist_entry *left, struct hist_entry *right)
+{
+	return right->time - left->time;
+}
+
+static int hist_entry__time_snprintf(struct hist_entry *he, char *bf,
+				    size_t size, unsigned int width)
+{
+	unsigned long secs;
+	unsigned long long nsecs;
+	char he_time[32];
+
+	nsecs = he->time;
+	secs = nsecs / NSEC_PER_SEC;
+	nsecs -= secs * NSEC_PER_SEC;
+
+	if (symbol_conf.nanosecs)
+		snprintf(he_time, sizeof he_time, "%5lu.%09llu: ",
+			 secs, nsecs);
+	else
+		timestamp__scnprintf_usec(he->time, he_time,
+					  sizeof(he_time));
+
+	return repsep_snprintf(bf, size, "%-.*s", width, he_time);
+}
+
+struct sort_entry sort_time = {
+	.se_header      = "Time",
+	.se_cmp	        = sort__time_cmp,
+	.se_snprintf    = hist_entry__time_snprintf,
+	.se_width_idx	= HISTC_TIME,
+};
+
 /* --sort trace */
 
 static char *get_trace_output(struct hist_entry *he)
@@ -1634,6 +1672,7 @@ static struct sort_dimension common_sort_dimensions[] = {
 	DIM(SORT_DSO_SIZE, "dso_size", sort_dso_size),
 	DIM(SORT_CGROUP_ID, "cgroup_id", sort_cgroup_id),
 	DIM(SORT_SYM_IPC_NULL, "ipc_null", sort_sym_ipc_null),
+	DIM(SORT_TIME, "time", sort_time),
 };
 
 #undef DIM
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 2fbee0b1011c..19dceb7f6145 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -135,6 +135,7 @@ struct hist_entry {
 	char			*srcfile;
 	struct symbol		*parent;
 	struct branch_info	*branch_info;
+	long			time;
 	struct hists		*hists;
 	struct mem_info		*mem_info;
 	void			*raw_data;
@@ -231,6 +232,7 @@ enum sort_type {
 	SORT_DSO_SIZE,
 	SORT_CGROUP_ID,
 	SORT_SYM_IPC_NULL,
+	SORT_TIME,
 
 	/* branch stack specific sort keys */
 	__SORT_BRANCH_STACK,
-- 
2.20.1

