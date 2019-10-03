Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56436C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1591B2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LwvECE09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733144AbfJCVir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 17:38:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42604 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730739AbfJCViq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 17:38:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id q12so2547196pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 14:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d8eAHonumPxoDjOGcoOJYQ6JBJJnBbXuaVBYnqFe57A=;
        b=LwvECE09N5iAc+1n+0VNTbW3zmtLbBUjEDaMYm2S3vACDV1hMKdGRDIo+5RddQV3iH
         oWl//haeVzcm6RoxtusZWfFjZQ8VGgKhfhBs+vUzdDrDclImOJ4p8ipQy30/IvuBjIwU
         Q/MypZoSS1Sn7QeW8RaJ/18OWxY8v6vaYpbRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d8eAHonumPxoDjOGcoOJYQ6JBJJnBbXuaVBYnqFe57A=;
        b=nsdEpHK1JcKX7TpPAtLHuheikF6VrsaWSzTcVJ5cyDNV1maExRy3l6Pf+0hQFspfHo
         QEqUkA1xn98oPFeFncEB3WwFt2oTdN5tmXMx0SVpJGg413QlEZw/uhmm1Vd7osP+1o8z
         Yvfj55+txUnmtiwQayi/EWiEmY/bOYHUTJCmY8V0KADxn/vHcdPGM/s5JJ/O12djfBs1
         ziJiDuFiRxfDmqTRq0NTfpbd4twfY/scmI75KDlq2QGeYM554i/McHNy0KqUuWtnurz7
         +0A12O3WAzMkT35cUuFbPBmLi4p9UMJHnOwG6d1owAIs3EqihpBxI8Y112f7RBtr8BNr
         9uXQ==
X-Gm-Message-State: APjAAAWVcvbqON5P5l19FJaMfl/mxEtPVmobagvlApO9xZSt5IvaHD8t
        d2OX3rmTvRblBUBLvWF3uGxeyw==
X-Google-Smtp-Source: APXvYqw+LtB3JWQsbxLy3YhlawIlrNj7chBkLHklXW+zMwZlMW1AvjlplYHd/Mb2CskKI81sZ0nfKQ==
X-Received: by 2002:a63:7342:: with SMTP id d2mr11918594pgn.264.1570138725773;
        Thu, 03 Oct 2019 14:38:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j126sm4570520pfb.186.2019.10.03.14.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 14:38:44 -0700 (PDT)
Date:   Thu, 3 Oct 2019 14:38:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Laura Abbott <labbott@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Semmle Security Reports <security-reports@semmle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: Lift address space checks out of debug code
Message-ID: <201910031438.A67C40B97C@keescook>
References: <201910021341.7819A660@keescook>
 <7a5dc7aa-66ec-0249-e73f-285b8807cb73@arm.com>
 <201910021643.75E856C@keescook>
 <fc9fffc8-3cff-4a6f-d426-4a4cc895ebb1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc9fffc8-3cff-4a6f-d426-4a4cc895ebb1@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 10:42:45AM +0100, Robin Murphy wrote:
