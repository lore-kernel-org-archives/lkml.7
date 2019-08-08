Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9DBC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7979A21874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732231AbfHHKAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 06:00:37 -0400
Received: from verein.lst.de ([213.95.11.211]:45231 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbfHHKAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 06:00:36 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DE187227A81; Thu,  8 Aug 2019 12:00:31 +0200 (CEST)
Date:   Thu, 8 Aug 2019 12:00:31 +0200
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
Message-ID: <20190808100031.GA32658@lst.de>
References: <20190805211451.20176-1-robdclark@gmail.com> <20190806084821.GA17129@lst.de> <CAJs_Fx6eh1w7c=crMoD5XyEOMzP6orLhqUewErE51cPGYmObBQ@mail.gmail.com> <20190806155044.GC25050@lst.de> <CAJs_Fx6uztwDy2PqRy3Tc9p12k8r_ovS2tAcsMV6HqnAp=Ggug@mail.gmail.com> <20190807062545.GF6627@lst.de> <CAJs_Fx7tqbr_gqRdqJEwOcRFReP0DqZzOu11Dxhxkp8+PygUQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJs_Fx7tqbr_gqRdqJEwOcRFReP0DqZzOu11Dxhxkp8+PygUQw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 09:09:53AM -0700, Rob Clark wrote:
> > > (Eventually I'd like to support pages passed in from userspace.. but
> > > that is down the road.)
> >
> > Eww.  Please talk to the iommu list before starting on that.
> 
> This is more of a long term goal, we can't do it until we have
> per-context/process pagetables, ofc.
> 
> Getting a bit off topic, but I'm curious about what problems you are
> concerned about.  Userspace can shoot it's own foot, but if it is not
> sharing GPU pagetables with other processes, it can't shoot other's
> feet.  (I'm guessing you are concerned about non-page-aligned
> mappings?)

Maybe I misunderstood what you mean above, I though you mean messing
with page cachability attributes for userspace pages.  If what you are
looking into is just "standard" SVM I only hope that our APIs for that
which currently are a mess are in shape by then, as all users currently
have their own crufty and at least slightly buggy versions of that.  But
at least it is an issue that is being worked on.

> > So back to the question, I'd like to understand your use case (and
> > maybe hear from the other drm folks if that is common):
> >
> >  - you allocate pages from shmem (why shmem, btw?  if this is done by
> >    other drm drivers how do they guarantee addressability without an
> >    iommu?)
> 
> shmem for swappable pages.  I don't unpin and let things get swapped
> out yet, but I'm told it starts to become important when you have 50
> browser tabs open ;-)

Yes,  but at that point the swapping can use the kernel linear mapping
and we are going into aliasing problems that can disturb the cache.  So
as-is this is going to problematic without new hooks into shmemfs.

> >  - then the memory is either mapped to userspace or vmapped (or even
> >    both, althrough the lack of aliasing you mentioned would speak
> >    against it) as writecombine (aka arm v6+ normal uncached).  Does
> >    the mapping live on until the memory is freed?
> 
> (side note, *most* of the drm/msm supported devices are armv8, the
> exceptions are 8060 and 8064 which are armv7.. I don't think drm/msm
> will ever have to deal w/ armv6)

Well, the point was that starting from v6 the kernels dma uncached
really is write combine.  So that applied to v7 and v8 as well.
