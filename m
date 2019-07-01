Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685C7C06511
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 12:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C66E20B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 12:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbfGAMWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 08:22:02 -0400
Received: from 8bytes.org ([81.169.241.247]:33650 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727243AbfGAMWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 08:22:02 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 82844229; Mon,  1 Jul 2019 14:22:00 +0200 (CEST)
Date:   Mon, 1 Jul 2019 14:21:59 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/dma: Fix calculation overflow in __finalise_sg()
Message-ID: <20190701122158.GE8166@8bytes.org>
References: <20190622043814.5003-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622043814.5003-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 09:38:14PM -0700, Nicolin Chen wrote:
> The max_len is a u32 type variable so the calculation on the
> left hand of the last if-condition will potentially overflow
> when a cur_len gets closer to UINT_MAX -- note that there're
> drivers setting max_seg_size to UINT_MAX:
>   drivers/dma/dw-edma/dw-edma-core.c:745:
>     dma_set_max_seg_size(dma->dev, U32_MAX);
>   drivers/dma/dma-axi-dmac.c:871:
>     dma_set_max_seg_size(&pdev->dev, UINT_MAX);
>   drivers/mmc/host/renesas_sdhi_internal_dmac.c:338:
>     dma_set_max_seg_size(dev, 0xffffffff);
>   drivers/nvme/host/pci.c:2520:
>     dma_set_max_seg_size(dev->dev, 0xffffffff);
> 
> So this patch just casts the cur_len in the calculation to a
> size_t type to fix the overflow issue, as it's not necessary
> to change the type of cur_len after all.
> 
> Fixes: 809eac54cdd6 ("iommu/dma: Implement scatterlist segment merging")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

Looks good to me, but I let Robin take a look too before I apply it,
Robin?

