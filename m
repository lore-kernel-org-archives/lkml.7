Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313ADC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0AE120835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfD3PSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:18:53 -0400
Received: from verein.lst.de ([213.95.11.211]:47154 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD3PSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:18:52 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D457F67358; Tue, 30 Apr 2019 17:18:33 +0200 (CEST)
Date:   Tue, 30 Apr 2019 17:18:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
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
Message-ID: <20190430151833.GB25447@lst.de>
References: <20190430015521.27734-1-nicoleotsuka@gmail.com> <20190430015521.27734-2-nicoleotsuka@gmail.com> <20190430105640.GA20021@lst.de> <0e3e6d8b-de44-d23e-a039-8d11b578ec5c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e3e6d8b-de44-d23e-a039-8d11b578ec5c@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 01:37:54PM +0100, Robin Murphy wrote:
> On 30/04/2019 11:56, Christoph Hellwig wrote:
>> So while I really, really like this cleanup it turns out it isn't
>> actually safe for arm :(  arm remaps the CMA allocation in place
>> instead of using a new mapping, which can be done because they don't
>> share PMDs with the kernel.
>>
>> So we'll probably need a __dma_alloc_from_contiguous version with
>> an additional bool fallback argument - everyone but arms uses
>> dma_alloc_from_contiguous as in your patch, just arm will get the
>> non-fallback one.
>
> Or we even just implement dma_{alloc,free}_contiguous() as a wrapper around 
> the existing APIs so that users can be thoroughly checked and converted 
> one-by-one.

Yeah.  Actually given all the contention I wonder if the easiest solution
for now is to just open code the cma_alloc/cma_free calls in dma-direct
and dma-iommu, with the hopes that everyone is going to migrate to those
implementations in the mid-term anyway and dma_alloc_from_contiguous /
dma_release_from_contiguous just go away..
