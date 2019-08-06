Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9014C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A85420B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbfHFMVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 08:21:00 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33443 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfHFMVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 08:21:00 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1huySY-0006uH-1d; Tue, 06 Aug 2019 14:20:58 +0200
Message-ID: <1565094057.2323.28.camel@pengutronix.de>
Subject: Re: Regression due to d98849aff879 (dma-direct: handle
 DMA_ATTR_NO_KERNEL_MAPPING in common code)
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Date:   Tue, 06 Aug 2019 14:20:57 +0200
In-Reply-To: <20190806113318.GA20215@lst.de>
References: <1565082809.2323.24.camel@pengutronix.de>
         <20190806113318.GA20215@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 06.08.2019, 13:33 +0200 schrieb Christoph Hellwig:
> On Tue, Aug 06, 2019 at 11:13:29AM +0200, Lucas Stach wrote:
> > Hi Christoph,
> > 
> > I just found a regression where my NVMe device is no longer able to
> > set
> > up its HMB.
> > 
> > After subject commit dma_direct_alloc_pages() is no longer
> > initializing
> > dma_handle properly when DMA_ATTR_NO_KERNEL_MAPPING is set, as the
> > function is now returning too early.
> > 
> > Now this could easily be fixed by adding the phy_to_dma translation
> > to
> > the NO_KERNEL_MAPPING code path, but I'm not sure how this stuff
> > interacts with the memory encryption stuff set up later in the
> > function, so I guess this should be looked at by someone with more
> > experience with this code than me.
> 
> There is not much we can do about the memory encryption case here,

Which I would guess means we need to ignore DMA_ATTR_NO_KERNEL_MAPPING
in that case instead of dropping out early?

> as that requires a kernel address to mark the memory as unencrypted.
> 
> So the obvious trivial fix is probably the right one:
> 
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 59bdceea3737..c49120193309 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -135,6 +135,7 @@ void *dma_direct_alloc_pages(struct device *dev,
> size_t size,
>  		if (!PageHighMem(page))
>  			arch_dma_prep_coherent(page, size);
>  		/* return the page pointer as the opaque cookie */
> +		*dma_handle = phys_to_dma(dev, page_to_phys(page));
>  		return page;
>  	}
>  
