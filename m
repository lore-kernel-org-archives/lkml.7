Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A70CC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A1721655
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Teeb0Iyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfLTMeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 07:34:11 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:38579 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbfLTMeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 07:34:11 -0500
Received: by mail-qv1-f67.google.com with SMTP id t6so3546135qvs.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 04:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OM+8DC58J3a1Ql31mcDf8DJoUej0i6n4zpuo/9t+noM=;
        b=Teeb0IyvGBgEsXC2FUlY9Jj8vaOWfLiTgSTFn2BvkRD5ZneA6TfW521uY8dyShqNmq
         kOrZnE+CrofE8hYE9gtEigmbo/3NSu3GYRTZNnzSoUB9+/tSxfmdSEHJxy3dI/yV3r+w
         vxzYMowRH3yiGAp0vJIs36MzTdgudugCMcS6nHxqNdW1vUuBSFmqQPHDx4cSYSwBiKUL
         qD+p6esS0BXk8YMffgOC9OfbCjl/Jxzhy3qS8oI9xO14xBxICze1vSxaMMqSiNQrdVBo
         GW3Y7L6dPSEg+7bQrFzoPg11otBGNXUy7zqWY991NzHmvUPAPRmmXS/JV4BqMFBM6ueF
         8itg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OM+8DC58J3a1Ql31mcDf8DJoUej0i6n4zpuo/9t+noM=;
        b=OngROYOEC8KQC6Cp9wWMEf8bkeBSECEzFppCkuFrsjCoSk6SsmXWPTq3uyO+Wr5IwU
         DWPinDFzPaOspmcSHCAIl8NKxfspXAzYzEXhfcO+gv0WdwUg1GrukgWhM27sRMXM+1i4
         dH6mShIPCTofdok50X8im5rXx5naDv8L0Ibpzz5PD52pJUMFR/wYLM1T9iqTRDAwKwvc
         Y/ZepkiGtKnBw8/St/zIybFOKtWBnIBKZrGa9ut0S5KRcsqd+eYvarY0ZVvoLp4Rtipx
         IK554ZMA7vUY46Qhaon35E6KbbbdnsUDBNmwnv0A1cRgooxvh0zSC++E0JWR4VF9LYq8
         NKMA==
X-Gm-Message-State: APjAAAVPE2IOmIiuC51XZS14Vn1Jf7itbCcUzNC0q1ZOR284mahqcex2
        FfvVvdvr3roektupAU9InsXdVlNM8r/5CkJMlA7DRw==
X-Google-Smtp-Source: APXvYqyKI5y4pA6tV7V4WabZMrtDehFiaFukF68PpW0zRcn+eFsKt3hAK4ZqwXgE6QO/xNOP1AtOUW3XIb6X2q62uSg=
X-Received: by 2002:a0c:ead1:: with SMTP id y17mr11501073qvp.210.1576845250032;
 Fri, 20 Dec 2019 04:34:10 -0800 (PST)
MIME-Version: 1.0
References: <1574850218-13257-1-git-send-email-yannick.fertre@st.com> <90e15f5b-0b65-1de7-229d-c8e0470071b5@st.com>
In-Reply-To: <90e15f5b-0b65-1de7-229d-c8e0470071b5@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Fri, 20 Dec 2019 13:33:59 +0100
Message-ID: <CA+M3ks663uFr-fpTXoKXd--yKi6q4o525H-eYM9ZsO4dpFS6yg@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: ltdc: move pinctrl to encoder mode set
To:     Philippe CORNU <philippe.cornu@st.com>
Cc:     Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
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

Le lun. 2 d=C3=A9c. 2019 =C3=A0 18:19, Philippe CORNU <philippe.cornu@st.co=
m> a =C3=A9crit :
>
> Dear Yannick,
> Thank you for your patch,
>
> Acked-by: Philippe Cornu <philippe.cornu@st.com>
>

Applied on drm-misc-next,

Thanks,
Benjamin

