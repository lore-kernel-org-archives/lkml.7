Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587B5C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 23:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A87B204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 23:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nuDHuLBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfGRXFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 19:05:55 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34629 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbfGRXFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 19:05:54 -0400
Received: by mail-lj1-f196.google.com with SMTP id p17so28977507ljg.1;
        Thu, 18 Jul 2019 16:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fc+u6+V0LBMO4h5XjC3+9AyYfLXafLmHvtMzG1nomgE=;
        b=nuDHuLBeSmox55Zwpt89WZmzaYohhH9FkinlEQpNtCxhihDP0Ue4k9XNHhu9m8479R
         ++P446NtARkpPtEWIsbHo/HNHeRfCLKXkVbEZ9j5w0RjSFkbSv0MwvX30mgwJnn6vFpA
         glXEhwIT+9ALQyM2hwixwq43TYJ//CpQz578628ActLr0KMGFMA7MGQYInuR+XfBiddY
         XhmALJU0u6B1j1muragUyiWcgDwM2O+9/Ptk9885NoV2kiQpF0qwisdqcgiG2mtTP/CG
         8buudUtysmru6o2gtuIsf97RiLcT6Q7IHhgGaDBla8i/ZkUdXpceZwuf+3VL1nQ2A5AE
         8TJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fc+u6+V0LBMO4h5XjC3+9AyYfLXafLmHvtMzG1nomgE=;
        b=nD0YRQ+q7y/fnbsZUek5RCvZHxC9efOKdBU7DoK0cLpPDtW6z1rxHBp+F+37oV/pNy
         1Eu2YeVJGokl8oVl7fXiIg8SjUYpaaeTEYtWpUvjGuzIgEsOEO6FlwFfWSyvHWsdMM2k
         FP0JhwUdBHBZF2oxaiSKkrjOS61guZNQ46SOP8/ERv6gb/kbalDvCfwXD89dy/l2sis9
         jztAJ/ZvjvSFW0i+AjVtM6oYOaDeBgumD2FMitn8XpAAg4vkkI+vV0XuMbOId3g9i5A/
         5WCHAzyFTke81g/RoFZE+URQU1Nt10HpBKr/CuKwV0lOIPjioWtXdipt2ibpEGly5UUX
         XCMw==
X-Gm-Message-State: APjAAAXQ39o/79mRlkXSRA16z5scrsX+pYs8OlL2WR7nRCucAzfgMuxH
        aMkidWn3ZBzEOkdV5MSnqefnd+SwZbU4zTk13i4=
X-Google-Smtp-Source: APXvYqw9fdugC/jRhcwqCisAxJ+Zj0R74bzZVO+RfkYWUdEJBKRFNdFU4Am1hVUA1F3fb7boXPR58wBpFYr/AX2KEp8=
X-Received: by 2002:a2e:5dc6:: with SMTP id v67mr25865035lje.240.1563491152722;
 Thu, 18 Jul 2019 16:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190718121628.23991-1-andradanciu1997@gmail.com> <20190718121628.23991-2-andradanciu1997@gmail.com>
In-Reply-To: <20190718121628.23991-2-andradanciu1997@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 18 Jul 2019 20:05:41 -0300
Message-ID: <CAOMZO5B-9+JnbfrTWP8GTuc0VcnDDPEZq-iXGbYVx9a6O9gwRg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] arm64: dts: fsl: pico-pi: Add a device tree for
 the PICO-PI-IMX8M
To:     Andra Danciu <andradanciu1997@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, sriram.dash@nxp.com,
        Lucas Stach <l.stach@pengutronix.de>, pankaj.bansal@nxp.com,
        Ping Bai <ping.bai@nxp.com>,
        Pramod Kumar <pramod.kumar_1@nxp.com>,
        Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>,
        Richard Hu <richard.hu@technexion.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andra,

On Thu, Jul 18, 2019 at 9:16 AM Andra Danciu <andradanciu1997@gmail.com> wrote:
>
> From: Richard Hu <richard.hu@technexion.com>

Please put a few words about the board and a link to its webpage, if available.

> The current level of support yields a working console and is able to boot
> userspace from NFS or init ramdisk.
>
> Additional subsystems that are active :
>         - Ethernet
>         - USB
>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Richard Hu <richard.hu@technexion.com>
> Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile       |   1 +
>  arch/arm64/boot/dts/freescale/pico-pi-8m.dts | 417 +++++++++++++++++++++++++++
>  2 files changed, 418 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/pico-pi-8m.dts
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index c043aca66572..538422903e8a 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -26,3 +26,4 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-devkit.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-rmb3.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-zest.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
> +dtb-$(CONFIG_ARCH_MXC) += pico-pi-8m.dtb

The convention we use with imx dtbs is to put the SoC name first, so
that would become:

imx8mq-pico-pi.dtb


> +&iomuxc {

Please place iomuxc node as the last one.

> +&fec1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_fec1 &pinctrl_enet_3v3>;
> +       phy-mode = "rgmii-id";
> +       pinctrl-assert-gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;

This property does not exist.

> +       phy-handle = <&ethphy0>;
> +       fsl,magic-packet;
> +       status = "okay";
> +
> +       mdio {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               ethphy0: ethernet-phy@1 {
> +                       compatible = "ethernet-phy-ieee802.3-c22";
> +                       reg = <1>;
> +                       at803x,led-act-blind-workaround;
> +                       at803x,eee-disabled;

These two properties do not exist.

> +&i2c1 {
> +       clock-frequency = <100000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c1>;
> +       status = "okay";
> +
> +       pmic: pmic@4b {
> +               reg = <0x4b>;
> +               compatible = "rohm,bd71837";
> +               /* PMIC BD71837 PMIC_nINT GPIO1_IO12 */
> +               pinctrl-0 = <&pinctrl_pmic>;

pinctrl-names = "default" is missing

> +               gpio_intr = <&gpio1 3 GPIO_ACTIVE_LOW>;

This is not documented.

Please look at Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
for the valid bindings and also at
arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts for a
reference for adding the BD71837 support.

> +&A53_0 {
> +       operating-points = <
> +               /* kHz    uV */
> +               1500000 1000000
> +               1300000 1000000
> +               1000000 900000
> +               800000  900000

This is not needed as these operating points are already specified at
imx8mq.dtsi.
