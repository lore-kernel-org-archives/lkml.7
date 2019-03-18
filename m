Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6CBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2281B205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JlpOjzdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfCRRA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:00:56 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:55844 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfCRRA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=p91FsRQXiZ+pjyki7Rn9wAMDTJ9iTohwofF6Wr0yuNg=; b=JlpOjzdU5CHLFy8118eb4XJeX
        4OScZ2Lak+rvx44sp64O86lS/NLhwxMHa73issWrJqGTIVzLKpV191n+umXqM3LBX7K73gF0MNRbO
        hCqBtguKJQgXMtrxL/+YshisWjed18823EPjFDd5dOE60cNRWkWqdLXB8SurPo9n3MKaI1GaqaL6a
        gADq41yLMa5xt+k0a+S8kLvySjgfehod2vasbFFcTy95HBrvl08DfwcSM0INWEfLIwE5+8oLn4Cgz
        Y/IGBrn/08QvU2l/M4d+ev3GIcG8a8sEIPBGCAt1N0bTyO1ebqQg1iMRdqScYg19Ag7s1APNTECae
        1+tVjHJIg==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:37444)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1h5vd0-0000pI-Fq; Mon, 18 Mar 2019 17:00:46 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1h5vcv-0005qK-OW; Mon, 18 Mar 2019 17:00:41 +0000
Date:   Mon, 18 Mar 2019 17:00:41 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Robin Murphy <robin.murphy@arm.com>
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
Subject: Re: [PATCH] arm64/io: Don't use WZR in writel
Message-ID: <20190318170041.qu4x2565fmno6sei@shell.armlinux.org.uk>
References: <68b71c15f32341468a868f6418e4fcb375bc49ba.camel@gmail.com>
 <20190211105755.GB30880@fuggles.cambridge.arm.com>
 <38d8965a-cd41-17cf-1b95-8dd58c079be4@arm.com>
 <874c702b8af760aa8fae38d478c79e3ecba00515.camel@gmail.com>
 <235d20ef-3054-69d9-975d-25aebf32aad3@arm.com>
 <20190223181254.GC572@tuxbook-pro>
 <86zhqm8i6d.wl-marc.zyngier@arm.com>
 <20190224035356.GD572@tuxbook-pro>
 <33d765b5-1807-fa6c-1ceb-99f09f7c8d5a@free.fr>
 <8eb4f446-6152-ffb6-9529-77fb0bcc307f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8eb4f446-6152-ffb6-9529-77fb0bcc307f@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 04:04:03PM +0000, Robin Murphy wrote:
