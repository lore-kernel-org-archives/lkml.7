Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E6BC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC618218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fcqn/tPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfJJKhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 06:37:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37227 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfJJKhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 06:37:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id f22so6219497wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 03:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=K+XnDvxSQJuhvCO7KGIXntE1hETq5N43SqA3okY4rkw=;
        b=fcqn/tPAl5OOWXqguYr2ZigXSGdA3N77cr9Y0nVJ9VA/Lxa2SjIEXz6CWIpPo1zdFL
         dgRFHjtncuYeJZKCpOXRd0d6u7D2SUiomHfExNxteWqmgsBab46/2YNojZKymAfTi9P1
         VSZd5XTNiE+MzBQ6jy/j2i1mJ2iNdDciV1dkl2XUQ5/uGGRLjY5+CQux95wl+hj6aYdR
         l+2N0x7R6r+hWe9qLbUwqCQzdi8ns7f1Wmixhub2xI1VFRElv4Z8iF2xFMUILpqoKRIf
         VEXUEpgayY43gj6mgZVTx9IndeXil3qlc5mzqXzuPLdj1x2/I9VEW8nLJhIdRiStRyAy
         VM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=K+XnDvxSQJuhvCO7KGIXntE1hETq5N43SqA3okY4rkw=;
        b=lelk7d11/2VcjOyL8ydVdYHfZYvzifcpeVkciqBtYZfC1rML+aYK3i0mpnxibCYWQh
         0E0vkp8WihL8B8RPuh/T0klvTd5m9/eAdiEzDei3975tt40sA1sDUzgvhXIWFoBDpGc6
         FWL2c+rDXRdCmS3VOmW/JVPdIxttb6zjbcdg9SaUVEtaaepyd7hYiaTFiZr+oW2M3Ce+
         Ohkrx38a+w8ZHeOITWmkjf5BoMLRp3lBEz4SaLFpBRTyRWzKMN6MZuJ0IXF/n8ciRfUx
         qnjPUNuLXpnAQCP7OMYAdxTQdp5UKqW4iEGE5JChlKg6ZhcKE/6ZdDi/3CTfjMi9OUMS
         w/Xw==
X-Gm-Message-State: APjAAAXqqOuF5t4pra05e32AXIlJmZGVl4X9PdxV4g/WAy0NTDH2Wg2q
        vsxFS1MIG7amhskBa4xj79mErxm5sj1iZw==
X-Google-Smtp-Source: APXvYqx3e7565BXuQKOZpvF5vrHvpbKWNvFChxp5OFkT2TCaXmuwbf2AwXZsIwBA3j3vYxTu99/dEQ==
X-Received: by 2002:a1c:4e09:: with SMTP id g9mr7238075wmh.96.1570703857425;
        Thu, 10 Oct 2019 03:37:37 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q192sm5491697wme.23.2019.10.10.03.37.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 03:37:36 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] drm/bridge: dw-hdmi: Add Dynamic Range and
 Mastering InfoFrame support
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko Stubner <heiko@sntech.de>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "zhengyang@rock-chips.com" <zhengyang@rock-chips.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <HE1PR06MB401113BF395C06E96503344FAC9B0@HE1PR06MB4011.eurprd06.prod.outlook.com>
 <CGME20191007192154epcas4p32fbfbce564847de5dac47a5e99972644@epcas4p3.samsung.com>
 <HE1PR06MB4011D7B916CBF8B740ACC45FAC9B0@HE1PR06MB4011.eurprd06.prod.outlook.com>
 <ced39de1-fc69-4e9b-550f-f3fe7d73a434@samsung.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <44e3c8f8-bfff-ae1c-7bc1-463935151e87@baylibre.com>
