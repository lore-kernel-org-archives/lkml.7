Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB655C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0091208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfE1SXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 14:23:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:18639 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbfE1SXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 14:23:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 11:23:11 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 28 May 2019 11:23:11 -0700
Received: from [10.254.95.162] (kliang2-mobl.ccr.corp.intel.com [10.254.95.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 79E9C5802C9;
        Tue, 28 May 2019 11:23:10 -0700 (PDT)
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH 4/9] perf/x86/intel: Support hardware TopDown metrics
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
 <20190521214055.31060-5-kan.liang@linux.intel.com>
 <20190528124349.GU2606@hirez.programming.kicks-ass.net>
Message-ID: <287c2c84-25cf-fdce-a3c3-49a6ee93ae4c@linux.intel.com>
Date:   Tue, 28 May 2019 14:23:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528124349.GU2606@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/2019 8:43 AM, Peter Zijlstra wrote:
> On Tue, May 21, 2019 at 02:40:50PM -0700, kan.liang@linux.intel.com wrote:
>> The 8bit metrics ratio values lose precision when the measurement period
>> gets longer.
>>
>> To avoid this we always reset the metric value when reading, as we
>> already accumulate the count in the perf count value.
>>
>> For a long period read, low precision is acceptable.
>> For a short period read, the register will be reset often enough that it
>> is not a problem.
> 
>> The PERF_METRICS may report wrong value if its delta was less than 1/255
>> of SLOTS (Fixed counter 3).
>>
>> To avoid this, the PERF_METRICS and SLOTS registers have to be reset
>> simultaneously. The slots value has to be cached as well.
> 
> That doesn't sound like it is NMI-safe.
>  >
> 
>> RDPMC
>> =========
>> The TopDown can be collected per thread/process. To use TopDown
>> through RDPMC in applications on Icelake, the metrics and slots values
>> have to be saved/restored during context switching.
>>
>> Add specific set_period() to specially handle the slots and metrics
>> event. Because,
>>   - The initial value must be 0.
>>   - Only need to restore the value in context switch. For other cases,
>>     the counters have been cleared after read.
> 
> So the above claims to explain RDPMC, but doesn't mention that magic
> value below at all. In fact, I don't see how the above relates to RDPMC
> at all.

Current perf only support per-core Topdown RDPMC. On Icelake, it can be 
extended to per-thread Topdown RDPMC.
It tries to explain the extra work for per-thread topdown RDPMC, e.g. 
save/restore slots and metrics value in context switch.


> 
>> @@ -2141,7 +2157,9 @@ static int x86_pmu_event_idx(struct perf_event *event)
>>   	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
>>   		return 0;
>>   
>> -	if (x86_pmu.num_counters_fixed && idx >= INTEL_PMC_IDX_FIXED) {
>> +	if (is_metric_idx(idx))
>> +		idx = 1 << 29;
> 
> I can't find this in the SDM RDPMC description. What does it return?

It will return the value of PERF_METRICS. I will add it in the changelog.

Thanks,
Kan
> 
>> +	else if (x86_pmu.num_counters_fixed && idx >= INTEL_PMC_IDX_FIXED) {
>>   		idx -= INTEL_PMC_IDX_FIXED;
>>   		idx |= 1 << 30;
>>   	}
