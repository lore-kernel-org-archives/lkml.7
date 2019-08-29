Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B67C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFEC22CEA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfH2TCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:02:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51512 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728806AbfH2TCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:02:11 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i3PgI-0005Ds-GT; Thu, 29 Aug 2019 21:02:02 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 54B961C0DE8;
        Thu, 29 Aug 2019 21:01:59 +0200 (CEST)
Date:   Thu, 29 Aug 2019 19:01:59 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Add PERF_RECORD_STAT_ROUND 'struct
 stat_round_event' to perf/event.h
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190828135717.7245-18-jolsa@kernel.org>
References: <20190828135717.7245-18-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <156710531922.10592.17801158953189534104.tip-bot2@tip-bot2>
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

Commit-ID:     782adbe2964953803ea1a38b80f6255c336cdd7b
Gitweb:        https://git.kernel.org/tip/782adbe2964953803ea1a38b80f6255c336cdd7b
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Wed, 28 Aug 2019 15:57:11 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 29 Aug 2019 08:36:12 -03:00

libperf: Add PERF_RECORD_STAT_ROUND 'struct stat_round_event' to perf/event.h

Move the PERF_RECORD_STAT_ROUND event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-18-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 6 ++++++
 tools/perf/util/event.h             | 6 ------
 tools/perf/util/stat.c              | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 7d1834f..34d365b 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -299,4 +299,10 @@ struct stat_event {
 	};
 };
 
+struct stat_round_event {
+	struct perf_event_header header;
+	__u64			 type;
+	__u64			 time;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index f3a02e0..ec76412 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -337,12 +337,6 @@ enum {
 	PERF_STAT_ROUND_TYPE__FINAL	= 1,
 };
 
-struct stat_round_event {
-	struct perf_event_header	header;
-	u64				type;
-	u64				time;
-};
-
 struct time_conv_event {
 	struct perf_event_header header;
 	u64 time_shift;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index c0cd9f9..4c79574 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -418,7 +418,7 @@ size_t perf_event__fprintf_stat_round(union perf_event *event, FILE *fp)
 	struct stat_round_event *rd = (struct stat_round_event *)event;
 	size_t ret;
 
-	ret = fprintf(fp, "\n... time %" PRIu64 ", type %s\n", rd->time,
+	ret = fprintf(fp, "\n... time %" PRI_lu64 ", type %s\n", rd->time,
 		      rd->type == PERF_STAT_ROUND_TYPE__FINAL ? "FINAL" : "INTERVAL");
 
 	return ret;
