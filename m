Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224F1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C371C21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P2bcN0kN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbfDXOQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:16:31 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44571 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfDXOQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:16:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id y12so6797456plk.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 07:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0gA08GE841s14gw763uvbDBTBTVWPmPEi5GpE9n37Ik=;
        b=P2bcN0kNm8RWhfW2ESVL6amLfH4+LcJtVR2pcNqt/hSnpMGwFVpigEVxwO+mO8avOw
         EbCOtvYCuSHxX+XKM2ImWYkD7fqFumQxR+Nm3V5lVv7kbe54SylRxeIddKUkc1Zd1ivi
         LvqgAePMA/Rx3WlH4nxFpYWtRvjh2dOeQjRXaHHyyVYjoo5IGg6NPbRM0OHSnhqo1QZF
         ds6xy26b/yoDpNHR5hx54+YvnRW7mDhzcaiWn3R4HHpHBa34HThMKgc4gONdFn/cJdaj
         g4GHJJBD7H3RGg7Cth32Uf38ACAkeg0eBu2MdunaPSXJLykdnU+lGWEhAQya/BHrUCy1
         9YOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0gA08GE841s14gw763uvbDBTBTVWPmPEi5GpE9n37Ik=;
        b=qmntlt0dKELxhs9kr38K+Jv78PgYNOjyvYMuBzs94qFnQCVwykokzHhA/PKlOvK5ls
         PWS2MeFk3OLooKDvT+PpJrEr01F574A+FM1zSRU91gcDo1Ci52Lk+HLmrO1HNsacw2Ez
         YBBw2AnHyAO3BJDjgkwnBqxFovrpYCq+sGiZD+KVd/EWaXDdr9+Z5XTY/FFT7Ye9WJ5g
         QFZWQ+TBhbEXoWMJJ4rMjUoWveeywqwwqMmhGFVZSps+F3fJhkr0wMzT5CXqPdI4rfgI
         xE524HHahgJnxC/oFq8ZvHd9m86EjRxkCzhLhVpJrBSw0PCYS8oxZNYcVlogf3KWYO7d
         ayYA==
X-Gm-Message-State: APjAAAVgvu7zLtv6N/RkdiCLWMsMxtfIgi+D+MdxNUg8fruHZass2k6W
        n3DbNnZa/jErDBxS3kpw16Sjcj1pkSaMsk595v20G3pNsphdag==
X-Google-Smtp-Source: APXvYqyTSxqEogmpOWM084BEF3UFS5Yy3XV3Ozam2zb7vwjPezrNBBs+LGyI5vSRTWn36hQdZNomliUr2yxse5qnVtE=
X-Received: by 2002:a17:902:e183:: with SMTP id cd3mr32984097plb.233.1556115389221;
 Wed, 24 Apr 2019 07:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <1556108926-233682-1-git-send-email-pengms1@lenovo.com>
In-Reply-To: <1556108926-233682-1-git-send-email-pengms1@lenovo.com>
From:   Patrick Venture <venture@google.com>
Date:   Wed, 24 Apr 2019 07:16:17 -0700
Message-ID: <CAO=notw7qnRtZBmi-Ew7OCOjTSw5nz4kBRA+eeUB_KYyeAkHPQ@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: dts: aspeed: Adding Lenovo Hr630 BMC
To:     Andrew Peng <pengms1@lenovo.com>
Cc:     Benjamin Fair <benjaminfair@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aspeed@lists.ozlabs.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lisa YJ19 Liu <liuyj19@lenovo.com>,
        Duke KH Du <dukh@lenovo.com>,
        Yonghui YH21 Liu <liuyh21@lenovo.com>,
        Harry Sung1 <hsung1@lenovo.com>, Joel Stanley <joel@jms.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 5:29 AM Andrew Peng <pengms1@lenovo.com> wrote:
