Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CDCC33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 06:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233B92075A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 06:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i21aNB1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgAGGsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 01:48:16 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46562 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgAGGsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 01:48:16 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0076ljZb049917;
        Tue, 7 Jan 2020 00:47:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578379665;
        bh=ODJ0NEYqrokHx/XZRr/mSRy9p7wnelQTyTQlEpgfxH4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=i21aNB1qs9sdXY54gDqh6MG8zV4rcKAjiHzA9EMtNipbZbsJRgqHWqw/deDRJEDMd
         xCXx4e41TXY+ClHHc4irVRTxHO8g96+vKgo6RBPPjt8ZB+jXcgk/zlovDEICyQ2B5w
         ElVly+gQRAci5vAHiRsFEgL6/4dmF2Oat8pH/FVc=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0076ljgs110930
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Jan 2020 00:47:45 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 7 Jan
 2020 00:47:43 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 7 Jan 2020 00:47:43 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0076leCl053362;
        Tue, 7 Jan 2020 00:47:41 -0600
Subject: Re: [PATCH] drm: replace IS_ERR and PTR_ERR with PTR_ERR_OR_ZERO
To:     yu kuai <yukuai3@huawei.com>
CC:     Maxime Ripard <mripard@kernel.org>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <wens@csie.org>, <jernej.skrabec@siol.net>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <zhengbin13@huawei.com>,
        <yi.zhang@huawei.com>
References: <20191225132042.5491-1-yukuai3@huawei.com>
 <20191227115401.agumkfuiwexl2wmx@hendrix.home>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <ec4d34d6-7c58-ea1e-cc9c-c2df0baaf23b@ti.com>
Date:   Tue, 7 Jan 2020 08:47:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191227115401.agumkfuiwexl2wmx@hendrix.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/12/2019 13:54, Maxime Ripard wrote:
> On Wed, Dec 25, 2019 at 09:20:42PM +0800, yu kuai wrote:
>> no functional change, just to make the code simpler
>>
>> Signed-off-by: yu kuai <yukuai3@huawei.com>
>> ---
>>   drivers/gpu/drm/omapdrm/dss/hdmi4.c         | 5 +----
>>   drivers/gpu/drm/omapdrm/dss/hdmi4_core.c    | 6 ++----
>>   drivers/gpu/drm/omapdrm/dss/hdmi5_core.c    | 4 +---
>>   drivers/gpu/drm/omapdrm/dss/hdmi_phy.c      | 4 +---
>>   drivers/gpu/drm/sun4i/sun4i_dotclock.c      | 4 +---
>>   drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c      | 4 +---
>>   drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c | 4 +---
>>   drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c  | 5 +----
>>   drivers/gpu/drm/tegra/drm.c                 | 4 +---
>>   drivers/gpu/drm/tegra/gem.c                 | 4 +---
>>   10 files changed, 11 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4.c b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
>> index 0f557fad4513..eb71baedf19e 100644
>> --- a/drivers/gpu/drm/omapdrm/dss/hdmi4.c
>> +++ b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
>> @@ -587,10 +587,7 @@ static int hdmi_audio_register(struct omap_hdmi *hdmi)
>>   		&hdmi->pdev->dev, "omap-hdmi-audio", PLATFORM_DEVID_AUTO,
>>   		&pdata, sizeof(pdata));
>>
>> -	if (IS_ERR(hdmi->audio_pdev))
>> -		return PTR_ERR(hdmi->audio_pdev);
>> -
>> -	return 0;
>> +	return PTR_ERR_OR_ZERO(hdmi->audio_pdev);
>>   }
>>
>>   /* -----------------------------------------------------------------------------
>> diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c b/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c
>> index ea5d5c228534..fdd73fb73653 100644
>> --- a/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c
>> +++ b/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c
>> @@ -924,8 +924,6 @@ int hdmi4_core_init(struct platform_device *pdev, struct hdmi_core_data *core)
>>
>>   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "core");
>>   	core->base = devm_ioremap_resource(&pdev->dev, res);
>> -	if (IS_ERR(core->base))
>> -		return PTR_ERR(core->base);
>> -
>> -	return 0;
>> +
>> +	return PTR_ERR_OR_ZERO(core->base);
>>   }
>> diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi5_core.c b/drivers/gpu/drm/omapdrm/dss/hdmi5_core.c
>> index ff4d35c8771f..30454bc9de78 100644
>> --- a/drivers/gpu/drm/omapdrm/dss/hdmi5_core.c
>> +++ b/drivers/gpu/drm/omapdrm/dss/hdmi5_core.c
>> @@ -908,8 +908,6 @@ int hdmi5_core_init(struct platform_device *pdev, struct hdmi_core_data *core)
>>
>>   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "core");
>>   	core->base = devm_ioremap_resource(&pdev->dev, res);
>> -	if (IS_ERR(core->base))
>> -		return PTR_ERR(core->base);
>>
>> -	return 0;
>> +	return PTR_ERR_OR_ZERO(core->base);
>>   }
>> diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi_phy.c b/drivers/gpu/drm/omapdrm/dss/hdmi_phy.c
>> index 00bbf24488c1..bbc02d5aa8fb 100644
>> --- a/drivers/gpu/drm/omapdrm/dss/hdmi_phy.c
>> +++ b/drivers/gpu/drm/omapdrm/dss/hdmi_phy.c
>> @@ -191,8 +191,6 @@ int hdmi_phy_init(struct platform_device *pdev, struct hdmi_phy_data *phy,
>>
>>   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
>>   	phy->base = devm_ioremap_resource(&pdev->dev, res);
>> -	if (IS_ERR(phy->base))
>> -		return PTR_ERR(phy->base);
>>
>> -	return 0;
>> +	return PTR_ERR_OR_ZERO(phy->base);
>>   }
>> diff --git a/drivers/gpu/drm/sun4i/sun4i_dotclock.c b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
>> index 417ade3d2565..84c04d8192b3 100644
>> --- a/drivers/gpu/drm/sun4i/sun4i_dotclock.c
>> +++ b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
>> @@ -191,10 +191,8 @@ int sun4i_dclk_create(struct device *dev, struct sun4i_tcon *tcon)
>>   	dclk->hw.init = &init;
>>
>>   	tcon->dclk = clk_register(dev, &dclk->hw);
>> -	if (IS_ERR(tcon->dclk))
>> -		return PTR_ERR(tcon->dclk);
>>
>> -	return 0;
>> +	return PTR_ERR_OR_ZERO(tcon->dclk);
> 
> This has been submitted a couple of times already. It's harder to
> maintain and not easier to read.
> 
> Please remove sun4i from your patch

Nack for the omapdrm parts too, for the same reasons.

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
