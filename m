Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61C6C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB20621928
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568913481;
	bh=yFCy4+MpB1fuov38bUgmcauo0/reXN7yqVfN2hTHm3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JzM7fy5EbqrCwa/D/yFrs0YlXMuGZ2yVY66IkR9qkac+kpACU+49LWqwVMjddDEaf
	 yuStISTm3uQOcA/lefeXxSaU7oRgG0JeYKwVXrQN986TIJl6HOeAPvoEfYyzCa9M87
	 eJjRzKQnnfHIHnGeG2V12X8t2CVSQXg9i9nzk/oM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391960AbfISRSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 13:18:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390073AbfISRR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 13:17:58 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B41C021928;
        Thu, 19 Sep 2019 17:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568913477;
        bh=yFCy4+MpB1fuov38bUgmcauo0/reXN7yqVfN2hTHm3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1BHIg98sQU3RSKO5g6gKuadHx+gZTwc4PvbsYJlU5PDLAsU+nnEkskfkxWwJSEIl4
         3QsZ4iQa7QmLNILjU1Cn3HaCTFre3NJhVL2wkSK7uKGnbw4YnqXhtTath1ebCQgKyY
         DT5WC5o4gYOsrt/++Dq71vwkm+ofxCbsCdnOEeg4=
Date:   Thu, 19 Sep 2019 19:17:54 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     roman.stratiienko@globallogic.com,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/sun4i: Use vi plane as primary
Message-ID: <20190919171754.x6lq73cctnqsjr4v@gilmour>
References: <20190919123703.8545-1-roman.stratiienko@globallogic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2rnnscmg2kp6rchv"
Content-Disposition: inline
In-Reply-To: <20190919123703.8545-1-roman.stratiienko@globallogic.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2rnnscmg2kp6rchv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Sep 19, 2019 at 03:37:03PM +0300, roman.stratiienko@globallogic.com wrote:
> From: Roman Stratiienko <roman.stratiienko@globallogic.com>
>
> DE2.0 blender does not take into the account alpha channel of vi layer.
> Thus makes overlaying of this layer totally opaque.
> Using vi layer as bottom solves this issue.
>
> Tested on Android.
>
> Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>

It sounds like a workaround more than an actual fix.

If the VI planes can't use the alpha, then we should just stop
reporting that format.

Jernej, what do you think?

Maxime

