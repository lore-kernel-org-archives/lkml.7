Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9C9C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC44222CF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="BN6jP/j1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437637AbfITHyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 03:54:50 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46632 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437626AbfITHyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 03:54:50 -0400
Received: by mail-ed1-f65.google.com with SMTP id t3so5438838edw.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 00:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gTl0/zojW/YMwD6857GyvtQiwPcC3wEmLLrOtd8M3CI=;
        b=BN6jP/j17vDhUo9RVgyUGTkIc+LehR/6uoUew57ENg1nbEJV3vOHNrANL2YM3D2E1e
         vgplHgKrLBiMOD5UButpnUPpHnBB1pz1FUWVSzFlZ0xoL7+5xo7qcQBO7oCOtFtlUYgS
         oE9qJJpJN2UMcQUgMYFx2PjldVRgvYuZOyIkqTWdic6I3wXz+GflX48PLBgXym1TpTq9
         4AXburDEU5vY9RNrtOHALgjfv2y/k6f6AKCDGhUKBqSwoa7Oo/hW0wyqd7SQ6S8YXFX4
         EjZkbhurwYAygxFUG6EMDjdXeTZONglgFKS18WaJNY3YzbEQS++uyEMJC1nDHlRCIgtb
         IB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gTl0/zojW/YMwD6857GyvtQiwPcC3wEmLLrOtd8M3CI=;
        b=KK3QkJHREH9aZtJymmTz7STsv/L/8J5cytnf00pggWPRg79oy9+L2xZLujGGfklb/j
         vcSaBCFjKzTTrhdK6V4X82Fp/wEd3A3/T1Tu15cVfVWpdu82zfMdk+UCx3E0KiQl/YRU
         E5zCECUeNvt2j0bFeAB5lY46QOqYogHzs1IZydcVD496bL9gq04vsG+68H30q2gB2Q4L
         2m2rvJvwtGEolKvMUI7NzPATvim8xGN2RcQ+5v8Upb+llboloGz997E+uf89hTEKSxR0
         9lptgs1eN0li8F7ecMezkxjsZdwhgutZdWyzdcaydPQVUC0EfMSXMPw9bApjGXnmpY8D
         3YcA==
X-Gm-Message-State: APjAAAUMQgzGv+RmS74BI3/BVE96in25xW4hV/+wkR01kM7z5R24x31K
        rgQjNr8Gh6rVN2cRU/lc6+3fPeKa1gd89ZCf/7lg+zM8dOw=
X-Google-Smtp-Source: APXvYqy0f/V8Tbl32ICbiQGM3E97+0UMwzQeILI7xu9zHBxIokVKNM8p8CNybQHEf1aiPdJd6H5AmGtPFKDoJlRYdqA=
X-Received: by 2002:a17:906:d050:: with SMTP id bo16mr18416776ejb.146.1568966087313;
 Fri, 20 Sep 2019 00:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190919123703.8545-1-roman.stratiienko@globallogic.com>
 <20190919171754.x6lq73cctnqsjr4v@gilmour> <104595190.vWb6g8xIPX@jernej-laptop>
In-Reply-To: <104595190.vWb6g8xIPX@jernej-laptop>
From:   Roman Stratiienko <roman.stratiienko@globallogic.com>
Date:   Fri, 20 Sep 2019 10:54:36 +0300
Message-ID: <CAODwZ7sDpJH3CSt5P3h+2OJnpLExkb+mmyWy2mOpx=A-eG3seQ@mail.gmail.com>
Subject: Re: [PATCH] drm/sun4i: Use vi plane as primary
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Resending  message in plain mode ]

Hello guys,

Actually, I believe this is True solution, and current one is wrong.
Let me explain why.

De2. 0 was designed to match Android hwcomposer hal requirements IMO.
You can easily agree with this conclusion by comparing Composer HAL
and De2. 0 hardware manuals.

I faced at least 4 issues when trying to run Android using the
mainline kernel sun8i mixer implementation. Current one, missing pixel
formats (my previous patch), missing plane alpha and rotation
properties. I plan to fix it and also send appropriate solution to the
upstream.

To achieve optimal UI performance Android requires at least 4 ui
layers to make screen composition. Current patch enables 4th plane
usable.

As for using vi plane to display video. I assume that some of the
current users may have regression in their software, but it could be
easily fixed. For example if vi layer isn't fullscreen and should be
on top of the other layers, it can actually be placed on the bottom
and overlayed with pictures with transparent rectangles in video
region.
But I assume most of users such as browser etc. uses GPU for that.

