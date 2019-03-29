Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E401C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 05:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585292173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 05:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNrq4KxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfC2Fau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 01:30:50 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37315 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfC2Fat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 01:30:49 -0400
Received: by mail-io1-f65.google.com with SMTP id x7so799223ioh.4;
        Thu, 28 Mar 2019 22:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tjTw/uu6MvXYUHUqXVvcsuEl2ECi+xRR8hf3MB1KE0g=;
        b=pNrq4KxYbiHS0FlUL9hADm6WlENoQy1chtiq6rvWpnDbbOWwDQbIxj4qXPtn5MGmDi
         kt9TG02cUoZun9uFdvb26+L93/jmlElGbV/SJGXYWsOwIOuA5MUs7S7iUE1xY7QLlYKK
         8h+jjek7dCDGM2gS4xJr4kRqSB+TjIS7WwvvZVlp+ppubdown2wEHxCyGdGAOxsO7A0M
         QFgRi8PaRVgPvXf47BzMZI3uY1U0tXlPyjYaQl1yKTmq4ScUYuALl0vyA6/71kVE05B4
         t81JHVzEGbf0bqYeylDejKxfmtpmYtj4NckRvKO6WHiw28EpcWew6hoHbCZVBROD8PiY
         xHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjTw/uu6MvXYUHUqXVvcsuEl2ECi+xRR8hf3MB1KE0g=;
        b=GcB9OAFmtt5XjPAWOfnjHb93KMVNvUblokBpcFsqO9Z+jS5bA2BDO0PUe2OE93vbVe
         eDFkr+FYAJRB8KPqNamU5PJ3u9jdNx8aDAHeQ4meMC7NeRFLwu/1jYBFxTppMZ9iguBo
         MO23+pXLxdrJaAdkDNLuJYIZWOjeTxUZQSWDe6lT35oTziiNc7befTXnEOtKYV5XQ5oe
         BPT5brVXrGMO4vBqIHKWRsYl98/cjHW1fRTEL3mkPNz7GOBwgG0TgPSJr0UhlnL/nMS1
         TCN2QuDFidMjCviJiDhsrpWUwYsP8J3lgBqVYkz3CcpTxQWU4vwUQfewwPd2o90CGKkD
         GmHw==
X-Gm-Message-State: APjAAAVIKfT6kyYHnZqsNDRdiTXDlAd1WUtxOp1mf/fqTgfT8l3pcDj4
        hHMKy69HnRnPR1O6nooQQl2xNk45+5DsI6BpIy0=
X-Google-Smtp-Source: APXvYqyeWuE/NRZ/aiDI8KEwCBMgSzDiIu/fd4DPFybu8vpbtUhRGLA6X4JWsBaH7S46bwsOwzydzQL3RYFoAPeTfh0=
X-Received: by 2002:a5d:8b97:: with SMTP id p23mr9905896iol.83.1553837448315;
 Thu, 28 Mar 2019 22:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190327064150.31549-1-andrew.smirnov@gmail.com> <20190327064150.31549-2-andrew.smirnov@gmail.com>
