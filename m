Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A56CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3867C21900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfCVWNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:13:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43349 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfCVWNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:13:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMD9vT748948
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:13:09 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMD8LF748944;
        Fri, 22 Mar 2019 15:13:08 -0700
Date:   Fri, 22 Mar 2019 15:13:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-3723908d05834c76fd5cc9ecd17b0851342e1df4@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org, ak@linux.intel.com,
        acme@redhat.com
Reply-To: jolsa@kernel.org, hpa@zytor.com, acme@redhat.com,
          ak@linux.intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <20190311144502.15423-4-andi@firstfloor.org>
References: <20190311144502.15423-4-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf report: Support time sort key
Git-Commit-ID: 3723908d05834c76fd5cc9ecd17b0851342e1df4
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3723908d05834c76fd5cc9ecd17b0851342e1df4
Gitweb:     https://git.kernel.org/tip/3723908d05834c76fd5cc9ecd17b0851342e1df4
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Mon, 11 Mar 2019 07:44:54 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 11 Mar 2019 16:32:31 -0300

perf report: Support time sort key

Add a time sort key to perf report to display samples for different time
quantums separately. This allows easier analysis of workloads that
change over time, and also will allow looking at the context of samples.

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

Committer notes:

Rename 'time' argument to hist_time() to htime to overcome this in older
distros:

  cc1: warnings being treated as errors
  util/hist.c: In function 'hist_time':
  util/hist.c:251: error: declaration of 'time' shadows a global declaration
  /usr/include/time.h:186: error: shadowed declaration is here

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190311144502.15423-4-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt |  2 ++
 tools/perf/util/hist.c                   | 11 +++++++++
 tools/perf/util/hist.h                   |  1 +
 tools/perf/util/sort.c                   | 39 ++++++++++++++++++++++++++++++++
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
index f9eb95bf3938..34c0f00c68d1 100644
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
 
+static long hist_time(unsigned long htime)
+{
+	unsigned long time_quantum = symbol_conf.time_quantum;
+	if (time_quantum)
+		return (htime / time_quantum) * time_quantum;
+	return htime;
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
