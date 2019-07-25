Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62382C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D44921901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUySh5ls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfGYOHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:07:36 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46299 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfGYOHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:07:36 -0400
Received: by mail-lf1-f68.google.com with SMTP id z15so30353739lfh.13;
        Thu, 25 Jul 2019 07:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rC7CJ3Us0JHdnFwo5M1FbCnSzpf/yZ4Z3VE1tDizNCA=;
        b=rUySh5lsYoDX6So5KaiKnCykcehQFNsmsNlgnnSGBL4Nq6j0qUO7iAkhwwqjWSWmhC
         zemDKCKpV6ugv6dVkspNpL4nf+cI2rpoOpGuCp/zAJosNgXUqF2WZHOFnWftSu5MagJv
         JNxYhLjW7sSE03ic4ibRUdrhd6i1gdOBeIZudZlLTvcuoxflzCua91YhbITRAn5VW/Ow
         P2Q/VAyIphqfLYs5ZlqOUZ3wVimx7WC6C6Eq3fJ3JpqNIY1ELqwI51uAOdGF1snVBn5N
         l6MkTgRLMYzfpXo386oWBP7CIpUxEPWqdkqIlncILwrny8r+LrIPKKUn1K7sYk6kZmX6
         JahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rC7CJ3Us0JHdnFwo5M1FbCnSzpf/yZ4Z3VE1tDizNCA=;
        b=eTbpduCXUWjFDQxdX0z8SKSqSYncCuCl8kwVfsKfD+rIa85PFJLxHOHTxSAeROrLPV
         +lH3qo6WNdkt8yOsQhWaQYVXoorhvXZEv/SyjwJ7Td+FImpSB96sYWEzCkzxsQcjhXjg
         JJPVAx8qzEXd9W+seU5VgGHWafvbSAcWKFUpoP1eju4x5KqK573kHxWDQByDvnn9Lq1v
         uyyI4p9Y4mzRkMrIT8fO1S6unO8nZMcmR8GksSTJ1On5ZoNSnktCHFkYZsADewOjITYR
         yY2WUq7UDTge83vhZj//QEVcvs2wkPP53nlODrvpnbIFslpmA+IjI75Do04dhGJAU5/W
         h77w==
X-Gm-Message-State: APjAAAWFUVUQMIFS/VVnklJrdOGRM6D/2TFlCVTaxInLia4AEDnVkHhF
        1XgHIHxQd4iTOJdy93c4dE3yJl+3g2grVv8YnN4=
X-Google-Smtp-Source: APXvYqybVQQ6LELvat6wI1HX6srPrUA8LGsWE6tcmgtfjJZ13dyU1yiUAYM5W7zhul+DXGPFfOjwvdPhUuNASVk2vLo=
X-Received: by 2002:a19:6e41:: with SMTP id q1mr31289910lfk.20.1564063653383;
 Thu, 25 Jul 2019 07:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190724171747.26076-1-dafna.hirschfeld@collabora.com>
In-Reply-To: <20190724171747.26076-1-dafna.hirschfeld@collabora.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 25 Jul 2019 11:07:34 -0300
Message-ID: <CAOMZO5AJwocYFaKtUBZbo0NareGmdAySwDjouxh5KMvnGz2o0A@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: imx: Add i.mx8mq nitrogen8m basic dts support
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Ezequiel Garcia <ezequiel@collabora.com>, kernel@collabora.com,
        Gary Bisson <gary.bisson@boundarydevices.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dafna,

On Wed, Jul 24, 2019 at 2:51 PM Dafna Hirschfeld
<dafna.hirschfeld@collabora.com> wrote:
>
> From: dafna <dafna.hirschfeld@collabora.com>
>
> Add basic dts support for i.MX8MQ NITROGEN8M.
>
> Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

Your From and Signed-off-by tags do not match.

> ---
>  arch/arm64/boot/dts/freescale/Makefile             |   1 +
>  .../arm64/boot/dts/freescale/imx8mq-nitrogen8m.dts | 411 +++++++++++++++++++++
>  2 files changed, 412 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-nitrogen8m.dts
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index c043aca66572..54a5c18c5c30 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -26,3 +26,4 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-devkit.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-rmb3.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-zest.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mq-nitrogen8m.dtb

Please keep it in alphabetical order.

> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen8m.dts b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen8m.dts
> new file mode 100644
> index 000000000000..cfd4915d2916
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen8m.dts

Isn't the 8m in the end redundant? What about just naming it
imx8mq-nitrogen.dts instead?

> +&a53_opp_table {
> +               opp-1500000000 {
> +                       opp-hz = /bits/ 64 <1500000000>;
> +                       opp-microvolt = <1000000>;
> +               };
> +
> +               opp-1000000000 {
> +                       opp-hz = /bits/ 64 <1000000000>;
> +                       opp-microvolt = <900000>;
> +               };

Couldn't this be dropped and just use the operational points defined
at imx8mq.dtsi?

> +};
> +
> +&iomuxc {

We usually prefer to place iomux as the last node.

> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_hog>;

You could place the "pinctrl_hog: hoggrp {" here

> +&i2c1 {
> +       clock-frequency = <400000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c1>;
> +       status = "okay";
> +
> +       i2cmux@70 {
> +               compatible = "pca9546";

You missed the manufacturer string: "nxp,pca9546"

> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_i2c1_pca9546>;
> +               reg = <0x70>;
> +               reset-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               i2c1a: i2c1@0 {
> +                       reg = <0>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg_arm_dram: fan53555@60 {

Node names should be generic:

regulator@60

> +                               compatible = "fcs,fan53555";
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&pinctrl_reg_arm_dram>;
> +                               reg = <0x60>;
> +                               regulator-min-microvolt =  <900000>;
> +                               regulator-max-microvolt = <1000000>;
> +                               regulator-always-on;
> +                               vsel-gpios = <&gpio3 24 GPIO_ACTIVE_HIGH>;
> +                       };
> +               };
> +
> +               i2c1b: i2c1@1 {
> +                       reg = <1>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg_dram_1p1v: fan53555@60 {

regulator@60

> +                               compatible = "fcs,fan53555";
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&pinctrl_reg_dram_1p1v>;
> +                               reg = <0x60>;
> +                               regulator-min-microvolt = <1100000>;
> +                               regulator-max-microvolt = <1100000>;
> +                               regulator-always-on;
> +                               vsel-gpios = <&gpio2 11 GPIO_ACTIVE_HIGH>;
> +                       };
> +               };
> +
> +               i2c1c: i2c1@2 {
> +                       reg = <2>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg_soc_gpu_vpu: fan53555@60 {

regulator@60

> +&usdhc1 {
> +       bus-width = <8>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_usdhc1>;
> +       non-removable;
> +       vqmmc-1-8-v;

This property does not exist. Please remove it.