> ---
>  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 33 -----------------------
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 36 +++++++++++++++++++++++++-
>  2 files changed, 35 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> index dd2a1c851939..25183badc85f 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> @@ -99,36 +99,6 @@ static int sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int channel,
>  	insize = SUN8I_MIXER_SIZE(src_w, src_h);
>  	outsize = SUN8I_MIXER_SIZE(dst_w, dst_h);
>
> -	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
> -		bool interlaced = false;
> -		u32 val;
> -
> -		DRM_DEBUG_DRIVER("Primary layer, updating global size W: %u H: %u\n",
> -				 dst_w, dst_h);
> -		regmap_write(mixer->engine.regs,
> -			     SUN8I_MIXER_GLOBAL_SIZE,
> -			     outsize);
> -		regmap_write(mixer->engine.regs,
> -			     SUN8I_MIXER_BLEND_OUTSIZE(bld_base), outsize);
> -
> -		if (state->crtc)
> -			interlaced = state->crtc->state->adjusted_mode.flags
> -				& DRM_MODE_FLAG_INTERLACE;
> -
> -		if (interlaced)
> -			val = SUN8I_MIXER_BLEND_OUTCTL_INTERLACED;
> -		else
> -			val = 0;
> -
> -		regmap_update_bits(mixer->engine.regs,
> -				   SUN8I_MIXER_BLEND_OUTCTL(bld_base),
> -				   SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
> -				   val);
> -
> -		DRM_DEBUG_DRIVER("Switching display mixer interlaced mode %s\n",
> -				 interlaced ? "on" : "off");
> -	}
> -
>  	/* Set height and width */
>  	DRM_DEBUG_DRIVER("Layer source offset X: %d Y: %d\n",
>  			 state->src.x1 >> 16, state->src.y1 >> 16);
> @@ -349,9 +319,6 @@ struct sun8i_ui_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
>  	if (!layer)
>  		return ERR_PTR(-ENOMEM);
>
> -	if (index == 0)
> -		type = DRM_PLANE_TYPE_PRIMARY;
> -
>  	/* possible crtcs are set later */
>  	ret = drm_universal_plane_init(drm, &layer->plane, 0,
>  				       &sun8i_ui_layer_funcs,
> diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> index 07c27e6a4b77..49c4074e164f 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> @@ -116,6 +116,36 @@ static int sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
>  	insize = SUN8I_MIXER_SIZE(src_w, src_h);
>  	outsize = SUN8I_MIXER_SIZE(dst_w, dst_h);
>
> +	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
> +		bool interlaced = false;
> +		u32 val;
> +
> +		DRM_DEBUG_DRIVER("Primary layer, updating global size W: %u H: %u\n",
> +				 dst_w, dst_h);
> +		regmap_write(mixer->engine.regs,
> +			     SUN8I_MIXER_GLOBAL_SIZE,
> +			     outsize);
> +		regmap_write(mixer->engine.regs,
> +			     SUN8I_MIXER_BLEND_OUTSIZE(bld_base), outsize);
> +
> +		if (state->crtc)
> +			interlaced = state->crtc->state->adjusted_mode.flags
> +				& DRM_MODE_FLAG_INTERLACE;
> +
> +		if (interlaced)
> +			val = SUN8I_MIXER_BLEND_OUTCTL_INTERLACED;
> +		else
> +			val = 0;
> +
> +		regmap_update_bits(mixer->engine.regs,
> +				   SUN8I_MIXER_BLEND_OUTCTL(bld_base),
> +				   SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
> +				   val);
> +
> +		DRM_DEBUG_DRIVER("Switching display mixer interlaced mode %s\n",
> +				 interlaced ? "on" : "off");
> +	}
> +
>  	/* Set height and width */
>  	DRM_DEBUG_DRIVER("Layer source offset X: %d Y: %d\n",
>  			 (state->src.x1 >> 16) & ~(format->hsub - 1),
> @@ -445,6 +475,7 @@ struct sun8i_vi_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
>  					       struct sun8i_mixer *mixer,
>  					       int index)
>  {
> +	enum drm_plane_type type = DRM_PLANE_TYPE_OVERLAY;
>  	struct sun8i_vi_layer *layer;
>  	unsigned int plane_cnt;
>  	int ret;
> @@ -453,12 +484,15 @@ struct sun8i_vi_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
>  	if (!layer)
>  		return ERR_PTR(-ENOMEM);
>
> +	if (index == 0)
> +		type = DRM_PLANE_TYPE_PRIMARY;
> +
>  	/* possible crtcs are set later */
>  	ret = drm_universal_plane_init(drm, &layer->plane, 0,
>  				       &sun8i_vi_layer_funcs,
>  				       sun8i_vi_layer_formats,
>  				       ARRAY_SIZE(sun8i_vi_layer_formats),
> -				       NULL, DRM_PLANE_TYPE_OVERLAY, NULL);
> +				       NULL, type, NULL);
>  	if (ret) {
>  		dev_err(drm->dev, "Couldn't initialize layer\n");
>  		return ERR_PTR(ret);
> --
> 2.17.1
>

--2rnnscmg2kp6rchv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXYO4QgAKCRDj7w1vZxhR
xTy3AQCFKpFFunsqQpH5S3NlmWIGIAVm1V7QMGnmSYwKpmq2AAD9HuR+fErdd4gi
hWcnK9n6BG95SzVHYdPnJwAevIKEQgQ=
=2o4M
-----END PGP SIGNATURE-----

--2rnnscmg2kp6rchv--
