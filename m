Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09FEC2D0C6
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 09:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88DD8207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 09:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfL2JUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 04:20:38 -0500
Received: from mailoutvs11.siol.net ([185.57.226.202]:57465 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726366AbfL2JUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 04:20:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id AB371521DE3;
        Sun, 29 Dec 2019 10:20:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id J6noI-8jRxmO; Sun, 29 Dec 2019 10:20:34 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 32F10521DE0;
        Sun, 29 Dec 2019 10:20:34 +0100 (CET)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Zimbra) with ESMTPA id D288C521DDF;
        Sun, 29 Dec 2019 10:20:33 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     mripard@kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        roman.stratiienko@globallogic.com
Cc:     Roman Stratiienko <roman.stratiienko@globallogic.com>
Subject: Re: [RFC 2/4] drm/sun4i: Use CRTC size instead of PRIMARY plane size as mixer frame.
Date:   Sun, 29 Dec 2019 10:20:33 +0100
Message-ID: <3498751.kQq0lBPeGt@jernej-laptop>
In-Reply-To: <20191228202818.69908-3-roman.stratiienko@globallogic.com>
References: <20191228202818.69908-1-roman.stratiienko@globallogic.com> <20191228202818.69908-3-roman.stratiienko@globallogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne sobota, 28. december 2019 ob 21:28:16 CET je 
roman.stratiienko@globallogic.com napisal(a):
> From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> 
> According to DRM documentation the only difference between PRIMARY
> and OVERLAY plane is that each CRTC must have PRIMARY plane and
> OVERLAY are optional.
> 
> Allow PRIMARY plane to have dimension different from full-screen.

I noticed this issue recently and I'm glad that you posted solution. Code is 
fine, just few nitpicks and I think it would be better to split it in two 
commits, one which adds callback and another which implements that callback in 
sun8i-mixer. DE1 also needs this fix, but it can be posted later.

