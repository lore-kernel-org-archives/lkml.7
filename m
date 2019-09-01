Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C562C3A5A7
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7542377B
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340703;
	bh=sHeklLgdUaAjyilM6crJSN0ARu/dEpWw7wexp4qSt0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XOIZH5P4zDLnvZgHs+6viSRR1emRBNC1eBA5LDFapEn9gOBoszZJwf3bm7T3rsTCq
	 a+CpYajsCLmjuuFWi6dtY7wf9+gana60o/zgZJ74ou6qvZ+QmCW7G1pwF4DBXSTct1
	 ruraqi//8um9WVqFHJ3U4vPC6kWBPjTdSfvBmphc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfIAMZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:25:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:42222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729170AbfIAMY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:24:59 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60A5123697;
        Sun,  1 Sep 2019 12:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340698;
        bh=sHeklLgdUaAjyilM6crJSN0ARu/dEpWw7wexp4qSt0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ichTDzUsCI4Y29SZ1hLqoHrF/Z+g6P7S9zhDjwgmcoTyTJKBIF+ro3gEi8KY6Z6Eq
         /VLdEeu6KirLowVGhbsYXdaJ9a0hKNAPGwNiq9NNjf9xJ7PsycOzSrX1ZlRSfc9lse
         v9bUUw/TOoE+BEkt+4UR5Zt+ZfdLM5nu3tXXCP74=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 28/47] perf tools: Move 'struct events_stats' and prototypes to separate header
Date:   Sun,  1 Sep 2019 09:23:07 -0300
Message-Id: <20190901122326.5793-29-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This will allow us to untangle the header dependency a bit more, as some
places will not need event.h anymore.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-enqncj29ovzaat3cd9203rwl@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.h     |  5 ++++
 tools/perf/util/event.h        | 42 ----------------------------
 tools/perf/util/events_stats.h | 51 ++++++++++++++++++++++++++++++++++
 tools/perf/util/evlist.h       |  2 +-
 tools/perf/util/hist.h         |  4 +--
 tools/perf/util/sort.h         |  1 -
 6 files changed, 58 insertions(+), 47 deletions(-)
 create mode 100644 tools/perf/util/events_stats.h

diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index b5ac24c770d4..c539e7b6ed56 100644
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
index 006aa432be19..47ad81d47b1a 100644
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
index 000000000000..859cb34fcff2
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
index ee288644e9e4..a55f0f2546e5 100644
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
index 1c0a635e5e32..34803e33dc80 100644
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
index 3d7cef73924c..7b93f34ac1f4 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -9,7 +9,6 @@
 #include "symbol_conf.h"
 #include "callchain.h"
 #include "values.h"
-
 #include "hist.h"
 
 struct option;
-- 
2.21.0

