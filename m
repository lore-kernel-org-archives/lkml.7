Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F712C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4843206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pjYiOtQN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbfFEM5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 08:57:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53802 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfFEM5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 08:57:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id d17so2155678wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 05:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tIe+egeGortghc25tNFk6UneW2Q78rPHSZI5D3cJ3XE=;
        b=pjYiOtQN5ueyJMBoj0hawB6qg4W5CcAHIKdcZp0fW6sJMI0iXqzWbgEBh3lg53eC6j
         uu0m0Gn5FplRzRibgwdpIY3Ora+c5SblkCASyTG9GxTFjlmJ5XIl3cWPMe5sAKsX+ESx
         WJGXOHPzUu06wcs3+7V+kw40oJThR0EN5vtKgVUpRS6z4ofcX9BWBMKfN+YG2k83MxoH
         56tjAQJ9Em2IzrWFBaUR8H77LFLYeNpnFu1Taa7Y75D2a5KxNEJEJYq99xV9KMC7vHyG
         7eifa5iGpw/PU/fE+7ys1pCrysMdXVHdqg7x4fQEXe2eD3nUDj4G989G1+7jXdaBZEic
         Bzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tIe+egeGortghc25tNFk6UneW2Q78rPHSZI5D3cJ3XE=;
        b=kOi0ESn/08rv+rQYZb0NWPC4pwUmBH+u6zx09kVedX5XoHYvaZQ+rNy1Z1tnDgYJlp
         fO7jW/EQ05FscIMNZFP2B5c7P3ziw0vzWK3ioDixHpoMsnAlPd7TJ0uf4hSEhqwGnZvQ
         zC1qIypighXcz6iGNB43cVg1O2zQtiojx5yj36nbmJFw+Gedg2KSRIoDxe3aggO5+2jr
         f+2dWp24EaOazZqdZwrKD004lujqPoqy2qvhNURCWm2rqmXLmFcLoLEh78+sSveme7W0
         ZYFlMTQKO0NGnEFlVk70SA1xz/+C8VhSEexC3oNZRpEAI6rzqRzb72UIA5P1c/AiLjle
         zGaw==
X-Gm-Message-State: APjAAAUgzuAbTNdwxHIk4RBZDJIfUntyb0laqmS+UtLnCJb8oSqDaRsW
        RneYvGPaFlpMvzzOA+HfuwIrFg2/l0t0Kw==
X-Google-Smtp-Source: APXvYqxEENBODsYV234l0NgAMAPtPoYMA60txpDlP/tsrXCfdCrpIO9vbxoSsT35vkmx9NOGjnU4mA==
X-Received: by 2002:a1c:b4d4:: with SMTP id d203mr23388766wmf.34.1559739435002;
        Wed, 05 Jun 2019 05:57:15 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e13sm25413497wra.16.2019.06.05.05.57.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 05:57:14 -0700 (PDT)
Subject: Re: [PATCH 1/4] drm/bridge: dw-hdmi: Add Dynamic Range and Mastering
 InfoFrame support
To:     Jonas Karlman <jonas@kwiboo.se>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>
Cc:     "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "zhengyang@rock-chips.com" <zhengyang@rock-chips.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "wens@csie.org" <wens@csie.org>,
        "hjc@rock-chips.com" <hjc@rock-chips.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <VI1PR03MB420621617DDEAB3596700DE0AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
 <VI1PR03MB4206B9AF66443E35946BD000AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <1b974919-e7bd-9a7d-1a10-b966bc42e082@baylibre.com>
