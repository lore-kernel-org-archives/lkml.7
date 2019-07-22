Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE18C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A7C21738
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbfGVQ44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 12:56:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54194 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728343AbfGVQ44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 12:56:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C400C3082133;
        Mon, 22 Jul 2019 16:56:55 +0000 (UTC)
Received: from [10.36.116.45] (ovpn-116-45.ams2.redhat.com [10.36.116.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B74719D71;
        Mon, 22 Jul 2019 16:56:51 +0000 (UTC)
Subject: Re: [PATCH v2] dma-mapping: Use dma_get_mask in
 dma_addressing_limited
To:     eric.auger.pro@gmail.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20190722165149.3763-1-eric.auger@redhat.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <77ba1061-08b6-421e-a6dd-d5db9851325b@redhat.com>
Date:   Mon, 22 Jul 2019 18:56:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190722165149.3763-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 22 Jul 2019 16:56:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 7/22/19 6:51 PM, Eric Auger wrote:
> We currently have cases where the dma_addressing_limited() gets
> called with dma_mask unset. This causes a NULL pointer dereference.
> 
> Use dma_get_mask() accessor to prevent the crash.
> 
> Fixes: b866455423e0 ("dma-mapping: add a dma_addressing_limited helper")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

As a follow-up of my last email, here is a patch featuring
dma_get_mask(). But you don't have the WARN_ON_ONCE anymore, pointing
out suspect users.

Feel free to pick up your preferred approach

Thanks

Eric
> 
> ---
> 
> v1 -> v2:
> - was [PATCH 1/2] dma-mapping: Protect dma_addressing_limited
>   against NULL dma_mask
> - Use dma_get_mask
> ---
>  include/linux/dma-mapping.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index e11b115dd0e4..f7d1eea32c78 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -689,8 +689,8 @@ static inline int dma_coerce_mask_and_coherent(struct device *dev, u64 mask)
>   */
>  static inline bool dma_addressing_limited(struct device *dev)
>  {
> -	return min_not_zero(*dev->dma_mask, dev->bus_dma_mask) <
> -		dma_get_required_mask(dev);
> +	return min_not_zero(dma_get_mask(dev), dev->bus_dma_mask) <
> +			    dma_get_required_mask(dev);
>  }
>  
>  #ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
> 
