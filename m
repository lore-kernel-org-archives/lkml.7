Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E2BC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21BF217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfDKN3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:29:55 -0400
Received: from mga18.intel.com ([134.134.136.126]:5586 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbfDKN3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:29:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Apr 2019 06:29:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,337,1549958400"; 
   d="scan'208";a="141880086"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 11 Apr 2019 06:29:54 -0700
Received: from [10.254.82.195] (kliang2-mobl.ccr.corp.intel.com [10.254.82.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id D64F358044F;
        Thu, 11 Apr 2019 06:29:48 -0700 (PDT)
Subject: Re: [PATCH V5 08/12] perf/x86/intel: Add Icelake support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20190402194509.2832-1-kan.liang@linux.intel.com>
 <20190402194509.2832-9-kan.liang@linux.intel.com>
 <20190408150654.GV12232@hirez.programming.kicks-ass.net>
 <4ff8fec9-fb41-b11d-b7ed-4c716b558adc@linux.intel.com>
 <688804aa-b6eb-0f19-828c-99b901bbe554@linux.intel.com>
 <20190410194720.GC11158@hirez.programming.kicks-ass.net>
 <20190411090056.GK14281@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <5a5dad0d-7e79-05f0-86eb-4c306c31f0ba@linux.intel.com>
Date:   Thu, 11 Apr 2019 09:29:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411090056.GK14281@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/2019 5:00 AM, Peter Zijlstra wrote:
> On Wed, Apr 10, 2019 at 09:47:20PM +0200, Peter Zijlstra wrote:
>> Sure, those are actually forced 0 with the existing thing.
>>
>> I'll go fold smething like back in. Thanks!
> 
>>> @@ -3472,7 +3475,7 @@ icl_get_event_constraints(struct cpu_hw_events *cpuc,
>>> int idx,
>>>   	 * Force instruction:ppp in Fixed counter 0
>>>   	 */
>>>   	if ((event->attr.precise_ip == 3) &&
>>> -	    (event->hw.config == X86_CONFIG(.event=0xc0)))
>>> +	    (EVENT_CONFIG(event->hw.config) == X86_CONFIG(.event=0xc0)))
>>>   		return &fixed_counter0_constraint;
>>>
>>>   	return hsw_get_event_constraints(cpuc, idx, event);
> 
> Staring at that I came up with the below; how does that look?
>

Yes, it looks better.

Thanks,
Kan

> Note: FIXED_EVENT_CONSTRAINT(0x00c0, 0) has FIXED_EVENT_FLAGS for
> ->cmask and includes the correct event code.
> 
> ---
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3433,7 +3433,7 @@ icl_get_event_constraints(struct cpu_hw_
>   	 * Force instruction:ppp in Fixed counter 0
>   	 */
>   	if ((event->attr.precise_ip == 3) &&
> -	    (event->hw.config == X86_CONFIG(.event=0xc0)))
> +	    constraint_match(&fixed_counter0_constraint, event->hw.config))
>   		return &fixed_counter0_constraint;
>   
>   	return hsw_get_event_constraints(cpuc, idx, event);
> 
