Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796E3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530AF20879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbfCYUgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:36:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:48232 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729548AbfCYUgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:36:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 13:36:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,270,1549958400"; 
   d="scan'208";a="310336919"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 25 Mar 2019 13:35:59 -0700
Received: from [10.254.88.97] (kliang2-mobl.ccr.corp.intel.com [10.254.88.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 18CAE5804B4;
        Mon, 25 Mar 2019 13:35:59 -0700 (PDT)
Subject: Re: [PATCH V3 01/23] perf/x86: Support outputting XMM registers
To:     Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com
References: <20190322163718.2191-1-kan.liang@linux.intel.com>
 <20190322163718.2191-2-kan.liang@linux.intel.com>
 <20190322170841.GJ7905@worktop.programming.kicks-ass.net>
 <20190322172250.GF24002@tassilo.jf.intel.com>
 <20190323095610.GB6058@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <697d0b76-d08f-5fa4-d49a-c291ab0f57de@linux.intel.com>
Date:   Mon, 25 Mar 2019 16:35:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190323095610.GB6058@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/23/2019 5:56 AM, Peter Zijlstra wrote:
> On Fri, Mar 22, 2019 at 10:22:50AM -0700, Andi Kleen wrote:
>>>> diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
>>>> index f3329cabce5c..b33995313d17 100644
>>>> --- a/arch/x86/include/uapi/asm/perf_regs.h
>>>> +++ b/arch/x86/include/uapi/asm/perf_regs.h
>>>> @@ -28,7 +28,29 @@ enum perf_event_x86_regs {
>>>>   	PERF_REG_X86_R14,
>>>>   	PERF_REG_X86_R15,
>>>>   
>>>> -	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
>>>> -	PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
>>>
>>> So this changes UAPI visible symbols... did we think about that?
>>
>> Should be fine. Old programs won't use the new bits,
>> and it just uses not yet used bits.
> 
> Old programs (that used the above symbols) will now fail to compile.
> Even if they won't use the new bits, that seems like a bad thing.
>

Yes, other programs which use the PERF_REG_GPR_X86_32/64_MAX symbols 
should be broken.
I think the new name PERF_REG_GPR_X86_32/64_MAX are more accurate. So I 
will keep both names in V4, and add comments for the old names.

/*
  * These names are deprecated, please use new names as below to instead.
  *     PERF_REG_GPR_X86_32_MAX
  *     PERF_REG_GPR_X86_64_MAX
  */
PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,


>>>> +	/* These all need two bits set because they are 128bit */
>>>> +	PERF_REG_X86_XMM0  = 32,
>>>> +	PERF_REG_X86_XMM1  = 34,
>>>> +	PERF_REG_X86_XMM2  = 36,
>>>> +	PERF_REG_X86_XMM3  = 38,
>>>> +	PERF_REG_X86_XMM4  = 40,
>>>> +	PERF_REG_X86_XMM5  = 42,
>>>> +	PERF_REG_X86_XMM6  = 44,
>>>> +	PERF_REG_X86_XMM7  = 46,
>>>> +	PERF_REG_X86_XMM8  = 48,
>>>> +	PERF_REG_X86_XMM9  = 50,
>>>> +	PERF_REG_X86_XMM10 = 52,
>>>> +	PERF_REG_X86_XMM11 = 54,
>>>> +	PERF_REG_X86_XMM12 = 56,
>>>> +	PERF_REG_X86_XMM13 = 58,
>>>> +	PERF_REG_X86_XMM14 = 60,
>>>> +	PERF_REG_X86_XMM15 = 62,
>>>> +
>>>> +	/* This does not include the XMMX registers */
>>>> +	PERF_REG_GPR_X86_32_MAX = PERF_REG_X86_GS + 1,
>>>> +	PERF_REG_GPR_X86_64_MAX = PERF_REG_X86_R15 + 1,
>>>> +
>>>> +	/* All registers include the XMMX registers */
>>>> +	PERF_REG_X86_MAX = PERF_REG_X86_XMM15 + 2,
>>>>   };
>>>>   #endif /* _ASM_X86_PERF_REGS_H */
>>>
>>> Also, what happens if we run a 32bit kernel or 32bit compat task?
>>>
>>> Then the register dump will report PERF_SAMPLE_REGS_ABI_32, should we
>>> then still interpret the XMM registers as 2x64bit?
>>
>> Yes XMM registers are 128bit in 32bit mode too.
>>
>>>
>>> Are they still at the same offset?
>>
>> Yes.
> 
> I think that is broken.. perf_prepare_sample() does:
> 
>   size += hweight(mask) * sizeof(u64);

It does size += hweight64(mask) * sizeof(u64);

> 
> And since 32bits will not have r8-r15 set, the XMM registers will shift
> forward no?
>

I tried a 32bits kernel, but I didn't observe any issue.

The index of XMM registers always start from 32. That's hard coded.

To double check, I also dumped the mask value in perf_prepare_sample().
With command "perf record -e cycles:p -IXMM0,IXMM1 sleep 1", the mask
value is 0xf00000000, hweight64(mask) returns 4. That is expected.

Is there anything I missed?

>>> Do we need additional PERF_SAMPLE_REGS_ABI_* definitions for this?
>>
>> I don't think so.
> 
> because....?
> 

I didn't observe any broken on 32bit. I think we don't need ABI to 
distinguish the XMM registers.

Thanks,
Kan