> On 12/03/2019 12:36, Marc Gonzalez wrote:
> > On 24/02/2019 04:53, Bjorn Andersson wrote:
> > 
> > > On Sat 23 Feb 10:37 PST 2019, Marc Zyngier wrote:
> > > 
> > > > On Sat, 23 Feb 2019 18:12:54 +0000, Bjorn Andersson wrote:
> > > > > 
> > > > > On Mon 11 Feb 06:59 PST 2019, Marc Zyngier wrote:
> > > > > 
> > > > > > On 11/02/2019 14:29, AngeloGioacchino Del Regno wrote:
> > > > > > 
> > > > > > > Also, just one more thing: yes this thing is going ARM64-wide and
> > > > > > > - from my findings - it's targeting certain Qualcomm SoCs, but...
> > > > > > > I'm not sure that only QC is affected by that, others may as well
> > > > > > > have the same stupid bug.
> > > > > > 
> > > > > > At the moment, only QC SoCs seem to be affected, probably because
> > > > > > everyone else has debugged their hypervisor (or most likely doesn't
> > > > > > bother with shipping one).
> > > > > > 
> > > > > > In all honesty, we need some information from QC here: which SoCs are
> > > > > > affected, what is the exact nature of the bug, can it be triggered from
> > > > > > EL0. Randomly papering over symptoms is not something I really like
> > > > > > doing, and is likely to generate problems on unaffected systems.
> > > > > 
> > > > > The bug at hand is that the XZR is not deemed a valid source in the
> > > > > virtualization of the SMMU registers. It was identified and fixed for
> > > > > all platforms that are shipping kernels based on v4.9 or later.
> > > > 
> > > > When you say "fixed": Do you mean fixed in the firmware? Or by adding
> > > > a workaround in the shipped kernel?
> > > 
> > > I mean that it's fixed in the firmware.
> > > 
> > > > If the former, is this part of an official QC statement, with an
> > > > associated erratum number?
> > > 
> > > I don't know, will get back to you on this one.
> > > 
> > > > Is this really limited to the SMMU accesses?
> > > 
> > > Yes.
> > > 
> > > > > As such Angelo's list of affected platforms covers the high-profile
> > > > > ones. In particular MSM8996 and MSM8998 is getting pretty good support
> > > > > upstream, if we can figure out a way around this issue.
> > > > 
> > > > We'd need an exhaustive list of the affected SoCs, and work out if we
> > > > can limit the hack to the SMMU driver (cc'ing Robin, who's the one
> > > > who'd know about it).
> > > 
> > > I will try to compose a list.
> > 
> > FWIW, I have just been bitten by this issue. I needed to enable an SMMU to
> > filter PCIe EP accesses to system RAM (or something). I'm using an APQ8098
> > MEDIABOX dev board. My system hangs in arm_smmu_device_reset() doing:
> > 
> > 	/* Invalidate the TLB, just in case */
> > 	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLH);
> > 	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);
> > 
> > 
> > With the 'Z' constraint, gcc generates:
> > 
> > 	str wzr, [x0]
> > 
> > without the 'Z' constraint, gcc generates:
> > 
> > 	mov	w1, 0
> > 	str w1, [x0]
> > 
> > 
> > I can work around the problem using the following patch:
> > 
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 045d93884164..93117519aed8 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -59,6 +59,11 @@
> >   #include "arm-smmu-regs.h"
> > +static inline void qcom_writel(u32 val, volatile void __iomem *addr)
> > +{
> > +	asm volatile("str %w0, [%1]" : : "r" (val), "r" (addr));
> > +}
> > +
> >   #define ARM_MMU500_ACTLR_CPRE		(1 << 1)
> >   #define ARM_MMU500_ACR_CACHE_LOCK	(1 << 26)
> > @@ -422,7 +427,7 @@ static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu,
> >   {
> >   	unsigned int spin_cnt, delay;
> > -	writel_relaxed(0, sync);
> > +	qcom_writel(0, sync);
> >   	for (delay = 1; delay < TLB_LOOP_TIMEOUT; delay *= 2) {
> >   		for (spin_cnt = TLB_SPIN_COUNT; spin_cnt > 0; spin_cnt--) {
> >   			if (!(readl_relaxed(status) & sTLBGSTATUS_GSACTIVE))
> > @@ -1760,8 +1765,8 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
> >   	}
> >   	/* Invalidate the TLB, just in case */
> > -	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLH);
> > -	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);
> > +	qcom_writel(0, gr0_base + ARM_SMMU_GR0_TLBIALLH);
> > +	qcom_writel(0, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);
> >   	reg = readl_relaxed(ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
> > 
> > 
> > 
> > Can a quirk be used to work around the issue?
> > Or can we just "pessimize" the 3 writes for everybody?
> > (Might be cheaper than a test anyway)
> 
> If it really is just the SMMU driver which is affected, we can work around
> it for free (not counting the 'cost' of slightly-weird-looking code, of
> course). If the diff below works as expected, I'll write it up properly.
> 
> Robin.
> ----->8-----
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 045d93884164..7ff29e33298f 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -422,7 +422,7 @@ static void __arm_smmu_tlb_sync(struct arm_smmu_device
> *smmu,
>  {
>  	unsigned int spin_cnt, delay;
> 
> -	writel_relaxed(0, sync);
> +	writel_relaxed((unsigned long)sync, sync);
>  	for (delay = 1; delay < TLB_LOOP_TIMEOUT; delay *= 2) {
>  		for (spin_cnt = TLB_SPIN_COUNT; spin_cnt > 0; spin_cnt--) {
>  			if (!(readl_relaxed(status) & sTLBGSTATUS_GSACTIVE))
> @@ -681,7 +681,12 @@ static void arm_smmu_write_context_bank(struct
> arm_smmu_device *smmu, int idx)
> 
>  	/* Unassigned context banks only need disabling */
>  	if (!cfg) {
> -		writel_relaxed(0, cb_base + ARM_SMMU_CB_SCTLR);
> +		/*
> +		 * For Qualcomm reasons, we want to guarantee that we write a
> +		 * zero from a register which is not WZR. Fortunately, the cfg
> +		 * logic here plays right into our hands...
> +		 */
> +		writel_relaxed((unsigned long)cfg, cb_base + ARM_SMMU_CB_SCTLR);
>  		return;
>  	}
> 
> @@ -1760,8 +1765,8 @@ static void arm_smmu_device_reset(struct
> arm_smmu_device *smmu)
>  	}
> 
>  	/* Invalidate the TLB, just in case */
> -	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLH);
> -	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);
> +	writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_TLBIALLH);
> +	writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);
> 
>  	reg = readl_relaxed(ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
> 

Given what we've seen from Clang for futex stuff in 32-bit ARM, are
you really sure that the above will not result in Clang still spotting
that the value is zero and using a wzr for all these cases?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
