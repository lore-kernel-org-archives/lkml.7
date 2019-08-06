Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A08BC32751
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 05:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B46D2147A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 05:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbfHFFMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 01:12:47 -0400
Received: from verein.lst.de ([213.95.11.211]:53003 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfHFFMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 01:12:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8410D68B05; Tue,  6 Aug 2019 07:12:42 +0200 (CEST)
Date:   Tue, 6 Aug 2019 07:12:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Gavin Li <gavinli@thegavinli.com>
Cc:     Christoph Hellwig <hch@lst.de>, Shawn Anastasio <shawn@anastas.io>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Gavin Li <git@thegavinli.com>
Subject: Re: [PATCH 1/2] dma-mapping: fix page attributes for dma_mmap_*
Message-ID: <20190806051242.GA13269@lst.de>
References: <20190805080145.5694-1-hch@lst.de> <20190805080145.5694-2-hch@lst.de> <CAP_+7SzPdNCMKuuXMjHjpCzxsey2YWR_e6mTAWtNSZ6kKBvKFw@mail.gmail.com> <CA+GxvY5C_rrukCzC5K-h72bePyW8PS_Rfj3uxh-K6UrcAextUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+GxvY5C_rrukCzC5K-h72bePyW8PS_Rfj3uxh-K6UrcAextUQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 07:55:44PM -0700, Gavin Li wrote:
> >         /* create a coherent mapping */
> >         ret = dma_common_contiguous_remap(page, size, VM_USERMAP,
> > -                       arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs),
> > +                       dma_pgprot(dev, PAGE_KERNEL, attrs),
> >                         __builtin_return_address(0));
> >         if (!ret) {
> >                 __dma_direct_free_pages(dev, size, page);
> 
> Is dma_common_contiguous_remap() still necessary in the
> DMA_ATTR_NON_CONSISTENT case? I would presume it would be fine to just
> return a linearly mapped address in that case.

It would not be required for a real DMA_ATTR_NON_CONSISTENT
implementation.  But only parisc and mips actually properly implement
DMA_ATTR_NON_CONSISTENT, everyone ignores it.  Given that the API is
a little ill defined and I have a better replacement in the pipeline
I don't want to start implementing it for other architectures now.
