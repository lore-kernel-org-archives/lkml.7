Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E9AC76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6759B21841
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563985116;
	bh=nt8pnw+s3B/k5tqXTz7GDC8ZdGRXGZeSzvYlVgrMn9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ESuW6Px0tezQN3IRALbq8jw45ljkfhEuWyDT1kC/egd0CqZXiIQL2Oudyd54+exbG
	 sLAI0UPaUXd20Mw+ctsH0JYOCBzHd3h8hncBqtcNk4y53Le9aoY/Bph2Fw4e7F6nrj
	 vc9AGfsHQSZarPURoM8yJHUQeUqqW63ASBg5YdEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfGXQSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:18:34 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45913 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbfGXQSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:18:32 -0400
Received: by mail-io1-f66.google.com with SMTP id g20so90791799ioc.12;
        Wed, 24 Jul 2019 09:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NiEvOyYVhlLilgSFE1mlRwHXS6W3gSeLb1b8lQMXBOQ=;
        b=e6iEfHQAe0xlSQQD94fofT147/LAEdu5QGfh4St0snk6MLbHHv+2u8RB68w69zkoV9
         oXUyrNxkAGaPtA0o8eKUfAPYrsywNX6SUMOZpOZNVpFTXTF5i5LV4Kbf5EbTztNz30Z6
         wgHzB5gsfQYkZSBfC04EPqtQjd4XV2LayoqUH0w18Oa0Og2DRwHL00Ww5NtYFl7N9CdG
         D1m4HKvKOO/m8TDnsiw+lS3Azeaa16FrJ3j7dVqKfzb5tKS/smNIYgUGiJ/uxA3lXec8
         2SaxqZYG6lV9yogFh38gtr1PShewnm8LolQnFy1sHlkE2aU88TmKEq77c56tZU80ka0Z
         C8zA==
X-Gm-Message-State: APjAAAXZAiEURFRvTkS6lqMmgVyePNdmhJQQf/Hls9Te62O7j2Qlrk1p
        5K0Ls5iIZUWHTx6WMPEzCA==
X-Google-Smtp-Source: APXvYqx80bAdAvJF00+PN/mFyPi4UNJY/h6LQp8Akm1NxxdhOq+ov9gIYj6vopYyGsh5Ktydz/4jiQ==
X-Received: by 2002:a6b:6012:: with SMTP id r18mr77134590iog.241.1563985110886;
        Wed, 24 Jul 2019 09:18:30 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id m4sm41525223iok.68.2019.07.24.09.18.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 09:18:30 -0700 (PDT)
Date:   Wed, 24 Jul 2019 10:18:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com
Subject: Re: [PATCH 1/5] dt-bindings: clock: Add Bitmain BM1880 SoC clock
 controller binding
Message-ID: <20190724161829.GA26249@bogus>
References: <20190705151440.20844-1-manivannan.sadhasivam@linaro.org>
 <20190705151440.20844-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705151440.20844-2-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 08:44:36PM +0530, Manivannan Sadhasivam wrote:
> Add devicetree binding for Bitmain BM1880 SoC clock controller.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/clock/bitmain,bm1880-clk.txt     | 47 +++++++++++
>  include/dt-bindings/clock/bm1880-clock.h      | 82 +++++++++++++++++++
>  2 files changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.txt
>  create mode 100644 include/dt-bindings/clock/bm1880-clock.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.txt b/Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.txt
> new file mode 100644
> index 000000000000..9c967095d430
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.txt
> @@ -0,0 +1,47 @@
> +* Bitmain BM1880 Clock Controller
> +
> +The Bitmain BM1880 clock controler generates and supplies clock to

checkpatch.pl reports a spelling error...

> +various peripherals within the SoC.
> +
> +Required Properties:
> +
> +- compatible: Should be "bitmain,bm1880-clk"
> +- reg :	Register address and size of PLL and SYS control domains
> +- reg-names : Register domain names: "pll" and "sys"
> +- clocks : Phandle of the input reference clock.
> +- #clock-cells: Should be 1.
> +
> +Each clock is assigned an identifier, and client nodes can use this identifier
> +to specify the clock which they consume.
> +
> +All available clocks are defined as preprocessor macros in corresponding
> +dt-bindings/clock/bm1880-clock.h header and can be used in device tree sources.
> +
> +External clocks:
> +
> +The osc clock used as the input for the plls is generated outside the SoC.
> +It is expected that it is defined using standard clock bindings as "osc".
> +
> +Example: 
> +
> +        clk: clock-controller@800 {

Usually the unit-address is from the first entry.

> +                compatible = "bitmain,bm1880-clk";
> +                reg = <0xe8 0x0c>,<0x800 0xb0>;

space                                ^

> +                reg-names = "pll", "sys";
> +                clocks = <&osc>;
> +                #clock-cells = <1>;
> +        };
> +
> +Example: UART controller node that consumes clock generated by the clock
> +controller:
> +
> +        uart0: serial@58018000 {
> +                compatible = "snps,dw-apb-uart";
> +                reg = <0x0 0x58018000 0x0 0x2000>;
> +                clocks = <&clk BM1880_CLK_UART_500M>;
> +                         <&clk BM1880_CLK_APB_UART>;
> +                clock-names = "baudclk", "apb_pclk";
> +                interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +                reg-shift = <2>;
> +                reg-io-width = <4>;
> +        };
> diff --git a/include/dt-bindings/clock/bm1880-clock.h b/include/dt-bindings/clock/bm1880-clock.h
> new file mode 100644
> index 000000000000..764472b9a4fd
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
> +#define BM1880_CLK_OSC			0
> +#define BM1880_CLK_MPLL			1
> +#define BM1880_CLK_SPLL			2
> +#define BM1880_CLK_FPLL			3
> +#define BM1880_CLK_DDRPLL 		4

