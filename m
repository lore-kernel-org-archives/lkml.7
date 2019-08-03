Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7617C433FF
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 14:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B209E2075C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 14:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XkrM0lj/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfHCOrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 10:47:21 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:38596 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfHCOrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 10:47:21 -0400
Received: by mail-io1-f47.google.com with SMTP id j6so38837645ioa.5
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2019 07:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MMP3XKfq/hVIdegHeWON3FjgCQoKuCyDOKRrc6VbHEg=;
        b=XkrM0lj/1vIfMQv9DtntirhXSAHlyvsnrKsI7ibOyW2d811N+fVzdc98V94Fvvaddo
         E2cVbOUFjkbLELYw1oJFMbJO9uTF/X/wNoB/ehY3m9j/OZazv4Lx8zaY3Roje6I3JQKQ
         tyS32CqFgdfKHfJ8DYN6Kj3mwVYHiJg+xNla4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MMP3XKfq/hVIdegHeWON3FjgCQoKuCyDOKRrc6VbHEg=;
        b=DyFOIfulWAiwgQ5bsnFy5f5CW/hXWfOnCjVcOZiKbDQYLiwdpSSG2JJE6D3ofzMolQ
         BeShNjETuRBZtMgaqu5WZe8dqUI9wO5wa5cbXn7euOafq7eiYhyc38oPOm84IJrnHbAt
         LjqScBmNbT8sgHBkJYiTTvhaRhcPC568siPdf6ILxuL1o3ZaVYjbr3RaEOWDozvadfBL
         T1fAPMXSvZ1FqumbmJOS6zIFZiOBJU70U6egf8JZJul10glHQeCLgWDfmQMTpKRPDoic
         jrzNOrRR20VMGdHOTN7fvA4Iqce9VXIRWpbP6iGkk+oipgGqNxLgUrsOZLK+vlIkueNp
         UTdw==
X-Gm-Message-State: APjAAAUiWW67FHGVj+o1Mu3FGSPJSHfML+e3RWBDzkxvMgcGMcQdwYcN
        frAHPUp4+In5iberNAiW5t80ox7f/tIEHtlTJoqPrA==
X-Google-Smtp-Source: APXvYqwA8gHeBOJ1xj6OCVE6XCHSbym6IKdiWAB8Hjqrg0fEQo3v4WmqHisVkKXXXTcF7ID7nGDNzh22d99fwAEKpWk=
X-Received: by 2002:a5e:9747:: with SMTP id h7mr9539731ioq.299.1564843639974;
 Sat, 03 Aug 2019 07:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190802213756.GA20033@lst.de> <CAJs_Fx45VtKe52eTuAUcqSUTrY=892OwhCZNrLGoQHHBwETCdQ@mail.gmail.com>
 <20190803061916.GA29348@lst.de>
In-Reply-To: <20190803061916.GA29348@lst.de>
From:   Rob Clark <robdclark@chromium.org>
Date:   Sat, 3 Aug 2019 07:47:08 -0700
Message-ID: <CAJs_Fx5r0qbtJPC+roiXaWz0SbPVtnDyWun6TB6a3HhQAEfk3A@mail.gmail.com>
Subject: Re: please revert "drm/msm: Use the correct dma_sync calls in msm_gem"
To:     Christoph Hellwig <hch@lst.de>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Sean Paul <seanpaul@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 2, 2019 at 11:19 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Aug 02, 2019 at 03:06:10PM -0700, Rob Clark wrote:
> > Sorry, this is just a temporary band-aid for v5.3 to get things
> > working again.  Yes, I realize it is a complete hack.
>
> My main problem is here that you badly hack a around a problem without
> talking to the relevant maintainers, and by abusing even more internal
> APIs.  As said get_dma_ops isn't really for driver use (although we
> have a few that use it for not quite as bad reason we are trying to get
> rid off).  And as also said your abuse of the DMA API will blow up
> with dma-debug use quite badly.  You might also corrupt the dma_address
> in the scatterlist in ways that aren't intended - as the call to
> dma_map_sg will allocate new iova space you are getting different
> results from whatever you expect to actually get from your iommu API
> usage.  This might or might no matter in the end, but you really should
> consult the maintainers first.
>
> > The root problem is that I'm using the DMA API in the first place.  I
> > don't actually use the DMA API to map buffers, for various reasons,
> > but instead manage the iommu_domain directly.
>
> Yes, and this has been going on for years, without any obvious attempt
> to address it at the API level before..