And if you are watching fullscreen video, I can imagine only subtitles
layer and advertising layers on top of the video layers.


On Thu, Sep 19, 2019 at 9:15 PM Jernej =C5=A0krabec <jernej.skrabec@siol.ne=
t> wrote:
>
> Dne =C4=8Detrtek, 19. september 2019 ob 19:17:54 CEST je Maxime Ripard na=
pisal(a):
> > Hi,
> >
> > On Thu, Sep 19, 2019 at 03:37:03PM +0300, roman.stratiienko@globallogic=
.com
> wrote:
> > > From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> > >
> > > DE2.0 blender does not take into the account alpha channel of vi laye=
r.
> > > Thus makes overlaying of this layer totally opaque.
> > > Using vi layer as bottom solves this issue.
>
> What issue? Overlays don't have to be "full screen", thus missing support=
 for
> alpha blending doesn't make it less valuable. And VI planes are already p=
laced
> at the bottom (zpos =3D 0).
>
> > >
> > > Tested on Android.
> > >
> > > Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
> >
> > It sounds like a workaround more than an actual fix.
> >
> > If the VI planes can't use the alpha, then we should just stop
> > reporting that format.
> >
> > Jernej, what do you think?
>
> Commit message is misleading. What this commit actually does is moving pr=
imary
> plane from first UI plane to bottom most plane, i.e. first VI plane. Howe=
ver, VI
> planes are scarce resource, almost all mixers have only one. I wouldn't s=
et it
> as primary, because it's the only one which provide support for YUV forma=
ts.
> That could be used for example by video player for zero-copy rendering.
> Probably most apps wouldn't touch it if it was primary (that's usually
> reserved for window manager, if used).
>
> I left few formats with alpha channel exposed by VI planes, just because =
they
> don't have equivalent format without alpha. But I'm fine with removing th=
em if
> you all agree on that.
>
> Best regards,
> Jernej
>
> >
> > Maxime
> >
> > > ---
> > >
> > >  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 33 -----------------------
> > >  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 36 ++++++++++++++++++++++++=
+-
> > >  2 files changed, 35 insertions(+), 34 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> > > b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c index dd2a1c851939..25183bad=
c85f
> > > 100644
> > > --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> > > +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> > > @@ -99,36 +99,6 @@ static int sun8i_ui_layer_update_coord(struct
> > > sun8i_mixer *mixer, int channel,>
> > >     insize =3D SUN8I_MIXER_SIZE(src_w, src_h);
> > >     outsize =3D SUN8I_MIXER_SIZE(dst_w, dst_h);
> > >
> > > -   if (plane->type =3D=3D DRM_PLANE_TYPE_PRIMARY) {
> > > -           bool interlaced =3D false;
> > > -           u32 val;
> > > -
> > > -           DRM_DEBUG_DRIVER("Primary layer, updating global size
> W: %u H: %u\n",
> > > -                            dst_w, dst_h);
> > > -           regmap_write(mixer->engine.regs,
> > > -                        SUN8I_MIXER_GLOBAL_SIZE,
> > > -                        outsize);
> > > -           regmap_write(mixer->engine.regs,
> > > -                        SUN8I_MIXER_BLEND_OUTSIZE(bld_base),
> outsize);
> > > -
> > > -           if (state->crtc)
> > > -                   interlaced =3D state->crtc->state-
> >adjusted_mode.flags
> > > -                           & DRM_MODE_FLAG_INTERLACE;
> > > -
> > > -           if (interlaced)
> > > -                   val =3D SUN8I_MIXER_BLEND_OUTCTL_INTERLACED;
> > > -           else
> > > -                   val =3D 0;
> > > -
> > > -           regmap_update_bits(mixer->engine.regs,
> > > -
> SUN8I_MIXER_BLEND_OUTCTL(bld_base),
> > > -
> SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
> > > -                              val);
> > > -
> > > -           DRM_DEBUG_DRIVER("Switching display mixer interlaced
> mode %s\n",
> > > -                            interlaced ? "on" : "off");
> > > -   }
> > > -
> > >
> > >     /* Set height and width */
> > >     DRM_DEBUG_DRIVER("Layer source offset X: %d Y: %d\n",
> > >
> > >                      state->src.x1 >> 16, state->src.y1 >> 16);
> > >
> > > @@ -349,9 +319,6 @@ struct sun8i_ui_layer *sun8i_ui_layer_init_one(st=
ruct
> > > drm_device *drm,>
> > >     if (!layer)
> > >
> > >             return ERR_PTR(-ENOMEM);
> > >
> > > -   if (index =3D=3D 0)
> > > -           type =3D DRM_PLANE_TYPE_PRIMARY;
> > > -
> > >
> > >     /* possible crtcs are set later */
> > >     ret =3D drm_universal_plane_init(drm, &layer->plane, 0,
> > >
> > >                                    &sun8i_ui_layer_funcs,
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > > b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c index 07c27e6a4b77..49c4074e=
164f
> > > 100644
> > > --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > > +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > > @@ -116,6 +116,36 @@ static int sun8i_vi_layer_update_coord(struct
> > > sun8i_mixer *mixer, int channel,>
> > >     insize =3D SUN8I_MIXER_SIZE(src_w, src_h);
> > >     outsize =3D SUN8I_MIXER_SIZE(dst_w, dst_h);
> > >
> > > +   if (plane->type =3D=3D DRM_PLANE_TYPE_PRIMARY) {
> > > +           bool interlaced =3D false;
> > > +           u32 val;
> > > +
> > > +           DRM_DEBUG_DRIVER("Primary layer, updating global size
> W: %u H: %u\n",
> > > +                            dst_w, dst_h);
> > > +           regmap_write(mixer->engine.regs,
> > > +                        SUN8I_MIXER_GLOBAL_SIZE,
> > > +                        outsize);
> > > +           regmap_write(mixer->engine.regs,
> > > +                        SUN8I_MIXER_BLEND_OUTSIZE(bld_base),
> outsize);
> > > +
> > > +           if (state->crtc)
> > > +                   interlaced =3D state->crtc->state-
> >adjusted_mode.flags
> > > +                           & DRM_MODE_FLAG_INTERLACE;
> > > +
> > > +           if (interlaced)
> > > +                   val =3D SUN8I_MIXER_BLEND_OUTCTL_INTERLACED;
> > > +           else
> > > +                   val =3D 0;
> > > +
> > > +           regmap_update_bits(mixer->engine.regs,
> > > +
> SUN8I_MIXER_BLEND_OUTCTL(bld_base),
> > > +
> SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
> > > +                              val);
> > > +
> > > +           DRM_DEBUG_DRIVER("Switching display mixer interlaced
> mode %s\n",
> > > +                            interlaced ? "on" : "off");
> > > +   }
> > > +
> > >
> > >     /* Set height and width */
> > >     DRM_DEBUG_DRIVER("Layer source offset X: %d Y: %d\n",
> > >
> > >                      (state->src.x1 >> 16) & ~(format->hsub -
> 1),
> > >
> > > @@ -445,6 +475,7 @@ struct sun8i_vi_layer *sun8i_vi_layer_init_one(st=
ruct
> > > drm_device *drm,>
> > >                                            struct
> sun8i_mixer *mixer,
> > >                                            int index)
> > >
> > >  {
> > >
> > > +   enum drm_plane_type type =3D DRM_PLANE_TYPE_OVERLAY;
> > >
> > >     struct sun8i_vi_layer *layer;
> > >     unsigned int plane_cnt;
> > >     int ret;
> > >
> > > @@ -453,12 +484,15 @@ struct sun8i_vi_layer
> > > *sun8i_vi_layer_init_one(struct drm_device *drm,>
> > >     if (!layer)
> > >
> > >             return ERR_PTR(-ENOMEM);
> > >
> > > +   if (index =3D=3D 0)
> > > +           type =3D DRM_PLANE_TYPE_PRIMARY;
> > > +
> > >
> > >     /* possible crtcs are set later */
> > >     ret =3D drm_universal_plane_init(drm, &layer->plane, 0,
> > >
> > >                                    &sun8i_vi_layer_funcs,
> > >                                    sun8i_vi_layer_formats,
> > >
> ARRAY_SIZE(sun8i_vi_layer_formats),
> > >
> > > -                                  NULL,
> DRM_PLANE_TYPE_OVERLAY, NULL);
> > > +                                  NULL, type, NULL);
> > >
> > >     if (ret) {
> > >
> > >             dev_err(drm->dev, "Couldn't initialize layer\n");
> > >             return ERR_PTR(ret);
> > >
> > > --
> > > 2.17.1
>
>
>
>


--=20
Best regards,
Roman Stratiienko
Global Logic
ADIT Team
