Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA1BC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FEE23A78
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfE2Omc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 10:42:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:21770 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfE2Omc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 10:42:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 May 2019 07:42:31 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 29 May 2019 07:42:31 -0700
Received: from [10.251.0.80] (kliang2-mobl.ccr.corp.intel.com [10.251.0.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 72BEE58054E;
        Wed, 29 May 2019 07:42:30 -0700 (PDT)
Subject: Re: [PATCH 4/9] perf/x86/intel: Support hardware TopDown metrics
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
 <20190521214055.31060-5-kan.liang@linux.intel.com>
 <20190528134845.GQ2623@hirez.programming.kicks-ass.net>
 <2d693635-9697-2cf5-54dc-b91da4dfd14f@linux.intel.com>
 <20190529075720.GB2623@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <09770caf-e717-5b11-d11f-f30cb027bb05@linux.intel.com>
Date:   Wed, 29 May 2019 10:42:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529075720.GB2623@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/29/2019 3:57 AM, Peter Zijlstra wrote:
> On Tue, May 28, 2019 at 02:24:56PM -0400, Liang, Kan wrote:
>>
>>
>> On 5/28/2019 9:48 AM, Peter Zijlstra wrote:
>>> On Tue, May 21, 2019 at 02:40:50PM -0700, kan.liang@linux.intel.com wrote:
>>>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>>>> index b980b9e95d2a..0d7081434d1d 100644
>>>> --- a/include/linux/perf_event.h
>>>> +++ b/include/linux/perf_event.h
>>>> @@ -133,6 +133,11 @@ struct hw_perf_event {
>>>>    			struct hw_perf_event_extra extra_reg;
>>>>    			struct hw_perf_event_extra branch_reg;
>>>> +
>>>> +			u64		saved_metric;
>>>> +			u64		saved_slots;
>>>> +			u64		last_slots;
>>>> +			u64		last_metric;
>>>
>>> This is really sad, and I'm thinking much of that really isn't needed
>>> anyway, due to how you're not using some of the other fields.
>>
>> If we don't cache the value, we have to update all metrics events when
>> reading any metrics event. I think that could bring high overhead.
> 
> Since you don't support sampling, or even 'normal' functionality on this
> FIXED3/SLOTS thing, you'll not use prev_count, sample_period,
> last_period, period_left, interrupts_seq, interrupts, freq_time_stamp
> and freq_count_stamp.
> 
> So why do you then need to grow the data structure with 4 more nonsense
> fields?
> 
> Also, I'm not sure what you need those last things for, you reset the
> value to 0 every time you read them, there is no delta to track.
> 

The 'last things' are only for per-thread Topdown RDPMC.
We have to save/restore slots and metrics value in context switch.
It's used to calculate the delta between thread shced in and current 
read/sched out.


I will split the patch into several patches, and try to make things clear.

Thanks,
Kan


