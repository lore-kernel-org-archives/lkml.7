Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70049C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE2820828
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfH2Q4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 12:56:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:48471 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727922AbfH2Q4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:56:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 09:56:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,444,1559545200"; 
   d="scan'208";a="356509376"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 29 Aug 2019 09:56:05 -0700
Received: from [10.251.1.23] (kliang2-mobl.ccr.corp.intel.com [10.251.1.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 2A6B558046E;
        Thu, 29 Aug 2019 09:56:04 -0700 (PDT)
Subject: Re: [RESEND PATCH V3 3/8] perf/x86/intel: Support hardware TopDown
 metrics
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20190826144740.10163-1-kan.liang@linux.intel.com>
 <20190826144740.10163-4-kan.liang@linux.intel.com>
 <20190828151921.GD17205@worktop.programming.kicks-ass.net>
 <fd95a255-4499-2907-8af9-d340f157da68@linux.intel.com>
 <20190829135256.GW2369@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <cc2ee16d-b10f-a31e-7411-320e90413ceb@linux.intel.com>
Date:   Thu, 29 Aug 2019 12:56:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829135256.GW2369@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/29/2019 9:52 AM, Peter Zijlstra wrote:
> On Thu, Aug 29, 2019 at 09:31:37AM -0400, Liang, Kan wrote:
>> On 8/28/2019 11:19 AM, Peter Zijlstra wrote:
>>>> +static int icl_set_topdown_event_period(struct perf_event *event)
>>>> +{
>>>> +	struct hw_perf_event *hwc = &event->hw;
>>>> +	s64 left = local64_read(&hwc->period_left);
>>>> +
>>>> +	/*
>>>> +	 * Clear PERF_METRICS and Fixed counter 3 in initialization.
>>>> +	 * After that, both MSRs will be cleared for each read.
>>>> +	 * Don't need to clear them again.
>>>> +	 */
>>>> +	if (left == x86_pmu.max_period) {
>>>> +		wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
>>>> +		wrmsrl(MSR_PERF_METRICS, 0);
>>>> +		local64_set(&hwc->period_left, 0);
>>>> +	}
>>> This really doesn't make sense to me; if you set FIXED_CTR3 := 0, you'll
>>> never trigger the overflow there; this then seems to suggest the actual
>>> counter value is irrelevant. Therefore you don't actually need this.
>>>
>>
>> Could you please elaborate on why initialization to 0 never triggers an
>> overflow?
> 
> Well, 'never' as in a 'long' time.
> 
>> As of my understanding, initialization to 0 only means that it will take
>> more time than initialization to -max_period (0x8000 0000 0001) to trigger
>> an overflow.
> 
> Only twice as long. And why do we care about that?
> 
> The problem with it is though that you get the overflow at the end of
> the whole period, instead of halfway through, so reconstruction is
> trickier.
> 
>> Maybe 0 is too tricky. We can set the initial value to 1.
> 
> That's even worse. I'm still not understanding why we can't use the
> normal code.
> 
>> I think the bottom line is that we need a small initial value for FIXED_CTR3
>> here.
> 
> But why?!
> 
>> PERF_METRICS reports an 8bit integer fraction which is something like 0xff *
>> internal counters / FIXCTR3.
>> The internal counters only start counting from 0. (SW cannot set an
>> arbitrary initial value for internal counters.)
>> If the initial value of FIXED_CTR3 is too big, PERF_METRICS could always
>> remain constant, e.g. 0.
> 
> What what? The PERF_METRICS contents depends on the FIXCTR3 value ?!

Yes.

For current implementation, PERF_METRIC MSR is composed by four fields, 
backend bound, frontend bound, bad speculation and retiring.
Each of the fields are populated using the below formula for eg:
PERF_METRIC[RETIRING] = (0xFF * 
PERF_METRICS_RETIRING_INTERNAL_48bit_COUNTER)
/ FIXCTR3

The METRICS_OVF indicates the overflow of any internal counters.

The internal counters only start counting from 0, which cannot be 
programmed by SW. But resetting the PERF_METRIC would implicitly 
resetting the internal counters.

Thanks,
Kan


> That's bloody insane. /me goes find the SDM. The SDM is bloody useless
> :-(.
> 
> Please give a complete and coherent description of all of this. I can't
> very well review any of this until I know how the hardware works, now
> can I.
> 
> In this write-up, include the exact condition for METRICS_OVF (the SDM
> states: 'it indicates that PERF_METRIC counter has overflowed', which is
> gramatically incorrect and makes no sense even with the missing article
> injected).
>




