Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4001DC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 14:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189B521736
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 14:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfK2On1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 09:43:27 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2143 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726943AbfK2On0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 09:43:26 -0500
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 18471A39C9AFC84A7EED;
        Fri, 29 Nov 2019 14:43:25 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML711-CAH.china.huawei.com (10.201.108.34) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 29 Nov 2019 14:43:24 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 29 Nov
 2019 14:43:24 +0000
Subject: Re: [Patch v2 1/3] iommu: match the original algorithm
To:     Cong Wang <xiyou.wangcong@gmail.com>,
        <iommu@lists.linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20191129004855.18506-1-xiyou.wangcong@gmail.com>
 <20191129004855.18506-2-xiyou.wangcong@gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <d0f58734-0c1e-af9d-3437-31cf6c8a86f9@huawei.com>
Date:   Fri, 29 Nov 2019 14:43:23 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191129004855.18506-2-xiyou.wangcong@gmail.com>
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
> The IOVA cache algorithm implemented in IOMMU code does not
> exactly match the original algorithm described in the paper.
> 

which paper?

> Particularly, it doesn't need to free the loaded empty magazine
> when trying to put it back to global depot. To make it work, we
> have to pre-allocate magazines in the depot and only recycle them
> when all of them are full.
> 
> Before this patch, rcache->depot[] contains either full or
> freed entries, after this patch, it contains either full or
> empty (but allocated) entries.

I *quickly* tested this patch and got a small performance gain.

> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> ---
>   drivers/iommu/iova.c | 45 +++++++++++++++++++++++++++-----------------
>   1 file changed, 28 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 41c605b0058f..cb473ddce4cf 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -862,12 +862,16 @@ static void init_iova_rcaches(struct iova_domain *iovad)
>   	struct iova_cpu_rcache *cpu_rcache;
>   	struct iova_rcache *rcache;
>   	unsigned int cpu;
> -	int i;
> +	int i, j;
>   
>   	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
>   		rcache = &iovad->rcaches[i];
>   		spin_lock_init(&rcache->lock);
>   		rcache->depot_size = 0;
> +		for (j = 0; j < MAX_GLOBAL_MAGS; ++j) {
> +			rcache->depot[j] = iova_magazine_alloc(GFP_KERNEL);
> +			WARN_ON(!rcache->depot[j]);
> +		}
>   		rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache), cache_line_size());
>   		if (WARN_ON(!rcache->cpu_rcaches))
>   			continue;
> @@ -900,24 +904,30 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>   
>   	if (!iova_magazine_full(cpu_rcache->loaded)) {
>   		can_insert = true;
> -	} else if (!iova_magazine_full(cpu_rcache->prev)) {
> +	} else if (iova_magazine_empty(cpu_rcache->prev)) {

is this change strictly necessary?

>   		swap(cpu_rcache->prev, cpu_rcache->loaded);
>   		can_insert = true;
>   	} else {
> -		struct iova_magazine *new_mag = iova_magazine_alloc(GFP_ATOMIC);
> +		spin_lock(&rcache->lock);
> +		if (rcache->depot_size < MAX_GLOBAL_MAGS) {
> +			swap(rcache->depot[rcache->depot_size], cpu_rcache->prev);
> +			swap(cpu_rcache->prev, cpu_rcache->loaded);
> +			rcache->depot_size++;
> +			can_insert = true;
> +		} else {
> +			mag_to_free = cpu_rcache->loaded;
> +		}
> +		spin_unlock(&rcache->lock);
> +
> +		if (mag_to_free) {
> +			struct iova_magazine *new_mag = iova_magazine_alloc(GFP_ATOMIC);
>   
> -		if (new_mag) {
> -			spin_lock(&rcache->lock);
> -			if (rcache->depot_size < MAX_GLOBAL_MAGS) {
> -				rcache->depot[rcache->depot_size++] =
> -						cpu_rcache->loaded;
> +			if (new_mag) {
> +				cpu_rcache->loaded = new_mag;
> +				can_insert = true;
>   			} else {
> -				mag_to_free = cpu_rcache->loaded;
> +				mag_to_free = NULL;
>   			}
> -			spin_unlock(&rcache->lock);
> -
> -			cpu_rcache->loaded = new_mag;
> -			can_insert = true;
>   		}
>   	}
>   
> @@ -963,14 +973,15 @@ static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
>   
>   	if (!iova_magazine_empty(cpu_rcache->loaded)) {
>   		has_pfn = true;
> -	} else if (!iova_magazine_empty(cpu_rcache->prev)) {
> +	} else if (iova_magazine_full(cpu_rcache->prev)) {
>   		swap(cpu_rcache->prev, cpu_rcache->loaded);
>   		has_pfn = true;
>   	} else {
>   		spin_lock(&rcache->lock);
>   		if (rcache->depot_size > 0) {
> -			iova_magazine_free(cpu_rcache->loaded);

it is good to remove this from under the lock, apart from this change

> -			cpu_rcache->loaded = rcache->depot[--rcache->depot_size];
> +			swap(rcache->depot[rcache->depot_size - 1], cpu_rcache->prev);
> +			swap(cpu_rcache->prev, cpu_rcache->loaded);
> +			rcache->depot_size--;

I'm not sure how appropriate the name "depot_size" is any longer.

>   			has_pfn = true;
>   		}
>   		spin_unlock(&rcache->lock);
> @@ -1019,7 +1030,7 @@ static void free_iova_rcaches(struct iova_domain *iovad)
>   			iova_magazine_free(cpu_rcache->prev);
>   		}
>   		free_percpu(rcache->cpu_rcaches);
> -		for (j = 0; j < rcache->depot_size; ++j)
> +		for (j = 0; j < MAX_GLOBAL_MAGS; ++j)
>   			iova_magazine_free(rcache->depot[j]);
>   	}
>   }
> 

