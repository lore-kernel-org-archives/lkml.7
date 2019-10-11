Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB9AC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40B421835
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfJKSVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 14:21:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:30728 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728472AbfJKSVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 14:21:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2019 11:21:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,285,1566889200"; 
   d="scan'208";a="207480147"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga001.fm.intel.com with ESMTP; 11 Oct 2019 11:21:42 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 70186300322; Fri, 11 Oct 2019 11:21:42 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 1/2] perf script: Fix --reltime with --time
Date:   Fri, 11 Oct 2019 11:21:39 -0700
Message-Id: <20191011182140.8353-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

My earlier patch to just enable --reltime with --time was a little too optimistic.
The --time parsing would accept absolute time, which is very confusing to the user.

Support relative time in --time parsing too. This only works with recent perf
record that records the first sample time. Otherwise we error out.

Fixes: 3714437d3fcc ("perf script: Allow --time with --reltime")
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/builtin-script.c  |  5 +++--
 tools/perf/util/time-utils.c | 27 ++++++++++++++++++++++++---
 tools/perf/util/time-utils.h |  5 +++++
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 1c797a948ada..f86c5cce5b2c 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3864,10 +3864,11 @@ int cmd_script(int argc, const char **argv)
 		goto out_delete;
 
 	if (script.time_str) {
-		err = perf_time__parse_for_ranges(script.time_str, session,
+		err = perf_time__parse_for_ranges_reltime(script.time_str, session,
 						  &script.ptime_range,
 						  &script.range_size,
-						  &script.range_num);
+						  &script.range_num,
+						  reltime);
 		if (err < 0)
 			goto out_delete;
 
diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 9796a2e43f67..302443921681 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -458,10 +458,11 @@ bool perf_time__ranges_skip_sample(struct perf_time_interval *ptime_buf,
 	return true;
 }
 
-int perf_time__parse_for_ranges(const char *time_str,
+int perf_time__parse_for_ranges_reltime(const char *time_str,
 				struct perf_session *session,
 				struct perf_time_interval **ranges,
-				int *range_size, int *range_num)
+				int *range_size, int *range_num,
+				bool reltime)
 {
 	bool has_percent = strchr(time_str, '%');
 	struct perf_time_interval *ptime_range;
@@ -471,7 +472,7 @@ int perf_time__parse_for_ranges(const char *time_str,
 	if (!ptime_range)
 		return -ENOMEM;
 
-	if (has_percent) {
+	if (has_percent || reltime) {
 		if (session->evlist->first_sample_time == 0 &&
 		    session->evlist->last_sample_time == 0) {
 			pr_err("HINT: no first/last sample time found in perf data.\n"
@@ -479,7 +480,9 @@ int perf_time__parse_for_ranges(const char *time_str,
 			       "(if '--buildid-all' is enabled, please set '--timestamp-boundary').\n");
 			goto error;
 		}
+	}
 
+	if (has_percent) {
 		num = perf_time__percent_parse_str(
 				ptime_range, size,
 				time_str,
@@ -492,6 +495,15 @@ int perf_time__parse_for_ranges(const char *time_str,
 	if (num < 0)
 		goto error_invalid;
 
+	if (reltime) {
+		int i;
+
+		for (i = 0; i < num; i++) {
+			ptime_range[i].start += session->evlist->first_sample_time;
+			ptime_range[i].end += session->evlist->first_sample_time;
+		}
+	}
+
 	*range_size = size;
 	*range_num = num;
 	*ranges = ptime_range;
@@ -504,6 +516,15 @@ int perf_time__parse_for_ranges(const char *time_str,
 	return ret;
 }
 
+int perf_time__parse_for_ranges(const char *time_str,
+				struct perf_session *session,
+				struct perf_time_interval **ranges,
+				int *range_size, int *range_num)
+{
+	return perf_time__parse_for_ranges_reltime(time_str, session, ranges,
+					range_size, range_num, false);
+}
+
 int timestamp__scnprintf_usec(u64 timestamp, char *buf, size_t sz)
 {
 	u64  sec = timestamp / NSEC_PER_SEC;
diff --git a/tools/perf/util/time-utils.h b/tools/perf/util/time-utils.h
index 4f42988eb2f7..1142b0bddd5e 100644
--- a/tools/perf/util/time-utils.h
+++ b/tools/perf/util/time-utils.h
@@ -26,6 +26,11 @@ bool perf_time__ranges_skip_sample(struct perf_time_interval *ptime_buf,
 
 struct perf_session;
 
+int perf_time__parse_for_ranges_reltime(const char *str, struct perf_session *session,
+				struct perf_time_interval **ranges,
+				int *range_size, int *range_num,
+				bool reltime);
+
 int perf_time__parse_for_ranges(const char *str, struct perf_session *session,
 				struct perf_time_interval **ranges,
 				int *range_size, int *range_num);
-- 
2.21.0

