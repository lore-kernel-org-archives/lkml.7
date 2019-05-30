Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F42C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E8525CB5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfE3PbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 11:31:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38160 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726355AbfE3PbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:31:19 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 780E2B06B6B9790FDA8F;
        Thu, 30 May 2019 23:31:16 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Thu, 30 May 2019
 23:31:14 +0800
Subject: Re: [PATCH] drm/nouveau: Fix DEVICE_PRIVATE dependencies
To:     <bskeggs@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <jglisse@redhat.com>, <jgg@mellanox.com>, <rcampbell@nvidia.com>,
        <leonro@mellanox.com>, <akpm@linux-foundation.org>,
        <sfr@canb.auug.org.au>, <gregkh@linuxfoundation.org>,
        <b.zolnierkie@samsung.com>
References: <20190417142632.12992-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-mm@kvack.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <583de550-d816-f619-d402-688c87c86fe3@huawei.com>
Date:   Thu, 30 May 2019 23:31:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190417142632.12992-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Friendly ping:

Who can take this?

On 2019/4/17 22:26, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> During randconfig builds, I occasionally run into an invalid configuration
> 
> WARNING: unmet direct dependencies detected for DEVICE_PRIVATE
>   Depends on [n]: ARCH_HAS_HMM_DEVICE [=n] && ZONE_DEVICE [=n]
>   Selected by [y]:
>   - DRM_NOUVEAU_SVM [=y] && HAS_IOMEM [=y] && ARCH_HAS_HMM [=y] && DRM_NOUVEAU [=y] && STAGING [=y]
> 
> mm/memory.o: In function `do_swap_page':
> memory.c:(.text+0x2754): undefined reference to `device_private_entry_fault'
> 
> commit 5da25090ab04 ("mm/hmm: kconfig split HMM address space mirroring from device memory")
> split CONFIG_DEVICE_PRIVATE dependencies from
> ARCH_HAS_HMM to ARCH_HAS_HMM_DEVICE and ZONE_DEVICE,
> so enable DRM_NOUVEAU_SVM will trigger this warning,
> cause building failed.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 5da25090ab04 ("mm/hmm: kconfig split HMM address space mirroring from device memory")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/nouveau/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
> index 00cd9ab..99e30c1 100644
> --- a/drivers/gpu/drm/nouveau/Kconfig
> +++ b/drivers/gpu/drm/nouveau/Kconfig
> @@ -74,7 +74,8 @@ config DRM_NOUVEAU_BACKLIGHT
>  
>  config DRM_NOUVEAU_SVM
>  	bool "(EXPERIMENTAL) Enable SVM (Shared Virtual Memory) support"
> -	depends on ARCH_HAS_HMM
> +	depends on ARCH_HAS_HMM_DEVICE
> +	depends on ZONE_DEVICE
>  	depends on DRM_NOUVEAU
>  	depends on STAGING
>  	select HMM_MIRROR
> 

