Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51E1C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70772067B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732704AbfJNOWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:22:53 -0400
Received: from foss.arm.com ([217.140.110.172]:45476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732522AbfJNOWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:22:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6A90337;
        Mon, 14 Oct 2019 07:22:52 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DAA23F68E;
        Mon, 14 Oct 2019 07:22:50 -0700 (PDT)
Subject: Re: [PATCH v3 4/7] iommu/mediatek: Delete the leaf in the tlb flush
To:     Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>
Cc:     Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        cui.zhang@mediatek.com, chao.hao@mediatek.com,
        edison.hsieh@mediatek.com
References: <1571035101-4213-1-git-send-email-yong.wu@mediatek.com>
 <1571035101-4213-5-git-send-email-yong.wu@mediatek.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <20c74c20-864e-88af-3c58-ad3bb7600bcc@arm.com>
Date:   Mon, 14 Oct 2019 15:22:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1571035101-4213-5-git-send-email-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2019 07:38, Yong Wu wrote:
> In our tlb range flush, we don't care the "leaf". Remove it to simplify
> the code. no functional change.

Presumably you don't care about the granule either?

Robin.

> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 16 ++++------------
>   1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 8712afc..19f936c 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -174,8 +174,7 @@ static void mtk_iommu_tlb_flush_all(void *cookie)
>   }
>   
>   static void mtk_iommu_tlb_add_flush_nosync(unsigned long iova, size_t size,
> -					   size_t granule, bool leaf,
> -					   void *cookie)
> +					   size_t granule, void *cookie)
>   {
>   	struct mtk_iommu_data *data = cookie;
>   
> @@ -219,14 +218,7 @@ static void mtk_iommu_tlb_sync(void *cookie)
>   static void mtk_iommu_tlb_flush_walk(unsigned long iova, size_t size,
>   				     size_t granule, void *cookie)
>   {
> -	mtk_iommu_tlb_add_flush_nosync(iova, size, granule, false, cookie);
> -	mtk_iommu_tlb_sync(cookie);
> -}
> -
> -static void mtk_iommu_tlb_flush_leaf(unsigned long iova, size_t size,
> -				     size_t granule, void *cookie)
> -{
> -	mtk_iommu_tlb_add_flush_nosync(iova, size, granule, true, cookie);
> +	mtk_iommu_tlb_add_flush_nosync(iova, size, granule, cookie);
>   	mtk_iommu_tlb_sync(cookie);
>   }
>   
> @@ -245,7 +237,7 @@ static void mtk_iommu_tlb_flush_page_nosync(struct iommu_iotlb_gather *gather,
>   static const struct iommu_flush_ops mtk_iommu_flush_ops = {
>   	.tlb_flush_all = mtk_iommu_tlb_flush_all,
>   	.tlb_flush_walk = mtk_iommu_tlb_flush_walk,
> -	.tlb_flush_leaf = mtk_iommu_tlb_flush_leaf,
> +	.tlb_flush_leaf = mtk_iommu_tlb_flush_walk,
>   	.tlb_add_page = mtk_iommu_tlb_flush_page_nosync,
>   };
>   
> @@ -475,7 +467,7 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
>   		spin_lock_irqsave(&dom->pgtlock, flags);
>   
>   	mtk_iommu_tlb_add_flush_nosync(gather->start, length, gather->pgsize,
> -				       false, data);
> +				       data);
>   	mtk_iommu_tlb_sync(data);
>   
>   	if (!is_in_gather)
> 
