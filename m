Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FF5C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3380206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732343AbfDQOip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:38:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35950 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729395AbfDQOip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:38:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D50B93092678;
        Wed, 17 Apr 2019 14:38:44 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 544795D704;
        Wed, 17 Apr 2019 14:38:43 +0000 (UTC)
Date:   Wed, 17 Apr 2019 10:38:41 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     bskeggs@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        jgg@mellanox.com, rcampbell@nvidia.com, leonro@mellanox.com,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org
Subject: Re: [PATCH] drm/nouveau: Fix DEVICE_PRIVATE dependencies
Message-ID: <20190417143841.GD3229@redhat.com>
References: <20190417142632.12992-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190417142632.12992-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 17 Apr 2019 14:38:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 10:26:32PM +0800, Yue Haibing wrote:
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

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

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
> -- 
> 2.7.4
> 
> 
