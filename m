Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E8AC3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 07:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C133320866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 07:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577951851;
	bh=gx42xUv6clxOQIv8CpUQeOfkg66ICi68qI7nqaGsUjA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Iyz+9hFfi+rbU+l70z9iVUTDWmAXXZEReZ8laN9a858nRaYIVoA2HbGtCJAjqheh2
	 yu+zSR5HpDosuI224M7y0OCAL+lzmEw5BCdDMqfZfLzxcBwGGCJ1SaFMj0CWNh/v+g
	 OQTCVnC3RtSR7ls8siBX1h6qlQWaeTbcz28b8BZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgABH5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 02:57:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:49558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727663AbgABH5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 02:57:30 -0500
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CE06217F4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jan 2020 07:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577951848;
        bh=gx42xUv6clxOQIv8CpUQeOfkg66ICi68qI7nqaGsUjA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GIDK4W8I0DJLfQQDIcCdx0GQPCnUGi9IMXt1KS6bHdpvzlP3EGf1AzOZ+aFFGr+Ww
         oKD37aY3ppFc4TcnDuiZAX1pSZHyb007JFnM8mpz5h7WUjpR5UiS0CBJ5rquL55OJ8
         mVu+iUhH67f5Lyhbjr6BixwclauCbmQ8UG5GZNkM=
Received: by mail-wr1-f44.google.com with SMTP id j42so38357427wrj.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 23:57:28 -0800 (PST)
X-Gm-Message-State: APjAAAXc/udDcKA7vtzGmqatDnmGazvXi0R5YYQyHAXMoILZtBAi7gwM
        0g4KgVmcF0ppNYwfXWqwhmjWF/4WP3zPwsaFrE0=
X-Google-Smtp-Source: APXvYqwTrncbHkUn10LLB1suUZuNiArnXijYHRuHYWb4puFPZ5K3QQZZGa/f4ZCKkCUh+UEHsd8stV3oTBKoh4QgYfU=
X-Received: by 2002:adf:81e3:: with SMTP id 90mr80305672wra.23.1577951846915;
 Wed, 01 Jan 2020 23:57:26 -0800 (PST)
MIME-Version: 1.0
References: <20200101204750.50541-1-roman.stratiienko@globallogic.com>
 <20200101204750.50541-2-roman.stratiienko@globallogic.com> <2989265.aV6nBDHxoP@jernej-laptop>
In-Reply-To: <2989265.aV6nBDHxoP@jernej-laptop>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Thu, 2 Jan 2020 15:57:15 +0800
X-Gmail-Original-Message-ID: <CAGb2v64nwceuBz+JLRDXD7Ji=n7Xg1QWTW=GVWAo6ZWa7zyaTA@mail.gmail.com>
Message-ID: <CAGb2v64nwceuBz+JLRDXD7Ji=n7Xg1QWTW=GVWAo6ZWa7zyaTA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/sun4i: Use CRTC size instead of PRIMARY plane
 size as mixer frame.
To:     Roman Stratiienko <roman.stratiienko@globallogic.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

Your domain has DMARC setup with the "reject" policy.

This means emails from your domain may be subsequently rejected by people
using email forwarders (such as @kernel.org) to forward to Gmail.

I suggest using another email address to send patches, or ask your IT
people to drop the policy to "quarantine", which makes the email go to
the SPAM folder instead of outright rejecting them.

ChenYu

On Thu, Jan 2, 2020 at 3:43 PM Jernej =C5=A0krabec <jernej.skrabec@siol.net=
> wrote:
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
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
