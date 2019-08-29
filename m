Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2E7C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190362189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbfH2TD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:03:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51464 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfH2TCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:02:07 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i3PgD-00059p-Cy; Thu, 29 Aug 2019 21:01:57 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5B24A1C0DEA;
        Thu, 29 Aug 2019 21:01:55 +0200 (CEST)
Date:   Thu, 29 Aug 2019 19:01:55 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Add PERF_RECORD_AUXTRACE 'struct
 auxtrace_event' to perf/event.h
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190828135717.7245-10-jolsa@kernel.org>
References: <20190828135717.7245-10-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <156710531528.10568.3815035679236242059.tip-bot2@tip-bot2>
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

Commit-ID:     306c9d24c09d84d80ae54b36f7f907c8b8fa537a
Gitweb:        https://git.kernel.org/tip/306c9d24c09d84d80ae54b36f7f907c8b8fa537a
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Wed, 28 Aug 2019 15:57:03 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 29 Aug 2019 08:36:11 -03:00

libperf: Add PERF_RECORD_AUXTRACE 'struct auxtrace_event' to perf/event.h

Move the PERF_RECORD_AUXTRACE event definition to libperf's event.h.

Ipn order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-10-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 11 +++++++++++
 tools/perf/util/auxtrace.c          |  2 +-
 tools/perf/util/event.h             | 11 -----------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 02da734..78001c2 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -208,4 +208,15 @@ struct auxtrace_info_event {
 	__u64			 priv[];
 };
 
+struct auxtrace_event {
+	struct perf_event_header header;
+	__u64			 size;
+	__u64			 offset;
+	__u64			 reference;
+	__u32			 idx;
+	__u32			 tid;
+	__u32			 cpu;
+	__u32			 reserved__; /* For alignment */
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 112c24a..5edec71 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -943,7 +943,7 @@ s64 perf_event__process_auxtrace(struct perf_session *session,
 	s64 err;
 
 	if (dump_trace)
-		fprintf(stdout, " size: %#"PRIx64"  offset: %#"PRIx64"  ref: %#"PRIx64"  idx: %u  tid: %d  cpu: %d\n",
+		fprintf(stdout, " size: %#"PRI_lx64"  offset: %#"PRI_lx64"  ref: %#"PRI_lx64"  idx: %u  tid: %d  cpu: %d\n",
 			event->auxtrace.size, event->auxtrace.offset,
 			event->auxtrace.reference, event->auxtrace.idx,
 			event->auxtrace.tid, event->auxtrace.cpu);
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index ca2cae3..60895a3 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -332,17 +332,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-struct auxtrace_event {
-	struct perf_event_header header;
-	u64 size;
-	u64 offset;
-	u64 reference;
-	u32 idx;
-	u32 tid;
-	u32 cpu;
-	u32 reserved__; /* For alignment */
-};
-
 #define MAX_AUXTRACE_ERROR_MSG 64
 
 struct auxtrace_error_event {
