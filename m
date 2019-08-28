Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE0CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B56722DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567025337;
	bh=wedKbY+wULWSOFuNELNsjmsKune/wJFgcC8Ep9J72tE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=wYRHnUMYnTdkm5xszqyqP0hoUjjEEtHBEH2TFZK3topRdf+lSOpqlk12DLwFkRBq8
	 TXL5weKMREo12PN4roav3ROqKX42sgKQPVsk4zBweh3JFk5a4HpGg+kznzp2ME9ylG
	 S24VTXJR1g7PwI5NNPtZIww1yxNNnHmryH1K8RHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfH1Us4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 16:48:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbfH1Usz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 16:48:55 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A49E92189D;
        Wed, 28 Aug 2019 20:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567025334;
        bh=wedKbY+wULWSOFuNELNsjmsKune/wJFgcC8Ep9J72tE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=dlHzspDsR4tSZ4pxoW0w/uceuuYYaigGCgU2ZBdI09VlO+9TzA2LfVGtLA/DWoNLc
         DkvT7J3braU+7C9K6xiN1FAyM/zHVUJi44ICjLQP+F4uj1+MO+Fm7MY0eu8WOO86OU
         QNlR4r/NS/sl19fR0UY6OdHgsz7PCa1wLNNKmRSw=
Date:   Wed, 28 Aug 2019 13:48:53 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Robin Murphy <robin.murphy@arm.com>
cc:     Stefano Stabellini <sstabellini@kernel.org>, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, michal.simek@xilinx.com,
        git@xilinx.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm-smmu: check for generic bindings first
In-Reply-To: <f6fe31f1-52e1-8ab8-4ba4-f23db262d1b5@arm.com>
Message-ID: <alpine.DEB.2.21.1908281338090.25361@sstabellini-ThinkPad-T480s>
References: <20190828173837.29617-1-sstabellini@kernel.org> <f6fe31f1-52e1-8ab8-4ba4-f23db262d1b5@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019, Robin Murphy wrote:
> On 28/08/2019 18:38, Stefano Stabellini wrote:
> > From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> > 
> > Today, the arm-smmu driver checks for mmu-masters on device tree, the
> > legacy property, if it is absent it assumes that we are using the new
> > bindings. If it is present it assumes that we are using the legacy
> > bindings. All arm-smmus need to use the same bindings: legacy or new.
> > 
> > There are two issues with this:
> > 
> > - we are not actually checking for the new bindings explicitly
> > It would be better to have an explicit check for the new bindings rather
> > than assuming we must be using the new if the old are not there.
> 
> The legacy binding is the special case, though. Isn't it perfectly logical to
> check for the special case, and assume the normal case otherwise? ;)

I don't know ... all cases are special and all cases are normal
depending on who you ask or when. The normal case of today can be the
special case of tomorrow and vice versa.


> > - old and new bindings cannot coexist
> > It would be nice to be able to provide both old and new bindings so
> > that software that hasn't been updated yet is still able to get IOMMU
> > information from the legacy bindings while at the same time newer
> > software can get the latest information via the new bindings. (Xen has
> > not been updated to use the new binding yet for instance.) The current
> > code breaks under these circumstances because if the old bindings are
> > present, the new are not even checked.
> 
> FWIW that was a deliberate design decision. We didn't want to see DTs with
> both bindings at once - the legacy binding support remains only for the sake
> of DTBs deployed in fossilised firmware that can't/won't ever be updated. And
> I'm pretty sure the intervening 3 years have only reinforced that position.
> Only a couple more months now until it will have been deprecated for longer
> than it wasn't :)

This way the people that would be willing to put in extra effort to
maintain compatibility wouldn't be able to achieve the goal.


> Do note that "mmu-masters" isn't just deprecated for giggles either - the
> binding made some flawed assumptions, and there are Stream ID topologies that
> it cannot possibly describe, which do exist in the real world.
>
> > This patch changes the scheme by checking for #iommu-cells, which is
> > only present with the new bindings, before checking for mmu-masters.
> > The new bindings are always favored when present. All SMMUs still need
> > to use the same bindings: mix-and-matching new and old bindings between
> > different SMMUs is not allowed.
> > 
> > Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
> > ---
> > 
> > Let me know if you'd like me to turn the two using_*_binding variables
> > into a single one.
> > 
> > Also, please note that this is not meant as an excuse not to get Xen
> > updated to use the new binding.
> 
> Fair enough, but conversely, what makes it Linux's responsibility to handle?
> If Xen wants to deal with funky hybrid DTs then why shouldn't it be Xen's job
> to just filter deprecated properties out of whatever it presents to Linux?

Yes, Xen does it just fine. But if you boot Linux with the same DT but
without Xen, problems occur.

The code looked suboptimal to me because of the reasons I listed in the
commit message. I thought it was done this way by "mistake". However, I
now realize that if it is written this way on purpose, then I have a
very little chance of convincing you to change it.


 
> >   drivers/iommu/arm-smmu.c | 22 +++++++++++++---------
> >   1 file changed, 13 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 64977c131ee6..79b518ff215c 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -2118,7 +2118,7 @@ static int arm_smmu_device_dt_probe(struct
> > platform_device *pdev,
> >   {
> >   	const struct arm_smmu_match_data *data;
> >   	struct device *dev = &pdev->dev;
> > -	bool legacy_binding;
> > +	bool legacy_binding, generic_binding;
> >     	if (of_property_read_u32(dev->of_node, "#global-interrupts",
> >   				 &smmu->num_global_irqs)) {
> > @@ -2132,16 +2132,20 @@ static int arm_smmu_device_dt_probe(struct
> > platform_device *pdev,
> >     	parse_driver_options(smmu);
> >   -	legacy_binding = of_find_property(dev->of_node, "mmu-masters", NULL);
> > -	if (legacy_binding && !using_generic_binding) {
> > -		if (!using_legacy_binding)
> > -			pr_notice("deprecated \"mmu-masters\" DT property in
> > use; DMA API support unavailable\n");
> > -		using_legacy_binding = true;
> > -	} else if (!legacy_binding && !using_legacy_binding) {
> > +	generic_binding = of_find_property(dev->of_node, "#iommu-cells",
> > NULL);
> > +	if (generic_binding && !using_legacy_binding) {
> >   		using_generic_binding = true;
> >   	} else {
> > -		dev_err(dev, "not probing due to mismatched DT properties\n");
> > -		return -ENODEV;
> > +		legacy_binding = of_find_property(dev->of_node, "mmu-masters",
> > +						  NULL);
> > +		if (legacy_binding && !using_generic_binding) {
> > +			if (!using_legacy_binding)
> > +				pr_notice("deprecated \"mmu-masters\" DT
> > property in use; DMA API support unavailable\n");
> > +			using_legacy_binding = true;
> > +		} else {
> > +			dev_err(dev, "not probing due to mismatched DT
> > properties\n");
> > +			return -ENODEV;
> > +		}
> >   	}
> >     	if (of_dma_is_coherent(dev->of_node))
> > 
> 
