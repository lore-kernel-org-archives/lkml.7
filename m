Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBA4C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 06:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C44B2166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 06:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hLiBqtHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405592AbfHIGk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 02:40:57 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58156 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfHIGk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 02:40:56 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x796eaGB033320;
        Fri, 9 Aug 2019 01:40:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565332836;
        bh=hIPNXoolm+R//pJaCGr9G32GodD/jqixzmQHbhz7icI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hLiBqtHOGzLgU897v6BBPIJQlbOH7izr+RIcMbzP2GOUM6yWg96rPad3c6AIIjMns
         W1hxE67Fw6NeQYwKFfAi25tctnrAzoaB2uMfC7wE4J3VEbuFyg2Hb5WGXvug4D4wDe
         VaeLrUrFSjqVQdbod5yguhAJeeiKqwWJ9w624r24=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x796eaD6078619
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Aug 2019 01:40:36 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 9 Aug
 2019 01:40:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 9 Aug 2019 01:40:35 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x796eXO0070071;
        Fri, 9 Aug 2019 01:40:33 -0500
Subject: Re: [PATCH for-5.3] drm/omap: ensure we have a valid dma_mask
To:     Christoph Hellwig <hch@lst.de>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
References: <20190808101042.18809-1-hch@lst.de>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <7fff8fd3-16ae-1f42-fcd6-9aa360fe36b5@ti.com>
Date:   Fri, 9 Aug 2019 09:40:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808101042.18809-1-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/08/2019 13:10, Christoph Hellwig wrote:
> The omapfb platform devices does not have a DMA mask set.  The
> traditional arm DMA code ignores, but the generic dma-direct/swiotlb
> has stricter checks and thus fails mappings without a DMA mask.
> As we use swiotlb for arm with LPAE now, omap needs to catch up
> and actually set a DMA mask.
> 
> Fixes: ad3c7b18c5b3 ("arm: use swiotlb for bounce buffering on LPAE configs")
> Reported-by: "H. Nikolaus Schaller" <hns@goldelico.com>
> Tested-by: "H. Nikolaus Schaller" <hns@goldelico.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/gpu/drm/omapdrm/omap_fbdev.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/omapdrm/omap_fbdev.c b/drivers/gpu/drm/omapdrm/omap_fbdev.c
> index 561c4812545b..2c8abf07e617 100644
> --- a/drivers/gpu/drm/omapdrm/omap_fbdev.c
> +++ b/drivers/gpu/drm/omapdrm/omap_fbdev.c
> @@ -232,6 +232,8 @@ void omap_fbdev_init(struct drm_device *dev)
>   	if (!priv->num_pipes)
>   		return;
>   
> +	dma_coerce_mask_and_coherent(dev->dev, DMA_BIT_MASK(32));
> +
>   	fbdev = kzalloc(sizeof(*fbdev), GFP_KERNEL);
>   	if (!fbdev)
>   		goto fail;
> 

We do call dma_set_coherent_mask() in omapdrm's probe() (in omap_drv.c), 
but apparently that's not enough anymore. Changing that call to 
dma_coerce_mask_and_coherent() removes the WARN. I can create a patch 
for that, or Christoph can respin this one.

I am not too familiar with the dma mask handling, so maybe someone can 
educate:

dma_coerce_mask_and_coherent() overwrites dev->dma_mask. Isn't that a 
bad thing? What if the platform has set dev->dma_mask, and the driver 
overwrites it with its value? Or who is supposed to set dev->dma_mask?

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
