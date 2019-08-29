Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB11C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D26422CEA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbfH2TCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:02:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51430 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbfH2TCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:02:03 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i3PgB-00056f-Qm; Thu, 29 Aug 2019 21:01:55 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 621381C0DE7;
        Thu, 29 Aug 2019 21:01:52 +0200 (CEST)
Date:   Thu, 29 Aug 2019 19:01:52 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Add PERF_RECORD_EVENT_UPDATE 'struct
 event_update_event' to perf/event.h
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190828135717.7245-4-jolsa@kernel.org>
References: <20190828135717.7245-4-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <156710531231.10547.8135075272656936446.tip-bot2@tip-bot2>
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

Commit-ID:     5ded068e923837068e39c0fd4ab40c0dacaa08e8
Gitweb:        https://git.kernel.org/tip/5ded068e923837068e39c0fd4ab40c0dacaa08e8
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Wed, 28 Aug 2019 15:56:57 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 28 Aug 2019 18:15:04 -03:00

libperf: Add PERF_RECORD_EVENT_UPDATE 'struct event_update_event' to perf/event.h

Move the PERF_RECORD_EVENT_UPDATE event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 22 ++++++++++++++++++++++
 tools/perf/util/event.h             | 23 -----------------------
 tools/perf/util/header.c            |  2 +-
 3 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 469be77..3d99818 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -141,4 +141,26 @@ struct cpu_map_event {
 	struct cpu_map_data	 data;
 };
 
+enum {
+	PERF_EVENT_UPDATE__UNIT  = 0,
+	PERF_EVENT_UPDATE__SCALE = 1,
+	PERF_EVENT_UPDATE__NAME  = 2,
+	PERF_EVENT_UPDATE__CPUS  = 3,
+};
+
+struct event_update_event_cpus {
+	struct cpu_map_data	 cpus;
+};
+
+struct event_update_event_scale {
+	double			 scale;
+};
+
+struct event_update_event {
+	struct perf_event_header header;
+	__u64			 type;
+	__u64			 id;
+	char			 data[];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 84bf673..a579e6b 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -337,29 +337,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-enum {
-	PERF_EVENT_UPDATE__UNIT  = 0,
-	PERF_EVENT_UPDATE__SCALE = 1,
-	PERF_EVENT_UPDATE__NAME  = 2,
-	PERF_EVENT_UPDATE__CPUS  = 3,
-};
-
-struct event_update_event_cpus {
-	struct cpu_map_data cpus;
-};
-
-struct event_update_event_scale {
-	double scale;
-};
-
-struct event_update_event {
-	struct perf_event_header header;
-	u64 type;
-	u64 id;
-
-	char data[];
-};
-
 #define MAX_EVENT_NAME 64
 
 struct perf_trace_event_type {
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 8e67faf..629bdb1 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3893,7 +3893,7 @@ size_t perf_event__fprintf_event_update(union perf_event *event, FILE *fp)
 	struct perf_cpu_map *map;
 	size_t ret;
 
-	ret = fprintf(fp, "\n... id:    %" PRIu64 "\n", ev->id);
+	ret = fprintf(fp, "\n... id:    %" PRI_lu64 "\n", ev->id);
 
 	switch (ev->type) {
 	case PERF_EVENT_UPDATE__SCALE:
