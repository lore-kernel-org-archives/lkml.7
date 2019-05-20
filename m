Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB7EC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3774F20645
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733093AbfETLhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:37:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:48121 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733075AbfETLhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:37:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 04:37:52 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga004.fm.intel.com with ESMTP; 20 May 2019 04:37:50 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 07/22] perf intel-pt: Add support for samples to contain IPC ratio
Date:   Mon, 20 May 2019 14:37:13 +0300
Message-Id: <20190520113728.14389-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190520113728.14389-1-adrian.hunter@intel.com>
References: <20190520113728.14389-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copy the incremental instruction count and cycle count onto 'instructions'
and 'branches' samples. Because Intel PT does not update the cycle count on
every branch or instruction, the incremental values will often be zero.
When there are values, they will be the number of instructions and number
of cycles since the last update, and thus represent the average IPC since
the last IPC value.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 7a70693c1b91..3cff8fe2eaa0 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -157,6 +157,12 @@ struct intel_pt_queue {
 	u32 flags;
 	u16 insn_len;
 	u64 last_insn_cnt;
+	u64 ipc_insn_cnt;
+	u64 ipc_cyc_cnt;
+	u64 last_in_insn_cnt;
+	u64 last_in_cyc_cnt;
+	u64 last_br_insn_cnt;
+	u64 last_br_cyc_cnt;
 	char insn[INTEL_PT_INSN_BUF_SZ];
 };
 
@@ -1162,6 +1168,13 @@ static int intel_pt_synth_branch_sample(struct intel_pt_queue *ptq)
 		sample.branch_stack = (struct branch_stack *)&dummy_bs;
 	}
 
+	sample.cyc_cnt = ptq->ipc_cyc_cnt - ptq->last_br_cyc_cnt;
+	if (sample.cyc_cnt) {
+		sample.insn_cnt = ptq->ipc_insn_cnt - ptq->last_br_insn_cnt;
+		ptq->last_br_insn_cnt = ptq->ipc_insn_cnt;
+		ptq->last_br_cyc_cnt = ptq->ipc_cyc_cnt;
+	}
+
 	return intel_pt_deliver_synth_b_event(pt, event, &sample,
 					      pt->branches_sample_type);
 }
@@ -1217,6 +1230,13 @@ static int intel_pt_synth_instruction_sample(struct intel_pt_queue *ptq)
 	sample.stream_id = ptq->pt->instructions_id;
 	sample.period = ptq->state->tot_insn_cnt - ptq->last_insn_cnt;
 
+	sample.cyc_cnt = ptq->ipc_cyc_cnt - ptq->last_in_cyc_cnt;
+	if (sample.cyc_cnt) {
+		sample.insn_cnt = ptq->ipc_insn_cnt - ptq->last_in_insn_cnt;
+		ptq->last_in_insn_cnt = ptq->ipc_insn_cnt;
+		ptq->last_in_cyc_cnt = ptq->ipc_cyc_cnt;
+	}
+
 	ptq->last_insn_cnt = ptq->state->tot_insn_cnt;
 
 	return intel_pt_deliver_synth_event(pt, ptq, event, &sample,
@@ -1488,6 +1508,15 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 
 	ptq->have_sample = false;
 
+	if (ptq->state->tot_cyc_cnt > ptq->ipc_cyc_cnt) {
+		/*
+		 * Cycle count and instruction count only go together to create
+		 * a valid IPC ratio when the cycle count changes.
+		 */
+		ptq->ipc_insn_cnt = ptq->state->tot_insn_cnt;
+		ptq->ipc_cyc_cnt = ptq->state->tot_cyc_cnt;
+	}
+
 	if (pt->sample_pwr_events && (state->type & INTEL_PT_PWR_EVT)) {
 		if (state->type & INTEL_PT_CBR_CHG) {
 			err = intel_pt_synth_cbr_sample(ptq);
-- 
2.17.1

