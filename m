Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B966C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FE3215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbfIBIQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:16:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56139 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729909AbfIBIQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:16:34 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hVk-00080x-At; Mon, 02 Sep 2019 10:16:28 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E7A2F1C0DE7;
        Mon,  2 Sep 2019 10:16:27 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:27 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf time-utils: Adopt rdclock() from perf.h
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-0zzt1u9rpyjukdy1ccr2u5r9@git.kernel.org>
References: <tip-0zzt1u9rpyjukdy1ccr2u5r9@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156741218774.17299.1627589289097656458.tip-bot2@tip-bot2>
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

Commit-ID:     f37110205c3065546d6995b1463751c7bbb50e89
Gitweb:        https://git.kernel.org/tip/f37110205c3065546d6995b1463751c7bbb50e89
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 29 Aug 2019 15:16:27 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 29 Aug 2019 17:38:32 -03:00

perf time-utils: Adopt rdclock() from perf.h

Seems to be a better place for this function to live, further shrinking
the hodge-podge that perf.h was.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-0zzt1u9rpyjukdy1ccr2u5r9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c    |  1 +
 tools/perf/perf.h            |  9 ---------
 tools/perf/util/event.c      |  1 +
 tools/perf/util/time-utils.h |  9 +++++++++
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a7e8c26..2741bcb 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -62,6 +62,7 @@
 #include "util/string2.h"
 #include "util/metricgroup.h"
 #include "util/target.h"
+#include "util/time-utils.h"
 #include "util/top.h"
 #include "asm/bug.h"
 
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 7a1a921..7401403 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -2,17 +2,8 @@
 #ifndef _PERF_PERF_H
 #define _PERF_PERF_H
 
-#include <time.h>
 #include <stdbool.h>
 
-static inline unsigned long long rdclock(void)
-{
-	struct timespec ts;
-
-	clock_gettime(CLOCK_MONOTONIC, &ts);
-	return ts.tv_sec * 1000000000ULL + ts.tv_nsec;
-}
-
 #ifndef MAX_NR_CPUS
 #define MAX_NR_CPUS			2048
 #endif
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index c9d1f83..7fa7a30 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -21,6 +21,7 @@
 #include "strlist.h"
 #include "thread.h"
 #include "thread_map.h"
+#include "time-utils.h"
 #include <linux/ctype.h>
 #include "map.h"
 #include "symbol.h"
diff --git a/tools/perf/util/time-utils.h b/tools/perf/util/time-utils.h
index 72a42ea..4f42988 100644
--- a/tools/perf/util/time-utils.h
+++ b/tools/perf/util/time-utils.h
@@ -3,6 +3,7 @@
 #define _TIME_UTILS_H_
 
 #include <stddef.h>
+#include <time.h>
 #include <linux/types.h>
 
 struct perf_time_interval {
@@ -34,4 +35,12 @@ int timestamp__scnprintf_nsec(u64 timestamp, char *buf, size_t sz);
 
 int fetch_current_timestamp(char *buf, size_t sz);
 
+static inline unsigned long long rdclock(void)
+{
+	struct timespec ts;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	return ts.tv_sec * 1000000000ULL + ts.tv_nsec;
+}
+
 #endif
