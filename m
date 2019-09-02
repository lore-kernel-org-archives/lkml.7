Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5A2C3A5A7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336F4215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730554AbfIBISy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:18:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56251 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730223AbfIBIQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:16:45 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hVw-00088C-AJ; Mon, 02 Sep 2019 10:16:40 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B63AE1C0DE7;
        Mon,  2 Sep 2019 10:16:35 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:35 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tools: Move 'struct events_stats' and
 prototypes to separate header
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-enqncj29ovzaat3cd9203rwl@git.kernel.org>
References: <tip-enqncj29ovzaat3cd9203rwl@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156741219554.17348.3161473190917894663.tip-bot2@tip-bot2>
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

Commit-ID:     4772925885dac93aa5f00d1c1da93277778099cd
Gitweb:        https://git.kernel.org/tip/4772925885dac93aa5f00d1c1da93277778099cd
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 30 Aug 2019 11:44:32 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 31 Aug 2019 22:24:10 -03:00

perf tools: Move 'struct events_stats' and prototypes to separate header

This will allow us to untangle the header dependency a bit more, as some
places will not need event.h anymore.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-enqncj29ovzaat3cd9203rwl@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.h     |  5 +++-
 tools/perf/util/event.h        | 42 +---------------------------
 tools/perf/util/events_stats.h | 51 +++++++++++++++++++++++++++++++++-
 tools/perf/util/evlist.h       |  2 +-
 tools/perf/util/hist.h         |  4 +---
 tools/perf/util/sort.h         |  1 +-
 6 files changed, 58 insertions(+), 47 deletions(-)
 create mode 100644 tools/perf/util/events_stats.h

diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index b5ac24c..c539e7b 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -30,6 +30,11 @@ struct record_opts;
 struct perf_record_auxtrace_info;
 struct events_stats;
 
+enum auxtrace_error_type {
+       PERF_AUXTRACE_ERROR_ITRACE  = 1,
+       PERF_AUXTRACE_ERROR_MAX
+};
+
 /* Auxtrace records must have the same alignment as perf event records */
 #define PERF_AUXTRACE_RECORD_ALIGNMENT 8
 
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 006aa43..47ad81d 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -151,11 +151,6 @@ struct perf_sample {
 	 PERF_MEM_S(LOCK, NA) |\
 	 PERF_MEM_S(TLB, NA))
 
-enum auxtrace_error_type {
-	PERF_AUXTRACE_ERROR_ITRACE  = 1,
-	PERF_AUXTRACE_ERROR_MAX
-};
-
 /* Attribute type for custom synthesized events */
 #define PERF_TYPE_SYNTH		(INT_MAX + 1U)
 
@@ -277,43 +272,6 @@ static inline void *perf_synth__raw_data(void *p)
 
 #define perf_sample__bad_synth_size(s, d) ((s)->raw_size < sizeof(d) - 4)
 
