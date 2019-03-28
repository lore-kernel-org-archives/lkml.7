Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E456BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD772075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553779645;
	bh=dA43GwEQMZP5qZ53qWNW+b18mK1b9WYddSx5M1Ldx40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LOz+sLW7RFpUN+8bVh3WOf+KA5ixZ74FV72LBjYVRPGICRZq9ttJz+xeIGqZvj6yF
	 NkpMpSNa4f7kYJDrCgXpPujfTMjXDTTlS7Kgdyn3N/lWnbhRbqhYt6D49IdLQyCeuX
	 zE2elly4M+gop2rwUSCAy1+PMjQDsPh0Su5J/0+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfC1N1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:27:24 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42096 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1N1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:27:24 -0400
Received: by mail-ot1-f67.google.com with SMTP id 103so18278681otd.9;
        Thu, 28 Mar 2019 06:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=epTSTknOtJPHy+N3mH0LKeWDmRA6grtsFQabr8ys2W4=;
        b=CO1m18gCm5FfS6mzZ4vhBQhdmcATa78oz58iCDsJTjUE2GkfhdUZ8KAHvO4NUY79xH
         McLchWchQvN++lINQ0pw53OiB4JgS/CLal37K8p7ZpIUB9xkVwOZWcrWhz+0SAljFkzP
         B0s4xP17Lx4KUFp+uRz//nKFWah+0m4N6gWPufQodhkho/0vjku7+9XVVP6onG4NSUJw
         vqZyCR+UZQPPAnBh96SPSZvJff1rZJtCH1WSi5HHncDxgn51W7Lh+NuaJl0CiDVQsP0n
         bfJoH5Htf0w2F96kGkN0Dc5UN5ZEn6M81jOaxxqiN4aaMozUfrkvIswEssJrnR8EaMyN
         /M4g==
X-Gm-Message-State: APjAAAUgtqD3XD4nKq3fwLNCtgkbgGc990rCWRU5eHAn2FJsRJvypvTh
        zDNvPG66J1SqbeipSM0iCX7G3mI=
X-Google-Smtp-Source: APXvYqyGo5Lw+JfcfyVj8pAgrI3iGo4VhY7eNHLDFR8PJjeNkKIGoBwuhM68gT9PgexmbGP55CWPzQ==
X-Received: by 2002:a9d:6a1a:: with SMTP id g26mr32073874otn.16.1553779642929;
        Thu, 28 Mar 2019 06:27:22 -0700 (PDT)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id w141sm7042410oie.1.2019.03.28.06.27.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 06:27:22 -0700 (PDT)
Date:   Thu, 28 Mar 2019 08:27:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 08/14] clk: sunxi-ng: v3s: add Allwinner V3 support
Message-ID: <20190328132721.GA32178@bogus>
References: <20190312152256.35574-1-icenowy@aosc.io>
 <20190312152256.35574-9-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312152256.35574-9-icenowy@aosc.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 11:22:50PM +0800, Icenowy Zheng wrote:
