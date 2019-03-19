Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE922C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0312083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cm4a9opx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfCSOrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:47:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33048 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfCSOry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WX36R1rrJVN6Rn4dBgl3i381zqnIZFniBTAcbea+lz4=; b=Cm4a9opx/ihG2P9y+rCoKyQRn
        u9J1do0LGxRCdcIl9VnTwI/uy6W6Wj/bMpHEX/V0Gx37qADdDV2AinADEH/sza5M0XYhEVZspVQ5M
        mOMcieaQKmJgmCG0BhYcCizzoSs2dwKeLVVTamDeN6ohnqe4ruFbID6qv7UnKvkST9NTCg48RY/1O
        yihhXTI9RoKAT263PewchvL1Idgv/qIZ+PdTkVnaAZ/I2laB+0dASfsTitbkB7nU2vTUbLmVqrDXh
        H7Tsdvj2bnh6/RYXgltLjsrjOYU9mBsbSTF71WOOtsknOxoATdgiqc43g1jf8uMYHgEZ/b/WqVs1D
        eIJAUkuyw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6G1u-0004rj-4f; Tue, 19 Mar 2019 14:47:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3710823CB651B; Tue, 19 Mar 2019 15:47:48 +0100 (CET)
Date:   Tue, 19 Mar 2019 15:47:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 03/22] perf/x86/intel: Support adaptive PEBSv4
Message-ID: <20190319144748.GH5996@hirez.programming.kicks-ass.net>
References: <20190318214144.4639-1-kan.liang@linux.intel.com>
 <20190318214144.4639-4-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318214144.4639-4-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 02:41:25PM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Adaptive PEBS is a new way to report PEBS sampling information. Instead
> of a fixed size record for all PEBS events it allows to configure the
> PEBS record to only include the information needed. Events can then opt
> in to use such an extended record, or stay with a basic record which
> only contains the IP.
> 
> The major new feature is to support LBRs in PEBS record.
> This allows (much faster) large PEBS, while still supporting callstacks
> through callstack LBR. 

Does it also allow normal LBR usage? Or does it have to be callstacks?

>  arch/x86/events/intel/core.c      |   2 +
>  arch/x86/events/intel/ds.c        | 293 ++++++++++++++++++++++++++++--
>  arch/x86/events/intel/lbr.c       |  22 +++
>  arch/x86/events/perf_event.h      |  14 ++
>  arch/x86/include/asm/msr-index.h  |   1 +
>  arch/x86/include/asm/perf_event.h |  42 +++++
>  6 files changed, 359 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 17096d3cd616..a964b9832b0c 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3446,6 +3446,8 @@ static int intel_pmu_cpu_prepare(int cpu)
>  {
>  	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
>  
> +	cpuc->pebs_record_size = x86_pmu.pebs_record_size;
> +
>  	if (x86_pmu.extra_regs || x86_pmu.lbr_sel_map) {
>  		cpuc->shared_regs = allocate_shared_regs(cpu);
>  		if (!cpuc->shared_regs)

Does not apply... Didn't apply when you send it. At the very least you
could've refreshed the series before sending :/

> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 4a2206876baa..974284c5ed6c 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -906,17 +906,82 @@ static inline void pebs_update_threshold(struct cpu_hw_events *cpuc)
>  
>  	if (cpuc->n_pebs == cpuc->n_large_pebs) {
>  		threshold = ds->pebs_absolute_maximum -
> -			reserved * x86_pmu.pebs_record_size;
> +			reserved * cpuc->pebs_record_size;
>  	} else {
> -		threshold = ds->pebs_buffer_base + x86_pmu.pebs_record_size;
> +		threshold = ds->pebs_buffer_base + cpuc->pebs_record_size;
>  	}
>  
>  	ds->pebs_interrupt_threshold = threshold;
>  }
>  
> +static void adaptive_pebs_record_size_update(void)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	u64 d = cpuc->pebs_data_cfg;
> +	int sz = sizeof(struct pebs_basic);
> +
> +	if (d & PEBS_DATACFG_MEMINFO)
> +		sz += sizeof(struct pebs_meminfo);
> +	if (d & PEBS_DATACFG_GPRS)
> +		sz += sizeof(struct pebs_gprs);
> +	if (d & PEBS_DATACFG_XMMS)
> +		sz += sizeof(struct pebs_xmm);
> +	if (d & PEBS_DATACFG_LBRS)
> +		sz += x86_pmu.lbr_nr * sizeof(struct pebs_lbr_entry);
> +
> +	cpuc->pebs_record_size = sz;
> +}

You call that @d pebs_data_cfg elsewhere, why the inconsistency?