> Philippe :-)
>
> On 11/27/19 11:23 AM, Yannick Fertre wrote:
> > From: Yannick Fertr=C3=A9 <yannick.fertre@st.com>
> >
> > The pin control must be set to default as soon as possible to
> > establish a good video link between tv & bridge hdmi
> > (encoder mode set is call before encoder enable).
> >
> > Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
> > ---
> >   drivers/gpu/drm/stm/ltdc.c | 24 ++++++++++++++++++------
> >   1 file changed, 18 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> > index 49ef406..dba8e7f 100644
> > --- a/drivers/gpu/drm/stm/ltdc.c
> > +++ b/drivers/gpu/drm/stm/ltdc.c
> > @@ -435,9 +435,6 @@ static void ltdc_crtc_atomic_enable(struct drm_crtc=
 *crtc,
> >       /* Commit shadow registers =3D update planes at next vblank */
> >       reg_set(ldev->regs, LTDC_SRCR, SRCR_VBR);
> >
> > -     /* Enable LTDC */
> > -     reg_set(ldev->regs, LTDC_GCR, GCR_LTDCEN);
> > -
> >       drm_crtc_vblank_on(crtc);
> >   }
> >
> > @@ -451,9 +448,6 @@ static void ltdc_crtc_atomic_disable(struct drm_crt=
c *crtc,
> >
> >       drm_crtc_vblank_off(crtc);
> >
> > -     /* disable LTDC */
> > -     reg_clear(ldev->regs, LTDC_GCR, GCR_LTDCEN);
> > -
> >       /* disable IRQ */
> >       reg_clear(ldev->regs, LTDC_IER, IER_RRIE | IER_FUIE | IER_TERRIE)=
;
> >
> > @@ -1042,9 +1036,13 @@ static const struct drm_encoder_funcs ltdc_encod=
er_funcs =3D {
> >   static void ltdc_encoder_disable(struct drm_encoder *encoder)
> >   {
> >       struct drm_device *ddev =3D encoder->dev;
> > +     struct ltdc_device *ldev =3D ddev->dev_private;
> >
> >       DRM_DEBUG_DRIVER("\n");
> >
> > +     /* Disable LTDC */
> > +     reg_clear(ldev->regs, LTDC_GCR, GCR_LTDCEN);
> > +
> >       /* Set to sleep state the pinctrl whatever type of encoder */
> >       pinctrl_pm_select_sleep_state(ddev->dev);
> >   }
> > @@ -1052,6 +1050,19 @@ static void ltdc_encoder_disable(struct drm_enco=
der *encoder)
> >   static void ltdc_encoder_enable(struct drm_encoder *encoder)
> >   {
> >       struct drm_device *ddev =3D encoder->dev;
> > +     struct ltdc_device *ldev =3D ddev->dev_private;
> > +
> > +     DRM_DEBUG_DRIVER("\n");
> > +
> > +     /* Enable LTDC */
> > +     reg_set(ldev->regs, LTDC_GCR, GCR_LTDCEN);
> > +}
> > +
> > +static void ltdc_encoder_mode_set(struct drm_encoder *encoder,
> > +                               struct drm_display_mode *mode,
> > +                               struct drm_display_mode *adjusted_mode)
> > +{
> > +     struct drm_device *ddev =3D encoder->dev;
> >
> >       DRM_DEBUG_DRIVER("\n");
> >
> > @@ -1067,6 +1078,7 @@ static void ltdc_encoder_enable(struct drm_encode=
r *encoder)
> >   static const struct drm_encoder_helper_funcs ltdc_encoder_helper_func=
s =3D {
> >       .disable =3D ltdc_encoder_disable,
> >       .enable =3D ltdc_encoder_enable,
> > +     .mode_set =3D ltdc_encoder_mode_set,
> >   };
> >
> >   static int ltdc_encoder_init(struct drm_device *ddev, struct drm_brid=
ge *bridge)
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
