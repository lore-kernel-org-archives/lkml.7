Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191D8C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B4C215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MrtEnvsP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731150AbfIBJfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:35:20 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40377 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729882AbfIBJfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:35:19 -0400
Received: by mail-qk1-f196.google.com with SMTP id f10so11974816qkg.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 02:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=38YIQw9rYXVcXSnz01ylMn1XuQgT2tKgepHXTvRAlmI=;
        b=MrtEnvsPeKbpdEE6n4t+yRTgqlactOV8g1SI+5jk0ZIyXDWGDbTrfXIz12VxRvYixu
         SI8Ls/by2Tn0tT31+NYhrzpSyE5Qa9YGGnyhVIPRyvIcUhdZeF3bi3rdJehdc0tDmz98
         CTP/uleQTCSkAmNWdqVCC0BkzhNBysidHkm9VFiK2EhUzjY3+sHD3BjBFcGIETlSLr27
         i6Qiijo8rqb36DwmQYlzWbmf2lxeJ2FOYX04K4zDuxcziu8LoskVWRvp4bG8nMy1wfVs
         bPt6NY0feBStC430sECK7fDZ4b8hOSs4S7Lbxq8HXiYsTdy5BQedyRMgkTk2AqWIjazR
         8/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=38YIQw9rYXVcXSnz01ylMn1XuQgT2tKgepHXTvRAlmI=;
        b=DW7ALPRlNYHdqZihmUsWZwrhOEdLnoWxVpHQpre0FpVWAtXaxVPIoUEdaGMXKARW6v
         S0Y5yEn6d4xKVovIjQ4u8Mre6Un6IlXW/SClcqmfpOF1BtWfmJBnuiGUtdZHKGBP8119
         U44L9ruFH1F7K8tU+fFFzprgVb6mB5iW+9ROVhNiRjXZdAyN1BpaZaIQbdtfcxODFCl2
         5ZIMhcni2eGjzSHiAoQjK28OqpchSY2d867T41Zt8VHoODMCivHolp5PelKuP6DpoGO3
         mLUdH+QWJj9PWqUN0VdVSKeEODGtm1ck0TwKpvTrV5CbOcuXuPBOaymT/X/BWf7/IOmb
         9DsQ==
X-Gm-Message-State: APjAAAWQoQmM7Oe/zMkY8SqDsR8X4asH21EUct265eFE1MWffOukrCKr
        MGX8IbAD0oYX0Sey6Nh/B+V3e1CwVrb1pM6Muk85Ydk4
X-Google-Smtp-Source: APXvYqzstwtUHC+bSs9WdknmyMWA119lZrPIEt6ddRW8DWeESXgG8Thvv6/PsX8pItz2k9fLmDu/VaDOP/UcM6Gga/c=
X-Received: by 2002:a37:8547:: with SMTP id h68mr6152302qkd.219.1567416918785;
 Mon, 02 Sep 2019 02:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <1564757262-6166-1-git-send-email-yannick.fertre@st.com> <ada48bc2-ac6a-8732-9aa6-03ef1c104abf@st.com>
In-Reply-To: <ada48bc2-ac6a-8732-9aa6-03ef1c104abf@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Mon, 2 Sep 2019 11:35:07 +0200
Message-ID: <CA+M3ks6MurXFitY24Cm9jCVx8h+VxTDFARxKuqg7MmhUk58X7w@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: ltdc: add pinctrl for DPI encoder mode
To:     Philippe CORNU <philippe.cornu@st.com>
Cc:     Yannick FERTRE <yannick.fertre@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Fabrice GASNIER <fabrice.gasnier@st.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+dri-devel mailing list

Le lun. 2 sept. 2019 =C3=A0 10:47, Philippe CORNU <philippe.cornu@st.com> a=
 =C3=A9crit :
>
> Hi Yannick,
>
> On 8/2/19 4:47 PM, Yannick Fertr=C3=A9 wrote:
> > The implementation of functions encoder_enable and encoder_disable
> > make possible to control the pinctrl according to the encoder type.
> > The pinctrl must be activated only if the encoder type is DPI.
> > This helps to move the DPI-related pinctrl configuration from
> > all the panel or bridge to the LTDC dt node.
> >
> > Signed-off-by: Yannick Fertr=C3=A9 <yannick.fertre@st.com>
> > ---
> >   drivers/gpu/drm/stm/ltdc.c | 35 +++++++++++++++++++++++++++++++++++
> >   1 file changed, 35 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> > index 3ab4fbf..1c4fde0 100644
> > --- a/drivers/gpu/drm/stm/ltdc.c
> > +++ b/drivers/gpu/drm/stm/ltdc.c
> > @@ -15,6 +15,7 @@
> >   #include <linux/module.h>
> >   #include <linux/of_address.h>
> >   #include <linux/of_graph.h>
> > +#include <linux/pinctrl/consumer.h>
> >   #include <linux/platform_device.h>
> >   #include <linux/pm_runtime.h>
> >   #include <linux/reset.h>
> > @@ -1040,6 +1041,36 @@ static const struct drm_encoder_funcs ltdc_encod=
er_funcs =3D {
> >       .destroy =3D drm_encoder_cleanup,
> >   };
> >
> > +static void ltdc_encoder_disable(struct drm_encoder *encoder)
> > +{
> > +     struct drm_device *ddev =3D encoder->dev;
> > +
> > +     DRM_DEBUG_DRIVER("\n");
> > +
> > +     /* Set to sleep state the pinctrl whatever type of encoder */
> > +     pinctrl_pm_select_sleep_state(ddev->dev);
> > +}
> > +
> > +static void ltdc_encoder_enable(struct drm_encoder *encoder)
> > +{
> > +     struct drm_device *ddev =3D encoder->dev;
> > +
> > +     DRM_DEBUG_DRIVER("\n");
> > +
> > +     /*
> > +      * Set to default state the pinctrl only with DPI type.
> > +      * Others types like DSI, don't need pinctrl due to
> > +      * internal bridge (the signals do not come out of the chipset).
> > +      */
> > +     if (encoder->encoder_type =3D=3D DRM_MODE_ENCODER_DPI)
> > +             pinctrl_pm_select_default_state(ddev->dev);
> > +}
> > +
> > +static const struct drm_encoder_helper_funcs ltdc_encoder_helper_funcs=
 =3D {
> > +     .disable =3D ltdc_encoder_disable,
> > +     .enable =3D ltdc_encoder_enable,
> > +};
> > +
> >   static int ltdc_encoder_init(struct drm_device *ddev, struct drm_brid=
ge *bridge)
> >   {
> >       struct drm_encoder *encoder;
> > @@ -1055,6 +1086,8 @@ static int ltdc_encoder_init(struct drm_device *d=
dev, struct drm_bridge *bridge)
> >       drm_encoder_init(ddev, encoder, &ltdc_encoder_funcs,
> >                        DRM_MODE_ENCODER_DPI, NULL);
> >
> > +     drm_encoder_helper_add(encoder, &ltdc_encoder_helper_funcs);
> > +
> >       ret =3D drm_bridge_attach(encoder, bridge, NULL);
> >       if (ret) {
> >               drm_encoder_cleanup(encoder);
> > @@ -1280,6 +1313,8 @@ int ltdc_load(struct drm_device *ddev)
> >
> >       clk_disable_unprepare(ldev->pixel_clk);
> >
> > +     pinctrl_pm_select_sleep_state(ddev->dev);
> > +
>
> Reviewed-by: Philippe Cornu <philippe.cornu@st.com>
>
> Thanks
> Philippe :)
>
> >       pm_runtime_enable(ddev->dev);
> >
> >       return 0;
> >
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
