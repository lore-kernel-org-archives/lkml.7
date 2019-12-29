Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A80C2D0C6
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 12:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839E2206E4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 12:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="aGDpI6F4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfL2MId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 07:08:33 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44532 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfL2MId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 07:08:33 -0500
Received: by mail-ed1-f66.google.com with SMTP id bx28so29703618edb.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 Dec 2019 04:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x73WnrIjmFq3ORdQPkVoDGf3tvkED3CW22+XB4slDCs=;
        b=aGDpI6F42/g5uHQzMz2CfsN6efJwGtQnEZTDFFYbOO5diKbHhsl2gaQfDI7NDVzmsv
         5SKersrywzqJJtsrotnLSWNHZTJFPGzUVszh7ryV3aU8/ZMeyjjawwGpdWXeRHrWKQTl
         Eu9yfRLhOr5kdKIDiUXBOdrVLnXIgIRHNl2mvFGGc1ADpZIw8V0IGq30srCbDG8ymdpP
         TWUu4sGdtYsSnuGc94KH//4v3P0/dhD0DBi3IbfelgTtDiGAg7ILJmNlPqttERXNBjxs
         KuEypEE6j4/SOaPSzeq5dmGdWew0zgjXQ/jlHqAaNEVwt5HXYlsvv/AGkH1k93vd3Lz0
         UxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x73WnrIjmFq3ORdQPkVoDGf3tvkED3CW22+XB4slDCs=;
        b=m0Y2+NeeocCkNe5Clq26wR5OLgp+hKCoQMzIMAo0lPlNXokGFuqgEO4xRCmk5WrYYD
         lWT/4Q0LJRFGSeprmT5VJh/WOmf4DMBe+mNxjL4s3x6mzgeC0ZrGJ21x6YQ+T7IOI+ug
         pAKdbATdMJMN7V255otDL6rvZwUgrR3kAGIeUpexqtEvpnd2XhGw6lIcWPtHL+BQ57jt
         TNLDpf9Qo5npzfVfu0ViC6ihcIzE6zritF3uB5cm+NgvVOaCSK1+iW8TtwdRGkSGWW3Q
         vARpgMgZIHeM+K69xj4reCZkrdelMexz1vpHtCl+LWzHCOmTnbyX7vE9vsoADW/4wcVf
         uYLg==
X-Gm-Message-State: APjAAAX6Ed3fANwybyGwH6LkxFI3riVB+JvObqhyqxYaQ4CayUe0mq4T
        nbwQl0MUhmyRvJOHLMtUw+gfFAVTP2n20ObZCqVJGA==
X-Google-Smtp-Source: APXvYqzP5ndhTbaxTdTjP2hOSWpMKgaUvqF3Dfy5nraWcGp1NXtJvEEu7SK9hDs9XfQenDX9vuSlPV0PErfRfvOVekc=
X-Received: by 2002:a17:906:d0c9:: with SMTP id bq9mr64910359ejb.56.1577621310327;
 Sun, 29 Dec 2019 04:08:30 -0800 (PST)
MIME-Version: 1.0
References: <20191228202818.69908-1-roman.stratiienko@globallogic.com>
 <20191228202818.69908-4-roman.stratiienko@globallogic.com> <3994677.ejJDZkT8p0@jernej-laptop>
In-Reply-To: <3994677.ejJDZkT8p0@jernej-laptop>
From:   Roman Stratiienko <roman.stratiienko@globallogic.com>
Date:   Sun, 29 Dec 2019 14:08:19 +0200
Message-ID: <CAODwZ7u3zAfsXRE-9XP0x=eoXYL__EzMLeJjE87_aPTe4UzRPg@mail.gmail.com>
Subject: Re: [RFC 3/4] drm/sun4i: Reimplement plane z position setting logic
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jernej,

Thank you for review.

