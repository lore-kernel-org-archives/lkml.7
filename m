Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22AEC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A772067D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfHNKIE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 06:08:04 -0400
Received: from mail-oln040092068072.outbound.protection.outlook.com ([40.92.68.72]:57638
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725955AbfHNKIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 06:08:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYZdoUFbDc24k4Drgu4L5VCczH+skK1P8U+x02aUluvN+eNqIJy9sgxQ8LM7pdiYJTQH/ap1ac7pf4EZuny0REYKuLSmMJ/y95nvU8K+gwtYTqxpUFNnWszHDYLiL/EFG1U0mu3TGuSLtKS3CrBVtKxZsr+0ucKJF6W6IS1IB5/c2bm0QQg3uJWp+aaT90lZ8Y5s0YiCq6+lZOsWdHEW5p3jdtcx+428IDSeOK/rX6SjaPfNj5+a8fuqOX6cUmsIWt/ZP3df2ZpVFnpy2GZ9W0NRipeKRZY6qvh21dxkaXUOz+z9BpuYtb5Gx17S7TlbRmel/OnRNwkdwItfnAFgiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NR5NxNQJtyUapF1QtPDV/DA8grF7qTEf6BJpmdlP268=;
 b=DajBhFgd6hwT+CwmlU/AkFLBwQYIrRjYo9Pnul/Phw2bIAzEMRqPyVxFujP18QwASrzE4W5eWUikKT6in2ngnWPHphXirKUx7ArO+lFqfbpDRLABZ+ePqBHWKGHJf7qhX8ion1o4ad5j9ufVfBuDCeeqTmTnmdVq0j2/IsSRKf4tE9t8pKVIYECtdUPYbEkWb9abNWXNnm71mmmCj1KaEoh4ysnwe0HXtB8HlS/UoHjA9axAUrZVsbHCWLH79Zu2Cg/ng1WvSxXCuFKXa69JgySy4Jzw38Jr1OwTrbk4N9ezRgmPsCF0rJAJSdyq9AwOvKdEPzmZSPfvb5PHojP8qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VE1EUR02FT013.eop-EUR02.prod.protection.outlook.com
 (10.152.12.56) by VE1EUR02HT217.eop-EUR02.prod.protection.outlook.com
 (10.152.13.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.15; Wed, 14 Aug
 2019 10:08:00 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com (10.152.12.57) by
 VE1EUR02FT013.mail.protection.outlook.com (10.152.12.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2178.16 via Frontend Transport; Wed, 14 Aug 2019 10:08:00 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::b952:7cd2:4c8d:e460]) by HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::b952:7cd2:4c8d:e460%4]) with mapi id 15.20.2157.022; Wed, 14 Aug 2019
 10:08:00 +0000
From:   Jonas Karlman <jonas@kwiboo.se>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Kevin Hilman <khilman@baylibre.com>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [RESEND PATCH v2 8/8] drm/bridge: dw-hdmi-i2s: add .get_eld
 support
Thread-Topic: [RESEND PATCH v2 8/8] drm/bridge: dw-hdmi-i2s: add .get_eld
 support
Thread-Index: AQHVUQyHpB7kAWBn7kqPIxD3pWYTiqb6bjGA
Date:   Wed, 14 Aug 2019 10:08:00 +0000
Message-ID: <HE1PR06MB401112DA555C49332C968D50ACAD0@HE1PR06MB4011.eurprd06.prod.outlook.com>
References: <20190812120726.1528-9-jbrunet@baylibre.com>
 <20190812125016.20169-1-jbrunet@baylibre.com>
In-Reply-To: <20190812125016.20169-1-jbrunet@baylibre.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0051.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::19) To HE1PR06MB4011.eurprd06.prod.outlook.com
 (2603:10a6:7:9c::32)
