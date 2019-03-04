Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABC0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 05:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1402082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 05:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfCDFB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 00:01:59 -0500
Received: from mga14.intel.com ([192.55.52.115]:45419 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbfCDFB5 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 00:01:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2019 21:01:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,438,1544515200"; 
   d="scan'208";a="138837934"
Received: from skl.sh.intel.com ([10.239.159.132])
  by orsmga002.jf.intel.com with ESMTP; 03 Mar 2019 21:01:54 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 1/3] perf diff: Support --time filter option
Date:   Mon,  4 Mar 2019 20:52:38 +0800
Message-Id: <1551703960-28957-2-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551703960-28957-1-git-send-email-yao.jin@linux.intel.com>
References: <1551703960-28957-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For better support for perf diff, it would be useful to add --time filter
option to diff the samples within given time window.

It supports time percent with multipe time ranges. Time string is
'a%/n,b%/m,...' or 'a%-b%,c%-%d,...'.

For example:

Select the second 10% time slice to diff:
perf diff --time 10%/2

Select from 0% to 10% time slice to diff:
perf diff --time 0%-10%

Select the first and the second 10% time slices to diff:
perf diff --time 10%/1,10%/2

Select from 0% to 10% and 30% to 40% slices to diff:
perf diff --time 0%-10%,30%-40%

It also supports to analyze samples within given time window as:
<start>,<stop>. Times have the format seconds.microseconds. If start
is not given (i.e., time string is ',x.y') then analysis starts at
the beginning of the file. If stop time is not given (i.e, time
string is 'x.y,') then analysis goes to end of file. Time string is
'a1.b1,c1.d1:a2.b2,c2.d2'. Use ':' to separate timestamps for different
perf.data files.

For example, we get the timestamp information from perf script.

perf script -i perf.data.old
  mgen 13940 [000]  3946.361400: ...

perf script -i perf.data
  mgen 13940 [000]  3971.150589 ...

perf diff --time 3946.361400,:3971.150589,

It analyzes the perf.data.old from the timestamp 3946.361400 to
the end of perf.data.old and analyzes the perf.data from the
timestamp 3971.150589 to the end of perf.data.

 v3:
 ---
 Don't parse the time string if --time option is not set.
 Refactor the code to make it simpler.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-diff.txt |  41 ++++++++++
 tools/perf/builtin-diff.c              | 136 +++++++++++++++++++++++++++++----
 2 files changed, 164 insertions(+), 13 deletions(-)

diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Documentation/perf-diff.txt
index a79c84a..5bfe876 100644
--- a/tools/perf/Documentation/perf-diff.txt
+++ b/tools/perf/Documentation/perf-diff.txt
@@ -118,6 +118,47 @@ OPTIONS
 	sum of shown entries will be always 100%.  "absolute" means it retains
 	the original value before and after the filter is applied.
 
+--time::
+	Analyze samples within given time window. It supports time
+	percent with multipe time ranges. Time string is 'a%/n,b%/m,...'
+	or 'a%-b%,c%-%d,...'.
+
+	For example:
+
+	Select the second 10% time slice to diff:
+	perf diff --time 10%/2
+
+	Select from 0% to 10% time slice to diff:
+	perf diff --time 0%-10%
+
+	Select the first and the second 10% time slices to diff:
+	perf diff --time 10%/1,10%/2
+
+	Select from 0% to 10% and 30% to 40% slices to diff:
+	perf diff --time 0%-10%,30%-40%
+
+	It also supports to analyze samples within given time window:
+	<start>,<stop>. Times have the format seconds.microseconds. If start
+	is not given (i.e., time string is ',x.y') then analysis starts at
+	the beginning of the file. If stop time is not given (i.e, time
+	string is 'x.y,') then analysis goes to end of file. Time string is
+	'a1.b1,c1.d1:a2.b2,c2.d2'. Use ':' to separate timestamps for different
+	perf.data files.
+
+	For example, we get the timestamp information from perf script.
+
+	perf script -i perf.data.old
+	  mgen 13940 [000]  3946.361400: ...
+
+	perf script -i perf.data
+	  mgen 13940 [000]  3971.150589 ...
+
+	perf diff --time 3946.361400,:3971.150589,
+
+	It analyzes the perf.data.old from the timestamp 3946.361400 to
+	the end of perf.data.old and analyzes the perf.data from the
+	timestamp 3971.150589 to the end of perf.data.
+
 COMPARISON
 ----------
 The comparison is governed by the baseline file. The baseline perf.data
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 58fe0e8..2c49dda 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -19,12 +19,21 @@
 #include "util/util.h"
 #include "util/data.h"
 #include "util/config.h"
+#include "util/time-utils.h"
 
 #include <errno.h>
 #include <inttypes.h>
 #include <stdlib.h>
 #include <math.h>
 