Date:   Thu, 10 Oct 2019 12:37:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ced39de1-fc69-4e9b-550f-f3fe7d73a434@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2019 12:12, Andrzej Hajda wrote:
> On 07.10.2019 21:21, Jonas Karlman wrote:
>> Add support for configuring Dynamic Range and Mastering InfoFrame from
>> the hdr_output_metadata connector property.
>>
>> This patch adds a use_drm_infoframe flag to dw_hdmi_plat_data that platform
>> drivers use to signal when Dynamic Range and Mastering infoframes is supported.
>> This flag is needed because Amlogic GXBB and GXL report same DW-HDMI version,
>> and only GXL support DRM InfoFrame.
>>
>> These changes were based on work done by Zheng Yang <zhengyang@rock-chips.com>
>> to support DRM InfoFrame on the Rockchip 4.4 BSP kernel at [1] and [2]
>>
>> [1] https://github.com/rockchip-linux/kernel/tree/develop-4.4
>> [2] https://github.com/rockchip-linux/kernel/commit/d1943fde81ff41d7cca87f4a42f03992e90bddd5
>>
>> Cc: Zheng Yang <zhengyang@rock-chips.com>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> 
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> 
> 
> Neil, since you want to take care of patch3/4, will you take care of the
> whole patchset?

Sure,

Neil

