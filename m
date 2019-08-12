Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A424AC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 05:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608DB2070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 05:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aWW5sFms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfHLF5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 01:57:38 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57066 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfHLF5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 01:57:38 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7C5vIR4061742;
        Mon, 12 Aug 2019 00:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565589438;
        bh=d/2eujAuWcFMzItdKiZz1Co+QI1jNG7Mcvw6s/uq0OE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=aWW5sFmsib5UYxgILEXnXw+NZAMQwMz0uPV7NaumisPe9UoIh+rdngL/9a29c0sT4
         sTHG54yZhPi0b+Bgb2N95dodWtp54E5cClAQkI/hehzDqaYl5tBHNCf7L9fEUkikFY
         WqpCHXJV88nTU61dWCA3w05/m62gjyjEweMDBJAU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7C5vI9Q080164
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Aug 2019 00:57:18 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 12
 Aug 2019 00:56:05 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 12 Aug 2019 00:56:05 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7C5u3mB022015;
        Mon, 12 Aug 2019 00:56:03 -0500
Subject: Re: [PATCH for-5.3] drm/omap: ensure we have a valid dma_mask
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Christoph Hellwig <hch@lst.de>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>
References: <20190808101042.18809-1-hch@lst.de>
 <7fff8fd3-16ae-1f42-fcd6-9aa360fe36b5@ti.com> <20190809080750.GA21874@lst.de>
 <c219e7e6-0f66-d6fd-e0cf-59c803386825@ti.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <b5961703-6e6f-5183-206b-d792017beb96@ti.com>
Date:   Mon, 12 Aug 2019 08:56:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c219e7e6-0f66-d6fd-e0cf-59c803386825@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/08/2019 13.00, Tomi Valkeinen wrote:
> Here's my version.
> 
> From c258309e36fc86076db155aead03a3900b96c3d4 Mon Sep 17 00:00:00 2001
> From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Date: Fri, 9 Aug 2019 09:54:49 +0300
> Subject: [PATCH] drm/omap: ensure we have a valid dma_mask
> 
> The omapdrm driver uses dma_set_coherent_mask(), but that's not enough
> anymore when LPAE is enabled.
> 
> From Christoph Hellwig <hch@lst.de>:
> 
> The traditional arm DMA code ignores, but the generic dma-direct/swiotlb
> has stricter checks and thus fails mappings without a DMA mask.  As we
> use swiotlb for arm with LPAE now, omapdrm needs to catch up and
> actually set a DMA mask.
> 
> Change the dma_set_coherent_mask() call to
> dma_coerce_mask_and_coherent() so that the dev->dma_mask is also set.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Fixes: ad3c7b18c5b3 ("arm: use swiotlb for bounce buffering on LPAE configs")
> Reported-by: "H. Nikolaus Schaller" <hns@goldelico.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> 
> diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
> index 288c59dae56a..1bad0a2cc5c6 100644
> --- a/drivers/gpu/drm/omapdrm/omap_drv.c
> +++ b/drivers/gpu/drm/omapdrm/omap_drv.c
> @@ -669,7 +669,7 @@ static int pdev_probe(struct platform_device *pdev)
>  	if (omapdss_is_initialized() == false)
>  		return -EPROBE_DEFER;
>  
> -	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
> +	ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to set the DMA mask\n");
>  		return ret;
> 
> 
> 
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
