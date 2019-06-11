Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4817DC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0374D21851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279599;
	bh=8BcGPmjRK1qT9x5M46OT7K7VW7YaLg2U0ZumruxYxgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0KoG9EUKBV20d73nnoInuqP7+Y25rR1iGy3bcmoTzta4SZjDvfst7NgeyzaJgxbrT
	 U9JDY7o3wQiCMq3wfPIzarynDFiWk+ftmMSjY8phX6KFyVnJu+kaFDrkl33NH2cSj5
	 SsxS7yhtUWCEReSn4DmyS4+dNoI2MdxDvdOkgHHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407123AbfFKS76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:59:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404869AbfFKS75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:59:57 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9D4021841;
        Tue, 11 Jun 2019 18:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279596;
        bh=8BcGPmjRK1qT9x5M46OT7K7VW7YaLg2U0ZumruxYxgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VEiZgaaM2tqmGzhT4kGsZJ1mveIHCVT9oSoVjTnu8Pvp2EGTlJPJyv3wFycd9aRGM
         QSKLv9ZfIoQh9e4wEsScPRs5Ofu2so6xC4GrXZJ4vs/pAz/hirBGF7XdE9weTT1M+A
         6AyUtiJ2ARzSS8JHtkbacZcASTVs5Ie23AWXOA94=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/85] perf intel-pt: Add support for samples to contain IPC ratio
Date:   Tue, 11 Jun 2019 15:57:56 -0300
Message-Id: <20190611185911.11645-11-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Copy the incremental instruction count and cycle count onto 'instructions'
and 'branches' samples.

Because Intel PT does not update the cycle count on every branch or
instruction, the incremental values will often be zero.

When there are values, they will be the number of instructions and
number of cycles since the last update, and thus represent the average
IPC since the last IPC value.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-8-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.20.1

