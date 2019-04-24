Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6420C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A134420811
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SYug7tCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbfDXMaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:30:07 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43196 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDXMaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:30:07 -0400
Received: by mail-qt1-f196.google.com with SMTP id g4so578393qtq.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 05:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NX2CogWQOYKbmVq2K2TtYwKyJnHLXLCU8YLX3Iw1nc0=;
        b=SYug7tCsoV9WY+MIkMo9/DxWOnPjEgsrpp2RJpkfp7cRLo7bwhtPrREaehKLf2eHvK
         9PI4gc/0QPNlM2+ezGx9IZ/z93fkbDcV9nnT8j5xGmA8g6FEfiEjhXwqVM4LgZhpeU9L
         pcuJ3AsSp+ujN6hNog7sPQu05dJDY82Felij2es7TrpVZ4wIK9Ok3ruz/RSv/4lc5iG1
         3Frr+zr8nbZXyM3JJWxBbpJIvTUIzQor4vUC/IoHcmW73pjaN6jUWTzKUKfGq8bK2vWi
         v2DP3rJGJ5hIj2JGv9mNtx9NkvAdEGcEyX+sa97EAUxHzcRKdnTXNKEzDteF5JnNEF04
         OA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NX2CogWQOYKbmVq2K2TtYwKyJnHLXLCU8YLX3Iw1nc0=;
        b=SydG8IjBzjAY1DneQ5/Xe3hd/6jg0IkKOG1soa2Mwe3F1DcUwto5Szu6hf8UqEslSp
         9X5T4zpGOqehZuaHdkcQPhj3CSZ+rzoq3c16/IjV9FpKOMffLVa5ESwBWPuDdsoycmDO
         9QpCMunFPXvddy4DDwgSLp3pFT/URszMygzoCLLc736PGJ67Px2w9irIQwrk5ZL3nQ+C
         lfsGzwqKLM0anyHvHcVT0WB0vQB7fkAJpQyxz8sd/I8NzkKuT2ysD7wmg4A6QhDScFUB
         iCEKBrOUGGXGXMOokpWJbmrZlcwIKFZyg2mio4E18y+3M0q/AdXq7LctIC9YVC70AoBB
         GfLQ==
X-Gm-Message-State: APjAAAVlBqLK8RoBJqBpkEaWoH9nL0qHnJwI1BFqm82oJFpYg2o1KUQu
        oT5ge5w+YNPndbv4gJ/isqCZvnpUFHBpfetXgY28hQ==
X-Google-Smtp-Source: APXvYqwwz23EwzGcXb0R9ebrnLdhBz25tlYTnJ/RYRoOGaSI9pkGjtSGsx2EBGEssnAmd58bFssBt20dh3cd1Httzoo=
X-Received: by 2002:a0c:b0a5:: with SMTP id o34mr24160016qvc.42.1556109006376;
 Wed, 24 Apr 2019 05:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <1554283514-2960-1-git-send-email-yannick.fertre@st.com> <f031fc0f-ea81-1083-df7a-e7ce413d2868@st.com>
In-Reply-To: <f031fc0f-ea81-1083-df7a-e7ce413d2868@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Wed, 24 Apr 2019 14:29:55 +0200
Message-ID: <CA+M3ks4q6J1pxd2ooSU+pDssX9u_sWCMeqtT3a4YqALhtAuimA@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: ltdc: add modifier support
To:     Philippe CORNU <philippe.cornu@st.com>
Cc:     Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven. 5 avr. 2019 =C3=A0 18:32, Philippe CORNU <philippe.cornu@st.com> a =
=C3=A9crit :
>
>
>
> On 4/3/19 11:25 AM, Yannick Fertr=C3=A9 wrote:
> > Signed-off-by: Mickael Reulier <mickael.reulier@st.com>
> > Signed-off-by: Yannick Fertr=C3=A9 <yannick.fertre@st.com>
> > ---
> >   drivers/gpu/drm/stm/ltdc.c | 21 ++++++++++++++++++++-
> >   1 file changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> > index b1741a9..6fa8fbc 100644
> > --- a/drivers/gpu/drm/stm/ltdc.c
> > +++ b/drivers/gpu/drm/stm/ltdc.c
> > @@ -232,6 +232,11 @@ static const enum ltdc_pix_fmt ltdc_pix_fmt_a1[NB_=
PF] =3D {
> >       PF_ARGB4444             /* 0x07 */
> >   };
> >
> > +static const u64 ltdc_format_modifiers[] =3D {
> > +     DRM_FORMAT_MOD_LINEAR,
> > +     DRM_FORMAT_MOD_INVALID
> > +};
> > +
> >   static inline u32 reg_read(void __iomem *base, u32 reg)
> >   {
> >       return readl_relaxed(base + reg);
> > @@ -864,6 +869,16 @@ static void ltdc_plane_atomic_print_state(struct d=
rm_printer *p,
> >       fpsi->counter =3D 0;
> >   }
> >
> > +static bool ltdc_plane_format_mod_supported(struct drm_plane *plane,
> > +                                         u32 format,
> > +                                         u64 modifier)
> > +{
> > +     if (modifier =3D=3D DRM_FORMAT_MOD_LINEAR)
> > +             return true;
> > +
> > +     return false;
> > +}
> > +
> >   static const struct drm_plane_funcs ltdc_plane_funcs =3D {
> >       .update_plane =3D drm_atomic_helper_update_plane,
> >       .disable_plane =3D drm_atomic_helper_disable_plane,
> > @@ -872,6 +887,7 @@ static const struct drm_plane_funcs ltdc_plane_func=
s =3D {
> >       .atomic_duplicate_state =3D drm_atomic_helper_plane_duplicate_sta=
te,
> >       .atomic_destroy_state =3D drm_atomic_helper_plane_destroy_state,
> >       .atomic_print_state =3D ltdc_plane_atomic_print_state,
> > +     .format_mod_supported =3D ltdc_plane_format_mod_supported,
> >   };
> >
> >   static const struct drm_plane_helper_funcs ltdc_plane_helper_funcs =
=3D {
> > @@ -890,6 +906,7 @@ static struct drm_plane *ltdc_plane_create(struct d=
rm_device *ddev,
> >       unsigned int i, nb_fmt =3D 0;
> >       u32 formats[NB_PF * 2];
> >       u32 drm_fmt, drm_fmt_no_alpha;
> > +     const u64 *modifiers =3D ltdc_format_modifiers;
> >       int ret;
> >
> >       /* Get supported pixel formats */
> > @@ -918,7 +935,7 @@ static struct drm_plane *ltdc_plane_create(struct d=
rm_device *ddev,
> >
> >       ret =3D drm_universal_plane_init(ddev, plane, possible_crtcs,
> >                                      &ltdc_plane_funcs, formats, nb_fmt=
,
> > -                                    NULL, type, NULL);
> > +                                    modifiers, type, NULL);
> >       if (ret < 0)
> >               return NULL;
> >
> > @@ -1179,6 +1196,8 @@ int ltdc_load(struct drm_device *ddev)
> >               goto err;
> >       }
> >
> > +     ddev->mode_config.allow_fb_modifiers =3D true;
> > +
>
>
> Acked-by: Philippe Cornu <philippe.cornu@st.com>
>

Applied on drm-misc-next even if I got issue with the author name encoding

Thanks,
Benjamin

> Philippe :)
>
> >       ret =3D ltdc_crtc_init(ddev, crtc);
> >       if (ret) {
> >               DRM_ERROR("Failed to init crtc\n");
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