On Sun, Dec 29, 2019 at 11:40 AM Jernej =C5=A0krabec <jernej.skrabec@siol.n=
et> wrote:
>
> Hi!
>
> Dne sobota, 28. december 2019 ob 21:28:17 CET je
> roman.stratiienko@globallogic.com napisal(a):
> > From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> >
> > To set blending channel order register software needs to know state and
> > position of each channel, which impossible at plane commit stage.
> >
> > Move this procedure to atomic_flush stage, where all necessary informat=
ion
> > is available.
> >
> > Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun8i_mixer.c    | 47 +++++++++++++++++++++++++-
> >  drivers/gpu/drm/sun4i/sun8i_mixer.h    |  3 ++
> >  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 42 ++++-------------------
> >  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 39 +++------------------
> >  4 files changed, 60 insertions(+), 71 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > b/drivers/gpu/drm/sun4i/sun8i_mixer.c index bb9a665fd053..da84fccf7784
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > @@ -307,8 +307,47 @@ static void sun8i_atomic_begin(struct sunxi_engine
> > *engine,
> >
> >  static void sun8i_mixer_commit(struct sunxi_engine *engine)
> >  {
> > -     DRM_DEBUG_DRIVER("Committing changes\n");
> > +     struct sun8i_mixer *mixer =3D engine_to_sun8i_mixer(engine);
> > +     u32 base =3D sun8i_blender_base(mixer);
> > +     int i, j;
> > +     int channel_by_zpos[4] =3D {-1, -1, -1, -1};
> > +     u32 route =3D 0, pipe_ctl =3D 0;
> > +
> > +     DRM_DEBUG_DRIVER("Update blender routing\n");
>
> Use drm_dbg().
>
> > +     for (i =3D 0; i < 4; i++) {
> > +             int zpos =3D mixer->channel_zpos[i];
>
> channel_zpos can hold 5 elements which is also theoretical maximum for cu=
rrent
> HW design. Why do you check only 4 elements?
>

I'll use plane_cnt as it done in mixer_bind

> It would be great to introduce a macro like SUN8I_MIXER_MAX_LAYERS so eve=
ryone
> would understand where this number comes from.

Will do.

>
> > +
> > +             if (zpos >=3D 0 && zpos < 4)
> > +                     channel_by_zpos[zpos] =3D i;
> > +     }
> > +
> > +     j =3D 0;
> > +     for (i =3D 0; i < 4; i++) {
> > +             int ch =3D channel_by_zpos[i];
> > +
> > +             if (ch >=3D 0) {
> > +                     pipe_ctl |=3D SUN8I_MIXER_BLEND_PIPE_CTL_EN(j);
> > +                     route |=3D ch <<
> SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(j);
> > +                     j++;
> > +             }
> > +     }
> > +
> > +     for (i =3D 0; i < 4 && j < 4; i++) {
> > +             int zpos =3D mixer->channel_zpos[i];
> >
> > +             if (zpos < 0) {
> > +                     route |=3D i <<
> SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(j);
> > +                     j++;
> > +             }
> > +     }
> > +
> > +     regmap_update_bits(mixer->engine.regs,
> SUN8I_MIXER_BLEND_PIPE_CTL(base),
> > +                        SUN8I_MIXER_BLEND_PIPE_CTL_EN_MSK,
> pipe_ctl);
> > +
> > +     regmap_write(mixer->engine.regs,
> > +                  SUN8I_MIXER_BLEND_ROUTE(base), route);
> > +
> > +     DRM_DEBUG_DRIVER("Committing changes\n");
>
> Use drm_dbg().

According to https://github.com/torvalds/linux/commit/99a954874e7b9f0c80584=
76575593b3beb5731a5#diff-b0cd2d683c6afbab7bd54173cfd3d3ecR289
,
DRM_DEBUG_DRIVER uses drm_dbg.
Also, using drm_dbg with category macro would require larger indent,
making harder to fit in 80 chars limit.
Are there any plans to deprecate DRM_DEBUG_DRIVER macro?

>
> >       regmap_write(engine->regs, SUN8I_MIXER_GLOBAL_DBUFF,
> >                    SUN8I_MIXER_GLOBAL_DBUFF_ENABLE);
> >  }
> > @@ -422,6 +461,12 @@ static int sun8i_mixer_bind(struct device *dev, st=
ruct
> > device *master, mixer->engine.ops =3D &sun8i_engine_ops;
> >       mixer->engine.node =3D dev->of_node;
> >
> > +     mixer->channel_zpos[0] =3D -1;
> > +     mixer->channel_zpos[1] =3D -1;
> > +     mixer->channel_zpos[2] =3D -1;
> > +     mixer->channel_zpos[3] =3D -1;
> > +     mixer->channel_zpos[4] =3D -1;
> > +
>
> for loop would be better, especially using proposed macro.

I'll put it into already existent for-loop below.

>
> Best regards,
> Jernej
>
> >       /*
> >        * While this function can fail, we shouldn't do anything
> >        * if this happens. Some early DE2 DT entries don't provide
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> > b/drivers/gpu/drm/sun4i/sun8i_mixer.h index 915479cc3077..9c2ff87923d8
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> > +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
> > @@ -178,6 +178,9 @@ struct sun8i_mixer {
> >
> >       struct clk                      *bus_clk;
> >       struct clk                      *mod_clk;
> > +
> > +     /* -1 means that layer is disabled */
> > +     int channel_zpos[5];
> >  };
> >
> >  static inline struct sun8i_mixer *
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> > b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c index 893076716070..23c2f4b68c=
89
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> > @@ -24,12 +24,10 @@
> >  #include "sun8i_ui_scaler.h"
> >
> >  static void sun8i_ui_layer_enable(struct sun8i_mixer *mixer, int chann=
el,
> > -                               int overlay, bool enable,
> unsigned int zpos,
> > -                               unsigned int old_zpos)
> > +                               int overlay, bool enable,
> unsigned int zpos)
> >  {
> > -     u32 val, bld_base, ch_base;
> > +     u32 val, ch_base;
> >
> > -     bld_base =3D sun8i_blender_base(mixer);
> >       ch_base =3D sun8i_channel_base(mixer, channel);
> >
> >       DRM_DEBUG_DRIVER("%sabling channel %d overlay %d\n",
> > @@ -44,32 +42,7 @@ static void sun8i_ui_layer_enable(struct sun8i_mixer
> > *mixer, int channel, SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base, overlay),
> >                          SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN, val);
> >
> > -     if (!enable || zpos !=3D old_zpos) {
> > -             regmap_update_bits(mixer->engine.regs,
> > -
> SUN8I_MIXER_BLEND_PIPE_CTL(bld_base),
> > -
> SUN8I_MIXER_BLEND_PIPE_CTL_EN(old_zpos),
> > -                                0);
> > -
> > -             regmap_update_bits(mixer->engine.regs,
> > -
> SUN8I_MIXER_BLEND_ROUTE(bld_base),
> > -
> SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(old_zpos),
> > -                                0);
> > -     }
> > -
> > -     if (enable) {
> > -             val =3D SUN8I_MIXER_BLEND_PIPE_CTL_EN(zpos);
> > -
> > -             regmap_update_bits(mixer->engine.regs,
> > -
> SUN8I_MIXER_BLEND_PIPE_CTL(bld_base),
> > -                                val, val);
> > -
> > -             val =3D channel <<
> SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(zpos);
> > -
> > -             regmap_update_bits(mixer->engine.regs,
> > -
> SUN8I_MIXER_BLEND_ROUTE(bld_base),
> > -
> SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(zpos),
> > -                                val);
> > -     }
> > +     mixer->channel_zpos[channel] =3D enable ? zpos : -1;
> >  }
> >
> >  static int sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int
> > channel, @@ -235,11 +208,9 @@ static void
> > sun8i_ui_layer_atomic_disable(struct drm_plane *plane, struct
> > drm_plane_state *old_state)
> >  {
> >       struct sun8i_ui_layer *layer =3D plane_to_sun8i_ui_layer(plane);
> > -     unsigned int old_zpos =3D old_state->normalized_zpos;
> >       struct sun8i_mixer *mixer =3D layer->mixer;
> >
> > -     sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay,
> false, 0,
> > -                           old_zpos);
> > +     sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay, fals=
e,
> 0);
> >  }
> >
> >  static void sun8i_ui_layer_atomic_update(struct drm_plane *plane,
> > @@ -247,12 +218,11 @@ static void sun8i_ui_layer_atomic_update(struct
> > drm_plane *plane, {
> >       struct sun8i_ui_layer *layer =3D plane_to_sun8i_ui_layer(plane);
> >       unsigned int zpos =3D plane->state->normalized_zpos;
> > -     unsigned int old_zpos =3D old_state->normalized_zpos;
> >       struct sun8i_mixer *mixer =3D layer->mixer;
> >
> >       if (!plane->state->visible) {
> >               sun8i_ui_layer_enable(mixer, layer->channel,
> > -                                   layer->overlay, false, 0,
> old_zpos);
> > +                                   layer->overlay, false, 0);
> >               return;
> >       }
> >
> > @@ -263,7 +233,7 @@ static void sun8i_ui_layer_atomic_update(struct
> > drm_plane *plane, sun8i_ui_layer_update_buffer(mixer, layer->channel,
> >                                    layer->overlay, plane);
> >       sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay,
> > -                           true, zpos, old_zpos);
> > +                           true, zpos);
> >  }
> >
> >  static struct drm_plane_helper_funcs sun8i_ui_layer_helper_funcs =3D {
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c index 42d445d23773..97cbc98bf7=
81
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > @@ -17,8 +17,7 @@
> >  #include "sun8i_vi_scaler.h"
> >
> >  static void sun8i_vi_layer_enable(struct sun8i_mixer *mixer, int chann=
el,
> > -                               int overlay, bool enable,
> unsigned int zpos,
> > -                               unsigned int old_zpos)
> > +                               int overlay, bool enable,
> unsigned int zpos)
> >  {
> >       u32 val, bld_base, ch_base;
> >
> > @@ -37,32 +36,7 @@ static void sun8i_vi_layer_enable(struct sun8i_mixer
> > *mixer, int channel, SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, overlay),
> >                          SUN8I_MIXER_CHAN_VI_LAYER_ATTR_EN, val);
> >
> > -     if (!enable || zpos !=3D old_zpos) {
> > -             regmap_update_bits(mixer->engine.regs,
> > -
> SUN8I_MIXER_BLEND_PIPE_CTL(bld_base),
> > -
> SUN8I_MIXER_BLEND_PIPE_CTL_EN(old_zpos),
> > -                                0);
> > -
> > -             regmap_update_bits(mixer->engine.regs,
> > -
> SUN8I_MIXER_BLEND_ROUTE(bld_base),
> > -
> SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(old_zpos),
> > -                                0);
> > -     }
> > -
> > -     if (enable) {
> > -             val =3D SUN8I_MIXER_BLEND_PIPE_CTL_EN(zpos);
> > -
> > -             regmap_update_bits(mixer->engine.regs,
> > -
> SUN8I_MIXER_BLEND_PIPE_CTL(bld_base),
> > -                                val, val);
> > -
> > -             val =3D channel <<
> SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(zpos);
> > -
> > -             regmap_update_bits(mixer->engine.regs,
> > -
> SUN8I_MIXER_BLEND_ROUTE(bld_base),
> > -
> SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(zpos),
> > -                                val);
> > -     }
> > +     mixer->channel_zpos[channel] =3D enable ? zpos : -1;
> >  }
> >
> >  static int sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int
> > channel, @@ -350,11 +324,9 @@ static void
> > sun8i_vi_layer_atomic_disable(struct drm_plane *plane, struct
> > drm_plane_state *old_state)
> >  {
> >       struct sun8i_vi_layer *layer =3D plane_to_sun8i_vi_layer(plane);
> > -     unsigned int old_zpos =3D old_state->normalized_zpos;
> >       struct sun8i_mixer *mixer =3D layer->mixer;
> >
> > -     sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay,
> false, 0,
> > -                           old_zpos);
> > +     sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay, fals=
e,
> 0);
> >  }
> >
> >  static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
> > @@ -362,12 +334,11 @@ static void sun8i_vi_layer_atomic_update(struct
> > drm_plane *plane, {
> >       struct sun8i_vi_layer *layer =3D plane_to_sun8i_vi_layer(plane);
> >       unsigned int zpos =3D plane->state->normalized_zpos;
> > -     unsigned int old_zpos =3D old_state->normalized_zpos;
> >       struct sun8i_mixer *mixer =3D layer->mixer;
> >
> >       if (!plane->state->visible) {
> >               sun8i_vi_layer_enable(mixer, layer->channel,
> > -                                   layer->overlay, false, 0,
> old_zpos);
> > +                                   layer->overlay, false, 0);
> >               return;
> >       }
> >
> > @@ -378,7 +349,7 @@ static void sun8i_vi_layer_atomic_update(struct
> > drm_plane *plane, sun8i_vi_layer_update_buffer(mixer, layer->channel,
> >                                    layer->overlay, plane);
> >       sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay,
> > -                           true, zpos, old_zpos);
> > +                           true, zpos);
> >  }
> >
> >  static struct drm_plane_helper_funcs sun8i_vi_layer_helper_funcs =3D {
>
>
>
>


--=20
Best regards,
Roman Stratiienko
Global Logic Inc.
