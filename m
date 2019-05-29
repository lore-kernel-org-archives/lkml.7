Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBF9C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06846208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9TPZUyU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfE2HW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 03:22:29 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50486 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfE2HW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 03:22:28 -0400
Received: by mail-it1-f196.google.com with SMTP id a186so2068011itg.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 00:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8PdySaW5/M3o7kkYS3QjGAsNuUlBv0LoNmhCVAMchU0=;
        b=T9TPZUyUCmcKrtg2yY2ON08nKW6RVV80EBeBttIi75vabWW44DKxbpht0xyvAoRMgj
         ibT+uaYcrnQOAnYHRcGQ/9rdZ22+IPHQ8rko9b13cMOPGQrdf19bFWgV+vIX1WhSaIIr
         8AZLnqtTgjvG/zpKo4nCO/bt1bUYKfa82foNbByK+OxrDBzpX7a9AOaYHYfT1780Tks0
         oyTkVKhs/kM2XVYHtUViPUSB3yGyqjJDlBDDO/+ZNMWPQWJkFumhaCA4WyLsauYEU18t
         LcRfvGfoZwj5me6sfb0hWOJefXLi7TqoZW2LBg4wVgW7AyjYcyL8kePaRGqDLG0BYdqu
         QTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8PdySaW5/M3o7kkYS3QjGAsNuUlBv0LoNmhCVAMchU0=;
        b=fpYYNgku7j0T3D+51DZGI09dvv8i3GGYEoqdu6Q/k3tx3aSsc2i0W+760Y/OB338C6
         T3OFY7dL5Qf0Cf9OWgbZt8E8KnAM5OH0eAtKqF1eQPGeO7gpyOBU0infMRgWtIf5tzLL
         mjpsnV+phoy46rL7ezc6/5BCLnO5RLY9IP1Z4GLhAceaLIjzcj3IoCoAsIydJH5LZvGU
         gN7KKgqca1wcfKQXBsaydVFMliu70rkpxiXwEcC7XV2n85aTAgYgcXawx4E49l6CBny4
         pBB53E+V2rlJu80NYz/Tn7PZH3FNqfM7TGZXeAVMnt2oWhAEZQEYbVMZZz0NF7+beCJx
         1QFw==
X-Gm-Message-State: APjAAAW+Ar8QTGfcQ0jkiEHKePbGP+hYJAe0KaY7iuv515M3hxbV5YmX
        j2gtnAroMvXX7cnyv825ITrHHRu+qHmULOOEGLJ3qqZPMMk=
X-Google-Smtp-Source: APXvYqxkZxQm2qtMOkWOJxLWeY/4J+xFkHGALhKS18VP9SiHIHbuR36TZL4ewm0+Z0rbmywU1DIfqoG8h1L2SB2ZUIc=
X-Received: by 2002:a24:97d2:: with SMTP id k201mr5944306ite.151.1559114547584;
 Wed, 29 May 2019 00:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190529071843.24767-1-andrew.smirnov@gmail.com>
In-Reply-To: <20190529071843.24767-1-andrew.smirnov@gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Wed, 29 May 2019 00:22:16 -0700
Message-ID: <CAHQ1cqFb2f6TvWVzwsHq=mWmheLZ82rMDjoMwgrJmyXCdqrJKw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: imx6: rdu2: Add node for UCS1002 USB
 charger chip
To:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 12:18 AM Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
>
> Add node for UCS1002 USB charger chip connected to front panel USB and
> replace "regulator-fixed" previously used to control VBUS.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Ugh, forgot to properly update reroll counter. This and the rest of
the series is a v2. Sorry about that.

Thanks,
Andrey Smirnov

