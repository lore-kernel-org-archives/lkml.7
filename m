Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C885BC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765C02147A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CC0ooN4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfDHPlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:41:21 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59400 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfDHPlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=H4ketvLYjms5ZdN0tDZEHTZVdWn0Y5vlV4EuQwM2xbk=; b=CC0ooN4O5YrEySzWmnirS60Na
        KEE2ihMOdH6dLYTZInrI4UmjJZFcHQMxiqcvszpZSoOhsif40hAsRj0cqXkkompIatGb73neRsM5A
        LJX+A62tSycOPw7qOVSxyuoacUtsAAWTwe0dLKk4yLSLLBV856snkDKI2apzjfzYmWONkQt+9c+qM
        ZgCCuMaJL5HbVYl9870iGAjFjsxiPIQXNJuW9w6Er8g2zuukvOuo+IEZWgNfHC4QYOJUol3d5Mkpe
        Y+J3ql/NBIztTFtFQcaGQlUGa05F3vQDpoXXaBP3Ak66U2tH+qMOEF1b400SVfw6TF7opky5cZDwU
        XEjCAVPGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDWOX-0007wc-P7; Mon, 08 Apr 2019 15:41:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 392E52030C791; Mon,  8 Apr 2019 17:41:12 +0200 (CEST)
Date:   Mon, 8 Apr 2019 17:41:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V5 00/12] perf: Add Icelake support (kernel only, except
 Topdown)
Message-ID: <20190408154112.GW12232@hirez.programming.kicks-ass.net>
References: <20190402194509.2832-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402194509.2832-1-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I currently have something like the below on top, is that correct?

If so, I'll fold it back in.


--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -563,16 +563,17 @@ int x86_pmu_hw_config(struct perf_event
 	/* sample_regs_user never support XMM registers */
 	if (unlikely(event->attr.sample_regs_user & PEBS_XMM_REGS))
 		return -EINVAL;
+
 	/*
 	 * Besides the general purpose registers, XMM registers may
 	 * be collected in PEBS on some platforms, e.g. Icelake
 	 */
 	if (unlikely(event->attr.sample_regs_intr & PEBS_XMM_REGS)) {
-		if (!is_sampling_event(event) ||
-		    !event->attr.precise_ip ||
-		    x86_pmu.pebs_no_xmm_regs)
+		if (x86_pmu.pebs_no_xmm_regs)
 			return -EINVAL;
 
+		if (!event->attr.precise_ip)
+			return -EINVAL;
 	}
 
 	return x86_setup_perfctr(event);
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3428,7 +3428,7 @@ icl_get_event_constraints(struct cpu_hw_
 	 * Force instruction:ppp in Fixed counter 0
 	 */
 	if ((event->attr.precise_ip == 3) &&
-	    ((event->hw.config & X86_RAW_EVENT_MASK) == 0x00c0))
+	    (event->hw.config == X86_CONFIG(.event=0xc0)))
 		return &fixed_counter0_constraint;
 
 	return hsw_get_event_constraints(cpuc, idx, event);
@@ -4810,7 +4810,7 @@ __init int intel_pmu_init(void)
 			hsw_format_attr : nhm_format_attr;
 		extra_attr = merge_attr(extra_attr, skl_format_attr);
 		x86_pmu.cpu_events = get_icl_events_attrs();
-		x86_pmu.force_gpr_event = 0x2ca;
+		x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xca, .umask=0x02);
 		x86_pmu.lbr_pt_coexist = true;
 		intel_pmu_pebs_data_source_skl(false);
 		pr_cont("Icelake events, ");
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -853,13 +853,13 @@ struct event_constraint intel_icl_pebs_e
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x1c0, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x400000000ULL),	/* SLOTS */
 
-	INTEL_PLD_CONSTRAINT(0x1cd, 0xff),		/* MEM_TRANS_RETIRED.LOAD_LATENCY */
-	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x1d0, 0xf),  /* MEM_INST_RETIRED.LOAD */
-	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x2d0, 0xf),  /* MEM_INST_RETIRED.STORE */
+	INTEL_PLD_CONSTRAINT(0x1cd, 0xff),			/* MEM_TRANS_RETIRED.LOAD_LATENCY */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x1d0, 0xf),	/* MEM_INST_RETIRED.LOAD */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x2d0, 0xf),	/* MEM_INST_RETIRED.STORE */
 
 	INTEL_FLAGS_EVENT_CONSTRAINT_DATALA_LD_RANGE(0xd1, 0xd4, 0xf), /* MEM_LOAD_*_RETIRED.* */
 
