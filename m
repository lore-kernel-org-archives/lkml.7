Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A37BC2D0B1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5167F2073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575489205;
	bh=61d9e5m5Lx24/1swdfOjeWYUJ2v/Ml2x5o9y2l1lSrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wZ0eEtijjLU3ER53WJRqtPrfNCLfrXce7snpvtQwythlvT0hFNHCfcIMq3/AZiqyo
	 veUqJPk2VIhmcx1YsRFk+5oy6BbMhntSHRaw/M106yQ/dEyHqhR2AKKtJ0PrYVNwDK
	 NbdNvGGoo6r8oThoPgkNGkWFf2ptGoLaiM5dY8KE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbfLDTxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 14:53:24 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36039 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbfLDTxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 14:53:23 -0500
Received: by mail-ot1-f67.google.com with SMTP id i4so401329otr.3;
        Wed, 04 Dec 2019 11:53:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VErAFhUGRb0cNxhhu1eTo9w0H41l+9thkMVm9GG9tXc=;
        b=iSdHBsixDHKQiw/XBpcae8rDNYrNDn8B48jhtMP4J+shjdvH+3wwSFJ/t2B7Q0/9pF
         26kKRXxObGqdyWan8JRF3hlpF0kq71djeBZvJD8WdOCeiIJd1GwT7k3HWfPGZ9DSolC/
         hyB/S10DBxQRv1CWJ29cq1VC2OwMJuYLQTOFP9/hRkpvkszRTp+XfwbDbogzrl6NZJRm
         BPcOgoySmQONzbUm/0peUclU2h5eu/Ta8k2Bosn0tlFG0+Y9OVEgThWPvcTjQon/2UK6
         bUtVxpMOW2vw05vwpzIDdqgoUi/KYj7WhXYj81UtiwKLdz3h61UMmhhaUYdvHOp98qFe
         Q2wg==
X-Gm-Message-State: APjAAAXm5cbFOjOZesN8VGXzsYuM4VAAHIhUzK7pxFZ5JihD9us7flKV
        HSXRxDUt8dHPgKOx95gA5Q==
X-Google-Smtp-Source: APXvYqxcpDfq7UKMVa3zk4+HKd/+0nlN8Z8TpaOkq3Ac+qhC2WwGHINTz7n/nZbH9FKtcKaUylVVCg==
X-Received: by 2002:a9d:73c8:: with SMTP id m8mr4065348otk.34.1575489201937;
        Wed, 04 Dec 2019 11:53:21 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r6sm2514506otd.66.2019.12.04.11.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 11:53:21 -0800 (PST)
Date:   Wed, 4 Dec 2019 13:53:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rajan Vaja <rajan.vaja@xilinx.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, mark.rutland@arm.com,
        michal.simek@xilinx.com, jolly.shah@xilinx.com,
        m.tretter@pengutronix.de, gustavo@embeddedor.com,
        dan.carpenter@oracle.com, tejas.patel@xilinx.com,
        nava.manne@xilinx.com, mdf@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/6] dt-bindings: clock: Add bindings for versal clock
 driver
Message-ID: <20191204195320.GA7173@bogus>
References: <1573564580-9006-1-git-send-email-rajan.vaja@xilinx.com>
 <1574415814-19797-1-git-send-email-rajan.vaja@xilinx.com>
 <1574415814-19797-2-git-send-email-rajan.vaja@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574415814-19797-2-git-send-email-rajan.vaja@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 01:43:29AM -0800, Rajan Vaja wrote:
> Add documentation to describe Xilinx Versal clock driver
> bindings.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> ---
> Changes in v2:
>  - Correct description.
>  - Add "select: false" field to avoid failing when firmware schema is
>    available.
>  - Remove "_clk" from clock names.
>  - Remove minItems and maxItems fields.
> 
> NOTE: firmware dt-bindings in yaml format will be added in a separate
>       change and $ref of this yaml to firmware will be added.
> ---
>  .../devicetree/bindings/clock/xlnx,versal-clk.yaml |  64 +++++++++++
>  include/dt-bindings/clock/xlnx-versal-clk.h        | 123 +++++++++++++++++++++
>  2 files changed, 187 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml
>  create mode 100644 include/dt-bindings/clock/xlnx-versal-clk.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml b/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml
> new file mode 100644
> index 0000000..a1f47cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: GPL-2.0