> 
> 
>  --
> Regards
> Andrzej
> 
> 
>> ---
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 81 +++++++++++++++++++++++
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h | 37 +++++++++++
>>  include/drm/bridge/dw_hdmi.h              |  1 +
>>  3 files changed, 119 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> index a15fbf71b9d7..fdc29869d75a 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> @@ -25,6 +25,7 @@
>>  #include <uapi/linux/videodev2.h>
>>  
>>  #include <drm/bridge/dw_hdmi.h>
>> +#include <drm/drm_atomic.h>
>>  #include <drm/drm_atomic_helper.h>
>>  #include <drm/drm_bridge.h>
>>  #include <drm/drm_edid.h>
>> @@ -1743,6 +1744,41 @@ static void hdmi_config_vendor_specific_infoframe(struct dw_hdmi *hdmi,
>>  			HDMI_FC_DATAUTO0_VSD_MASK);
>>  }
>>  
>> +static void hdmi_config_drm_infoframe(struct dw_hdmi *hdmi)
>> +{
>> +	const struct drm_connector_state *conn_state = hdmi->connector.state;
>> +	struct hdmi_drm_infoframe frame;
>> +	u8 buffer[30];
>> +	ssize_t err;
>> +	int i;
>> +
>> +	if (!hdmi->plat_data->use_drm_infoframe)
>> +		return;
>> +
>> +	hdmi_modb(hdmi, HDMI_FC_PACKET_TX_EN_DRM_DISABLE,
>> +		  HDMI_FC_PACKET_TX_EN_DRM_MASK, HDMI_FC_PACKET_TX_EN);
>> +
>> +	err = drm_hdmi_infoframe_set_hdr_metadata(&frame, conn_state);
>> +	if (err < 0)
>> +		return;
>> +
>> +	err = hdmi_drm_infoframe_pack(&frame, buffer, sizeof(buffer));
>> +	if (err < 0) {
>> +		dev_err(hdmi->dev, "Failed to pack drm infoframe: %zd\n", err);
>> +		return;
>> +	}
>> +
>> +	hdmi_writeb(hdmi, frame.version, HDMI_FC_DRM_HB0);
>> +	hdmi_writeb(hdmi, frame.length, HDMI_FC_DRM_HB1);
>> +
>> +	for (i = 0; i < frame.length; i++)
>> +		hdmi_writeb(hdmi, buffer[4 + i], HDMI_FC_DRM_PB0 + i);
>> +
>> +	hdmi_writeb(hdmi, 1, HDMI_FC_DRM_UP);
>> +	hdmi_modb(hdmi, HDMI_FC_PACKET_TX_EN_DRM_ENABLE,
>> +		  HDMI_FC_PACKET_TX_EN_DRM_MASK, HDMI_FC_PACKET_TX_EN);
>> +}
>> +
>>  static void hdmi_av_composer(struct dw_hdmi *hdmi,
>>  			     const struct drm_display_mode *mode)
>>  {
>> @@ -2064,6 +2100,7 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
>>  		/* HDMI Initialization Step F - Configure AVI InfoFrame */
>>  		hdmi_config_AVI(hdmi, mode);
>>  		hdmi_config_vendor_specific_infoframe(hdmi, mode);
>> +		hdmi_config_drm_infoframe(hdmi);
>>  	} else {
>>  		dev_dbg(hdmi->dev, "%s DVI mode\n", __func__);
>>  	}
>> @@ -2230,6 +2267,45 @@ static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
>>  	return ret;
>>  }
>>  
>> +static bool hdr_metadata_equal(const struct drm_connector_state *old_state,
>> +			       const struct drm_connector_state *new_state)
>> +{
>> +	struct drm_property_blob *old_blob = old_state->hdr_output_metadata;
>> +	struct drm_property_blob *new_blob = new_state->hdr_output_metadata;
>> +
>> +	if (!old_blob || !new_blob)
>> +		return old_blob == new_blob;
>> +
>> +	if (old_blob->length != new_blob->length)
>> +		return false;
>> +
>> +	return !memcmp(old_blob->data, new_blob->data, old_blob->length);
>> +}
>> +
>> +static int dw_hdmi_connector_atomic_check(struct drm_connector *connector,
>> +					  struct drm_atomic_state *state)
>> +{
>> +	struct drm_connector_state *old_state =
>> +		drm_atomic_get_old_connector_state(state, connector);
>> +	struct drm_connector_state *new_state =
>> +		drm_atomic_get_new_connector_state(state, connector);
>> +	struct drm_crtc *crtc = new_state->crtc;
>> +	struct drm_crtc_state *crtc_state;
>> +
>> +	if (!crtc)
>> +		return 0;
>> +
>> +	if (!hdr_metadata_equal(old_state, new_state)) {
>> +		crtc_state = drm_atomic_get_crtc_state(state, crtc);
>> +		if (IS_ERR(crtc_state))
>> +			return PTR_ERR(crtc_state);
>> +
>> +		crtc_state->mode_changed = true;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static void dw_hdmi_connector_force(struct drm_connector *connector)
>>  {
>>  	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
>> @@ -2254,6 +2330,7 @@ static const struct drm_connector_funcs dw_hdmi_connector_funcs = {
>>  
>>  static const struct drm_connector_helper_funcs dw_hdmi_connector_helper_funcs = {
>>  	.get_modes = dw_hdmi_connector_get_modes,
>> +	.atomic_check = dw_hdmi_connector_atomic_check,
>>  };
>>  
>>  static int dw_hdmi_bridge_attach(struct drm_bridge *bridge)
>> @@ -2274,6 +2351,10 @@ static int dw_hdmi_bridge_attach(struct drm_bridge *bridge)
>>  				    DRM_MODE_CONNECTOR_HDMIA,
>>  				    hdmi->ddc);
>>  
>> +	if (hdmi->version >= 0x200a && hdmi->plat_data->use_drm_infoframe)
>> +		drm_object_attach_property(&connector->base,
>> +			connector->dev->mode_config.hdr_output_metadata_property, 0);
>> +
>>  	drm_connector_attach_encoder(connector, encoder);
>>  
>>  	cec_fill_conn_info_from_drm(&conn_info, connector);
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
>> index fcff5059db24..1999db05bc3b 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
>> @@ -254,6 +254,7 @@
>>  #define HDMI_FC_POL2                            0x10DB
>>  #define HDMI_FC_PRCONF                          0x10E0
>>  #define HDMI_FC_SCRAMBLER_CTRL                  0x10E1
>> +#define HDMI_FC_PACKET_TX_EN                    0x10E3
>>  
>>  #define HDMI_FC_GMD_STAT                        0x1100
>>  #define HDMI_FC_GMD_EN                          0x1101
>> @@ -289,6 +290,37 @@
>>  #define HDMI_FC_GMD_PB26                        0x111F
>>  #define HDMI_FC_GMD_PB27                        0x1120
>>  
>> +#define HDMI_FC_DRM_UP                          0x1167
>> +#define HDMI_FC_DRM_HB0                         0x1168
>> +#define HDMI_FC_DRM_HB1                         0x1169
>> +#define HDMI_FC_DRM_PB0                         0x116A
>> +#define HDMI_FC_DRM_PB1                         0x116B
>> +#define HDMI_FC_DRM_PB2                         0x116C
>> +#define HDMI_FC_DRM_PB3                         0x116D
>> +#define HDMI_FC_DRM_PB4                         0x116E
>> +#define HDMI_FC_DRM_PB5                         0x116F
>> +#define HDMI_FC_DRM_PB6                         0x1170
>> +#define HDMI_FC_DRM_PB7                         0x1171
>> +#define HDMI_FC_DRM_PB8                         0x1172
>> +#define HDMI_FC_DRM_PB9                         0x1173
>> +#define HDMI_FC_DRM_PB10                        0x1174
>> +#define HDMI_FC_DRM_PB11                        0x1175
>> +#define HDMI_FC_DRM_PB12                        0x1176
>> +#define HDMI_FC_DRM_PB13                        0x1177
>> +#define HDMI_FC_DRM_PB14                        0x1178
>> +#define HDMI_FC_DRM_PB15                        0x1179
>> +#define HDMI_FC_DRM_PB16                        0x117A
>> +#define HDMI_FC_DRM_PB17                        0x117B
>> +#define HDMI_FC_DRM_PB18                        0x117C
>> +#define HDMI_FC_DRM_PB19                        0x117D
>> +#define HDMI_FC_DRM_PB20                        0x117E
>> +#define HDMI_FC_DRM_PB21                        0x117F
>> +#define HDMI_FC_DRM_PB22                        0x1180
>> +#define HDMI_FC_DRM_PB23                        0x1181
>> +#define HDMI_FC_DRM_PB24                        0x1182
>> +#define HDMI_FC_DRM_PB25                        0x1183
>> +#define HDMI_FC_DRM_PB26                        0x1184
>> +
>>  #define HDMI_FC_DBGFORCE                        0x1200
>>  #define HDMI_FC_DBGAUD0CH0                      0x1201
>>  #define HDMI_FC_DBGAUD1CH0                      0x1202
>> @@ -744,6 +776,11 @@ enum {
>>  	HDMI_FC_PRCONF_OUTPUT_PR_FACTOR_MASK = 0x0F,
>>  	HDMI_FC_PRCONF_OUTPUT_PR_FACTOR_OFFSET = 0,
>>  
>> +/* FC_PACKET_TX_EN field values */
>> +	HDMI_FC_PACKET_TX_EN_DRM_MASK = 0x80,
>> +	HDMI_FC_PACKET_TX_EN_DRM_ENABLE = 0x80,
>> +	HDMI_FC_PACKET_TX_EN_DRM_DISABLE = 0x00,
>> +
>>  /* FC_AVICONF0-FC_AVICONF3 field values */
>>  	HDMI_FC_AVICONF0_PIX_FMT_MASK = 0x03,
>>  	HDMI_FC_AVICONF0_PIX_FMT_RGB = 0x00,
>> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
>> index 4b3e863c4f8a..fbf3812c4326 100644
>> --- a/include/drm/bridge/dw_hdmi.h
>> +++ b/include/drm/bridge/dw_hdmi.h
>> @@ -126,6 +126,7 @@ struct dw_hdmi_plat_data {
>>  					   const struct drm_display_mode *mode);
>>  	unsigned long input_bus_format;
>>  	unsigned long input_bus_encoding;
>> +	bool use_drm_infoframe;
>>  
>>  	/* Vendor PHY support */
>>  	const struct dw_hdmi_phy_ops *phy_ops;
> 
> 

