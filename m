Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B00C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B90A22CEA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfH2TCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:02:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51549 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728903AbfH2TCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:02:16 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i3PgM-0005Gv-9x; Thu, 29 Aug 2019 21:02:06 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 40A511C0DED;
        Thu, 29 Aug 2019 21:02:02 +0200 (CEST)
Date:   Thu, 29 Aug 2019 19:02:02 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Move 'enum perf_user_event_type' to perf/event.h
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190828135717.7245-24-jolsa@kernel.org>
References: <20190828135717.7245-24-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <156710532214.10610.9063553957043202304.tip-bot2@tip-bot2>
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

Commit-ID:     653dd8e6e8e46591f864b7ad98e10819079d5a88
Gitweb:        https://git.kernel.org/tip/653dd8e6e8e46591f864b7ad98e10819079d5a88
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Wed, 28 Aug 2019 15:57:17 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 29 Aug 2019 08:36:12 -03:00

libperf: Move 'enum perf_user_event_type' to perf/event.h

So it's available for libperf's users.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-24-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 23 +++++++++++++++++++++++
 tools/perf/util/event.h             | 23 -----------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 1655c74..1810689 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -323,6 +323,29 @@ struct perf_record_compressed {
 	char			 data[];
 };
 
+enum perf_user_event_type { /* above any possible kernel type */
+	PERF_RECORD_USER_TYPE_START		= 64,
+	PERF_RECORD_HEADER_ATTR			= 64,
+	PERF_RECORD_HEADER_EVENT_TYPE		= 65, /* deprecated */
+	PERF_RECORD_HEADER_TRACING_DATA		= 66,
+	PERF_RECORD_HEADER_BUILD_ID		= 67,
+	PERF_RECORD_FINISHED_ROUND		= 68,
+	PERF_RECORD_ID_INDEX			= 69,
+	PERF_RECORD_AUXTRACE_INFO		= 70,
+	PERF_RECORD_AUXTRACE			= 71,
+	PERF_RECORD_AUXTRACE_ERROR		= 72,
+	PERF_RECORD_THREAD_MAP			= 73,
+	PERF_RECORD_CPU_MAP			= 74,
+	PERF_RECORD_STAT_CONFIG			= 75,
+	PERF_RECORD_STAT			= 76,
+	PERF_RECORD_STAT_ROUND			= 77,
+	PERF_RECORD_EVENT_UPDATE		= 78,
+	PERF_RECORD_TIME_CONV			= 79,
+	PERF_RECORD_HEADER_FEATURE		= 80,
+	PERF_RECORD_COMPRESSED			= 81,
+	PERF_RECORD_HEADER_MAX
+};
+
 union perf_event {
 	struct perf_event_header		header;
 	struct perf_record_mmap			mmap;
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index a7341e1..4c0c523 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -146,29 +146,6 @@ struct perf_sample {
 	 PERF_MEM_S(LOCK, NA) |\
 	 PERF_MEM_S(TLB, NA))
 
-enum perf_user_event_type { /* above any possible kernel type */
-	PERF_RECORD_USER_TYPE_START		= 64,
-	PERF_RECORD_HEADER_ATTR			= 64,
-	PERF_RECORD_HEADER_EVENT_TYPE		= 65, /* deprecated */
-	PERF_RECORD_HEADER_TRACING_DATA		= 66,
-	PERF_RECORD_HEADER_BUILD_ID		= 67,
-	PERF_RECORD_FINISHED_ROUND		= 68,
-	PERF_RECORD_ID_INDEX			= 69,
-	PERF_RECORD_AUXTRACE_INFO		= 70,
-	PERF_RECORD_AUXTRACE			= 71,
-	PERF_RECORD_AUXTRACE_ERROR		= 72,
-	PERF_RECORD_THREAD_MAP			= 73,
-	PERF_RECORD_CPU_MAP			= 74,
-	PERF_RECORD_STAT_CONFIG			= 75,
-	PERF_RECORD_STAT			= 76,
-	PERF_RECORD_STAT_ROUND			= 77,
-	PERF_RECORD_EVENT_UPDATE		= 78,
-	PERF_RECORD_TIME_CONV			= 79,
-	PERF_RECORD_HEADER_FEATURE		= 80,
-	PERF_RECORD_COMPRESSED			= 81,
-	PERF_RECORD_HEADER_MAX
-};
-
 enum auxtrace_error_type {
 	PERF_AUXTRACE_ERROR_ITRACE  = 1,
 	PERF_AUXTRACE_ERROR_MAX
