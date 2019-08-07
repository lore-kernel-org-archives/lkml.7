Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AB7C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F302229C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BXAaSO0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388963AbfHGQKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:10:06 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33050 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729960AbfHGQKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:10:06 -0400
Received: by mail-ot1-f68.google.com with SMTP id q20so106339537otl.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 09:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wsthQu2QfAQEyfTgzCODadqkB3TT/99Z+5eL+7UiyVQ=;
        b=BXAaSO0gMR6cIg4Fgcqgz5JRNjU0CWl9D7rFFlMWR9fYSw3fx70pTWQmqBu/TXrO/O
         +2f67Q6wQjoZuqWpkqedEoIquPJYIU006KqDEvmmgFPiMRuCBxOUbVH+AjSnZeB10F58
         nGsCwcW3m2h6lU6Ei6/vgorIrgyZLVvE29N2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wsthQu2QfAQEyfTgzCODadqkB3TT/99Z+5eL+7UiyVQ=;
        b=Jf8S2R4dg4n+DG15k4BzKTosK3izY65N7F+klu8behChJUPL+YVEjE9++MFUaoKkAB
         qIFFKG9Ol/XGHOFhSf2M9r5w6yoyKgOwr7CcM9NM7VVyDXY/4Xk+IRoE9jodUxP7sq5g
         TCGyUcvJfg2mUBu8/8tFTo4RpQ4qDTkSinilR0F93i0ggtYs+kcRSlQf0WOPBQ8dHPze
         +ZU4s8NzWR743nvlr2g5sirT4TBj/J0VZblihpRaw7+6BpvJF8JrcQzEhpfGOmWpA1eX
         JO1dNmdr0mCys0pfpPbl1sFYNu7+xrrvGMdXExIV7ldAoDM4sUFWJsgf3GaN6knYUTpr
         3AMA==
X-Gm-Message-State: APjAAAXGuSBbEhWYBgWNGxjyAcTaOR56D9EtXzWAnKhl7kUb5j5piqO+
        fmoYve+xGH205KFzEGdqfaBr+VzfM8+N5B0Lx60qyA==
X-Google-Smtp-Source: APXvYqwojz9eSov1PXUTI/zpOp1ExSls/bfkUhbDuFqllq8EBa7KKJoLrr+LBs09AKnPc4X1TsiBh9hb7d2Dqng/bck=
X-Received: by 2002:a02:c487:: with SMTP id t7mr10812421jam.99.1565194204750;
 Wed, 07 Aug 2019 09:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190805211451.20176-1-robdclark@gmail.com> <20190806084821.GA17129@lst.de>
 <CAJs_Fx6eh1w7c=crMoD5XyEOMzP6orLhqUewErE51cPGYmObBQ@mail.gmail.com>
 <20190806155044.GC25050@lst.de> <CAJs_Fx6uztwDy2PqRy3Tc9p12k8r_ovS2tAcsMV6HqnAp=Ggug@mail.gmail.com>
 <20190807062545.GF6627@lst.de>
In-Reply-To: <20190807062545.GF6627@lst.de>
From:   Rob Clark <robdclark@chromium.org>
Date:   Wed, 7 Aug 2019 09:09:53 -0700
Message-ID: <CAJs_Fx7tqbr_gqRdqJEwOcRFReP0DqZzOu11Dxhxkp8+PygUQw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm: add cache support for arm64
To:     Christoph Hellwig <hch@lst.de>
Cc:     Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 11:25 PM Christoph Hellwig <hch@lst.de> wrote:
>
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

yes

> > (Eventually I'd like to support pages passed in from userspace.. but
> > that is down the road.)
>
> Eww.  Please talk to the iommu list before starting on that.

This is more of a long term goal, we can't do it until we have
per-context/process pagetables, ofc.

Getting a bit off topic, but I'm curious about what problems you are
concerned about.  Userspace can shoot it's own foot, but if it is not
sharing GPU pagetables with other processes, it can't shoot other's
feet.  (I'm guessing you are concerned about non-page-aligned
mappings?)

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
>
>  - you allocate pages from shmem (why shmem, btw?  if this is done by
>    other drm drivers how do they guarantee addressability without an
>    iommu?)

shmem for swappable pages.  I don't unpin and let things get swapped
out yet, but I'm told it starts to become important when you have 50
browser tabs open ;-)

There are some display-only drm drivers with no IOMMU, which use CMA
rather than shmem.  Basically every real GPU has some form of MMU or
IOMMU for memory protection.  (The couple exceptions do expensive
kernel side cmdstream validation.)

>  - then the memory is either mapped to userspace or vmapped (or even
>    both, althrough the lack of aliasing you mentioned would speak
>    against it) as writecombine (aka arm v6+ normal uncached).  Does
>    the mapping live on until the memory is freed?

(side note, *most* of the drm/msm supported devices are armv8, the
exceptions are 8060 and 8064 which are armv7.. I don't think drm/msm
will ever have to deal w/ armv6)

Userspace keeps the userspace mmap around opportunistically (once it
is mmap'd, not all buffers will be accessed from CPU).  In fact there
is a userspace buffer cache, where we try to re-use buffers that are
already allocated and possibly mmap'd, since allocation and setting up
mmap is expensive.

(There is an MADVISE ioctl so userspace can tell kernel about buffers
in the cache, which are available to be purged by shrinker..  if a
buffer is purged, it's userspace mmap is torn down... along with it's
IOMMU map, ofc)

>  - as you mention swapping - how do you guarantee there are no
>    aliases in the kernel direct mapping after the page has been swapped
>    in?

Before unpinning and allowing pages to be swapped out, CPU and IOMMU
maps would be torn down.  (I don't think we could unpin buffers w/ a
vmap, but those are just a drop in the bucket.)

Currently, the kernel always knows buffers associated w/ a submit
(job) queued to the GPU, so it could bring pages back in and re-store
iommu map.. the fault handler can be used to bring things back in for
CPU access.  (For more free-form HMM style access to userspace memory,
we'd need to be able to sleep in IOMMU fault handler before the IOMMU
resumes translation.)

As far as cache is concerned, it would be basically the same as newly
allocated pages, ie. need to wb+inv the new pages.

>  - then the memory is potentially mapped to the iommu.  Is it using
>    a long-living mapping, or does get unmapped/remapped repeatedly?

Similar to CPU maps, we keep the IOMMU map around as long as possible.

(Side note, I was thinking batching unmaps could be useful to reduce
IOMMU TLB inv overhead.. usually when we are freeing a buffer, we are
freeing multiple, so we could unmap them all, then TLB inv, then free
pages.)

BR,
-R
