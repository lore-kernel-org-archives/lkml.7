Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A08C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4C422CEA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbfH2TDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:03:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51465 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbfH2TCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:02:06 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i3PgF-00058D-V4; Thu, 29 Aug 2019 21:02:00 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5C5F91C0DE9;
        Thu, 29 Aug 2019 21:01:54 +0200 (CEST)
Date:   Thu, 29 Aug 2019 19:01:54 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Add PERF_RECORD_ID_INDEX 'struct
 id_index_event' to perf/event.h
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190828135717.7245-8-jolsa@kernel.org>
References: <20190828135717.7245-8-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <156710531425.10561.3393738240075496572.tip-bot2@tip-bot2>
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

Commit-ID:     fecb410030628d70401e06a98a585d735f61d7e2
Gitweb:        https://git.kernel.org/tip/fecb410030628d70401e06a98a585d735f61d7e2
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Wed, 28 Aug 2019 15:57:01 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 28 Aug 2019 18:15:05 -03:00

libperf: Add PERF_RECORD_ID_INDEX 'struct id_index_event' to perf/event.h

Move the PERF_RECORD_ID_INDEX event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Add the PRI_ld64 define, so we can use it in printf output.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 13 +++++++++++++
 tools/perf/util/event.h             | 15 ++-------------
 tools/perf/util/session.c           |  8 ++++----
 3 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 5e6b6d1..c68523c 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -188,4 +188,17 @@ struct build_id_event {
 	char			 filename[];
 };
 
+struct id_index_entry {
+	__u64			 id;
+	__u64			 idx;
+	__u64			 cpu;
+	__u64			 tid;
+};
+
+struct id_index_event {
+	struct perf_event_header header;
+	__u64			 nr;
+	struct id_index_entry	 entries[0];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 4b6cf89..82315d2 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -22,9 +22,11 @@
  */
 #define PRI_lu64 "l" PRIu64
 #define PRI_lx64 "l" PRIx64
+#define PRI_ld64 "l" PRId64
 #else
 #define PRI_lu64 PRIu64
 #define PRI_lx64 PRIx64
+#define PRI_ld64 PRId64
 #endif
 
 #define PERF_SAMPLE_MASK				\
@@ -330,19 +332,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-struct id_index_entry {
-	u64 id;
-	u64 idx;
-	u64 cpu;
-	u64 tid;
-};
-
-struct id_index_event {
-	struct perf_event_header header;
-	u64 nr;
-	struct id_index_entry entries[0];
-};
-
 struct auxtrace_info_event {
 	struct perf_event_header header;
 	u32 type;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index a275f2e..aa96674 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2393,10 +2393,10 @@ int perf_event__process_id_index(struct perf_session *session,
 		struct perf_sample_id *sid;
 
 		if (dump_trace) {
-			fprintf(stdout,	" ... id: %"PRIu64, e->id);
-			fprintf(stdout,	"  idx: %"PRIu64, e->idx);
-			fprintf(stdout,	"  cpu: %"PRId64, e->cpu);
-			fprintf(stdout,	"  tid: %"PRId64"\n", e->tid);
+			fprintf(stdout,	" ... id: %"PRI_lu64, e->id);
+			fprintf(stdout,	"  idx: %"PRI_lu64, e->idx);
+			fprintf(stdout,	"  cpu: %"PRI_ld64, e->cpu);
+			fprintf(stdout,	"  tid: %"PRI_ld64"\n", e->tid);
 		}
 
 		sid = perf_evlist__id2sid(evlist, e->id);
