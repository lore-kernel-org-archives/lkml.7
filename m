Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50779C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2832173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730792AbfH0I1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:27:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42831 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729935AbfH0I0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:26:32 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2Wo3-0007u0-EC; Tue, 27 Aug 2019 10:26:23 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B30D81C0DE3;
        Tue, 27 Aug 2019 10:26:21 +0200 (CEST)
Date:   Tue, 27 Aug 2019 08:26:21 -0000
From:   tip-bot2 for Jiri Olsa <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Add PERF_RECORD_READ 'struct read_event' to
 perf/event.h
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190825181752.722-9-jolsa@kernel.org>
References: <20190825181752.722-9-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <156689438154.24544.8209665051621814081.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     213a6c1d20687d44acaa1cb4f77ce5bae4f1dd8f
Gitweb:        https://git.kernel.org/tip/213a6c1d20687d44acaa1cb4f77ce5bae4f1dd8f
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Sun, 25 Aug 2019 20:17:48 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 26 Aug 2019 19:39:10 -03:00

libperf: Add PERF_RECORD_READ 'struct read_event' to perf/event.h

Move the PERF_RECORD_READ event definition to libperf's event.h header
include.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Perf added 'u*' types mainly to ease up printing __u64 values
as stated in the linux/types.h comment:

  /*
   * We define u64 as uint64_t for every architecture
   * so that we can print it with "%"PRIx64 without getting warnings.
   *
   * typedef __u64 u64;
   * typedef __s64 s64;
   */

Add and use new PRI_lu64 and PRI_lx64 macros for that.  Use extra '_' to
ease up the reading and differentiate them from standard PRI*64 macros.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190825181752.722-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 12 ++++++++++++
 tools/perf/util/event.h             | 12 ------------
 tools/perf/util/session.c           |  8 ++++----
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 86a7795..f183070 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -61,4 +61,16 @@ struct lost_samples_event {
 	__u64			 lost;
 };
 
+/*
+ * PERF_FORMAT_ENABLED | PERF_FORMAT_RUNNING | PERF_FORMAT_ID
+ */
+struct read_event {
+	struct perf_event_header header;
+	__u32			 pid, tid;
+	__u64			 value;
+	__u64			 time_enabled;
+	__u64			 time_running;
+	__u64			 id;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 976a8f0..008a283 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -27,18 +27,6 @@
 #define PRI_lx64 PRIx64
 #endif
 
-/*
- * PERF_FORMAT_ENABLED | PERF_FORMAT_RUNNING | PERF_FORMAT_ID
- */
-struct read_event {
-	struct perf_event_header header;
-	u32 pid, tid;
-	u64 value;
-	u64 time_enabled;
-	u64 time_running;
-	u64 id;
-};
-
 struct throttle_event {
 	struct perf_event_header header;
 	u64 time;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 82e0438..cb1d8dc 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1260,7 +1260,7 @@ static void dump_read(struct evsel *evsel, union perf_event *event)
 	if (!dump_trace)
 		return;
 
-	printf(": %d %d %s %" PRIu64 "\n", event->read.pid, event->read.tid,
+	printf(": %d %d %s %" PRI_lu64 "\n", event->read.pid, event->read.tid,
 	       perf_evsel__name(evsel),
 	       event->read.value);
 
@@ -1270,13 +1270,13 @@ static void dump_read(struct evsel *evsel, union perf_event *event)
 	read_format = evsel->core.attr.read_format;
 
 	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
-		printf("... time enabled : %" PRIu64 "\n", read_event->time_enabled);
+		printf("... time enabled : %" PRI_lu64 "\n", read_event->time_enabled);
 
 	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
-		printf("... time running : %" PRIu64 "\n", read_event->time_running);
+		printf("... time running : %" PRI_lu64 "\n", read_event->time_running);
 
 	if (read_format & PERF_FORMAT_ID)
-		printf("... id           : %" PRIu64 "\n", read_event->id);
+		printf("... id           : %" PRI_lu64 "\n", read_event->id);
 }
 
 static struct machine *machines__find_for_cpumode(struct machines *machines,