> 
> Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_crtc.c     |  4 +++
>  drivers/gpu/drm/sun4i/sun8i_mixer.c    | 35 ++++++++++++++++++++++++++
>  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 30 ----------------------
>  drivers/gpu/drm/sun4i/sunxi_engine.h   |  8 ++++++
>  4 files changed, 47 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c
> b/drivers/gpu/drm/sun4i/sun4i_crtc.c index 3a153648b369..156ea8f19d7d
> 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
> @@ -139,8 +139,12 @@ static void sun4i_crtc_mode_set_nofb(struct drm_crtc
> *crtc) struct drm_display_mode *mode = &crtc->state->adjusted_mode;
>  	struct drm_encoder *encoder = sun4i_crtc_get_encoder(crtc);
>  	struct sun4i_crtc *scrtc = drm_crtc_to_sun4i_crtc(crtc);
> +	struct sunxi_engine *engine = scrtc->engine;
> 
>  	sun4i_tcon_mode_set(scrtc->tcon, encoder, mode);
> +
> +	if (engine->ops->mode_set)
> +		engine->ops->mode_set(engine, mode);
>  }
> 
>  static const struct drm_crtc_helper_funcs sun4i_crtc_helper_funcs = {
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> b/drivers/gpu/drm/sun4i/sun8i_mixer.c index eea4813602b7..bb9a665fd053
> 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -257,6 +257,40 @@ const struct de2_fmt_info *sun8i_mixer_format_info(u32
> format) return NULL;
>  }
> 
> +static void sun8i_mode_set(struct sunxi_engine *engine,
> +			   struct drm_display_mode *mode)
> +{
> +	u32 dst_w = mode->crtc_hdisplay;
> +	u32 dst_h = mode->crtc_vdisplay;
> +	u32 outsize = SUN8I_MIXER_SIZE(dst_w, dst_h);
> +	bool interlaced = false;
> +	u32 val;
> +	struct sun8i_mixer *mixer = engine_to_sun8i_mixer(engine);
> +	u32 bld_base = sun8i_blender_base(mixer);
> +
> +	DRM_DEBUG_DRIVER("Mode change, updating global size W: %u H: %u\n",
> +			 dst_w, dst_h);

We should start using newly introduced helpers for DRM debug output, in this 
case drm_dbg(), which replace those in in all caps.

> +	regmap_write(mixer->engine.regs,
> +		     SUN8I_MIXER_GLOBAL_SIZE,
> +		     outsize);
> +	regmap_write(mixer->engine.regs,
> +		     SUN8I_MIXER_BLEND_OUTSIZE(bld_base), outsize);
> +
> +	interlaced = mode->flags & DRM_MODE_FLAG_INTERLACE;
> +
> +	if (interlaced)
> +		val = SUN8I_MIXER_BLEND_OUTCTL_INTERLACED;
> +	else
> +		val = 0;
> +
> +	regmap_update_bits(mixer->engine.regs,
> +			   SUN8I_MIXER_BLEND_OUTCTL(bld_base),
> +			   SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
> +			   val);
> +	DRM_DEBUG_DRIVER("Switching display mixer interlaced mode %s\n",
> +			 interlaced ? "on" : "off");

Ditto.

> +}
> +
>  static void sun8i_atomic_begin(struct sunxi_engine *engine,
>  			       struct drm_crtc_state *old_state)
>  {
> @@ -325,6 +359,7 @@ static const struct sunxi_engine_ops sun8i_engine_ops =
> { .commit		= sun8i_mixer_commit,
>  	.layers_init	= sun8i_layers_init,
>  	.atomic_begin	= sun8i_atomic_begin,
> +	.mode_set	= sun8i_mode_set,
>  };
> 
>  static struct regmap_config sun8i_mixer_regmap_config = {
> diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c index c87fd842918e..893076716070
> 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> @@ -99,36 +99,6 @@ static int sun8i_ui_layer_update_coord(struct sun8i_mixer
> *mixer, int channel, insize = SUN8I_MIXER_SIZE(src_w, src_h);
>  	outsize = SUN8I_MIXER_SIZE(dst_w, dst_h);
> 
> -	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
> -		bool interlaced = false;
> -		u32 val;
> -
> -		DRM_DEBUG_DRIVER("Primary layer, updating global size 
W: %u H: %u\n",
> -				 dst_w, dst_h);
> -		regmap_write(mixer->engine.regs,
> -			     SUN8I_MIXER_GLOBAL_SIZE,
> -			     outsize);
> -		regmap_write(mixer->engine.regs,
> -			     SUN8I_MIXER_BLEND_OUTSIZE(bld_base), 
outsize);
> -
> -		if (state->crtc)
> -			interlaced = state->crtc->state-
>adjusted_mode.flags
> -				& DRM_MODE_FLAG_INTERLACE;
> -
> -		if (interlaced)
> -			val = SUN8I_MIXER_BLEND_OUTCTL_INTERLACED;
> -		else
> -			val = 0;
> -
> -		regmap_update_bits(mixer->engine.regs,
> -				   
SUN8I_MIXER_BLEND_OUTCTL(bld_base),
> -				   
SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
> -				   val);
> -
> -		DRM_DEBUG_DRIVER("Switching display mixer interlaced 
mode %s\n",
> -				 interlaced ? "on" : "off");
> -	}
> -
>  	/* Set height and width */
>  	DRM_DEBUG_DRIVER("Layer source offset X: %d Y: %d\n",
>  			 state->src.x1 >> 16, state->src.y1 >> 16);
> diff --git a/drivers/gpu/drm/sun4i/sunxi_engine.h
> b/drivers/gpu/drm/sun4i/sunxi_engine.h index 548710a936d5..9783c112d512
> 100644
> --- a/drivers/gpu/drm/sun4i/sunxi_engine.h
> +++ b/drivers/gpu/drm/sun4i/sunxi_engine.h
> @@ -108,6 +108,14 @@ struct sunxi_engine_ops {
>  	 * This function is optional.
>  	 */
>  	void (*vblank_quirk)(struct sunxi_engine *engine);
> +
> +	/**
> +	 * @mode_set:
> +	 *

Please add description.

Best regards,
Jernej

> +	 * This function is optional.
> +	 */
> +	void (*mode_set)(struct sunxi_engine *engine,
> +			 struct drm_display_mode *mode);
>  };
> 
>  /**