>
> Initial introduction of Lenovo Hr630 family equipped with
> Aspeed 2500 BMC SoC. Hr630 is a x86 server development kit
> with a ASPEED ast2500 BMC manufactured by Lenovo.
> Specifically, This adds the Hr630 platform device tree file
> used by the Hr630 BMC machines.
>
> This also adds an entry of Hr630 device tree file in Makefile
>
> Signed-off-by: Andrew Peng <pengms1@lenovo.com>
> Signed-off-by: Yonghui Liu <liuyh21@lenovo.com>
> Signed-off-by: Lisa Liu <liuyj19@lenovo.com>
> ---
> Changes in v3:
>  - revise i2c switch aliases name.
> Changes in v2:
>  - add i2c switch aliases name.
>  - remove the unused eeprom device from DT file.
>  - remove "Licensed under..." sentence.
>
>  arch/arm/boot/dts/Makefile                    |   3 +-
>  arch/arm/boot/dts/aspeed-bmc-lenovo-hr630.dts | 886 ++++++++++++++++++++++++++
>  2 files changed, 888 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-lenovo-hr630.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index f4f5aea..375e53b 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1261,4 +1261,5 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>         aspeed-bmc-opp-witherspoon.dtb \
>         aspeed-bmc-opp-zaius.dtb \
>         aspeed-bmc-portwell-neptune.dtb \
> -       aspeed-bmc-quanta-q71l.dtb
> +       aspeed-bmc-quanta-q71l.dtb \
> +       aspeed-bmc-lenovo-hr630.dtb
> diff --git a/arch/arm/boot/dts/aspeed-bmc-lenovo-hr630.dts b/arch/arm/boot/dts/aspeed-bmc-lenovo-hr630.dts
> new file mode 100644
> index 0000000..5c45523
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-lenovo-hr630.dts
> @@ -0,0 +1,886 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Device Tree file for Lenovo Hr630 platform
> + *
> + * Copyright (C) 2019-present Lenovo
> + */
> +
> +/dts-v1/;
> +
> +#include "aspeed-g5.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +       model = "HR630 BMC";
> +       compatible = "lenovo,hr630-bmc", "aspeed,ast2500";
> +
> +       aliases {
> +               pca9545_i2c0 = &i2c_rbp;
> +               pca9545_i2c1 = &i2c_fbp1;
> +               pca9545_i2c2 = &i2c_fbp2;
> +               pca9545_i2c3 = &i2c_fbp3;
> +       };
> +
> +       chosen {
> +               stdout-path = &uart5;
> +               bootargs = "console=tty0 console=ttyS4,115200 earlyprintk";
> +       };
> +
> +       memory@80000000 {
> +               device_type = "memory";
> +               reg = <0x80000000 0x20000000>;
> +       };
> +
> +       reserved-memory {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               flash_memory: region@98000000 {
> +                       no-map;
> +                       reg = <0x98000000 0x00100000>; /* 1M */
> +               };
> +
> +               gfx_memory: framebuffer {
> +                       size = <0x01000000>;
> +                       alignment = <0x01000000>;
> +                       compatible = "shared-dma-pool";
> +                       reusable;
> +               };
> +       };
> +
> +       leds {
> +               compatible = "gpio-leds";
> +
> +               heartbeat {
> +                       gpios = <&gpio ASPEED_GPIO(J, 1) GPIO_ACTIVE_LOW>;
> +               };
> +
> +               fault {
> +                       gpios = <&gpio ASPEED_GPIO(J, 0) GPIO_ACTIVE_LOW>;
> +               };
> +       };
> +
> +       iio-hwmon {
> +               compatible = "iio-hwmon";
> +               io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>,
> +               <&adc 4>, <&adc 5>, <&adc 6>, <&adc 7>,
> +               <&adc 8>, <&adc 9>, <&adc 10>,
> +               <&adc 12>, <&adc 13>, <&adc 14>;
> +       };
> +
> +};
> +
> +&fmc {
> +       status = "okay";
> +       flash@0 {
> +               status = "okay";
> +               m25p,fast-read;
> +               label = "bmc";
> +               spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout.dtsi"
> +       };
> +};
> +
> +&lpc_ctrl {
> +       status = "okay";
> +       memory-region = <&flash_memory>;
> +       flash = <&spi1>;
> +};
> +
> +&uart1 {
> +       status = "okay";
> +};
> +
> +&uart2 {
> +       status = "okay";
> +};
> +
> +&uart3 {
> +       status = "okay";
> +};
> +
> +&uart5 {
> +       status = "okay";
> +};
> +
> +&vuart {
> +       status = "okay";
> +};
> +
> +&ibt {
> +       status = "okay";
> +};
> +
> +&mac0 {
> +       status = "okay";
> +
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rmii1_default>;
> +       use-ncsi;
> +};
> +
> +&mac1 {
> +       status = "okay";
> +
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
> +};
> +
> +&adc {
> +       status = "okay";
> +};
> +
> +&i2c0 {
> +       status = "okay";
> +       /* temp1 inlet */
> +       tmp75@4e {
> +               compatible = "national,lm75";
> +               reg = <0x4e>;
> +       };
> +};
> +
> +&i2c1 {
> +       status = "okay";
> +       /* temp2 outlet */
> +       tmp75@4d {
> +               compatible = "national,lm75";
> +               reg = <0x4d>;
> +       };
> +};
> +
> +&i2c2 {
> +       status = "okay";
> +};
> +
> +&i2c3 {
> +       status = "okay";
> +};
> +
> +&i2c4 {
> +       status = "okay";
> +};
> +
> +&i2c5 {
> +       status = "okay";
> +};
> +
> +&i2c6 {
> +       status = "okay";
> +       /*      Slot 0,
> +        *      Slot 1,
> +        *      Slot 2,
> +        *      Slot 3
> +        */
> +
> +       i2c-switch@70 {
> +               compatible = "nxp,pca9545";
> +               reg = <0x70>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               i2c-mux-idle-disconnect;        /* may use mux@70 next. */

It's fine to leave mux-idle-disconnect, however the two muxes you're
worried about aren't competing under the same bus.  This one lives
under i2c6 and the other i2c7, so they shouldn't interfere with each
other.  Does that make sense?  I missed this before because the window
only let me see part of a thing so I didn't see both in the same view
until I opened the patch in patchworks.

> +
> +               i2c_rbp: i2c@0 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0>;
> +               };
> +
> +               i2c_fbp1: i2c@1 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <1>;
> +               };
> +
> +               i2c_fbp2: i2c@2 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <2>;
> +               };
> +
> +               i2c_fbp3: i2c@3 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <3>;
> +               };
> +       };
> +};
> +
> +&i2c7 {
> +       status = "okay";
> +
> +       /*      Slot 0,
> +        *      Slot 1,
> +        *      Slot 2,
> +        *      Slot 3
> +        */
> +       i2c-switch@76 {
> +               compatible = "nxp,pca9546";
> +               reg = <0x76>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               i2c-mux-idle-disconnect;  /* may use mux@76 next. */
> +
> +               i2c_riser2: i2c@0 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0>;
> +               };
> +
> +               i2c_pcie4: i2c@1 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <1>;
> +               };
> +
> +               i2c_riser1: i2c@2 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <2>;
> +               };
> +
> +               i2c_ocp: i2c@3 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <3>;
> +               };
> +       };
> +};
> +
> +&i2c8 {
> +       status = "okay";
> +
> +       eeprom@57 {
> +               compatible = "atmel,24c256";
> +               reg = <0x57>;
> +               pagesize = <16>;
> +       };
> +};
> +
> +&i2c9 {
> +       status = "okay";
> +};
> +
> +&i2c10 {
> +       status = "okay";
> +};
> +
> +&i2c11 {
> +       status = "okay";
> +};
> +
> +&i2c12 {
> +       status = "okay";
> +};
> +
> +/*
> + * Enable port A as device (via the virtual hub) and port B as
> + * host by default on the eval board. This can be easily changed
> + * by replacing the override below with &ehci0 { ... } to enable
> + * host on both ports.
> + */
> +&vhub {
> +       status = "okay";
> +};
> +
> +&ehci1 {
> +       status = "okay";
> +};
> +
> +&uhci {
> +       status = "okay";
> +};
> +
> +&gfx {
> +       status = "okay";
> +       memory-region = <&gfx_memory>;
> +};
> +
> +&pwm_tacho {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_pwm0_default
> +       &pinctrl_pwm1_default
> +       &pinctrl_pwm2_default
> +       &pinctrl_pwm3_default
> +       &pinctrl_pwm4_default
> +       &pinctrl_pwm5_default
> +       &pinctrl_pwm6_default>;
> +
> +       fan@0 {
> +               reg = <0x00>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x00>;
> +       };
> +
> +       fan@1 {
> +               reg = <0x00>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x01>;
> +       };
> +
> +       fan@2 {
> +               reg = <0x01>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x02>;
> +       };
> +
> +       fan@3 {
> +               reg = <0x01>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x03>;
> +       };
> +
> +       fan@4 {
> +               reg = <0x02>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x04>;
> +       };
> +
> +       fan@5 {
> +               reg = <0x02>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x05>;
> +       };
> +
> +       fan@6 {
> +               reg = <0x03>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x06>;
> +       };
> +
> +       fan@7 {
> +               reg = <0x03>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x07>;
> +       };
> +
> +       fan@8 {
> +               reg = <0x04>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x08>;
> +       };
> +
> +       fan@9 {
> +               reg = <0x04>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x09>;
> +       };
> +
> +       fan@10 {
> +               reg = <0x05>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x0a>;
> +       };
> +
> +       fan@11 {
> +               reg = <0x05>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x0b>;
> +       };
> +
> +       fan@12 {
> +               reg = <0x06>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x0c>;
> +       };
> +
> +       fan@13 {
> +               reg = <0x06>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x0d>;
> +       };
> +};
> +
> +&gpio {
> +
> +       pin_gpio_a0 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(A, 0) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "MAC1_INT_N";
> +       };
> +
> +       pin_gpio_a1 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(A, 1) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "MEZZ_C_PRESENT_N";
> +       };
> +
> +       pin_gpio_a2 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(A, 2) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "PSU1_PRST";
> +       };
> +
> +       pin_gpio_a3 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(A, 3) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "PSU2_PRST";
> +       };
> +
> +       pin_gpio_b5 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name = "IRQ_BMC_PCH_SMI_LPC_N";
> +       };
> +
> +       pin_gpio_f0 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(F, 0) GPIO_ACTIVE_HIGH>;
> +               output-low;
> +               line-name = "IRQ_BMC_PCH_NMI_R";
> +       };
> +
> +       pin_gpio_f1 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(F, 1) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "FM_CPU1_DISABLE_COD_N";
> +       };
> +
> +       pin_gpio_f2 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(F, 2) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "SMB_LAN_ALERT_N_MEZZ";
> +       };
> +
> +       pin_gpio_f3 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(F, 3) GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name = "I2C_BUS0_RST_OUT_N";
> +       };
> +
> +       pin_gpio_f4 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(F, 4) GPIO_ACTIVE_HIGH>;
> +               output-low;
> +               line-name = "FM_SKT0_FAULT_LED";
> +       };
> +
> +       pin_gpio_f5 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(F, 5) GPIO_ACTIVE_HIGH>;
> +               output-low;
> +               line-name = "FM_SKT1_FAULT_LED";
> +       };
> +
> +       pin_gpio_f6 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(F, 6) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "IRQ_BMC_CPLD_NMI";
> +       };
> +
> +       pin_gpio_f7 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(F, 7) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "PSU2_ALERT_N";
> +       };
> +
> +       pin_gpio_g0 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(G, 0) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "FM_CPU_ERR2_LVT3_N";
> +       };
> +
> +       pin_gpio_g1 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(G, 1) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "FM_CPU_MSMI_CATERR_LVT3_N";
> +       };
> +
> +       pin_gpio_g2 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(G, 2) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "FM_PCH_BMC_THERMTRIP_N";
> +       };
> +
> +       pin_gpio_g3 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(G, 3) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "BMC_I2C_BUS7_INT_N";
> +       };
> +
> +       pin_gpio_g4 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(G, 4) GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name = "FAN_PWR_CTL_N";
> +       };
> +
> +       pin_gpio_g5 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(G, 5) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "NFC_FD_N";
> +       };
> +
> +       pin_gpio_g6 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(G, 6) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "IRQ_NMI_EVENT_N";
> +       };
> +
> +       pin_gpio_g7 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(G, 7) GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name = "RST_BMC_PCIE_I2CMUX_N";
> +       };
> +
> +       pin_gpio_h0 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(H, 0) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "PSU1_EPOW_N_R";
> +       };
> +
> +       pin_gpio_h1 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(H, 1) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "PSU2_EPOW_N_R";
> +       };
> +
> +       pin_gpio_h2 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(H, 2) GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name = "PSU1_FFS_N_R";
> +       };
> +
> +       pin_gpio_h3 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(H, 3) GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name = "PSU2_FFS_N_R";
> +       };
> +
> +       pin_gpio_h4 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(H, 4) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "PSU1_THROTTLE_N_R";
> +       };
> +
> +       pin_gpio_h5 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(H, 5) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "PSU2_THROTTLE_N_R";
> +       };
> +
> +       pin_gpio_h6 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(H, 6) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "PSU1_SMB_RESET_N";
> +       };
> +
> +       pin_gpio_h7 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(H, 7) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "PSU2_SMB_RESET_N";
> +       };
> +
> +       pin_gpio_i1 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(I, 1) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "FP_PWR_BTN_N";
> +       };
> +
> +       pin_gpio_i2 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(I, 2) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "BIOS_RCVR_N";
> +       };
> +
> +       pin_gpio_i3 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(I, 3) GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name = "BMC_INTRUDED_COVER";
> +       };
> +
> +       pin_gpio_j2 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(J, 2) GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name = "BMC_BIOS_UPDATE_N";
> +       };
> +
> +       pin_gpio_j3 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(J, 3) GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name = "RST_BMC_HDD_I2CMUX_N";
> +       };
> +
> +       pin_gpio_q4 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(Q, 4) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "MEZZ_A_PRESENT_N";
> +       };
> +
> +       pin_gpio_q5 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(Q, 5) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "VGA_FRONT_PRES_N";
> +       };
> +
> +       pin_gpio_q6 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(Q, 6) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "I2C_RISER1_INT_N";
> +       };
> +
> +       pin_gpio_q7 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(Q, 7) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "NCSI_CABLE_DET_N";
> +       };
> +
> +       pin_gpio_r0 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(R, 0) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "FP_RST_BTN_N";
> +       };
> +
> +       pin_gpio_r2 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(R, 2) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "HDDSIG1_DETECT_N";
> +       };
> +
> +       pin_gpio_r3 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(R, 3) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "HDDSIG2_DETECT_N";
> +       };
> +
> +       pin_gpio_r4 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(R, 4) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "HDDSIG3_DETECT_N";
> +       };
> +
> +       pin_gpio_r5 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(R, 5) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "VIDEO_CABLE_DETECT_N";
> +       };
> +
> +       pin_gpio_s0 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(S, 0) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "BMC_PS_RAPIDON_WAKE_R_N";
> +       };
> +
> +       pin_gpio_s1 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(S, 1) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "HOST_TPM_PP_BUF";
> +       };
> +
> +       pin_gpio_s2 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(S, 2) GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name = "BMC_VGA_SW";
> +       };
> +
> +       pin_gpio_s3 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(S, 3) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "IRQ_SML0_ALERT_MUX_N";
> +       };
> +
> +       pin_gpio_s4 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(S, 4) GPIO_ACTIVE_HIGH>;
> +               output;
> +               line-name = "VBAT_EN_N";
> +       };
> +
> +       pin_gpio_s5 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(S, 5) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "BMC_HW_STRAP_4";
> +       };
> +
> +       pin_gpio_s6 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(S, 6) GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name = "PU_BMC_GPIOS6";
> +       };
> +
> +       pin_gpio_s7 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(S, 7) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "I2C_BUS7_RESET_N";
> +       };
> +
> +       pin_gpio_y0 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(Y, 0) GPIO_ACTIVE_HIGH>;
> +               output-low;
> +               line-name = "BMC_NCSI_MUX_CTL_S0";
> +       };
> +
> +       pin_gpio_y1 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(Y, 1) GPIO_ACTIVE_HIGH>;
> +               output-low;
> +               line-name = "BMC_NCSI_MUX_CTL_S1";
> +       };
> +
> +       pin_gpio_y2 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(Y, 2) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "UID_ALERT_N";
> +       };
> +
> +       pin_gpio_z0 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(Z, 0) GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name = "I2C_RISER2_INT_N";
> +       };
> +
> +       pin_gpio_z2 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(Z, 2) GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name = "I2C_RISER2_RESET_N";
> +       };
> +
> +       pin_gpio_z3 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name = "FM_BMC_PCH_SCI_LPC_N";
> +       };
> +
> +       pin_gpio_z4 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "BMC_HW_STRAP_17";
> +       };
> +
> +       pin_gpio_z6 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(Z, 6) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "BMC_HW_STRAP_20";
> +       };
> +
> +       pin_gpio_z7 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(Z, 7) GPIO_ACTIVE_HIGH>;
> +               output-low;
> +               line-name = "BMC_POST_CMPLT_N";
> +       };
> +
> +       pin_gpio_aa0 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(AA, 0) GPIO_ACTIVE_HIGH>;
> +               output-low;
> +               line-name = "HOST_BMC_USB_SEL";
> +       };
> +
> +       pin_gpio_aa1 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(AA, 1) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "PSU1_ALERT_N";
> +       };
> +
> +       pin_gpio_aa2 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(AA, 2) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "FM_PVCCIN_CPU0_PWR_IN_ALERT_N";
> +       };
> +
> +       pin_gpio_aa3 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(AA, 3) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "FM_PVCCIN_CPU1_PWR_IN_ALERT_N";
> +       };
> +
> +       pin_gpio_aa4 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(AA, 4) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "USB_CABLE_DETECT_N";
> +       };
> +
> +       pin_gpio_aa5 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(AA, 5) GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name = "I2C_BUS1_RST_OUT_N";
> +       };
> +
> +       pin_gpio_aa6 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(AA, 6) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "IRQ_SMI_ACTIVE_N";
> +       };
> +
> +       pin_gpio_aa7 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(AA, 7) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "FM_BIOS_POST_CMPLT_N";
> +       };
> +
> +       pin_gpio_ab0 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(AB, 0) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "FM_TPM_MOD_PRES_N";
> +       };
> +
> +       pin_gpio_ab1 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(AB, 1) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "FORCE_NMI_SW_FPGA_N";
> +       };
> +
> +       pin_gpio_ab2 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(AB, 2) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "1U_2U_PCBA_SEL_R";
> +       };
> +
> +       pin_gpio_ab3 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(AB, 3) GPIO_ACTIVE_HIGH>;
> +               input;
> +               line-name = "INTRUDED_PRES_N";
> +       };
> +};

This is my last comment.
Thanks,
Patrick

> --
> 2.7.4
>
