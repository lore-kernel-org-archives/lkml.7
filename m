Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBE1C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1916720B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405920AbfHIIPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 04:15:00 -0400
Received: from verein.lst.de ([213.95.11.211]:53322 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfHIIPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 04:15:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8901768B05; Fri,  9 Aug 2019 10:14:55 +0200 (CEST)
Date:   Fri, 9 Aug 2019 10:14:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christoph Hellwig <hch@lst.de>, Rob Clark <robdclark@chromium.org>,
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
Subject: Re: [PATCH 1/2] drm: add cache support for arm64
Message-ID: <20190809081455.GA21967@lst.de>
References: <20190805211451.20176-1-robdclark@gmail.com> <20190806084821.GA17129@lst.de> <CAJs_Fx6eh1w7c=crMoD5XyEOMzP6orLhqUewErE51cPGYmObBQ@mail.gmail.com> <20190806155044.GC25050@lst.de> <CAJs_Fx6uztwDy2PqRy3Tc9p12k8r_ovS2tAcsMV6HqnAp=Ggug@mail.gmail.com> <20190807062545.GF6627@lst.de> <CAKMK7uH1O3q8VUftikipGH6ACPoT-8tbV1Zwo-8WL=wUHiqsoQ@mail.gmail.com> <20190808095506.GA32621@lst.de> <20190808115808.GN7444@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808115808.GN7444@phenom.ffwll.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 01:58:08PM +0200, Daniel Vetter wrote:
> > > We use shmem to get at swappable pages. We generally just assume that
> > > the gpu can get at those pages, but things fall apart in fun ways:
> > > - some setups somehow inject bounce buffers. Some drivers just give
> > > up, others try to allocate a pool of pages with dma_alloc_coherent.
> > > - some devices are misdesigned and can't access as much as the cpu. We
> > > allocate using GFP_DMA32 to fix that.
> > 
> > Well, for shmem you can't really call allocators directly, right?
> 
> We can pass gfp flags to shmem_read_mapping_page_gfp, which is just about
> enough for the 2 cases on intel platforms where the gpu can only access
> 4G, but the cpu has way more.

Right.  And that works for architectures without weird DMA offsets and
devices that exactly have a 32-bit DMA limit.  It falls flat for all
the more complex ones unfortunately.

> > But userspace malloc really means dma_map_* anyway, so not really
> > relevant for memory allocations.
> 
> It does tie in, since we'll want a dma_map which fails if a direct mapping
> isn't possible. It also helps the driver code a lot if we could use the
> same low-level flushing functions between our own memory (whatever that
> is) and anon pages from malloc. And in all the cases if it's not possible,
> we want a failure, not elaborate attempts at hiding the differences
> between all possible architectures out there.

At the very lowest level all goes down to the same three primitives we
talked about anyway, but there are different ways how they are combined.
For the streaming mappins looks at the table in arch/arc/mm/dma.c I
mentioned earlier.  For memory that is prepared for just mmaping to
userspace without a kernel user we'll always do a wb+inv.  But as the
other subthread shows we'll need to eventually look into unmapping
(or remapping with the same attributes) of that memory in kernel space
to avoid speculation bugs (or just invalid combination on x86 where
we check for that), so the API will be a little more complex.

Btw, are all DRM drivers using vmf_insert_* to pre-populate the mapping
like the MSM case, or are some doing dynamic faulting from
vm_ops->fault?
