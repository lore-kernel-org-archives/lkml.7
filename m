Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AFEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D80020880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MrSG+S8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfDAKVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:21:53 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35764 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfDAKVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:21:52 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x31ALgiO009557;
        Mon, 1 Apr 2019 05:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554114102;
        bh=8boVWkCzhzJVm53tle20KwP8RDULPry1l1N8Iq+0u4w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=MrSG+S8Mpn3nv4tJDWqeROAiC3pycrQp2bW7owALN9xTqphsZoY+9RnbHZd1+Ox+r
         6uKj5qrblMjkIjI+DPaNdxsJVSLkdykA0ioHswsa6Ds21Cl+7vqpxecnr9gVKa79hs
         XF7kZ20uhEF6eIVlh4ciLuGNr35bsejkTpEyjcUM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x31ALgFp019306
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Apr 2019 05:21:42 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 1 Apr
 2019 05:21:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 1 Apr 2019 05:21:41 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x31ALcWx015794;
        Mon, 1 Apr 2019 05:21:38 -0500
Subject: Re: [PATCH -next] drm/omap: Use PTR_ERR_OR_ZERO in hdmi4_core_init()
To:     YueHaibing <yuehaibing@huawei.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Matteo Croce <mcroce@redhat.com>,
        Benoit Parrot <bparrot@ti.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20190329014136.20318-1-yuehaibing@huawei.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <3dec4093-824e-b13d-d712-2dedd445a7b7@ti.com>
Date:   Mon, 1 Apr 2019 13:21:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190329014136.20318-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29/03/2019 03:41, YueHaibing wrote:
> Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/omapdrm/dss/hdmi4_core.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c b/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c
> index e384b95ad857..8287ade5ece0 100644
> --- a/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c
> +++ b/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c
> @@ -934,8 +934,5 @@ int hdmi4_core_init(struct platform_device *pdev, struct hdmi_core_data *core)
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "core");
>  	core->base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(core->base))
> -		return PTR_ERR(core->base);
> -
> -	return 0;
> +	return PTR_ERR_OR_ZERO(core->base);
>  }

Thanks, but I don't usually want this kind of patches. They're mostly
just extra changes, increasing the chance of conflicts, and, in my
opinion, the current code is clearer than the proposed one.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
