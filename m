Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5691C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766B621479
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731885AbfHHJzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 05:55:13 -0400
Received: from verein.lst.de ([213.95.11.211]:45154 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731550AbfHHJzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:55:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2AB2168AFE; Thu,  8 Aug 2019 11:55:07 +0200 (CEST)
Date:   Thu, 8 Aug 2019 11:55:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Christoph Hellwig <hch@lst.de>, Rob Clark <robdclark@chromium.org>,
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
Message-ID: <20190808095506.GA32621@lst.de>
References: <20190805211451.20176-1-robdclark@gmail.com> <20190806084821.GA17129@lst.de> <CAJs_Fx6eh1w7c=crMoD5XyEOMzP6orLhqUewErE51cPGYmObBQ@mail.gmail.com> <20190806155044.GC25050@lst.de> <CAJs_Fx6uztwDy2PqRy3Tc9p12k8r_ovS2tAcsMV6HqnAp=Ggug@mail.gmail.com> <20190807062545.GF6627@lst.de> <CAKMK7uH1O3q8VUftikipGH6ACPoT-8tbV1Zwo-8WL=wUHiqsoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uH1O3q8VUftikipGH6ACPoT-8tbV1Zwo-8WL=wUHiqsoQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 10:48:56AM +0200, Daniel Vetter wrote:
> >    other drm drivers how do they guarantee addressability without an
> >    iommu?)
> 
> We use shmem to get at swappable pages. We generally just assume that
> the gpu can get at those pages, but things fall apart in fun ways:
> - some setups somehow inject bounce buffers. Some drivers just give
> up, others try to allocate a pool of pages with dma_alloc_coherent.
> - some devices are misdesigned and can't access as much as the cpu. We
> allocate using GFP_DMA32 to fix that.

Well, for shmem you can't really call allocators directly, right?

One thing I have in my pipeline is a dma_alloc_pages API that allocates
pages that are guaranteed to be addressably by the device or otherwise
fail.  But that doesn't really help with the shmem fs.

> Also modern gpu apis pretty much assume you can malloc() and then use
> that directly with the gpu.

Which is fine as long as the GPU itself supports full 64-bit addressing
(or always sits behind an iommu), and the platform doesn't impose
addressing limit, which unfortunately some that are shipped right now
still do :(

But userspace malloc really means dma_map_* anyway, so not really
relevant for memory allocations.
