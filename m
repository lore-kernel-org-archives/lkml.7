Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C005C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 13:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAE02086A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 13:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfK2NeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 08:34:05 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2141 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726785AbfK2NeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 08:34:05 -0500
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id AF5A731C83F1C5CE58D3;
        Fri, 29 Nov 2019 13:34:04 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML714-CAH.china.huawei.com (10.201.108.37) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 29 Nov 2019 13:34:04 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 29 Nov
 2019 13:34:04 +0000
Subject: Re: [Patch v2 3/3] iommu: avoid taking iova_rbtree_lock twice
To:     Cong Wang <xiyou.wangcong@gmail.com>,
        <iommu@lists.linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20191129004855.18506-1-xiyou.wangcong@gmail.com>
 <20191129004855.18506-4-xiyou.wangcong@gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <dea0de02-cedc-7817-5b04-3888e0e86812@huawei.com>
Date:   Fri, 29 Nov 2019 13:34:03 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191129004855.18506-4-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2019 00:48, Cong Wang wrote:
> Both find_iova() and __free_iova() take iova_rbtree_lock,
> there is no reason to take and release it twice inside
> free_iova().
> 
> Fold them into the critical section by calling the unlock
> versions instead.

Since generally the iova would be non-NULL, this seems a reasonable 
change (which could be mentioned in the commit log)

John

> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
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