> ---
>
> Changes since [v1]:
>
>     - Added GPIO hog configuration to put UCS1002 into correct mode
>       even before its driver takes over. The code for that is taken
>       from similar patch from Lucas, so I added his Signed-off-by as
>       well.
>
> [v1] lore.kernel.org/r/20190522071227.31488-1-andrew.smirnov@gmail.com
>
>  arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 77 +++++++++++++++++++------
>  1 file changed, 59 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> index 93be00a60c88..07e21d1e5b4c 100644
> --- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> @@ -60,18 +60,6 @@
>                 regulator-always-on;
>         };
>
> -       reg_5p0v_user_usb: regulator-5p0v-user-usb {
> -               compatible = "regulator-fixed";
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_reg_user_usb>;
> -               vin-supply = <&reg_5p0v_main>;
> -               regulator-name = "5V_USER_USB";
> -               regulator-min-microvolt = <5000000>;
> -               regulator-max-microvolt = <5000000>;
> -               gpio = <&gpio3 22 GPIO_ACTIVE_LOW>;
> -               startup-delay-us = <1000>;
> -       };
> -
>         reg_3p3v_pmic: regulator-3p3v-pmic {
>                 compatible = "regulator-fixed";
>                 vin-supply = <&reg_12p0v>;
> @@ -331,6 +319,39 @@
>         };
>  };
>
> +&gpio3 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_gpio3_hog>;
> +
> +       usb-emulation {
> +               gpio-hog;
> +               gpios = <19 GPIO_ACTIVE_HIGH>;
> +               output-low;
> +               line-name = "usb-emulation";
> +       };
> +
> +       usb-mode1 {
> +               gpio-hog;
> +               gpios = <20 GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name = "usb-mode1";
> +       };
> +
> +       usb-pwr {
> +               gpio-hog;
> +               gpios = <22 GPIO_ACTIVE_LOW>;
> +               output-high;
> +               line-name = "usb-pwr-ctrl-en-n";
> +       };
> +
> +       usb-mode2 {
> +               gpio-hog;
> +               gpios = <23 GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name = "usb-mode2";
> +       };
> +};
> +
>  &i2c1 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_i2c1>;
> @@ -590,6 +611,16 @@
>                 status = "disabled";
>         };
>
> +       reg_5p0v_user_usb: charger@32 {
> +               compatible = "microchip,ucs1002";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_ucs1002_pins>;
> +               reg = <0x32>;
> +               interrupts-extended = <&gpio5 2 IRQ_TYPE_EDGE_BOTH>,
> +                                     <&gpio3 21 IRQ_TYPE_EDGE_BOTH>;
> +               interrupt-names = "a_det", "alert";
> +       };
> +
>         hpa1: amp@60 {
>                 compatible = "ti,tpa6130a2";
>                 pinctrl-names = "default";
> @@ -935,6 +966,15 @@
>                 >;
>         };
>
> +       pinctrl_gpio3_hog: gpio3hoggrp {
> +               fsl,pins = <
> +                       MX6QDL_PAD_EIM_D19__GPIO3_IO19          0x1b0b0
> +                       MX6QDL_PAD_EIM_D20__GPIO3_IO20          0x1b0b0
> +                       MX6QDL_PAD_EIM_D22__GPIO3_IO22          0x1b0b0
> +                       MX6QDL_PAD_EIM_D23__GPIO3_IO23          0x1b0b0
> +               >;
> +       };
> +
>         pinctrl_i2c1: i2c1grp {
>                 fsl,pins = <
>                         MX6QDL_PAD_CSI0_DAT8__I2C1_SDA          0x4001b8b1
> @@ -982,12 +1022,6 @@
>                 >;
>         };
>
> -       pinctrl_reg_user_usb: usbotggrp {
> -               fsl,pins = <
> -                       MX6QDL_PAD_EIM_D22__GPIO3_IO22          0x40000038
> -               >;
> -       };
> -
>         pinctrl_rmii_phy_irq: phygrp {
>                 fsl,pins = <
>                         MX6QDL_PAD_EIM_D30__GPIO3_IO30          0x40010000
> @@ -1047,6 +1081,13 @@
>                 >;
>         };
>
> +       pinctrl_ucs1002_pins: ucs1002grp {
> +               fsl,pins = <
> +                       MX6QDL_PAD_EIM_A25__GPIO5_IO02          0x1b0b0
> +                       MX6QDL_PAD_EIM_D21__GPIO3_IO21          0x1b0b0
> +               >;
> +       };
> +
>         pinctrl_usdhc2: usdhc2grp {
>                 fsl,pins = <
>                         MX6QDL_PAD_SD2_CMD__SD2_CMD             0x10059
> --
> 2.21.0
>