space before tab

> +#define BM1880_CLK_A53			5
> +#define BM1880_CLK_50M_A53		6
> +#define BM1880_CLK_AHB_ROM		7
> +#define BM1880_CLK_AXI_SRAM		8
> +#define BM1880_CLK_DDR_AXI		9
> +#define BM1880_CLK_EFUSE		10
> +#define BM1880_CLK_APB_EFUSE		11
> +#define BM1880_CLK_AXI5_EMMC		12
> +#define BM1880_CLK_EMMC			13
> +#define BM1880_CLK_100K_EMMC		14
> +#define BM1880_CLK_AXI5_SD		15
> +#define BM1880_CLK_SD			16
> +#define BM1880_CLK_100K_SD		17
> +#define BM1880_CLK_500M_ETH0		18
> +#define BM1880_CLK_AXI4_ETH0		19
> +#define BM1880_CLK_500M_ETH1		20
> +#define BM1880_CLK_AXI4_ETH1		21
> +#define BM1880_CLK_AXI1_GDMA		22
> +#define BM1880_CLK_APB_GPIO		23
> +#define BM1880_CLK_APB_GPIO_INTR	24
> +#define BM1880_CLK_GPIO_DB		25
> +#define BM1880_CLK_AXI1_MINER		26
> +#define BM1880_CLK_AHB_SF		27
> +#define BM1880_CLK_SDMA_AXI		28
> +#define BM1880_CLK_SDMA_AUD		29
> +#define BM1880_CLK_APB_I2C		30
> +#define BM1880_CLK_APB_WDT		31
> +#define BM1880_CLK_APB_JPEG		32
> +#define BM1880_CLK_JPEG_AXI		33
> +#define BM1880_CLK_AXI5_NF		34
> +#define BM1880_CLK_APB_NF		35
> +#define BM1880_CLK_NF			36
> +#define BM1880_CLK_APB_PWM		37
> +#define BM1880_CLK_DIV_0_RV		38
> +#define BM1880_CLK_DIV_1_RV		39
> +#define BM1880_CLK_MUX_RV		40
> +#define BM1880_CLK_RV			41
> +#define BM1880_CLK_APB_SPI		42
> +#define BM1880_CLK_TPU_AXI		43
> +#define BM1880_CLK_DIV_UART_500M	44
> +#define BM1880_CLK_UART_500M		45
> +#define BM1880_CLK_APB_UART		46
> +#define BM1880_CLK_APB_I2S		47
> +#define BM1880_CLK_AXI4_USB		48
> +#define BM1880_CLK_APB_USB		49
> +#define BM1880_CLK_125M_USB		50
> +#define BM1880_CLK_33K_USB		51
> +#define BM1880_CLK_DIV_12M_USB		52
> +#define BM1880_CLK_12M_USB		53
> +#define BM1880_CLK_APB_VIDEO		54
> +#define BM1880_CLK_VIDEO_AXI		55
> +#define BM1880_CLK_VPP_AXI		56
> +#define BM1880_CLK_APB_VPP		57
> +#define BM1880_CLK_DIV_0_AXI1		58
> +#define BM1880_CLK_DIV_1_AXI1		59
> +#define BM1880_CLK_AXI1			60
> +#define BM1880_CLK_AXI2			61
> +#define BM1880_CLK_AXI3			62
> +#define BM1880_CLK_AXI4			63
> +#define BM1880_CLK_AXI5			64
> +#define BM1880_CLK_DIV_0_AXI6		65
> +#define BM1880_CLK_DIV_1_AXI6		66
> +#define BM1880_CLK_MUX_AXI6		67
> +#define BM1880_CLK_AXI6			68
> +#define BM1880_NR_CLKS			69
> +
> +#endif /* __DT_BINDINGS_CLOCK_BM1880_H */
> -- 
> 2.17.1
> 