99% of my time goes to mesa and r/e, so having the argument about
dealing w/ cache directly simply wasn't a big enough fire to deal with
until now, unfortunately.

(Admittedly, there is room here for someone with more bandwidth to
take on drm/msm maintainer role.. but someone needs to do it.  Sean
has been pitching in on the display side more recently, which has been
a big help.)

> > Because arm/arm64 cache ops are not exported to modules, so currently
> > I need to abuse the DMA API for cache operations (really just to clean
> > pages if I need to mmap them uncached/writecombine).  Originally I was
> > doing that w/ dma_{map,unmap}_sg.  But to avoid debug splats I
> > switched that to dma_sync_sg (see
> > 0036bc73ccbe7e600a3468bf8e8879b122252274).  But now it seems the
> > dma-direct ops are unhappy w/ dma_sync without a dma_map (AFAICT).
>
> Russell has been very strict about not exporting the cache ops, and all
> for the right reasons.  Cache maintainance for not dma coherent devices
> is hard, and without a proper API that has arch input for even which
> calls are used for cache flushing chances of bugs are extremely high.
>
> I see two proper ways out of this mess:  either we actually make msm
> use the DMA API, so I'd be curious of what is missing that forces you
> to use the low-level iommu API.  Or we need to enhance the iommu API
> with a similar ownership concepts as the DMA API.  Which probably is
> a good thing even if we move msm over to the DMA API.

There are a few reasons we need to manage the GPU's address space
directly, most of which are stalled on some iommu changes, that I wish
I had more time to push for.  In particular, we need to move to
per-context pagetables (so each GL context has it's own GPU address
space).  Once we get there, we'd also like to enable SVM/SVA so GPU
can share address space with the userspace process (which requires
stall/resume and iommu fault handler to run in a context that can
sleep).

Fitting that into the DMA API doesn't really make sense to me.

I'm not entirely sure that fitting cache maintenance into the IOMMU
makes a huge amount of sense either, since the issue is really about
the CPU cache.  And I doubt the GPU is going to fit into a nice policy
of page ownership.  There are a number of cases where both CPU and GPU
are accessing the same buffers, and unmapping/remapping to iommu is
either not possible (because GPU is actively accessing another part of
the buffer) or prohibitive from a performance standpoint.

As far as cache maintenance being hard, I'm not really sure I buy
that.. at least not for arm64.  (And probably not even w/ the limited
# of armv7 cores that can be paired with drm/msm.)

> > (On some generations of hw, the iommu is attached to the device node
> > that maps to the drm device, which is passed to dma_map/dma_sync.  On
> > other generations the iommu is attached to a sub-device.  Changing
> > this would break dtb compatibility.. so for now I need to handle both
> > iommu-ops and direct-ops cases.)
>
> Or you always call call on a struct device that has the iommu, that
> is match on the generic, and pick a different device.  That would in
> many ways seem preferably over the current hack, even if that also is
> just a horribly band-aid.

I suppose picking a device w/ iommu would *mostly* work, except for
a2xx (which has no IOMMU, but has it's own internal GPUMMU instead..
so there is no device with iommu ops)

We could perhaps, based on compatible, set a flag to use either
dma_sync_* or dma_map_* which would avoid using get_dma_ops() (but
otherwise doesn't seem like much of an improvement, I guess)

BR,
-R