x-incomingtopheadermarker: OriginalChecksum:D494B6AF08BF40FBF92638DDD8A4D59F407F39174239B7F9E6523763EA9E57BB;UpperCasedChecksum:DAF511C40F22CAC2B53AA4142B4A255422B1A9FE2C55EB46054A32F190BF0572;SizeAsReceived:7723;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [LCsCnxmRS6BMnifjFpxUzBOE12c/6op/]
x-microsoft-original-message-id: <13bb5f91-c9aa-7e66-e2ae-492ec8b46b57@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:VE1EUR02HT217;
x-ms-traffictypediagnostic: VE1EUR02HT217:
x-microsoft-antispam-message-info: wZKtRV7CwSIA7HMbUiA5v1ZzohMuRGjuU/LHFClGgLuXagAvmKGU2w6CRzkPT+ueJ3jnFrttFOynK9kBYdejMo/pSYwRGOAGwL5ygQi/Ip/TKEXBUiw/gQQHpxrzJ8u+qpBSqAWeGkRsXyzIshaRJLtfJV0EP/mJz/hH/ABy5kAboE7SGoOSDYleRgivrZuf
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <2CFCBE53D18BD54898332EA4864AEF33@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2601b5fb-ee98-4491-9ade-08d7209f4919
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2019 10:08:00.2084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR02HT217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-12 14:50, Jerome Brunet wrote:
> Provide the eld to the generic hdmi-codec driver.
> This will let the driver enforce the maximum channel number and set the
> channel allocation depending on the hdmi sink.
>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Tested on Rockchip RK3288/RK3328 devices, full ELD is now available to userspace.
Please note that the r-b line in patch 2 is mixed in middle of commit message.

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h     |  1 +
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 11 +++++++++++
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c           |  1 +
>  3 files changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h
> index 63b5756f463b..cb07dc0da5a7 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h
> @@ -14,6 +14,7 @@ struct dw_hdmi_audio_data {
>  
>  struct dw_hdmi_i2s_audio_data {
>  	struct dw_hdmi *hdmi;
> +	u8 *eld;
>  
>  	void (*write)(struct dw_hdmi *hdmi, u8 val, int offset);
>  	u8 (*read)(struct dw_hdmi *hdmi, int offset);
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> index b8ece9c1ba2c..1d15cf9b6821 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> @@ -10,6 +10,7 @@
>  #include <linux/module.h>
>  
>  #include <drm/bridge/dw_hdmi.h>
> +#include <drm/drm_crtc.h>
>  
>  #include <sound/hdmi-codec.h>
>  
> @@ -121,6 +122,15 @@ static void dw_hdmi_i2s_audio_shutdown(struct device *dev, void *data)
>  	dw_hdmi_audio_disable(hdmi);
>  }
>  
> +static int dw_hdmi_i2s_get_eld(struct device *dev, void *data, uint8_t *buf,
> +			       size_t len)
> +{
> +	struct dw_hdmi_i2s_audio_data *audio = data;
> +
> +	memcpy(buf, audio->eld, min_t(size_t, MAX_ELD_BYTES, len));
> +	return 0;
> +}
> +
>  static int dw_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
>  				  struct device_node *endpoint)
>  {
> @@ -144,6 +154,7 @@ static int dw_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
>  static struct hdmi_codec_ops dw_hdmi_i2s_ops = {
>  	.hw_params	= dw_hdmi_i2s_hw_params,
>  	.audio_shutdown	= dw_hdmi_i2s_audio_shutdown,
> +	.get_eld	= dw_hdmi_i2s_get_eld,
>  	.get_dai_id	= dw_hdmi_i2s_get_dai_id,
>  };
>  
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index bed4bb017afd..8df69c9dbfad 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2797,6 +2797,7 @@ __dw_hdmi_probe(struct platform_device *pdev,
>  		struct dw_hdmi_i2s_audio_data audio;
>  
>  		audio.hdmi	= hdmi;
> +		audio.eld	= hdmi->connector.eld;
>  		audio.write	= hdmi_writeb;
>  		audio.read	= hdmi_readb;
>  		hdmi->enable_audio = dw_hdmi_i2s_audio_enable;

