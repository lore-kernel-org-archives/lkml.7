Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3780BC2D0C6
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 12:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0641206E4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 12:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="J2OGVp3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfL2Mrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 07:47:53 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34112 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfL2Mrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 07:47:52 -0500
Received: by mail-ed1-f65.google.com with SMTP id l8so29856110edw.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Dec 2019 04:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zzFMPdfpHln29Lt4auEIKECN7L4xYuWWlgsi6kEW3h8=;
        b=J2OGVp3Sg5uAWHVBkBu5GnsgBZGAO55ZPyK6H4zsScttVgblq9VOr5xVRFtsnB+WYx
         7ikRIOePdPJKB2syYtqW8UV2wvDiSahifdFqbmBzji9vYxHA4be5TC9poc7x14U7hA4E
         e1NSD3X7oNVUt9gQf50PCJMwtsqg6wn800WsY/Nd6NnW+C1QqcujaIY3qSuQfXWR/T1H
         Oaf9vVnbMSr1Znm8OJTmJMZNWKiR5Sfr/7dMdjComYEf//Ra623vJeZQ6lcK3iVq6Xnr
         yrBgQw2axtQgbh7RSyaoS+56OXdkEihJ7Nok23XXnG+TDXYFvFXkHtq9F+Cf5za9GRZr
         pyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zzFMPdfpHln29Lt4auEIKECN7L4xYuWWlgsi6kEW3h8=;
        b=h7DHQUVxEu59oTyJiyn5oSHfu5knLMOreTFhx6TIa2I4B6bzPGmRnwrw2MqVfWOCTj
         ZDr2wSyFRZZUxvAUizruW1C9Wbt3yYSTsmcq0IFu9PwdpeuqzmZlvU7E8smBiQ0yhnQK
         S1zpyoWOOc0DhhyfL8f+vlyPPsoGUnVbbEBjgIXqHsSP8Rn2VLyX7l1D5vv+cgdxpq4S
         TeTetLVSoBGLjYaYM24QQJXlB6WaKMTF4S9dZ6MJK771U5vyft/Lx7dKmnDIk3pJBfde
         63DvWe9MtU3U133dOZP/lUU6D8ISjV2QP9/4bFIs3ImkmoueMSTmuWQnUsJrjTYYvVLQ
         XlIw==
X-Gm-Message-State: APjAAAUIAKAZTSw21Qpu+6Ah09d2Zgjdx1q430lSlPf3iHac39GxMcKH
        RkuwSASryqRpK5Gzm0E7kYn15ZPlBLs7HWns5Tn2LQ==
X-Google-Smtp-Source: APXvYqzF9yn3V2h9IkRN/DoySJJe/FrIXudn+YGCSfnGdaPZt4PAoYGC7K1TMhgGD3i9lzF/UHxPTQzDMKFsT7ju/bs=
X-Received: by 2002:a17:906:ecae:: with SMTP id qh14mr63676694ejb.229.1577623669678;
 Sun, 29 Dec 2019 04:47:49 -0800 (PST)
MIME-Version: 1.0
References: <20191228202818.69908-1-roman.stratiienko@globallogic.com>
 <3994677.ejJDZkT8p0@jernej-laptop> <CAODwZ7u3zAfsXRE-9XP0x=eoXYL__EzMLeJjE87_aPTe4UzRPg@mail.gmail.com>
 <1775324.taCxCBeP46@jernej-laptop>
In-Reply-To: <1775324.taCxCBeP46@jernej-laptop>
From:   Roman Stratiienko <roman.stratiienko@globallogic.com>
Date:   Sun, 29 Dec 2019 14:47:38 +0200
Message-ID: <CAODwZ7srrrbDk=kKjg2-amVtGzNsqqZ72JopHijtNPD=-EzjgA@mail.gmail.com>
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

On Sun, Dec 29, 2019 at 2:18 PM Jernej =C5=A0krabec <jernej.skrabec@siol.ne=
t> wrote:
>
> Dne nedelja, 29. december 2019 ob 13:08:19 CET je Roman Stratiienko
> napisal(a):
> > Hello Jernej,
> >
> > Thank you for review.
> >
> > On Sun, Dec 29, 2019 at 11:40 AM Jernej =C5=A0krabec <jernej.skrabec@si=
ol.net>
> wrote:
> > > Hi!
> > >
> > > Dne sobota, 28. december 2019 ob 21:28:17 CET je
> > >
> > > roman.stratiienko@globallogic.com napisal(a):
> > > > From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> > > >
> > > > To set blending channel order register software needs to know state=
 and
