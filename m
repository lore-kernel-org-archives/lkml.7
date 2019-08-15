Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE57C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4731321855
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565862694;
	bh=a1hqZBHdq1hu1xUpLskbyQKgoPJV36S4RRERlFP5ysc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wWrXgnagowOFXGAWTZjW5n5IKXpDbWthR5nE2aHo9fh0MwFGN9IxuAqaf5S8REkEe
	 z3Yb5xUycaL0FVXuLtvMwtib1TVpObHULGMhq/oxDMFgbGh5SF6oS2ev4B0arhEkZj
	 SsASkYDFMYV9Y1woQtDDQRQTwetHaIxyoEkjGXLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbfHOJvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:51:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730801AbfHOJvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:51:32 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AD79206C1;
        Thu, 15 Aug 2019 09:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565862691;
        bh=a1hqZBHdq1hu1xUpLskbyQKgoPJV36S4RRERlFP5ysc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XiXltRI2jc9WC/RckSTqTgumGsudQCuUvuAzQGuVxcu3CzTMInr6pbBJWo21250U/
         /f5wg7TLzsV31LzRoaI17ge5Q22WeYksihXQd3IrqkRPRUqqnHvk7Q5QMDnMC4+1Ny
         4Xac+mCJhBX5nO3/MAPTN6llyO4DShnxedjl7Ee4=
Date:   Thu, 15 Aug 2019 10:51:24 +0100
From:   Will Deacon <will@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        Matthias Kaehlcke <mka@chromium.org>, cui.zhang@mediatek.com,
        chao.hao@mediatek.com, ming-fan.chen@mediatek.com
Subject: Re: [PATCH v9 08/21] iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB
 Mode
Message-ID: <20190815095123.rzgtpklvhtjlqir4@willie-the-truck>
References: <1565423901-17008-1-git-send-email-yong.wu@mediatek.com>
 <1565423901-17008-9-git-send-email-yong.wu@mediatek.com>
 <20190814144059.ruyc45yoqkwpbuga@willie-the-truck>
 <1565858869.12818.51.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565858869.12818.51.camel@mhfsdcap03>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 04:47:49PM +0800, Yong Wu wrote:
> On Wed, 2019-08-14 at 15:41 +0100, Will Deacon wrote:
> > On Sat, Aug 10, 2019 at 03:58:08PM +0800, Yong Wu wrote:
> > > MediaTek extend the arm v7s descriptor to support the dram over 4GB.
> > > 
> > > In the mt2712 and mt8173, it's called "4GB mode", the physical address
> > > is from 0x4000_0000 to 0x1_3fff_ffff, but from EMI point of view, it
> > > is remapped to high address from 0x1_0000_0000 to 0x1_ffff_ffff, the
> > > bit32 is always enabled. thus, in the M4U, we always enable the bit9
> > > for all PTEs which means to enable bit32 of physical address. Here is
> > > the detailed remap relationship in the "4GB mode":
> > > CPU PA         ->    HW PA
> > > 0x4000_0000          0x1_4000_0000 (Add bit32)
> > > 0x8000_0000          0x1_8000_0000 ...
> > > 0xc000_0000          0x1_c000_0000 ...
> > > 0x1_0000_0000        0x1_0000_0000 (No change)
> > 
> > So in this example, there are no PAs below 0x4000_0000 yet you later
> > add code to deal with that:
> > 
> > > +	/* Workaround for MTK 4GB Mode: Add BIT32 only when PA < 0x4000_0000.*/
> > > +	if (cfg->oas == ARM_V7S_MTK_4GB_OAS && paddr < 0x40000000UL)
> > > +		paddr |= BIT_ULL(32);
> > 
> > Why? Mainline currently doesn't do anything like this for the "4gb mode"
> > support as far as I can tell. In fact, we currently unconditionally set
> > bit 32 in the physical address returned by iova_to_phys() which wouldn't
> > match your CPU PAs listed above, so I'm confused about how this is supposed
> > to work.
> 
> Actually current mainline have a bug for this. So I tried to use another
> special patch[1] for it in v8.

If you're fixing a bug in mainline, I'd prefer to see that as a separate
patch.

> But the issue is not critical since MediaTek multimedia consumer(v4l2
> and drm) don't call iommu_iova_to_phys currently.
> 
> > 
> > The way I would like this quirk to work is that the io-pgtable code
> > basically sets bit 9 in the pte when bit 32 is set in the physical address,
> > and sets bit 4 in the pte when bit 33 is set in the physical address. It
> > would then do the opposite when converting a pte to a physical address.
> > 
> > That way, your driver can call the page table code directly with the high
> > addresses and we don't have to do any manual offsetting or range checking
> > in the page table code.
> 
> In this case, the mt8183 can work successfully while the "4gb
> mode"(mt8173/mt2712) can not.
> 
> In the "4gb mode", As the remap relationship above, we should always add
> bit32 in pte as we did in [2]. and need add bit32 in the
> "iova_to_phys"(Not always add.). That means the "4gb mode" has a special
> flow:
> a. Always add bit32 in paddr_to_iopte.
> b. Add bit32 only when PA < 0x40000000 in iopte_to_paddr.

