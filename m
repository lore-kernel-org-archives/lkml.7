Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D07C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC5224906
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfFDNCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:02:55 -0400
Received: from mga07.intel.com ([134.134.136.100]:5114 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbfFDNCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:02:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 06:02:08 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jun 2019 06:02:07 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/19] perf intel-pt: Add support for efficient time interval filtering
Date:   Tue,  4 Jun 2019 16:00:09 +0300
Message-Id: <20190604130017.31207-12-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604130017.31207-1-adrian.hunter@intel.com>
References: <20190604130017.31207-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set up time ranges for efficient time interval filtering using the new
"fast forward" facility.

Because decoding is done in time order, intel_pt_time_filter() needs to
look only at the next start or end timestamp - refer intel_pt_next_time().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 208 +++++++++++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 3e3a01318b76..43ddc78a066e 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -42,6 +42,7 @@
 #include "tsc.h"
 #include "intel-pt.h"
 #include "config.h"
+#include "time-utils.h"
 
 #include "intel-pt-decoder/intel-pt-log.h"
 #include "intel-pt-decoder/intel-pt-decoder.h"
@@ -50,6 +51,11 @@
 
 #define MAX_TIMESTAMP (~0ULL)
 
+struct range {
+	u64 start;
+	u64 end;
+};
+
 struct intel_pt {
 	struct auxtrace auxtrace;
 	struct auxtrace_queues queues;
@@ -118,6 +124,9 @@ struct intel_pt {
 
 	char *filter;
 	struct addr_filters filts;
+
+	struct range *time_ranges;
+	unsigned int range_cnt;
 };
 
 enum switch_state {
@@ -154,6 +163,9 @@ struct intel_pt_queue {
 	bool have_sample;
 	u64 time;
 	u64 timestamp;
+	u64 sel_timestamp;
+	bool sel_start;
+	unsigned int sel_idx;
 	u32 flags;
 	u16 insn_len;
 	u64 last_insn_cnt;
@@ -1007,6 +1019,23 @@ static void intel_pt_sample_flags(struct intel_pt_queue *ptq)
 		ptq->flags |= PERF_IP_FLAG_TRACE_END;
 }
 
+static void intel_pt_setup_time_range(struct intel_pt *pt,
+				      struct intel_pt_queue *ptq)
+{
+	if (!pt->range_cnt)
+		return;
+
+	ptq->sel_timestamp = pt->time_ranges[0].start;
+	ptq->sel_idx = 0;
+
+	if (ptq->sel_timestamp) {
+		ptq->sel_start = true;
+	} else {
+		ptq->sel_timestamp = pt->time_ranges[0].end;
+		ptq->sel_start = false;
+	}
+}
+
 static int intel_pt_setup_queue(struct intel_pt *pt,
 				struct auxtrace_queue *queue,
 				unsigned int queue_nr)
@@ -1031,6 +1060,8 @@ static int intel_pt_setup_queue(struct intel_pt *pt,
 			ptq->step_through_buffers = true;
 
 		ptq->sync_switch = pt->sync_switch;
+
+		intel_pt_setup_time_range(pt, ptq);
 	}
 
 	if (!ptq->on_heap &&
@@ -1045,6 +1076,14 @@ static int intel_pt_setup_queue(struct intel_pt *pt,
 		intel_pt_log("queue %u getting timestamp\n", queue_nr);
 		intel_pt_log("queue %u decoding cpu %d pid %d tid %d\n",
 			     queue_nr, ptq->cpu, ptq->pid, ptq->tid);
+
+		if (ptq->sel_start && ptq->sel_timestamp) {
+			ret = intel_pt_fast_forward(ptq->decoder,
+						    ptq->sel_timestamp);
+			if (ret)
+				return ret;
+		}
+
 		while (1) {
 			state = intel_pt_decode(ptq->decoder);
 			if (state->err) {
@@ -1064,6 +1103,9 @@ static int intel_pt_setup_queue(struct intel_pt *pt,
 			     queue_nr, ptq->timestamp);
 		ptq->state = state;
 		ptq->have_sample = true;
+		if (ptq->sel_start && ptq->sel_timestamp &&
+		    ptq->timestamp < ptq->sel_timestamp)
+			ptq->have_sample = false;
 		intel_pt_sample_flags(ptq);
 		ret = auxtrace_heap__add(&pt->heap, queue_nr, ptq->timestamp);
 		if (ret)
@@ -1750,10 +1792,83 @@ static void intel_pt_enable_sync_switch(struct intel_pt *pt)
 	}
 }
 
+/*
+ * To filter against time ranges, it is only necessary to look at the next start
+ * or end time.
+ */
+static bool intel_pt_next_time(struct intel_pt_queue *ptq)
+{
+	struct intel_pt *pt = ptq->pt;
+
+	if (ptq->sel_start) {
+		/* Next time is an end time */
+		ptq->sel_start = false;
+		ptq->sel_timestamp = pt->time_ranges[ptq->sel_idx].end;
+		return true;
+	} else if (ptq->sel_idx + 1 < pt->range_cnt) {
+		/* Next time is a start time */
+		ptq->sel_start = true;
+		ptq->sel_idx += 1;
+		ptq->sel_timestamp = pt->time_ranges[ptq->sel_idx].start;
+		return true;
+	}
+
+	/* No next time */
+	return false;
+}
+
+static int intel_pt_time_filter(struct intel_pt_queue *ptq, u64 *ff_timestamp)
+{
+	int err;
+
+	while (1) {
+		if (ptq->sel_start) {
+			if (ptq->timestamp >= ptq->sel_timestamp) {
+				/* After start time, so consider next time */
+				intel_pt_next_time(ptq);
+				if (!ptq->sel_timestamp) {
+					/* No end time */
+					return 0;
+				}
+				/* Check against end time */
+				continue;
+			}
+			/* Before start time, so fast forward */
+			ptq->have_sample = false;
+			if (ptq->sel_timestamp > *ff_timestamp) {
+				if (ptq->sync_switch) {
+					intel_pt_next_tid(ptq->pt, ptq);
+					ptq->switch_state = INTEL_PT_SS_UNKNOWN;
+				}
+				*ff_timestamp = ptq->sel_timestamp;
+				err = intel_pt_fast_forward(ptq->decoder,
+							    ptq->sel_timestamp);
+				if (err)
+					return err;
+			}
+			return 0;
+		} else if (ptq->timestamp > ptq->sel_timestamp) {
+			/* After end time, so consider next time */
+			if (!intel_pt_next_time(ptq)) {
+				/* No next time range, so stop decoding */
+				ptq->have_sample = false;
+				ptq->switch_state = INTEL_PT_SS_NOT_TRACING;
+				return 1;
+			}
+			/* Check against next start time */
+			continue;
+		} else {
+			/* Before end time */
+			return 0;
+		}
+	}
+}
+
 static int intel_pt_run_decoder(struct intel_pt_queue *ptq, u64 *timestamp)
 {
 	const struct intel_pt_state *state = ptq->state;
 	struct intel_pt *pt = ptq->pt;
+	u64 ff_timestamp = 0;
 	int err;
 
 	if (!pt->kernel_start) {
@@ -1818,6 +1933,12 @@ static int intel_pt_run_decoder(struct intel_pt_queue *ptq, u64 *timestamp)
 			ptq->timestamp = state->timestamp;
 		}
 
+		if (ptq->sel_timestamp) {
+			err = intel_pt_time_filter(ptq, &ff_timestamp);
+			if (err)
+				return err;
+		}
+
 		if (!pt->timeless_decoding && ptq->timestamp >= *timestamp) {
 			*timestamp = ptq->timestamp;
 			return 0;
@@ -2223,6 +2344,7 @@ static void intel_pt_free(struct perf_session *session)
 	thread__put(pt->unknown_thread);
 	addr_filters__exit(&pt->filts);
 	zfree(&pt->filter);
+	zfree(&pt->time_ranges);
 	free(pt);
 }
 
@@ -2520,6 +2642,85 @@ static int intel_pt_perf_config(const char *var, const char *value, void *data)
 	return 0;
 }
 
+/* Find least TSC which converts to ns or later */
+static u64 intel_pt_tsc_start(u64 ns, struct intel_pt *pt)
+{
+	u64 tsc, tm;
+
+	tsc = perf_time_to_tsc(ns, &pt->tc);
+
+	while (1) {
+		tm = tsc_to_perf_time(tsc, &pt->tc);
+		if (tm < ns)
+			break;
+		tsc -= 1;
+	}
+
+	while (tm < ns)
+		tm = tsc_to_perf_time(++tsc, &pt->tc);
+
+	return tsc;
+}
+
+/* Find greatest TSC which converts to ns or earlier */
+static u64 intel_pt_tsc_end(u64 ns, struct intel_pt *pt)
+{
+	u64 tsc, tm;
+
+	tsc = perf_time_to_tsc(ns, &pt->tc);
+
+	while (1) {
+		tm = tsc_to_perf_time(tsc, &pt->tc);
+		if (tm > ns)
+			break;
+		tsc += 1;
+	}
+
+	while (tm > ns)
+		tm = tsc_to_perf_time(--tsc, &pt->tc);
+
+	return tsc;
+}
+
+static int intel_pt_setup_time_ranges(struct intel_pt *pt,
+				      struct itrace_synth_opts *opts)
+{
+	struct perf_time_interval *p = opts->ptime_range;
+	int n = opts->range_num;
+	int i;
+
+	if (!n || !p || pt->timeless_decoding)
+		return 0;
+
+	pt->time_ranges = calloc(n, sizeof(struct range));
+	if (!pt->time_ranges)
+		return -ENOMEM;
+
+	pt->range_cnt = n;
+
+	intel_pt_log("%s: %u range(s)\n", __func__, n);
+
+	for (i = 0; i < n; i++) {
+		struct range *r = &pt->time_ranges[i];
+		u64 ts = p[i].start;
+		u64 te = p[i].end;
+
+		/*
+		 * Take care to ensure the TSC range matches the perf-time range
+		 * when converted back to perf-time.
+		 */
+		r->start = ts ? intel_pt_tsc_start(ts, pt) : 0;
+		r->end   = te ? intel_pt_tsc_end(te, pt) : 0;
+
+		intel_pt_log("range %d: perf time interval: %"PRIu64" to %"PRIu64"\n",
+			     i, ts, te);
+		intel_pt_log("range %d: TSC time interval: %#"PRIx64" to %#"PRIx64"\n",
+			     i, r->start, r->end);
+	}
+
+	return 0;
+}
+
 static const char * const intel_pt_info_fmts[] = {
 	[INTEL_PT_PMU_TYPE]		= "  PMU Type            %"PRId64"\n",
 	[INTEL_PT_TIME_SHIFT]		= "  Time Shift          %"PRIu64"\n",
@@ -2752,6 +2953,12 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 		pt->cbr2khz = tsc_freq / pt->max_non_turbo_ratio / 1000;
 	}
 
+	if (session->itrace_synth_opts) {
+		err = intel_pt_setup_time_ranges(pt, session->itrace_synth_opts);
+		if (err)
+			goto err_delete_thread;
+	}
+
 	if (pt->synth_opts.calls)
 		pt->branches_filter |= PERF_IP_FLAG_CALL | PERF_IP_FLAG_ASYNC |
 				       PERF_IP_FLAG_TRACE_END;
@@ -2792,6 +2999,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 err_free:
 	addr_filters__exit(&pt->filts);
 	zfree(&pt->filter);
+	zfree(&pt->time_ranges);
 	free(pt);
 	return err;
 }
-- 
2.17.1

