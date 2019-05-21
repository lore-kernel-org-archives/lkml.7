Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEBBC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF59217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558437356;
	bh=BGopbQCk3bzBzM8Wbz1LAhSrUslStMl2R3d35vRkkNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LKZdpZHweBkO/mCBhIF2qtOPMsEB0CRTZqXY2IC92TdZ7N3/9HDMABev3sisUjRYi
	 /0IgWsmA8ouRE7Fc0jSwuKuQ2LZVBAf4t58mNzFeUWFShuxlpbGQD9Wb51i2MRid0a
	 6jNyBIyS/UJlJzmePaxAkTJ1FGCo/nz7wfa2eb4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfEULPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 07:15:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbfEULPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 07:15:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39DA32081C;
        Tue, 21 May 2019 11:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558437353;
        bh=BGopbQCk3bzBzM8Wbz1LAhSrUslStMl2R3d35vRkkNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cva7BvNxufZAFrBpnvDXsrfR73GrmdDgX/ZZAVQi8XTNdZl4vVKAyp0bHb0LWmuOf
         dOi0oe8RApr8X2BCRLNMdRpjlR/1XfzANAhlgT6qVbVOBFYLVxKe4h5mTve9rWFCxw
         tHSa48kJIFp9X0W5B9b5IAv69NU0SK+r5TUzuim0=
Date:   Tue, 21 May 2019 13:15:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "marex@denx.de" <marex@denx.de>, Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "noring@nocrew.org" <noring@nocrew.org>,
        "JuergenUrban@gmx.de" <JuergenUrban@gmx.de>
Subject: Re: [PATCH v4 1/3] USB: use genalloc for USB HCs with local memory
Message-ID: <20190521111551.GA24591@kroah.com>
References: <20190516114721.27694-1-laurentiu.tudor@nxp.com>
 <20190516114721.27694-2-laurentiu.tudor@nxp.com>
 <20190521081657.GA10639@kroah.com>
 <e71c7f9d-2299-827d-821f-591e134f4a8f@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e71c7f9d-2299-827d-821f-591e134f4a8f@nxp.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 11:04:12AM +0000, Laurentiu Tudor wrote:
> 
> 
> On 21.05.2019 11:16, Greg KH wrote:
> > On Thu, May 16, 2019 at 02:47:19PM +0300, laurentiu.tudor@nxp.com wrote:
> >> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >>
> >> For HCs that have local memory, replace the current DMA API usage
> >> with a genalloc generic allocator to manage the mappings for these
> >> devices.
> >> This is in preparation for dropping the existing "coherent" dma
> >> mem declaration APIs. Current implementation was relying on a short
> >> circuit in the DMA API that in the end, was acting as an allocator
> >> for these type of devices.
> >>
> >> For context, see thread here: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2019%2F4%2F22%2F357&amp;data=02%7C01%7Claurentiu.tudor%40nxp.com%7Cf5242fb28d154ff9653208d6ddc4b41c%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636940234237524499&amp;sdata=KEEUP1KH%2BaraWcVKogeYBzrauh%2FFTzGjSxjk%2BuNozjA%3D&amp;reserved=0
> >>
> >> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >> ---
> >>   drivers/usb/core/buffer.c   | 15 +++++++++++----
> >>   drivers/usb/host/ohci-hcd.c | 23 ++++++++++++++++++-----
> >>   include/linux/usb/hcd.h     |  3 +++
> >>   3 files changed, 32 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
> >> index f641342cdec0..22a8f3f5679b 100644
> >> --- a/drivers/usb/core/buffer.c
> >> +++ b/drivers/usb/core/buffer.c
> >> @@ -16,6 +16,7 @@
> >>   #include <linux/io.h>
> >>   #include <linux/dma-mapping.h>
> >>   #include <linux/dmapool.h>
> >> +#include <linux/genalloc.h>
> >>   #include <linux/usb.h>
> >>   #include <linux/usb/hcd.h>
> >>   
> >> @@ -124,10 +125,12 @@ void *hcd_buffer_alloc(
> >>   	if (size == 0)
> >>   		return NULL;
> >>   
> >> +	if (hcd->driver->flags & HCD_LOCAL_MEM)
> >> +		return gen_pool_dma_alloc(hcd->localmem_pool, size, dma);
> > 
> > Does this patch now break things?  hcd->localmem_pool at this point in
> > time is NULL, so this call will fail.  There's no chance for any host
> > controller driver to actually set up this pool in this patch, so is
> > bisection broken?
> 
> Unfortunately, yes. I could lump the patches together but I think 
> Christoph suggestion is much better.

I do too, can you redo these patches to work in that manner please?

thanks,

greg k-h
