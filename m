Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D23C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7738B21473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kAZWZizh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfFNMCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:02:54 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50706 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbfFNMCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:02:54 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5EC2mVo121156;
        Fri, 14 Jun 2019 07:02:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560513768;
        bh=kTOOVS4lzR0ZGAawOm/QCWHiNqtFPNN7v2karhZmd94=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=kAZWZizhqg3dOKfeofrqT3kWX9NE99xhqM4m+tZjB1flTyVksciCTz7JLxjOVkzFc
         MwS/IIzpwHfykNmxNQqvwxYWMhMVNmHQgQ0ol6vGxG0aw/lH2llMf9rkc4CWGFsvJC
         POweS/21SYewNz3Ro+hEkdj98d4BKPukrhrlEaTk=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5EC2mSA083103
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Jun 2019 07:02:48 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 14
 Jun 2019 07:02:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 14 Jun 2019 07:02:47 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5EC2jcQ038250;
        Fri, 14 Jun 2019 07:02:45 -0500
Subject: Re: [PATCH] ARM: davinci: da8xx: specify dma_coherent_mask for lcdc
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190607143350.11214-1-brgl@bgdev.pl>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <a437ee74-6e1d-c8cd-d9ad-7ccaf28faf9c@ti.com>
Date:   Fri, 14 Jun 2019 17:32:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190607143350.11214-1-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/19 8:03 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The lcdc device is missing the dma_coherent_mask definition causing the
> following warning on da850-evm:
> 
> da8xx_lcdc da8xx_lcdc.0: found Sharp_LK043T1DG01 panel
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at kernel/dma/mapping.c:247 dma_alloc_attrs+0xc8/0x110
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper Not tainted 5.2.0-rc3-00077-g16d72dd4891f #18
> Hardware name: DaVinci DA850/OMAP-L138/AM18x EVM
> [<c000fce8>] (unwind_backtrace) from [<c000d900>] (show_stack+0x10/0x14)
> [<c000d900>] (show_stack) from [<c001a4f8>] (__warn+0xec/0x114)
> [<c001a4f8>] (__warn) from [<c001a634>] (warn_slowpath_null+0x3c/0x48)
> [<c001a634>] (warn_slowpath_null) from [<c0065860>] (dma_alloc_attrs+0xc8/0x110)
> [<c0065860>] (dma_alloc_attrs) from [<c02820f8>] (fb_probe+0x228/0x5a8)
> [<c02820f8>] (fb_probe) from [<c02d3e9c>] (platform_drv_probe+0x48/0x9c)
> [<c02d3e9c>] (platform_drv_probe) from [<c02d221c>] (really_probe+0x1d8/0x2d4)
> [<c02d221c>] (really_probe) from [<c02d2474>] (driver_probe_device+0x5c/0x168)
> [<c02d2474>] (driver_probe_device) from [<c02d2728>] (device_driver_attach+0x58/0x60)
> [<c02d2728>] (device_driver_attach) from [<c02d27b0>] (__driver_attach+0x80/0xbc)
> [<c02d27b0>] (__driver_attach) from [<c02d047c>] (bus_for_each_dev+0x64/0xb4)
> [<c02d047c>] (bus_for_each_dev) from [<c02d1590>] (bus_add_driver+0xe4/0x1d8)
> [<c02d1590>] (bus_add_driver) from [<c02d301c>] (driver_register+0x78/0x10c)
> [<c02d301c>] (driver_register) from [<c000a5c0>] (do_one_initcall+0x48/0x1bc)
> [<c000a5c0>] (do_one_initcall) from [<c05cae6c>] (kernel_init_freeable+0x10c/0x1d8)
> [<c05cae6c>] (kernel_init_freeable) from [<c048a000>] (kernel_init+0x8/0xf4)
> [<c048a000>] (kernel_init) from [<c00090e0>] (ret_from_fork+0x14/0x34)
> Exception stack(0xc6837fb0 to 0xc6837ff8)
> 7fa0:                                     00000000 00000000 00000000 00000000
> 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> ---[ end trace 8a8073511be81dd2 ]---
> 
> Add a 32-bit mask to the platform device's definition.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/mach-davinci/devices-da8xx.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
> index 9ff02de448c6..767cc6f7834c 100644
> --- a/arch/arm/mach-davinci/devices-da8xx.c
> +++ b/arch/arm/mach-davinci/devices-da8xx.c
> @@ -683,6 +683,9 @@ static struct platform_device da8xx_lcdc_device = {
>  	.id		= 0,
>  	.num_resources	= ARRAY_SIZE(da8xx_lcdc_resources),
>  	.resource	= da8xx_lcdc_resources,
> +	.dev		= {
> +		.coherent_dma_mask	= DMA_BIT_MASK(32)

Applied to fixes for v5.2 with a ',' added at the end so next
initialization can be added without changing this line.

Thanks,
Sekhar
