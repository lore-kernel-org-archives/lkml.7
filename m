Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F18C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4B420665
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfE0PaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 11:30:16 -0400
Received: from mailoutvs55.siol.net ([185.57.226.246]:47807 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726115AbfE0PaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 11:30:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 65F0A522B8D;
        Mon, 27 May 2019 17:30:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id AsIJkzKwdpyq; Mon, 27 May 2019 17:30:09 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id BDA28522C5D;
        Mon, 27 May 2019 17:30:09 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 32F84522B8D;
        Mon, 27 May 2019 17:30:09 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, hverkuil@xs4all.nl,
        dri-devel@lists.freedesktop.org, heiko@sntech.de,
        maxime.ripard@bootlin.com, hjc@rock-chips.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] drm/bridge: dw-hdmi: Add support for dynamic output format setup
Date:   Mon, 27 May 2019 17:30:08 +0200
Message-ID: <6496480.LkDOl06ZB3@jernej-laptop>
In-Reply-To: <20190520133753.23871-4-narmstrong@baylibre.com>
References: <20190520133753.23871-1-narmstrong@baylibre.com> <20190520133753.23871-4-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne ponedeljek, 20. maj 2019 ob 15:37:51 CEST je Neil Armstrong napisal(a):
> In order to support the HDMI2.0 YUV420, YUV422 and the 10bit, 12bit and
> 16bits outpu use cases, add support for the recently introduced bridge
> callback format_set().
> 
> This callback will setup the new input format and encoding from encoder,
> then these information will be used instead of the default ones
> in the dw_hdmi_setup() function.
> 
> To determine the output bus format, has been added :
> - support for the connector display_info bus_formats, where a fixed
>   output bus format can be enforced by the encoder
> - support for synami output bus format depending on the input format,
>   especially the YUV420 input bus format, enforcing YUV420 as output
>   with the correct bit depth
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 121 ++++++++++++++++++++--
>  1 file changed, 112 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
> b50c49caf7ae..284ce59be8f8 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -103,6 +103,8 @@ struct hdmi_vmode {
>  };
> 
>  struct hdmi_data_info {
> +	unsigned int bridge_in_bus_format;
> +	unsigned int bridge_in_encoding;
>  	unsigned int enc_in_bus_format;
>  	unsigned int enc_out_bus_format;
>  	unsigned int enc_in_encoding;
> @@ -1838,8 +1840,51 @@ static void hdmi_disable_overflow_interrupts(struct
> dw_hdmi *hdmi) HDMI_IH_MUTE_FC_STAT2);
>  }
> 
> +/*
> + * The DW-HDMI CSC can only interpolate and decimate from 4:2:2 to
> 4:4:4/RGB + * and from 4:4:4/RGB to 4:2:2.
> + * Default to RGB output except if 4:2:0 as input, which CSC cannot
> convert. + */
> +static unsigned long dw_hdmi_determine_output_bus_format(struct dw_hdmi
> *hdmi) +{
> +	unsigned int depth = hdmi_bus_fmt_color_depth(
> +					hdmi-
>hdmi_data.enc_in_bus_format);
> +	bool is_420 = hdmi_bus_fmt_is_yuv420(hdmi-
>hdmi_data.enc_in_bus_format);
> +	unsigned long fmt = MEDIA_BUS_FMT_RGB888_1X24;
> +
> +	switch (depth) {
> +	case 8:
> +		if (is_420)
> +			fmt = MEDIA_BUS_FMT_UYYVYY8_0_5X24;
> +		else
> +			fmt = MEDIA_BUS_FMT_RGB888_1X24;
> +		break;
> +	case 10:
> +		if (is_420)
> +			fmt = MEDIA_BUS_FMT_UYYVYY10_0_5X30;
> +		else
> +			fmt = MEDIA_BUS_FMT_RGB101010_1X30;
> +		break;
> +	case 12:
> +		if (is_420)
> +			fmt = MEDIA_BUS_FMT_UYYVYY12_0_5X36;
> +		else
> +			fmt = MEDIA_BUS_FMT_RGB121212_1X36;
> +		break;
> +	case 16:
> +		if (is_420)
> +			fmt = MEDIA_BUS_FMT_UYYVYY16_0_5X48;
> +		else
> +			fmt = MEDIA_BUS_FMT_RGB161616_1X48;
> +		break;
> +	}
> +
> +	return fmt;
> +}
> +
>  static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode
> *mode) {
> +	struct drm_display_info *display = &hdmi->connector.display_info;
>  	int ret;
> 
>  	hdmi_disable_overflow_interrupts(hdmi);
> @@ -1853,9 +1898,9 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct
> drm_display_mode *mode) }
> 
>  	if ((hdmi->vic == 6) || (hdmi->vic == 7) ||
> -	    (hdmi->vic == 21) || (hdmi->vic == 22) ||
> -	    (hdmi->vic == 2) || (hdmi->vic == 3) ||
> -	    (hdmi->vic == 17) || (hdmi->vic == 18))
> +		 (hdmi->vic == 21) || (hdmi->vic == 22) ||
> +		 (hdmi->vic == 2) || (hdmi->vic == 3) ||
> +		 (hdmi->vic == 17) || (hdmi->vic == 18))
>  		hdmi->hdmi_data.enc_out_encoding = V4L2_YCBCR_ENC_601;
>  	else
>  		hdmi->hdmi_data.enc_out_encoding = V4L2_YCBCR_ENC_709;
> @@ -1863,22 +1908,29 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi,
> struct drm_display_mode *mode)
> hdmi->hdmi_data.video_mode.mpixelrepetitionoutput = 0;
>  	hdmi->hdmi_data.video_mode.mpixelrepetitioninput = 0;
> 
> -	/* TOFIX: Get input format from plat data or fallback to RGB888 */
> -	if (hdmi->plat_data->input_bus_format)
> +	if (hdmi->hdmi_data.bridge_in_bus_format)
> +		hdmi->hdmi_data.enc_in_bus_format =
> +			hdmi->hdmi_data.bridge_in_bus_format;
> +	else if (hdmi->plat_data->input_bus_format)
>  		hdmi->hdmi_data.enc_in_bus_format =
>  			hdmi->plat_data->input_bus_format;
>  	else
>  		hdmi->hdmi_data.enc_in_bus_format = 
MEDIA_BUS_FMT_RGB888_1X24;
> 
> -	/* TOFIX: Get input encoding from plat data or fallback to none */
> -	if (hdmi->plat_data->input_bus_encoding)
> +	if (hdmi->hdmi_data.bridge_in_encoding)
> +		hdmi->hdmi_data.enc_in_encoding =
> +			hdmi->hdmi_data.bridge_in_encoding;
> +	else if (hdmi->plat_data->input_bus_encoding)
>  		hdmi->hdmi_data.enc_in_encoding =
>  			hdmi->plat_data->input_bus_encoding;
>  	else
>  		hdmi->hdmi_data.enc_in_encoding = 
V4L2_YCBCR_ENC_DEFAULT;
> 
> -	/* TOFIX: Default to RGB888 output format */
> -	hdmi->hdmi_data.enc_out_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
> +	if (display->num_bus_formats)
> +		hdmi->hdmi_data.enc_out_bus_format = display-
>bus_formats[0];
> +	else
> +		hdmi->hdmi_data.enc_out_bus_format =
> +				
dw_hdmi_determine_output_bus_format(hdmi);
> 
>  	hdmi->hdmi_data.pix_repet_factor = 0;
>  	hdmi->hdmi_data.hdcp_enable = 0;
> @@ -2150,6 +2202,56 @@ dw_hdmi_bridge_mode_valid(struct drm_bridge *bridge,
>  	return mode_status;
>  }
> 
> +static bool dw_hdmi_drm_bridge_format_set(struct drm_bridge *bridge,
> +					 const u32 
input_bus_format,
> +					 const u32 
input_encoding)
> +{
> +	struct dw_hdmi *hdmi = bridge->driver_private;
> +
> +	/* Filter supported input bus formats */
> +	switch (input_bus_format) {
> +	case MEDIA_BUS_FMT_RGB888_1X24:
> +	case MEDIA_BUS_FMT_RGB101010_1X30:
> +	case MEDIA_BUS_FMT_RGB121212_1X36:
> +	case MEDIA_BUS_FMT_RGB161616_1X48:
> +	case MEDIA_BUS_FMT_YUV8_1X24:
> +	case MEDIA_BUS_FMT_YUV10_1X30:
> +	case MEDIA_BUS_FMT_YUV12_1X36:
> +	case MEDIA_BUS_FMT_YUV16_1X48:
> +	case MEDIA_BUS_FMT_UYVY8_1X16:
> +	case MEDIA_BUS_FMT_UYVY10_1X20:
> +	case MEDIA_BUS_FMT_UYVY12_1X24:
> +	case MEDIA_BUS_FMT_UYYVYY8_0_5X24:
> +	case MEDIA_BUS_FMT_UYYVYY10_0_5X30:
> +	case MEDIA_BUS_FMT_UYYVYY12_0_5X36:
> +	case MEDIA_BUS_FMT_UYYVYY16_0_5X48:
> +		break;
> +	default:
> +		dev_dbg(hdmi->dev, "Unsupported Input bus format %x\n",
> +			input_bus_format);
> +		return false;
> +	}
> +
> +	/* Filter supported input bus encoding */
> +	switch (input_encoding) {
> +	case V4L2_YCBCR_ENC_DEFAULT:
> +	case V4L2_YCBCR_ENC_601:
> +	case V4L2_YCBCR_ENC_709:
> +	case V4L2_YCBCR_ENC_XV601:
> +	case V4L2_YCBCR_ENC_XV709:
> +		break;
> +	default:
> +		dev_dbg(hdmi->dev, "Unsupported Input encoding %x\n",
> +			input_bus_format);
> +		return false;
> +	}
> +
> +	hdmi->hdmi_data.bridge_in_bus_format = input_bus_format;
> +	hdmi->hdmi_data.bridge_in_encoding = input_encoding;
> +
> +	return true;
> +}
> +
>  static void dw_hdmi_bridge_mode_set(struct drm_bridge *bridge,
>  				    const struct drm_display_mode 
*orig_mode,
>  				    const struct drm_display_mode 
*mode)
> @@ -2192,6 +2294,7 @@ static const struct drm_bridge_funcs
> dw_hdmi_bridge_funcs = { .disable = dw_hdmi_bridge_disable,
>  	.mode_set = dw_hdmi_bridge_mode_set,
>  	.mode_valid = dw_hdmi_bridge_mode_valid,
> +	.format_set = dw_hdmi_drm_bridge_format_set,
>  };
> 
>  static irqreturn_t dw_hdmi_i2c_irq(struct dw_hdmi *hdmi)

Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>

Best regards,
Jernej



