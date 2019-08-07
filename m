Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED67C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 06:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95D9214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 06:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfHGGZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 02:25:51 -0400
Received: from verein.lst.de ([213.95.11.211]:34817 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbfHGGZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 02:25:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D947B68B05; Wed,  7 Aug 2019 08:25:45 +0200 (CEST)
Date:   Wed, 7 Aug 2019 08:25:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Rob Clark <robdclark@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>, Rob Clark <robdclark@gmail.com>,
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
Subject: Re: [PATCH 1/2] drm: add cache support for arm64
Message-ID: <20190807062545.GF6627@lst.de>
References: <20190805211451.20176-1-robdclark@gmail.com> <20190806084821.GA17129@lst.de> <CAJs_Fx6eh1w7c=crMoD5XyEOMzP6orLhqUewErE51cPGYmObBQ@mail.gmail.com> <20190806155044.GC25050@lst.de> <CAJs_Fx6uztwDy2PqRy3Tc9p12k8r_ovS2tAcsMV6HqnAp=Ggug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJs_Fx6uztwDy2PqRy3Tc9p12k8r_ovS2tAcsMV6HqnAp=Ggug@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 09:23:51AM -0700, Rob Clark wrote:
> On Tue, Aug 6, 2019 at 8:50 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Tue, Aug 06, 2019 at 07:11:41AM -0700, Rob Clark wrote:
> > > Agreed that drm_cflush_* isn't a great API.  In this particular case
> > > (IIUC), I need wb+inv so that there aren't dirty cache lines that drop
> > > out to memory later, and so that I don't get a cache hit on
> > > uncached/wc mmap'ing.
> >
> > So what is the use case here?  Allocate pages using the page allocator
> > (or CMA for that matter), and then mmaping them to userspace and never
> > touching them again from the kernel?
> 
> Currently, it is pages coming from tmpfs.  Ideally we want pages that
> are swappable when unpinned.

tmpfs is basically a (complicated) frontend for alloc pages as far
as page allocation is concerned.

> CPU mappings are *mostly* just mapping to userspace.  There are a few
> exceptions that are vmap'd (fbcon, and ringbuffer).

And those use the same backend?

> (Eventually I'd like to support pages passed in from userspace.. but
> that is down the road.)

Eww.  Please talk to the iommu list before starting on that.

> > > Tying it in w/ iommu seems a bit weird to me.. but maybe that is just
> > > me, I'm certainly willing to consider proposals or to try things and
> > > see how they work out.
> >
> > This was just my through as the fit seems easy.  But maybe you'll
> > need to explain your use case(s) a bit more so that we can figure out
> > what a good high level API is.
> 
> Tying it to iommu_map/unmap would be awkward, as we could need to
> setup cpu mmap before it ends up mapped to iommu.  And the plan to
> support per-process pagetables involved creating an iommu_domain per
> userspace gl context.. some buffers would end up mapped into multiple
> contexts/iommu_domains.
> 
> If the cache operation was detached from iommu_map/unmap, then it
> would seem weird to be part of the iommu API.
> 
> I guess I'm not entirely sure what you had in mind, but this is why
> iommu seemed to me like a bad fit.

So back to the question, I'd like to understand your use case (and
maybe hear from the other drm folks if that is common):

 - you allocate pages from shmem (why shmem, btw?  if this is done by
   other drm drivers how do they guarantee addressability without an
   iommu?)
 - then the memory is either mapped to userspace or vmapped (or even
   both, althrough the lack of aliasing you mentioned would speak
   against it) as writecombine (aka arm v6+ normal uncached).  Does
   the mapping live on until the memory is freed?
 - as you mention swapping - how do you guarantee there are no
   aliases in the kernel direct mapping after the page has been swapped
   in?
 - then the memory is potentially mapped to the iommu.  Is it using
   a long-living mapping, or does get unmapped/remapped repeatedly?
 
