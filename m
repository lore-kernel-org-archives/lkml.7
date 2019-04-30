Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4AAC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16392075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfD3MiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 08:38:01 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46340 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbfD3MiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 08:38:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7007B15A2;
        Tue, 30 Apr 2019 05:38:00 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE0783F5AF;
        Tue, 30 Apr 2019 05:37:56 -0700 (PDT)
Subject: Re: [RFC/RFT PATCH 1/2] dma-contiguous: Simplify
 dma_*_from_contiguous() function calls
To:     Christoph Hellwig <hch@lst.de>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     m.szyprowski@samsung.com, vdumpa@nvidia.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, chris@zankel.net,
        jcmvbkbc@gmail.com, joro@8bytes.org, dwmw2@infradead.org,
        tony@atomide.com, akpm@linux-foundation.org, sfr@canb.auug.org.au,
        treding@nvidia.com, keescook@chromium.org, iamjoonsoo.kim@lge.com,
        wsa+renesas@sang-engineering.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org
References: <20190430015521.27734-1-nicoleotsuka@gmail.com>
 <20190430015521.27734-2-nicoleotsuka@gmail.com>
 <20190430105640.GA20021@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <0e3e6d8b-de44-d23e-a039-8d11b578ec5c@arm.com>
Date:   Tue, 30 Apr 2019 13:37:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430105640.GA20021@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2019 11:56, Christoph Hellwig wrote:
> So while I really, really like this cleanup it turns out it isn't
> actually safe for arm :(  arm remaps the CMA allocation in place
> instead of using a new mapping, which can be done because they don't
> share PMDs with the kernel.
> 
> So we'll probably need a __dma_alloc_from_contiguous version with
> an additional bool fallback argument - everyone but arms uses
> dma_alloc_from_contiguous as in your patch, just arm will get the
> non-fallback one.

Or we even just implement dma_{alloc,free}_contiguous() as a wrapper 
around the existing APIs so that users can be thoroughly checked and 
converted one-by-one.

Robin.