-	INTEL_FLAGS_EVENT_CONSTRAINT(0xd0, 0xf), 	     /* MEM_INST_RETIRED.* */
+	INTEL_FLAGS_EVENT_CONSTRAINT(0xd0, 0xf),		/* MEM_INST_RETIRED.* */
 
 	/*
 	 * Everything else is handled by PMU_FL_PEBS_ALL, because we
@@ -963,40 +963,42 @@ static u64 pebs_update_adaptive_cfg(stru
 	u64 pebs_data_cfg = 0;
 	bool gprs, tsx_weight;
 
-	if ((sample_type & ~(PERF_SAMPLE_IP|PERF_SAMPLE_TIME)) ||
-	    attr->precise_ip < 2) {
+	if (!(sample_type & ~(PERF_SAMPLE_IP|PERF_SAMPLE_TIME)) &&
+	    attr->precise_ip > 1)
+		return pebs_data_cfs;
 
-		if (sample_type & PERF_PEBS_MEMINFO_TYPE)
-			pebs_data_cfg |= PEBS_DATACFG_MEMINFO;
+	if (sample_type & PERF_PEBS_MEMINFO_TYPE)
+		pebs_data_cfg |= PEBS_DATACFG_MEMINFO;
 
+	/*
+	 * We need GPRs when:
+	 * + user requested them
+	 * + precise_ip < 2 for the non event IP
+	 * + For RTM TSX weight we need GPRs for the abort code.
+	 */
+	gprs = (sample_type & PERF_SAMPLE_REGS_INTR) &&
+	       (attr->sample_regs_intr & PEBS_GPRS_REGS);
+
+	tsx_weight = (sample_type & PERF_SAMPLE_WEIGHT) &&
+		     ((attr->config & INTEL_ARCH_EVENT_MASK) ==
+		      x86_pmu.rtm_abort_event);
+
+	if (gprs || (attr->precise_ip < 2) || tsx_weight)
+		pebs_data_cfg |= PEBS_DATACFG_GPRS;
+
+	if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
+	    (attr->sample_regs_intr & PERF_XMM_REGS))
+		pebs_data_cfg |= PEBS_DATACFG_XMMS;
+
+	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
 		/*
-		 * Cases we need the registers:
-		 * + user requested registers
-		 * + precise_ip < 2 for the non event IP
-		 * + For RTM TSX weight we need GPRs too for the abort
-		 * code. But we don't want to force GPRs for all other
-		 * weights.  So add it only collectfor the RTM abort event.
+		 * For now always log all LBRs. Could configure this
+		 * later.
 		 */
-		gprs = (sample_type & PERF_SAMPLE_REGS_INTR) &&
-			      (attr->sample_regs_intr & 0xffffffff);
-		tsx_weight = (sample_type & PERF_SAMPLE_WEIGHT) &&
-			     ((attr->config & 0xffff) == x86_pmu.force_gpr_event);
-		if (gprs || (attr->precise_ip < 2) || tsx_weight)
-			pebs_data_cfg |= PEBS_DATACFG_GPRS;
-
-		if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
-		    (attr->sample_regs_intr >> 32))
-			pebs_data_cfg |= PEBS_DATACFG_XMMS;
-
-		if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
-			/*
-			 * For now always log all LBRs. Could configure this
-			 * later.
-			 */
-			pebs_data_cfg |= PEBS_DATACFG_LBRS |
-				((x86_pmu.lbr_nr-1) << PEBS_DATACFG_LBR_SHIFT);
-		}
+		pebs_data_cfg |= PEBS_DATACFG_LBRS |
+			((x86_pmu.lbr_nr-1) << PEBS_DATACFG_LBR_SHIFT);
 	}
+
 	return pebs_data_cfg;
 }
 
