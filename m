Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CACC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 06:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F721218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 06:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730985AbfB1GjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 01:39:25 -0500
Received: from mga17.intel.com ([192.55.52.151]:22675 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730961AbfB1GjY (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 01:39:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 22:39:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,422,1544515200"; 
   d="scan'208";a="322792891"
Received: from skl.sh.intel.com ([10.239.159.132])
  by fmsmga006.fm.intel.com with ESMTP; 27 Feb 2019 22:39:22 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf util: Refactor time range parsing code
Date:   Thu, 28 Feb 2019 22:30:09 +0800
Message-Id: <1551364210-31350-1-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri points out that we don't need any time checking and time string
parsing if the --time option is not set. That makes sense.

This patch refactors the time range parsing code, move the duplicated
code from perf report and perf script to time_utils and check if --time
option is set before parsing the time string.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-report.c  | 38 +++++++--------------------------
 tools/perf/builtin-script.c  | 39 +++++++--------------------------
 tools/perf/util/time-utils.c | 51 +++++++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/time-utils.h |  6 ++++++
 4 files changed, 72 insertions(+), 62 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 1532ebd..ee93c18 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1375,36 +1375,13 @@ int cmd_report(int argc, const char **argv)
 	if (symbol__init(&session->header.env) < 0)
 		goto error;
 
-	report.ptime_range = perf_time__range_alloc(report.time_str,
-						    &report.range_size);
-	if (!report.ptime_range) {
-		ret = -ENOMEM;
-		goto error;
-	}
-
-	if (perf_time__parse_str(report.ptime_range, report.time_str) != 0) {
-		if (session->evlist->first_sample_time == 0 &&
-		    session->evlist->last_sample_time == 0) {
-			pr_err("HINT: no first/last sample time found in perf data.\n"
-			       "Please use latest perf binary to execute 'perf record'\n"
-			       "(if '--buildid-all' is enabled, please set '--timestamp-boundary').\n");
-			ret = -EINVAL;
-			goto error;
-		}
-
-		report.range_num = perf_time__percent_parse_str(
-					report.ptime_range, report.range_size,
-					report.time_str,
-					session->evlist->first_sample_time,
-					session->evlist->last_sample_time);
-
-		if (report.range_num < 0) {
-			pr_err("Invalid time string\n");
-			ret = -EINVAL;
+	if (report.time_str) {
+		ret = perf_time__parse_for_ranges(report.time_str, session,
+						  &report.ptime_range,
+						  &report.range_size,
+						  &report.range_num);
+		if (ret < 0)
 			goto error;
-		}
-	} else {
-		report.range_num = 1;
 	}
 
 	if (session->tevent.pevent &&
@@ -1426,7 +1403,8 @@ int cmd_report(int argc, const char **argv)
 		ret = 0;
 
 error:
-	zfree(&report.ptime_range);
+	if (report.ptime_range)
+		zfree(&report.ptime_range);
 
 	perf_session__delete(session);
 	return ret;
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 2d8cb1d..53f78cf 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3699,37 +3699,13 @@ int cmd_script(int argc, const char **argv)
 	if (err < 0)
 		goto out_delete;
 
-	script.ptime_range = perf_time__range_alloc(script.time_str,
-						    &script.range_size);
-	if (!script.ptime_range) {
-		err = -ENOMEM;
-		goto out_delete;
-	}
-
-	/* needs to be parsed after looking up reference time */
-	if (perf_time__parse_str(script.ptime_range, script.time_str) != 0) {
-		if (session->evlist->first_sample_time == 0 &&
-		    session->evlist->last_sample_time == 0) {
-			pr_err("HINT: no first/last sample time found in perf data.\n"
-			       "Please use latest perf binary to execute 'perf record'\n"
-			       "(if '--buildid-all' is enabled, please set '--timestamp-boundary').\n");
-			err = -EINVAL;
-			goto out_delete;
-		}
-
-		script.range_num = perf_time__percent_parse_str(
-					script.ptime_range, script.range_size,
-					script.time_str,
-					session->evlist->first_sample_time,
-					session->evlist->last_sample_time);
-
-		if (script.range_num < 0) {
-			pr_err("Invalid time string\n");
-			err = -EINVAL;
+	if (script.time_str) {
+		err = perf_time__parse_for_ranges(script.time_str, session,
+						  &script.ptime_range,
+						  &script.range_size,
+						  &script.range_num);
+		if (err < 0)
 			goto out_delete;
-		}
-	} else {
-		script.range_num = 1;
 	}
 
 	err = __cmd_script(&script);
@@ -3737,7 +3713,8 @@ int cmd_script(int argc, const char **argv)
 	flush_scripting();
 
 out_delete:
-	zfree(&script.ptime_range);
+	if (script.ptime_range)
+		zfree(&script.ptime_range);
 
 	perf_evlist__free_stats(session->evlist);
 	perf_session__delete(session);
diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 6193b46..0f53bae 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -11,6 +11,8 @@
 #include "perf.h"
 #include "debug.h"
 #include "time-utils.h"
+#include "session.h"
+#include "evlist.h"
 
 int parse_nsec_time(const char *str, u64 *ptime)
 {
@@ -374,7 +376,7 @@ bool perf_time__ranges_skip_sample(struct perf_time_interval *ptime_buf,
 	struct perf_time_interval *ptime;
 	int i;
 
-	if ((timestamp == 0) || (num == 0))
+	if ((!ptime_buf) || (timestamp == 0) || (num == 0))
 		return false;
 
 	if (num == 1)
@@ -396,6 +398,53 @@ bool perf_time__ranges_skip_sample(struct perf_time_interval *ptime_buf,
 	return (i == num) ? true : false;
 }
 
+int perf_time__parse_for_ranges(const char *time_str,
+				struct perf_session *session,
+				struct perf_time_interval **ranges,
+				int *range_size, int *range_num)
+{
+	struct perf_time_interval *ptime_range;
+	int size, num, ret;
+
+	ptime_range = perf_time__range_alloc(time_str, &size);
+	if (!ptime_range)
+		return -ENOMEM;
+
+	if (perf_time__parse_str(ptime_range, time_str) != 0) {
+		if (session->evlist->first_sample_time == 0 &&
+		    session->evlist->last_sample_time == 0) {
+			pr_err("HINT: no first/last sample time found in perf data.\n"
+			       "Please use latest perf binary to execute 'perf record'\n"
+			       "(if '--buildid-all' is enabled, please set '--timestamp-boundary').\n");
+			ret = -EINVAL;
+			goto error;
+		}
+
+		num = perf_time__percent_parse_str(
+				ptime_range, size,
+				time_str,
+				session->evlist->first_sample_time,
+				session->evlist->last_sample_time);
+
+		if (num < 0) {
+			pr_err("Invalid time string\n");
+			ret = -EINVAL;
+			goto error;
+		}
+	} else {
+		num = 1;
+	}
+
+	*range_size = size;
+	*range_num = num;
+	*ranges = ptime_range;
+	return 0;
+
+error:
+	free(ptime_range);
+	return ret;
+}
+
 int timestamp__scnprintf_usec(u64 timestamp, char *buf, size_t sz)
 {
 	u64  sec = timestamp / NSEC_PER_SEC;
diff --git a/tools/perf/util/time-utils.h b/tools/perf/util/time-utils.h
index 70b177d..b923de4 100644
--- a/tools/perf/util/time-utils.h
+++ b/tools/perf/util/time-utils.h
@@ -23,6 +23,12 @@ bool perf_time__skip_sample(struct perf_time_interval *ptime, u64 timestamp);
 bool perf_time__ranges_skip_sample(struct perf_time_interval *ptime_buf,
 				   int num, u64 timestamp);
 
+struct perf_session;
+
+int perf_time__parse_for_ranges(const char *str, struct perf_session *session,
+				struct perf_time_interval **ranges,
+				int *range_size, int *range_num);
+
 int timestamp__scnprintf_usec(u64 timestamp, char *buf, size_t sz);
 
 int fetch_current_timestamp(char *buf, size_t sz);
-- 
2.7.4

