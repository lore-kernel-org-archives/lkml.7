Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F809C3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0332087E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566242354;
	bh=m5k/dKgxoNFL9CE5OJQ0J1mAEZhAcE7RlJlTNYGMXKg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=k9G/6mprgb+Ia8gonlQ09MWFQndUdPsmrsK0YZN+9PaK2yDUXN9rFrLLIfmreu7fg
	 cIPxWg7Wsd+c58lgHkctYZujibIy4SDzGbBeW1ENzkpku4gM7K/dIrp6oUqIkWsTjJ
	 wa0IAzXhfeNgxjnGVRAZgPnyNawqDG9Dh94SA67g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbfHSTTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:19:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728218AbfHSTTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:19:13 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 671D222CEC;
        Mon, 19 Aug 2019 19:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566242351;
        bh=m5k/dKgxoNFL9CE5OJQ0J1mAEZhAcE7RlJlTNYGMXKg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=adKdACk3DG6n7olLKxlOA2FQFwp1c6on+rtkK7ffmaevSA4JaVJHFULggsUQlV2FY
         AF/paJwiGMo9PSin48AYUyKQH6SzOxMDUU/o8NKamQkLlFN/jkU9D1hdNPij4CA44+
         22GZw1P+uBi+1Z01/+XByyeX/Tw2aBUDFp0bCWMM=
Received: by mail-qk1-f175.google.com with SMTP id s14so2401357qkm.4;
        Mon, 19 Aug 2019 12:19:11 -0700 (PDT)
X-Gm-Message-State: APjAAAV7zgdeb+coYwqE9Wms6HRK3Ex/ALKy0HZrYmjvakR6D/7sOd2U
        0g49/xbIU+YX7svvRrfLDfwV4TnKC/eGN0lJPA==
X-Google-Smtp-Source: APXvYqwywCKFrxUGXe1dzDKOKdn7UDjBT7BeQlquV4HYXItFVBdeO9hnhuqf/A3ZQAmkFttswCEwRJJ+KNdEqPku1R0=
X-Received: by 2002:a37:d8f:: with SMTP id 137mr21547412qkn.254.1566242350541;
 Mon, 19 Aug 2019 12:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190819130143.18778-1-manivannan.sadhasivam@linaro.org> <20190819130143.18778-5-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190819130143.18778-5-manivannan.sadhasivam@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 19 Aug 2019 14:18:59 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL7iXWU9YS-_8HkEZRgqPE8WkAm85Sai=Kx-wV8hD-3HA@mail.gmail.com>
Message-ID: <CAL_JsqL7iXWU9YS-_8HkEZRgqPE8WkAm85Sai=Kx-wV8hD-3HA@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] dt-bindings: clock: Add devicetree binding for
 BM1880 SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, haitao.suo@bitmain.com,
        darren.tsao@bitmain.com, fisher.cheng@bitmain.com,
        alec.lin@bitmain.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 8:02 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Add YAML devicetree binding for Bitmain BM1880 SoC.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/clock/bitmain,bm1880-clk.yaml    | 83 +++++++++++++++++++
>  include/dt-bindings/clock/bm1880-clock.h      | 82 ++++++++++++++++++
>  2 files changed, 165 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml
>  create mode 100644 include/dt-bindings/clock/bm1880-clock.h
>
> diff --git a/Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml b/Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml
> new file mode 100644
> index 000000000000..a457f996287d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/clock/bitmain,bm1880-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bitmain BM1880 Clock Controller
> +
> +maintainers:
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +
> +description: |
> +  The Bitmain BM1880 clock controller generates and supplies clock to
> +  various peripherals within the SoC.
> +
> +  This binding uses common clock bindings
> +  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - bitmain,bm1880-clk

Just 'const: bitmain,bm1880-clk' is enough.

> +
> +  reg:
> +    minItems: 2
> +    maxItems: 2

These 2 are implied by the items list and can be dropped.

> +    items:
> +      - description: pll registers
> +      - description: system registers
> +
> +  reg-names:
> +    items:
> +      - const: pll
> +      - const: sys
> +
> +  clocks:
> +    maxItems: 1
> +    description: Phandle of the input reference clock

Don't need a description if there's only one entry.

> +
> +  clock-names:
> +    maxItems: 1
> +    items:
> +      - const: osc

Just:

clock-names:
  const: osc

> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +
> +examples:
> +  # Clock controller node:
> +  - |
> +    clk: clock-controller@e8 {
> +        compatible = "bitmain,bm1880-clk";
> +        reg = <0xe8 0x0c>, <0x800 0xb0>;
> +        reg-names = "pll", "sys";
> +        clocks = <&osc>;
> +        clock-names = "osc";
> +        #clock-cells = <1>;
> +    };
> +
> +  # Example UART controller node that consumes clock generated by the clock controller:
> +  - |
> +    uart0: serial@58018000 {
> +         compatible = "snps,dw-apb-uart";
> +         reg = <0x0 0x58018000 0x0 0x2000>;
> +         clocks = <&clk BM1880_CLK_UART_500M>;
> +                  <&clk BM1880_CLK_APB_UART>;

This won't build without includes. Please run 'make dt_binding_check'
before you submit bindings.

> +         clock-names = "baudclk", "apb_pclk";
> +         interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +         reg-shift = <2>;
> +         reg-io-width = <4>;
> +    };
> +
> +...
> diff --git a/include/dt-bindings/clock/bm1880-clock.h b/include/dt-bindings/clock/bm1880-clock.h
> new file mode 100644
> index 000000000000..895646d66b07
> --- /dev/null
> +++ b/include/dt-bindings/clock/bm1880-clock.h
> @@ -0,0 +1,82 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Device Tree binding constants for Bitmain BM1880 SoC
> + *
> + * Copyright (c) 2019 Linaro Ltd.
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_BM1880_H
> +#define __DT_BINDINGS_CLOCK_BM1880_H
> +
> +#define BM1880_CLK_OSC                 0
> +#define BM1880_CLK_MPLL                        1
> +#define BM1880_CLK_SPLL                        2
> +#define BM1880_CLK_FPLL                        3
> +#define BM1880_CLK_DDRPLL              4
> +#define BM1880_CLK_A53                 5
> +#define BM1880_CLK_50M_A53             6
> +#define BM1880_CLK_AHB_ROM             7
> +#define BM1880_CLK_AXI_SRAM            8
> +#define BM1880_CLK_DDR_AXI             9
> +#define BM1880_CLK_EFUSE               10
> +#define BM1880_CLK_APB_EFUSE           11
> +#define BM1880_CLK_AXI5_EMMC           12
> +#define BM1880_CLK_EMMC                        13
> +#define BM1880_CLK_100K_EMMC           14
> +#define BM1880_CLK_AXI5_SD             15
> +#define BM1880_CLK_SD                  16
> +#define BM1880_CLK_100K_SD             17
> +#define BM1880_CLK_500M_ETH0           18
> +#define BM1880_CLK_AXI4_ETH0           19
> +#define BM1880_CLK_500M_ETH1           20
> +#define BM1880_CLK_AXI4_ETH1           21
> +#define BM1880_CLK_AXI1_GDMA           22
> +#define BM1880_CLK_APB_GPIO            23
> +#define BM1880_CLK_APB_GPIO_INTR       24
> +#define BM1880_CLK_GPIO_DB             25
> +#define BM1880_CLK_AXI1_MINER          26
> +#define BM1880_CLK_AHB_SF              27
> +#define BM1880_CLK_SDMA_AXI            28
> +#define BM1880_CLK_SDMA_AUD            29
> +#define BM1880_CLK_APB_I2C             30
> +#define BM1880_CLK_APB_WDT             31
> +#define BM1880_CLK_APB_JPEG            32
> +#define BM1880_CLK_JPEG_AXI            33
> +#define BM1880_CLK_AXI5_NF             34
> +#define BM1880_CLK_APB_NF              35
> +#define BM1880_CLK_NF                  36
> +#define BM1880_CLK_APB_PWM             37
> +#define BM1880_CLK_DIV_0_RV            38
> +#define BM1880_CLK_DIV_1_RV            39
> +#define BM1880_CLK_MUX_RV              40
> +#define BM1880_CLK_RV                  41
> +#define BM1880_CLK_APB_SPI             42
> +#define BM1880_CLK_TPU_AXI             43
> +#define BM1880_CLK_DIV_UART_500M       44
> +#define BM1880_CLK_UART_500M           45
> +#define BM1880_CLK_APB_UART            46
> +#define BM1880_CLK_APB_I2S             47
> +#define BM1880_CLK_AXI4_USB            48
> +#define BM1880_CLK_APB_USB             49
> +#define BM1880_CLK_125M_USB            50
> +#define BM1880_CLK_33K_USB             51
> +#define BM1880_CLK_DIV_12M_USB         52
> +#define BM1880_CLK_12M_USB             53
> +#define BM1880_CLK_APB_VIDEO           54
> +#define BM1880_CLK_VIDEO_AXI           55
> +#define BM1880_CLK_VPP_AXI             56
> +#define BM1880_CLK_APB_VPP             57
> +#define BM1880_CLK_DIV_0_AXI1          58
> +#define BM1880_CLK_DIV_1_AXI1          59
> +#define BM1880_CLK_AXI1                        60
> +#define BM1880_CLK_AXI2                        61
> +#define BM1880_CLK_AXI3                        62
> +#define BM1880_CLK_AXI4                        63
> +#define BM1880_CLK_AXI5                        64
> +#define BM1880_CLK_DIV_0_AXI6          65
> +#define BM1880_CLK_DIV_1_AXI6          66
> +#define BM1880_CLK_MUX_AXI6            67
> +#define BM1880_CLK_AXI6                        68
> +#define BM1880_NR_CLKS                 69
> +
> +#endif /* __DT_BINDINGS_CLOCK_BM1880_H */
> --
> 2.17.1
>