@@ -1022,13 +1024,8 @@ pebs_update_state(bool needed_cb, struct
 	}
 
 	/*
-	 * The PEBS record doesn't shrink on the del. Because to get
-	 * an accurate config needs to go through all the existing pebs events.
-	 * It's not necessary.
-	 * There is no harmful for a bigger PEBS record, except little
-	 * performance impacts.
-	 * Also, for most cases, the same pebs config is applied for all
-	 * pebs events.
+	 * The PEBS record doesn't shrink on pmu::del(). Doing so would require
+	 * iterating all remaining PEBS events to reconstruct the config.
 	 */
 	if (x86_pmu.intel_cap.pebs_baseline && add) {
 		u64 pebs_data_cfg;
@@ -1076,8 +1073,7 @@ void intel_pmu_pebs_enable(struct perf_e
 
 	cpuc->pebs_enabled |= 1ULL << hwc->idx;
 
-	if ((event->hw.flags & PERF_X86_EVENT_PEBS_LDLAT) &&
-	    (x86_pmu.version < 5))
+	if ((event->hw.flags & PERF_X86_EVENT_PEBS_LDLAT) && (x86_pmu.version < 5))
 		cpuc->pebs_enabled |= 1ULL << (hwc->idx + 32);
 	else if (event->hw.flags & PERF_X86_EVENT_PEBS_ST)
 		cpuc->pebs_enabled |= 1ULL << 63;
@@ -1766,8 +1762,7 @@ static void intel_pmu_drain_pebs_core(st
 			       setup_pebs_fixed_sample_data);
 }
 
-static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc,
-						 int size)
+static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, int size)
 {
 	struct perf_event *event;
 	int bit;
@@ -1826,8 +1821,7 @@ static void intel_pmu_drain_pebs_nhm(str
 
 		/* PEBS v3 has more accurate status bits */
 		if (x86_pmu.intel_cap.pebs_format >= 3) {
-			for_each_set_bit(bit, (unsigned long *)&pebs_status,
-					 size)
+			for_each_set_bit(bit, (unsigned long *)&pebs_status, size)
 				counts[bit]++;
 
 			continue;
@@ -1866,8 +1860,7 @@ static void intel_pmu_drain_pebs_nhm(str
 		 * If collision happened, the record will be dropped.
 		 */
 		if (p->status != (1ULL << bit)) {
-			for_each_set_bit(i, (unsigned long *)&pebs_status,
-					 x86_pmu.max_pebs_events)
+			for_each_set_bit(i, (unsigned long *)&pebs_status, size)
 				error[i]++;
 			continue;
 		}
@@ -1875,7 +1868,7 @@ static void intel_pmu_drain_pebs_nhm(str
 		counts[bit]++;
 	}
 
-	for (bit = 0; bit < size; bit++) {
+	for_each_set_bit(bit, (unsigned long *)&mask, size) {
 		if ((counts[bit] == 0) && (error[bit] == 0))
 			continue;
 
@@ -1939,7 +1932,7 @@ static void intel_pmu_drain_pebs_icl(str
 			counts[bit]++;
 	}
 
-	for (bit = 0; bit < size; bit++) {
+	for_each_set_bit(bit, (unsigned long *)mask, size) {
 		if (counts[bit] == 0)
 			continue;
 
@@ -1980,6 +1973,9 @@ void __init intel_ds_init(void)
 		char *pebs_qual = "";
 		int format = x86_pmu.intel_cap.pebs_format;
 
+		if (format < 4)
+			x86_pmu.intel_cap.pebs_baseline = 0;
+
 		switch (format) {
 		case 0:
 			pr_cont("PEBS fmt0%c, ", pebs_type);
@@ -2042,8 +2038,6 @@ void __init intel_ds_init(void)
 			pr_cont("no PEBS fmt%d%c, ", format, pebs_type);
 			x86_pmu.pebs = 0;
 		}
-		if (format != 4)
-			x86_pmu.intel_cap.pebs_baseline = 0;
 	}
 }
 
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -303,8 +303,8 @@ struct cpu_hw_events {
 	__EVENT_CONSTRAINT(c, n, m, HWEIGHT(n), 0, 0)
 
 /*
- * Only works for Intel events, which has 'small' event codes.
- * Need to fix the rang compare for 'big' event codes, e.g AMD64_EVENTSEL_EVENT
+ * The constraint_match() function only works for 'simple' event codes
+ * and not for extended (AMD64_EVENTSEL_EVENT) events codes.
  */
 #define EVENT_CONSTRAINT_RANGE(c, e, n, m) \
 	__EVENT_CONSTRAINT_RANGE(c, e, n, m, HWEIGHT(n), 0, 0)
@@ -672,12 +672,12 @@ struct x86_pmu {
 			pebs_no_xmm_regs	:1;
 	int		pebs_record_size;
 	int		pebs_buffer_size;
+	int		max_pebs_events;
 	void		(*drain_pebs)(struct pt_regs *regs);
 	struct event_constraint *pebs_constraints;
 	void		(*pebs_aliases)(struct perf_event *event);
-	int 		max_pebs_events;
 	unsigned long	large_pebs_flags;
-	u64		force_gpr_event;
+	u64		rtm_abort_event;
 
 	/*
 	 * Intel LBR
