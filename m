Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880C3CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6CA21D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbv7Y0bi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504873AbfJYNmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 09:42:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35388 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504824AbfJYNmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:42:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id m7so2802733lji.2;
        Fri, 25 Oct 2019 06:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZRSlUd6LBzNrzynd46ONvlcqzPRdK4ulFGHewpixHno=;
        b=mbv7Y0biARyzPb/EJCakviuvn06QIZwjPvOKGlL92CvQOQ/Iy4BtFxYOrMgJ+MFBDH
         6pmFbG3RUuMa/ORC1X2mbZAjYTkwBIK9GwuQFFb2NN0b62deyS9LN5D+HnGZFFnFY2Uk
         FlJz94rvnlbcMKdQeHw1rtlgMCMK34aOizlf8KXAVtg1EB31/Lm1ckOJc0sJT7B2slIe
         3aztx+4T+0DPco7Mc1wuV4941KCORw9DZ6f0OAYgEqXWX/wJKreIdHGJbguHZTflI6ql
         dZvUwo8qB0UihBYr/gQ/M8q2UH5xQDHe1jfVrj0ZPTJe2XnzNb7M2TnakXPK2KA/Ycgg
         /uGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZRSlUd6LBzNrzynd46ONvlcqzPRdK4ulFGHewpixHno=;
        b=pnKuqxySHA1lDTTT1W2ZRfRPIh/bkAmHG7kcg7Wpm3iZDZKZ+n7ZgeToiGL3CLZaf5
         6V+cGO+sbSdFQohUymcZ+XISCX33nB/kPfm9Rk+Sm9443B1M7HdzTnIf7WLgU7o1MxOk
         +J+R7QtyYwPFqxDd/FmOeTizXA474WXI2wESxaVW7e9zX172tk3smGU3dpVcEDYvyNq+
         79SVCeBIAe0Rx2UwQFQM9/kt3eLDGlnGljWdsRfExp6Th4FjuyzyyNBlHkp+Pu+KjKT5
         vo3NHo3d6KOcvSJdSdjGVQ4KZNIXu9IEM13Wny6LGDL0PgF0BdxDjjcqz+stVisI7wEZ
         ObvQ==
X-Gm-Message-State: APjAAAUEvsRHZRbrtvVj1CY/cBNk8bZZBfqpofmaCcLYRRSDvqXTAxsQ
        DAqKc1GLoQl64eo0C6K7hMG+qjI+wRZK8esgGVs=
X-Google-Smtp-Source: APXvYqxmA+8A2DXEytTBc07CV8DHJQ2sr633xeYXjNR88vJQfKd3uRsGxawHg0NP3EBLqa36vlTpkvn303BIHXcmPqc=
X-Received: by 2002:a2e:7c13:: with SMTP id x19mr2680919ljc.0.1572010962438;
 Fri, 25 Oct 2019 06:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191025082247.3371-1-offougajoris@gmail.com>
In-Reply-To: <20191025082247.3371-1-offougajoris@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 25 Oct 2019 10:42:44 -0300
Message-ID: <CAOMZO5ChthYBiH6tLd2AyEWiKNtYGMpTjnuRxX2VP++-cnYvuQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx7d-pico: Add LCD support
To:     Joris Offouga <offougajoris@gmail.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Otavio Salvador <otavio@ossystems.com.br>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joris,

On Fri, Oct 25, 2019 at 5:22 AM Joris Offouga <offougajoris@gmail.com> wrote:
>
> Add support for the VXT VL050-8048NT-C01 panel connected through
> the 24 bit parallel LCDIF interface.
>
> Signed-off-by: Joris Offouga <offougajoris@gmail.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>

When you send someone else's patch you need to keep the original From line.

In this case it needs to be:
From: Fabio Estevam <festevam@gmail.com>

Your Signed-off-by should come as the last one, since you are one
final person submitting upstream.

Please send a v2 with these fixes.

Thanks