> > > > position of each channel, which impossible at plane commit stage.
> > > >
> > > > Move this procedure to atomic_flush stage, where all necessary
> > > > information
> > > > is available.
> > > >
> > > > Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com=
>
> > > > ---
> > > >
> > > >  drivers/gpu/drm/sun4i/sun8i_mixer.c    | 47 ++++++++++++++++++++++=
+++-
> > > >  drivers/gpu/drm/sun4i/sun8i_mixer.h    |  3 ++
> > > >  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 42 ++++------------------=
-
> > > >  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 39 +++------------------
> > > >  4 files changed, 60 insertions(+), 71 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > > b/drivers/gpu/drm/sun4i/sun8i_mixer.c index bb9a665fd053..da84fccf7=
784
> > > > 100644
> > > > --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > > +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > > @@ -307,8 +307,47 @@ static void sun8i_atomic_begin(struct sunxi_en=
gine
> > > > *engine,
> > > >
> > > >  static void sun8i_mixer_commit(struct sunxi_engine *engine)
> > > >  {
> > > >
> > > > -     DRM_DEBUG_DRIVER("Committing changes\n");
> > > > +     struct sun8i_mixer *mixer =3D engine_to_sun8i_mixer(engine);
> > > > +     u32 base =3D sun8i_blender_base(mixer);
> > > > +     int i, j;
> > > > +     int channel_by_zpos[4] =3D {-1, -1, -1, -1};
> > > > +     u32 route =3D 0, pipe_ctl =3D 0;
> > > > +
> > > > +     DRM_DEBUG_DRIVER("Update blender routing\n");
> > >
> > > Use drm_dbg().
> > >
> > > > +     for (i =3D 0; i < 4; i++) {
> > > > +             int zpos =3D mixer->channel_zpos[i];
> > >
> > > channel_zpos can hold 5 elements which is also theoretical maximum fo=
r
> > > current HW design. Why do you check only 4 elements?
> >
> > I'll use plane_cnt as it done in mixer_bind
> >
> > > It would be great to introduce a macro like SUN8I_MIXER_MAX_LAYERS so
> > > everyone would understand where this number comes from.
> >
> > Will do.
> >
> > > > +
> > > > +             if (zpos >=3D 0 && zpos < 4)
> > > > +                     channel_by_zpos[zpos] =3D i;
> > > > +     }
> > > > +
> > > > +     j =3D 0;
> > > > +     for (i =3D 0; i < 4; i++) {
> > > > +             int ch =3D channel_by_zpos[i];
> > > > +
> > > > +             if (ch >=3D 0) {
> > > > +                     pipe_ctl |=3D SUN8I_MIXER_BLEND_PIPE_CTL_EN(j=
);
> > > > +                     route |=3D ch <<
> > >
> > > SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(j);
> > >
> > > > +                     j++;
> > > > +             }
> > > > +     }
> > > > +
> > > > +     for (i =3D 0; i < 4 && j < 4; i++) {
> > > > +             int zpos =3D mixer->channel_zpos[i];
> > > >
> > > > +             if (zpos < 0) {
> > > > +                     route |=3D i <<
> > >
> > > SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(j);
> > >
> > > > +                     j++;
> > > > +             }
> > > > +     }
> > > > +
> > > > +     regmap_update_bits(mixer->engine.regs,
> > >
> > > SUN8I_MIXER_BLEND_PIPE_CTL(base),
> > >
> > > > +                        SUN8I_MIXER_BLEND_PIPE_CTL_EN_MSK,
> > >
> > > pipe_ctl);
> > >
> > > > +
> > > > +     regmap_write(mixer->engine.regs,
> > > > +                  SUN8I_MIXER_BLEND_ROUTE(base), route);
> > > > +
> > > > +     DRM_DEBUG_DRIVER("Committing changes\n");
> > >
> > > Use drm_dbg().
> >
> > According to
> > https://github.com/torvalds/linux/commit/99a954874e7b9f0c8058476575593b=
3beb
> > 5731a5#diff-b0cd2d683c6afbab7bd54173cfd3d3ecR289 ,
> > DRM_DEBUG_DRIVER uses drm_dbg.
> > Also, using drm_dbg with category macro would require larger indent,
> > making harder to fit in 80 chars limit.
>
> From what I can see, category is already defined by macro name. Check her=
e:
> https://cgit.freedesktop.org/drm/drm-misc/tree/include/drm/drm_print.h#n4=
65
>
> So it should be actually shorter.
>

Ah, it something very recent.
drm_dbg also require drm_device struct
Do you know the best way to extract it from `struct engine`?

> > Are there any plans to deprecate DRM_DEBUG_DRIVER macro?
>
> Yes, at least I understand following commit message in such manner:
> https://cgit.freedesktop.org/drm/drm-misc/commit/?
> id=3D93ccfa9a4eca482216c5caf88be77e5ffa0d744a
>
> Best regards,
> Jernej
>
> >
> > > >       regmap_write(engine->regs, SUN8I_MIXER_GLOBAL_DBUFF,
> > > >
> > > >                    SUN8I_MIXER_GLOBAL_DBUFF_ENABLE);
> > > >
> > > >  }
> > > >
> > > > @@ -422,6 +461,12 @@ static int sun8i_mixer_bind(struct device *dev=
,
> > > > struct
> > > > device *master, mixer->engine.ops =3D &sun8i_engine_ops;
> > > >
> > > >       mixer->engine.node =3D dev->of_node;
> > > >
> > > > +     mixer->channel_zpos[0] =3D -1;
> > > > +     mixer->channel_zpos[1] =3D -1;
> > > > +     mixer->channel_zpos[2] =3D -1;
> > > > +     mixer->channel_zpos[3] =3D -1;
> > > > +     mixer->channel_zpos[4] =3D -1;
> > > > +
> > >
> > > for loop would be better, especially using proposed macro.
> >
> > I'll put it into already existent for-loop below.
> >
> > > Best regards,
> > > Jernej
> > >
> > > >       /*
> > > >
> > > >        * While this function can fail, we shouldn't do anything
> > > >        * if this happens. Some early DE2 DT entries don't provide
> > > >
> > > > diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> > > > b/drivers/gpu/drm/sun4i/sun8i_mixer.h index 915479cc3077..9c2ff8792=
3d8
> > > > 100644
> > > > --- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> > > > +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
> > > > @@ -178,6 +178,9 @@ struct sun8i_mixer {
> > > >
> > > >       struct clk                      *bus_clk;
> > > >       struct clk                      *mod_clk;
> > > >
> > > > +
> > > > +     /* -1 means that layer is disabled */
> > > > +     int channel_zpos[5];
> > > >
> > > >  };
> > > >
> > > >  static inline struct sun8i_mixer *
> > > >
> > > > diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> > > > b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c index
> > > > 893076716070..23c2f4b68c89
> > > > 100644
> > > > --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> > > > +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> > > > @@ -24,12 +24,10 @@
> > > >
> > > >  #include "sun8i_ui_scaler.h"
> > > >
> > > >  static void sun8i_ui_layer_enable(struct sun8i_mixer *mixer, int
> > > >  channel,
> > > >
> > > > -                               int overlay, bool enable,
> > >
> > > unsigned int zpos,
> > >
> > > > -                               unsigned int old_zpos)
> > > > +                               int overlay, bool enable,
> > >
> > > unsigned int zpos)
> > >
> > > >  {
> > > >
> > > > -     u32 val, bld_base, ch_base;
> > > > +     u32 val, ch_base;
> > > >
> > > > -     bld_base =3D sun8i_blender_base(mixer);
> > > >
> > > >       ch_base =3D sun8i_channel_base(mixer, channel);
> > > >
> > > >       DRM_DEBUG_DRIVER("%sabling channel %d overlay %d\n",
> > > >
> > > > @@ -44,32 +42,7 @@ static void sun8i_ui_layer_enable(struct sun8i_m=
ixer
> > > > *mixer, int channel, SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base, overla=
y),
> > > >
> > > >                          SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN, val);
> > > >
> > > > -     if (!enable || zpos !=3D old_zpos) {
> > > > -             regmap_update_bits(mixer->engine.regs,
> > > > -
> > >
> > > SUN8I_MIXER_BLEND_PIPE_CTL(bld_base),
> > >
> > > > -
> > >
> > > SUN8I_MIXER_BLEND_PIPE_CTL_EN(old_zpos),
> > >
> > > > -                                0);
> > > > -
> > > > -             regmap_update_bits(mixer->engine.regs,
> > > > -
> > >
> > > SUN8I_MIXER_BLEND_ROUTE(bld_base),
> > >
> > > > -
> > >
> > > SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(old_zpos),
> > >
> > > > -                                0);
> > > > -     }
> > > > -
> > > > -     if (enable) {
> > > > -             val =3D SUN8I_MIXER_BLEND_PIPE_CTL_EN(zpos);
> > > > -
> > > > -             regmap_update_bits(mixer->engine.regs,
> > > > -
> > >
> > > SUN8I_MIXER_BLEND_PIPE_CTL(bld_base),
> > >
> > > > -                                val, val);
> > > > -
> > > > -             val =3D channel <<
> > >
> > > SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(zpos);
> > >
> > > > -
> > > > -             regmap_update_bits(mixer->engine.regs,
> > > > -
> > >
> > > SUN8I_MIXER_BLEND_ROUTE(bld_base),
> > >
> > > > -
> > >
> > > SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(zpos),
> > >
> > > > -                                val);
> > > > -     }
> > > > +     mixer->channel_zpos[channel] =3D enable ? zpos : -1;
> > > >
> > > >  }
> > > >
> > > >  static int sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, =
int
> > > >
> > > > channel, @@ -235,11 +208,9 @@ static void
> > > > sun8i_ui_layer_atomic_disable(struct drm_plane *plane, struct
> > > > drm_plane_state *old_state)
> > > >
> > > >  {
> > > >
> > > >       struct sun8i_ui_layer *layer =3D plane_to_sun8i_ui_layer(plan=
e);
> > > >
> > > > -     unsigned int old_zpos =3D old_state->normalized_zpos;
> > > >
> > > >       struct sun8i_mixer *mixer =3D layer->mixer;
> > > >
> > > > -     sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay,
> > >
> > > false, 0,
> > >
> > > > -                           old_zpos);
> > > > +     sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay,
> > > > false,
> > >
> > > 0);
> > >
> > > >  }
> > > >
> > > >  static void sun8i_ui_layer_atomic_update(struct drm_plane *plane,
> > > >
> > > > @@ -247,12 +218,11 @@ static void sun8i_ui_layer_atomic_update(stru=
ct
> > > > drm_plane *plane, {
> > > >
> > > >       struct sun8i_ui_layer *layer =3D plane_to_sun8i_ui_layer(plan=
e);
> > > >       unsigned int zpos =3D plane->state->normalized_zpos;
> > > >
> > > > -     unsigned int old_zpos =3D old_state->normalized_zpos;
> > > >
> > > >       struct sun8i_mixer *mixer =3D layer->mixer;
> > > >
> > > >       if (!plane->state->visible) {
> > > >
> > > >               sun8i_ui_layer_enable(mixer, layer->channel,
> > > >
> > > > -                                   layer->overlay, false, 0,
> > >
> > > old_zpos);
> > >
> > > > +                                   layer->overlay, false, 0);
> > > >
> > > >               return;
> > > >
> > > >       }
> > > >
> > > > @@ -263,7 +233,7 @@ static void sun8i_ui_layer_atomic_update(struct
> > > > drm_plane *plane, sun8i_ui_layer_update_buffer(mixer, layer->channe=
l,
> > > >
> > > >                                    layer->overlay, plane);
> > > >
> > > >       sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay,
> > > >
> > > > -                           true, zpos, old_zpos);
> > > > +                           true, zpos);
> > > >
> > > >  }
> > > >
> > > >  static struct drm_plane_helper_funcs sun8i_ui_layer_helper_funcs =
=3D {
> > > >
> > > > diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > > > b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c index
> > > > 42d445d23773..97cbc98bf781
> > > > 100644
> > > > --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > > > +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > > > @@ -17,8 +17,7 @@
> > > >
> > > >  #include "sun8i_vi_scaler.h"
> > > >
> > > >  static void sun8i_vi_layer_enable(struct sun8i_mixer *mixer, int
> > > >  channel,
> > > >
> > > > -                               int overlay, bool enable,
> > >
> > > unsigned int zpos,
> > >
> > > > -                               unsigned int old_zpos)
> > > > +                               int overlay, bool enable,
> > >
> > > unsigned int zpos)
> > >
> > > >  {
> > > >
> > > >       u32 val, bld_base, ch_base;
> > > >
> > > > @@ -37,32 +36,7 @@ static void sun8i_vi_layer_enable(struct sun8i_m=
ixer
> > > > *mixer, int channel, SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, overla=
y),
> > > >
> > > >                          SUN8I_MIXER_CHAN_VI_LAYER_ATTR_EN, val);
> > > >
> > > > -     if (!enable || zpos !=3D old_zpos) {
> > > > -             regmap_update_bits(mixer->engine.regs,
> > > > -
> > >
> > > SUN8I_MIXER_BLEND_PIPE_CTL(bld_base),
> > >
> > > > -
> > >
> > > SUN8I_MIXER_BLEND_PIPE_CTL_EN(old_zpos),
> > >
> > > > -                                0);
> > > > -
> > > > -             regmap_update_bits(mixer->engine.regs,
> > > > -
> > >
> > > SUN8I_MIXER_BLEND_ROUTE(bld_base),
> > >
> > > > -
> > >
> > > SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(old_zpos),
> > >
> > > > -                                0);
> > > > -     }
> > > > -
> > > > -     if (enable) {
> > > > -             val =3D SUN8I_MIXER_BLEND_PIPE_CTL_EN(zpos);
> > > > -
> > > > -             regmap_update_bits(mixer->engine.regs,
> > > > -
> > >
> > > SUN8I_MIXER_BLEND_PIPE_CTL(bld_base),
> > >
> > > > -                                val, val);
> > > > -
> > > > -             val =3D channel <<
> > >
> > > SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(zpos);
> > >
> > > > -
> > > > -             regmap_update_bits(mixer->engine.regs,
> > > > -
> > >
> > > SUN8I_MIXER_BLEND_ROUTE(bld_base),
> > >
> > > > -
> > >
> > > SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(zpos),
> > >
> > > > -                                val);
> > > > -     }
> > > > +     mixer->channel_zpos[channel] =3D enable ? zpos : -1;
> > > >
> > > >  }
> > > >
> > > >  static int sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, =
int
> > > >
> > > > channel, @@ -350,11 +324,9 @@ static void
> > > > sun8i_vi_layer_atomic_disable(struct drm_plane *plane, struct
> > > > drm_plane_state *old_state)
> > > >
> > > >  {
> > > >
> > > >       struct sun8i_vi_layer *layer =3D plane_to_sun8i_vi_layer(plan=
e);
> > > >
> > > > -     unsigned int old_zpos =3D old_state->normalized_zpos;
> > > >
> > > >       struct sun8i_mixer *mixer =3D layer->mixer;
> > > >
> > > > -     sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay,
> > >
> > > false, 0,
> > >
> > > > -                           old_zpos);
> > > > +     sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay,
> > > > false,
> > >
> > > 0);
> > >
> > > >  }
> > > >
> > > >  static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
> > > >
> > > > @@ -362,12 +334,11 @@ static void sun8i_vi_layer_atomic_update(stru=
ct
> > > > drm_plane *plane, {
> > > >
> > > >       struct sun8i_vi_layer *layer =3D plane_to_sun8i_vi_layer(plan=
e);
> > > >       unsigned int zpos =3D plane->state->normalized_zpos;
> > > >
> > > > -     unsigned int old_zpos =3D old_state->normalized_zpos;
> > > >
> > > >       struct sun8i_mixer *mixer =3D layer->mixer;
> > > >
> > > >       if (!plane->state->visible) {
> > > >
> > > >               sun8i_vi_layer_enable(mixer, layer->channel,
> > > >
> > > > -                                   layer->overlay, false, 0,
> > >
> > > old_zpos);
> > >
> > > > +                                   layer->overlay, false, 0);
> > > >
> > > >               return;
> > > >
> > > >       }
> > > >
> > > > @@ -378,7 +349,7 @@ static void sun8i_vi_layer_atomic_update(struct
> > > > drm_plane *plane, sun8i_vi_layer_update_buffer(mixer, layer->channe=
l,
> > > >
> > > >                                    layer->overlay, plane);
> > > >
> > > >       sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay,
> > > >
> > > > -                           true, zpos, old_zpos);
> > > > +                           true, zpos);
> > > >
> > > >  }
> > > >
> > > >  static struct drm_plane_helper_funcs sun8i_vi_layer_helper_funcs =
=3D {
>
>
>
>


--=20
Best regards,
Roman Stratiienko
Global Logic Inc.
