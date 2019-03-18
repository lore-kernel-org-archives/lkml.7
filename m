Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359A6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109C02087E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfCRPT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:19:28 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36168 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbfCRPT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:19:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDFEF1650;
        Mon, 18 Mar 2019 08:19:25 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED8A03F59C;
        Mon, 18 Mar 2019 08:19:24 -0700 (PDT)
Subject: Re: [PATCH] iommu/iova: Fix tracking of recently failed iova address
 size
To:     Robert Richter <rrichter@marvell.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Ganapatrao Kulkarni <gkulkarni@marvell.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190315155553.11857-1-rrichter@marvell.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <7515342b-f4b2-9406-5249-93ae7880835a@arm.com>
Date:   Mon, 18 Mar 2019 15:19:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190315155553.11857-1-rrichter@marvell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2019 15:56, Robert Richter wrote:
> We track the smallest size that failed for a 32 bit allocation. The
> Size decreases only and if we actually walked the tree and noticed an
> allocation failure. Current code is broken and wrongly updates the
> size value even if we did not try an allocation. This leads to
> increased size values and we might go the slow path again even if we
> have seen a failure before for the same or a smaller size.

That description wasn't too clear (since it rather contradicts itself by 
starting off with "XYZ happens" when the whole point is that XYZ doesn't 
actually happen properly), but having gone and looked at the code in 
context I think I understand it now - specifically, it's that the 
early-exit path for detecting that a 32-bit allocation request is too 
big to possibly succeed should never have gone via the route which 
assigns to max32_alloc_size.

In that respect, the diff looks correct, so modulo possibly tweaking the 
commit message,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Thanks,
Robin.

> Cc: <stable@vger.kernel.org> # 4.20+
> Fixes: bee60e94a1e2 ("iommu/iova: Optimise attempts to allocate iova from 32bit address range")
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>   drivers/iommu/iova.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index f8d3ba247523..2de8122e218f 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -207,8 +207,10 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>   		curr_iova = rb_entry(curr, struct iova, node);
>   	} while (curr && new_pfn <= curr_iova->pfn_hi);
>   
> -	if (limit_pfn < size || new_pfn < iovad->start_pfn)
> +	if (limit_pfn < size || new_pfn < iovad->start_pfn) {
> +		iovad->max32_alloc_size = size;
>   		goto iova32_full;
> +	}
>   
>   	/* pfn_lo will point to size aligned address if size_aligned is set */
>   	new->pfn_lo = new_pfn;
> @@ -222,7 +224,6 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>   	return 0;
>   
>   iova32_full:
> -	iovad->max32_alloc_size = size;
>   	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
>   	return -ENOMEM;
>   }
> 
