Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBF6C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636BA21BE6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388289AbfHGO55 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 10:57:57 -0400
Received: from mail-oln040092069085.outbound.protection.outlook.com ([40.92.69.85]:31977
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387915AbfHGO55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 10:57:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFQsEYydBvUh89r53Q6N/nxQzM3JwQ8s5+9q1/TMQIteMrMKuL6QqZKxsgymDQqXM4syGAF6pv0/mvJDCAjGTvI2e8xf9ld+jzy25obCutEkiIYngGhqgHOIKSfA1BcPecnOXHnE32tPPvPxSSjGgJi1zLmLEAIECiSV55uVRv+aqTpmuvksPogBIrBwUPo77saymLYuJDjNpi47XSKjeMJnzE1S2X7HW2EZUK3ce2D46PUzaupSBPcsF1Yoy5wO+krsIdK5cF81OfSSxLFPoLvl4uO/PSy9RixV++6IqfhF6LN68WyjdxTbEPcoLzkCe1K/QceDxxq/Ph18GBt/TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krAO9Vcb3TWPVi+jgwDCKhYYl+NDI+NYXpBKn9OUAkA=;
 b=QQ/fmusyasWNU24yEZKTsCHZSngZV7swAIxO3jIVuI19St1ePtW2kXoocp7WQ/r4xCavH7lER/iyiGFB6SXAU7OJP+qLi6eoJL7ginuikm9JPNPUfNGqdw1m+0l2LEMqiivIyoiw9tK51ARGLNxLWe7FWj6V6rPRCum/OQ6xrNoErZpAxAfQbIkHiTrcJ0FESSTkqKOUWBKfB3Y6EDLKgK55pngjea/6MV+LsJos9xgWsizBiN5fiPeHpAF2vCHBrXnOS2HuP8Sid17CkFoHtqb++6qeOmJTXudrQzs+eYVsUZ31qGjlhO/E6PLWFHlxV4psQdzX0Odjnob55YA9nw==
ARC-Authentication-Results: i=1; mx.microsoft.com
 1;spf=none;dmarc=none;dkim=none;arc=none
Received: from VE1EUR02FT018.eop-EUR02.prod.protection.outlook.com
 (10.152.12.60) by VE1EUR02HT159.eop-EUR02.prod.protection.outlook.com
 (10.152.13.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2136.14; Wed, 7 Aug
 2019 14:57:53 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com (10.152.12.56) by
 VE1EUR02FT018.mail.protection.outlook.com (10.152.12.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2157.15 via Frontend Transport; Wed, 7 Aug 2019 14:57:53 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::b952:7cd2:4c8d:e460]) by HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::b952:7cd2:4c8d:e460%4]) with mapi id 15.20.2157.015; Wed, 7 Aug 2019
 14:57:53 +0000
From:   Jonas Karlman <jonas@kwiboo.se>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Kevin Hilman <khilman@baylibre.com>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 8/8] drm/bridge: dw-hdmi-i2s: add .get_eld support
Thread-Topic: [PATCH 8/8] drm/bridge: dw-hdmi-i2s: add .get_eld support
Thread-Index: AQHVS5N0jSIKg921YEambElhd5+H3qbvyc8A
Date:   Wed, 7 Aug 2019 14:57:53 +0000
Message-ID: <HE1PR06MB40117A899E057B36BE461B8EACD40@HE1PR06MB4011.eurprd06.prod.outlook.com>
References: <20190805134102.24173-1-jbrunet@baylibre.com>
 <20190805134102.24173-9-jbrunet@baylibre.com>
In-Reply-To: <20190805134102.24173-9-jbrunet@baylibre.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR0202CA0010.eurprd02.prod.outlook.com
 (2603:10a6:200:89::20) To HE1PR06MB4011.eurprd06.prod.outlook.com
 (2603:10a6:7:9c::32)
x-incomingtopheadermarker: OriginalChecksum:5F0EFE78D58F44619228BFF3DA3D0769E7EAD631B5AE7906D0299939D681FF76;UpperCasedChecksum:EB3E31C703F69500A8E8A941F3EFFDF9CC91D2BDC281AA706DC00A1D1EBFE832;SizeAsReceived:7735;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [dG3e88mril5xWIDYYzJRdQb3X6dNLYAI]
x-microsoft-original-message-id: <a8f15dd4-9122-404b-625c-d8783f2c1f8d@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:VE1EUR02HT159;
x-ms-traffictypediagnostic: VE1EUR02HT159:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-message-info: 3UWih373MKW4Dkk+kMwJcYyem/V+Zz06Tixg8tsqP4rfX36ffr+dmTiNhOqzsON6KZJChTljVxSazs84rzo4rKgc3ccVqi3h9SRyHv0xm0qoM0rnCsu9zxzIGVEVqRYAuOoyZGOxvWIjK93/nVsLOm6oe7B/KvU8sAV5gGcinU7SwDry1uniqKE3oj8j6FPU
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <CEFFEE3B8C6D594DA8DF310362DFBD3D@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a63a0008-4dfc-4fc7-5358-08d71b479f38
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 14:57:53.2226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR02HT159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-05 15:41, Jerome Brunet wrote:
> Provide the eld to the generic hdmi-codec driver.
> This will let the driver enforce the maximum channel number and set the
> channel allocation depending on the hdmi sink.
>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h     |  1 +
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 10 ++++++++++
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c           |  1 +
>  3 files changed, 12 insertions(+)
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
> index b8ece9c1ba2c..14d499b344c0 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> @@ -121,6 +121,15 @@ static void dw_hdmi_i2s_audio_shutdown(struct device *dev, void *data)
>  	dw_hdmi_audio_disable(hdmi);
>  }
>  
> +static int dw_hdmi_i2s_get_eld(struct device *dev, void *data, uint8_t *buf,
> +			       size_t len)
> +{
> +	struct dw_hdmi_i2s_audio_data *audio = data;
> +
> +	memcpy(buf, audio->eld, min(sizeof(audio->eld), len));

Above sizeof does not work as intended, sizeof(audio->eld) is probably the size of a pointer and not MAX_ELD_BYTES (128),
resulting in only part of the ELD gets copied to buf.


Thanks for reworking dw-hdmi multi channel lpcm support!, this works on Rockchip for most parts.
Without the [1] patch (reset cts+n after clock is enabled) audio sometime stay silent when switching between e.g. 2ch 44.1khz and 6ch 48khz tracks.
It is not fully clear to me why reset cts+n helps, if that have negative affects on other platforms or if there is another way to solve loosing audio.

I also have a small issue with the channel allocation being selected by hdmi-codec, my soundbar reports LPCM 6.1ch instead of LPCM 7.1ch when I play a 7.1ch speaker test clip.
I have a hdmi-codec patch to fix selection of channel allocation in queue.


For patch 1-7:

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>


[1] https://github.com/Kwiboo/linux-rockchip/commit/c0839e874f843ad173ddde958303d6878394ef92

Regards,
Jonas

> +	return 0;
> +}
> +
>  static int dw_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
>  				  struct device_node *endpoint)
>  {
> @@ -144,6 +153,7 @@ static int dw_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
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

