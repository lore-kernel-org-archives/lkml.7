Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58926C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F1922CEA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfH2TCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:02:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51555 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbfH2TCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:02:16 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i3PgO-0005EW-2X; Thu, 29 Aug 2019 21:02:08 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D04B81C0DEB;
        Thu, 29 Aug 2019 21:01:59 +0200 (CEST)
Date:   Thu, 29 Aug 2019 19:01:59 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Add PERF_RECORD_TIME_CONV 'struct
 time_conv_event' to perf/event.h
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190828135717.7245-19-jolsa@kernel.org>
References: <20190828135717.7245-19-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <156710531977.10595.9991241484739982312.tip-bot2@tip-bot2>
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

Commit-ID:     bfd922d8f09a692f2a952a67451bc3eeaad3fb73
Gitweb:        https://git.kernel.org/tip/bfd922d8f09a692f2a952a67451bc3eeaad3fb73
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Wed, 28 Aug 2019 15:57:12 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 29 Aug 2019 08:36:12 -03:00

libperf: Add PERF_RECORD_TIME_CONV 'struct time_conv_event' to perf/event.h

Move the PERF_RECORD_TIME_CONV event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-19-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 7 +++++++
 tools/perf/util/event.h             | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 34d365b..7600f53 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -305,4 +305,11 @@ struct stat_round_event {
 	__u64			 time;
 };
 
+struct time_conv_event {
+	struct perf_event_header header;
+	__u64			 time_shift;
+	__u64			 time_mult;
+	__u64			 time_zero;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index ec76412..d758485 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -337,13 +337,6 @@ enum {
 	PERF_STAT_ROUND_TYPE__FINAL	= 1,
 };
 
-struct time_conv_event {
-	struct perf_event_header header;
-	u64 time_shift;
-	u64 time_mult;
-	u64 time_zero;
-};
-
 struct feature_event {
 	struct perf_event_header 	header;
 	u64				feat_id;
