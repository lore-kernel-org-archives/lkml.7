Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDD4C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 18:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D3F21928
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 18:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391352AbfISSPz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 14:15:55 -0400
Received: from mailoutvs41.siol.net ([185.57.226.232]:51786 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389923AbfISSPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 14:15:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 0A6CF522ADB;
        Thu, 19 Sep 2019 20:15:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id aN1n3KoJdUQs; Thu, 19 Sep 2019 20:15:50 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 80AE052376F;
        Thu, 19 Sep 2019 20:15:50 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe-86-58-59-25.static.triera.net [86.58.59.25])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 392C7522ADB;
        Thu, 19 Sep 2019 20:15:50 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     roman.stratiienko@globallogic.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/sun4i: Use vi plane as primary
Date:   Thu, 19 Sep 2019 20:15:49 +0200
Message-ID: <104595190.vWb6g8xIPX@jernej-laptop>
In-Reply-To: <20190919171754.x6lq73cctnqsjr4v@gilmour>
References: <20190919123703.8545-1-roman.stratiienko@globallogic.com> <20190919171754.x6lq73cctnqsjr4v@gilmour>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne četrtek, 19. september 2019 ob 19:17:54 CEST je Maxime Ripard napisal(a):
> Hi,
> 
> On Thu, Sep 19, 2019 at 03:37:03PM +0300, roman.stratiienko@globallogic.com 
wrote:
> > From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> > 
> > DE2.0 blender does not take into the account alpha channel of vi layer.
> > Thus makes overlaying of this layer totally opaque.
> > Using vi layer as bottom solves this issue.

What issue? Overlays don't have to be "full screen", thus missing support for 
alpha blending doesn't make it less valuable. And VI planes are already placed 
at the bottom (zpos = 0).

> > 
> > Tested on Android.
> > 
> > Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
> 
> It sounds like a workaround more than an actual fix.
> 
> If the VI planes can't use the alpha, then we should just stop
> reporting that format.
> 
> Jernej, what do you think?

Commit message is misleading. What this commit actually does is moving primary 
plane from first UI plane to bottom most plane, i.e. first VI plane. However, VI 
planes are scarce resource, almost all mixers have only one. I wouldn't set it 
as primary, because it's the only one which provide support for YUV formats. 
That could be used for example by video player for zero-copy rendering. 
Probably most apps wouldn't touch it if it was primary (that's usually 
reserved for window manager, if used).

I left few formats with alpha channel exposed by VI planes, just because they 
don't have equivalent format without alpha. But I'm fine with removing them if 
you all agree on that.

Best regards,
Jernej