+struct perf_diff {
+	struct perf_tool		 tool;
+	const char			*time_str;
+	struct perf_time_interval	*ptime_range;
+	int				 range_size;
+	int				 range_num;
+};
+
 /* Diff command specific HPP columns. */
 enum {
 	PERF_HPP_DIFF__BASELINE,
@@ -323,16 +332,22 @@ static int formula_fprintf(struct hist_entry *he, struct hist_entry *pair,
 	return -1;
 }
 
-static int diff__process_sample_event(struct perf_tool *tool __maybe_unused,
+static int diff__process_sample_event(struct perf_tool *tool,
 				      union perf_event *event,
 				      struct perf_sample *sample,
 				      struct perf_evsel *evsel,
 				      struct machine *machine)
 {
+	struct perf_diff *pdiff = container_of(tool, struct perf_diff, tool);
 	struct addr_location al;
 	struct hists *hists = evsel__hists(evsel);
 	int ret = -1;
 
+	if (perf_time__ranges_skip_sample(pdiff->ptime_range, pdiff->range_num,
+					  sample->time)) {
+		return 0;
+	}
+
 	if (machine__resolve(machine, &al, sample) < 0) {
 		pr_warning("problem processing %d event, skipping it.\n",
 			   event->header.type);
@@ -359,17 +374,19 @@ static int diff__process_sample_event(struct perf_tool *tool __maybe_unused,
 	return ret;
 }
 
-static struct perf_tool tool = {
-	.sample	= diff__process_sample_event,
-	.mmap	= perf_event__process_mmap,
-	.mmap2	= perf_event__process_mmap2,
-	.comm	= perf_event__process_comm,
-	.exit	= perf_event__process_exit,
-	.fork	= perf_event__process_fork,
-	.lost	= perf_event__process_lost,
-	.namespaces = perf_event__process_namespaces,
-	.ordered_events = true,
-	.ordering_requires_timestamps = true,
+static struct perf_diff pdiff = {
+	.tool = {
+		.sample	= diff__process_sample_event,
+		.mmap	= perf_event__process_mmap,
+		.mmap2	= perf_event__process_mmap2,
+		.comm	= perf_event__process_comm,
+		.exit	= perf_event__process_exit,
+		.fork	= perf_event__process_fork,
+		.lost	= perf_event__process_lost,
+		.namespaces = perf_event__process_namespaces,
+		.ordered_events = true,
+		.ordering_requires_timestamps = true,
+	},
 };
 
 static struct perf_evsel *evsel_match(struct perf_evsel *evsel,
@@ -771,19 +788,100 @@ static void data__free(struct data__file *d)
 	}
 }
 
+static char *abstime_str_dup(void)
+{
+	if (pdiff.time_str && strchr(pdiff.time_str, ':'))
+		return strdup(pdiff.time_str);
+
+	return NULL;
+}
+
+static int parse_absolute_time(struct data__file *d, char **pstr)
+{
+	char *p = *pstr;
+	int ret;
+
+	/*
+	 * Absolute timestamp for one file has the format: a.b,c.d
+	 * For multiple files, the format is: a.b,c.d:a.b,c.d
+	 */
+	p = strchr(*pstr, ':');
+	if (p) {
+		if (p == *pstr) {
+			pr_err("Invalid time string\n");
+			return -EINVAL;
+		}
+
+		*p = 0;
+		p++;
+		if (*p == 0) {
+			pr_err("Invalid time string\n");
+			return -EINVAL;
+		}
+	}
+
+	ret = perf_time__parse_for_ranges(*pstr, d->session,
+					  &pdiff.ptime_range,
+					  &pdiff.range_size,
+					  &pdiff.range_num);
+	if (ret < 0)
+		return ret;
+
+	if (!p || *p == 0)
+		*pstr = NULL;
+	else
+		*pstr = p;
+
+	return ret;
+}
+
+static int parse_percent_time(struct data__file *d)
+{
+	int ret;
+
+	ret = perf_time__parse_for_ranges(pdiff.time_str, d->session,
+					  &pdiff.ptime_range,
+					  &pdiff.range_size,
+					  &pdiff.range_num);
+	return ret;
+}
+
+static int parse_time_str(struct data__file *d, char *abstime_ostr,
+			   char **pabstime_tmp)
+{
+	int ret = 0;
+
+	if (abstime_ostr)
+		ret = parse_absolute_time(d, pabstime_tmp);
+	else if (pdiff.time_str)
+		ret = parse_percent_time(d);
+
+	return ret;
+}
+
 static int __cmd_diff(void)
 {
 	struct data__file *d;
 	int ret = -EINVAL, i;
+	char *abstime_ostr, *abstime_tmp;
+
+	abstime_ostr = abstime_str_dup();
+	abstime_tmp = abstime_ostr;
 
 	data__for_each_file(i, d) {
-		d->session = perf_session__new(&d->data, false, &tool);
+		d->session = perf_session__new(&d->data, false, &pdiff.tool);
 		if (!d->session) {
 			pr_err("Failed to open %s\n", d->data.path);
 			ret = -1;
 			goto out_delete;
 		}
 
+		if (pdiff.time_str) {
+			ret = parse_time_str(d, abstime_ostr, &abstime_tmp);
+			if (ret < 0)
+				goto out_delete;
+		}
+
 		ret = perf_session__process_events(d->session);
 		if (ret) {
 			pr_err("Failed to process %s\n", d->data.path);
@@ -791,6 +889,9 @@ static int __cmd_diff(void)
 		}
 
 		perf_evlist__collapse_resort(d->session->evlist);
+
+		if (pdiff.ptime_range)
+			zfree(&pdiff.ptime_range);
 	}
 
 	data_process();
@@ -802,6 +903,13 @@ static int __cmd_diff(void)
 	}
 
 	free(data__files);
+
+	if (pdiff.ptime_range)
+		zfree(&pdiff.ptime_range);
+
+	if (abstime_ostr)
+		free(abstime_ostr);
+
 	return ret;
 }
 
@@ -849,6 +957,8 @@ static const struct option options[] = {
 	OPT_UINTEGER('o', "order", &sort_compute, "Specify compute sorting."),
 	OPT_CALLBACK(0, "percentage", NULL, "relative|absolute",
 		     "How to display percentage of filtered entries", parse_filter_percentage),
+	OPT_STRING(0, "time", &pdiff.time_str, "str",
+		   "Time span (time percent or absolute timestamp)"),
 	OPT_END()
 };
 
-- 
2.7.4

