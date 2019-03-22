Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F3FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7930021900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfCVQjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:39:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:60735 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbfCVQjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:39:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 09:39:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="144356586"
Received: from otc-icl-cdi187.jf.intel.com ([10.54.55.103])
  by orsmga002.jf.intel.com with ESMTP; 22 Mar 2019 09:39:31 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 02/23] perf/x86/intel: Extract memory code PEBS parser for reuse
Date:   Fri, 22 Mar 2019 09:36:57 -0700
Message-Id: <20190322163718.2191-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190322163718.2191-1-kan.liang@linux.intel.com>
References: <20190322163718.2191-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Extract some code related to memory profiling from the PEBS record
parser into separate functions. It can be reused by the upcoming
adaptive PEBS parser. No functional changes.
Rename intel_hsw_weight to intel_get_tsx_weight, and
intel_hsw_transaction to intel_get_tsx_transaction. Because the input is
not the hsw pebs format anymore.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V2.

 arch/x86/events/intel/ds.c | 63 ++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 10c99ce1fead..c02cd19fe640 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1125,34 +1125,50 @@ static int intel_pmu_pebs_fixup_ip(struct pt_regs *regs)
 	return 0;
 }
 
-static inline u64 intel_hsw_weight(struct pebs_record_skl *pebs)
+static inline u64 intel_get_tsx_weight(u64 tsx_tuning)
 {
-	if (pebs->tsx_tuning) {
-		union hsw_tsx_tuning tsx = { .value = pebs->tsx_tuning };
+	if (tsx_tuning) {
+		union hsw_tsx_tuning tsx = { .value = tsx_tuning };
 		return tsx.cycles_last_block;
 	}
 	return 0;
 }
 
-static inline u64 intel_hsw_transaction(struct pebs_record_skl *pebs)
+static inline u64 intel_get_tsx_transaction(u64 tsx_tuning, u64 ax)
 {
-	u64 txn = (pebs->tsx_tuning & PEBS_HSW_TSX_FLAGS) >> 32;
+	u64 txn = (tsx_tuning & PEBS_HSW_TSX_FLAGS) >> 32;
 
 	/* For RTM XABORTs also log the abort code from AX */
-	if ((txn & PERF_TXN_TRANSACTION) && (pebs->ax & 1))
-		txn |= ((pebs->ax >> 24) & 0xff) << PERF_TXN_ABORT_SHIFT;
+	if ((txn & PERF_TXN_TRANSACTION) && (ax & 1))
+		txn |= ((ax >> 24) & 0xff) << PERF_TXN_ABORT_SHIFT;
 	return txn;
 }
 
+#define PERF_X86_EVENT_PEBS_HSW_PREC \
+		(PERF_X86_EVENT_PEBS_ST_HSW | \
+		 PERF_X86_EVENT_PEBS_LD_HSW | \
+		 PERF_X86_EVENT_PEBS_NA_HSW)
+
+static u64 get_data_src(struct perf_event *event, u64 aux)
+{
+	u64 val = PERF_MEM_NA;
+	int fl = event->hw.flags;
+	bool fst = fl & (PERF_X86_EVENT_PEBS_ST | PERF_X86_EVENT_PEBS_HSW_PREC);
+
+	if (fl & PERF_X86_EVENT_PEBS_LDLAT)
+		val = load_latency_data(aux);
+	else if (fst && (fl & PERF_X86_EVENT_PEBS_HSW_PREC))
+		val = precise_datala_hsw(event, aux);
+	else if (fst)
+		val = precise_store_data(aux);
+	return val;
+}
+
 static void setup_pebs_sample_data(struct perf_event *event,
 				   struct pt_regs *iregs, void *__pebs,
 				   struct perf_sample_data *data,
 				   struct pt_regs *regs)
 {
-#define PERF_X86_EVENT_PEBS_HSW_PREC \
-		(PERF_X86_EVENT_PEBS_ST_HSW | \
-		 PERF_X86_EVENT_PEBS_LD_HSW | \
-		 PERF_X86_EVENT_PEBS_NA_HSW)
 	/*
 	 * We cast to the biggest pebs_record but are careful not to
 	 * unconditionally access the 'extra' entries.
@@ -1160,17 +1176,13 @@ static void setup_pebs_sample_data(struct perf_event *event,
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct pebs_record_skl *pebs = __pebs;
 	u64 sample_type;
-	int fll, fst, dsrc;
-	int fl = event->hw.flags;
+	int fll;
 
 	if (pebs == NULL)
 		return;
 
 	sample_type = event->attr.sample_type;
-	dsrc = sample_type & PERF_SAMPLE_DATA_SRC;
-
-	fll = fl & PERF_X86_EVENT_PEBS_LDLAT;
-	fst = fl & (PERF_X86_EVENT_PEBS_ST | PERF_X86_EVENT_PEBS_HSW_PREC);
+	fll = event->hw.flags & PERF_X86_EVENT_PEBS_LDLAT;
 
 	perf_sample_data_init(data, 0, event->hw.last_period);
 
@@ -1185,16 +1197,8 @@ static void setup_pebs_sample_data(struct perf_event *event,
 	/*
 	 * data.data_src encodes the data source
 	 */
-	if (dsrc) {
-		u64 val = PERF_MEM_NA;
-		if (fll)
-			val = load_latency_data(pebs->dse);
-		else if (fst && (fl & PERF_X86_EVENT_PEBS_HSW_PREC))
-			val = precise_datala_hsw(event, pebs->dse);
-		else if (fst)
-			val = precise_store_data(pebs->dse);
-		data->data_src.val = val;
-	}
+	if (sample_type & PERF_SAMPLE_DATA_SRC)
+		data->data_src.val = get_data_src(event, pebs->dse);
 
 	/*
 	 * We must however always use iregs for the unwinder to stay sane; the
@@ -1281,10 +1285,11 @@ static void setup_pebs_sample_data(struct perf_event *event,
 	if (x86_pmu.intel_cap.pebs_format >= 2) {
 		/* Only set the TSX weight when no memory weight. */
 		if ((sample_type & PERF_SAMPLE_WEIGHT) && !fll)
-			data->weight = intel_hsw_weight(pebs);
+			data->weight = intel_get_tsx_weight(pebs->tsx_tuning);
 
 		if (sample_type & PERF_SAMPLE_TRANSACTION)
-			data->txn = intel_hsw_transaction(pebs);
+			data->txn = intel_get_tsx_transaction(pebs->tsx_tuning,
+							      pebs->ax);
 	}
 
 	/*
-- 
2.17.1

