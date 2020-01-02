Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FBEC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 16:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6572E206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 16:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="j/vKUvhd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgABQgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 11:36:43 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46941 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728812AbgABQgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 11:36:42 -0500
Received: by mail-ed1-f67.google.com with SMTP id m8so39537230edi.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 08:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eHGrpF5r5X0Jxgz+QRMxzVI+2gznTMrz/RrPo1FYHwY=;
        b=j/vKUvhdn5XJ70A8irM+VowUtg3lci4TfgSpdnbPdGeqIG+VbVhown3ELyQUEVfqvl
         nGz277Az/xc6Dd5udcl25DKNAtCoSU28DW04Och07dVa7uTp8symwuh+WKRHoyYccmDB
         on6Z0FfMij7uYp1vWe9mmYDIDAC11PtQA8ruuXs8lGn3ts1mmQdwISZ/F0pf55XsItxV
         3XHM3kAxSOhDMJ1M6OIooaBIWpw9o+7rtWHXVPPa8zwwbXdbFiPArrxZdadfWgkzIhx5
         pB2hXHiy8ZBh+LQ0/PPoSyzi/zxnlD52Rc/YiuOprgtcSVUs41cCpzng2PmtmzNNY2Pn
         aigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eHGrpF5r5X0Jxgz+QRMxzVI+2gznTMrz/RrPo1FYHwY=;
        b=beB3MwFeDsCv+W6XUu4vpqQlHhc9Fg083skeOJV+i5CBoKjaIGlcJtV6DWZ3j79pqT
         jy9AMQgwMJANkcN7dAAvQVW/C8zd/cwKkESYcCnAvkUkzUDvQTERSD0jLgYyLsbW+u6Q
         ylq2LjjUduuetLO44NS/mJJSSZeFcNvKi2VIfO6v1WtTLGk026za4oPbXOGS0uiiLeVu
         5VDDJm6xogE1emr1twAkgfDUszkLX016neaT7dPNkX7F7E86n/dhWqi/KNvHRlThc09K
         OtHtF85rvtCF85eOEzoADkuA1I6klsf3qvl5JLuPrXje/w5e8PnTmbHRgXRaHHyQMu7Y
         sl5A==
X-Gm-Message-State: APjAAAV+NmcM0T7hb/9fUakBr8MVDjeN87Cmbk9UePQ4G01PVnPtZuLn
        ul6LzbJX0KEGO0Q5wOf3KwZGRlUZeTJFhm9/FNgL1g==
X-Google-Smtp-Source: APXvYqyq/HLt8Y/l1d0gQ3r9ZA4FlgrukTV32rofiXVRw0xjeZdmo/udny3w7kdTXl4ToNDdW9vKVj0jm/EBkvx3G5g=
X-Received: by 2002:a17:906:ff01:: with SMTP id zn1mr88611764ejb.323.1577983000391;
 Thu, 02 Jan 2020 08:36:40 -0800 (PST)
MIME-Version: 1.0
References: <20200101204750.50541-1-roman.stratiienko@globallogic.com>
 <20200101204750.50541-2-roman.stratiienko@globallogic.com> <2989265.aV6nBDHxoP@jernej-laptop>
In-Reply-To: <2989265.aV6nBDHxoP@jernej-laptop>
From:   Roman Stratiienko <roman.stratiienko@globallogic.com>
Date:   Thu, 2 Jan 2020 18:36:29 +0200
Message-ID: <CAODwZ7t3JB+KMqxpFdVE11zHvLh+OrT8MrhAZ7-kFOZDjae92w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/sun4i: Use CRTC size instead of PRIMARY plane
 size as mixer frame.
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

=D1=87=D1=82, 2 =D1=8F=D0=BD=D0=B2. 2020 =D0=B3., 09:42 Jernej =C5=A0krabec=
 <jernej.skrabec@siol.net>:
>
> Hi!
>
> Dne sreda, 01. januar 2020 ob 21:47:50 CET je
> roman.stratiienko@globallogic.com napisal(a):
> > From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> >
> > According to DRM documentation the only difference between PRIMARY
> > and OVERLAY plane is that each CRTC must have PRIMARY plane and
> > OVERLAY are optional.
> >
> > Allow PRIMARY plane to have dimension different from full-screen.
> >
> > Fixes: 5bb5f5dafa1a ("drm/sun4i: Reorganize UI layer code in DE2")
> > Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
>
> This looks great now.
>
> Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>
>
> What happened to other patches in the series? It would be nice to have a =
cover
> letter for such cases, where you can explain reasons for dropped patches.
>
>
>
>

Thanks and sorry for any mistakes in procedure, I'll try to follow the
rules in the future..
Some of commits requires more time to test/deliver than others.  So
splitting it into smaller chunks helps to deliver them earlier.

