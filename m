Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E56C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04CD32086D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbfHFIs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 04:48:28 -0400
Received: from verein.lst.de ([213.95.11.211]:54580 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728998AbfHFIs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 04:48:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5B809227A81; Tue,  6 Aug 2019 10:48:22 +0200 (CEST)
Date:   Tue, 6 Aug 2019 10:48:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>,
        Rob Clark <robdclark@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm: add cache support for arm64
Message-ID: <20190806084821.GA17129@lst.de>
References: <20190805211451.20176-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805211451.20176-1-robdclark@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This goes in the wrong direction.  drm_cflush_* are a bad API we need to
get rid of, not add use of it.  The reason for that is two-fold:

 a) it doesn't address how cache maintaince actually works in most
    platforms.  When talking about a cache we three fundamental operations:

	1) write back - this writes the content of the cache back to the
	   backing memory
	2) invalidate - this remove the content of the cache
	3) write back + invalidate - do both of the above

 b) which of the above operation you use when depends on a couple of
    factors of what you want to do with the range you do the cache
    maintainance operations

Take a look at the comment in arch/arc/mm/dma.c around line 30 that
explains how this applies to buffer ownership management.  Note that
"for device" applies to "for userspace" in the same way, just that
userspace then also needs to follow this protocol.  So the whole idea
that random driver code calls random low-level cache maintainance
operations (and use the non-specific term flush to make it all more
confusing) is a bad idea.  Fortunately enough we have really good
arch helpers for all non-coherent architectures (this excludes the
magic i915 won't be covered by that, but that is a separate issue
to be addressed later, and the fact that while arm32 did grew them
very recently and doesn't expose them for all configs, which is easily
fixable if needed) with arch_sync_dma_for_device and
arch_sync_dma_for_cpu.  So what we need is to figure out where we
have valid cases for buffer ownership transfer outside the DMA
API, and build proper wrappers around the above function for that.
My guess is it should probably be build to go with the iommu API
as that is the only other way to map memory for DMA access, but
if you have a better idea I'd be open to discussion.
