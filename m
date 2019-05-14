Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88B8C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45592147A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfENNJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 09:09:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55942 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfENNJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 09:09:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92095341;
        Tue, 14 May 2019 06:09:02 -0700 (PDT)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01A013F6C4;
        Tue, 14 May 2019 06:08:57 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] arm64: Fix incorrect irqflag restore for priority
 masking
To:     Robin Murphy <robin.murphy@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     mark.rutland@arm.com, Suzuki K Pouloze <suzuki.poulose@arm.com>,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        Christoffer Dall <christoffer.dall@arm.com>,
        james.morse@arm.com, Oleg Nesterov <oleg@redhat.com>,
        yuzenghui@huawei.com, wanghaibin.wang@huawei.com,
        liwei391@huawei.com
References: <1556553607-46531-1-git-send-email-julien.thierry@arm.com>
 <1556553607-46531-4-git-send-email-julien.thierry@arm.com>
 <2b023ba4-b95b-f823-4635-6a75deef5386@arm.com>
 <1739c8ac-9073-798f-ed0b-0dc617c195d6@arm.com>
 <5e8a85f5-c837-3ce8-5830-f3ae7897e326@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <0a0dfd57-af99-f603-a56f-ee05f5c7b98a@arm.com>
Date:   Tue, 14 May 2019 14:08:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5e8a85f5-c837-3ce8-5830-f3ae7897e326@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/05/2019 13:01, Robin Murphy wrote:
> On 14/05/2019 10:25, Julien Thierry wrote:
> [...]
>>>> +static inline int arch_irqs_disabled_flags(unsigned long flags)
>>>> +{
>>>> +    int res;
>>>> +
>>>> +    asm volatile(ALTERNATIVE(
>>>> +        "and    %w0, %w1, #" __stringify(PSR_I_BIT) "\n"
>>>> +        "nop",
>>>> +        "cmp    %w1, #" __stringify(GIC_PRIO_IRQON) "\n"
>>>> +        "cset    %w0, ne",
>>>> +        ARM64_HAS_IRQ_PRIO_MASKING)
>>>> +        : "=&r" (res)
>>>> +        : "r" ((int) flags)
>>>> +        : "memory");
>>>
>>> I wonder if this should have "cc" as part of the clobber list.
>>
>> Is there any special semantic to "cc" on arm64? All I can find is that
>> in the general case it indicates that it is modifying the "flags"
>> register.
>>
>> Is your suggestion only for the PMR case? Or is it something that we
>> should add regardless of PMR?
>> The latter makes sense to me, but for the former, I fail to understand
>> why this should affect only PMR.
> 
> The PMR case really ought to have have a cc clobber, because who knows
> what this may end up inlined into, and compilers can get pretty
> aggressive with instruction scheduling in ways which leave a live value
> in CPSR across sizeable chunks of other code. It's true that the non-PMR
> case doesn't need it, but the surrounding code still needs to be
> generated to accommodate both possible versions of the alternative. From
> the look of the rest of the patch, the existing pseudo-NMI code has this
> bug in a few places.
> 
> Technically you could omit it when ARM64_PSEUDO_NMI is configured out
> entirely, but at that point you may as well omit the whole alternative
> as well. It's probably not worth the bother unless it proves to have a
> significant impact on codegen overall. On which note the memory clobber
> also seems superfluous either way :/
> 

Right, I see. I misunderstood what was meant by "cc" indicating that the
assembly modified the flags.

Due to the context I interpreted it as irqflags whereas it concerns the
condition flags (hence the 'c' I presume...). It all makes more sense now.

> That said, now that I've been looking at it for this long, if the aim is
> just to create a zero/nonzero value then couldn't the PMR case just be
> "eor %w0, %w1, #GIC_PRIO_IRQON" and avoid the need for clobbers at all?
> 

Yes, definitely seems like it would be better! I'll take that
suggestion, thanks.

Cheers,

-- 
Julien Thierry