>
> Best regards,
> Jernej
>
> > ---
> > v2:
> > - Split commit in 2 parts
> > - Add Fixes line to the commit message
> >
> > v3:
> > - Address review comments of v2 + removed 3 local varibles
> > - Change 'Fixes' line
> >
> > Since I've put more changes from my side, please review/sign again.
> > ---
> >  drivers/gpu/drm/sun4i/sun8i_mixer.c    | 28 ++++++++++++++++++++++++
> >  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 30 --------------------------
> >  2 files changed, 28 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > b/drivers/gpu/drm/sun4i/sun8i_mixer.c index 8b803eb903b8..658cf442c121
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > @@ -257,6 +257,33 @@ const struct de2_fmt_info *sun8i_mixer_format_info=
(u32
> > format) return NULL;
> >  }
> >
> > +static void sun8i_mode_set(struct sunxi_engine *engine,
> > +                        struct drm_display_mode *mode)
> > +{
> > +     u32 size =3D SUN8I_MIXER_SIZE(mode->crtc_hdisplay, mode-
> >crtc_vdisplay);
> > +     struct sun8i_mixer *mixer =3D engine_to_sun8i_mixer(engine);
> > +     u32 bld_base =3D sun8i_blender_base(mixer);
> > +     u32 val;
> > +
> > +     DRM_DEBUG_DRIVER("Mode change, updating global size W: %u H: %u\n=
",
> > +                      mode->crtc_hdisplay, mode->crtc_vdisplay);
> > +     regmap_write(mixer->engine.regs, SUN8I_MIXER_GLOBAL_SIZE, size);
> > +     regmap_write(mixer->engine.regs,
> > +                  SUN8I_MIXER_BLEND_OUTSIZE(bld_base), size);
> > +
> > +     if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> > +             val =3D SUN8I_MIXER_BLEND_OUTCTL_INTERLACED;
> > +     else
> > +             val =3D 0;
> > +
> > +     regmap_update_bits(mixer->engine.regs,
> > +                        SUN8I_MIXER_BLEND_OUTCTL(bld_base),
> > +                        SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
> > +                        val);
> > +     DRM_DEBUG_DRIVER("Switching display mixer interlaced mode %s\n",
> > +                      val ? "on" : "off");
> > +}
> > +
> >  static void sun8i_mixer_commit(struct sunxi_engine *engine)
> >  {
> >       DRM_DEBUG_DRIVER("Committing changes\n");
> > @@ -310,6 +337,7 @@ static struct drm_plane **sun8i_layers_init(struct
> > drm_device *drm, static const struct sunxi_engine_ops sun8i_engine_ops =
=3D {
> >       .commit         =3D sun8i_mixer_commit,
> >       .layers_init    =3D sun8i_layers_init,
> > +     .mode_set       =3D sun8i_mode_set,
> >  };
> >
> >  static struct regmap_config sun8i_mixer_regmap_config =3D {
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> > b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c index 4343ea9f8cf8..f01ac55191=
f1
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> > @@ -120,36 +120,6 @@ static int sun8i_ui_layer_update_coord(struct
> > sun8i_mixer *mixer, int channel, insize =3D SUN8I_MIXER_SIZE(src_w, src=
_h);
> >       outsize =3D SUN8I_MIXER_SIZE(dst_w, dst_h);
> >
> > -     if (plane->type =3D=3D DRM_PLANE_TYPE_PRIMARY) {
> > -             bool interlaced =3D false;
> > -             u32 val;
> > -
> > -             DRM_DEBUG_DRIVER("Primary layer, updating global size
> W: %u H: %u\n",
> > -                              dst_w, dst_h);
> > -             regmap_write(mixer->engine.regs,
> > -                          SUN8I_MIXER_GLOBAL_SIZE,
> > -                          outsize);
> > -             regmap_write(mixer->engine.regs,
> > -                          SUN8I_MIXER_BLEND_OUTSIZE(bld_base),
> outsize);
> > -
> > -             if (state->crtc)
> > -                     interlaced =3D state->crtc->state-
> >adjusted_mode.flags
> > -                             & DRM_MODE_FLAG_INTERLACE;
> > -
> > -             if (interlaced)
> > -                     val =3D SUN8I_MIXER_BLEND_OUTCTL_INTERLACED;
> > -             else
> > -                     val =3D 0;
> > -
> > -             regmap_update_bits(mixer->engine.regs,
> > -
> SUN8I_MIXER_BLEND_OUTCTL(bld_base),
> > -
> SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
> > -                                val);
> > -
> > -             DRM_DEBUG_DRIVER("Switching display mixer interlaced
> mode %s\n",
> > -                              interlaced ? "on" : "off");
> > -     }
> > -
> >       /* Set height and width */
> >       DRM_DEBUG_DRIVER("Layer source offset X: %d Y: %d\n",
> >                        state->src.x1 >> 16, state->src.y1 >> 16);
>
>
>
>
