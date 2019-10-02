Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1EEC4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2625121A4C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BNQIebcW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbfJBX6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 19:58:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35372 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbfJBX6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 19:58:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id 205so543726pfw.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 16:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PH0TVlptMFdFZ9SoJTuyTfXJKlgPpa/0x/CIYNASyXQ=;
        b=BNQIebcW8imd/BryLx2tGf090/MdRtGKiAIdxV+pGfFq9zQ/YmeSI9MEvl1pFl+ZmB
         g5MtZRW/8VkM+iEW4brSZWu0RFyyTxhP5GubvJr0M5+wQp2AT2IUnZywGJkwk9s+PYMg
         9RTLXCS14kBrYS5lwB01GGuX2ArbYvFDl2KXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PH0TVlptMFdFZ9SoJTuyTfXJKlgPpa/0x/CIYNASyXQ=;
        b=Hl+d+iaB8H6KKtDANzDv0WQOuDwfWG9V8s9BHqiSj6XQ0w+qj4EL3FuZGbnqgCxSSA
         NCv2V1oKwX87XShxbPVCuu7AIFhZBGziMuV1chYqgyUdiibGSu1q1bH8YCnYm0wkGqf8
         zLAT/5VfTjf/D2NX00OhbF2bQ5NUqsa4qKZLED2eQ1iG7NVzEuWbBeqs5x/RH2U9N0QJ
         AG+na6OnbkpaXfhp8y1eKWL5VfWPeHYMVYEtTGg/Ava79BTrf6KdHJDLAagR0/t3uVvx
         iF+GW/jj+DsR0GWAMuRWjEou0gQyoS2Yls3/quet7urNuSshSzmEwBMwm1Hw3rMnP6ja
         wehg==
X-Gm-Message-State: APjAAAV3rwKPLA7iXIP5283mshZZkEDDfdeMnO9FgUQzATL5TDnhkIFF
        yOqngIBkgnm5RfPuOcWEwGlqiw==
X-Google-Smtp-Source: APXvYqyjGev5+2vi2/tdFJi2+wdkZLQNTruTzLAkCBI1aI7WQOssSzGUb8T1kwdZT7r1wk5YRimfxA==
X-Received: by 2002:a62:1747:: with SMTP id 68mr7925839pfx.63.1570060721898;
        Wed, 02 Oct 2019 16:58:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g5sm472581pgd.82.2019.10.02.16.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 16:58:40 -0700 (PDT)
Date:   Wed, 2 Oct 2019 16:58:39 -0700
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
Message-ID: <201910021643.75E856C@keescook>
References: <201910021341.7819A660@keescook>
 <7a5dc7aa-66ec-0249-e73f-285b8807cb73@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a5dc7aa-66ec-0249-e73f-285b8807cb73@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 10:15:43PM +0100, Robin Murphy wrote:
> Hi Kees,
> 
> On 2019-10-02 9:46 pm, Kees Cook wrote:
> > As we've seen from USB and other areas, we need to always do runtime
> > checks for DMA operating on memory regions that might be remapped. This
> > consolidates the (existing!) checks and makes them on by default. A
> > warning will be triggered for any drivers still using DMA on the stack
> > (as has been seen in a few recent reports).
> > 
> > Suggested-by: Laura Abbott <labbott@redhat.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >   include/linux/dma-debug.h   |  8 --------
> >   include/linux/dma-mapping.h |  8 +++++++-
> >   kernel/dma/debug.c          | 16 ----------------
> >   3 files changed, 7 insertions(+), 25 deletions(-)
> > 
> > diff --git a/include/linux/dma-debug.h b/include/linux/dma-debug.h
> > index 4208f94d93f7..2af9765d9af7 100644
> > --- a/include/linux/dma-debug.h
> > +++ b/include/linux/dma-debug.h
> > @@ -18,9 +18,6 @@ struct bus_type;
> >   extern void dma_debug_add_bus(struct bus_type *bus);
> > -extern void debug_dma_map_single(struct device *dev, const void *addr,
> > -				 unsigned long len);
> > -
> >   extern void debug_dma_map_page(struct device *dev, struct page *page,
> >   			       size_t offset, size_t size,
> >   			       int direction, dma_addr_t dma_addr);
> > @@ -75,11 +72,6 @@ static inline void dma_debug_add_bus(struct bus_type *bus)
> >   {
> >   }
> > -static inline void debug_dma_map_single(struct device *dev, const void *addr,
> > -					unsigned long len)
> > -{
> > -}
> > -
> >   static inline void debug_dma_map_page(struct device *dev, struct page *page,
> >   				      size_t offset, size_t size,
> >   				      int direction, dma_addr_t dma_addr)
> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index 4a1c4fca475a..2d6b8382eab1 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -583,7 +583,13 @@ static inline unsigned long dma_get_merge_boundary(struct device *dev)
> >   static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
> >   		size_t size, enum dma_data_direction dir, unsigned long attrs)
> >   {
> > -	debug_dma_map_single(dev, ptr, size);
> > +	/* DMA must never operate on stack or other remappable places. */
> > +	WARN_ONCE(is_vmalloc_addr(ptr) || !virt_addr_valid(ptr),
> 
> This stands to absolutely cripple I/O performance on arm64, because every
> valid call will end up going off and scanning the memblock list, which is
> not something we want on a fastpath in non-debug configurations. We'd need a
> much better solution to the "pfn_valid() vs. EFI no-map" problem before this
> might be viable.

Ah! Interesting. I didn't realize this was fast-path (I don't know the
DMA code at all). I thought it was more of a "one time setup" before
actual DMA activity started.

Regardless, is_vmalloc_addr() is extremely light (a bounds check), and is the
most important part of this as far as catching stack-based DMA attempts.
I thought virt_addr_valid() was cheap too, but I see it's much heavier on
arm64.

I just went to compare what the existing USB check does, and it happens
immediately before its call to dma_map_single(). Both checks are simple
bounds checks, so it shouldn't be an issue:

			if (is_vmalloc_addr(urb->setup_packet)) {
				WARN_ONCE(1, "setup packet is not dma capable\n");
				return -EAGAIN;
			} else if (object_is_on_stack(urb->setup_packet)) {
				WARN_ONCE(1, "setup packet is on stack\n");
				return -EAGAIN;
			}

			urb->setup_dma = dma_map_single(
					hcd->self.sysdev,
					urb->setup_packet,
					sizeof(struct usb_ctrlrequest),


In the USB case, it'll actually refuse to do the operation. Should
dma_map_single() similarly fail? I could push these checks down into
dma_map_single(), which would be a no-change on behavior for USB and
gain the checks on all other callers...

-- 
Kees Cook
