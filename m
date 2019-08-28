Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3B3C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0299320856
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfH1Nv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:51:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:63657 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbfH1Nvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:51:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 06:51:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,441,1559545200"; 
   d="scan'208";a="197562353"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 28 Aug 2019 06:51:54 -0700
Received: from [10.254.95.196] (kliang2-mobl.ccr.corp.intel.com [10.254.95.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id E8AC6580409;
        Wed, 28 Aug 2019 06:51:52 -0700 (PDT)
Subject: Re: [RESEND PATCH V3 2/8] perf/x86/intel: Basic support for metrics
 counters
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20190826144740.10163-1-kan.liang@linux.intel.com>
 <20190826144740.10163-3-kan.liang@linux.intel.com>
 <20190828084416.GC2369@hirez.programming.kicks-ass.net>
 <20190828090217.GN2386@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <0798b310-3337-cc5f-99fb-73ce5849f7d4@linux.intel.com>
Date:   Wed, 28 Aug 2019 09:51:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828090217.GN2386@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/2019 5:02 AM, Peter Zijlstra wrote:
> On Wed, Aug 28, 2019 at 10:44:16AM +0200, Peter Zijlstra wrote:
> 
>> Let me clean up this mess for you.
> 
> Here, how's that. Now we don't check is_metric_idx() _3_ times on the
> enable/disable path and all the topdown crud is properly placed in the
> fixed counter functions.

Thank you very much for the cleanup. The new code is more efficient.
I will prepare V4 with this code and to address other comments.

Thanks,
Kan
> 
> Please think; don't tinker.
> 
> ---
> 
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1033,22 +1033,34 @@ static inline void x86_assign_hw_event(s
>   				struct cpu_hw_events *cpuc, int i)
>   {
>   	struct hw_perf_event *hwc = &event->hw;
> +	int idx;
>   
> -	hwc->idx = cpuc->assign[i];
> +	idx = hwc->idx = cpuc->assign[i];
>   	hwc->last_cpu = smp_processor_id();
>   	hwc->last_tag = ++cpuc->tags[i];
>   
> -	if (hwc->idx == INTEL_PMC_IDX_FIXED_BTS) {
> +	switch (hwc->idx) {
> +	case INTEL_PMC_IDX_FIXED_BTS:
>   		hwc->config_base = 0;
>   		hwc->event_base	= 0;
> -	} else if (hwc->idx >= INTEL_PMC_IDX_FIXED) {
> +		break;
> +
> +	case INTEL_PMC_IDX_FIXED_METRIC_BASE ... INTEL_PMC_IDX_FIXED_METRIC_BASE+3:
> +		/* All METRIC events are mapped onto the fixed SLOTS event */
> +		idx = INTEL_PMC_IDX_FIXED_SLOTS;
> +
> +	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS-1:
>   		hwc->config_base = MSR_ARCH_PERFMON_FIXED_CTR_CTRL;
> -		hwc->event_base = MSR_ARCH_PERFMON_FIXED_CTR0 + (hwc->idx - INTEL_PMC_IDX_FIXED);
> -		hwc->event_base_rdpmc = (hwc->idx - INTEL_PMC_IDX_FIXED) | 1<<30;
> -	} else {
> +		hwc->event_base = MSR_ARCH_PERFMON_FIXED_CTR0 +
> +				  (idx - INTEL_PMC_IDX_FIXED);
> +		hwc->event_base_rdpmc = (idx - INTEL_PMC_IDX_FIXED) | 1<<30;
> +		break;
> +
> +	default:
>   		hwc->config_base = x86_pmu_config_addr(hwc->idx);
>   		hwc->event_base  = x86_pmu_event_addr(hwc->idx);
>   		hwc->event_base_rdpmc = x86_pmu_rdpmc_index(hwc->idx);
> +		break;
>   	}
>   }
>   
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2128,27 +2128,61 @@ static inline void intel_pmu_ack_status(
>   	wrmsrl(MSR_CORE_PERF_GLOBAL_OVF_CTRL, ack);
>   }
>   
> -static void intel_pmu_disable_fixed(struct hw_perf_event *hwc)
> +static inline bool event_is_checkpointed(struct perf_event *event)
> +{
> +	return unlikely(event->hw.config & HSW_IN_TX_CHECKPOINTED) != 0;
> +}
> +
> +static inline void intel_set_masks(struct perf_event *event, int idx)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +
> +	if (event->attr.exclude_host)
> +		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_guest_mask);
> +	if (event->attr.exclude_guest)
> +		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_host_mask);
> +	if (event_is_checkpointed(event))
> +		__set_bit(idx, (unsigned long *)&cpuc->intel_cp_status);
> +}
> +
> +static inline void intel_clear_masks(struct perf_event *event, int idx)
>   {
> -	int idx = hwc->idx - INTEL_PMC_IDX_FIXED;
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +
> +	__clear_bit(idx, (unsigned long *)&cpuc->intel_ctrl_guest_mask);
> +	__clear_bit(idx, (unsigned long *)&cpuc->intel_ctrl_host_mask);
> +	__clear_bit(idx, (unsigned long *)&cpuc->intel_cp_status);
> +}
> +
> +static void intel_pmu_disable_fixed(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
>   	u64 ctrl_val, mask;
> +	int idx = hwc->idx;
>   
> -	mask = 0xfULL << (idx * 4);
> +	if (is_topdown_idx(idx)) {
> +		struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +		/*
> +		 * When there are other Top-Down events still active; don't
> +		 * disable the SLOTS counter.
> +		 */
> +		if (*(u64 *)cpuc->active_mask & INTEL_PMC_OTHER_TOPDOWN_BITS(idx))
> +			return;
> +
> +		idx = INTEL_PMC_IDX_FIXED_SLOTS;
> +	}
>   
> +	intel_clear_masks(event, idx);
> +
> +	mask = 0xfULL << ((idx - INTEL_PMC_IDX_FIXED) * 4);
>   	rdmsrl(hwc->config_base, ctrl_val);
>   	ctrl_val &= ~mask;
>   	wrmsrl(hwc->config_base, ctrl_val);
>   }
>   
> -static inline bool event_is_checkpointed(struct perf_event *event)
> -{
> -	return (event->hw.config & HSW_IN_TX_CHECKPOINTED) != 0;
> -}
> -
>   static void intel_pmu_disable_event(struct perf_event *event)
>   {
>   	struct hw_perf_event *hwc = &event->hw;
> -	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>   
>   	if (unlikely(hwc->idx == INTEL_PMC_IDX_FIXED_BTS)) {
>   		intel_pmu_disable_bts();
> @@ -2156,18 +2190,19 @@ static void intel_pmu_disable_event(stru
>   		return;
>   	}
>   
> -	cpuc->intel_ctrl_guest_mask &= ~(1ull << hwc->idx);
> -	cpuc->intel_ctrl_host_mask &= ~(1ull << hwc->idx);
> -	cpuc->intel_cp_status &= ~(1ull << hwc->idx);
> -
> -	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL))
> -		intel_pmu_disable_fixed(hwc);
> -	else
> +	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL)) {
> +		intel_pmu_disable_fixed(event);
> +	} else {
> +		intel_clear_masks(event, hwc->idx);
>   		x86_pmu_disable_event(event);
> +	}
>   
>   	/*
>   	 * Needs to be called after x86_pmu_disable_event,
>   	 * so we don't trigger the event without PEBS bit set.
> +	 *
> +	 * Metric stuff doesn't do PEBS (I hope?); and so the early exit from
> +	 * intel_pmu_disable_fixed() is OK.
>   	 */
>   	if (unlikely(event->attr.precise_ip))
>   		intel_pmu_pebs_disable(event);
> @@ -2192,8 +2227,22 @@ static void intel_pmu_read_event(struct
>   static void intel_pmu_enable_fixed(struct perf_event *event)
>   {
>   	struct hw_perf_event *hwc = &event->hw;
> -	int idx = hwc->idx - INTEL_PMC_IDX_FIXED;
>   	u64 ctrl_val, mask, bits = 0;
> +	int idx = hwc->idx;
> +
> +	if (is_topdown_idx(idx)) {
> +		struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +		/*
> +		 * When there are other Top-Down events already active; don't
> +		 * enable the SLOTS counter.
> +		 */
> +		if (*(u64 *)cpuc->active_mask & INTEL_PMC_OTHER_TOPDOWN_BITS(idx))
> +			return;
> +
> +		idx = INTEL_PMC_IDX_FIXED_SLOTS;
> +	}
> +
> +	intel_set_masks(event, hwc->idx);
>   
>   	/*
>   	 * Enable IRQ generation (0x8), if not PEBS,
> @@ -2213,6 +2262,7 @@ static void intel_pmu_enable_fixed(struc
>   	if (x86_pmu.version > 2 && hwc->config & ARCH_PERFMON_EVENTSEL_ANY)
>   		bits |= 0x4;
>   
> +	idx -= INTEL_PMC_IDX_FIXED;
>   	bits <<= (idx * 4);
>   	mask = 0xfULL << (idx * 4);
>   
> @@ -2230,7 +2280,6 @@ static void intel_pmu_enable_fixed(struc
>   static void intel_pmu_enable_event(struct perf_event *event)
>   {
>   	struct hw_perf_event *hwc = &event->hw;
> -	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>   
>   	if (unlikely(hwc->idx == INTEL_PMC_IDX_FIXED_BTS)) {
>   		if (!__this_cpu_read(cpu_hw_events.enabled))
> @@ -2240,23 +2289,16 @@ static void intel_pmu_enable_event(struc
>   		return;
>   	}
>   
> -	if (event->attr.exclude_host)
> -		cpuc->intel_ctrl_guest_mask |= (1ull << hwc->idx);
> -	if (event->attr.exclude_guest)
> -		cpuc->intel_ctrl_host_mask |= (1ull << hwc->idx);
> -
> -	if (unlikely(event_is_checkpointed(event)))
> -		cpuc->intel_cp_status |= (1ull << hwc->idx);
>   
>   	if (unlikely(event->attr.precise_ip))
>   		intel_pmu_pebs_enable(event);
>   
>   	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL)) {
>   		intel_pmu_enable_fixed(event);
> -		return;
> +	} else {
> +		intel_set_masks(event, hwc->idx);
> +		__x86_pmu_enable_event(hwc, ARCH_PERFMON_EVENTSEL_ENABLE);
>   	}
> -
> -	__x86_pmu_enable_event(hwc, ARCH_PERFMON_EVENTSEL_ENABLE);
>   }
>   
>   static void intel_pmu_add_event(struct perf_event *event)
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -349,6 +349,20 @@ struct cpu_hw_events {
>   	EVENT_CONSTRAINT(c, (1ULL << (32+n)), FIXED_EVENT_FLAGS)
>   
>   /*
> + * Special metric counters do not actually exist, but get remapped
> + * to a combination of FxCtr3 + MSR_PERF_METRICS
> + *
> + * This allocates them to a dummy offset for the scheduler.
> + * This does not allow sharing of multiple users of the same
> + * metric without multiplexing, even though the hardware supports that
> + * in principle.
> + */
> +
> +#define METRIC_EVENT_CONSTRAINT(c, n)					\
> +	EVENT_CONSTRAINT(c, (1ULL << (INTEL_PMC_IDX_FIXED_METRIC_BASE+n)), \
> +			 FIXED_EVENT_FLAGS)
> +
> +/*
>    * Constraint on the Event code + UMask
>    */
>   #define INTEL_UEVENT_CONSTRAINT(c, n)	\
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -795,6 +795,7 @@
>   #define MSR_CORE_PERF_FIXED_CTR0	0x00000309
>   #define MSR_CORE_PERF_FIXED_CTR1	0x0000030a
>   #define MSR_CORE_PERF_FIXED_CTR2	0x0000030b
> +#define MSR_CORE_PERF_FIXED_CTR3	0x0000030c
>   #define MSR_CORE_PERF_FIXED_CTR_CTRL	0x0000038d
>   #define MSR_CORE_PERF_GLOBAL_STATUS	0x0000038e
>   #define MSR_CORE_PERF_GLOBAL_CTRL	0x0000038f
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -175,11 +175,39 @@ struct x86_pmu_capability {
>   /*
>    * We model BTS tracing as another fixed-mode PMC.
>    *
> - * We choose a value in the middle of the fixed event range, since lower
> + * We choose value 47 for the fixed index of BTS, since lower
>    * values are used by actual fixed events and higher values are used
>    * to indicate other overflow conditions in the PERF_GLOBAL_STATUS msr.
>    */
> -#define INTEL_PMC_IDX_FIXED_BTS				(INTEL_PMC_IDX_FIXED + 16)
> +#define INTEL_PMC_IDX_FIXED_BTS				(INTEL_PMC_IDX_FIXED + 15)
> +
> +/*
> + * We model PERF_METRICS as more magic fixed-mode PMCs, one for each metric
> + *
> + * Internally they all map to Fixed Ctr 3 (SLOTS), and allocate PERF_METRICS
> + * as an extra_reg. PERF_METRICS has no own configuration, but we fill in
> + * the configuration of FxCtr3 to enforce that all the shared users of SLOTS
> + * have the same configuration.
> + */
> +#define INTEL_PMC_IDX_FIXED_METRIC_BASE		(INTEL_PMC_IDX_FIXED + 16)
> +#define INTEL_PMC_IDX_TD_RETIRING		(INTEL_PMC_IDX_FIXED_METRIC_BASE + 0)
> +#define INTEL_PMC_IDX_TD_BAD_SPEC		(INTEL_PMC_IDX_FIXED_METRIC_BASE + 1)
> +#define INTEL_PMC_IDX_TD_FE_BOUND		(INTEL_PMC_IDX_FIXED_METRIC_BASE + 2)
> +#define INTEL_PMC_IDX_TD_BE_BOUND		(INTEL_PMC_IDX_FIXED_METRIC_BASE + 3)
> +#define INTEL_PMC_MSK_TOPDOWN			((0xfull << INTEL_PMC_IDX_FIXED_METRIC_BASE) | \
> +						 INTEL_PMC_MSK_FIXED_SLOTS)
> +
> +static inline bool is_metric_idx(int idx)
> +{
> +	return (unsigned)(idx - INTEL_PMC_IDX_FIXED_METRIC_BASE) < 4;
> +}
> +
> +static inline bool is_topdown_idx(int idx)
> +{
> +	return is_metric_idx(idx) || idx == INTEL_PMC_IDX_FIXED_SLOTS;
> +}
> +
> +#define INTEL_PMC_OTHER_TOPDOWN_BITS(bit)	(~(0x1ull << bit) & INTEL_PMC_MSK_TOPDOWN)
>   
>   #define GLOBAL_STATUS_COND_CHG				BIT_ULL(63)
>   #define GLOBAL_STATUS_BUFFER_OVF			BIT_ULL(62)
> 
