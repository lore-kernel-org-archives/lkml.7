Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B833CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8779C2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Cz6CprBJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfCHOc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 09:32:27 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37622 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfCHOc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 09:32:26 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x28EWGux029230;
        Fri, 8 Mar 2019 08:32:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552055536;
        bh=j+EI3Y+x6/hyQcN3oeoef1UtYAU/WpZSeYBRmVGpY8k=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Cz6CprBJi6bK2XSqBBiq3rfi3Jk4mp5e8uQYeOWDSat341nZT27BFvwHCqGZcNZOS
         Z9CmYa8jaHVS3yZ29xFF6mTpbXHB3/Sx1nrSM9jS3j0iXm+pWmRr+7BstjQxY76Jja
         YZBGm1F42q/OaDHjjxPjc5M83b307QrqZg99fBLY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x28EWGHi120912
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Mar 2019 08:32:16 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 8
 Mar 2019 08:32:14 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 8 Mar 2019 08:32:14 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x28EWBT9002804;
        Fri, 8 Mar 2019 08:32:12 -0600
Subject: Re: [PATCH 2/3] dmaengine: omap-dma: make omap_dma_filter_fn private
To:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20190307151646.1016966-1-arnd@arndb.de>
 <20190307151646.1016966-2-arnd@arndb.de>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <641ebb44-7278-f298-c03d-8251dcd6c71e@ti.com>
Date:   Fri, 8 Mar 2019 16:32:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190307151646.1016966-2-arnd@arndb.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/03/2019 17.16, Arnd Bergmann wrote:
> With the audio driver no longer referring to this function, it
> can be made private to the dmaengine driver itself, and the
> header file removed.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/dma/ti/omap-dma.c      |  3 ++-
>  include/linux/omap-dma.h       |  2 --
>  include/linux/omap-dmaengine.h | 21 ---------------------
>  3 files changed, 2 insertions(+), 24 deletions(-)
>  delete mode 100644 include/linux/omap-dmaengine.h
> 
> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index a4a931ddf6f6..5bf635ba234d 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> @@ -205,6 +205,7 @@ static const unsigned es_bytes[] = {
>  	[CSDP_DATA_TYPE_32] = 4,
>  };
>  
> +static bool omap_dma_filter_fn(struct dma_chan *chan, void *param);
>  static struct of_dma_filter_info omap_dma_info = {
>  	.filter_fn = omap_dma_filter_fn,
>  };
> @@ -1640,7 +1641,7 @@ static struct platform_driver omap_dma_driver = {
>  	},
>  };
>  
> -bool omap_dma_filter_fn(struct dma_chan *chan, void *param)
> +static bool omap_dma_filter_fn(struct dma_chan *chan, void *param)
>  {
>  	if (chan->device->dev->driver == &omap_dma_driver.driver) {
>  		struct omap_dmadev *od = to_omap_dma_dev(chan->device);
> diff --git a/include/linux/omap-dma.h b/include/linux/omap-dma.h
> index 840ce551e773..ba3cfbb52312 100644
> --- a/include/linux/omap-dma.h
> +++ b/include/linux/omap-dma.h
> @@ -1,8 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #ifndef __LINUX_OMAP_DMA_H
>  #define __LINUX_OMAP_DMA_H
> -#include <linux/omap-dmaengine.h>
> -
>  /*
>   *  Legacy OMAP DMA handling defines and functions
>   *
> diff --git a/include/linux/omap-dmaengine.h b/include/linux/omap-dmaengine.h
> deleted file mode 100644
> index 8e6906c72e90..000000000000
> --- a/include/linux/omap-dmaengine.h
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -/*
> - * OMAP DMA Engine support
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -#ifndef __LINUX_OMAP_DMAENGINE_H
> -#define __LINUX_OMAP_DMAENGINE_H
> -
> -struct dma_chan;
> -
> -#if defined(CONFIG_DMA_OMAP) || (defined(CONFIG_DMA_OMAP_MODULE) && defined(MODULE))
> -bool omap_dma_filter_fn(struct dma_chan *, void *);
> -#else
> -static inline bool omap_dma_filter_fn(struct dma_chan *c, void *d)
> -{
> -	return false;
> -}
> -#endif
> -#endif /* __LINUX_OMAP_DMAENGINE_H */
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
