Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890B8CA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D50521D71
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbfJVADu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:03:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730548AbfJVADo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:03:44 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgxU-0004Ho-Gy; Tue, 22 Oct 2019 01:19:29 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BF2601C04D3;
        Tue, 22 Oct 2019 01:19:20 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:19:20 -0000
From:   "tip-bot2 for Andi Kleen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf script: Fix --reltime with --time
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191011182140.8353-1-andi@firstfloor.org>
References: <20191011182140.8353-1-andi@firstfloor.org>
MIME-Version: 1.0
Message-ID: <157169996037.29376.11389091155150315603.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b3509b6ed7a79ec49f6b64e4f3b780f259a2a468
Gitweb:        https://git.kernel.org/tip/b3509b6ed7a79ec49f6b64e4f3b780f259a2a468
Author:        Andi Kleen <ak@linux.intel.com>
AuthorDate:    Fri, 11 Oct 2019 11:21:39 -07:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 15 Oct 2019 08:36:22 -03:00

perf script: Fix --reltime with --time

My earlier patch to just enable --reltime with --time was a little too
optimistic.  The --time parsing would accept absolute time, which is
very confusing to the user.

Support relative time in --time parsing too. This only works with recent
perf record that records the first sample time. Otherwise we error out.

Fixes: 3714437d3fcc ("perf script: Allow --time with --reltime")
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20191011182140.8353-1-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c  |  5 +++--
 tools/perf/util/time-utils.c | 27 ++++++++++++++++++++++++---
 tools/perf/util/time-utils.h |  5 +++++
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 1c797a9..f86c5cc 100644
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
index 9796a2e..3024439 100644
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
@@ -504,6 +516,15 @@ error:
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
index 4f42988..1142b0b 100644
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
