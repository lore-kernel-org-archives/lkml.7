Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C47DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553B52146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MDTXjXvw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfCSVwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:52:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40767 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfCSVwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:52:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id u10so15599161wmj.5;
        Tue, 19 Mar 2019 14:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wP2Vx5x57j3vZz7n2bHZ/YzUvPSJARlLffs/IRms6p8=;
        b=MDTXjXvw8r3DMn05nAGGAm0Sh7XHDfjEf2WRlFCa6p3K5zME/z0eAd96UOkim8yqYK
         B5ctPqDvgM8PuyPVMU0Kp37nww7rCmL3+5gDdo/dAr1DbEppqrLS/TTI1C3pcn85ZFJk
         9QgFwaBok1GsOXUdeXj/qI+wEK7vgihms+2lXqpdMieCJkUPhMmOoJAvUBfPMzL7xiJ2
         I2tshB9jW2mbsqUfyccvuc/06UpIJRQvkknsRY7/z8oyYPXP89uQTurdCkBJ7Bkgp8PK
         5esvJcCw90hz/NrFwJ7LyJ/mGWuzXYVW6UZP87MS6XBrC4tzy8xN+S1RAg9ZPR/femHo
         Gm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wP2Vx5x57j3vZz7n2bHZ/YzUvPSJARlLffs/IRms6p8=;
        b=KuRLd+S+wtdM07MX6FP2Wx4wafyxfjs/hczPk5NHJ4Pu6cWcnqNzvvKLfWm5hy5IlD
         riFfyWlAMwlmjGvx+TgJQuo2dVXDYD+jAT1BWdwnP1qWjSRprfIk/ztINAmSgwhdkbeH
         lPA6jDQ183x9Q+ZXTedlafSgduizAS9bD2jjgNqb8xNlt9+NW+8bZFsPGHzVXu9IjCMa
         tFhsz743bi5uoZ9BPAPW3Bq//FrhhWP1Uggy20SazEVq8J2ssZwD0VEfsJkCB+5tw/9c
         Is8PX4/cDXJajGwdeIuqdpm+p1wXoe44Ktuvksy/AdOqQ2H6/++TuNkxq6ZU4VrSpgkG
         BO6Q==
X-Gm-Message-State: APjAAAW3dt4NLqgTTX+9SRRGbhDVkSKUryd+Ta3i1bTM+cNcVMVgWUnW
        FHwAgsmfNsewh5fXrR5S0dO/2aCO
X-Google-Smtp-Source: APXvYqxXq2LaBTTqcLpVYH7nUQ0rJ9GhqrWgmPQsxz7RlF8G1u/+xnxx0aKA1GFOebzcNGw5RTWDhA==
X-Received: by 2002:a1c:7a1a:: with SMTP id v26mr5167831wmc.129.1553032323034;
        Tue, 19 Mar 2019 14:52:03 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD739990039EE738515149D3E.dip0.t-ipconnect.de. [2003:dc:d739:9900:39ee:7385:1514:9d3e])
        by smtp.googlemail.com with ESMTPSA id c8sm56050wrx.6.2019.03.19.14.52.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 14:52:02 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/4] clk: meson: meson8b: use a sparate clock table for Meson8m2
Date:   Tue, 19 Mar 2019 22:51:19 +0100
Message-Id: <20190319215121.29340-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319215121.29340-1-martin.blumenstingl@googlemail.com>
References: <20190319215121.29340-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Meson8, Meson8b and Meson8m2 implement a similar clock controller.
However, there are a few differences between the three actual IP blocks.

One example where Meson8m2 differs from Meson8b is the VPU clock setup:
- the VPU input mux can choose between "fclk_div4", "fclk_div3",
  "fclk_div5" and "fclk_div7" on Meson8b
- however, on Meson8m2 it can choose between "fclk_div4", "fclk_div3",
  "fclk_div5" and "gp_pll" (GP_PLL only exists on Meson8m2, it's the
  predecessor of the GP0_PLL clock on GXBB/GXL/GXM))

Add a separate clk_hw_onecell_data table for Meson8m2 so these
differences can be implemented in our clock controller driver. For now
meson8m2_hw_onecell_data is a clone of our existing
meson8b_hw_onecell_data.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 193 +++++++++++++++++++++++++++++++++++-
 1 file changed, 192 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 576ad42252d0..c9e6ec67d649 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -2157,6 +2157,192 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
 	.num = CLK_NR_CLKS,
 };
 
