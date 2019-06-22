Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B39C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 09:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D203F2089C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 09:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfFVJeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 05:34:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:26120 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbfFVJeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 05:34:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2019 02:34:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,404,1557212400"; 
   d="scan'208";a="312233159"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by orsmga004.jf.intel.com with ESMTP; 22 Jun 2019 02:34:13 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] perf intel-pt: Synthesize CBR events when last seen value changes
Date:   Sat, 22 Jun 2019 12:32:45 +0300
Message-Id: <20190622093248.581-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190622093248.581-1-adrian.hunter@intel.com>
References: <20190622093248.581-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first core-to-bus ratio (CBR) event will not be shown if --itrace 's'
option (skip initial number of events) is used, nor if time intervals are
specified that do not include the start of tracing. Change the logic to
record the last CBR value seen by the user, and synthesize CBR events
whenever that changes.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 65 ++++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 550db6e77968..470aaae9d930 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -171,6 +171,7 @@ struct intel_pt_queue {
 	u64 last_in_cyc_cnt;
 	u64 last_br_insn_cnt;
 	u64 last_br_cyc_cnt;
+	unsigned int cbr_seen;
 	char insn[INTEL_PT_INSN_BUF_SZ];
 };
 
@@ -1052,6 +1053,8 @@ static int intel_pt_setup_queue(struct intel_pt *pt,
 			ptq->cpu = queue->cpu;
 		ptq->tid = queue->tid;
 
+		ptq->cbr_seen = UINT_MAX;
+
 		if (pt->sampling_mode && !pt->snapshot_mode &&
 		    pt->timeless_decoding)
 			ptq->step_through_buffers = true;
@@ -1184,6 +1187,17 @@ static inline bool intel_pt_skip_event(struct intel_pt *pt)
 	       pt->num_events++ < pt->synth_opts.initial_skip;
 }
 
+/*
+ * Cannot count CBR as skipped because it won't go away until cbr == cbr_seen.
+ * Also ensure CBR is first non-skipped event by allowing for 4 more samples
+ * from this decoder state.
+ */
+static inline bool intel_pt_skip_cbr_event(struct intel_pt *pt)
+{
+	return pt->synth_opts.initial_skip &&
+	       pt->num_events + 4 < pt->synth_opts.initial_skip;
+}
+
 static void intel_pt_prep_a_sample(struct intel_pt_queue *ptq,
 				   union perf_event *event,
 				   struct perf_sample *sample)
@@ -1429,9 +1443,11 @@ static int intel_pt_synth_cbr_sample(struct intel_pt_queue *ptq)
 	struct perf_synth_intel_cbr raw;
 	u32 flags;
 
-	if (intel_pt_skip_event(pt))
+	if (intel_pt_skip_cbr_event(pt))
 		return 0;
 
+	ptq->cbr_seen = ptq->state->cbr;
+
 	intel_pt_prep_p_sample(pt, ptq, event, &sample);
 
 	sample.id = ptq->pt->cbr_id;
@@ -1868,8 +1884,7 @@ static inline bool intel_pt_is_switch_ip(struct intel_pt_queue *ptq, u64 ip)
 }
 
 #define INTEL_PT_PWR_EVT (INTEL_PT_MWAIT_OP | INTEL_PT_PWR_ENTRY | \
-			  INTEL_PT_EX_STOP | INTEL_PT_PWR_EXIT | \
-			  INTEL_PT_CBR_CHG)
+			  INTEL_PT_EX_STOP | INTEL_PT_PWR_EXIT)
 
 static int intel_pt_sample(struct intel_pt_queue *ptq)
 {
@@ -1901,31 +1916,33 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 			return err;
 	}
 
-	if (pt->sample_pwr_events && (state->type & INTEL_PT_PWR_EVT)) {
-		if (state->type & INTEL_PT_CBR_CHG) {
+	if (pt->sample_pwr_events) {
+		if (ptq->state->cbr != ptq->cbr_seen) {
 			err = intel_pt_synth_cbr_sample(ptq);
 			if (err)
 				return err;
 		}
-		if (state->type & INTEL_PT_MWAIT_OP) {
-			err = intel_pt_synth_mwait_sample(ptq);
-			if (err)
-				return err;
-		}
-		if (state->type & INTEL_PT_PWR_ENTRY) {
-			err = intel_pt_synth_pwre_sample(ptq);
-			if (err)
-				return err;
-		}
-		if (state->type & INTEL_PT_EX_STOP) {
-			err = intel_pt_synth_exstop_sample(ptq);
-			if (err)
-				return err;
-		}
-		if (state->type & INTEL_PT_PWR_EXIT) {
-			err = intel_pt_synth_pwrx_sample(ptq);
-			if (err)
-				return err;
+		if (state->type & INTEL_PT_PWR_EVT) {
+			if (state->type & INTEL_PT_MWAIT_OP) {
+				err = intel_pt_synth_mwait_sample(ptq);
+				if (err)
+					return err;
+			}
+			if (state->type & INTEL_PT_PWR_ENTRY) {
+				err = intel_pt_synth_pwre_sample(ptq);
+				if (err)
+					return err;
+			}
+			if (state->type & INTEL_PT_EX_STOP) {
+				err = intel_pt_synth_exstop_sample(ptq);
+				if (err)
+					return err;
+			}
+			if (state->type & INTEL_PT_PWR_EXIT) {
+				err = intel_pt_synth_pwrx_sample(ptq);
+				if (err)
+					return err;
+			}
 		}
 	}
 
-- 
2.17.1

