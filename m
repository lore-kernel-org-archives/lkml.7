Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31A0C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 20:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C047920725
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 20:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4Oe2CWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfKNUNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 15:13:47 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41934 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfKNUNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 15:13:47 -0500
Received: by mail-lj1-f194.google.com with SMTP id m4so3158480ljj.8;
        Thu, 14 Nov 2019 12:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x3CgdEWITSo+eK6gV+uLZAjDWDJyETiK4+Drplq4PgM=;
        b=I4Oe2CWqf6WzpiT58ihacjjFdQVcsZGaku/MrdMLdhug9o+MkkeARlGOfSwnYvL+1Y
         xQ90kNke49Ta2j1cU1NfuK2eR6M20DOL18QpZyHicNes1K2P45rMf501zcaREyNO/rre
         0VQ1N8MTuKgaE0r+bheA7UC0bSY0dyqZ8QlUHl1LD4I/GOoE9BOXfpIkHiJY1VoqgSY5
         ASb4jDdjcW3IQbqaaemGhyp3tbwyvgpRiYcGAigwfWfe9YwJ9lb1rZLrf/cyku7hAN89
         fzm1sbQsrM8kRJsUEzJmdv8Y146Iy3D3cwm35a3MTxUhggxQyHPPjc6CCLyM1jUYwhCT
         53pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x3CgdEWITSo+eK6gV+uLZAjDWDJyETiK4+Drplq4PgM=;
        b=I8MO8FkpqVFl+c94igoFCycP4vIQV98bazlqDwuruWPqnb5JbPHYtlQWGObMiI5Y9Z
         GIAoxG1gYSu8qptDcKhknQtwzJhZKing49/N+PxT+mHjan+k5RTugufCQuMh+8Xd/1qY
         PFmzxqUjXRTdw34gBTfbS85WsOa+e7qfnTIf8sv3Z2NCZ8EKv5KaF9xZmn91nlR0ZXPa
         7c3a09HSHtK4jp0WJcStZLaFh7HuAEv4zta/uIBvye5MXXMc23ey8e0ozgokubUrnxBP
         5jIra5lqmfwwQTzxvdjMSZjDxfZ9CbTA6fp1EV0235tkNaRafrEpdPt/lV0QD2GxW0O9
         BMlA==
X-Gm-Message-State: APjAAAWSSlQ8YixSFQbXk2PWw0h8SvMuNcl/eAqn9t/zYJHiMFtqs7yO
        Y3FasJjnaHaNIz8obNGv0zqdq741Jft2Km7ZnV0=
X-Google-Smtp-Source: APXvYqzTjpV2EGEx/nI9p8C44bLQO2CDArK63nzLyG4ISo69VQudOUoP1ds4/e1SnqQp779vUeEPYry/A8MnnGZP4hs=
X-Received: by 2002:a2e:2c1a:: with SMTP id s26mr5219843ljs.239.1573762425328;
 Thu, 14 Nov 2019 12:13:45 -0800 (PST)
MIME-Version: 1.0
References: <20191114195609.30222-1-marco.franchi@nxp.com>
In-Reply-To: <20191114195609.30222-1-marco.franchi@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 14 Nov 2019 17:13:36 -0300
Message-ID: <CAOMZO5Asp-m7zyY6dp72_VKZs0OisxX4B-PJtP4=GuE_-XDBsg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: freescale: add initial support for Google
 i.MX 8MQ Phanbell
To:     Marco Antonio Franchi <marco.franchi@nxp.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcofrk@gmail.com" <marcofrk@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Thu, Nov 14, 2019 at 4:56 PM Marco Antonio Franchi
<marco.franchi@nxp.com> wrote:
>
> This patch adds the device tree to support Google Coral Edge TPU,
> historicaly named as fsl-imx8mq-phanbell, a computer on module
> which can be used for AI/ML propose.
>
> It introduces a minimal enablement support for this module and

What are the features that have been tested?

Also, is the schematics available?

> was totally based on the NXP i.MX 8MQ EVK board and i.MX 8MQ Phanbell
> Google Source Code for Coral Edge TPU Mendel release:
> https://coral.googlesource.com/linux-imx/
>
> This patch was tested using the U-Boot 2017-03-1-release-chef,
> which is supported by the Coral Edge TPU Mendel release:
> https://coral.googlesource.com/uboot-imx/

I would suggest removing this paragraph from the commit log as it is
not relevant to the dts itself.

> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 38e344a2f0ff..cc7e02a30ed1 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -21,6 +21,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
>
> +dtb-$(CONFIG_ARCH_MXC) += fsl-imx8mq-phanbell.dtb

Please remove the fsl prefix and call it mx8mq-phanbell.dtb instead to
align with the other imx8mq dtbs.

> +&i2c1 {
> +       clock-frequency = <400000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c1>;
> +       status = "okay";
> +
> +       pmic: pmic@4b {
> +               reg = <0x4b>;
> +               compatible = "rohm,bd71837";
> +               pinctrl-0 = <&pinctrl_pmic>;
> +               gpio_intr = <&gpio1 3 GPIO_ACTIVE_LOW>;

This property does not exist upstream.

You should describe the interrupt like this instead:

interrupt-parent = <&gpio1>;
interrupts = <3 GPIO_ACTIVE_LOW>;

> +
> +               gpo {
> +                       rohm,drv = <0x0C>;

This property does not exist upstream.

> +&sai2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_sai2>;
> +       assigned-clocks =
> +               <&clk IMX8MQ_AUDIO_PLL1_BYPASS>, <&clk IMX8MQ_CLK_SAI2>;

Please don't split the lines as it gets harder to read.

> +       assigned-clock-parents =
> +               <&clk IMX8MQ_AUDIO_PLL1>, <&clk IMX8MQ_AUDIO_PLL1_OUT>;

Same here.

> +       assigned-clock-rates = <0>, <24576000>;
> +       status = "okay";
> +};
> +
> +&wdog1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_wdog>;
> +       fsl,ext-reset-output;
> +       status = "okay";
> +};
> +
> +&iomuxc {
> +       pinctrl-names = "default";
> +
> +       imx8mq-evk {

No need for this imx8mq-evk container.

> +               pinctrl_pmic: pmicirq {
> +                       fsl,pins = <
> +                               MX8MQ_IOMUXC_GPIO1_IO03_GPIO1_IO3       0x41 /*0x17059*/

This comment looks confusing. I would suggest removing it.

Regards,

Fabio Estevam
