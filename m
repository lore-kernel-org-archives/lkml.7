Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518FCC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209E320835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfD3PVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:21:18 -0400
Received: from verein.lst.de ([213.95.11.211]:47185 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfD3PVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:21:17 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 18DE167358; Tue, 30 Apr 2019 17:20:59 +0200 (CEST)
Date:   Tue, 30 Apr 2019 17:20:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Nicolin Chen <nicoleotsuka@gmail.com>, hch@lst.de,
        m.szyprowski@samsung.com, vdumpa@nvidia.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, chris@zankel.net,
        jcmvbkbc@gmail.com, joro@8bytes.org, dwmw2@infradead.org,
        tony@atomide.com, akpm@linux-foundation.org, sfr@canb.auug.org.au,
        treding@nvidia.com, keescook@chromium.org, iamjoonsoo.kim@lge.com,
        wsa+renesas@sang-engineering.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org
Subject: Re: [RFC/RFT PATCH 1/2] dma-contiguous: Simplify
 dma_*_from_contiguous() function calls
Message-ID: <20190430152058.GC25447@lst.de>
References: <20190430015521.27734-1-nicoleotsuka@gmail.com> <20190430015521.27734-2-nicoleotsuka@gmail.com> <d43e1cfe-1d12-c0c6-d76b-81330918d9ab@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d43e1cfe-1d12-c0c6-d76b-81330918d9ab@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 01:52:26PM +0100, Robin Murphy wrote:
> As Catalin pointed out before, many of the users above may still have 
> implicit assumptions about the default CMA area, i.e. that this won't 
> return something above the limit they originally passed to 
> dma_contiguous_reserve(). I'm not sure how straightforward that is to 
> resolve - at the very least we may have to monkey around with GFP_DMA{32} 
> flags based on where dma_contiguous_default_area lies :(

Or just convert the callers one by one.  The two most interesting ones
are dma-direct which always check addressability after the allocation,
and dma-iommu, which doesn't care.  dma-iommu.c and intel-iommu.c also
don't care, but should use dma-iommu by next merge window anyway,
which leaves arm which is so complicated that we better don't touch
it for now, and xtensa, which I hope to switch to dma-direct in the
next merge window or two.
