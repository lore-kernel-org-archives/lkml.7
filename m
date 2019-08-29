Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435A0C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E8F2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfH2TCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:02:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51489 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728782AbfH2TCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:02:09 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i3PgH-0005DN-MA; Thu, 29 Aug 2019 21:02:01 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C04DA1C0DED;
        Thu, 29 Aug 2019 21:01:58 +0200 (CEST)
Date:   Thu, 29 Aug 2019 19:01:58 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Add PERF_RECORD_STAT 'struct stat_event' to
 perf/event.h
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190828135717.7245-17-jolsa@kernel.org>
References: <20190828135717.7245-17-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <156710531865.10589.6576230534513379742.tip-bot2@tip-bot2>
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

Commit-ID:     18a13a60f6f50f2fb1f7354f6d0b2ded01995443
Gitweb:        https://git.kernel.org/tip/18a13a60f6f50f2fb1f7354f6d0b2ded01995443
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Wed, 28 Aug 2019 15:57:10 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 29 Aug 2019 08:36:12 -03:00

libperf: Add PERF_RECORD_STAT 'struct stat_event' to perf/event.h

Move the PERF_RECORD_STAT event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-17-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 17 +++++++++++++++++
 tools/perf/util/event.h             | 17 -----------------
 tools/perf/util/stat.c              |  4 ++--
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index ba6ed24..7d1834f 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -282,4 +282,21 @@ struct stat_config_event {
 	struct stat_config_event_entry	 data[];
 };
 
+struct stat_event {
+	struct perf_event_header header;
+
+	__u64			 id;
+	__u32			 cpu;
+	__u32			 thread;
+
+	union {
+		struct {
+			__u64	 val;
+			__u64	 ena;
+			__u64	 run;
+		};
+		__u64		 values[3];
+	};
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 68531d0..f3a02e0 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -332,23 +332,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-struct stat_event {
-	struct perf_event_header	header;
-
-	u64	id;
-	u32	cpu;
-	u32	thread;
-
-	union {
-		struct {
-			u64 val;
-			u64 ena;
-			u64 run;
-		};
-		u64 values[3];
-	};
-};
-
 enum {
 	PERF_STAT_ROUND_TYPE__INTERVAL	= 0,
 	PERF_STAT_ROUND_TYPE__FINAL	= 1,
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index f985336..c0cd9f9 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -405,9 +405,9 @@ size_t perf_event__fprintf_stat(union perf_event *event, FILE *fp)
 	struct stat_event *st = (struct stat_event *) event;
 	size_t ret;
 
-	ret  = fprintf(fp, "\n... id %" PRIu64 ", cpu %d, thread %d\n",
+	ret  = fprintf(fp, "\n... id %" PRI_lu64 ", cpu %d, thread %d\n",
 		       st->id, st->cpu, st->thread);
-	ret += fprintf(fp, "... value %" PRIu64 ", enabled %" PRIu64 ", running %" PRIu64 "\n",
+	ret += fprintf(fp, "... value %" PRI_lu64 ", enabled %" PRI_lu64 ", running %" PRI_lu64 "\n",
 		       st->val, st->ena, st->run);
 
 	return ret;