I think this is probably at the heart of my misunderstanding. What is so
special about PAs (is this HW PA or CPU PA?) below 0x40000000? Is this RAM
or something else?

> > Please can you explain to me why the diff below doesn't work on top of
> > this series?
> 
> The diff below is just I did in v8[3]. The different is that I move the
> "4gb mode" special flow in the mtk_iommu.c in v8, the code is like
> [4]below. When I sent v9, I found that I can distinguish the "4gb mode"
> with "oas == 33" in v7s. then I can "simply" add the 4gb special flow[5]
> based on your diff.
> 
> 
> >  I'm happy to chat on IRC if you think it would be easier,
> > because I have a horrible feeling that we've been talking past each other
> > and I'd like to see this support merged for 5.4.
> 
> Thanks very much for your view, I'm sorry that I don't have IRC. I will
> send the next version quickly if we have a conclusion here. Then Which
> way is better? If you'd like keep the pagetable code clean, I will add
> the "4gb mode" special flow into mtk_iommu.c.

I mean, we could even talk on the phone if necessary because I can't accept
this code unless I understand how it works!

To be blunt, I'd like to avoid the io-pgtable changes looking different to
what I suggested:

> > diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> > index ab12ef5f8b03..d8d84617c822 100644
> > --- a/drivers/iommu/io-pgtable-arm-v7s.c
> > +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> > @@ -184,7 +184,7 @@ static arm_v7s_iopte paddr_to_iopte(phys_addr_t paddr, int lvl,
> >  	arm_v7s_iopte pte = paddr & ARM_V7S_LVL_MASK(lvl);
> >  
> >  	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT) {
> > -		if ((paddr & BIT_ULL(32)) || cfg->oas == ARM_V7S_MTK_4GB_OAS)
> > +		if (paddr & BIT_ULL(32))
> >  			pte |= ARM_V7S_ATTR_MTK_PA_BIT32;
> >  		if (paddr & BIT_ULL(33))
> >  			pte |= ARM_V7S_ATTR_MTK_PA_BIT33;
> > @@ -206,17 +206,14 @@ static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
> >  		mask = ARM_V7S_LVL_MASK(lvl);
> >  
> >  	paddr = pte & mask;
> > -	if (cfg->oas == 32 || !(cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT))
> > -		return paddr;
> >  
> > -	if (pte & ARM_V7S_ATTR_MTK_PA_BIT33)
> > -		paddr |= BIT_ULL(33);
> > +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT) {
> > +		if (pte & ARM_V7S_ATTR_MTK_PA_BIT32)
> > +			paddr |= BIT_ULL(32);
> > +		if (pte & ARM_V7S_ATTR_MTK_PA_BIT33)
> > +			paddr |= BIT_ULL(33);
> > +	}
> >  
> > -	/* Workaround for MTK 4GB Mode: Add BIT32 only when PA < 0x4000_0000.*/
> > -	if (cfg->oas == ARM_V7S_MTK_4GB_OAS && paddr < 0x40000000UL)
> > -		paddr |= BIT_ULL(32);
> > -	else if (pte & ARM_V7S_ATTR_MTK_PA_BIT32)
> > -		paddr |= BIT_ULL(32);
> >  	return paddr;
> >  }

so anything else should ideally go in the driver. The change above gives
the driver control over bits 4 and 9 in the pte, which I hope should be
sufficient. That said, yet another thing I don't understand is how the
IOMMU page table walker views physical addresses :/

Anyway, in your diff here...

> [5]:
> =========================================================
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c
> b/drivers/iommu/io-pgtable-arm-v7s.c
> index 78fd11e..8e974a5 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -184,7 +184,7 @@ static arm_v7s_iopte paddr_to_iopte(phys_addr_t
> paddr, int lvl,
>  	arm_v7s_iopte pte = paddr & ARM_V7S_LVL_MASK(lvl);
>  
>  	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB) {
> -		if (paddr & BIT_ULL(32))
> +		if (paddr & BIT_ULL(32) || cfg->oas == 33)
>  			pte |= ARM_V7S_ATTR_MTK_PA_BIT32;

... I'd like to drop the oas check, because the driver should be passing
in physical addresses with bit 32 set in this case, and...

>  		if (paddr & BIT_ULL(33))
>  			pte |= ARM_V7S_ATTR_MTK_PA_BIT33;
> @@ -207,7 +207,9 @@ static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte,
> int lvl,
>  
>  	paddr = pte & mask;
>  	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB) {
> -		if (pte & ARM_V7S_ATTR_MTK_PA_BIT32)
> +		if (cfg->oas == 33 && paddr < 0x40000000UL)
> +			paddr |= BIT_ULL(32);

... here I simply don't understand the significance of 0x40000000.

Will
