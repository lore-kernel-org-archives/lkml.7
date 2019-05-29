Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F84C28CC1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A49423A9F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfE2OmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 10:42:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:36964 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfE2OmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 10:42:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 May 2019 07:42:11 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 29 May 2019 07:42:11 -0700
Received: from [10.251.0.80] (kliang2-mobl.ccr.corp.intel.com [10.251.0.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id F240A58054E;
        Wed, 29 May 2019 07:42:10 -0700 (PDT)
Subject: Re: [PATCH 4/9] perf/x86/intel: Support hardware TopDown metrics
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
 <20190521214055.31060-5-kan.liang@linux.intel.com>
 <20190528134354.GP2623@hirez.programming.kicks-ass.net>
 <561ec469-2e0b-4749-c184-d07e4f4eaf40@linux.intel.com>
 <20190529075426.GA2623@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <110d6e3e-9f50-ad47-5a12-1ccf0b756602@linux.intel.com>
Date:   Wed, 29 May 2019 10:42:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529075426.GA2623@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/29/2019 3:54 AM, Peter Zijlstra wrote:
> On Tue, May 28, 2019 at 02:24:38PM -0400, Liang, Kan wrote:
>>
>>
>> On 5/28/2019 9:43 AM, Peter Zijlstra wrote:
>>> On Tue, May 21, 2019 at 02:40:50PM -0700, kan.liang@linux.intel.com wrote:
>>>> @@ -3287,6 +3304,13 @@ static int core_pmu_hw_config(struct perf_event *event)
>>>>    	return intel_pmu_bts_config(event);
>>>>    }
>>>> +#define EVENT_CODE(e)	(e->attr.config & INTEL_ARCH_EVENT_MASK)
>>>> +#define is_slots_event(e)	(EVENT_CODE(e) == 0x0400)
>>>> +#define is_perf_metrics_event(e)				\
>>>> +		(((EVENT_CODE(e) & 0xff) == 0xff) &&		\
>>>> +		 (EVENT_CODE(e) >= 0x01ff) &&			\
>>>> +		 (EVENT_CODE(e) <= 0x04ff))
>>>> +
>>>
>>> That is horrific.. (e & INTEL_ARCH_EVENT_MASK) & 0xff is just daft,
>>> that should be: (e & ARCH_PERFMON_EVENTSEL_EVENT).
>>>
>>> Also, we already have fake events for event=0, see FIXED2, why are we
>>> now using event=0xff ?
>>
>> I think event=0 is for genuine fixed events. Metrics events are fake events.
>> I didn't find FIXED2 in the code. Could you please share more hints?
> 
> cd09c0c40a97 ("perf events: Enable raw event support for Intel unhalted_reference_cycles event")
> 
> We used the fake event=0x00, umask=0x03 for CPU_CLK_UNHALTED.REF_TSC,
> because that was not available as a generic event, *until now* it seems.
> I see ICL actually has it as a generic event, which means we need to fix
> up the constraint mask for that differently.
>

There is no change for REF_TSC on ICL.

> But note that for all previous uarchs this event did not in fact exist.
> 
> It appears the TOPDOWN.SLOTS thing, which is available in in FIXED3 is
> event=0x00, umask=0x04, is indeed a generic event too.

The SLOTS do have a generic event, TOPDOWN.SLOTS_P, event=0xA4, umask=0x1.

I think we need a fix as below for ICL, so the SLOT event can be 
extended to generic event.
-	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* SLOTS */
+	FIXED_EVENT_CONSTRAINT(0x01a4, 3),	/* TOPDOWN.SLOTS */

I will send a separate patch for it.

Thanks,
Kan
