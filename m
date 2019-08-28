Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F03C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B9522CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567015790;
	bh=pEW7d4+ki1j7cGrysUa/rs6+n6aWIK6WXN6/tbYAFzs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=yoCZtG3l25hqZFJ1cYuh1iUIxlzubwOwiAQ0D39d03pLL7rsZg1fGgme7+MyP/6Re
	 zA//ZGF4dzyOnhXhw0M5wQt1qwyWmIv9ME3RGQ578w3qMegv+Ckk5B1a/t58mn4OEB
	 LhYRZEvMic+duUjAiu0rvuqFe0qnrlU4mm3gi6kw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfH1SJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 14:09:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfH1SJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 14:09:48 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0953F2053B;
        Wed, 28 Aug 2019 18:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567015787;
        bh=pEW7d4+ki1j7cGrysUa/rs6+n6aWIK6WXN6/tbYAFzs=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=SPT3DChX1H83A9Qle/0AqSTbAk6v+FbOYww2pgDUZeRbOYCEyK/D4OEH5eWuzjVuC
         xDRQFHaR+yKsCIOSiA8B8PhK8UDu1KCgDFfj4b4ahORsC/TvPnQROWaAKyTMWTCALu
         t81UTiYo2w495kttG20MKcBuBREwFON4EDlYJMPY=
Date:   Wed, 28 Aug 2019 11:09:46 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Peng Fan <peng.fan@nxp.com>
cc:     Robin Murphy <robin.murphy@arm.com>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] arm: xen: mm: use __GPF_DMA32 for arm64
In-Reply-To: <AM0PR04MB4481386D2C54AEA6987E1B1588A30@AM0PR04MB4481.eurprd04.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.1908281103290.25361@sstabellini-ThinkPad-T480s>
References: <20190709083729.11135-1-peng.fan@nxp.com> <d70b3a5c-647c-2147-99be-4572f76e898b@arm.com> <AM0PR04MB4481386D2C54AEA6987E1B1588A30@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019, Peng Fan wrote:
> Hi Robin,
> 
> > Subject: Re: [PATCH] arm: xen: mm: use __GPF_DMA32 for arm64
> > 
> > On 09/07/2019 09:22, Peng Fan wrote:
> > > arm64 shares some code under arch/arm/xen, including mm.c.
> > > However ZONE_DMA is removed by commit
> > > ad67f5a6545("arm64: replace ZONE_DMA with ZONE_DMA32").
> > > So to ARM64, need use __GFP_DMA32.

Hi Peng,

Sorry for being so late in replying, this email got lost in the noise.


> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >   arch/arm/xen/mm.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c index
> > > e1d44b903dfc..a95e76d18bf9 100644
> > > --- a/arch/arm/xen/mm.c
> > > +++ b/arch/arm/xen/mm.c
> > > @@ -27,7 +27,7 @@ unsigned long xen_get_swiotlb_free_pages(unsigned
> > > int order)
> > >
> > >   	for_each_memblock(memory, reg) {
> > >   		if (reg->base < (phys_addr_t)0xffffffff) {
> > > -			flags |= __GFP_DMA;
> > > +			flags |= __GFP_DMA | __GFP_DMA32;
> > 
> > Given the definition of GFP_ZONE_BAD, I'm not sure this combination of flags
> > is strictly valid, but rather is implicitly reliant on only one of those zones ever
> > actually existing. As such, it seems liable to blow up if the plans to add
> > ZONE_DMA to arm64[1] go ahead.
> 
> How about this, or do you have any suggestions?
> diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
> index d33b77e9add3..f61c29a4430f 100644
> --- a/arch/arm/xen/mm.c
> +++ b/arch/arm/xen/mm.c
> @@ -28,7 +28,11 @@ unsigned long xen_get_swiotlb_free_pages(unsigned int order)
> 
>         for_each_memblock(memory, reg) {
>                 if (reg->base < (phys_addr_t)0xffffffff) {
> +#ifdef CONFIG_ARM64
> +                       flags |= __GFP_DMA32;
> +#else
>                         flags |= __GFP_DMA;
> +#endif
>                         break;
>                 }
>         }

Yes I think this is the way to go, but we are trying not to add any
#ifdef CONFIG_ARM64 under arch/arm. Maybe you could introduce a static
inline function to set GFP_DMA:

  static inline void xen_set_gfp_dma(gfp_t *flags)

it could be implemented under arch/arm/include/asm/xen/page.h for arm
and under arch/arm64/include/asm/xen/page.h for arm64 using __GFP_DMA
for the former and __GFP_DMA32 for the latter.