> Allwinner V3 has the same main die with V3s, but with more pins wired.
> There's a I2S bus on V3 that is not available on V3s.
> 
> Add the V3-only peripheral's clocks and reset to the V3s CCU driver,
> bound to a new V3 compatible string. The driver name is not changed
> because it's part of the device tree binding (the header file name).
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/clk/sunxi-ng/ccu-sun8i-v3s.c      | 225 +++++++++++++++++++++-
>  drivers/clk/sunxi-ng/ccu-sun8i-v3s.h      |   2 +-
>  include/dt-bindings/clock/sun8i-v3s-ccu.h |   4 +
>  include/dt-bindings/reset/sun8i-v3s-ccu.h |   3 +
>  4 files changed, 231 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
> index cbba04f5f761..81450ea8faa2 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
> @@ -242,6 +242,8 @@ static SUNXI_CCU_GATE(bus_codec_clk,	"bus-codec",	"apb1",
>  		      0x068, BIT(0), 0);
>  static SUNXI_CCU_GATE(bus_pio_clk,	"bus-pio",	"apb1",
>  		      0x068, BIT(5), 0);
> +static SUNXI_CCU_GATE(bus_i2s0_clk,	"bus-i2s0",	"apb1",
> +		      0x068, BIT(12), 0);
>  
>  static SUNXI_CCU_GATE(bus_i2c0_clk,	"bus-i2c0",	"apb2",
>  		      0x06c, BIT(0), 0);
> @@ -313,6 +315,11 @@ static SUNXI_CCU_MP_WITH_MUX_GATE(spi0_clk, "spi0", mod0_default_parents, 0x0a0,
>  				  BIT(31),	/* gate */
>  				  0);
>  
> +static const char * const i2s_parents[] = { "pll-audio-8x", "pll-audio-4x",
> +					    "pll-audio-2x", "pll-audio" };
> +static SUNXI_CCU_MUX_WITH_GATE(i2s0_clk, "i2s0", i2s_parents,
> +			       0x0b0, 16, 2, BIT(31), CLK_SET_RATE_PARENT);
> +
>  static SUNXI_CCU_GATE(usb_phy0_clk,	"usb-phy0",	"osc24M",
>  		      0x0cc, BIT(8), 0);
>  static SUNXI_CCU_GATE(usb_ohci0_clk,	"usb-ohci0",	"osc24M",
> @@ -445,6 +452,80 @@ static struct ccu_common *sun8i_v3s_ccu_clks[] = {
>  	&mipi_csi_clk.common,
>  };
>  
> +static struct ccu_common *sun8i_v3_ccu_clks[] = {

Seems like a bunch of duplication for just 2 differences in clocks. 
Can't you keep the definitions the same and just skip registering the 
clocks not present?

> +	&pll_cpu_clk.common,
> +	&pll_audio_base_clk.common,
> +	&pll_video_clk.common,
> +	&pll_ve_clk.common,
> +	&pll_ddr0_clk.common,
> +	&pll_periph0_clk.common,
> +	&pll_isp_clk.common,
> +	&pll_periph1_clk.common,
> +	&pll_ddr1_clk.common,
> +	&cpu_clk.common,
> +	&axi_clk.common,
> +	&ahb1_clk.common,
> +	&apb1_clk.common,
> +	&apb2_clk.common,
> +	&ahb2_clk.common,
> +	&bus_ce_clk.common,
> +	&bus_dma_clk.common,
> +	&bus_mmc0_clk.common,
> +	&bus_mmc1_clk.common,
> +	&bus_mmc2_clk.common,
> +	&bus_dram_clk.common,
> +	&bus_emac_clk.common,
> +	&bus_hstimer_clk.common,
> +	&bus_spi0_clk.common,
> +	&bus_otg_clk.common,
> +	&bus_ehci0_clk.common,
> +	&bus_ohci0_clk.common,
> +	&bus_ve_clk.common,
> +	&bus_tcon0_clk.common,
> +	&bus_csi_clk.common,
> +	&bus_de_clk.common,
> +	&bus_codec_clk.common,
> +	&bus_pio_clk.common,
> +	&bus_i2s0_clk.common,
> +	&bus_i2c0_clk.common,
> +	&bus_i2c1_clk.common,
> +	&bus_uart0_clk.common,
> +	&bus_uart1_clk.common,
> +	&bus_uart2_clk.common,
> +	&bus_ephy_clk.common,
> +	&bus_dbg_clk.common,
> +	&mmc0_clk.common,
> +	&mmc0_sample_clk.common,
> +	&mmc0_output_clk.common,
> +	&mmc1_clk.common,
> +	&mmc1_sample_clk.common,
> +	&mmc1_output_clk.common,
> +	&mmc2_clk.common,
> +	&mmc2_sample_clk.common,
> +	&mmc2_output_clk.common,
> +	&ce_clk.common,
> +	&spi0_clk.common,
> +	&i2s0_clk.common,
> +	&usb_phy0_clk.common,
> +	&usb_ohci0_clk.common,
> +	&dram_clk.common,
> +	&dram_ve_clk.common,
> +	&dram_csi_clk.common,
> +	&dram_ohci_clk.common,
> +	&dram_ehci_clk.common,
> +	&de_clk.common,
> +	&tcon_clk.common,
> +	&csi_misc_clk.common,
> +	&csi0_mclk_clk.common,
> +	&csi1_sclk_clk.common,
> +	&csi1_mclk_clk.common,
> +	&ve_clk.common,
> +	&ac_dig_clk.common,
> +	&avs_clk.common,
> +	&mbus_clk.common,
> +	&mipi_csi_clk.common,
> +};
> +
>  /* We hardcode the divider to 4 for now */
>  static CLK_FIXED_FACTOR(pll_audio_clk, "pll-audio",
>  			"pll-audio-base", 4, 1, CLK_SET_RATE_PARENT);
> @@ -534,6 +615,85 @@ static struct clk_hw_onecell_data sun8i_v3s_hw_clks = {
>  	.num	= CLK_NUMBER,
>  };
>  
> +static struct clk_hw_onecell_data sun8i_v3_hw_clks = {
> +	.hws	= {
> +		[CLK_PLL_CPU]		= &pll_cpu_clk.common.hw,
> +		[CLK_PLL_AUDIO_BASE]	= &pll_audio_base_clk.common.hw,
> +		[CLK_PLL_AUDIO]		= &pll_audio_clk.hw,
> +		[CLK_PLL_AUDIO_2X]	= &pll_audio_2x_clk.hw,
> +		[CLK_PLL_AUDIO_4X]	= &pll_audio_4x_clk.hw,
> +		[CLK_PLL_AUDIO_8X]	= &pll_audio_8x_clk.hw,
> +		[CLK_PLL_VIDEO]		= &pll_video_clk.common.hw,
> +		[CLK_PLL_VE]		= &pll_ve_clk.common.hw,
> +		[CLK_PLL_DDR0]		= &pll_ddr0_clk.common.hw,
> +		[CLK_PLL_PERIPH0]	= &pll_periph0_clk.common.hw,
> +		[CLK_PLL_PERIPH0_2X]	= &pll_periph0_2x_clk.hw,
> +		[CLK_PLL_ISP]		= &pll_isp_clk.common.hw,
> +		[CLK_PLL_PERIPH1]	= &pll_periph1_clk.common.hw,
> +		[CLK_PLL_DDR1]		= &pll_ddr1_clk.common.hw,
> +		[CLK_CPU]		= &cpu_clk.common.hw,
> +		[CLK_AXI]		= &axi_clk.common.hw,
> +		[CLK_AHB1]		= &ahb1_clk.common.hw,
> +		[CLK_APB1]		= &apb1_clk.common.hw,
> +		[CLK_APB2]		= &apb2_clk.common.hw,
> +		[CLK_AHB2]		= &ahb2_clk.common.hw,
> +		[CLK_BUS_CE]		= &bus_ce_clk.common.hw,
> +		[CLK_BUS_DMA]		= &bus_dma_clk.common.hw,
> +		[CLK_BUS_MMC0]		= &bus_mmc0_clk.common.hw,
> +		[CLK_BUS_MMC1]		= &bus_mmc1_clk.common.hw,
> +		[CLK_BUS_MMC2]		= &bus_mmc2_clk.common.hw,
> +		[CLK_BUS_DRAM]		= &bus_dram_clk.common.hw,
> +		[CLK_BUS_EMAC]		= &bus_emac_clk.common.hw,
> +		[CLK_BUS_HSTIMER]	= &bus_hstimer_clk.common.hw,
> +		[CLK_BUS_SPI0]		= &bus_spi0_clk.common.hw,
> +		[CLK_BUS_OTG]		= &bus_otg_clk.common.hw,
> +		[CLK_BUS_EHCI0]		= &bus_ehci0_clk.common.hw,
> +		[CLK_BUS_OHCI0]		= &bus_ohci0_clk.common.hw,
> +		[CLK_BUS_VE]		= &bus_ve_clk.common.hw,
> +		[CLK_BUS_TCON0]		= &bus_tcon0_clk.common.hw,
> +		[CLK_BUS_CSI]		= &bus_csi_clk.common.hw,
> +		[CLK_BUS_DE]		= &bus_de_clk.common.hw,
> +		[CLK_BUS_CODEC]		= &bus_codec_clk.common.hw,
> +		[CLK_BUS_PIO]		= &bus_pio_clk.common.hw,
> +		[CLK_BUS_I2S0]		= &bus_i2s0_clk.common.hw,
> +		[CLK_BUS_I2C0]		= &bus_i2c0_clk.common.hw,
> +		[CLK_BUS_I2C1]		= &bus_i2c1_clk.common.hw,
> +		[CLK_BUS_UART0]		= &bus_uart0_clk.common.hw,
> +		[CLK_BUS_UART1]		= &bus_uart1_clk.common.hw,
> +		[CLK_BUS_UART2]		= &bus_uart2_clk.common.hw,
> +		[CLK_BUS_EPHY]		= &bus_ephy_clk.common.hw,
> +		[CLK_BUS_DBG]		= &bus_dbg_clk.common.hw,
> +		[CLK_MMC0]		= &mmc0_clk.common.hw,
> +		[CLK_MMC0_SAMPLE]	= &mmc0_sample_clk.common.hw,
> +		[CLK_MMC0_OUTPUT]	= &mmc0_output_clk.common.hw,
> +		[CLK_MMC1]		= &mmc1_clk.common.hw,
> +		[CLK_MMC1_SAMPLE]	= &mmc1_sample_clk.common.hw,
> +		[CLK_MMC1_OUTPUT]	= &mmc1_output_clk.common.hw,
> +		[CLK_CE]		= &ce_clk.common.hw,
> +		[CLK_SPI0]		= &spi0_clk.common.hw,
> +		[CLK_I2S0]		= &i2s0_clk.common.hw,
> +		[CLK_USB_PHY0]		= &usb_phy0_clk.common.hw,
> +		[CLK_USB_OHCI0]		= &usb_ohci0_clk.common.hw,
> +		[CLK_DRAM]		= &dram_clk.common.hw,
> +		[CLK_DRAM_VE]		= &dram_ve_clk.common.hw,
> +		[CLK_DRAM_CSI]		= &dram_csi_clk.common.hw,
> +		[CLK_DRAM_EHCI]		= &dram_ehci_clk.common.hw,
> +		[CLK_DRAM_OHCI]		= &dram_ohci_clk.common.hw,
> +		[CLK_DE]		= &de_clk.common.hw,
> +		[CLK_TCON0]		= &tcon_clk.common.hw,
> +		[CLK_CSI_MISC]		= &csi_misc_clk.common.hw,
> +		[CLK_CSI0_MCLK]		= &csi0_mclk_clk.common.hw,
> +		[CLK_CSI1_SCLK]		= &csi1_sclk_clk.common.hw,
> +		[CLK_CSI1_MCLK]		= &csi1_mclk_clk.common.hw,
> +		[CLK_VE]		= &ve_clk.common.hw,
> +		[CLK_AC_DIG]		= &ac_dig_clk.common.hw,
> +		[CLK_AVS]		= &avs_clk.common.hw,
> +		[CLK_MBUS]		= &mbus_clk.common.hw,
> +		[CLK_MIPI_CSI]		= &mipi_csi_clk.common.hw,
> +	},
> +	.num	= CLK_NUMBER,
> +};
> +
>  static struct ccu_reset_map sun8i_v3s_ccu_resets[] = {
>  	[RST_USB_PHY0]		=  { 0x0cc, BIT(0) },
>  
> @@ -569,6 +729,42 @@ static struct ccu_reset_map sun8i_v3s_ccu_resets[] = {
>  	[RST_BUS_UART2]		=  { 0x2d8, BIT(18) },
>  };
>  
> +static struct ccu_reset_map sun8i_v3_ccu_resets[] = {
> +	[RST_USB_PHY0]		=  { 0x0cc, BIT(0) },
> +
> +	[RST_MBUS]		=  { 0x0fc, BIT(31) },
> +
> +	[RST_BUS_CE]		=  { 0x2c0, BIT(5) },
> +	[RST_BUS_DMA]		=  { 0x2c0, BIT(6) },
> +	[RST_BUS_MMC0]		=  { 0x2c0, BIT(8) },
> +	[RST_BUS_MMC1]		=  { 0x2c0, BIT(9) },
> +	[RST_BUS_MMC2]		=  { 0x2c0, BIT(10) },
> +	[RST_BUS_DRAM]		=  { 0x2c0, BIT(14) },
> +	[RST_BUS_EMAC]		=  { 0x2c0, BIT(17) },
> +	[RST_BUS_HSTIMER]	=  { 0x2c0, BIT(19) },
> +	[RST_BUS_SPI0]		=  { 0x2c0, BIT(20) },
> +	[RST_BUS_OTG]		=  { 0x2c0, BIT(24) },
> +	[RST_BUS_EHCI0]		=  { 0x2c0, BIT(26) },
> +	[RST_BUS_OHCI0]		=  { 0x2c0, BIT(29) },
> +
> +	[RST_BUS_VE]		=  { 0x2c4, BIT(0) },
> +	[RST_BUS_TCON0]		=  { 0x2c4, BIT(4) },
> +	[RST_BUS_CSI]		=  { 0x2c4, BIT(8) },
> +	[RST_BUS_DE]		=  { 0x2c4, BIT(12) },
> +	[RST_BUS_DBG]		=  { 0x2c4, BIT(31) },
> +
> +	[RST_BUS_EPHY]		=  { 0x2c8, BIT(2) },
> +
> +	[RST_BUS_CODEC]		=  { 0x2d0, BIT(0) },
> +	[RST_BUS_I2S0]		=  { 0x2d0, BIT(12) },
> +
> +	[RST_BUS_I2C0]		=  { 0x2d8, BIT(0) },
> +	[RST_BUS_I2C1]		=  { 0x2d8, BIT(1) },
> +	[RST_BUS_UART0]		=  { 0x2d8, BIT(16) },
> +	[RST_BUS_UART1]		=  { 0x2d8, BIT(17) },
> +	[RST_BUS_UART2]		=  { 0x2d8, BIT(18) },
> +};
> +
>  static const struct sunxi_ccu_desc sun8i_v3s_ccu_desc = {
>  	.ccu_clks	= sun8i_v3s_ccu_clks,
>  	.num_ccu_clks	= ARRAY_SIZE(sun8i_v3s_ccu_clks),
> @@ -579,7 +775,18 @@ static const struct sunxi_ccu_desc sun8i_v3s_ccu_desc = {
>  	.num_resets	= ARRAY_SIZE(sun8i_v3s_ccu_resets),
>  };
>  
> -static void __init sun8i_v3s_ccu_setup(struct device_node *node)
> +static const struct sunxi_ccu_desc sun8i_v3_ccu_desc = {
> +	.ccu_clks	= sun8i_v3_ccu_clks,
> +	.num_ccu_clks	= ARRAY_SIZE(sun8i_v3_ccu_clks),
> +
> +	.hw_clks	= &sun8i_v3_hw_clks,
> +
> +	.resets		= sun8i_v3_ccu_resets,
> +	.num_resets	= ARRAY_SIZE(sun8i_v3_ccu_resets),
> +};
> +
> +static void __init sun8i_v3_v3s_ccu_init(struct device_node *node,
> +					 const struct sunxi_ccu_desc *ccu_desc)
>  {
>  	void __iomem *reg;
>  	u32 val;
> @@ -595,7 +802,21 @@ static void __init sun8i_v3s_ccu_setup(struct device_node *node)
>  	val &= ~GENMASK(19, 16);
>  	writel(val | (3 << 16), reg + SUN8I_V3S_PLL_AUDIO_REG);
>  
> -	sunxi_ccu_probe(node, reg, &sun8i_v3s_ccu_desc);
> +	sunxi_ccu_probe(node, reg, ccu_desc);
> +}
> +
> +static void __init sun8i_v3s_ccu_setup(struct device_node *node)
> +{
> +	sun8i_v3_v3s_ccu_init(node, &sun8i_v3s_ccu_desc);
> +}
> +
> +static void __init sun8i_v3_ccu_setup(struct device_node *node)
> +{
> +	sun8i_v3_v3s_ccu_init(node, &sun8i_v3_ccu_desc);
>  }
> +
>  CLK_OF_DECLARE(sun8i_v3s_ccu, "allwinner,sun8i-v3s-ccu",
>  	       sun8i_v3s_ccu_setup);
> +
> +CLK_OF_DECLARE(sun8i_v3_ccu, "allwinner,sun8i-v3-ccu",
> +	       sun8i_v3_ccu_setup);
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.h b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.h
> index a091b7217dfd..578485d85cd2 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.h
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.h
> @@ -60,6 +60,6 @@
>  
>  #define CLK_PLL_DDR1		74
>  
> -#define CLK_NUMBER		(CLK_PLL_DDR1 + 1)
> +#define CLK_NUMBER		(CLK_I2S0 + 1)
>  
>  #endif /* _CCU_SUN8I_H3_H_ */
> diff --git a/include/dt-bindings/clock/sun8i-v3s-ccu.h b/include/dt-bindings/clock/sun8i-v3s-ccu.h
> index c0d5d5599c87..014ac6123d17 100644
> --- a/include/dt-bindings/clock/sun8i-v3s-ccu.h
> +++ b/include/dt-bindings/clock/sun8i-v3s-ccu.h
> @@ -104,4 +104,8 @@
>  
>  #define CLK_MIPI_CSI		73
>  
> +/* Clocks not available on V3s */

Perhaps reword as 'Clocks only on V3'

> +#define CLK_BUS_I2S0		75
> +#define CLK_I2S0		76
> +
>  #endif /* _DT_BINDINGS_CLK_SUN8I_V3S_H_ */
> diff --git a/include/dt-bindings/reset/sun8i-v3s-ccu.h b/include/dt-bindings/reset/sun8i-v3s-ccu.h
> index b58ef21a2e18..b6790173afd6 100644
> --- a/include/dt-bindings/reset/sun8i-v3s-ccu.h
> +++ b/include/dt-bindings/reset/sun8i-v3s-ccu.h
> @@ -75,4 +75,7 @@
>  #define RST_BUS_UART1		50
>  #define RST_BUS_UART2		51
>  
> +/* Reset lines not available on V3s */
> +#define RST_BUS_I2S0		52
> +
>  #endif /* _DT_BINDINGS_RST_SUN8I_H3_H_ */
> -- 
> 2.18.1
> 
