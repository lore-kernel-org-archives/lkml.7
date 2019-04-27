Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1837DC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 13:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE792087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 13:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556370022;
	bh=iGRFi0Km+sdfY//PO/gcrE6YZGld79ZiIjYE2iI73JE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kHrq0WLNvwkHg1BXWPM6tDUUl0L0Uk7USd41IEBUZSbMrnokjYrzeNbEDBrbHhJw9
	 VQcsj5MNdW6ZFZ+SyaEXabVro5VTZcSeUvs6GsRA1vBoskp/J7EdltjHhuDWwTExPz
	 EWuEbGvVsN7cMr3NkPyJ///3u98ntnMB/uDVs3NE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfD0NAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 09:00:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbfD0NAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 09:00:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 535BD2087C;
        Sat, 27 Apr 2019 13:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556370019;
        bh=iGRFi0Km+sdfY//PO/gcrE6YZGld79ZiIjYE2iI73JE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eY1St2jmLd9C/4LAtbgIhozEkq3dDj9XjNLYY9Ma6FuVcoePzZN7v5NK4XbTy+avL
         xLbpdI8pcWFg/JBJit7GS/I1uvSWXGHq5rGVPpm9fNhXt6gYnxlEX3Sm+s1ro0cNhX
         z8wIfz457Wf+zGuSvwwQWYChNv1hzOEH4x0H9cGM=
Date:   Sat, 27 Apr 2019 15:00:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: comedi: comedi_isadma: Use a non-NULL device
 for DMA API
Message-ID: <20190427130017.GA25587@kroah.com>
References: <20190425162644.21947-1-abbotti@mev.co.uk>
 <20190425171351.GB11105@kroah.com>
 <e1322f35-af8b-8151-b560-0ba76775b237@mev.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1322f35-af8b-8151-b560-0ba76775b237@mev.co.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 10:41:20AM +0100, Ian Abbott wrote:
> On 25/04/2019 18:13, Greg Kroah-Hartman wrote:
> > On Thu, Apr 25, 2019 at 05:26:44PM +0100, Ian Abbott wrote:
> > > The "comedi_isadma" module calls `dma_alloc_coherent()` and
> > > `dma_free_coherent()` with a NULL device pointer which is no longer
> > > allowed.  If the `hw_dev` member of the `struct comedi_device` has been
> > > set to a valid device, that can be used instead.  Unfortunately, all the
> > > current users of the "comedi_isadma" module leave the `hw_dev` member
> > > set to NULL.  In that case, use a static dummy fallback device structure
> > > with the coherent DMA mask set to the ISA bus limit of 16MB.
> > > 
> > > Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
> > > ---
> > >   drivers/staging/comedi/drivers/comedi_isadma.c | 15 +++++++++++++--
> > >   drivers/staging/comedi/drivers/comedi_isadma.h |  3 +++
> > >   2 files changed, 16 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/staging/comedi/drivers/comedi_isadma.c b/drivers/staging/comedi/drivers/comedi_isadma.c
> > > index b77dc8d5d3ff..8929952516a1 100644
> > > --- a/drivers/staging/comedi/drivers/comedi_isadma.c
> > > +++ b/drivers/staging/comedi/drivers/comedi_isadma.c
> > > @@ -14,6 +14,16 @@
> > >   #include "comedi_isadma.h"
> > > +/*
> > > + * Fallback device used when hardware device is NULL.
> > > + * This can be removed after drivers have been converted to use isa_driver.
> > > + */
> > > +static struct device fallback_dev = {
> > > +	.init_name = "comedi_isadma fallback device",
> > > +	.coherent_dma_mask = DMA_BIT_MASK(24),
> > > +	.dma_mask = &fallback_dev.coherent_dma_mask,
> > > +};
> > 
> > Ick, no, static struct device are a very bad idea as this is a reference
> > counted structure and making it static can cause odd problems.
> 
> This was based on the use of `struct device x86_dma_fallback_dev` in
> "arch/x86/kernel/pci-dma.c", and `static struct device isa_dma_dev` in
> "arch/arm/kernel/dma-isa.c", but perhaps it is not appropriate in non-arch
> code.

No, those are probably broken as well :)

Ah, I see why, ugh, ISA.

> > Why not just create a "real" one?  Or better yet, use the real device
> > for the comedi device as all of these drivers should have one now.
> 
> I suppose I could use the comedi class device pointed to by the `class_dev`
> member of `struct comedi_device` (although that could also be NULL because
> the comedi core does not currently treat `device_create()` failures as
> fatal).

Why would device_create() fail?  If it does, the driver should not have
been bound to anything.

And no, this shouldn't be the class device, but the "real" hardware
device that does dma, which is what is needed anyway here to allow the
DMA to happen properly.

I guess the problem is with the ISA drivers, right?  And I doubt that is
ever going to get fixed up, hopefully just deleted :)

Your second patch is "good enough", I'll go queue that up now.

thanks,

greg k-h
