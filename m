Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552DDC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 18:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 265C42070E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 18:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgAFSTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 13:19:37 -0500
Received: from foss.arm.com ([217.140.110.172]:46932 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgAFSTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 13:19:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FBE9328;
        Mon,  6 Jan 2020 10:19:36 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D2B43F534;
        Mon,  6 Jan 2020 10:19:35 -0800 (PST)
Subject: Re: [PATCH] iommu/dma: fix variable 'cookie' set but not used
To:     Qian Cai <cai@lca.pw>, jroedel@suse.de
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200106152727.1589-1-cai@lca.pw>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <418dcce0-f048-a4cc-3360-d4b9c7926a6d@arm.com>
Date:   Mon, 6 Jan 2020 18:19:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200106152727.1589-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2020 3:27 pm, Qian Cai wrote:
> The commit c18647900ec8 ("iommu/dma: Relax locking in
> iommu_dma_prepare_msi()") introduced a compliation warning,
> 
> drivers/iommu/dma-iommu.c: In function 'iommu_dma_prepare_msi':
> drivers/iommu/dma-iommu.c:1206:27: warning: variable 'cookie' set but
> not used [-Wunused-but-set-variable]
>    struct iommu_dma_cookie *cookie;
>                             ^~~~~~

Fair enough... I guess this is a W=1 thing? Either way there's certainly 
no harm in cleaning up.

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Fixes: c18647900ec8 ("iommu/dma: Relax locking in iommu_dma_prepare_msi()")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>   drivers/iommu/dma-iommu.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index c363294b3bb9..a2e96a5fd9a7 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1203,7 +1203,6 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
>   {
>   	struct device *dev = msi_desc_to_dev(desc);
>   	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> -	struct iommu_dma_cookie *cookie;
>   	struct iommu_dma_msi_page *msi_page;
>   	static DEFINE_MUTEX(msi_prepare_lock); /* see below */
>   
> @@ -1212,8 +1211,6 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
>   		return 0;
>   	}
>   
> -	cookie = domain->iova_cookie;
> -
>   	/*
>   	 * In fact the whole prepare operation should already be serialised by
>   	 * irq_domain_mutex further up the callchain, but that's pretty subtle
> 