> On 03/10/2019 00:58, Kees Cook wrote:
> > On Wed, Oct 02, 2019 at 10:15:43PM +0100, Robin Murphy wrote:
> > > Hi Kees,
> > > 
> > > On 2019-10-02 9:46 pm, Kees Cook wrote:
> > > > As we've seen from USB and other areas, we need to always do runtime
> > > > checks for DMA operating on memory regions that might be remapped. This
> > > > consolidates the (existing!) checks and makes them on by default. A
> > > > warning will be triggered for any drivers still using DMA on the stack
> > > > (as has been seen in a few recent reports).
> > > > 
> > > > Suggested-by: Laura Abbott <labbott@redhat.com>
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > ---
> > > >    include/linux/dma-debug.h   |  8 --------
> > > >    include/linux/dma-mapping.h |  8 +++++++-
> > > >    kernel/dma/debug.c          | 16 ----------------
> > > >    3 files changed, 7 insertions(+), 25 deletions(-)
> > > > 
> > > > diff --git a/include/linux/dma-debug.h b/include/linux/dma-debug.h
> > > > index 4208f94d93f7..2af9765d9af7 100644
> > > > --- a/include/linux/dma-debug.h
> > > > +++ b/include/linux/dma-debug.h
> > > > @@ -18,9 +18,6 @@ struct bus_type;
> > > >    extern void dma_debug_add_bus(struct bus_type *bus);
> > > > -extern void debug_dma_map_single(struct device *dev, const void *addr,
> > > > -				 unsigned long len);
> > > > -
> > > >    extern void debug_dma_map_page(struct device *dev, struct page *page,
> > > >    			       size_t offset, size_t size,
> > > >    			       int direction, dma_addr_t dma_addr);
> > > > @@ -75,11 +72,6 @@ static inline void dma_debug_add_bus(struct bus_type *bus)
> > > >    {
> > > >    }
> > > > -static inline void debug_dma_map_single(struct device *dev, const void *addr,
> > > > -					unsigned long len)
> > > > -{
> > > > -}
> > > > -
> > > >    static inline void debug_dma_map_page(struct device *dev, struct page *page,
> > > >    				      size_t offset, size_t size,
> > > >    				      int direction, dma_addr_t dma_addr)
> > > > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > > > index 4a1c4fca475a..2d6b8382eab1 100644
> > > > --- a/include/linux/dma-mapping.h
> > > > +++ b/include/linux/dma-mapping.h
> > > > @@ -583,7 +583,13 @@ static inline unsigned long dma_get_merge_boundary(struct device *dev)
> > > >    static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
> > > >    		size_t size, enum dma_data_direction dir, unsigned long attrs)
> > > >    {
> > > > -	debug_dma_map_single(dev, ptr, size);
> > > > +	/* DMA must never operate on stack or other remappable places. */
> > > > +	WARN_ONCE(is_vmalloc_addr(ptr) || !virt_addr_valid(ptr),
> > > 
> > > This stands to absolutely cripple I/O performance on arm64, because every
> > > valid call will end up going off and scanning the memblock list, which is
> > > not something we want on a fastpath in non-debug configurations. We'd need a
> > > much better solution to the "pfn_valid() vs. EFI no-map" problem before this
> > > might be viable.
> > 
> > Ah! Interesting. I didn't realize this was fast-path (I don't know the
> > DMA code at all). I thought it was more of a "one time setup" before
> > actual DMA activity started.
> 
> That's strictly true, it's just that many workloads can involve tens of
> thousands of "one time"s per second ;)
> 
> Overhead on the dma_map_* paths has shown to have a direct impact on
> throughput in such situations, hence various optimisation effort in IOVA
> allocation for IOMMU-based DMA ops, and the recent work to remove indirect
> calls entirely for the common dma-direct/SWIOTLB cases.
> 
> > Regardless, is_vmalloc_addr() is extremely light (a bounds check), and is the
> > most important part of this as far as catching stack-based DMA attempts.
> > I thought virt_addr_valid() was cheap too, but I see it's much heavier on
> > arm64.
> > 
> > I just went to compare what the existing USB check does, and it happens
> > immediately before its call to dma_map_single(). Both checks are simple
> > bounds checks, so it shouldn't be an issue:
> > 
> > 			if (is_vmalloc_addr(urb->setup_packet)) {
> > 				WARN_ONCE(1, "setup packet is not dma capable\n");
> > 				return -EAGAIN;
> > 			} else if (object_is_on_stack(urb->setup_packet)) {
> > 				WARN_ONCE(1, "setup packet is on stack\n");
> > 				return -EAGAIN;
> > 			}
> > 
> > 			urb->setup_dma = dma_map_single(
> > 					hcd->self.sysdev,
> > 					urb->setup_packet,
> > 					sizeof(struct usb_ctrlrequest),
> > 
> > 
> > In the USB case, it'll actually refuse to do the operation. Should
> > dma_map_single() similarly fail? I could push these checks down into
> > dma_map_single(), which would be a no-change on behavior for USB and
> > gain the checks on all other callers...
> 
> I think it would be reasonable to pull the is_vmalloc_addr() check inline,
> as that probably covers 90+% of badness (especially given vmapped stacks),
> and as you say should be reliably cheap everywhere. Callers are certainly
> expected to use dma_mapping_error() and handle failure, so refusing to do a
> bogus mapping operation should be OK API-wise - ultimately if a driver goes
> ahead and uses DMA_MAPPING_ERROR as an address anyway, that's not likely to
> be any *more* catastrophic than if it did the same with whatever nonsense
> virt_to_phys() of a vmalloc address had returned.

What do you think about the object_is_on_stack() check? That does a
dereference through "current" to find the stack bounds...

-- 
Kees Cook