+static struct clk_hw_onecell_data meson8m2_hw_onecell_data = {
+	.hws = {
+		[CLKID_XTAL] = &meson8b_xtal.hw,
+		[CLKID_PLL_FIXED] = &meson8b_fixed_pll.hw,
+		[CLKID_PLL_VID] = &meson8b_vid_pll.hw,
+		[CLKID_PLL_SYS] = &meson8b_sys_pll.hw,
+		[CLKID_FCLK_DIV2] = &meson8b_fclk_div2.hw,
+		[CLKID_FCLK_DIV3] = &meson8b_fclk_div3.hw,
+		[CLKID_FCLK_DIV4] = &meson8b_fclk_div4.hw,
+		[CLKID_FCLK_DIV5] = &meson8b_fclk_div5.hw,
+		[CLKID_FCLK_DIV7] = &meson8b_fclk_div7.hw,
+		[CLKID_CPUCLK] = &meson8b_cpu_clk.hw,
+		[CLKID_MPEG_SEL] = &meson8b_mpeg_clk_sel.hw,
+		[CLKID_MPEG_DIV] = &meson8b_mpeg_clk_div.hw,
+		[CLKID_CLK81] = &meson8b_clk81.hw,
+		[CLKID_DDR]		    = &meson8b_ddr.hw,
+		[CLKID_DOS]		    = &meson8b_dos.hw,
+		[CLKID_ISA]		    = &meson8b_isa.hw,
+		[CLKID_PL301]		    = &meson8b_pl301.hw,
+		[CLKID_PERIPHS]		    = &meson8b_periphs.hw,
+		[CLKID_SPICC]		    = &meson8b_spicc.hw,
+		[CLKID_I2C]		    = &meson8b_i2c.hw,
+		[CLKID_SAR_ADC]		    = &meson8b_sar_adc.hw,
+		[CLKID_SMART_CARD]	    = &meson8b_smart_card.hw,
+		[CLKID_RNG0]		    = &meson8b_rng0.hw,
+		[CLKID_UART0]		    = &meson8b_uart0.hw,
+		[CLKID_SDHC]		    = &meson8b_sdhc.hw,
+		[CLKID_STREAM]		    = &meson8b_stream.hw,
+		[CLKID_ASYNC_FIFO]	    = &meson8b_async_fifo.hw,
+		[CLKID_SDIO]		    = &meson8b_sdio.hw,
+		[CLKID_ABUF]		    = &meson8b_abuf.hw,
+		[CLKID_HIU_IFACE]	    = &meson8b_hiu_iface.hw,
+		[CLKID_ASSIST_MISC]	    = &meson8b_assist_misc.hw,
+		[CLKID_SPI]		    = &meson8b_spi.hw,
+		[CLKID_I2S_SPDIF]	    = &meson8b_i2s_spdif.hw,
+		[CLKID_ETH]		    = &meson8b_eth.hw,
+		[CLKID_DEMUX]		    = &meson8b_demux.hw,
+		[CLKID_AIU_GLUE]	    = &meson8b_aiu_glue.hw,
+		[CLKID_IEC958]		    = &meson8b_iec958.hw,
+		[CLKID_I2S_OUT]		    = &meson8b_i2s_out.hw,
+		[CLKID_AMCLK]		    = &meson8b_amclk.hw,
+		[CLKID_AIFIFO2]		    = &meson8b_aififo2.hw,
+		[CLKID_MIXER]		    = &meson8b_mixer.hw,
+		[CLKID_MIXER_IFACE]	    = &meson8b_mixer_iface.hw,
+		[CLKID_ADC]		    = &meson8b_adc.hw,
+		[CLKID_BLKMV]		    = &meson8b_blkmv.hw,
+		[CLKID_AIU]		    = &meson8b_aiu.hw,
+		[CLKID_UART1]		    = &meson8b_uart1.hw,
+		[CLKID_G2D]		    = &meson8b_g2d.hw,
+		[CLKID_USB0]		    = &meson8b_usb0.hw,
+		[CLKID_USB1]		    = &meson8b_usb1.hw,
+		[CLKID_RESET]		    = &meson8b_reset.hw,
+		[CLKID_NAND]		    = &meson8b_nand.hw,
+		[CLKID_DOS_PARSER]	    = &meson8b_dos_parser.hw,
+		[CLKID_USB]		    = &meson8b_usb.hw,
+		[CLKID_VDIN1]		    = &meson8b_vdin1.hw,
+		[CLKID_AHB_ARB0]	    = &meson8b_ahb_arb0.hw,
+		[CLKID_EFUSE]		    = &meson8b_efuse.hw,
+		[CLKID_BOOT_ROM]	    = &meson8b_boot_rom.hw,
+		[CLKID_AHB_DATA_BUS]	    = &meson8b_ahb_data_bus.hw,
+		[CLKID_AHB_CTRL_BUS]	    = &meson8b_ahb_ctrl_bus.hw,
+		[CLKID_HDMI_INTR_SYNC]	    = &meson8b_hdmi_intr_sync.hw,
+		[CLKID_HDMI_PCLK]	    = &meson8b_hdmi_pclk.hw,
+		[CLKID_USB1_DDR_BRIDGE]	    = &meson8b_usb1_ddr_bridge.hw,
+		[CLKID_USB0_DDR_BRIDGE]	    = &meson8b_usb0_ddr_bridge.hw,
+		[CLKID_MMC_PCLK]	    = &meson8b_mmc_pclk.hw,
+		[CLKID_DVIN]		    = &meson8b_dvin.hw,
+		[CLKID_UART2]		    = &meson8b_uart2.hw,
+		[CLKID_SANA]		    = &meson8b_sana.hw,
+		[CLKID_VPU_INTR]	    = &meson8b_vpu_intr.hw,
+		[CLKID_SEC_AHB_AHB3_BRIDGE] = &meson8b_sec_ahb_ahb3_bridge.hw,
+		[CLKID_CLK81_A9]	    = &meson8b_clk81_a9.hw,
+		[CLKID_VCLK2_VENCI0]	    = &meson8b_vclk2_venci0.hw,
+		[CLKID_VCLK2_VENCI1]	    = &meson8b_vclk2_venci1.hw,
+		[CLKID_VCLK2_VENCP0]	    = &meson8b_vclk2_vencp0.hw,
+		[CLKID_VCLK2_VENCP1]	    = &meson8b_vclk2_vencp1.hw,
+		[CLKID_GCLK_VENCI_INT]	    = &meson8b_gclk_venci_int.hw,
+		[CLKID_GCLK_VENCP_INT]	    = &meson8b_gclk_vencp_int.hw,
+		[CLKID_DAC_CLK]		    = &meson8b_dac_clk.hw,
+		[CLKID_AOCLK_GATE]	    = &meson8b_aoclk_gate.hw,
+		[CLKID_IEC958_GATE]	    = &meson8b_iec958_gate.hw,
+		[CLKID_ENC480P]		    = &meson8b_enc480p.hw,
+		[CLKID_RNG1]		    = &meson8b_rng1.hw,
+		[CLKID_GCLK_VENCL_INT]	    = &meson8b_gclk_vencl_int.hw,
+		[CLKID_VCLK2_VENCLMCC]	    = &meson8b_vclk2_venclmcc.hw,
+		[CLKID_VCLK2_VENCL]	    = &meson8b_vclk2_vencl.hw,
+		[CLKID_VCLK2_OTHER]	    = &meson8b_vclk2_other.hw,
+		[CLKID_EDP]		    = &meson8b_edp.hw,
+		[CLKID_AO_MEDIA_CPU]	    = &meson8b_ao_media_cpu.hw,
+		[CLKID_AO_AHB_SRAM]	    = &meson8b_ao_ahb_sram.hw,
+		[CLKID_AO_AHB_BUS]	    = &meson8b_ao_ahb_bus.hw,
+		[CLKID_AO_IFACE]	    = &meson8b_ao_iface.hw,
+		[CLKID_MPLL0]		    = &meson8b_mpll0.hw,
+		[CLKID_MPLL1]		    = &meson8b_mpll1.hw,
+		[CLKID_MPLL2]		    = &meson8b_mpll2.hw,
+		[CLKID_MPLL0_DIV]	    = &meson8b_mpll0_div.hw,
+		[CLKID_MPLL1_DIV]	    = &meson8b_mpll1_div.hw,
+		[CLKID_MPLL2_DIV]	    = &meson8b_mpll2_div.hw,
+		[CLKID_CPU_IN_SEL]	    = &meson8b_cpu_in_sel.hw,
+		[CLKID_CPU_IN_DIV2]	    = &meson8b_cpu_in_div2.hw,
+		[CLKID_CPU_IN_DIV3]	    = &meson8b_cpu_in_div3.hw,
+		[CLKID_CPU_SCALE_DIV]	    = &meson8b_cpu_scale_div.hw,
+		[CLKID_CPU_SCALE_OUT_SEL]   = &meson8b_cpu_scale_out_sel.hw,
+		[CLKID_MPLL_PREDIV]	    = &meson8b_mpll_prediv.hw,
+		[CLKID_FCLK_DIV2_DIV]	    = &meson8b_fclk_div2_div.hw,
+		[CLKID_FCLK_DIV3_DIV]	    = &meson8b_fclk_div3_div.hw,
+		[CLKID_FCLK_DIV4_DIV]	    = &meson8b_fclk_div4_div.hw,
+		[CLKID_FCLK_DIV5_DIV]	    = &meson8b_fclk_div5_div.hw,
+		[CLKID_FCLK_DIV7_DIV]	    = &meson8b_fclk_div7_div.hw,
+		[CLKID_NAND_SEL]	    = &meson8b_nand_clk_sel.hw,
+		[CLKID_NAND_DIV]	    = &meson8b_nand_clk_div.hw,
+		[CLKID_NAND_CLK]	    = &meson8b_nand_clk_gate.hw,
+		[CLKID_PLL_FIXED_DCO]	    = &meson8b_fixed_pll_dco.hw,
+		[CLKID_HDMI_PLL_DCO]	    = &meson8b_hdmi_pll_dco.hw,
+		[CLKID_PLL_SYS_DCO]	    = &meson8b_sys_pll_dco.hw,
+		[CLKID_CPU_CLK_DIV2]	    = &meson8b_cpu_clk_div2.hw,
+		[CLKID_CPU_CLK_DIV3]	    = &meson8b_cpu_clk_div3.hw,
+		[CLKID_CPU_CLK_DIV4]	    = &meson8b_cpu_clk_div4.hw,
+		[CLKID_CPU_CLK_DIV5]	    = &meson8b_cpu_clk_div5.hw,
+		[CLKID_CPU_CLK_DIV6]	    = &meson8b_cpu_clk_div6.hw,
+		[CLKID_CPU_CLK_DIV7]	    = &meson8b_cpu_clk_div7.hw,
+		[CLKID_CPU_CLK_DIV8]	    = &meson8b_cpu_clk_div8.hw,
+		[CLKID_APB_SEL]		    = &meson8b_apb_clk_sel.hw,
+		[CLKID_APB]		    = &meson8b_apb_clk_gate.hw,
+		[CLKID_PERIPH_SEL]	    = &meson8b_periph_clk_sel.hw,
+		[CLKID_PERIPH]		    = &meson8b_periph_clk_gate.hw,
+		[CLKID_AXI_SEL]		    = &meson8b_axi_clk_sel.hw,
+		[CLKID_AXI]		    = &meson8b_axi_clk_gate.hw,
+		[CLKID_L2_DRAM_SEL]	    = &meson8b_l2_dram_clk_sel.hw,
+		[CLKID_L2_DRAM]		    = &meson8b_l2_dram_clk_gate.hw,
+		[CLKID_HDMI_PLL_LVDS_OUT]   = &meson8b_hdmi_pll_lvds_out.hw,
+		[CLKID_HDMI_PLL_HDMI_OUT]   = &meson8b_hdmi_pll_hdmi_out.hw,
+		[CLKID_VID_PLL_IN_SEL]	    = &meson8b_vid_pll_in_sel.hw,
+		[CLKID_VID_PLL_IN_EN]	    = &meson8b_vid_pll_in_en.hw,
+		[CLKID_VID_PLL_PRE_DIV]	    = &meson8b_vid_pll_pre_div.hw,
+		[CLKID_VID_PLL_POST_DIV]    = &meson8b_vid_pll_post_div.hw,
+		[CLKID_VID_PLL_FINAL_DIV]   = &meson8b_vid_pll_final_div.hw,
+		[CLKID_VCLK_IN_SEL]	    = &meson8b_vclk_in_sel.hw,
+		[CLKID_VCLK_IN_EN]	    = &meson8b_vclk_in_en.hw,
+		[CLKID_VCLK_DIV1]	    = &meson8b_vclk_div1_gate.hw,
+		[CLKID_VCLK_DIV2_DIV]	    = &meson8b_vclk_div2_div.hw,
+		[CLKID_VCLK_DIV2]	    = &meson8b_vclk_div2_div_gate.hw,
+		[CLKID_VCLK_DIV4_DIV]	    = &meson8b_vclk_div4_div.hw,
+		[CLKID_VCLK_DIV4]	    = &meson8b_vclk_div4_div_gate.hw,
+		[CLKID_VCLK_DIV6_DIV]	    = &meson8b_vclk_div6_div.hw,
+		[CLKID_VCLK_DIV6]	    = &meson8b_vclk_div6_div_gate.hw,
+		[CLKID_VCLK_DIV12_DIV]	    = &meson8b_vclk_div12_div.hw,
+		[CLKID_VCLK_DIV12]	    = &meson8b_vclk_div12_div_gate.hw,
+		[CLKID_VCLK2_IN_SEL]	    = &meson8b_vclk2_in_sel.hw,
+		[CLKID_VCLK2_IN_EN]	    = &meson8b_vclk2_clk_in_en.hw,
+		[CLKID_VCLK2_DIV1]	    = &meson8b_vclk2_div1_gate.hw,
+		[CLKID_VCLK2_DIV2_DIV]	    = &meson8b_vclk2_div2_div.hw,
+		[CLKID_VCLK2_DIV2]	    = &meson8b_vclk2_div2_div_gate.hw,
+		[CLKID_VCLK2_DIV4_DIV]	    = &meson8b_vclk2_div4_div.hw,
+		[CLKID_VCLK2_DIV4]	    = &meson8b_vclk2_div4_div_gate.hw,
+		[CLKID_VCLK2_DIV6_DIV]	    = &meson8b_vclk2_div6_div.hw,
+		[CLKID_VCLK2_DIV6]	    = &meson8b_vclk2_div6_div_gate.hw,
+		[CLKID_VCLK2_DIV12_DIV]	    = &meson8b_vclk2_div12_div.hw,
+		[CLKID_VCLK2_DIV12]	    = &meson8b_vclk2_div12_div_gate.hw,
+		[CLKID_CTS_ENCT_SEL]	    = &meson8b_cts_enct_sel.hw,
+		[CLKID_CTS_ENCT]	    = &meson8b_cts_enct.hw,
+		[CLKID_CTS_ENCP_SEL]	    = &meson8b_cts_encp_sel.hw,
+		[CLKID_CTS_ENCP]	    = &meson8b_cts_encp.hw,
+		[CLKID_CTS_ENCI_SEL]	    = &meson8b_cts_enci_sel.hw,
+		[CLKID_CTS_ENCI]	    = &meson8b_cts_enci.hw,
+		[CLKID_HDMI_TX_PIXEL_SEL]   = &meson8b_hdmi_tx_pixel_sel.hw,
+		[CLKID_HDMI_TX_PIXEL]	    = &meson8b_hdmi_tx_pixel.hw,
+		[CLKID_CTS_ENCL_SEL]	    = &meson8b_cts_encl_sel.hw,
+		[CLKID_CTS_ENCL]	    = &meson8b_cts_encl.hw,
+		[CLKID_CTS_VDAC0_SEL]	    = &meson8b_cts_vdac0_sel.hw,
+		[CLKID_CTS_VDAC0]	    = &meson8b_cts_vdac0.hw,
+		[CLKID_HDMI_SYS_SEL]	    = &meson8b_hdmi_sys_sel.hw,
+		[CLKID_HDMI_SYS_DIV]	    = &meson8b_hdmi_sys_div.hw,
+		[CLKID_HDMI_SYS]	    = &meson8b_hdmi_sys.hw,
+		[CLKID_MALI_0_SEL]	    = &meson8b_mali_0_sel.hw,
+		[CLKID_MALI_0_DIV]	    = &meson8b_mali_0_div.hw,
+		[CLKID_MALI_0]		    = &meson8b_mali_0.hw,
+		[CLKID_MALI_1_SEL]	    = &meson8b_mali_1_sel.hw,
+		[CLKID_MALI_1_DIV]	    = &meson8b_mali_1_div.hw,
+		[CLKID_MALI_1]		    = &meson8b_mali_1.hw,
+		[CLKID_MALI]		    = &meson8b_mali.hw,
+		[CLK_NR_CLKS]		    = NULL,
+	},
+	.num = CLK_NR_CLKS,
+};
+
 static struct clk_regmap *const meson8b_clk_regmaps[] = {
 	&meson8b_clk81,
 	&meson8b_ddr,
@@ -2558,9 +2744,14 @@ static void __init meson8b_clkc_init(struct device_node *np)
 	return meson8b_clkc_init_common(np, &meson8b_hw_onecell_data);
 }
 
+static void __init meson8m2_clkc_init(struct device_node *np)
+{
+	return meson8b_clkc_init_common(np, &meson8m2_hw_onecell_data);
+}
+
 CLK_OF_DECLARE_DRIVER(meson8_clkc, "amlogic,meson8-clkc",
 		      meson8_clkc_init);
 CLK_OF_DECLARE_DRIVER(meson8b_clkc, "amlogic,meson8b-clkc",
 		      meson8b_clkc_init);
 CLK_OF_DECLARE_DRIVER(meson8m2_clkc, "amlogic,meson8m2-clkc",
-		      meson8b_clkc_init);
+		      meson8m2_clkc_init);
-- 
2.21.0

