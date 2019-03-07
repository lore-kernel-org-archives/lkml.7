Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79593C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366A32085A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980780;
	bh=WENxIgQQ0DzgcSLehG8r7BXTk4ghOWX31oAOgnAbYyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hsrHw1Qd5J0HbxwmpGPzP5XJFVLwJPkbDSmAgxCjRvFbU59VSroARvvARjYolDMRk
	 824rrTxWIQjI2lar8qCicBILAg6/EzwxMgWcuzlo0wfjoIRo2/vETozO+04E0/DRTV
	 pq0ZlFOyHTr3s6wwNGSiHvxhBRu30aPcD/09BTfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfCGRqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:46:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:38620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfCGRqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:46:17 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFEE320851;
        Thu,  7 Mar 2019 17:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551980775;
        bh=WENxIgQQ0DzgcSLehG8r7BXTk4ghOWX31oAOgnAbYyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kqi6S+WCNJ7jZfFQPH2TjvSKppVly5HZ0/AszKRcacLI7esCtCH710K4O0VX1SkiQ
         z/Uhy3O77BnCq8uIbOrBH+71eLc7sFScEuReyKI0cEjVwVrOo/pji269TKVkXTYRE9
         4qJwlQiJ8/1iiXaeuQ3ZDkD1Fk+SBX+TSNK5f5EQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 21/35] perf diff: Support --time filter option
Date:   Thu,  7 Mar 2019 14:44:19 -0300
Message-Id: <20190307174433.28819-22-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

To improve 'perf diff', implement a --time filter option to diff the
samples within given time window.

It supports time percent with multiple time ranges. The time string
format is 'a%/n,b%/m,...' or 'a%-b%,c%-%d,...'.

For example:

Select the second 10% time slice to diff:

  perf diff --time 10%/2

Select from 0% to 10% time slice to diff:

  perf diff --time 0%-10%

Select the first and the second 10% time slices to diff:

  perf diff --time 10%/1,10%/2

Select from 0% to 10% and 30% to 40% slices to diff:

  perf diff --time 0%-10%,30%-40%

It also supports analysing samples within a given time window
<start>,<stop>.

Times have the format seconds.microseconds.

If 'start' is not given (i.e., time string is ',x.y') then analysis starts at
the beginning of the file.

If the stop time is not given (i.e, time string is 'x.y,') then analysis
goes to end of file.

Time string is 'a1.b1,c1.d1:a2.b2,c2.d2'. Use ':' to separate timestamps for
different perf.data files.

For example, we get the timestamp information from perf script.

  perf script -i perf.data.old

    mgen 13940 [000]  3946.361400: ...

  perf script -i perf.data

    mgen 13940 [000]  3971.150589 ...

  perf diff --time 3946.361400,:3971.150589,

It analyzes the perf.data.old from the timestamp 3946.361400 to the end of
perf.data.old and analyzes the perf.data from the timestamp 3971.150589 to the
end of perf.data.

 v4:
 ---
 Update abstime_str_dup(), let it return error if strdup
 is failed, and update __cmd_diff() accordingly.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1551791143-10334-2-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-diff.txt |  45 ++++++++
 tools/perf/builtin-diff.c              | 148 ++++++++++++++++++++++---
 2 files changed, 179 insertions(+), 14 deletions(-)

diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Documentation/perf-diff.txt
index a79c84ae61aa..036d65bded51 100644
--- a/tools/perf/Documentation/perf-diff.txt
+++ b/tools/perf/Documentation/perf-diff.txt
@@ -118,6 +118,51 @@ OPTIONS
 	sum of shown entries will be always 100%.  "absolute" means it retains
 	the original value before and after the filter is applied.
 
+--time::
+	Analyze samples within given time window. It supports time
+	percent with multiple time ranges. Time string is 'a%/n,b%/m,...'
+	or 'a%-b%,c%-%d,...'.
+
+	For example:
+
+	Select the second 10% time slice to diff:
+
+	  perf diff --time 10%/2
+
+	Select from 0% to 10% time slice to diff:
+
+	  perf diff --time 0%-10%
+
+	Select the first and the second 10% time slices to diff:
+
+	  perf diff --time 10%/1,10%/2
+
+	Select from 0% to 10% and 30% to 40% slices to diff:
+
+	  perf diff --time 0%-10%,30%-40%
+
+	It also supports analyzing samples within a given time window
+	<start>,<stop>. Times have the format seconds.microseconds. If 'start'
+	is not given (i.e., time string is ',x.y') then analysis starts at
+	the beginning of the file. If stop time is not given (i.e, time
+	string is 'x.y,') then analysis goes to the end of the file. Time string is
+	'a1.b1,c1.d1:a2.b2,c2.d2'. Use ':' to separate timestamps for different
+	perf.data files.
+
+	For example, we get the timestamp information from 'perf script'.
+
+	  perf script -i perf.data.old
+	    mgen 13940 [000]  3946.361400: ...
+
+	  perf script -i perf.data
+	    mgen 13940 [000]  3971.150589 ...
+
+	  perf diff --time 3946.361400,:3971.150589,
+
+	It analyzes the perf.data.old from the timestamp 3946.361400 to
+	the end of perf.data.old and analyzes the perf.data from the
+	timestamp 3971.150589 to the end of perf.data.
+
 COMPARISON
 ----------
 The comparison is governed by the baseline file. The baseline perf.data
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 58fe0e88215c..17cd898074c8 100644
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
@@ -771,19 +788,110 @@ static void data__free(struct data__file *d)
 	}
 }
 
+static int abstime_str_dup(char **pstr)
+{
+	char *str = NULL;
+
+	if (pdiff.time_str && strchr(pdiff.time_str, ':')) {
+		str = strdup(pdiff.time_str);
+		if (!str)
+			return -ENOMEM;
+	}
+
+	*pstr = str;
+	return 0;
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
-	int ret = -EINVAL, i;
+	int ret, i;
+	char *abstime_ostr, *abstime_tmp;
+
+	ret = abstime_str_dup(&abstime_ostr);
+	if (ret)
+		return ret;
+
+	abstime_tmp = abstime_ostr;
+	ret = -EINVAL;
 
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
@@ -791,6 +899,9 @@ static int __cmd_diff(void)
 		}
 
 		perf_evlist__collapse_resort(d->session->evlist);
+
+		if (pdiff.ptime_range)
+			zfree(&pdiff.ptime_range);
 	}
 
 	data_process();
@@ -802,6 +913,13 @@ static int __cmd_diff(void)
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
 
@@ -849,6 +967,8 @@ static const struct option options[] = {
 	OPT_UINTEGER('o', "order", &sort_compute, "Specify compute sorting."),
 	OPT_CALLBACK(0, "percentage", NULL, "relative|absolute",
 		     "How to display percentage of filtered entries", parse_filter_percentage),
+	OPT_STRING(0, "time", &pdiff.time_str, "str",
+		   "Time span (time percent or absolute timestamp)"),
 	OPT_END()
 };
 
-- 
2.20.1

