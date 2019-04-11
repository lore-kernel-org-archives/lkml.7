Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AADC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95043206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfDKOeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 10:34:44 -0400
Received: from verein.lst.de ([213.95.11.211]:36076 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfDKOen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 10:34:43 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 150ED68AFE; Thu, 11 Apr 2019 16:34:31 +0200 (CEST)
Date:   Thu, 11 Apr 2019 16:34:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mmc: let the dma map ops handle bouncing
Message-ID: <20190411143430.GA17371@lst.de>
References: <20190411070948.29564-1-hch@lst.de> <20190411070948.29564-2-hch@lst.de> <CAPDyKFqHrvz_5taNTx7k6Skx=Ox+9XgQHHz0LZyr4QNV9orvRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqHrvz_5taNTx7k6Skx=Ox+9XgQHHz0LZyr4QNV9orvRw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 11:00:56AM +0200, Ulf Hansson wrote:
> >         blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, mq->queue);
> >         if (mmc_can_erase(card))
> >                 mmc_queue_setup_discard(mq->queue, card);
> >
> > -       blk_queue_bounce_limit(mq->queue, limit);
> > +       if (!mmc_dev(host)->dma_mask || !*mmc_dev(host)->dma_mask)
> > +               blk_queue_bounce_limit(mq->queue, BLK_BOUNCE_HIGH);
> 
> So this means we are not going to set a bounce limit for the queue, in
> case we have a dma mask.
> 
> Why isn't that needed no more? Whats has changed?

On most architectures it was never needed, the major hold out was x86-32
with PAE.  In general the dma_mask tells the DMA API layer what is
supported, and if the physical addressing doesn't support that it has to
use bounce buffering like swiotlb (or dmabounce on arm32).  A couple
month ago I finally fixes x86-32 to also properly set up swiotlb,
and remove the block layerer bounce buffering that wasn't for highmem
(which is about having a kernel mapping, not addressing), and ISA DMA
(which is not handled like everything else, but we'll get there).
But for some reason I missed mmc back then, so mmc right now is the
only remaining user of address based block layer bouncing.
