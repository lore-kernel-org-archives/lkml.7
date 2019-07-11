Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73299C74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 12:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4547720872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 12:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562848299;
	bh=taKYFaL4w66TAwI7MPXQRwN1YVw6ACtaT/WEv3sNJm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D/GvtddfjFDZSwhcYTkKTPVSJuOjuRTtVPSvBJ/yfW1HvlAPGLb/6/4Par5fqmIvI
	 4qszlkLoYIL7Qj3/wp3/YLK35IsZYHW3F7wBHBYF6h95d4Snbg+d288hrDRHnjUjNa
	 NgkMXPTxoVKLjZIY7bOMiAz2GT9K/xXGmcUqgtEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfGKMbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 08:31:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfGKMbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 08:31:37 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F26FC20872;
        Thu, 11 Jul 2019 12:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562848296;
        bh=taKYFaL4w66TAwI7MPXQRwN1YVw6ACtaT/WEv3sNJm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I8t08CD65eN+1vdURSKrXiClbKBzmqV8BxOEB+RYrcsXeEC7JGnv38XHWFNfuEhZe
         Fg3LNEGKB0Iy9Pmb7WmH+bzDCXLlNMZfPl3pfgJFwSxLmeRBm8cerDcIEVHkJX0JpZ
         TevDVShZM2RAlid5HYXefWAbG56bGpv9Y1KjKVJo=
Date:   Thu, 11 Jul 2019 13:31:29 +0100
From:   Will Deacon <will@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, yingjoe.chen@mediatek.com,
        youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>,
        anan.sun@mediatek.com, Matthias Kaehlcke <mka@chromium.org>,
        chao.hao@mediatek.com, cui.zhang@mediatek.com
Subject: Re: [PATCH v8 07/21] iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB
 Mode
Message-ID: <20190711123129.da4rg35b54u4svfw@willie-the-truck>
References: <1561774167-24141-1-git-send-email-yong.wu@mediatek.com>
 <1561774167-24141-8-git-send-email-yong.wu@mediatek.com>
 <20190710143649.w5dplhzdpi3bxp7e@willie-the-truck>
 <1562846036.31342.10.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562846036.31342.10.camel@mhfsdcap03>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 07:53:56PM +0800, Yong Wu wrote:
> On Wed, 2019-07-10 at 15:36 +0100, Will Deacon wrote:
> > On Sat, Jun 29, 2019 at 10:09:13AM +0800, Yong Wu wrote:
> > > MediaTek extend the arm v7s descriptor to support the dram over 4GB.
> > > 
> > > In the mt2712 and mt8173, it's called "4GB mode", the physical address
> > > is from 0x4000_0000 to 0x1_3fff_ffff, but from EMI point of view, it
> > > is remapped to high address from 0x1_0000_0000 to 0x1_ffff_ffff, the
> > > bit32 is always enabled. thus, in the M4U, we always enable the bit9
> > > for all PTEs which means to enable bit32 of physical address.
> > > 
> > > but in mt8183, M4U support the dram from 0x4000_0000 to 0x3_ffff_ffff
> > > which isn't remaped. We extend the PTEs: the bit9 represent bit32 of
> > > PA and the bit4 represent bit33 of PA. Meanwhile the iova still is
> > > 32bits.
> > 
> > What happens if bit4 is set in the pte for mt2712 or mt8173? Perhaps the
> 
> bit4 is ignored in mt2712 and mt8173(No effect).
> 
> > io-pgtable backend should be allowing oas > 32 when
> > IO_PGTABLE_QUIRK_ARM_MTK_4GB is set, and then enforcing that itself.
> 
> About oas, It looks the oas doesn't work in current the v7s. 
> 
> How about I add a new simple preparing patch like this(copy from
> io-pgtable-arm.c)?

This looks like the right sort of idea. Basically, I was thinking that you
can use the oas in conjunction with the quirk to specify whether or not
your two magic bits should be set. You could also then cap the oas using
the size of phys_addr_t to deal with my other comment.

Finally, I was hoping you could drop the |= BIT_ULL(32) and the &=
~BIT_ULL(32) bits of the mtk driver if the pgtable code now accepts higher
addresses. Did that not work out?
> 
> ==========================================
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -495,7 +495,8 @@ static int arm_v7s_map(struct io_pgtable_ops *ops,
> unsigned long iova,
>         if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
>                 return 0;
> 
> -       if (WARN_ON(upper_32_bits(iova) || upper_32_bits(paddr)))
> +       if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias) ||
> +                   paddr >= (1ULL << data->iop.cfg.oas)))
>                 return -ERANGE;
> 
> ===============================================
> 
> Then, change the oas in MTK 4GB mode, like this:
> 
> ================================================
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -721,7 +721,9 @@ static struct io_pgtable
> *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
>  {
>         struct arm_v7s_io_pgtable *data;
> 
> -       if (cfg->ias > ARM_V7S_ADDR_BITS || cfg->oas >
> ARM_V7S_ADDR_BITS)
> +       if (cfg->ias > ARM_V7S_ADDR_BITS ||
> +           (cfg->oas > ARM_V7S_ADDR_BITS &&
> +            !(cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB)))

This should probably still be capped at 34 bits.

> > > +	paddr = pte & mask;
> > > +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB) {
> > > +		if (pte & ARM_V7S_ATTR_MTK_PA_BIT32)
> > > +			paddr |= BIT_ULL(32);
> > > +		if (pte & ARM_V7S_ATTR_MTK_PA_BIT33)
> > > +			paddr |= BIT_ULL(33);
> > > +	}
> > > +	return paddr;
> > 
> > I think this relies on CONFIG_PHYS_ADDR_T_64BIT, which isn't always set on
> > 32-bit ARM.
> 
> This was discussed at [1]. Robin commented that this is not needed and
> build won't complain about this.

It's not so much the build I was worried about, but more that we'd silently
be doing the wrong thing and I think we can fix that as I mentioned above.

Will
