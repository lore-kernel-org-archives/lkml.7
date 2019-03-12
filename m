Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C34CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261C3214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfCLMgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:36:54 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:59430 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbfCLMgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:36:54 -0400
Received: from [192.168.108.8] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 24FC313F8B8;
        Tue, 12 Mar 2019 13:36:26 +0100 (CET)
Subject: Re: [PATCH] arm64/io: Don't use WZR in writel
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
References: <68b71c15f32341468a868f6418e4fcb375bc49ba.camel@gmail.com>
 <20190211105755.GB30880@fuggles.cambridge.arm.com>
 <38d8965a-cd41-17cf-1b95-8dd58c079be4@arm.com>
 <874c702b8af760aa8fae38d478c79e3ecba00515.camel@gmail.com>
 <235d20ef-3054-69d9-975d-25aebf32aad3@arm.com>
 <20190223181254.GC572@tuxbook-pro> <86zhqm8i6d.wl-marc.zyngier@arm.com>
 <20190224035356.GD572@tuxbook-pro>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <33d765b5-1807-fa6c-1ceb-99f09f7c8d5a@free.fr>
Date:   Tue, 12 Mar 2019 13:36:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190224035356.GD572@tuxbook-pro>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2019 04:53, Bjorn Andersson wrote:

> On Sat 23 Feb 10:37 PST 2019, Marc Zyngier wrote:
> 
>> On Sat, 23 Feb 2019 18:12:54 +0000, Bjorn Andersson wrote:
>>>
>>> On Mon 11 Feb 06:59 PST 2019, Marc Zyngier wrote:
>>>
>>>> On 11/02/2019 14:29, AngeloGioacchino Del Regno wrote:
>>>>
>>>>> Also, just one more thing: yes this thing is going ARM64-wide and
>>>>> - from my findings - it's targeting certain Qualcomm SoCs, but...
>>>>> I'm not sure that only QC is affected by that, others may as well
>>>>> have the same stupid bug.
>>>>
>>>> At the moment, only QC SoCs seem to be affected, probably because
>>>> everyone else has debugged their hypervisor (or most likely doesn't
>>>> bother with shipping one).
>>>>
>>>> In all honesty, we need some information from QC here: which SoCs are
>>>> affected, what is the exact nature of the bug, can it be triggered from
>>>> EL0. Randomly papering over symptoms is not something I really like
>>>> doing, and is likely to generate problems on unaffected systems.
>>>
>>> The bug at hand is that the XZR is not deemed a valid source in the
>>> virtualization of the SMMU registers. It was identified and fixed for
>>> all platforms that are shipping kernels based on v4.9 or later.
>>
>> When you say "fixed": Do you mean fixed in the firmware? Or by adding
>> a workaround in the shipped kernel?
> 
> I mean that it's fixed in the firmware.
> 
>> If the former, is this part of an official QC statement, with an
>> associated erratum number?
> 
> I don't know, will get back to you on this one.
> 
>> Is this really limited to the SMMU accesses?
> 
> Yes.
> 
>>> As such Angelo's list of affected platforms covers the high-profile
>>> ones. In particular MSM8996 and MSM8998 is getting pretty good support
>>> upstream, if we can figure out a way around this issue.
>> 
>> We'd need an exhaustive list of the affected SoCs, and work out if we
>> can limit the hack to the SMMU driver (cc'ing Robin, who's the one
>> who'd know about it).
> 
> I will try to compose a list.

FWIW, I have just been bitten by this issue. I needed to enable an SMMU to
filter PCIe EP accesses to system RAM (or something). I'm using an APQ8098
MEDIABOX dev board. My system hangs in arm_smmu_device_reset() doing:

	/* Invalidate the TLB, just in case */
	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLH);
	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);


With the 'Z' constraint, gcc generates:

	str wzr, [x0]

without the 'Z' constraint, gcc generates:

	mov	w1, 0
	str w1, [x0]


I can work around the problem using the following patch:

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 045d93884164..93117519aed8 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -59,6 +59,11 @@
 
 #include "arm-smmu-regs.h"
 
+static inline void qcom_writel(u32 val, volatile void __iomem *addr)
+{
+	asm volatile("str %w0, [%1]" : : "r" (val), "r" (addr));
+}
+
 #define ARM_MMU500_ACTLR_CPRE		(1 << 1)
 
 #define ARM_MMU500_ACR_CACHE_LOCK	(1 << 26)
@@ -422,7 +427,7 @@ static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu,
 {
 	unsigned int spin_cnt, delay;
 
-	writel_relaxed(0, sync);
+	qcom_writel(0, sync);
 	for (delay = 1; delay < TLB_LOOP_TIMEOUT; delay *= 2) {
 		for (spin_cnt = TLB_SPIN_COUNT; spin_cnt > 0; spin_cnt--) {
 			if (!(readl_relaxed(status) & sTLBGSTATUS_GSACTIVE))
@@ -1760,8 +1765,8 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	}
 
 	/* Invalidate the TLB, just in case */
-	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLH);
-	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);
+	qcom_writel(0, gr0_base + ARM_SMMU_GR0_TLBIALLH);
+	qcom_writel(0, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);
 
 	reg = readl_relaxed(ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
 



Can a quirk be used to work around the issue?
Or can we just "pessimize" the 3 writes for everybody?
(Might be cheaper than a test anyway)

Regards.
