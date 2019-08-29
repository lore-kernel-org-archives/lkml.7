Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DE7C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8781C2189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbfH2TDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:03:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51515 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbfH2TCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:02:11 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i3PgJ-0005Cr-PB; Thu, 29 Aug 2019 21:02:04 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4877F1C0DEA;
        Thu, 29 Aug 2019 21:01:58 +0200 (CEST)
Date:   Thu, 29 Aug 2019 19:01:58 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Add PERF_RECORD_STAT_CONFIG 'struct
 stat_config_event' to perf/event.h
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190828135717.7245-16-jolsa@kernel.org>
References: <20190828135717.7245-16-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <156710531809.10586.8461661547952223478.tip-bot2@tip-bot2>
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

Commit-ID:     c5f416e6c69e333207666a1ddab0b41c6f12e588
Gitweb:        https://git.kernel.org/tip/c5f416e6c69e333207666a1ddab0b41c6f12e588
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Wed, 28 Aug 2019 15:57:09 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 29 Aug 2019 08:36:11 -03:00

libperf: Add PERF_RECORD_STAT_CONFIG 'struct stat_config_event' to perf/event.h

Move the PERF_RECORD_STAT_CONFIG event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-16-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 18 ++++++++++++++++++
 tools/perf/util/event.c             |  2 +-
 tools/perf/util/event.h             | 18 ------------------
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index fe0ce65..ba6ed24 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -264,4 +264,22 @@ struct thread_map_event {
 	struct thread_map_event_entry	 entries[];
 };
 
+enum {
+	PERF_STAT_CONFIG_TERM__AGGR_MODE	= 0,
+	PERF_STAT_CONFIG_TERM__INTERVAL		= 1,
+	PERF_STAT_CONFIG_TERM__SCALE		= 2,
+	PERF_STAT_CONFIG_TERM__MAX		= 3,
+};
+
+struct stat_config_event_entry {
+	__u64			 tag;
+	__u64			 val;
+};
+
+struct stat_config_event {
+	struct perf_event_header	 header;
+	__u64				 nr;
+	struct stat_config_event_entry	 data[];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index b048e60..b711019 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1235,7 +1235,7 @@ void perf_event__read_stat_config(struct perf_stat_config *config,
 		CASE(INTERVAL,  interval)
 #undef CASE
 		default:
-			pr_warning("unknown stat config term %" PRIu64 "\n",
+			pr_warning("unknown stat config term %" PRI_lu64 "\n",
 				   event->data[i].tag);
 		}
 	}
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 3a85669..68531d0 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -332,24 +332,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-enum {
-	PERF_STAT_CONFIG_TERM__AGGR_MODE	= 0,
-	PERF_STAT_CONFIG_TERM__INTERVAL		= 1,
-	PERF_STAT_CONFIG_TERM__SCALE		= 2,
-	PERF_STAT_CONFIG_TERM__MAX		= 3,
-};
-
-struct stat_config_event_entry {
-	u64	tag;
-	u64	val;
-};
-
-struct stat_config_event {
-	struct perf_event_header	header;
-	u64				nr;
-	struct stat_config_event_entry	data[];
-};
-
 struct stat_event {
 	struct perf_event_header	header;
 