> ---
>  arch/arm/boot/dts/imx7d-pico.dtsi | 84 +++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
> index 6f50ebf31a0a..9042b1e6f1db 100644
> --- a/arch/arm/boot/dts/imx7d-pico.dtsi
> +++ b/arch/arm/boot/dts/imx7d-pico.dtsi
> @@ -69,6 +69,37 @@
>                 clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
>                 clock-names = "ext_clock";
>         };
> +
> +       backlight: backlight {
> +               compatible = "pwm-backlight";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_backlight>;
> +               pwms = <&pwm4 0 50000 0>;
> +               brightness-levels = <0 36 72 108 144 180 216 255>;
> +               default-brightness-level = <6>;
> +               status = "okay";
> +       };
> +
> +       reg_lcd_3v3: regulator-lcd-3v3 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "lcd-3v3";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               gpio = <&gpio1 6 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +       };
> +
> +       panel {
> +               compatible = "vxt,vl050-8048nt-c01";
> +               backlight = <&backlight>;
> +               power-supply = <&reg_lcd_3v3>;
> +
> +               port {
> +                       panel_in: endpoint {
> +                               remote-endpoint = <&display_out>;
> +                       };
> +               };
> +       };
>  };
>
>  &clks {
> @@ -230,6 +261,18 @@
>         };
>  };
>
> +&lcdif {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_lcdif>;
> +       status = "okay";
> +
> +       port {
> +               display_out: endpoint {
> +                       remote-endpoint = <&panel_in>;
> +               };
> +       };
> +};
> +
>  &sai1 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_sai1>;
> @@ -349,6 +392,13 @@
>  };
>
>  &iomuxc {
> +
> +       pinctrl_backlight: backlight {
> +               fsl,pins = <
> +                       MX7D_PAD_GPIO1_IO11__PWM4_OUT           0x0
> +               >;
> +       };
> +
>         pinctrl_ecspi3: ecspi3grp {
>                 fsl,pins = <
>                         MX7D_PAD_I2C1_SCL__ECSPI3_MISO          0x2
> @@ -413,6 +463,40 @@
>                 >;
>         };
>
> +       pinctrl_lcdif: lcdifgrp {
> +               fsl,pins = <
> +                       MX7D_PAD_LCD_DATA00__LCD_DATA0          0x79
> +                       MX7D_PAD_LCD_DATA01__LCD_DATA1          0x79
> +                       MX7D_PAD_LCD_DATA02__LCD_DATA2          0x79
> +                       MX7D_PAD_LCD_DATA03__LCD_DATA3          0x79
> +                       MX7D_PAD_LCD_DATA04__LCD_DATA4          0x79
> +                       MX7D_PAD_LCD_DATA05__LCD_DATA5          0x79
> +                       MX7D_PAD_LCD_DATA06__LCD_DATA6          0x79
> +                       MX7D_PAD_LCD_DATA07__LCD_DATA7          0x79
> +                       MX7D_PAD_LCD_DATA08__LCD_DATA8          0x79
> +                       MX7D_PAD_LCD_DATA09__LCD_DATA9          0x79
> +                       MX7D_PAD_LCD_DATA10__LCD_DATA10         0x79
> +                       MX7D_PAD_LCD_DATA11__LCD_DATA11         0x79
> +                       MX7D_PAD_LCD_DATA12__LCD_DATA12         0x79
> +                       MX7D_PAD_LCD_DATA13__LCD_DATA13         0x79
> +                       MX7D_PAD_LCD_DATA14__LCD_DATA14         0x79
> +                       MX7D_PAD_LCD_DATA15__LCD_DATA15         0x79
> +                       MX7D_PAD_LCD_DATA16__LCD_DATA16         0x79
> +                       MX7D_PAD_LCD_DATA17__LCD_DATA17         0x79
> +                       MX7D_PAD_LCD_DATA18__LCD_DATA18         0x79
> +                       MX7D_PAD_LCD_DATA19__LCD_DATA19         0x79
> +                       MX7D_PAD_LCD_DATA20__LCD_DATA20         0x79
> +                       MX7D_PAD_LCD_DATA21__LCD_DATA21         0x79
> +                       MX7D_PAD_LCD_DATA22__LCD_DATA22         0x79
> +                       MX7D_PAD_LCD_DATA23__LCD_DATA23         0x79
> +                       MX7D_PAD_LCD_CLK__LCD_CLK               0x79
> +                       MX7D_PAD_LCD_ENABLE__LCD_ENABLE         0x78
> +                       MX7D_PAD_LCD_VSYNC__LCD_VSYNC           0x78
> +                       MX7D_PAD_LCD_HSYNC__LCD_HSYNC           0x78
> +                       MX7D_PAD_LCD_RESET__GPIO3_IO4           0x14
> +               >;
> +       };
> +
>         pinctrl_pwm1: pwm1 {
>                 fsl,pins = <
>                         MX7D_PAD_GPIO1_IO08__PWM1_OUT   0x7f
> --
> 2.17.1
>
