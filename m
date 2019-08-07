Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E1AC32754
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B324C22324
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VzZ/k+WN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387760AbfHGItK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:49:10 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38162 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387649AbfHGItK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:49:10 -0400
Received: by mail-ot1-f65.google.com with SMTP id d17so101357936oth.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 01:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T81jo3bu6m4G57eeMXxphqH+l+0vNlO7yTI3xodpqPI=;
        b=VzZ/k+WNyCuM2f1dJQ03+NI1UkAik3fFROb31bJVDnPPAZOSPcylhaCzalryzu9DPv
         YhKdlzglWiTsBwJ7cvfxH6+Mj/PGuIF+CuWeFKJxRfFHVq1h6EY5vqis+niVIuRIS5mk
         190cRetnRdel+ZI8AXXYLVx8KIwjJUrhBPvUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T81jo3bu6m4G57eeMXxphqH+l+0vNlO7yTI3xodpqPI=;
        b=NrTXdoT4x92/ZxhxcY7uFM2tlq+yReWP5WLi+4SR1vtaaLAkOhylLhywXJMeEqEmnS
         Yg6p0uKQkOh2C7VqCCXM74AjmPro9nfiGOqQDmd6yY+S/zLshCwDyxLG8yv4dCt6NFzu
         9m25f7v5cvO1IOO/XhCuyojx7n8X02GPKt/MC6qY4Mw/SaaJisUMU2DzFyEmiaS4PX1z
         g4jGOdB5r0X9FGGLNZQ/qA9YcNpXUwjQV76ll9xcXWVWKPOzS2PNtfJa+Z99UYsZu5Gp
         T52ez9mHTSkKNRjGNWOclGANzcA7zxqew52gSwrPuLxtKCHE5iRXhnGTPN4xfFhsgWnu
         u7yg==
X-Gm-Message-State: APjAAAX4D3Twa1xwxuByr3re+p1sX+V4xbAZ4NLLRXkTRN6JZHpmjusa
        6K0jz+xnTRgWBFuu45yf/2j0ntEGrv2bQHxuPagU3g==
X-Google-Smtp-Source: APXvYqwVAPf2IGHO0oTry32QAj0SqfjmXrfGG+CXng41fJ63s62HG8IRd79JpZudl3h1OzpVmIpGS4CtyXSlXyxSzKs=
X-Received: by 2002:aca:b104:: with SMTP id a4mr5382980oif.14.1565167748729;
 Wed, 07 Aug 2019 01:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190805211451.20176-1-robdclark@gmail.com> <20190806084821.GA17129@lst.de>
 <CAJs_Fx6eh1w7c=crMoD5XyEOMzP6orLhqUewErE51cPGYmObBQ@mail.gmail.com>
 <20190806155044.GC25050@lst.de> <CAJs_Fx6uztwDy2PqRy3Tc9p12k8r_ovS2tAcsMV6HqnAp=Ggug@mail.gmail.com>
 <20190807062545.GF6627@lst.de>
In-Reply-To: <20190807062545.GF6627@lst.de>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 7 Aug 2019 10:48:56 +0200
Message-ID: <CAKMK7uH1O3q8VUftikipGH6ACPoT-8tbV1Zwo-8WL=wUHiqsoQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm: add cache support for arm64
To:     Christoph Hellwig <hch@lst.de>
Cc:     Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 8:25 AM Christoph Hellwig <hch@lst.de> wrote:
> On Tue, Aug 06, 2019 at 09:23:51AM -0700, Rob Clark wrote:
> > On Tue, Aug 6, 2019 at 8:50 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Tue, Aug 06, 2019 at 07:11:41AM -0700, Rob Clark wrote:
> > > > Agreed that drm_cflush_* isn't a great API.  In this particular case
> > > > (IIUC), I need wb+inv so that there aren't dirty cache lines that drop
> > > > out to memory later, and so that I don't get a cache hit on
> > > > uncached/wc mmap'ing.
> > >
> > > So what is the use case here?  Allocate pages using the page allocator
> > > (or CMA for that matter), and then mmaping them to userspace and never
> > > touching them again from the kernel?
> >
> > Currently, it is pages coming from tmpfs.  Ideally we want pages that
> > are swappable when unpinned.
>
> tmpfs is basically a (complicated) frontend for alloc pages as far
> as page allocation is concerned.
>
> > CPU mappings are *mostly* just mapping to userspace.  There are a few
> > exceptions that are vmap'd (fbcon, and ringbuffer).
>
> And those use the same backend?
>
> > (Eventually I'd like to support pages passed in from userspace.. but
> > that is down the road.)
>
> Eww.  Please talk to the iommu list before starting on that.
>
> > > > Tying it in w/ iommu seems a bit weird to me.. but maybe that is just
> > > > me, I'm certainly willing to consider proposals or to try things and
> > > > see how they work out.
> > >
> > > This was just my through as the fit seems easy.  But maybe you'll
> > > need to explain your use case(s) a bit more so that we can figure out
> > > what a good high level API is.
> >
> > Tying it to iommu_map/unmap would be awkward, as we could need to
> > setup cpu mmap before it ends up mapped to iommu.  And the plan to
> > support per-process pagetables involved creating an iommu_domain per
> > userspace gl context.. some buffers would end up mapped into multiple
> > contexts/iommu_domains.
> >
> > If the cache operation was detached from iommu_map/unmap, then it
> > would seem weird to be part of the iommu API.
> >
> > I guess I'm not entirely sure what you had in mind, but this is why
> > iommu seemed to me like a bad fit.
>
> So back to the question, I'd like to understand your use case (and
> maybe hear from the other drm folks if that is common):

Filling in a bunch more of the use-cases we have in drm. Don't need to
solve them all right away ofc, but whatever direction we're aiming for
should keep these in mind I think.

>  - you allocate pages from shmem (why shmem, btw?  if this is done by
>    other drm drivers how do they guarantee addressability without an
>    iommu?)

We use shmem to get at swappable pages. We generally just assume that
the gpu can get at those pages, but things fall apart in fun ways:
- some setups somehow inject bounce buffers. Some drivers just give
up, others try to allocate a pool of pages with dma_alloc_coherent.
- some devices are misdesigned and can't access as much as the cpu. We
allocate using GFP_DMA32 to fix that.

Also modern gpu apis pretty much assume you can malloc() and then use
that directly with the gpu.

>  - then the memory is either mapped to userspace or vmapped (or even
>    both, althrough the lack of aliasing you mentioned would speak
>    against it) as writecombine (aka arm v6+ normal uncached).  Does
>    the mapping live on until the memory is freed?

Generally we cache mappings forever. Some exceptions for 32bit
userspace excluded, where people expect to be able to use more than
4GB of textures somehow, so we have to recycle old mappings. Obviously
applies less to gpus on socs.

Also, at least i915 also has writeback userspace mmaps, and userspace
doing the cflushing. Also not sure I ever mentioned this, but at least
i915 userspace controls the coherency mode of the device dma directly,
on a per-op granularity. For buffers shared with other processes it
defers to the gpu pagetables, which the kernel controls.

>  - as you mention swapping - how do you guarantee there are no
>    aliases in the kernel direct mapping after the page has been swapped
>    in?

No idea personally, since we can ignore this on x86. I think atm
there's not a huge overlap of gpu drivers doing swapping and running
on something like arm where incompatible aliased mappings are bad.

>  - then the memory is potentially mapped to the iommu.  Is it using
>    a long-living mapping, or does get unmapped/remapped repeatedly?

Again, generally cached for as long as possible, until we run out of
space/memory somewhere.
-Daniel
--
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
