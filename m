Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773D5C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54CF32064A
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfH1N7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:59:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:26741 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbfH1N7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:59:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 06:59:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,441,1559545200"; 
   d="scan'208";a="332168480"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 28 Aug 2019 06:59:04 -0700
Received: from [10.254.95.196] (kliang2-mobl.ccr.corp.intel.com [10.254.95.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 663C3580409;
        Wed, 28 Aug 2019 06:59:03 -0700 (PDT)
Subject: Re: [RESEND PATCH V3 2/8] perf/x86/intel: Basic support for metrics
 counters
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20190826144740.10163-1-kan.liang@linux.intel.com>
 <20190826144740.10163-3-kan.liang@linux.intel.com>
 <20190828075213.GB2369@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <ae6e095a-d041-4cde-b9e1-fd950160abfd@linux.intel.com>
Date:   Wed, 28 Aug 2019 09:59:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828075213.GB2369@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/2019 3:52 AM, Peter Zijlstra wrote:
> On Mon, Aug 26, 2019 at 07:47:34AM -0700, kan.liang@linux.intel.com wrote:
> 
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 81b005e4c7d9..54534ff00940 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -1033,18 +1033,30 @@ static inline void x86_assign_hw_event(struct perf_event *event,
>>   				struct cpu_hw_events *cpuc, int i)
>>   {
>>   	struct hw_perf_event *hwc = &event->hw;
>> +	int reg_idx;
>>   
>>   	hwc->idx = cpuc->assign[i];
>>   	hwc->last_cpu = smp_processor_id();
>>   	hwc->last_tag = ++cpuc->tags[i];
>>   
>> +	/*
>> +	 * Metrics counters use different indexes in the scheduler
>> +	 * versus the hardware.
>> +	 *
>> +	 * Map metrics to fixed counter 3 (which is the base count),
>> +	 * but the update event callback reads the extra metric register
>> +	 * and converts to the right metric.
>> +	 */
>> +	reg_idx = get_reg_idx(hwc->idx);
>> +
>>   	if (hwc->idx == INTEL_PMC_IDX_FIXED_BTS) {
>>   		hwc->config_base = 0;
>>   		hwc->event_base	= 0;
>>   	} else if (hwc->idx >= INTEL_PMC_IDX_FIXED) {
>>   		hwc->config_base = MSR_ARCH_PERFMON_FIXED_CTR_CTRL;
>> -		hwc->event_base = MSR_ARCH_PERFMON_FIXED_CTR0 + (hwc->idx - INTEL_PMC_IDX_FIXED);
>> -		hwc->event_base_rdpmc = (hwc->idx - INTEL_PMC_IDX_FIXED) | 1<<30;
>> +		hwc->event_base = MSR_ARCH_PERFMON_FIXED_CTR0 +
>> +				  (reg_idx - INTEL_PMC_IDX_FIXED);
>> +		hwc->event_base_rdpmc = (reg_idx - INTEL_PMC_IDX_FIXED) | 1<<30;
>>   	} else {
>>   		hwc->config_base = x86_pmu_config_addr(hwc->idx);
>>   		hwc->event_base  = x86_pmu_event_addr(hwc->idx);
> 
> That reg_idx is a pointless unconditional branch; better to write it
> like:
> 
> static inline void x86_assign_hw_event(struct perf_event *event,
> 				struct cpu_hw_events *cpuc, int i)
> {
> 	struct hw_perf_event *hwc = &event->hw;
> 	int idx;
> 
> 	idx = hwc->idx = cpuc->assign[i];
> 	hwc->last_cpu = smp_processor_id();
> 	hwc->last_tag = ++cpuc->tags[i];
> 
> 	switch (hwc->idx) {
> 	case INTEL_PMC_IDX_FIXED_BTS:
> 		hwc->config_base = 0;
> 		hwc->event_base	= 0;
> 		break;
> 
> 	case INTEL_PMC_IDX_FIXED_METRIC_BASE ... INTEL_PMC_IDX_FIXED_METRIC_BASE+3:
> 		/* All METRIC events are mapped onto the fixed SLOTS counter */
> 		idx = INTEL_PMC_IDX_FIXED_SLOTS;
> 
> 	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_METRIC_BASE-1:
> 		hwc->config_base = MSR_ARCH_PERFMON_FIXED_CTR_CTRL;
> 		hwc->event_base = MSR_ARCH_PERFMON_FIXED_CTR0 +
> 				  (idx - INTEL_PMC_IDX_FIXED);
> 		hwc->event_base_rdpmc = (idx - INTEL_PMC_IDX_FIXED) | 1<<30;
> 		break;
> 
> 	default:
> 		hwc->config_base = x86_pmu_config_addr(hwc->idx);
> 		hwc->event_base = x86_pmu_event_addr(hwc->idx);
> 		hwc->event_base_rdpmc = x86_pmu_rdpmc_index(hwc->idx);
> 		break;
> 	}
> }
> 
> On that; wth does this to the RDPMC userspace support!? Does that even
> work with these counters?
> 

The event_base_rdpmc is only for kernel usage now.
But it seems we can update x86_pmu_event_idx() to use it as well.

Thanks,
Kan


