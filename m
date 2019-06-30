Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1CDC5B57E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 08:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B1B2086D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 08:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfF3IUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 04:20:52 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:38729 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfF3IUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 04:20:52 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 28FEB20067;
        Sun, 30 Jun 2019 10:20:49 +0200 (CEST)
Date:   Sun, 30 Jun 2019 10:20:47 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        od@zcrc.me, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/3] DRM: ingenic: Add support for Sharp panels
Message-ID: <20190630082047.GD5081@ravnborg.org>
References: <20190627182114.27299-1-paul@crapouillou.net>
 <20190627182114.27299-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627182114.27299-2-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8
        a=7gkXJVJtAAAA:8 a=e5mUnYsNAAAA:8 a=dZ1WxxcaQ2ST3bnaBBcA:9
        a=CjuIK1q_8ugA:10 a=9LHmKk7ezEChjTCyhBa9:22 a=E9Po1WZjFZOl8hwRPBS3:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 08:21:13PM +0200, Paul Cercueil wrote:
> Add support for the LCD panels that must be driven with the
> Sharp-specific signals SPL, CLS, REV, PS.
> 
> An example of such panel is the LS020B1DD01D supported by the
> panel-simple DRM panel driver.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

> ---
>  drivers/gpu/drm/ingenic/ingenic-drm.c | 64 +++++++++++++++++----------
>  1 file changed, 41 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
> index 02c4788ef1c7..da966f3dc1f7 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
> @@ -166,6 +166,8 @@ struct ingenic_drm {
>  
>  	struct ingenic_dma_hwdesc *dma_hwdesc;
>  	dma_addr_t dma_hwdesc_phys;
> +
> +	bool panel_is_sharp;
>  };
>  
>  static const u32 ingenic_drm_primary_formats[] = {
> @@ -283,6 +285,13 @@ static void ingenic_drm_crtc_update_timings(struct ingenic_drm *priv,
>  	regmap_write(priv->map, JZ_REG_LCD_DAV,
>  		     vds << JZ_LCD_DAV_VDS_OFFSET |
>  		     vde << JZ_LCD_DAV_VDE_OFFSET);
> +
> +	if (priv->panel_is_sharp) {
> +		regmap_write(priv->map, JZ_REG_LCD_PS, hde << 16 | (hde + 1));
> +		regmap_write(priv->map, JZ_REG_LCD_CLS, hde << 16 | (hde + 1));
> +		regmap_write(priv->map, JZ_REG_LCD_SPL, hpe << 16 | (hpe + 1));
> +		regmap_write(priv->map, JZ_REG_LCD_REV, mode->htotal << 16);
> +	}
>  }
>  
>  static void ingenic_drm_crtc_update_ctrl(struct ingenic_drm *priv,
> @@ -378,11 +387,18 @@ static void ingenic_drm_encoder_atomic_mode_set(struct drm_encoder *encoder,
>  {
>  	struct ingenic_drm *priv = drm_encoder_get_priv(encoder);
>  	struct drm_display_mode *mode = &crtc_state->adjusted_mode;
> -	struct drm_display_info *info = &conn_state->connector->display_info;
> -	unsigned int cfg = JZ_LCD_CFG_PS_DISABLE
> -			 | JZ_LCD_CFG_CLS_DISABLE
> -			 | JZ_LCD_CFG_SPL_DISABLE
> -			 | JZ_LCD_CFG_REV_DISABLE;
> +	struct drm_connector *conn = conn_state->connector;
> +	struct drm_display_info *info = &conn->display_info;
> +	unsigned int cfg;
> +
> +	priv->panel_is_sharp = info->bus_flags & DRM_BUS_FLAG_SHARP_SIGNALS;
> +
> +	if (priv->panel_is_sharp) {
> +		cfg = JZ_LCD_CFG_MODE_SPECIAL_TFT_1 | JZ_LCD_CFG_REV_POLARITY;
> +	} else {
> +		cfg = JZ_LCD_CFG_PS_DISABLE | JZ_LCD_CFG_CLS_DISABLE
> +		    | JZ_LCD_CFG_SPL_DISABLE | JZ_LCD_CFG_REV_DISABLE;
> +	}
>  
>  	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
>  		cfg |= JZ_LCD_CFG_HSYNC_ACTIVE_LOW;
> @@ -393,24 +409,26 @@ static void ingenic_drm_encoder_atomic_mode_set(struct drm_encoder *encoder,
>  	if (info->bus_flags & DRM_BUS_FLAG_PIXDATA_NEGEDGE)
>  		cfg |= JZ_LCD_CFG_PCLK_FALLING_EDGE;
>  
> -	if (conn_state->connector->connector_type == DRM_MODE_CONNECTOR_TV) {
> -		if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> -			cfg |= JZ_LCD_CFG_MODE_TV_OUT_I;
> -		else
> -			cfg |= JZ_LCD_CFG_MODE_TV_OUT_P;
> -	} else {
> -		switch (*info->bus_formats) {
> -		case MEDIA_BUS_FMT_RGB565_1X16:
> -			cfg |= JZ_LCD_CFG_MODE_GENERIC_16BIT;
> -			break;
> -		case MEDIA_BUS_FMT_RGB666_1X18:
> -			cfg |= JZ_LCD_CFG_MODE_GENERIC_18BIT;
> -			break;
> -		case MEDIA_BUS_FMT_RGB888_1X24:
> -			cfg |= JZ_LCD_CFG_MODE_GENERIC_24BIT;
> -			break;
> -		default:
> -			break;
> +	if (!priv->panel_is_sharp) {
> +		if (conn->connector_type == DRM_MODE_CONNECTOR_TV) {
> +			if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> +				cfg |= JZ_LCD_CFG_MODE_TV_OUT_I;
> +			else
> +				cfg |= JZ_LCD_CFG_MODE_TV_OUT_P;
> +		} else {
> +			switch (*info->bus_formats) {
> +			case MEDIA_BUS_FMT_RGB565_1X16:
> +				cfg |= JZ_LCD_CFG_MODE_GENERIC_16BIT;
> +				break;
> +			case MEDIA_BUS_FMT_RGB666_1X18:
> +				cfg |= JZ_LCD_CFG_MODE_GENERIC_18BIT;
> +				break;
> +			case MEDIA_BUS_FMT_RGB888_1X24:
> +				cfg |= JZ_LCD_CFG_MODE_GENERIC_24BIT;
> +				break;
> +			default:
> +				break;
> +			}
>  		}
>  	}
>  
> -- 
> 2.21.0.593.g511ec345e18
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
