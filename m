Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F6BC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8244920879
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lQncQYni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfEQKOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 06:14:30 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40702 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfEQKOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 06:14:30 -0400
Received: by mail-qk1-f194.google.com with SMTP id q197so4092887qke.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 03:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c2AcJv21LbYCYD5C9Jjpp5BCKygW6luQM6iJ5dPZwlA=;
        b=lQncQYniggfzZ8LMfFNfPm8ZuE9Yt7gKDDYK2B1lpPhyV0V6lMzqpbaJnQQp9ken6D
         UviiUJLEW8Gn9oGUMRErMd2XDMk4cD2cIXOlUyk1MWyWe6ANmXrTTy4ouKnfbOXcG5uS
         +Hy1nXkwnLFxZFjtaTK4ro37s4NKGxt9bLqVgAfiW3Aa3k1qc/PsbbbOasjpV4v0oR2a
         pApLyVKvEFTZfCT8grgONhlyTFBToshHNZ4SxDANwweiL75sUBT/jtj909UDHI2KChbW
         xs9DFoJ+I3YDX1Gke7gHMGY5rKN7j/jTJHi+kY7D4GikXNTi+wQuwadOU9+JivSXorW5
         BUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c2AcJv21LbYCYD5C9Jjpp5BCKygW6luQM6iJ5dPZwlA=;
        b=dtcbXIfUWtoMfYzkxN5g9K5BIhrmFsan6rjkLkfBUYjPjM8slczrapto77wfOPwLos
         y6Cvp3+US23loyP1H8yyHVJ6s5N0SwkjvsJUsrjvgo/BN3Q7bt8nOsIBUHfDSFP9/Axc
         JJbRkKxzwFZ6PA5qiQzIFedEhFOUFVGSgo87g6emiH7Xct8C5vI2uFzrLKBUKqu58FpX
         96m+9pxyTpTs+2+KMPONeyGrpODJI3lI4QDpQEZPo0bZR/H6fukV3VsFOGiu2V8Meyii
         HVuP5Oha0mnpKtrh8ujgWEEU2/EMPnQO0EdFcKQL2I4MDptWgLHQ3p6ReZO01t813hgy
         Ytow==
X-Gm-Message-State: APjAAAUHIwPZACbuA4vV2bVaRmBMAzs98aJOdDaxtZ+dSv6DXNd+CeCD
        zZCja8bnukm+4/Hz1RxwAU+RPB43W5gZhyKaD0OPsQ==
X-Google-Smtp-Source: APXvYqxVWn2bvh4TLQU8hA7wU5xUDlGjdTmy4QhvkCVnfiI9qFaHAIv4QUUclL6iglzysUdQhZdbFUDPdGhnmrBs0bA=
X-Received: by 2002:a37:a555:: with SMTP id o82mr22147311qke.93.1558088068450;
 Fri, 17 May 2019 03:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <1557826556-10079-1-git-send-email-yannick.fertre@st.com> <1557826556-10079-3-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1557826556-10079-3-git-send-email-yannick.fertre@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Fri, 17 May 2019 12:14:17 +0200
Message-ID: <CA+M3ks5hQnqdLxefcCskmNJTw4FeXEgWp=8mUhm7y0JSR4vsKQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/stm: dsi: add regulator support
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

Le mar. 14 mai 2019 =C3=A0 11:36, Yannick Fertr=C3=A9 <yannick.fertre@st.co=
m> a =C3=A9crit :
>
> Add support of regulator for the phy part of the DSI
> controller.
>
> Signed-off-by: Yannick Fertr=C3=A9 <yannick.fertre@st.com>
> Acked-by: Philippe Cornu <philippe.cornu@st.com>
Applied on drm-misc-next,

Thanks,
Benjamin

