Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE867C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB7020872
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfK0SBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 13:01:01 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2130 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726576AbfK0SBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 13:01:01 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 27BC0BDB9FE9DE7501A4;
        Wed, 27 Nov 2019 18:01:00 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 27 Nov 2019 18:00:59 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 27 Nov
 2019 18:00:59 +0000
Subject: Re: [PATCH 1/3] iommu: match the original algorithm
To:     Cong Wang <xiyou.wangcong@gmail.com>,
        <iommu@lists.linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20191121001348.27230-1-xiyou.wangcong@gmail.com>
 <20191121001348.27230-2-xiyou.wangcong@gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <9ac29292-bc3d-ae57-daff-5b3264020fe2@huawei.com>
Date:   Wed, 27 Nov 2019 18:00:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191121001348.27230-2-xiyou.wangcong@gmail.com>
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

On 21/11/2019 00:13, Cong Wang wrote:
> The IOVA cache algorithm implemented in IOMMU code does not
> exactly match the original algorithm described in the paper.
> 
> Particularly, it doesn't need to free the loaded empty magazine
> when trying to put it back to global depot.
> 
> This patch makes it exactly match the original algorithm.
> 

I haven't gone into the details, but this patch alone is giving this:

root@(none)$ [  123.857024] kmemleak: 8 new suspected memory leaks (see 
/sys/kernel/debug/kmemleak)

root@(none)$ cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff002339843000 (size 2048):
   comm "swapper/0", pid 1, jiffies 4294898165 (age 122.688s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000001d2710bf>] kmem_cache_alloc+0x188/0x260
     [<00000000cc229a78>] init_iova_domain+0x1e8/0x2a8
     [<000000002646fc92>] iommu_setup_dma_ops+0x200/0x710
     [<00000000acc5fe46>] arch_setup_dma_ops+0x80/0x128
     [<00000000994e1e43>] acpi_dma_configure+0x11c/0x140
     [<00000000effe9374>] pci_dma_configure+0xe0/0x108
     [<00000000f614ae1e>] really_probe+0x210/0x548
     [<0000000087884b1b>] driver_probe_device+0x7c/0x148
     [<0000000010af2936>] device_driver_attach+0x94/0xa0
     [<00000000c92b2971>] __driver_attach+0xa4/0x110
     [<00000000c873500f>] bus_for_each_dev+0xe8/0x158
     [<00000000c7d0e008>] driver_attach+0x30/0x40
     [<000000003cf39ba8>] bus_add_driver+0x234/0x2f0
     [<0000000043830a45>] driver_register+0xbc/0x1d0
     [<00000000c8a41162>] __pci_register_driver+0xb0/0xc8
     [<00000000e562eeec>] sas_v3_pci_driver_init+0x20/0x28
unreferenced object 0xffff002339844000 (size 2048):
   comm "swapper/0", pid 1, jiffies 4294898165 (age 122.688s)

[snip]

And I don't feel like continuing until it's resolved....

Thanks,
John

> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> ---
>   drivers/iommu/iova.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 41c605b0058f..92f72a85e62a 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -900,7 +900,7 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>   
>   	if (!iova_magazine_full(cpu_rcache->loaded)) {
>   		can_insert = true;
> -	} else if (!iova_magazine_full(cpu_rcache->prev)) {
> +	} else if (iova_magazine_empty(cpu_rcache->prev)) {
>   		swap(cpu_rcache->prev, cpu_rcache->loaded);
>   		can_insert = true;
>   	} else {
> @@ -909,8 +909,9 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>   		if (new_mag) {
>   			spin_lock(&rcache->lock);
>   			if (rcache->depot_size < MAX_GLOBAL_MAGS) {
> -				rcache->depot[rcache->depot_size++] =
> -						cpu_rcache->loaded;
> +				swap(rcache->depot[rcache->depot_size], cpu_rcache->prev);
> +				swap(cpu_rcache->prev, cpu_rcache->loaded);
> +				rcache->depot_size++;
>   			} else {
>   				mag_to_free = cpu_rcache->loaded;
>   			}
> @@ -963,14 +964,15 @@ static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
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
> -			cpu_rcache->loaded = rcache->depot[--rcache->depot_size];
> +			swap(rcache->depot[rcache->depot_size - 1], cpu_rcache->prev);
> +			swap(cpu_rcache->prev, cpu_rcache->loaded);
> +			rcache->depot_size--;
>   			has_pfn = true;
>   		}
>   		spin_unlock(&rcache->lock);
> 

