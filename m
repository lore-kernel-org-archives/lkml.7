Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F93C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F1D2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S0Ap6BOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfCHOcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 09:32:15 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59982 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfCHOcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 09:32:15 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x28EW0O0082453;
        Fri, 8 Mar 2019 08:32:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552055520;
        bh=tEhZGV1ImB6FZXDOWFZ17IXQF53AFz1U/iY/EJMG/PY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=S0Ap6BOp/04UwIEmfzJFAOG5bM/7LgbTN8QZ/sT7aRJiGWqeEOF5klhAddgYmaAFj
         RHyRDw23m/ugHZEFF8cAY2dEkDU6zR8J5KHh53owK6OHARF4c+MQRTLUpGxjD4Pv8R
         JpYIT+1mZIdRSSYnzaBgjA3ER03oiqXCouTOBDyM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x28EW0in107410
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Mar 2019 08:32:00 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 8
 Mar 2019 08:31:59 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 8 Mar 2019 08:31:59 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x28EVv3v027079;
        Fri, 8 Mar 2019 08:31:57 -0600
Subject: Re: [PATCH 3/3] dmaengine: edma: make edma_filter_fn private
To:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20190307151646.1016966-1-arnd@arndb.de>
 <20190307151646.1016966-3-arnd@arndb.de>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <de62088c-c09c-a198-412e-6507168bb31e@ti.com>
Date:   Fri, 8 Mar 2019 16:32:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190307151646.1016966-3-arnd@arndb.de>
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

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/dma/ti/edma.c |  5 +++--
>  include/linux/edma.h  | 29 -----------------------------
>  2 files changed, 3 insertions(+), 31 deletions(-)
>  delete mode 100644 include/linux/edma.h
> 
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index ceabdea40ae0..f2549ee3fb49 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -15,7 +15,6 @@
>  
>  #include <linux/dmaengine.h>
>  #include <linux/dma-mapping.h>
> -#include <linux/edma.h>
>  #include <linux/err.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> @@ -2185,6 +2184,8 @@ static struct dma_chan *of_edma_xlate(struct of_phandle_args *dma_spec,
>  }
>  #endif
>  
> +static bool edma_filter_fn(struct dma_chan *chan, void *param);
> +
>  static int edma_probe(struct platform_device *pdev)
>  {
>  	struct edma_soc_info	*info = pdev->dev.platform_data;
> @@ -2524,7 +2525,7 @@ static struct platform_driver edma_tptc_driver = {
>  	},
>  };
>  
> -bool edma_filter_fn(struct dma_chan *chan, void *param)
> +static bool edma_filter_fn(struct dma_chan *chan, void *param)
>  {
>  	bool match = false;
>  
> diff --git a/include/linux/edma.h b/include/linux/edma.h
> deleted file mode 100644
> index a1307e7827e8..000000000000
> --- a/include/linux/edma.h
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -/*
> - * TI EDMA DMA engine driver
> - *
> - * Copyright 2012 Texas Instruments
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation version 2.
> - *
> - * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> - * kind, whether express or implied; without even the implied warranty
> - * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> -#ifndef __LINUX_EDMA_H
> -#define __LINUX_EDMA_H
> -
> -struct dma_chan;
> -
> -#if defined(CONFIG_TI_EDMA) || defined(CONFIG_TI_EDMA_MODULE)
> -bool edma_filter_fn(struct dma_chan *, void *);
> -#else
> -static inline bool edma_filter_fn(struct dma_chan *chan, void *param)
> -{
> -	return false;
> -}
> -#endif
> -
> -#endif
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
