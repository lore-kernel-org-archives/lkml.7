Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C2FC2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 10:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51133206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 10:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfLaKGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 05:06:50 -0500
Received: from mailoutvs52.siol.net ([185.57.226.243]:58020 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726334AbfLaKGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 05:06:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id DEE665219D1;
        Tue, 31 Dec 2019 11:06:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jzCOG0hi0pwy; Tue, 31 Dec 2019 11:06:47 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 79ADF5219D9;
        Tue, 31 Dec 2019 11:06:47 +0100 (CET)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 8A75A5219D1;
        Tue, 31 Dec 2019 11:06:43 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     mripard@kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        roman.stratiienko@globallogic.com
Cc:     Roman Stratiienko <roman.stratiienko@globallogic.com>
Subject: Re: [PATCH v2 1/2] drm/sun4i: Add alpha property for sun8i UI layer
Date:   Tue, 31 Dec 2019 11:06:43 +0100
Message-ID: <1972955.OBFZWjSADL@jernej-laptop>
In-Reply-To: <20191230180842.13393-1-roman.stratiienko@globallogic.com>
References: <20191230180842.13393-1-roman.stratiienko@globallogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne ponedeljek, 30. december 2019 ob 19:08:41 CET je 
roman.stratiienko@globallogic.com napisal(a):
> From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> 
> DE2.0 and DE3.0 UI layers supports plane-global alpha channel.
> Add alpha property to the DRM plane and connect it to the
> corresponding registers in mixer.
> 
> Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>

BTW, patch is marked as v2, but I don't see any changelog. What did you 
change?

Best regards,
Jernej

> ---
>  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 29 ++++++++++++++++++++++++++
>  drivers/gpu/drm/sun4i/sun8i_ui_layer.h |  5 +++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c index c87fd842918e..4343ea9f8cf8
> 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> @@ -72,6 +72,27 @@ static void sun8i_ui_layer_enable(struct sun8i_mixer
> *mixer, int channel, }
>  }
> 
> +static void sun8i_ui_layer_update_alpha(struct sun8i_mixer *mixer, int
> channel, +					int overlay, struct 
drm_plane *plane)
> +{
> +	u32 mask, val, ch_base;
> +
> +	ch_base = sun8i_channel_base(mixer, channel);
> +
> +	mask = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_MASK |
> +		SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MASK;
> +
> +	val = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA(plane->state->alpha >> 
8);
> +
> +	val |= (plane->state->alpha == DRM_BLEND_ALPHA_OPAQUE) ?
> +		SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_PIXEL :
> +		SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_COMBINED;
> +
> +	regmap_update_bits(mixer->engine.regs,
> +			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base, 
overlay),
> +			   mask, val);
> +}
> +
>  static int sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int
> channel, int overlay, struct drm_plane *plane,
>  				       unsigned int zpos)
> @@ -288,6 +309,8 @@ static void sun8i_ui_layer_atomic_update(struct
> drm_plane *plane,
> 
>  	sun8i_ui_layer_update_coord(mixer, layer->channel,
>  				    layer->overlay, plane, zpos);
> +	sun8i_ui_layer_update_alpha(mixer, layer->channel,
> +				    layer->overlay, plane);
>  	sun8i_ui_layer_update_formats(mixer, layer->channel,
>  				      layer->overlay, plane);
>  	sun8i_ui_layer_update_buffer(mixer, layer->channel,
> @@ -365,6 +388,12 @@ struct sun8i_ui_layer *sun8i_ui_layer_init_one(struct
> drm_device *drm,
> 
>  	plane_cnt = mixer->cfg->ui_num + mixer->cfg->vi_num;
> 
> +	ret = drm_plane_create_alpha_property(&layer->plane);
> +	if (ret) {
> +		dev_err(drm->dev, "Couldn't add alpha property\n");
> +		return ERR_PTR(ret);
> +	}
> +
>  	ret = drm_plane_create_zpos_property(&layer->plane, channel,
>  					     0, plane_cnt - 
1);
>  	if (ret) {
> diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.h
> b/drivers/gpu/drm/sun4i/sun8i_ui_layer.h index f4ab1cf6cded..e3e32ee1178d
> 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.h
> +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.h
> @@ -40,6 +40,11 @@
>  #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK	GENMASK(12, 8)
>  #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_OFFSET	8
>  #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MASK	GENMASK(31, 24)
> +#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA(x)		((x) << 24)
> +
> +#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_PIXEL		
((0) << 1)
> +#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_LAYER		
((1) << 1)
> +#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_COMBINED	((2) << 1)
> 
>  struct sun8i_mixer;




