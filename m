Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B89EC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83A62077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfDKNPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:15:53 -0400
Received: from 8bytes.org ([81.169.241.247]:34110 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbfDKNPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:15:53 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id B1A6E42D; Thu, 11 Apr 2019 15:15:51 +0200 (CEST)
Date:   Thu, 11 Apr 2019 15:15:49 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        iommu@lists.linux-foundation.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lyude Paul <lyude@redhat.com>, Eric Anholt <eric@anholt.net>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v3 1/3] iommu: io-pgtable: Add ARM Mali midgard MMU page
 table format
Message-ID: <20190411131549.GB4518@8bytes.org>
References: <20190401074730.12241-1-robh@kernel.org>
 <20190401074730.12241-2-robh@kernel.org>
 <8d091874-11b0-e348-c4f1-dd1bcfa4bf97@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d091874-11b0-e348-c4f1-dd1bcfa4bf97@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 08:11:00PM +0100, Robin Murphy wrote:
> With the diff below squashed in to address my outstanding style nits,
> 
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> 
> I don't foresee any conflicting io-pgtable changes to prevent this going via
> DRM, but I'll leave the final say up to Joerg.

No objection from my side with merging this via DRM. With Robin's
concerns addressed:

	Acked-by: Joerg Roedel <jroedel@suse.de>

> 
> Thanks,
> Robin.
> 
> ----->8-----
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 98551d0cff59..55ed039da166 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -197,12 +197,13 @@ struct arm_lpae_io_pgtable {
> 
>  typedef u64 arm_lpae_iopte;
> 
> -static inline bool iopte_leaf(arm_lpae_iopte pte, int l, enum
> io_pgtable_fmt fmt)
> +static inline bool iopte_leaf(arm_lpae_iopte pte, int lvl,
> +			      enum io_pgtable_fmt fmt)
>  {
> -	if ((l == (ARM_LPAE_MAX_LEVELS - 1)) && (fmt != ARM_MALI_LPAE))
> -		return iopte_type(pte,l) == ARM_LPAE_PTE_TYPE_PAGE;
> +	if (lvl == (ARM_LPAE_MAX_LEVELS - 1) && fmt != ARM_MALI_LPAE)
> +		return iopte_type(pte, lvl) == ARM_LPAE_PTE_TYPE_PAGE;
> 
> -	return iopte_type(pte,l) == ARM_LPAE_PTE_TYPE_BLOCK;
> +	return iopte_type(pte, lvl) == ARM_LPAE_PTE_TYPE_BLOCK;
>  }
> 
>  static arm_lpae_iopte paddr_to_iopte(phys_addr_t paddr,
> @@ -310,13 +311,10 @@ static void __arm_lpae_init_pte(struct
> arm_lpae_io_pgtable *data,
>  	if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NS)
>  		pte |= ARM_LPAE_PTE_NS;
> 
> -	if (lvl == ARM_LPAE_MAX_LEVELS - 1) {
> -		if (data->iop.fmt == ARM_MALI_LPAE)
> -			pte |= ARM_LPAE_PTE_TYPE_BLOCK;
> -		else
> -			pte |= ARM_LPAE_PTE_TYPE_PAGE;
> -	} else
> +	if (data->iop.fmt != ARM_MALI_LPAE && lvl != ARM_LPAE_MAX_LEVELS - 1)
>  		pte |= ARM_LPAE_PTE_TYPE_BLOCK;
> +	else
> +		pte |= ARM_LPAE_PTE_TYPE_PAGE;
> 
>  	if (data->iop.fmt != ARM_MALI_LPAE)
>  		pte |= ARM_LPAE_PTE_AF;
