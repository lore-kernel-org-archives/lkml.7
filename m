Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E2CC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568B82053B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pE4dxLaD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbfH0Jpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:45:35 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:36624 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbfH0Jpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=db4eeeBDxOPeQgCnxVgK0cY8TBZGLFlCe0NsKNFsxDw=; b=pE4dxLaD4wDroPGs8tQLb6wF0
        V+nS/JucfqBwoulqP0IfXx6iiAVhPBAlNdlPeLBPz65OMFeoMqdEOkAVzaLSf4kHnFIhnr70g6yE3
        khUUxAHxfcda9QVcxqglAMS8K8PVBqsVS6QAqd/5+KzM/Kb5j9Rkd1oD1Tm+PcypsIS+D2YBXswKN
        10c3adRsX0Si5HSR9OoZFhhjY/dJ3G3dyIdDYqE01O2glKpBQtH5vIPwho7cjB9q7nlgAs67xH0CL
        /U0G8hs5+Ie3mnYVJv9fabZP0c7XGDfMRW1F2KJLf+h1Vv6SeqI4hVts1ZkI/Y3A000xdMHIPGHKU
        GRJfQ/gwQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38568)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1i2Y2V-0003bW-8m; Tue, 27 Aug 2019 10:45:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1i2Y2S-0005ek-8q; Tue, 27 Aug 2019 10:45:20 +0100
Date:   Tue, 27 Aug 2019 10:45:20 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "julien.grall@arm.com" <julien.grall@arm.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm: xen: mm: use __GPF_DMA32 for arm64
Message-ID: <20190827094520.GJ13294@shell.armlinux.org.uk>
References: <20190709083729.11135-1-peng.fan@nxp.com>
 <AM0PR04MB448135E1B2C85F0B6029F7B788C70@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <AM0PR04MB44818BB69CAD35DC989A416988A00@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB44818BB69CAD35DC989A416988A00@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You need to find someone who is interested in Xen on 32-bit ARM, and
who knows this code - and therefore what impact your change causes.
That isn't me, sorry.

On Tue, Aug 27, 2019 at 09:27:53AM +0000, Peng Fan wrote:
> Ping again..
> 
> +Julien
> 
> > Subject: RE: [PATCH] arm: xen: mm: use __GPF_DMA32 for arm64
> > 
> > Hi Russell, Stefano
> > 
> > > Subject: [PATCH] arm: xen: mm: use __GPF_DMA32 for arm64
> > 
> > Any comments?
> > 
> > >
> > > arm64 shares some code under arch/arm/xen, including mm.c.
> > > However ZONE_DMA is removed by commit
> > > ad67f5a6545("arm64: replace ZONE_DMA with ZONE_DMA32").
> > > So to ARM64, need use __GFP_DMA32.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  arch/arm/xen/mm.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c index
> > > e1d44b903dfc..a95e76d18bf9 100644
> > > --- a/arch/arm/xen/mm.c
> > > +++ b/arch/arm/xen/mm.c
> > > @@ -27,7 +27,7 @@ unsigned long xen_get_swiotlb_free_pages(unsigned
> > int
> > > order)
> > >
> > >  	for_each_memblock(memory, reg) {
> > >  		if (reg->base < (phys_addr_t)0xffffffff) {
> > > -			flags |= __GFP_DMA;
> > > +			flags |= __GFP_DMA | __GFP_DMA32;
> > >  			break;
> > >  		}
> > >  	}
> > 
> > Thanks,
> > Peng.
> 
> Thanks,
> Peng.
> 
> > 
> > > --
> > > 2.16.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
