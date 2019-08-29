Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC63C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D892166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfH2TEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:04:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51409 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbfH2TCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:02:02 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i3Pg8-00056a-Dk; Thu, 29 Aug 2019 21:01:52 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E86731C07C3;
        Thu, 29 Aug 2019 21:01:51 +0200 (CEST)
Date:   Thu, 29 Aug 2019 19:01:51 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Add PERF_RECORD_CPU_MAP 'struct
 cpu_map_event' to perf/event.h
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190828135717.7245-3-jolsa@kernel.org>
References: <20190828135717.7245-3-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <156710531183.10544.16289306458936777545.tip-bot2@tip-bot2>
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

Commit-ID:     78e5ea1620964c4e34e9bf43e98a3def77e6bcde
Gitweb:        https://git.kernel.org/tip/78e5ea1620964c4e34e9bf43e98a3def77e6bcde
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Wed, 28 Aug 2019 15:56:56 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 28 Aug 2019 18:15:04 -03:00

libperf: Add PERF_RECORD_CPU_MAP 'struct cpu_map_event' to perf/event.h

Move the PERF_RECORD_CPU_MAP event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 26 ++++++++++++++++++++++++++
 tools/perf/util/event.h             | 26 --------------------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index bb66da5..469be77 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -115,4 +115,30 @@ struct attr_event {
 	__u64			 id[];
 };
 
+enum {
+	PERF_CPU_MAP__CPUS = 0,
+	PERF_CPU_MAP__MASK = 1,
+};
+
+struct cpu_map_entries {
+	__u16			 nr;
+	__u16			 cpu[];
+};
+
+struct cpu_map_mask {
+	__u16			 nr;
+	__u16			 long_size;
+	unsigned long		 mask[];
+};
+
+struct cpu_map_data {
+	__u16			 type;
+	char			 data[];
+};
+
+struct cpu_map_event {
+	struct perf_event_header header;
+	struct cpu_map_data	 data;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 21fa6c2..84bf673 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -338,32 +338,6 @@ struct events_stats {
 };
 
 enum {
-	PERF_CPU_MAP__CPUS = 0,
-	PERF_CPU_MAP__MASK = 1,
-};
-
-struct cpu_map_entries {
-	u16	nr;
-	u16	cpu[];
-};
-
-struct cpu_map_mask {
-	u16	nr;
-	u16	long_size;
-	unsigned long mask[];
-};
-
-struct cpu_map_data {
-	u16	type;
-	char	data[];
-};
-
-struct cpu_map_event {
-	struct perf_event_header	header;
-	struct cpu_map_data		data;
-};
-
-enum {
 	PERF_EVENT_UPDATE__UNIT  = 0,
 	PERF_EVENT_UPDATE__SCALE = 1,
 	PERF_EVENT_UPDATE__NAME  = 2,
