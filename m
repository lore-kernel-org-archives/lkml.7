Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2AAC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B02220C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733218AbfHFPut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:50:49 -0400
Received: from verein.lst.de ([213.95.11.211]:57530 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728041AbfHFPut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:50:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 125CC227A81; Tue,  6 Aug 2019 17:50:45 +0200 (CEST)
Date:   Tue, 6 Aug 2019 17:50:44 +0200
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
Message-ID: <20190806155044.GC25050@lst.de>
References: <20190805211451.20176-1-robdclark@gmail.com> <20190806084821.GA17129@lst.de> <CAJs_Fx6eh1w7c=crMoD5XyEOMzP6orLhqUewErE51cPGYmObBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJs_Fx6eh1w7c=crMoD5XyEOMzP6orLhqUewErE51cPGYmObBQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 07:11:41AM -0700, Rob Clark wrote:
> Agreed that drm_cflush_* isn't a great API.  In this particular case
> (IIUC), I need wb+inv so that there aren't dirty cache lines that drop
> out to memory later, and so that I don't get a cache hit on
> uncached/wc mmap'ing.

So what is the use case here?  Allocate pages using the page allocator
(or CMA for that matter), and then mmaping them to userspace and never
touching them again from the kernel?

> Tying it in w/ iommu seems a bit weird to me.. but maybe that is just
> me, I'm certainly willing to consider proposals or to try things and
> see how they work out.

This was just my through as the fit seems easy.  But maybe you'll
need to explain your use case(s) a bit more so that we can figure out
what a good high level API is.

> Exposing the arch_sync_* API and using that directly (bypassing
> drm_cflush_*) actually seems pretty reasonable and pragmatic.  I did
> have one doubt, as phys_to_virt() is only valid for kernel direct
> mapped memory (AFAIU), what happens for pages that are not in kernel
> linear map?  Maybe it is ok to ignore those pages, since they won't
> have an aliased mapping?

They could have an aliased mapping in vmalloc/vmap space for example,
if you created one.  We have the flush_kernel_vmap_range /
invalidate_kernel_vmap_range APIs for those, that are implement
on architectures with VIVT caches.
