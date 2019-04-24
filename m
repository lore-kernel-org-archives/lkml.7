Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4C8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444112084F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731315AbfDXPG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:06:56 -0400
Received: from verein.lst.de ([213.95.11.211]:54541 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbfDXPG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:06:56 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id EB16368AA6; Wed, 24 Apr 2019 17:06:38 +0200 (CEST)
Date:   Wed, 24 Apr 2019 17:06:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     hch@lst.de, robin.murphy@arm.com, vdumpa@nvidia.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, joro@8bytes.org, m.szyprowski@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, tony@atomide.com
Subject: Re: [PATCH v2 RFC/RFT 1/5] ARM: dma-mapping: Add fallback normal
 page allocations
Message-ID: <20190424150638.GA22191@lst.de>
References: <20190326230131.16275-1-nicoleotsuka@gmail.com> <20190326230131.16275-2-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326230131.16275-2-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 04:01:27PM -0700, Nicolin Chen wrote:
>  	page = dma_alloc_from_contiguous(dev, count, order, gfp & __GFP_NOWARN);
> +	if (!page)
> +		page = alloc_pages(gfp, order);

We have this fallback in most callers already.  And with me adding
it to the dma-iommu code in one series, and you to arm here I think
we really need to take a step back and think of a better way
to handle this, and the general mess that dma_alloc_from_contiguous.

So what about:

 (1) change the dma_alloc_from_contiguous prototype to be:

struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp);

     that is: calculate order and count internally, pass the full gfp_t
     and mask it internally, and drop the pointless from in the name.
     I'd also use the oppurtunity to forbid a NULL dev argument and
     opencode those uses.
 
 (2) handle the alloc_pages fallback internally.  Note that we should
     use alloc_pages_node as we do in dma-direct.

> +			if (!dma_release_from_contiguous(dev, page, count))
> +				__free_pages(page, get_order(size));

Same for dma_release_from_contiguous - drop the _from, pass the
actual size, and handle the free_pages fallback.
