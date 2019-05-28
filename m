Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EB4C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEC4208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfE1SWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 14:22:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:16814 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728007AbfE1SWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 14:22:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 11:22:34 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 28 May 2019 11:22:33 -0700
Received: from [10.254.95.162] (kliang2-mobl.ccr.corp.intel.com [10.254.95.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 189B95802C9;
        Tue, 28 May 2019 11:22:33 -0700 (PDT)
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH 3/9] perf/x86/intel: Support overflows on SLOTS
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
 <20190521214055.31060-4-kan.liang@linux.intel.com>
 <20190528122029.GT2606@hirez.programming.kicks-ass.net>
Message-ID: <364b3af4-3bef-b669-a38e-f40dbe5d34c4@linux.intel.com>
Date:   Tue, 28 May 2019 14:22:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528122029.GT2606@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/2019 8:20 AM, Peter Zijlstra wrote:
> On Tue, May 21, 2019 at 02:40:49PM -0700, kan.liang@linux.intel.com wrote:
>> From: Andi Kleen <ak@linux.intel.com>
>>
>> The internal counters used for the metrics can overflow. If this happens
>> an overflow is triggered on the SLOTS fixed counter. Add special code
>> that resets all the slave metric counters in this case.
> 
> The SDM also talked about a OVF_PERF_METRICS overflow bit. Which seems
> to suggest something else.

Yes, I think we should handle the bit as well and only update metrics event.

It looks like bit 48 is occupied by INTEL_PMC_IDX_FIXED_BTS.
I will also change
INTEL_PMC_IDX_FIXED_BTS to INTEL_PMC_IDX_FIXED + 15.
INTEL_PMC_IDX_FIXED_METRIC_BASE to INTEL_PMC_IDX_FIXED + 16

Thanks,
Kan

> 
>> Signed-off-by: Andi Kleen <ak@linux.intel.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   arch/x86/events/intel/core.c | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 75ed91a36413..a66dc761f09d 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -2279,12 +2279,35 @@ static void intel_pmu_add_event(struct perf_event *event)
>>   		intel_pmu_lbr_add(event);
>>   }
>>   
>> +/* When SLOTS overflowed update all the active topdown-* events */
>> +static void intel_pmu_update_metrics(struct perf_event *event)
>> +{
>> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> +	int idx;
>> +	u64 slots_events;
>> +
>> +	slots_events = *(u64 *)cpuc->enabled_events & INTEL_PMC_MSK_ANY_SLOTS;
>> +
>> +	for_each_set_bit(idx, (unsigned long *)&slots_events, 64) {
> 
> 	for (idx = INTEL_PMC_IDX_TD_RETIRING;
> 	     idx <= INTEL_PMC_IDX_TD_BE_BOUND; idx++)
> 
> perhaps?
> 
>> +		struct perf_event *ev = cpuc->events[idx];
>> +
>> +		if (ev == event)
>> +			continue;
>> +		x86_perf_event_update(event);
> 
> 		if (ev != event)
> 			x86_perf_event_update(event)
>> +	}
>> +}
>> +
>>   /*
>>    * Save and restart an expired event. Called by NMI contexts,
>>    * so it has to be careful about preempting normal event ops:
>>    */
>>   int intel_pmu_save_and_restart(struct perf_event *event)
>>   {
>> +	struct hw_perf_event *hwc = &event->hw;
>> +
>> +	if (unlikely(hwc->reg_idx == INTEL_PMC_IDX_FIXED_SLOTS))
>> +		intel_pmu_update_metrics(event);
>> +
>>   	x86_perf_event_update(event);
>>   	/*
>>   	 * For a checkpointed counter always reset back to 0.  This
>> -- 
>> 2.14.5
>>