> 
> Maxime
> 
> > ---
> > 
> >  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 33 -----------------------
> >  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 36 +++++++++++++++++++++++++-
> >  2 files changed, 35 insertions(+), 34 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> > b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c index dd2a1c851939..25183badc85f
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> > @@ -99,36 +99,6 @@ static int sun8i_ui_layer_update_coord(struct
> > sun8i_mixer *mixer, int channel,> 
> >  	insize = SUN8I_MIXER_SIZE(src_w, src_h);
> >  	outsize = SUN8I_MIXER_SIZE(dst_w, dst_h);
> > 
> > -	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
> > -		bool interlaced = false;
> > -		u32 val;
> > -
> > -		DRM_DEBUG_DRIVER("Primary layer, updating global size 
W: %u H: %u\n",
> > -				 dst_w, dst_h);
> > -		regmap_write(mixer->engine.regs,
> > -			     SUN8I_MIXER_GLOBAL_SIZE,
> > -			     outsize);
> > -		regmap_write(mixer->engine.regs,
> > -			     SUN8I_MIXER_BLEND_OUTSIZE(bld_base), 
outsize);
> > -
> > -		if (state->crtc)
> > -			interlaced = state->crtc->state-
>adjusted_mode.flags
> > -				& DRM_MODE_FLAG_INTERLACE;
> > -
> > -		if (interlaced)
> > -			val = SUN8I_MIXER_BLEND_OUTCTL_INTERLACED;
> > -		else
> > -			val = 0;
> > -
> > -		regmap_update_bits(mixer->engine.regs,
> > -				   
SUN8I_MIXER_BLEND_OUTCTL(bld_base),
> > -				   
SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
> > -				   val);
> > -
> > -		DRM_DEBUG_DRIVER("Switching display mixer interlaced 
mode %s\n",
> > -				 interlaced ? "on" : "off");
> > -	}
> > -
> > 
> >  	/* Set height and width */
> >  	DRM_DEBUG_DRIVER("Layer source offset X: %d Y: %d\n",
> >  	
> >  			 state->src.x1 >> 16, state->src.y1 >> 16);
> > 
> > @@ -349,9 +319,6 @@ struct sun8i_ui_layer *sun8i_ui_layer_init_one(struct
> > drm_device *drm,> 
> >  	if (!layer)
> >  	
> >  		return ERR_PTR(-ENOMEM);
> > 
> > -	if (index == 0)
> > -		type = DRM_PLANE_TYPE_PRIMARY;
> > -
> > 
> >  	/* possible crtcs are set later */
> >  	ret = drm_universal_plane_init(drm, &layer->plane, 0,
> >  	
> >  				       &sun8i_ui_layer_funcs,
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c index 07c27e6a4b77..49c4074e164f
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > @@ -116,6 +116,36 @@ static int sun8i_vi_layer_update_coord(struct
> > sun8i_mixer *mixer, int channel,> 
> >  	insize = SUN8I_MIXER_SIZE(src_w, src_h);
> >  	outsize = SUN8I_MIXER_SIZE(dst_w, dst_h);
> > 
> > +	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
> > +		bool interlaced = false;
> > +		u32 val;
> > +
> > +		DRM_DEBUG_DRIVER("Primary layer, updating global size 
W: %u H: %u\n",
> > +				 dst_w, dst_h);
> > +		regmap_write(mixer->engine.regs,
> > +			     SUN8I_MIXER_GLOBAL_SIZE,
> > +			     outsize);
> > +		regmap_write(mixer->engine.regs,
> > +			     SUN8I_MIXER_BLEND_OUTSIZE(bld_base), 
outsize);
> > +
> > +		if (state->crtc)
> > +			interlaced = state->crtc->state-
>adjusted_mode.flags
> > +				& DRM_MODE_FLAG_INTERLACE;
> > +
> > +		if (interlaced)
> > +			val = SUN8I_MIXER_BLEND_OUTCTL_INTERLACED;
> > +		else
> > +			val = 0;
> > +
> > +		regmap_update_bits(mixer->engine.regs,
> > +				   
SUN8I_MIXER_BLEND_OUTCTL(bld_base),
> > +				   
SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
> > +				   val);
> > +
> > +		DRM_DEBUG_DRIVER("Switching display mixer interlaced 
mode %s\n",
> > +				 interlaced ? "on" : "off");
> > +	}
> > +
> > 
> >  	/* Set height and width */
> >  	DRM_DEBUG_DRIVER("Layer source offset X: %d Y: %d\n",
> >  	
> >  			 (state->src.x1 >> 16) & ~(format->hsub - 
1),
> > 
> > @@ -445,6 +475,7 @@ struct sun8i_vi_layer *sun8i_vi_layer_init_one(struct
> > drm_device *drm,> 
> >  					       struct 
sun8i_mixer *mixer,
> >  					       int index)
> >  
> >  {
> > 
> > +	enum drm_plane_type type = DRM_PLANE_TYPE_OVERLAY;
> > 
> >  	struct sun8i_vi_layer *layer;
> >  	unsigned int plane_cnt;
> >  	int ret;
> > 
> > @@ -453,12 +484,15 @@ struct sun8i_vi_layer
> > *sun8i_vi_layer_init_one(struct drm_device *drm,> 
> >  	if (!layer)
> >  	
> >  		return ERR_PTR(-ENOMEM);
> > 
> > +	if (index == 0)
> > +		type = DRM_PLANE_TYPE_PRIMARY;
> > +
> > 
> >  	/* possible crtcs are set later */
> >  	ret = drm_universal_plane_init(drm, &layer->plane, 0,
> >  	
> >  				       &sun8i_vi_layer_funcs,
> >  				       sun8i_vi_layer_formats,
> >  				       
ARRAY_SIZE(sun8i_vi_layer_formats),
> > 
> > -				       NULL, 
DRM_PLANE_TYPE_OVERLAY, NULL);
> > +				       NULL, type, NULL);
> > 
> >  	if (ret) {
> >  	
> >  		dev_err(drm->dev, "Couldn't initialize layer\n");
> >  		return ERR_PTR(ret);
> > 
> > --
> > 2.17.1




