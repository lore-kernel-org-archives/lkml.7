Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E0EC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D8E26E28
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuCYLYmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfEaTET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 15:04:19 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50295 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfEaTES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 15:04:18 -0400
Received: by mail-it1-f196.google.com with SMTP id a186so17565795itg.0;
        Fri, 31 May 2019 12:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jii0B1SHiBfsyisYt0tjpTfpkyGH53lgOLJFv4P8AwE=;
        b=iuCYLYmDOhQ9p8JLVl/C0+c+Ld3GC+bFYACfyafdHxSbhnh+0QqJKPbE763fesZle2
         zI84+KPISI7qwEliFT9USl6LsFCNKr2yU2Fd0EambT/PztdMkUmbto28suxyDlm/5j3W
         dO/DR9hsyXaIdamyLwgTQuhHhFdZdmoXswkluBpKYYfYaXC/81D3YlmeXlSEefLZQQwZ
         75PpNdtP+lDS2l63AMLuQ/gfe2hrPhwETogRiKrpkvUqz2SQggbiHIwy420WZHk8EZB+
         J+PtKB0wY1DiZY5yWROXVbNhF/8aSWU6OsDFO6hWzQz0X6TtAChf8GboM4UgVDE8UGMS
         135w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jii0B1SHiBfsyisYt0tjpTfpkyGH53lgOLJFv4P8AwE=;
        b=PnCADanpHFQqajS4m3sRwQGsOnE47LlreWO21Ecp/OBKxE7J6bn0zjkA7pUUbXChFO
         tb4Ko5WtacU1zCKGqQ5mNK7HjVp4kPxZQrpwi/6+dn8PZN71uZHE6YKae8zEOyrNDlOu
         dcF+LAh9/KuzIt7O6KW0HMs8A2IrahKvW0bCi7JC4ucRwffG2zvjCSX+1XQEoogeSQyg
         6oWCNiomMg+3gd8JbYv9yuLm53lM2cU0vUhfX/Qa5EZg04eQxoAIn1faQ3VnvwjLz9Tt
         2Gr3FWeUzijWIC1LQ20nwPbxZ9Abgn6WFENSuTs2hFl5Ooae/JZcrxybPXvyASkJV35V
         ugDg==
X-Gm-Message-State: APjAAAX2ADtxbRmOn+M8moFx0flZ0flf27pUE+mg9sKXBA2ZeTMp8SMk
        PIVIBP9OGlC+hEqgtt6uA+jkWQ+k6T908HKpy14=
X-Google-Smtp-Source: APXvYqwapy1+PtDtUVrQRkp40Z48kFBN7dxwhXYy+KhKWw8zc87Kq8HPXqmR6nBSk2z2xbUgQdaKwXi9T9lS1g6+EIw=
X-Received: by 2002:a24:97d2:: with SMTP id k201mr8019261ite.151.1559329457355;
 Fri, 31 May 2019 12:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190530094706.865-1-Anson.Huang@nxp.com> <20190530094706.865-2-Anson.Huang@nxp.com>
In-Reply-To: <20190530094706.865-2-Anson.Huang@nxp.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Fri, 31 May 2019 12:04:06 -0700
Message-ID: <CAHQ1cqE2UPL6mM0GdS3aLinM46puE1r+80qGUEX2yA9CDMz=EQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: freescale: Add i.MX8MN dtsi support
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        manivannan.sadhasivam@linaro.org, bruno.thomsen@gmail.com,
        Dong Aisheng <aisheng.dong@nxp.com>, ping.bai@nxp.com,
        leoyang.li@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        pankaj.bansal@nxp.com, bhaskar.upadhaya@nxp.com,
        pramod.kumar_1@nxp.com, vabhav.sharma@nxp.com,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 2:45 AM <Anson.Huang@nxp.com> wrote:
