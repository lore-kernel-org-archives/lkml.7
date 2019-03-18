Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D0FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65EE20854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfCRRYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:24:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38478 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfCRRYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:24:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 746941650;
        Mon, 18 Mar 2019 10:24:20 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 815683F614;
        Mon, 18 Mar 2019 10:24:18 -0700 (PDT)
Subject: Re: [PATCH] arm64/io: Don't use WZR in writel
From:   Robin Murphy <robin.murphy@arm.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <68b71c15f32341468a868f6418e4fcb375bc49ba.camel@gmail.com>
 <20190211105755.GB30880@fuggles.cambridge.arm.com>
 <38d8965a-cd41-17cf-1b95-8dd58c079be4@arm.com>
 <874c702b8af760aa8fae38d478c79e3ecba00515.camel@gmail.com>
 <235d20ef-3054-69d9-975d-25aebf32aad3@arm.com>
 <20190223181254.GC572@tuxbook-pro> <86zhqm8i6d.wl-marc.zyngier@arm.com>
 <20190224035356.GD572@tuxbook-pro>
 <33d765b5-1807-fa6c-1ceb-99f09f7c8d5a@free.fr>
 <8eb4f446-6152-ffb6-9529-77fb0bcc307f@arm.com>
 <20190318170041.qu4x2565fmno6sei@shell.armlinux.org.uk>
 <5ba7c4d0-30ec-e38d-41dc-653fd5cb7f05@arm.com>
