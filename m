Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B18BC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1132083B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732466AbfJNOEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:04:47 -0400
Received: from foss.arm.com ([217.140.110.172]:44988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732121AbfJNOEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:04:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83EDF337;
        Mon, 14 Oct 2019 07:04:46 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22A513F68E;
        Mon, 14 Oct 2019 07:04:43 -0700 (PDT)
Subject: Re: [PATCH v3 6/7] iommu/mediatek: Use writel for TLB range
 invalidation
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
 <1571035101-4213-7-git-send-email-yong.wu@mediatek.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c87e2a9c-5ed3-e44c-3b17-067db173eae9@arm.com>
Date:   Mon, 14 Oct 2019 15:04:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1571035101-4213-7-git-send-email-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2019 07:38, Yong Wu wrote:
> Use writel for the register F_MMU_INV_RANGE which is for triggering the
> HW work. We expect all the setting(iova_start/iova_end...) have already
> been finished before F_MMU_INV_RANGE.

For Arm CPUs, these registers should be mapped as Device memory, 
therefore the same-peripheral rule should implicitly enforce that the 
accesses are made in program order, hence you're unlikely to have seen a 
problem in reality. However, the logical reasoning for the change seems 
valid in general, so I'd argue that it's still worth making if only for 
the sake of good practice:

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Anan.Sun <anan.sun@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index dbbacc3..d285457 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -187,8 +187,7 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
>   		writel_relaxed(iova, data->base + REG_MMU_INVLD_START_A);
>   		writel_relaxed(iova + size - 1,
>   			       data->base + REG_MMU_INVLD_END_A);
> -		writel_relaxed(F_MMU_INV_RANGE,
> -			       data->base + REG_MMU_INVALIDATE);
> +		writel(F_MMU_INV_RANGE, data->base + REG_MMU_INVALIDATE);
>   
>   		/* tlb sync */
>   		ret = readl_poll_timeout_atomic(data->base + REG_MMU_CPE_DONE,
> 
