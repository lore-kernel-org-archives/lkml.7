Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B966C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E806B2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfCMS3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:29:09 -0400
Received: from verein.lst.de ([213.95.11.211]:53214 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbfCMS3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:29:08 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 22F6768B05; Wed, 13 Mar 2019 19:29:01 +0100 (CET)
Date:   Wed, 13 Mar 2019 19:29:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     linux@armlinux.org.uk, akpm@linux-foundation.org,
        robin.murphy@arm.com, iamjoonsoo.kim@lge.com, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dma-mapping: always clear allocated buffers in
 __alloc_from_pool
Message-ID: <20190313182900.GA4926@lst.de>
References: <20190312091637.16412-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312091637.16412-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 05:16:37PM +0800, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Like commit 518a2f1925c3 ("dma-mapping: zero memory returned
> from dma_alloc_*"), if we want to map memory from the DMA
> allocator to userspace it must be zeroed at allocation time 
> to prevent stale data leaks. On arm platform, if the allocator
> is pool_allocator in __dma_alloc, then the mem is alloced by
> __alloc_from_pool, which also need be zeroed.

The observations looks correct, and because this memory is already
remapped I don't think we need __dma_clear_buffer here.

But I'd love to see a review from Russell as well.
