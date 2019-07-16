Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64554C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 06:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350AC20880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 06:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbfGPGXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 02:23:14 -0400
Received: from gate.crashing.org ([63.228.1.57]:60179 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729533AbfGPGXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 02:23:13 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6G6Mxw6010843;
        Tue, 16 Jul 2019 01:23:00 -0500
Message-ID: <00c4f41415c94e18dce0e8a3ff60991edc3aba9d.camel@kernel.crashing.org>
Subject: Re: [PATCH 3/3] nvme: Add support for Apple 2018+ models
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
        Paul Pawlowski <paul@mrarm.io>
Date:   Tue, 16 Jul 2019 16:22:59 +1000
In-Reply-To: <20190716060623.GC29414@lst.de>
References: <20190716004649.17799-1-benh@kernel.crashing.org>
         <20190716004649.17799-3-benh@kernel.crashing.org>
         <20190716060623.GC29414@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-16 at 08:06 +0200, Christoph Hellwig wrote:
> 
> >  /*
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 54b35ea4af88..ab2358137419 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2080,6 +2080,9 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
> >  	dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
> >  	dev->io_queues[HCTX_TYPE_READ] = 0;
> >  
> > +	if (dev->ctrl.quirks & NVME_QUIRK_SINGLE_VECTOR)
> > +		irq_queues = 1;
> > +
> >  	return pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues,
> >  			      PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
> 
> Callin pci_alloc_irq_vectors_affinity in this case seems a bit
> pointless, but if this works for you I'd rather keep it as-is for now
> if this works for you.

It seems to work and it's simpler that way. The original patch was
grabbing all the interrupts then hacking the queues to all use vector 0
(well there's only one IO queue). The above is a bit cleaner imho.

Cheers,
Ben.


