Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655A4C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E8A23697
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340661;
	bh=FQyZII0a2nZMQJpdAHRQYdZjNXwRqJN56ndS27mxPcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VD/lA9xoF//fuk+1BDFcGj9q1EfpIK7T4KzvDv3fhJYAhWUgcQzG7b57B59O/VeGw
	 7E0rwHy8yPM5CYcvp4b2AziYvWKtcP4njRuX8vhc6X8JN7UVMGHmtvkiHi4EyGyOYD
	 4buYDAA1k6rCXlx5trbJn60Qyy+DE1/tvUmtIMaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbfIAMYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:24:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728983AbfIAMYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:24:14 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBA0F2342E;
        Sun,  1 Sep 2019 12:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340654;
        bh=FQyZII0a2nZMQJpdAHRQYdZjNXwRqJN56ndS27mxPcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mzJ7W1ZrvF+HXkcNPsQSwP9aKyTMkqnulk6GDQS1HgTEXIgdEYQzE4HCPhOrbcC5J
         rB+qTf0rP5elyNv9ECX+k4sWWbLmLzfDdSHg+ubi+E2dcq/A6yCT1pfy4UjuH86on4
         ILPbXSHOds5jS3fjQ4qjTxlsOY+KL15V5PQN6tsM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 12/47] perf time-utils: Adopt rdclock() from perf.h
Date:   Sun,  1 Sep 2019 09:22:51 -0300
Message-Id: <20190901122326.5793-13-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Seems to be a better place for this function to live, further shrinking
the hodge-podge that perf.h was.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-0zzt1u9rpyjukdy1ccr2u5r9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c    | 1 +
 tools/perf/perf.h            | 9 ---------
 tools/perf/util/event.c      | 1 +
 tools/perf/util/time-utils.h | 9 +++++++++
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a7e8c26635db..2741bcb049fb 100644
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
index 7a1a92127b9b..74014033df60 100644
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
index c9d1f83c747a..7fa7a303e476 100644
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
index 72a42ea1d513..4f42988eb2f7 100644
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
-- 
2.21.0