Message-ID: <2a7098cb-5f36-d0ab-4f74-ac6e4ab7e0fd@arm.com>
Date:   Mon, 18 Mar 2019 17:24:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <5ba7c4d0-30ec-e38d-41dc-653fd5cb7f05@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2019 17:19, Robin Murphy wrote:
> On 18/03/2019 17:00, Russell King - ARM Linux admin wrote:
>> On Mon, Mar 18, 2019 at 04:04:03PM +0000, Robin Murphy wrote:
>>> On 12/03/2019 12:36, Marc Gonzalez wrote:
>>>> On 24/02/2019 04:53, Bjorn Andersson wrote:
>>>>
>>>>> On Sat 23 Feb 10:37 PST 2019, Marc Zyngier wrote:
>>>>>
>>>>>> On Sat, 23 Feb 2019 18:12:54 +0000, Bjorn Andersson wrote:
>>>>>>>
>>>>>>> On Mon 11 Feb 06:59 PST 2019, Marc Zyngier wrote:
>>>>>>>
>>>>>>>> On 11/02/2019 14:29, AngeloGioacchino Del Regno wrote:
>>>>>>>>
>>>>>>>>> Also, just one more thing: yes this thing is going ARM64-wide and
>>>>>>>>> - from my findings - it's targeting certain Qualcomm SoCs, but...
>>>>>>>>> I'm not sure that only QC is affected by that, others may as well
>>>>>>>>> have the same stupid bug.
>>>>>>>>
>>>>>>>> At the moment, only QC SoCs seem to be affected, probably because
>>>>>>>> everyone else has debugged their hypervisor (or most likely doesn't
>>>>>>>> bother with shipping one).
>>>>>>>>
>>>>>>>> In all honesty, we need some information from QC here: which 
>>>>>>>> SoCs are
>>>>>>>> affected, what is the exact nature of the bug, can it be 
>>>>>>>> triggered from
>>>>>>>> EL0. Randomly papering over symptoms is not something I really like
>>>>>>>> doing, and is likely to generate problems on unaffected systems.
>>>>>>>
>>>>>>> The bug at hand is that the XZR is not deemed a valid source in the
>>>>>>> virtualization of the SMMU registers. It was identified and fixed 
>>>>>>> for
>>>>>>> all platforms that are shipping kernels based on v4.9 or later.
>>>>>>
>>>>>> When you say "fixed": Do you mean fixed in the firmware? Or by adding
>>>>>> a workaround in the shipped kernel?
>>>>>
>>>>> I mean that it's fixed in the firmware.
>>>>>
>>>>>> If the former, is this part of an official QC statement, with an
>>>>>> associated erratum number?
>>>>>
>>>>> I don't know, will get back to you on this one.
>>>>>
>>>>>> Is this really limited to the SMMU accesses?
>>>>>
>>>>> Yes.
>>>>>
>>>>>>> As such Angelo's list of affected platforms covers the high-profile
>>>>>>> ones. In particular MSM8996 and MSM8998 is getting pretty good 
>>>>>>> support
>>>>>>> upstream, if we can figure out a way around this issue.
>>>>>>
>>>>>> We'd need an exhaustive list of the affected SoCs, and work out if we
>>>>>> can limit the hack to the SMMU driver (cc'ing Robin, who's the one
>>>>>> who'd know about it).
>>>>>
>>>>> I will try to compose a list.
>>>>
>>>> FWIW, I have just been bitten by this issue. I needed to enable an 
>>>> SMMU to
>>>> filter PCIe EP accesses to system RAM (or something). I'm using an 
>>>> APQ8098
>>>> MEDIABOX dev board. My system hangs in arm_smmu_device_reset() doing:
>>>>
>>>>     /* Invalidate the TLB, just in case */
>>>>     writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLH);
>>>>     writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);
>>>>
>>>>
>>>> With the 'Z' constraint, gcc generates:
>>>>
>>>>     str wzr, [x0]
>>>>
>>>> without the 'Z' constraint, gcc generates:
>>>>
>>>>     mov    w1, 0
>>>>     str w1, [x0]
>>>>
>>>>
>>>> I can work around the problem using the following patch:
>>>>
>>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>>> index 045d93884164..93117519aed8 100644
>>>> --- a/drivers/iommu/arm-smmu.c
>>>> +++ b/drivers/iommu/arm-smmu.c
>>>> @@ -59,6 +59,11 @@
>>>>    #include "arm-smmu-regs.h"
>>>> +static inline void qcom_writel(u32 val, volatile void __iomem *addr)
>>>> +{
>>>> +    asm volatile("str %w0, [%1]" : : "r" (val), "r" (addr));
>>>> +}
>>>> +
>>>>    #define ARM_MMU500_ACTLR_CPRE        (1 << 1)
>>>>    #define ARM_MMU500_ACR_CACHE_LOCK    (1 << 26)
>>>> @@ -422,7 +427,7 @@ static void __arm_smmu_tlb_sync(struct 
>>>> arm_smmu_device *smmu,
>>>>    {
>>>>        unsigned int spin_cnt, delay;
>>>> -    writel_relaxed(0, sync);
>>>> +    qcom_writel(0, sync);
>>>>        for (delay = 1; delay < TLB_LOOP_TIMEOUT; delay *= 2) {
>>>>            for (spin_cnt = TLB_SPIN_COUNT; spin_cnt > 0; spin_cnt--) {
>>>>                if (!(readl_relaxed(status) & sTLBGSTATUS_GSACTIVE))
>>>> @@ -1760,8 +1765,8 @@ static void arm_smmu_device_reset(struct 
>>>> arm_smmu_device *smmu)
>>>>        }
>>>>        /* Invalidate the TLB, just in case */
>>>> -    writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLH);
>>>> -    writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);
>>>> +    qcom_writel(0, gr0_base + ARM_SMMU_GR0_TLBIALLH);
>>>> +    qcom_writel(0, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);
>>>>        reg = readl_relaxed(ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
>>>>
>>>>
>>>>
>>>> Can a quirk be used to work around the issue?
>>>> Or can we just "pessimize" the 3 writes for everybody?
>>>> (Might be cheaper than a test anyway)
>>>
>>> If it really is just the SMMU driver which is affected, we can work 
>>> around
>>> it for free (not counting the 'cost' of slightly-weird-looking code, of
>>> course). If the diff below works as expected, I'll write it up properly.
>>>
>>> Robin.
>>> ----->8-----
>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>> index 045d93884164..7ff29e33298f 100644
>>> --- a/drivers/iommu/arm-smmu.c
>>> +++ b/drivers/iommu/arm-smmu.c
>>> @@ -422,7 +422,7 @@ static void __arm_smmu_tlb_sync(struct 
>>> arm_smmu_device
>>> *smmu,
>>>   {
>>>       unsigned int spin_cnt, delay;
>>>
>>> -    writel_relaxed(0, sync);
>>> +    writel_relaxed((unsigned long)sync, sync);
>>>       for (delay = 1; delay < TLB_LOOP_TIMEOUT; delay *= 2) {
>>>           for (spin_cnt = TLB_SPIN_COUNT; spin_cnt > 0; spin_cnt--) {
>>>               if (!(readl_relaxed(status) & sTLBGSTATUS_GSACTIVE))
>>> @@ -681,7 +681,12 @@ static void arm_smmu_write_context_bank(struct
>>> arm_smmu_device *smmu, int idx)
>>>
>>>       /* Unassigned context banks only need disabling */
>>>       if (!cfg) {
>>> -        writel_relaxed(0, cb_base + ARM_SMMU_CB_SCTLR);
>>> +        /*
>>> +         * For Qualcomm reasons, we want to guarantee that we write a
>>> +         * zero from a register which is not WZR. Fortunately, the cfg
>>> +         * logic here plays right into our hands...
>>> +         */
>>> +        writel_relaxed((unsigned long)cfg, cb_base + 
>>> ARM_SMMU_CB_SCTLR);
>>>           return;
>>>       }
>>>
>>> @@ -1760,8 +1765,8 @@ static void arm_smmu_device_reset(struct
>>> arm_smmu_device *smmu)
>>>       }
>>>
>>>       /* Invalidate the TLB, just in case */
>>> -    writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLH);
>>> -    writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);
>>> +    writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_TLBIALLH);
>>> +    writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);
>>>
>>>       reg = readl_relaxed(ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
>>>
>>
>> Given what we've seen from Clang for futex stuff in 32-bit ARM, are
>> you really sure that the above will not result in Clang still spotting
>> that the value is zero and using a wzr for all these cases?
> 
> The trick is that in the write-only TLBI cases the variable we're 
> passing in really is nonzero, so that can't possibly happen. For the 
> context bank reset, yes, I am assuming that no complier will ever be 
> perverse enough to detect that cfg is not written after the NULL check 
> and immediately reallocate it to XZR for no good reason. I'd like to 
> think that assumption is going to hold for the reasonable scope of this 
> particular workaround, though.

Well, crap. So much for that hubris...


00000000000000f0 <arm_smmu_write_context_bank>:
       f0:       52800504        mov     w4, #0x28 
// #40
       f4:       f940240a        ldr     x10, [x0,#72]
       f8:       a9411402        ldp     x2, x5, [x0,#16]
       fc:       9b247c24        smull   x4, w1, w4
      100:       8b040148        add     x8, x10, x4
      104:       1ac52023        lsl     w3, w1, w5
      108:       8b23c042        add     x2, x2, w3, sxtw
      10c:       f9401107        ldr     x7, [x8,#32]
      110:       b5000067        cbnz    x7, 11c 
<arm_smmu_write_context_bank+0x2c>
      114:       b900005f        str     wzr, [x2]


Time to come up with a better SCTLR reset value, I guess.

Robin.