> ---
>  drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 60 ++++++++++++++++++++++++++++-=
------
>  1 file changed, 49 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/stm/=
dw_mipi_dsi-stm.c
> index 1bef73e..d8e4a14 100644
> --- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> +++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> @@ -9,6 +9,7 @@
>  #include <linux/clk.h>
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
> +#include <linux/regulator/consumer.h>
>  #include <drm/drmP.h>
>  #include <drm/drm_mipi_dsi.h>
>  #include <drm/bridge/dw_mipi_dsi.h>
> @@ -76,6 +77,7 @@ struct dw_mipi_dsi_stm {
>         u32 hw_version;
>         int lane_min_kbps;
>         int lane_max_kbps;
> +       struct regulator *vdd_supply;
>  };
>
>  static inline void dsi_write(struct dw_mipi_dsi_stm *dsi, u32 reg, u32 v=
al)
> @@ -314,21 +316,36 @@ static int dw_mipi_dsi_stm_probe(struct platform_de=
vice *pdev)
>         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         dsi->base =3D devm_ioremap_resource(dev, res);
>         if (IS_ERR(dsi->base)) {
> -               DRM_ERROR("Unable to get dsi registers\n");
> -               return PTR_ERR(dsi->base);
> +               ret =3D PTR_ERR(dsi->base);
> +               DRM_ERROR("Unable to get dsi registers %d\n", ret);
> +               return ret;
> +       }
> +
> +       dsi->vdd_supply =3D devm_regulator_get(dev, "phy-dsi");
> +       if (IS_ERR(dsi->vdd_supply)) {
> +               ret =3D PTR_ERR(dsi->vdd_supply);
> +               if (ret !=3D -EPROBE_DEFER)
> +                       DRM_ERROR("Failed to request regulator: %d\n", re=
t);
> +               return ret;
> +       }
> +
> +       ret =3D regulator_enable(dsi->vdd_supply);
> +       if (ret) {
> +               DRM_ERROR("Failed to enable regulator: %d\n", ret);
> +               return ret;
>         }
>
>         dsi->pllref_clk =3D devm_clk_get(dev, "ref");
>         if (IS_ERR(dsi->pllref_clk)) {
>                 ret =3D PTR_ERR(dsi->pllref_clk);
> -               dev_err(dev, "Unable to get pll reference clock: %d\n", r=
et);
> -               return ret;
> +               DRM_ERROR("Unable to get pll reference clock: %d\n", ret)=
;
> +               goto err_clk_get;
>         }
>
>         ret =3D clk_prepare_enable(dsi->pllref_clk);
>         if (ret) {
> -               dev_err(dev, "%s: Failed to enable pllref_clk\n", __func_=
_);
> -               return ret;
> +               DRM_ERROR("Failed to enable pllref_clk: %d\n", ret);
> +               goto err_clk_get;
>         }
>
>         dw_mipi_dsi_stm_plat_data.base =3D dsi->base;
> @@ -338,20 +355,28 @@ static int dw_mipi_dsi_stm_probe(struct platform_de=
vice *pdev)
>
>         dsi->dsi =3D dw_mipi_dsi_probe(pdev, &dw_mipi_dsi_stm_plat_data);
>         if (IS_ERR(dsi->dsi)) {
> -               DRM_ERROR("Failed to initialize mipi dsi host\n");
> -               clk_disable_unprepare(dsi->pllref_clk);
> -               return PTR_ERR(dsi->dsi);
> +               ret =3D PTR_ERR(dsi->dsi);
> +               DRM_ERROR("Failed to initialize mipi dsi host: %d\n", ret=
);
> +               goto err_dsi_probe;
>         }
>
>         return 0;
> +
> +err_dsi_probe:
> +       clk_disable_unprepare(dsi->pllref_clk);
> +err_clk_get:
> +       regulator_disable(dsi->vdd_supply);
> +
> +       return ret;
>  }
>
>  static int dw_mipi_dsi_stm_remove(struct platform_device *pdev)
>  {
>         struct dw_mipi_dsi_stm *dsi =3D platform_get_drvdata(pdev);
>
> -       clk_disable_unprepare(dsi->pllref_clk);
>         dw_mipi_dsi_remove(dsi->dsi);
> +       clk_disable_unprepare(dsi->pllref_clk);
> +       regulator_disable(dsi->vdd_supply);
>
>         return 0;
>  }
> @@ -363,6 +388,7 @@ static int __maybe_unused dw_mipi_dsi_stm_suspend(str=
uct device *dev)
>         DRM_DEBUG_DRIVER("\n");
>
>         clk_disable_unprepare(dsi->pllref_clk);
> +       regulator_disable(dsi->vdd_supply);
>
>         return 0;
>  }
> @@ -370,10 +396,22 @@ static int __maybe_unused dw_mipi_dsi_stm_suspend(s=
truct device *dev)
>  static int __maybe_unused dw_mipi_dsi_stm_resume(struct device *dev)
>  {
>         struct dw_mipi_dsi_stm *dsi =3D dw_mipi_dsi_stm_plat_data.priv_da=
ta;
> +       int ret;
>
>         DRM_DEBUG_DRIVER("\n");
>
> -       clk_prepare_enable(dsi->pllref_clk);
> +       ret =3D regulator_enable(dsi->vdd_supply);
> +       if (ret) {
> +               DRM_ERROR("Failed to enable regulator: %d\n", ret);
> +               return ret;
> +       }
> +
> +       ret =3D clk_prepare_enable(dsi->pllref_clk);
> +       if (ret) {
> +               regulator_disable(dsi->vdd_supply);
> +               DRM_ERROR("Failed to enable pllref_clk: %d\n", ret);
> +               return ret;
> +       }
>
>         return 0;
>  }
> --
> 2.7.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
