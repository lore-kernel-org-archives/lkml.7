Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D226BC00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F5221924
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vrZnv+PS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389853AbfIIJdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 05:33:10 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38027 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbfIIJdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 05:33:10 -0400
Received: by mail-qk1-f196.google.com with SMTP id x5so12372570qkh.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 02:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2tHmH1stIAhWci8qIBPtmNf+VD11DJ+UCL9f9Y17abo=;
        b=vrZnv+PStMf+ECSwAA9EBVmkJ1p3GaWvYFKNeMG3Owov4IHFuOEVR00hBZEXUYgKSh
         OieKMKPXAWSyeWC/HP+/8QjHPAQdr34fWMdBDb4EyrTrZzcaWm+bFSXF8/i1Qu+HEiyz
         CKq1XWiDER91AclIs00Rtj003JXkH1Eu9Ku5Gq5DOUvFkeqvW6kHPWF61Px47znWI9K1
         S/swfW3z34aw9icDEOL4KLxAVFXkRZCd61hfEJTlf//onBcY4c/nTKxMTOkbTn4T4qAu
         gUry9EPHH1pj8bML9BWQUN4v2UvpiQKwO3J3lFPxgg0Hq0i2zXZ1H1fYb9CNTHuZvNPo
         y/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2tHmH1stIAhWci8qIBPtmNf+VD11DJ+UCL9f9Y17abo=;
        b=COWxtEvjA0YPKz+70GirymX69Q65pd9NT1Y45CeDZubEP4AMzI4ZqQhMEkogUnJSMi
         T9mNHp/OzeNoGohaKc6AODmupeNK5admjkFakdXLXZA/SwfjAdUap1ej8AGwsuL6z5gK
         q9o29H719w4/n2iVZljz1Oc01yP6m7u9Iz8H5zA49YZCgJWO2NLZ8SOJs+jBFE2cYEJg
         4LK1yoMsA8p6h5jsMqAz0pK6OxYYmSs9kGIynsG5MLuuBC0zDNFTKcQalIfy9TdbV4bI
         dGGsBY/QTBofSgPJxdjCPZQAz12/oil35PPHoWL6Sl+75a60xR6WRRIyGLI/bnRFIcxy
         gfrw==
X-Gm-Message-State: APjAAAUH3kqU7nRnvsuDxL6afyntt5Ij11V4KXMkfl4BXEWGZ0EcJjoE
        hNJXWZUoMkZc5fM7CICF5C530rWXDrNVPb/C3AOycg==
X-Google-Smtp-Source: APXvYqyJ2skoDsCxCcviaFJEdYxXi0/LKrzEr6iBfeSawT0Q0tTImcnSBrPILhJzLyjKObBRKhPopIxIjwlVAoBadOo=
X-Received: by 2002:ae9:dd81:: with SMTP id r123mr6813864qkf.103.1568021588009;
 Mon, 09 Sep 2019 02:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <1567761708-31777-1-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1567761708-31777-1-git-send-email-yannick.fertre@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Mon, 9 Sep 2019 11:32:57 +0200
Message-ID: <CA+M3ks6MQBScJ4mOY3VD-OTP-wG2VfSLMxA-9z6ZkNAeO53SMA@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: ltdc: add pinctrl for DPI encoder mode
To:     =?UTF-8?Q?Yannick_Fertr=C3=A9?= <yannick.fertre@st.com>
Cc:     Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven. 6 sept. 2019 =C3=A0 11:22, Yannick Fertr=C3=A9 <yannick.fertre@st.c=
om> a =C3=A9crit :
>
> The implementation of functions encoder_enable and encoder_disable
> make possible to control the pinctrl according to the encoder type.
> The pinctrl must be activated only if the encoder type is DPI.
> This helps to move the DPI-related pinctrl configuration from
> all the panel or bridge to the LTDC dt node.
>
> Reviewed-by: Philippe Cornu <philippe.cornu@st.com>
>
> Signed-off-by: Yannick Fertr=C3=A9 <yannick.fertre@st.com>

Applied on drm-misc-next,
Thanks,
Benjamin

> ---
>  drivers/gpu/drm/stm/ltdc.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index 3ab4fbf..1c4fde0 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/of_graph.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
> @@ -1040,6 +1041,36 @@ static const struct drm_encoder_funcs ltdc_encoder=
_funcs =3D {
>         .destroy =3D drm_encoder_cleanup,
>  };
>
> +static void ltdc_encoder_disable(struct drm_encoder *encoder)
> +{
> +       struct drm_device *ddev =3D encoder->dev;
> +
> +       DRM_DEBUG_DRIVER("\n");
> +
> +       /* Set to sleep state the pinctrl whatever type of encoder */
> +       pinctrl_pm_select_sleep_state(ddev->dev);
> +}
> +
> +static void ltdc_encoder_enable(struct drm_encoder *encoder)
> +{
> +       struct drm_device *ddev =3D encoder->dev;
> +
> +       DRM_DEBUG_DRIVER("\n");
> +
> +       /*
> +        * Set to default state the pinctrl only with DPI type.
> +        * Others types like DSI, don't need pinctrl due to
> +        * internal bridge (the signals do not come out of the chipset).
> +        */
> +       if (encoder->encoder_type =3D=3D DRM_MODE_ENCODER_DPI)
> +               pinctrl_pm_select_default_state(ddev->dev);
> +}
> +
> +static const struct drm_encoder_helper_funcs ltdc_encoder_helper_funcs =
=3D {
> +       .disable =3D ltdc_encoder_disable,
> +       .enable =3D ltdc_encoder_enable,
> +};
> +
>  static int ltdc_encoder_init(struct drm_device *ddev, struct drm_bridge =
*bridge)
>  {
>         struct drm_encoder *encoder;
> @@ -1055,6 +1086,8 @@ static int ltdc_encoder_init(struct drm_device *dde=
v, struct drm_bridge *bridge)
>         drm_encoder_init(ddev, encoder, &ltdc_encoder_funcs,
>                          DRM_MODE_ENCODER_DPI, NULL);
>
> +       drm_encoder_helper_add(encoder, &ltdc_encoder_helper_funcs);
> +
>         ret =3D drm_bridge_attach(encoder, bridge, NULL);
>         if (ret) {
>                 drm_encoder_cleanup(encoder);
> @@ -1280,6 +1313,8 @@ int ltdc_load(struct drm_device *ddev)
>
>         clk_disable_unprepare(ldev->pixel_clk);
>
> +       pinctrl_pm_select_sleep_state(ddev->dev);
> +
>         pm_runtime_enable(ddev->dev);
>
>         return 0;
> --
> 2.7.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
