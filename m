Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9187C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 09:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B79CF2064B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 09:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfLSJvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 04:51:19 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2208 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726709AbfLSJvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 04:51:19 -0500
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 1ACD64D20BC1B19E079B;
        Thu, 19 Dec 2019 09:51:17 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML714-CAH.china.huawei.com (10.201.108.37) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 19 Dec 2019 09:51:16 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 19 Dec
 2019 09:51:16 +0000
Subject: Re: [Patch v3 3/3] iommu: avoid taking iova_rbtree_lock twice
To:     Cong Wang <xiyou.wangcong@gmail.com>,
        <iommu@lists.linux-foundation.org>
CC:     <robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
        <joro@8bytes.org>
References: <20191218043951.10534-1-xiyou.wangcong@gmail.com>
 <20191218043951.10534-4-xiyou.wangcong@gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <c0e33d09-8d0e-80b5-1b95-4af82004d9dd@huawei.com>
Date:   Thu, 19 Dec 2019 09:51:15 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191218043951.10534-4-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/2019 04:39, Cong Wang wrote:
> Both find_iova() and __free_iova() take iova_rbtree_lock,
> there is no reason to take and release it twice inside
> free_iova().
> 
> Fold them into one critical section by calling the unlock
> versions instead.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: John Garry <john.garry@huawei.com>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>

FWIW:
Reviewed-by: John Garry <john.garry@huawei.com>

> ---
>   drivers/iommu/iova.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 184d4c0e20b5..f46f8f794678 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -390,10 +390,14 @@ EXPORT_SYMBOL_GPL(__free_iova);
>   void
>   free_iova(struct iova_domain *iovad, unsigned long pfn)
>   {
> -	struct iova *iova = find_iova(iovad, pfn);
> +	unsigned long flags;
> +	struct iova *iova;
>   
> +	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> +	iova = private_find_iova(iovad, pfn);
>   	if (iova)
> -		__free_iova(iovad, iova);
> +		private_free_iova(iovad, iova);
> +	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
>   
>   }
>   EXPORT_SYMBOL_GPL(free_iova);
> 