> +static u64 pebs_update_adaptive_cfg(struct perf_event *event)
> +{
> +	u64 sample_type = event->attr.sample_type;
> +	u64 pebs_data_cfg = 0;
> +
> +

too much whitespace

> +	if ((sample_type & ~(PERF_SAMPLE_IP|PERF_SAMPLE_TIME)) ||
> +		event->attr.precise_ip < 2) {
> +
> +		if (sample_type & (PERF_SAMPLE_ADDR | PERF_SAMPLE_DATA_SRC |
> +				   PERF_SAMPLE_PHYS_ADDR | PERF_SAMPLE_WEIGHT |
> +				   PERF_SAMPLE_TRANSACTION))
> +			pebs_data_cfg |= PEBS_DATACFG_MEMINFO;
> +
> +		/*
> +		 * Cases we need the registers:
> +		 * + user requested registers
> +		 * + precise_ip < 2 for the non event IP
> +		 * + For RTM TSX weight we need GPRs too for the abort
> +		 * code. But we don't want to force GPRs for all other
> +		 * weights.  So add it only for the RTM abort event.
> +		 */
> +		if (((sample_type & PERF_SAMPLE_REGS_INTR) &&
> +			(event->attr.sample_regs_intr & 0xffffffff)) ||
> +		    (event->attr.precise_ip < 2) ||
> +		    ((sample_type & PERF_SAMPLE_WEIGHT) &&
> +		     ((event->attr.config & 0xffff) == x86_pmu.force_gpr_event)))
> +			pebs_data_cfg |= PEBS_DATACFG_GPRS;

I know it has a comment, but it would be nice for the code to be
readable too. This is horrible.

> +
> +		if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
> +			(event->attr.sample_regs_intr >> 32))
> +			pebs_data_cfg |= PEBS_DATACFG_XMMS;

indent fail

> +
> +		if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
> +			/*
> +			 * For now always log all LBRs. Could configure this
> +			 * later.
> +			 */
> +			pebs_data_cfg |= PEBS_DATACFG_LBRS |
> +				((x86_pmu.lbr_nr-1) << PEBS_DATACFG_LBR_SHIFT);
> +		}
> +	}
> +	return pebs_data_cfg;
> +}
> +
>  static void
> -pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc, struct pmu *pmu)
> +pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc,
> +		  struct perf_event *event, bool add)
>  {
> +	struct pmu *pmu = event->ctx->pmu;
>  	/*
>  	 * Make sure we get updated with the first PEBS
>  	 * event. It will trigger also during removal, but
> @@ -933,6 +998,19 @@ pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc, struct pmu *pmu)
>  		update = true;
>  	}
>  
> +	if (x86_pmu.intel_cap.pebs_baseline && add) {
> +		u64 pebs_data_cfg;
> +
> +		pebs_data_cfg = pebs_update_adaptive_cfg(event);
> +
> +		/* Update pebs_record_size if new event requires more data. */
> +		if (pebs_data_cfg & ~cpuc->pebs_data_cfg) {
> +			cpuc->pebs_data_cfg |= pebs_data_cfg;
> +			adaptive_pebs_record_size_update();
> +			update = true;
> +		}
> +	}
> +
>  	if (update)
>  		pebs_update_threshold(cpuc);
>  }

Hurmph.. this only grows the PEBS record.


> @@ -947,7 +1025,7 @@ void intel_pmu_pebs_add(struct perf_event *event)
>  	if (hwc->flags & PERF_X86_EVENT_LARGE_PEBS)
>  		cpuc->n_large_pebs++;
>  
> -	pebs_update_state(needed_cb, cpuc, event->ctx->pmu);
> +	pebs_update_state(needed_cb, cpuc, event, true);
>  }
>  
>  void intel_pmu_pebs_enable(struct perf_event *event)
> @@ -965,6 +1043,14 @@ void intel_pmu_pebs_enable(struct perf_event *event)
>  	else if (event->hw.flags & PERF_X86_EVENT_PEBS_ST)
>  		cpuc->pebs_enabled |= 1ULL << 63;
>  
> +	if (x86_pmu.intel_cap.pebs_baseline) {
> +		hwc->config |= ICL_EVENTSEL_ADAPTIVE;
> +		if (cpuc->pebs_data_cfg != cpuc->active_pebs_data_cfg) {
> +			wrmsrl(MSR_PEBS_DATA_CFG, cpuc->pebs_data_cfg);
> +			cpuc->active_pebs_data_cfg = cpuc->pebs_data_cfg;
> +		}
> +	}
> +
>  	/*
>  	 * Use auto-reload if possible to save a MSR write in the PMI.
>  	 * This must be done in pmu::start(), because PERF_EVENT_IOC_PERIOD.
> @@ -991,7 +1077,12 @@ void intel_pmu_pebs_del(struct perf_event *event)
>  	if (hwc->flags & PERF_X86_EVENT_LARGE_PEBS)
>  		cpuc->n_large_pebs--;
>  
> -	pebs_update_state(needed_cb, cpuc, event->ctx->pmu);
> +	/* Clear both pebs_data_cfg and pebs_record_size for first PEBS. */