For new bindings: (GPL-2.0-only OR BSD-2-Clause)

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/clock/xlnx,versal-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx Versal clock controller
> +
> +maintainers:
> +  - Michal Simek <michal.simek@xilinx.com>
> +  - Jolly Shah <jolly.shah@xilinx.com>
> +  - Rajan Vaja <rajan.vaja@xilinx.com>
> +
> +description: |
> +  The clock controller is a hardware block of Xilinx versal clock tree. It
> +  reads required input clock frequencies from the devicetree and acts as clock
> +  provider for all clock consumers of PS clocks.
> +
> +select: false
> +
> +properties:
> +  compatible:
> +    const: xlnx,versal-clk
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  clocks:
> +    description: List of clock specifiers which are external input
> +      clocks to the given clock controller.
> +    items:
> +      - description: reference clock
> +      - description: alternate reference clock
> +      - description: alternate reference clock for programmable logic
> +
> +  clock-names:
> +    items:
> +      - const: ref
> +      - const: alt_ref
> +      - const: pl_alt_ref
> +
> +required:
> +  - compatible
> +  - "#clock-cells"
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    firmware {
> +      zynqmp_firmware: zynqmp-firmware {
> +        compatible = "xlnx,zynqmp-firmware";
> +        method = "smc";
> +        versal_clk: clock-controller {
> +          #clock-cells = <1>;
> +          compatible = "xlnx,versal-clk";
> +          clocks = <&ref>, <&alt_ref>, <&pl_alt_ref>;
> +          clock-names = "ref", "alt_ref", "pl_alt_ref";
> +        };
> +      };
> +    };
> +...
> diff --git a/include/dt-bindings/clock/xlnx-versal-clk.h b/include/dt-bindings/clock/xlnx-versal-clk.h
> new file mode 100644
> index 0000000..264d634
> --- /dev/null
> +++ b/include/dt-bindings/clock/xlnx-versal-clk.h
> @@ -0,0 +1,123 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + *  Copyright (C) 2019 Xilinx Inc.
> + *
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_VERSAL_H
> +#define _DT_BINDINGS_CLK_VERSAL_H
> +
> +#define PMC_PLL					1
> +#define APU_PLL					2
> +#define RPU_PLL					3
> +#define CPM_PLL					4
> +#define NOC_PLL					5
> +#define PLL_MAX					6
> +#define PMC_PRESRC				7
> +#define PMC_POSTCLK				8
> +#define PMC_PLL_OUT				9
> +#define PPLL					10
> +#define NOC_PRESRC				11
> +#define NOC_POSTCLK				12
> +#define NOC_PLL_OUT				13
> +#define NPLL					14
> +#define APU_PRESRC				15
> +#define APU_POSTCLK				16
> +#define APU_PLL_OUT				17
> +#define APLL					18
> +#define RPU_PRESRC				19
> +#define RPU_POSTCLK				20
> +#define RPU_PLL_OUT				21
> +#define RPLL					22
> +#define CPM_PRESRC				23
> +#define CPM_POSTCLK				24
> +#define CPM_PLL_OUT				25
> +#define CPLL					26
> +#define PPLL_TO_XPD				27
> +#define NPLL_TO_XPD				28
> +#define APLL_TO_XPD				29
> +#define RPLL_TO_XPD				30
> +#define EFUSE_REF				31
> +#define SYSMON_REF				32
> +#define IRO_SUSPEND_REF				33
> +#define USB_SUSPEND				34
> +#define SWITCH_TIMEOUT				35
> +#define RCLK_PMC				36
> +#define RCLK_LPD				37
> +#define WDT					38
> +#define TTC0					39
> +#define TTC1					40
> +#define TTC2					41
> +#define TTC3					42
> +#define GEM_TSU					43
> +#define GEM_TSU_LB				44
> +#define MUXED_IRO_DIV2				45
> +#define MUXED_IRO_DIV4				46
> +#define PSM_REF					47
> +#define GEM0_RX					48
> +#define GEM0_TX					49
> +#define GEM1_RX					50
> +#define GEM1_TX					51
> +#define CPM_CORE_REF				52
> +#define CPM_LSBUS_REF				53
> +#define CPM_DBG_REF				54
> +#define CPM_AUX0_REF				55
> +#define CPM_AUX1_REF				56
> +#define QSPI_REF				57
> +#define OSPI_REF				58
> +#define SDIO0_REF				59
> +#define SDIO1_REF				60
> +#define PMC_LSBUS_REF				61
> +#define I2C_REF					62
> +#define TEST_PATTERN_REF			63
> +#define DFT_OSC_REF				64
> +#define PMC_PL0_REF				65
> +#define PMC_PL1_REF				66
> +#define PMC_PL2_REF				67
> +#define PMC_PL3_REF				68
> +#define CFU_REF					69
> +#define SPARE_REF				70
> +#define NPI_REF					71
> +#define HSM0_REF				72
> +#define HSM1_REF				73
> +#define SD_DLL_REF				74
> +#define FPD_TOP_SWITCH				75
> +#define FPD_LSBUS				76
> +#define ACPU					77
> +#define DBG_TRACE				78
> +#define DBG_FPD					79
> +#define LPD_TOP_SWITCH				80
> +#define ADMA					81
> +#define LPD_LSBUS				82
> +#define CPU_R5					83
> +#define CPU_R5_CORE				84
> +#define CPU_R5_OCM				85
> +#define CPU_R5_OCM2				86
> +#define IOU_SWITCH				87
> +#define GEM0_REF				88
> +#define GEM1_REF				89
> +#define GEM_TSU_REF				90
> +#define USB0_BUS_REF				91
> +#define UART0_REF				92
> +#define UART1_REF				93
> +#define SPI0_REF				94
> +#define SPI1_REF				95
> +#define CAN0_REF				96
> +#define CAN1_REF				97
> +#define I2C0_REF				98
> +#define I2C1_REF				99
> +#define DBG_LPD					100
> +#define TIMESTAMP_REF				101
> +#define DBG_TSTMP				102
> +#define CPM_TOPSW_REF				103
> +#define USB3_DUAL_REF				104
> +#define OUTCLK_MAX				105
> +#define REF_CLK					106
> +#define PL_ALT_REF_CLK				107
> +#define MUXED_IRO				108
> +#define PL_EXT					109
> +#define PL_LB					110
> +#define MIO_50_OR_51				111
> +#define MIO_24_OR_25				112
> +
> +#endif
> -- 
> 2.7.4
> 