>
> From: Anson Huang <Anson.Huang@nxp.com>
>
> The i.MX8M Nano Media Applications Processor is a new SoC of the i.MX8M
> family, it is a 14nm FinFET product of the growing mScale family targeting
> the consumer market. It is built in Samsung 14LPP to achieve both high
> performance and low power consumption and relies on a powerful fully
> coherent core complex based on a quad core ARM Cortex-A53 cluster,
> Cortex-M7 low-power coprocessor and graphics accelerator.
>
> This patch adds the basic dtsi support for i.MX8MN.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> This patch should be based on below patches for clock and pinctrl head files:
> https://patchwork.kernel.org/patch/10968059/
> https://patchwork.kernel.org/patch/10968267/
> ---
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 701 ++++++++++++++++++++++++++++++
>  1 file changed, 701 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mn.dtsi
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> new file mode 100644
> index 0000000..c318ee6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -0,0 +1,701 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2019 NXP
> + */
> +
> +#include <dt-bindings/clock/imx8mn-clock.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +#include "imx8mn-pinfunc.h"
> +
> +/ {
> +       compatible = "fsl,imx8mn";
> +       interrupt-parent = <&gic>;
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +
> +       aliases {
> +               ethernet0 = &fec1;
> +               gpio0 = &gpio1;
> +               gpio1 = &gpio2;
> +               gpio2 = &gpio3;
> +               gpio3 = &gpio4;
> +               gpio4 = &gpio5;
> +               i2c0 = &i2c1;
> +               i2c1 = &i2c2;
> +               i2c2 = &i2c3;
> +               i2c3 = &i2c4;
> +               mmc0 = &usdhc1;
> +               mmc1 = &usdhc2;
> +               mmc2 = &usdhc3;
> +               serial0 = &uart1;
> +               serial1 = &uart2;
> +               serial2 = &uart3;
> +               serial3 = &uart4;
> +               spi0 = &ecspi1;
> +               spi1 = &ecspi2;
> +               spi2 = &ecspi3;
> +       };
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               A53_0: cpu@0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a53";
> +                       reg = <0x0>;
> +                       clock-latency = <61036>;
> +                       clocks = <&clk IMX8MN_CLK_ARM>;
> +                       enable-method = "psci";
> +                       next-level-cache = <&A53_L2>;
> +               };
> +
> +               A53_1: cpu@1 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a53";
> +                       reg = <0x1>;
> +                       clock-latency = <61036>;
> +                       clocks = <&clk IMX8MN_CLK_ARM>;
> +                       enable-method = "psci";
> +                       next-level-cache = <&A53_L2>;
> +               };
> +
> +               A53_2: cpu@2 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a53";
> +                       reg = <0x2>;
> +                       clock-latency = <61036>;
> +                       clocks = <&clk IMX8MN_CLK_ARM>;
> +                       enable-method = "psci";
> +                       next-level-cache = <&A53_L2>;
> +               };
> +
> +               A53_3: cpu@3 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a53";
> +                       reg = <0x3>;
> +                       clock-latency = <61036>;
> +                       clocks = <&clk IMX8MN_CLK_ARM>;
> +                       enable-method = "psci";
> +                       next-level-cache = <&A53_L2>;
> +               };
> +
> +               A53_L2: l2-cache0 {
> +                       compatible = "cache";
> +               };
> +       };
> +
> +       memory@40000000 {
> +               device_type = "memory";
> +               reg = <0x0 0x40000000 0 0x80000000>;
> +       };
> +
> +       osc_32k: clock-osc-32k {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <32768>;
> +               clock-output-names = "osc_32k";
> +       };
> +
> +       osc_24m: clock-osc-24m {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <24000000>;
> +               clock-output-names = "osc_24m";
> +       };
> +
> +       clk_ext1: clock-ext1 {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <133000000>;
> +               clock-output-names = "clk_ext1";
> +       };
> +
> +       clk_ext2: clock-ext2 {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <133000000>;
> +               clock-output-names = "clk_ext2";
> +       };
> +
> +       clk_ext3: clock-ext3 {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <133000000>;
> +               clock-output-names = "clk_ext3";
> +       };
> +
> +       clk_ext4: clock-ext4 {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency= <133000000>;
> +               clock-output-names = "clk_ext4";
> +       };
> +
> +       gic: interrupt-controller@38800000 {
> +               compatible = "arm,gic-v3";
> +               reg = <0x0 0x38800000 0 0x10000>,
> +                     <0x0 0x38880000 0 0xC0000>;
> +               #interrupt-cells = <3>;
> +               interrupt-controller;
> +               interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +       };

GIC should probably go into soc {} node. At least that's how we have
it in i.MX8MQ AFAICT.

Thanks,
Andrey Smirnov
