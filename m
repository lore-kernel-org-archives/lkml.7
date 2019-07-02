Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8024C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FEA92189E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562034415;
	bh=PE8xycleilBXEVW8iaQnH75ZrA9Gd71bqqTuqwGszYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uOVaPvceDRB6L3Eg3mOLMVXNkuxvEvIjTNThGJ+s/e5Yi+f0TAjarBU/s1ozEWxR4
	 OQ6M6ZfG1o8hWV/bSBSzidoCtNK+PIrw6oIZumo92Ts3BJ6Tbc2pKinWC6T4xCu1io
	 UM54Zrvcp7ke2zOgPnLF3P1M5Exshk/XcPSsa8Yk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfGBC0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:26:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727194AbfGBC0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:26:50 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C342321841;
        Tue,  2 Jul 2019 02:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034409;
        bh=PE8xycleilBXEVW8iaQnH75ZrA9Gd71bqqTuqwGszYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1UuBJh0nPoFFx9Z1QvmnX//O8wr1p+sql8ZkVzzHn/NP8ZzKLU7EBWEhJ4daRhHMS
         T584he4qfhZm7SVEvOy8I5Yji/UvKXvT0gq/AcRFQethg6nBMv0d7PMHwNL4FJFiDr
         7y/hpYbSPAflw72SGxgFr7Iv32CZN7eXWhBDD8i4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 08/43] perf intel-pt: Synthesize CBR events when last seen value changes
Date:   Mon,  1 Jul 2019 23:25:41 -0300
Message-Id: <20190702022616.1259-9-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

The first core-to-bus ratio (CBR) event will not be shown if --itrace
's' option (skip initial number of events) is used, nor if time
intervals are specified that do not include the start of tracing. Change
the logic to record the last CBR value seen by the user, and synthesize
CBR events whenever that changes.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190622093248.581-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.20.1

