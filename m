Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EDCC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72DB2178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJbjU2Mf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389182AbfKGPkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:40:36 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46981 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730114AbfKGPkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 10:40:35 -0500
Received: by mail-lf1-f66.google.com with SMTP id 19so1920245lft.13;
        Thu, 07 Nov 2019 07:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3wfpECuF12H+DE1PZtlOEqiGcYmjEL0HWEfgaBT4lbM=;
        b=bJbjU2MfoF4N8Ri1rVIdHg4m03cNn8SW9jOhXXeQO0kuaNF5bTOtxzBq2S8NFzKBqP
         IcO351Le3xMLgl1iFeBBatrsr5reYoa+jHbcwtbD58rr0qAIr8fEtMilenNIwJnyrQV8
         sd+ikiYu0r4wz/yBI65aSBNf3EmWzm1wL7ybh3ynGl88ftf3CmwDglI+jO2IJTJmxIO9
         gOfvPtpEDb9BwNg7Ws3/69WrgaKiPX9ti0q3PTbSK/Lw5sTu+iXWHJdE9yUEOLnWU3Wd
         iigsas+K15fxkvfyafGu1jxtNiEDVX2mnkDNwrVSPLhxRYu2FRpbLtJwKiZxC9HcRmmX
         hx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3wfpECuF12H+DE1PZtlOEqiGcYmjEL0HWEfgaBT4lbM=;
        b=KXwJREQWQSpbSKirq5ke0Lmqafocc6dwSimYQo7KXtpFCp1Snn641OFMrTgxkGmqML
         D5yfcMm8oKvoiRB0NPHmOu5pVcy3BhmH1kRWF9Sp1tBJDRRgjV/JN3u+M3AxDRDPSdpX
         21oB4bn83NVtf1UfNGUFs/9SWZokd4kTMT+TNhEPhbxlTgLl9afhAsA3SDCscTQhQVV3
         UataU8xae1CSdVDvT5cZ0U8h+YewXupmzgn4bKcm80TUB3+g23gSwUBoNCgFzJ02YSRY
         l/SyE+kuYHzjCYVqAnFWtGQnULbUWnEkdmn3E+kB2DgzWE8RkBGokYcgyb0+yzLRU4YX
         hFMQ==
X-Gm-Message-State: APjAAAXYVCMcJHmsc+2+V4WSmm5qfu01nn5GX6uHJu0mjQjfw1RbiKzU
        O5aiAFxIv5mawjrewDwFQxEtZbGwiEjACiAKTK8=
X-Google-Smtp-Source: APXvYqy28CEsAIgaxf8ySUF97vlGB/pLswajdJxXB007SZ9AZuUinPdeAUK7kjTrQQ6CfPiZrS5vS5B4dWjHsnv6E7A=
X-Received: by 2002:ac2:4a8a:: with SMTP id l10mr2816632lfp.185.1573141233381;
 Thu, 07 Nov 2019 07:40:33 -0800 (PST)
MIME-Version: 1.0
References: <1573092393-26885-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1573092393-26885-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 7 Nov 2019 12:40:24 -0300
Message-ID: <CAOMZO5CiR7-YmAUggdt9rdZpNYKzQTFY5zGGGQ2k06Qc7pkg_Q@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] ARM: dts: imx6sll: Update usdhc fallback
 compatible to support HS400 mode
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        =?UTF-8?Q?S=C3=A9bastien_Szymanski?= 
        <sebastien.szymanski@armadeus.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Wed, Nov 6, 2019 at 11:08 PM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> The latest i.MX6SLL EVK board supports HS400 mode, update usdhc's

Since this is a dtsi patch, it is better not to mention a specific
board here in the commit log.

It would be better to say that unlike i.MX6SL, the i.MX6SLL SoC can
support HS400 mode, hence fsl,imx7d-usdhc should be used as compatible
string.

Regards,

Fabio Estevam
> fallback compatible to support HS400 mode by default.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No changes.
> ---
>  arch/arm/boot/dts/imx6sll.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
> index 85aa8bb..1c8101f 100644
> --- a/arch/arm/boot/dts/imx6sll.dtsi
> +++ b/arch/arm/boot/dts/imx6sll.dtsi
> @@ -698,7 +698,7 @@
>                         };
>
>                         usdhc1: mmc@2190000 {
> -                               compatible = "fsl,imx6sll-usdhc", "fsl,imx6sx-usdhc";
> +                               compatible = "fsl,imx6sll-usdhc", "fsl,imx7d-usdhc";
>                                 reg = <0x02190000 0x4000>;
>                                 interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
>                                 clocks = <&clks IMX6SLL_CLK_USDHC1>,
> @@ -712,7 +712,7 @@
>                         };
>
>                         usdhc2: mmc@2194000 {
> -                               compatible = "fsl,imx6sll-usdhc", "fsl,imx6sx-usdhc";
> +                               compatible = "fsl,imx6sll-usdhc", "fsl,imx7d-usdhc";
>                                 reg = <0x02194000 0x4000>;
>                                 interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
>                                 clocks = <&clks IMX6SLL_CLK_USDHC2>,
> @@ -726,7 +726,7 @@
>                         };
>
>                         usdhc3: mmc@2198000 {
> -                               compatible = "fsl,imx6sll-usdhc", "fsl,imx6sx-usdhc";
> +                               compatible = "fsl,imx6sll-usdhc", "fsl,imx7d-usdhc";
>                                 reg = <0x02198000 0x4000>;
>                                 interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
>                                 clocks = <&clks IMX6SLL_CLK_USDHC3>,
> --
> 2.7.4
>
