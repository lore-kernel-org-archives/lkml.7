Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57602C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 06:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE8B206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 06:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733070AbfGPGG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 02:06:27 -0400
Received: from verein.lst.de ([213.95.11.211]:38924 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfGPGG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 02:06:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8965568C65; Tue, 16 Jul 2019 08:06:24 +0200 (CEST)
Date:   Tue, 16 Jul 2019 08:06:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Paul Pawlowski <paul@mrarm.io>
Subject: Re: [PATCH 3/3] nvme: Add support for Apple 2018+ models
Message-ID: <20190716060623.GC29414@lst.de>
References: <20190716004649.17799-1-benh@kernel.crashing.org> <20190716004649.17799-3-benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716004649.17799-3-benh@kernel.crashing.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 10:46:49AM +1000, Benjamin Herrenschmidt wrote:
> Based on reverse engineering and original patch by
> 
> Paul Pawlowski <paul@mrarm.io>
> 
> This adds support for Apple weird implementation of NVME in their
> 2018 or later machines. It accounts for the twice-as-big SQ entries
> for the IO queues, and the fact that only interrupt vector 0 appears
> to function properly.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  drivers/nvme/host/core.c |  5 ++++-
>  drivers/nvme/host/nvme.h | 10 ++++++++++
>  drivers/nvme/host/pci.c  |  6 ++++++
>  3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 716ebe87a2b8..480ea24d8cf4 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2701,7 +2701,10 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>  		ctrl->hmmaxd = le16_to_cpu(id->hmmaxd);
>  
>  		/* Grab required IO queue size */
> -		ctrl->iosqes = id->sqes & 0xf;
> +		if (ctrl->quirks & NVME_QUIRK_128_BYTES_SQES)
> +			ctrl->iosqes = 7;
> +		else
> +			ctrl->iosqes = id->sqes & 0xf;
>  		if (ctrl->iosqes < NVME_NVM_IOSQES) {
>  			dev_err(ctrl->device,
>  				"unsupported required IO queue size %d\n", ctrl->iosqes);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 34ef35fcd8a5..b2a78d08b984 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -92,6 +92,16 @@ enum nvme_quirks {
>  	 * Broken Write Zeroes.
>  	 */
>  	NVME_QUIRK_DISABLE_WRITE_ZEROES		= (1 << 9),
> +
> +	/*
> +	 * Use only one interrupt vector for all queues
> +	 */
> +	NVME_QUIRK_SINGLE_VECTOR		= (1 << 10),
> +
> +	/*
> +	 * Use non-standard 128 bytes SQEs.
> +	 */
> +	NVME_QUIRK_128_BYTES_SQES		= (1 << 11),
>  };
>  
>  /*
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 54b35ea4af88..ab2358137419 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2080,6 +2080,9 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
>  	dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
>  	dev->io_queues[HCTX_TYPE_READ] = 0;
>  
> +	if (dev->ctrl.quirks & NVME_QUIRK_SINGLE_VECTOR)
> +		irq_queues = 1;
> +
>  	return pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues,
>  			      PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);

Callin pci_alloc_irq_vectors_affinity in this case seems a bit
pointless, but if this works for you I'd rather keep it as-is for now
if this works for you.
