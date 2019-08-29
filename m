Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5FFC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A792189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbfH2TDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:03:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51451 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728700AbfH2TCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:02:05 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i3PgE-0005AG-Hg; Thu, 29 Aug 2019 21:01:58 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C6E021C0DEB;
        Thu, 29 Aug 2019 21:01:55 +0200 (CEST)
Date:   Thu, 29 Aug 2019 19:01:55 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Add PERF_RECORD_AUXTRACE_ERROR 'struct
 auxtrace_error_event' to perf/event.h
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190828135717.7245-11-jolsa@kernel.org>
References: <20190828135717.7245-11-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <156710531573.10571.6241130853636342452.tip-bot2@tip-bot2>
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

Commit-ID:     3460efb2e842cccc4566756f194a1be0547f7098
Gitweb:        https://git.kernel.org/tip/3460efb2e842cccc4566756f194a1be0547f7098
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Wed, 28 Aug 2019 15:57:04 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 29 Aug 2019 08:36:11 -03:00

libperf: Add PERF_RECORD_AUXTRACE_ERROR 'struct auxtrace_error_event' to perf/event.h

Move the PERF_RECORD_AUXTRACE_ERROR event definition to libperf's
event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-11-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 15 +++++++++++++++
 tools/perf/util/auxtrace.c          |  2 +-
 tools/perf/util/event.h             | 15 ---------------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 78001c2..6292b7c 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -219,4 +219,19 @@ struct auxtrace_event {
 	__u32			 reserved__; /* For alignment */
 };
 
+#define MAX_AUXTRACE_ERROR_MSG 64
+
+struct auxtrace_error_event {
+	struct perf_event_header header;
+	__u32			 type;
+	__u32			 code;
+	__u32			 cpu;
+	__u32			 pid;
+	__u32			 tid;
+	__u32			 fmt;
+	__u64			 ip;
+	__u64			 time;
+	char			 msg[MAX_AUXTRACE_ERROR_MSG];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 5edec71..c3da8a0 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1189,7 +1189,7 @@ size_t perf_event__fprintf_auxtrace_error(union perf_event *event, FILE *fp)
 	if (!e->fmt)
 		msg = (const char *)&e->time;
 
-	ret += fprintf(fp, " cpu %d pid %d tid %d ip %#"PRIx64" code %u: %s\n",
+	ret += fprintf(fp, " cpu %d pid %d tid %d ip %#"PRI_lx64" code %u: %s\n",
 		       e->cpu, e->pid, e->tid, e->ip, e->code, msg);
 	return ret;
 }
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 60895a3..e334ecb 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -332,21 +332,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-#define MAX_AUXTRACE_ERROR_MSG 64
-
-struct auxtrace_error_event {
-	struct perf_event_header header;
-	u32 type;
-	u32 code;
-	u32 cpu;
-	u32 pid;
-	u32 tid;
-	u32 fmt;
-	u64 ip;
-	u64 time;
-	char msg[MAX_AUXTRACE_ERROR_MSG];
-};
-
 struct aux_event {
 	struct perf_event_header header;
 	u64	aux_offset;