Weird comment..

> +	if (x86_pmu.intel_cap.pebs_baseline && !cpuc->n_pebs) {
> +		cpuc->pebs_data_cfg = 0;
> +		cpuc->pebs_record_size = sizeof(struct pebs_basic);
> +	}
> +	pebs_update_state(needed_cb, cpuc, event, false);

Why do we have to reset record_size? That'll be updated in
pebs_update_state() on the next add.

>  }
>  
>  void intel_pmu_pebs_disable(struct perf_event *event)
> @@ -1004,6 +1095,8 @@ void intel_pmu_pebs_disable(struct perf_event *event)
>  
>  	cpuc->pebs_enabled &= ~(1ULL << hwc->idx);
>  
> +	/* Delay reprograming DATA_CFG to next enable */
> +

No need for that I think.

>  	if (event->hw.flags & PERF_X86_EVENT_PEBS_LDLAT)
>  		cpuc->pebs_enabled &= ~(1ULL << (hwc->idx + 32));
>  	else if (event->hw.flags & PERF_X86_EVENT_PEBS_ST)
> @@ -1013,6 +1106,7 @@ void intel_pmu_pebs_disable(struct perf_event *event)
>  		wrmsrl(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
>  
>  	hwc->config |= ARCH_PERFMON_EVENTSEL_INT;
> +	hwc->config &= ~ICL_EVENTSEL_ADAPTIVE;

Just curious; the way I read the SDM, we could leave this set, is that
correct?

>  }
>  
>  void intel_pmu_pebs_enable_all(void)

> @@ -1323,19 +1558,20 @@ get_next_pebs_record_by_bit(void *base, void *top, int bit)
>  	if (base == NULL)
>  		return NULL;
>  
> -	for (at = base; at < top; at += x86_pmu.pebs_record_size) {
> +	for (at = base; at < top; at = next_pebs_record(at)) {

That _should_ work with cpuc->pebs_record_size, right?

>  		struct pebs_record_nhm *p = at;
> +		unsigned long status = get_pebs_status(p);
>  
> -		if (test_bit(bit, (unsigned long *)&p->status)) {
> +		if (test_bit(bit, (unsigned long *)&status)) {
>  			/* PEBS v3 has accurate status bits */
>  			if (x86_pmu.intel_cap.pebs_format >= 3)
>  				return at;
>  
> -			if (p->status == (1 << bit))
> +			if (status == (1 << bit))
>  				return at;
>  
>  			/* clear non-PEBS bit and re-check */
> -			pebs_status = p->status & cpuc->pebs_enabled;
> +			pebs_status = status & cpuc->pebs_enabled;
>  			pebs_status &= PEBS_COUNTER_MASK;
>  			if (pebs_status == (1 << bit))
>  				return at;

> @@ -1434,14 +1670,14 @@ static void __intel_pmu_pebs_event(struct perf_event *event,
>  		return;
>  
>  	while (count > 1) {
> -		setup_pebs_sample_data(event, iregs, at, &data, &regs);
> +		x86_pmu.setup_pebs_sample_data(event, iregs, at, &data, &regs);
>  		perf_event_output(event, &data, &regs);
> -		at += x86_pmu.pebs_record_size;
> +		at = next_pebs_record(at);
>  		at = get_next_pebs_record_by_bit(at, top, bit);
>  		count--;
>  	}
>  
> -	setup_pebs_sample_data(event, iregs, at, &data, &regs);
> +	x86_pmu.setup_pebs_sample_data(event, iregs, at, &data, &regs);
>  
>  	/*
>  	 * All but the last records are processed.
> @@ -1534,11 +1770,11 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs)
>  		return;
>  	}
>  
> -	for (at = base; at < top; at += x86_pmu.pebs_record_size) {
> +	for (at = base; at < top; at = next_pebs_record(at)) {
>  		struct pebs_record_nhm *p = at;
>  		u64 pebs_status;
>  
> -		pebs_status = p->status & cpuc->pebs_enabled;
> +		pebs_status = get_pebs_status(p) & cpuc->pebs_enabled;
>  		pebs_status &= mask;
>  
>  		/* PEBS v3 has more accurate status bits */

How much work would intel_pmu_drain_pebs_icl() be?

I'm thinking that might not be terrible.
