Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071BEC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5862183F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhkHV/C4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfFNQwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:52:17 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45321 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfFNQwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:52:16 -0400
Received: by mail-io1-f65.google.com with SMTP id e3so7105522ioc.12;
        Fri, 14 Jun 2019 09:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VHBN9wFTEuXJLZJuvq9UKo9jUBkumDESCB/tRtHAcUw=;
        b=OhkHV/C4uU7RQc1Ui4CvCg/LHrGATRYkRt59YooC0i5ZKpFaFLbdQns18vlCSUvPcN
         UTeUSi7QYJiqW53NN0GqsQ/1lMgigmmvGa5R7FZXafZCB+waf9R/LYpCEhIaQaxm044v
         uxOTQ4gPLhGA+hZ011/3lVzns6nemdjjREA+zScAKE6/S0wdEHeKi51jLQJPlPT8H+2a
         SLgebRCfYgbyQ8oZMnHBbscTkB3XAYwJdkG5rZvwC+3ef3fhiNjcl9Q5y1RMdK1m4v7i
         G0zMx8dujRl7YbRkxTXUD6AdxAOuqsrCoLzE+7rp7xTiEzsotkXGynhmaJq7ooq6aiTS
         nH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VHBN9wFTEuXJLZJuvq9UKo9jUBkumDESCB/tRtHAcUw=;
        b=cVwKIauymgliRKqsA97XX5bD+kyHtWgDBbvXR92PkXcR3mvl9d43iSsy+9vd/uCROB
         r2c9F0wRRyucYnbakf76yEehHYEF1rsAGXIGGY0zYv5/2WGEljZLkrhiAylf7Sjn0xrx
         cGiZSO+Y3eXaDPcHbh0PSAGZCBYLecy65hxXmCHmR7+0OXwtDcnyWtLSqrs62nU1ePS6
         XAVDeo5BpqKPRung+TqD9hVDjjmPLaW54rbnS6QROilk2nYuLZse5kcfht/cC0iYrhdh
         RDrKbu1hsE+L3yAWFK3n4BrjeMYsVqo6ezmQ7MWuog6Lwci/waj/WcN4JdvjzCUuMlbP
         qPmw==
X-Gm-Message-State: APjAAAVHpIRj3M0mS4JUHEQbz9O8PpW7mkrPzMbZB7NWpc2QvdJu0bCr
        /zspJLTg9vY1d/Fbnf0s+90q4uJ1DiN02UMb0qc=
X-Google-Smtp-Source: APXvYqw9IMOjvY8adpddV4q2iTxL7Wp/MrsOOO+GABMLEPFjmiFgpFagZAwQjnbkYEOV3VzYE4p0azX40JCtdTWVQ18=
X-Received: by 2002:a02:3b62:: with SMTP id i34mr62410188jaf.91.1560531135880;
 Fri, 14 Jun 2019 09:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190614080317.16850-1-andrew.smirnov@gmail.com>
In-Reply-To: <20190614080317.16850-1-andrew.smirnov@gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Fri, 14 Jun 2019 09:52:04 -0700
Message-ID: <CAHQ1cqFcbs5feFzSjrwMWyNsSphuQy487_wsvRY_BKnS=x4b=w@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: Add ZII support for ZII i.MX7 RMU2 board
To:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Bob Langer <Bob.Langer@zii.aero>,
        Liang Pan <Liang.Pan@zii.aero>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 1:03 AM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> Add support for ZII's i.MX7 based Remote Modem Unit 2 (RMU2) board.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Bob Langer <Bob.Langer@zii.aero>
> Cc: Liang Pan <Liang.Pan@zii.aero>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> ---
>  arch/arm/boot/dts/Makefile           |   1 +
>  arch/arm/boot/dts/imx7d-zii-rmu2.dts | 358 +++++++++++++++++++++++++++
>  2 files changed, 359 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx7d-zii-rmu2.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 5559028b770e..516e2912236d 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -593,6 +593,7 @@ dtb-$(CONFIG_SOC_IMX7D) += \
>         imx7d-sdb.dtb \
>         imx7d-sdb-reva.dtb \
>         imx7d-sdb-sht11.dtb \
> +       imx7d-zii-rmu2.dtb \
>         imx7d-zii-rpu2.dtb \
>         imx7s-colibri-eval-v3.dtb \
>         imx7s-mba7.dtb \
> diff --git a/arch/arm/boot/dts/imx7d-zii-rmu2.dts b/arch/arm/boot/dts/imx7d-zii-rmu2.dts
> new file mode 100644
> index 000000000000..10fdafe5e0e4
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx7d-zii-rmu2.dts
> @@ -0,0 +1,358 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Device tree file for ZII's RMU2 board
> + *
> + * RMU - Remote Modem Unit
> + *
> + * Copyright (C) 2019 Zodiac Inflight Innovations
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/thermal/thermal.h>
> +#include "imx7d.dtsi"
> +
> +/ {
> +       model = "ZII RMU2 Board";
> +       compatible = "zii,imx7d-rmu2", "fsl,imx7d";
> +
> +       chosen {
> +               stdout-path = &uart2;
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
> +};
> +
> +&cpu0 {
> +       arm-supply = <&sw1a_reg>;
> +};
> +
> +&ecspi1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_ecspi1>;
> +       cs-gpios = <&gpio4 19 GPIO_ACTIVE_HIGH>;
> +       status = "okay";
> +
> +       flash@0 {
> +               compatible = "jedec,spi-nor";
> +               spi-max-frequency = <20000000>;
> +               reg = <0>;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +       };
> +};
> +
> +&fec1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_enet1>;
> +       assigned-clocks = <&clks IMX7D_ENET1_TIME_ROOT_SRC>,
> +                         <&clks IMX7D_ENET1_TIME_ROOT_CLK>;
> +       assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
> +       assigned-clock-rates = <0>, <100000000>;
> +       phy-mode = "rgmii";
> +       phy-handle = <&fec1_phy>;
> +       status = "okay";
> +
> +       mdio {

Ugh, missed

#address-cells = <1>;
#size-cells = <0>;

here. Will fix in v2.

Thanks,
Andrey Smirnov