In-Reply-To: <20190327064150.31549-2-andrew.smirnov@gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 28 Mar 2019 22:30:36 -0700
Message-ID: <CAHQ1cqHiz__CXFZKG_6GanDxNTMzdhTLc_f9Xa-pc8Tb5GyRuw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: Add support for ZII i.MX7 RPU2 board
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 11:41 PM Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
>
> Add support for ZII's i.MX7 based Remote Peripheral Unit 2 (RPU2)
> board.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> ---
>  arch/arm/boot/dts/Makefile           |   1 +
>  arch/arm/boot/dts/imx7d-zii-rpu2.dts | 936 +++++++++++++++++++++++++++
>  2 files changed, 937 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx7d-zii-rpu2.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index efefce8efa05..687222907154 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -586,6 +586,7 @@ dtb-$(CONFIG_SOC_IMX7D) += \
>         imx7d-sdb.dtb \
>         imx7d-sdb-reva.dtb \
>         imx7d-sdb-sht11.dtb \
> +       imx7d-zii-rpu2.dtb \
>         imx7s-colibri-eval-v3.dtb \
>         imx7s-warp.dtb
>  dtb-$(CONFIG_SOC_IMX7ULP) += \
> diff --git a/arch/arm/boot/dts/imx7d-zii-rpu2.dts b/arch/arm/boot/dts/imx7d-zii-rpu2.dts
> new file mode 100644
> index 000000000000..6f36c7d9d214
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx7d-zii-rpu2.dts
> @@ -0,0 +1,936 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +
> +/*
> + * Device tree file for ZII's RPU2 board
> + *
> + * RPU - Remote Peripheral Unit
> + *
> + * Copyright (C) 2019 Zodiac Inflight Innovations
> + */
> +
> +/dts-v1/;
> +#include "imx7d.dtsi"
> +
> +/ {
> +       model = "ZII RPU2 Board";
> +       compatible = "zii,imx7d-rpu2", "fsl,imx7d";
> +
> +       chosen {
> +               stdout-path = &uart1;
> +       };
> +
> +       gpio-leds {
> +               compatible = "gpio-leds";
> +               pinctrl-0 = <&pinctrl_leds_debug>;
> +               pinctrl-names = "default";
> +
> +               debug {
> +                       label = "zii:green:debug1";
> +                       gpios = <&gpio2 8 GPIO_ACTIVE_HIGH>;
> +                       linux,default-trigger = "heartbeat";
> +               };
> +       };
> +
> +       reg_can1_stby: regulator-can1-stby {
> +               compatible = "regulator-fixed";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_flexcan1_stby>;
> +               regulator-name = "can1-3v3";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               gpio = <&gpio1 9 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +       };
> +
> +       reg_can2_stby: regulator-can2-stby {
> +               compatible = "regulator-fixed";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_flexcan2_stby>;
> +               regulator-name = "can2-3v3";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               gpio = <&gpio1 8 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +       };
> +
> +       reg_vref_1v8: regulator-vref-1v8 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vref-1v8";
> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <1800000>;
> +               regulator-always-on;
> +       };
> +
> +       reg_3p3v: regulator-3p3v {
> +               compatible = "regulator-fixed";
> +               regulator-name = "GEN_3V3";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               regulator-always-on;
> +       };
> +
> +       reg_5p0v_main: regulator-5p0v-main {
> +               compatible = "regulator-fixed";
> +               regulator-name = "5V_MAIN";
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +               regulator-always-on;
> +       };
> +
> +       sound1 {
> +               compatible = "simple-audio-card";
> +               simple-audio-card,name = "Audio Output 1";
> +               simple-audio-card,format = "i2s";
> +               simple-audio-card,bitclock-master = <&sound1_codec>;
> +               simple-audio-card,frame-master = <&sound1_codec>;
> +               simple-audio-card,widgets =
> +                       "Headphone", "Headphone Jack";
> +               simple-audio-card,routing =
> +                       "Headphone Jack", "HPLEFT",
> +                       "Headphone Jack", "HPRIGHT",
> +                       "LEFTIN", "HPL",
> +                       "RIGHTIN", "HPR";
> +               simple-audio-card,aux-devs = <&hpa1>;
> +
> +               simple-audio-card,cpu {
> +                       sound-dai = <&sai1>;
> +               };
> +
> +               sound1_codec: simple-audio-card,codec {
> +                       sound-dai = <&codec1>;
> +                       clocks = <&cs2000>;
> +               };
> +       };
> +
> +       sound2 {
> +               compatible = "simple-audio-card";
> +               simple-audio-card,name = "Audio Output 2";
> +               simple-audio-card,format = "i2s";
> +               simple-audio-card,bitclock-master = <&sound2_codec>;
> +               simple-audio-card,frame-master = <&sound2_codec>;
> +               simple-audio-card,widgets =
> +                       "Headphone", "Headphone Jack";
> +               simple-audio-card,routing =
> +                       "Headphone Jack", "HPLEFT",
> +                       "Headphone Jack", "HPRIGHT",
> +                       "LEFTIN", "HPL",
> +                       "RIGHTIN", "HPR";
> +               simple-audio-card,aux-devs = <&hpa2>;
> +
> +               simple-audio-card,cpu {
> +                       sound-dai = <&sai2>;
> +               };
> +
> +               sound2_codec: simple-audio-card,codec {
> +                       sound-dai = <&codec2>;
> +                       clocks = <&cs2000>;
> +               };
> +       };
> +
> +       sound3 {
> +               compatible = "simple-audio-card";
> +               simple-audio-card,name = "Audio Output 3";
> +               simple-audio-card,format = "i2s";
> +               simple-audio-card,bitclock-master = <&sound3_codec>;
> +               simple-audio-card,frame-master = <&sound3_codec>;
> +               simple-audio-card,widgets =
> +                       "Headphone", "Headphone Jack";
> +               simple-audio-card,routing =
> +                       "Headphone Jack", "HPLEFT",
> +                       "Headphone Jack", "HPRIGHT",
> +                       "LEFTIN", "HPL",
> +                       "RIGHTIN", "HPR";
> +               simple-audio-card,aux-devs = <&hpa3>;
> +
> +               simple-audio-card,cpu {
> +                       sound-dai = <&sai3>;
> +               };
> +
> +               sound3_codec: simple-audio-card,codec {
> +                       sound-dai = <&codec3>;
> +                       clocks = <&cs2000>;
> +               };
> +       };
> +
> +       cs2000_ref: cs2000-ref {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <24576000>;
> +       };
> +
> +       cs2000_in_dummy: cs2000-in-dummy {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <0>;
> +       };
> +};
> +
> +&adc1 {
> +       vref-supply = <&reg_vref_1v8>;
> +       status = "okay";
> +};
> +
> +&adc2 {
> +       vref-supply = <&reg_vref_1v8>;
> +       status = "okay";
> +};

Tested this patch more and realized that these two above need to be
properly exposed via HWMON. Will submit an update v2 of this set.

Thanks,
Andrey Smirnov
