Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F56DC606BA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F208F21670
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731658AbfGHOJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:09:14 -0400
Received: from foss.arm.com ([217.140.110.172]:48846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfGHOJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:09:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CA772B;
        Mon,  8 Jul 2019 07:09:12 -0700 (PDT)
Received: from [33.8.37.10] (unknown [10.37.8.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08B6B3F59C;
        Mon,  8 Jul 2019 07:09:08 -0700 (PDT)
Subject: Re: [PATCH] drm/exynos: add CONFIG_MMU dependency
To:     Arnd Bergmann <arnd@arndb.de>, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        Jingoo Han <jingoohan1@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        linux-arm-kernel@lists.infradead.org
References: <20190708134707.538501-1-arnd@arndb.de>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <ea185bd7-3ac7-dc38-1c0e-78cb1cffa6a0@arm.com>
Date:   Mon, 8 Jul 2019 15:09:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190708134707.538501-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/19 2:46 PM, Arnd Bergmann wrote:
> Compile-testing this driver on a NOMMU configuration shows a link failure:
> 
> drivers/gpu/drm/exynos/exynos_drm_gem.o: In function `exynos_drm_gem_fault':
> exynos_drm_gem.c:(.text+0x484): undefined reference to `vmf_insert_mixed'
> 
> Add a CONFIG_MMU dependency to ensure we only enable this in configurations
> that build correctly.
> 
> Many other drm drivers have the same dependency. It would be nice to
> make this work in MMU-less configurations, but evidently nobody has
> ever needed this so far.
> 
> Fixes: 156bdac99061 ("drm/exynos: trigger build of all modules")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/exynos/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/exynos/Kconfig b/drivers/gpu/drm/exynos/Kconfig
> index 60ce4a8ad9e1..6f7d3b3b3628 100644
> --- a/drivers/gpu/drm/exynos/Kconfig
> +++ b/drivers/gpu/drm/exynos/Kconfig
> @@ -2,6 +2,7 @@
>  config DRM_EXYNOS
>  	tristate "DRM Support for Samsung SoC EXYNOS Series"
>  	depends on OF && DRM && (ARCH_S3C64XX || ARCH_S5PV210 || ARCH_EXYNOS || ARCH_MULTIPLATFORM || COMPILE_TEST)
> +	depends on MMU
>  	select DRM_KMS_HELPER
>  	select VIDEOMODE_HELPERS
>  	select SND_SOC_HDMI_CODEC if SND_SOC
> 

I seen

ERROR: "vmf_insert_mixed" [drivers/gpu/drm/exynos/exynosdrm.ko] undefined!

with older kernels when driver was build as a module, so FWIW

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

Cheers
Vladimir