Date:   Wed, 5 Jun 2019 14:57:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <VI1PR03MB4206B9AF66443E35946BD000AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2019 23:19, Jonas Karlman wrote:
> Add support for configuring Dynamic Range and Mastering InfoFrame from
> the hdr_output_metadata connector property.
> 
> This patch adds a drm_infoframe flag to dw_hdmi_plat_data that platform drivers
> use to signal when Dynamic Range and Mastering infoframes is supported.
> This flag is needed because Amlogic GXBB and GXL report same DW-HDMI version,
> and only GXL support DRM InfoFrame.
> 
> These changes were based on work done by Zheng Yang <zhengyang@rock-chips.com>
> to support DRM InfoFrame on the Rockchip 4.4 BSP kernel at [1] and [2]
> 
> [1] https://github.com/rockchip-linux/kernel/tree/develop-4.4
> [2] https://github.com/rockchip-linux/kernel/commit/d1943fde81ff41d7cca87f4a42f03992e90bddd5
> 
> Cc: Zheng Yang <zhengyang@rock-chips.com>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 109 ++++++++++++++++++++++
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h |  37 ++++++++
>  include/drm/bridge/dw_hdmi.h              |   1 +
>  3 files changed, 147 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 284ce59be8f8..801bbbd732fd 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -24,6 +24,7 @@
>  
>  #include <drm/drm_of.h>
>  #include <drm/drmP.h>
> +#include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_encoder_slave.h>
> @@ -1592,6 +1593,78 @@ static void hdmi_config_vendor_specific_infoframe(struct dw_hdmi *hdmi,
>  			HDMI_FC_DATAUTO0_VSD_MASK);
>  }
>  
> +#define HDR_LSB(n) ((n) & 0xff)
> +#define HDR_MSB(n) (((n) & 0xff00) >> 8)
> +
> +static void hdmi_config_drm_infoframe(struct dw_hdmi *hdmi)
> +{
> +	const struct drm_connector_state *conn_state = hdmi->connector.state;
> +	struct hdmi_drm_infoframe frame;
> +	int ret;
> +
> +	if (hdmi->version < 0x200a || !hdmi->plat_data->drm_infoframe)
> +		return;
> +
> +	hdmi_modb(hdmi, HDMI_FC_PACKET_TX_EN_DRM_DISABLE,
> +		  HDMI_FC_PACKET_TX_EN_DRM_MASK, HDMI_FC_PACKET_TX_EN);
> +
> +	ret = drm_hdmi_infoframe_set_hdr_metadata(&frame, conn_state);
> +	if (ret < 0)
> +		return;
> +
> +	ret = hdmi_drm_infoframe_check(&frame);
> +	if (WARN_ON(ret))
> +		return;
> +
> +	hdmi_writeb(hdmi, frame.version, HDMI_FC_DRM_HB0);
> +	hdmi_writeb(hdmi, frame.length, HDMI_FC_DRM_HB1);
> +	hdmi_writeb(hdmi, frame.eotf, HDMI_FC_DRM_PB0);
> +	hdmi_writeb(hdmi, frame.metadata_type, HDMI_FC_DRM_PB1);
> +	hdmi_writeb(hdmi, HDR_LSB(frame.display_primaries[0].x),
> +		    HDMI_FC_DRM_PB2);
> +	hdmi_writeb(hdmi, HDR_MSB(frame.display_primaries[0].x),
> +		    HDMI_FC_DRM_PB3);
> +	hdmi_writeb(hdmi, HDR_LSB(frame.display_primaries[0].y),
> +		    HDMI_FC_DRM_PB4);
> +	hdmi_writeb(hdmi, HDR_MSB(frame.display_primaries[0].y),
> +		    HDMI_FC_DRM_PB5);
> +	hdmi_writeb(hdmi, HDR_LSB(frame.display_primaries[1].x),
> +		    HDMI_FC_DRM_PB6);
> +	hdmi_writeb(hdmi, HDR_MSB(frame.display_primaries[1].x),
> +		    HDMI_FC_DRM_PB7);
> +	hdmi_writeb(hdmi, HDR_LSB(frame.display_primaries[1].y),
> +		    HDMI_FC_DRM_PB8);
> +	hdmi_writeb(hdmi, HDR_MSB(frame.display_primaries[1].y),
> +		    HDMI_FC_DRM_PB9);
> +	hdmi_writeb(hdmi, HDR_LSB(frame.display_primaries[2].x),
> +		    HDMI_FC_DRM_PB10);
> +	hdmi_writeb(hdmi, HDR_MSB(frame.display_primaries[2].x),
> +		    HDMI_FC_DRM_PB11);
> +	hdmi_writeb(hdmi, HDR_LSB(frame.display_primaries[2].y),
> +		    HDMI_FC_DRM_PB12);
> +	hdmi_writeb(hdmi, HDR_MSB(frame.display_primaries[2].y),
> +		    HDMI_FC_DRM_PB13);
> +	hdmi_writeb(hdmi, HDR_LSB(frame.white_point.x), HDMI_FC_DRM_PB14);
> +	hdmi_writeb(hdmi, HDR_MSB(frame.white_point.x), HDMI_FC_DRM_PB15);
> +	hdmi_writeb(hdmi, HDR_LSB(frame.white_point.y), HDMI_FC_DRM_PB16);
> +	hdmi_writeb(hdmi, HDR_MSB(frame.white_point.y), HDMI_FC_DRM_PB17);
> +	hdmi_writeb(hdmi, HDR_LSB(frame.max_display_mastering_luminance),
> +		    HDMI_FC_DRM_PB18);
> +	hdmi_writeb(hdmi, HDR_MSB(frame.max_display_mastering_luminance),
> +		    HDMI_FC_DRM_PB19);
> +	hdmi_writeb(hdmi, HDR_LSB(frame.min_display_mastering_luminance),
> +		    HDMI_FC_DRM_PB20);
> +	hdmi_writeb(hdmi, HDR_MSB(frame.min_display_mastering_luminance),
> +		    HDMI_FC_DRM_PB21);
> +	hdmi_writeb(hdmi, HDR_LSB(frame.max_cll), HDMI_FC_DRM_PB22);
> +	hdmi_writeb(hdmi, HDR_MSB(frame.max_cll), HDMI_FC_DRM_PB23);
> +	hdmi_writeb(hdmi, HDR_LSB(frame.max_fall), HDMI_FC_DRM_PB24);
> +	hdmi_writeb(hdmi, HDR_MSB(frame.max_fall), HDMI_FC_DRM_PB25);
> +	hdmi_writeb(hdmi, 1, HDMI_FC_DRM_UP);
> +	hdmi_modb(hdmi, HDMI_FC_PACKET_TX_EN_DRM_ENABLE,
> +		  HDMI_FC_PACKET_TX_EN_DRM_MASK, HDMI_FC_PACKET_TX_EN);
> +}
> +
>  static void hdmi_av_composer(struct dw_hdmi *hdmi,
>  			     const struct drm_display_mode *mode)
>  {
> @@ -1963,6 +2036,7 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
>  		/* HDMI Initialization Step F - Configure AVI InfoFrame */
>  		hdmi_config_AVI(hdmi, mode);
>  		hdmi_config_vendor_specific_infoframe(hdmi, mode);
> +		hdmi_config_drm_infoframe(hdmi);
>  	} else {
>  		dev_dbg(hdmi->dev, "%s DVI mode\n", __func__);
>  	}
> @@ -2139,6 +2213,36 @@ static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
>  	return ret;
>  }
>  
> +static bool blob_equal(const struct drm_property_blob *a,
> +		       const struct drm_property_blob *b)
> +{
> +	if (a && b)
> +		return a->length == b->length &&
> +			!memcmp(a->data, b->data, a->length);
> +
> +	return !a == !b;
> +}
> +
> +static int dw_hdmi_connector_atomic_check(struct drm_connector *conn,
> +	struct drm_connector_state *new_state)
> +{
> +	struct drm_connector_state *old_state =
> +		drm_atomic_get_old_connector_state(new_state->state, conn);
> +	struct drm_crtc_state *crtc_state;
> +
> +	if (!new_state->crtc)
> +		return 0;
> +
> +	crtc_state = drm_atomic_get_new_crtc_state(new_state->state,
> +						   new_state->crtc);
> +
> +	if (!blob_equal(new_state->hdr_output_metadata,
> +			old_state->hdr_output_metadata))
> +		crtc_state->mode_changed = true;
> +
> +	return 0;
> +}
> +
>  static void dw_hdmi_connector_force(struct drm_connector *connector)
>  {
>  	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
> @@ -2163,6 +2267,7 @@ static const struct drm_connector_funcs dw_hdmi_connector_funcs = {
>  
>  static const struct drm_connector_helper_funcs dw_hdmi_connector_helper_funcs = {
>  	.get_modes = dw_hdmi_connector_get_modes,
> +	.atomic_check = dw_hdmi_connector_atomic_check,
>  };
>  
>  static int dw_hdmi_bridge_attach(struct drm_bridge *bridge)
> @@ -2179,6 +2284,10 @@ static int dw_hdmi_bridge_attach(struct drm_bridge *bridge)
>  	drm_connector_init(bridge->dev, connector, &dw_hdmi_connector_funcs,
>  			   DRM_MODE_CONNECTOR_HDMIA);
>  
> +	if (hdmi->version >= 0x200a && hdmi->plat_data->drm_infoframe)
> +		drm_object_attach_property(&connector->base,
> +			connector->dev->mode_config.hdr_output_metadata_property, 0);
> +
>  	drm_connector_attach_encoder(connector, encoder);
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> index 3f3c616eba97..d4efbec14f68 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> @@ -256,6 +256,7 @@
>  #define HDMI_FC_POL2                            0x10DB
>  #define HDMI_FC_PRCONF                          0x10E0
>  #define HDMI_FC_SCRAMBLER_CTRL                  0x10E1
> +#define HDMI_FC_PACKET_TX_EN                    0x10E3
>  
>  #define HDMI_FC_GMD_STAT                        0x1100
>  #define HDMI_FC_GMD_EN                          0x1101
> @@ -291,6 +292,37 @@
>  #define HDMI_FC_GMD_PB26                        0x111F
>  #define HDMI_FC_GMD_PB27                        0x1120
>  
> +#define HDMI_FC_DRM_UP                          0x1167
> +#define HDMI_FC_DRM_HB0                         0x1168
> +#define HDMI_FC_DRM_HB1                         0x1169
> +#define HDMI_FC_DRM_PB0                         0x116A
> +#define HDMI_FC_DRM_PB1                         0x116B
> +#define HDMI_FC_DRM_PB2                         0x116C
> +#define HDMI_FC_DRM_PB3                         0x116D
> +#define HDMI_FC_DRM_PB4                         0x116E
> +#define HDMI_FC_DRM_PB5                         0x116F
> +#define HDMI_FC_DRM_PB6                         0x1170
> +#define HDMI_FC_DRM_PB7                         0x1171
> +#define HDMI_FC_DRM_PB8                         0x1172
> +#define HDMI_FC_DRM_PB9                         0x1173
> +#define HDMI_FC_DRM_PB10                        0x1174
> +#define HDMI_FC_DRM_PB11                        0x1175
> +#define HDMI_FC_DRM_PB12                        0x1176
> +#define HDMI_FC_DRM_PB13                        0x1177
> +#define HDMI_FC_DRM_PB14                        0x1178
> +#define HDMI_FC_DRM_PB15                        0x1179
> +#define HDMI_FC_DRM_PB16                        0x117A
> +#define HDMI_FC_DRM_PB17                        0x117B
> +#define HDMI_FC_DRM_PB18                        0x117C
> +#define HDMI_FC_DRM_PB19                        0x117D
> +#define HDMI_FC_DRM_PB20                        0x117E
> +#define HDMI_FC_DRM_PB21                        0x117F
> +#define HDMI_FC_DRM_PB22                        0x1180
> +#define HDMI_FC_DRM_PB23                        0x1181
> +#define HDMI_FC_DRM_PB24                        0x1182
> +#define HDMI_FC_DRM_PB25                        0x1183
> +#define HDMI_FC_DRM_PB26                        0x1184
> +
>  #define HDMI_FC_DBGFORCE                        0x1200
>  #define HDMI_FC_DBGAUD0CH0                      0x1201
>  #define HDMI_FC_DBGAUD1CH0                      0x1202
> @@ -746,6 +778,11 @@ enum {
>  	HDMI_FC_PRCONF_OUTPUT_PR_FACTOR_MASK = 0x0F,
>  	HDMI_FC_PRCONF_OUTPUT_PR_FACTOR_OFFSET = 0,
>  
> +/* FC_PACKET_TX_EN field values */
> +	HDMI_FC_PACKET_TX_EN_DRM_MASK = 0x80,
> +	HDMI_FC_PACKET_TX_EN_DRM_ENABLE = 0x80,
> +	HDMI_FC_PACKET_TX_EN_DRM_DISABLE = 0x00,
> +
>  /* FC_AVICONF0-FC_AVICONF3 field values */
>  	HDMI_FC_AVICONF0_PIX_FMT_MASK = 0x03,
>  	HDMI_FC_AVICONF0_PIX_FMT_RGB = 0x00,
> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
> index 0f0e82638fbe..04d1ec60f218 100644
> --- a/include/drm/bridge/dw_hdmi.h
> +++ b/include/drm/bridge/dw_hdmi.h
> @@ -131,6 +131,7 @@ struct dw_hdmi_plat_data {
>  	unsigned long input_bus_format;
>  	unsigned long input_bus_encoding;
>  	bool ycbcr_420_allowed;
> +	bool drm_infoframe;
>  
>  	/* Vendor PHY support */
>  	const struct dw_hdmi_phy_ops *phy_ops;
> 

Thanks for this work !

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