-/*
- * The kernel collects the number of events it couldn't send in a stretch and
- * when possible sends this number in a PERF_RECORD_LOST event. The number of
- * such "chunks" of lost events is stored in .nr_events[PERF_EVENT_LOST] while
- * total_lost tells exactly how many events the kernel in fact lost, i.e. it is
- * the sum of all struct perf_record_lost.lost fields reported.
- *
- * The kernel discards mixed up samples and sends the number in a
- * PERF_RECORD_LOST_SAMPLES event. The number of lost-samples events is stored
- * in .nr_events[PERF_RECORD_LOST_SAMPLES] while total_lost_samples tells
- * exactly how many samples the kernel in fact dropped, i.e. it is the sum of
- * all struct perf_record_lost_samples.lost fields reported.
- *
- * The total_period is needed because by default auto-freq is used, so
- * multipling nr_events[PERF_EVENT_SAMPLE] by a frequency isn't possible to get
- * the total number of low level events, it is necessary to to sum all struct
- * perf_record_sample.period and stash the result in total_period.
- */
-struct events_stats {
-	u64 total_period;
-	u64 total_non_filtered_period;
-	u64 total_lost;
-	u64 total_lost_samples;
-	u64 total_aux_lost;
-	u64 total_aux_partial;
-	u64 total_invalid_chains;
-	u32 nr_events[PERF_RECORD_HEADER_MAX];
-	u32 nr_non_filtered_samples;
-	u32 nr_lost_warned;
-	u32 nr_unknown_events;
-	u32 nr_invalid_chains;
-	u32 nr_unknown_id;
-	u32 nr_unprocessable_samples;
-	u32 nr_auxtrace_errors[PERF_AUXTRACE_ERROR_MAX];
-	u32 nr_proc_map_timeout;
-};
-
 enum {
 	PERF_STAT_ROUND_TYPE__INTERVAL	= 0,
 	PERF_STAT_ROUND_TYPE__FINAL	= 1,
diff --git a/tools/perf/util/events_stats.h b/tools/perf/util/events_stats.h
new file mode 100644
index 0000000..859cb34
--- /dev/null
+++ b/tools/perf/util/events_stats.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_EVENTS_STATS_
+#define __PERF_EVENTS_STATS_
+
+#include <stdio.h>
+#include <perf/event.h>
+#include <linux/types.h>
+#include "auxtrace.h"
+
+/*
+ * The kernel collects the number of events it couldn't send in a stretch and
+ * when possible sends this number in a PERF_RECORD_LOST event. The number of
+ * such "chunks" of lost events is stored in .nr_events[PERF_EVENT_LOST] while
+ * total_lost tells exactly how many events the kernel in fact lost, i.e. it is
+ * the sum of all struct perf_record_lost.lost fields reported.
+ *
+ * The kernel discards mixed up samples and sends the number in a
+ * PERF_RECORD_LOST_SAMPLES event. The number of lost-samples events is stored
+ * in .nr_events[PERF_RECORD_LOST_SAMPLES] while total_lost_samples tells
+ * exactly how many samples the kernel in fact dropped, i.e. it is the sum of
+ * all struct perf_record_lost_samples.lost fields reported.
+ *
+ * The total_period is needed because by default auto-freq is used, so
+ * multipling nr_events[PERF_EVENT_SAMPLE] by a frequency isn't possible to get
+ * the total number of low level events, it is necessary to to sum all struct
+ * perf_record_sample.period and stash the result in total_period.
+ */
+struct events_stats {
+	u64 total_period;
+	u64 total_non_filtered_period;
+	u64 total_lost;
+	u64 total_lost_samples;
+	u64 total_aux_lost;
+	u64 total_aux_partial;
+	u64 total_invalid_chains;
+	u32 nr_events[PERF_RECORD_HEADER_MAX];
+	u32 nr_non_filtered_samples;
+	u32 nr_lost_warned;
+	u32 nr_unknown_events;
+	u32 nr_invalid_chains;
+	u32 nr_unknown_id;
+	u32 nr_unprocessable_samples;
+	u32 nr_auxtrace_errors[PERF_AUXTRACE_ERROR_MAX];
+	u32 nr_proc_map_timeout;
+};
+
+void events_stats__inc(struct events_stats *stats, u32 type);
+
+size_t events_stats__fprintf(struct events_stats *stats, FILE *fp);
+
+#endif /* __PERF_EVENTS_STATS_ */
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index ee28864..a55f0f2 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -9,7 +9,7 @@
 #include <api/fd/array.h>
 #include <stdio.h>
 #include <internal/evlist.h>
-#include "event.h"
+#include "events_stats.h"
 #include "evsel.h"
 #include "mmap.h"
 #include <signal.h>
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 1c0a635..34803e3 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -6,8 +6,8 @@
 #include <linux/types.h>
 #include <pthread.h>
 #include "evsel.h"
-#include "header.h"
 #include "color.h"
+#include "events_stats.h"
 
 struct hist_entry;
 struct hist_entry_ops;
@@ -190,8 +190,6 @@ void hists__reset_stats(struct hists *hists);
 void hists__inc_stats(struct hists *hists, struct hist_entry *h);
 void hists__inc_nr_events(struct hists *hists, u32 type);
 void hists__inc_nr_samples(struct hists *hists, bool filtered);
-void events_stats__inc(struct events_stats *stats, u32 type);
-size_t events_stats__fprintf(struct events_stats *stats, FILE *fp);
 
 size_t hists__fprintf(struct hists *hists, bool show_header, int max_rows,
 		      int max_cols, float min_pcnt, FILE *fp,
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 3d7cef7..7b93f34 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -9,7 +9,6 @@
 #include "symbol_conf.h"
 #include "callchain.h"
 #include "values.h"
-
 #include "hist.h"
 
 struct option;
