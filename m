Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49EAC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF2920873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUXgpcZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbfFRUS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 16:18:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38654 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbfFRUS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 16:18:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id s15so4557084wmj.3;
        Tue, 18 Jun 2019 13:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LTMdBP8eCUfHjffwbb75FXDn3anqE4Gx9Xs6BmZvRK4=;
        b=PUXgpcZPRsO9lRHA4KBsCleQ6lOorgPUrU1TbIh57xC/sGQKKDDOHjf1Og4r0T8PS3
         4FfSGLxiKCQCnLWeOyz0+c86/6FMTGN15JmfgeTESNaDSLbgZ7F5FZi1kzI3ajLKLtw2
         DEyItfEeTzojaeEGTTVLxf1UtJ6iOR2DuaoRx6Beigh51xKc0IbKjvE/GNRtuHEzTDDC
         A3bA60KzjBJfAv4iQ2ydEp9Qs4ofjbiBxumAskwSn4HOSQbGjH0h11WHc3v1AFTsd368
         PKTIX8FhEsJ3rqzXoy+heHkSsVjcRQAQV0nPENg3+euHl3apWsHwM/aJ99Wlf5fM5Fj2
         bv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LTMdBP8eCUfHjffwbb75FXDn3anqE4Gx9Xs6BmZvRK4=;
        b=cyO3S1dxdBfUd14lbNYHSGAGMXcZVafS3YswxdV+6Jw/uOgzHH+ABDjFF9mVZ7gKJq
         qvUcfSUylg/VzYwKIVj/Dcerb625xRgxr/Dv+qs3VmxAtVBvTc5xUVPlj8pgnapKB/mA
         oQ7fu6yX2+Zo9zdnE/3YvjYG1p12yvyE5XI3xn78PxB8PqkRC5wxjKTOOVpUhzdxWliV
         4VJoU7+oB5968aizxf/qJpgQu8DrXaFEvNyeeZdBZn2kKy2TOP46/unf6NL2uOZ19oPi
         Ak2Pt7clpiCDTP7HK/PCV6wNxtQ8RROzltDaifakQy5SByLbcE89VTM/4sOb174xvEYV
         ygLw==
X-Gm-Message-State: APjAAAXJIackY6NCmruS2hO7EKa+NbOHk671nTgpKz/npocKJ1aOz1QV
        DsY2PsvOyBLD3FGTw+tKRjmewFtpEemURGE4EVQ=
X-Google-Smtp-Source: APXvYqz1tLKUdFmkDYrn9GXuqjoehYxC5kr689Ke/bt0PzSYLe7IGleSGeQWVzCscTngOGlquK82tRYJAViCEDOCqHg=
X-Received: by 2002:a7b:c051:: with SMTP id u17mr3115442wmc.25.1560889136270;
 Tue, 18 Jun 2019 13:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190604123257.2920-1-daniel.baluta@nxp.com> <20190604123257.2920-3-daniel.baluta@nxp.com>
In-Reply-To: <20190604123257.2920-3-daniel.baluta@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 18 Jun 2019 23:18:44 +0300
Message-ID: <CAEnQRZDhh-NiYhS6=t=URqA0Yn4=HdL2xXCci_AmqdUgU=8kkw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: imx8mm-evk: Enable audio codec wm8524
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn,

Care to have a look at this? git send-email should correctly work now.

Let me know if you want me to resend

On Tue, Jun 4, 2019 at 3:34 PM <daniel.baluta@nxp.com> wrote:
>
> From: Daniel Baluta <daniel.baluta@nxp.com>
>
> i.MX8MM has one wm8524 audio codec connected with
> SAI3 digital audio interface.
>
> This patch uses simple-card machine driver in order
> to enable wm8524 codec.
>
> We need to set:
>         * SAI3 pinctrl configuration
>         * codec reset gpio pinctrl configuration
>         * clock hierarchy
>         * codec node
>         * simple-card configuration
>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dts | 55 ++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> index f8ff0a4b8961..7d2ec0326659 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> @@ -37,6 +37,37 @@
>                 gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
>                 enable-active-high;
>         };
> +
> +       wm8524: audio-codec {
> +               #sound-dai-cells = <0>;
> +               compatible = "wlf,wm8524";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_gpio_wlf>;
> +               wlf,mute-gpios = <&gpio5 21 GPIO_ACTIVE_LOW>;
> +       };
> +
> +       sound-wm8524 {
> +               compatible = "simple-audio-card";
> +               simple-audio-card,name = "wm8524-audio";
> +               simple-audio-card,format = "i2s";
> +               simple-audio-card,frame-master = <&cpudai>;
> +               simple-audio-card,bitclock-master = <&cpudai>;
> +               simple-audio-card,widgets =
> +                       "Line", "Left Line Out Jack",
> +                       "Line", "Right Line Out Jack";
> +               simple-audio-card,routing =
> +                       "Left Line Out Jack", "LINEVOUTL",
> +                       "Right Line Out Jack", "LINEVOUTR";
> +
> +               cpudai: simple-audio-card,cpu {
> +                       sound-dai = <&sai3>;
> +               };
> +
> +               simple-audio-card,codec {
> +                       sound-dai = <&wm8524>;
> +                       clocks = <&clk IMX8MM_CLK_SAI3_ROOT>;
> +               };
> +       };
>  };
>
>  &A53_0 {
> @@ -65,6 +96,15 @@
>         };
>  };
>
> +&sai3 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_sai3>;
> +       assigned-clocks = <&clk IMX8MM_CLK_SAI3>;
> +       assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
> +       assigned-clock-rates = <24576000>;
> +       status = "okay";
> +};
> +
>  &uart2 { /* console */
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_uart2>;
> @@ -242,6 +282,12 @@
>                 >;
>         };
>
> +       pinctrl_gpio_wlf: gpiowlfgrp {
> +               fsl,pins = <
> +                       MX8MM_IOMUXC_I2C4_SDA_GPIO5_IO21        0xd6
> +               >;
> +       };
> +
>         pinctrl_i2c1: i2c1grp {
>                 fsl,pins = <
>                         MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL                  0x400001c3
> @@ -261,6 +307,15 @@
>                 >;
>         };
>
> +       pinctrl_sai3: sai3grp {
> +               fsl,pins = <
> +                       MX8MM_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC     0xd6
> +                       MX8MM_IOMUXC_SAI3_TXC_SAI3_TX_BCLK      0xd6
> +                       MX8MM_IOMUXC_SAI3_MCLK_SAI3_MCLK        0xd6
> +                       MX8MM_IOMUXC_SAI3_TXD_SAI3_TX_DATA0     0xd6
> +               >;
> +       };
> +
>         pinctrl_uart2: uart2grp {
>                 fsl,pins = <
>                         MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX     0x140
> --
> 2.17.1
>
