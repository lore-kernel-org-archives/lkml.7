Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C2AC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC2220874
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="istq9sbh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbfHZH0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 03:26:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32962 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729984AbfHZHZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 03:25:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id u16so14258792wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 00:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nJHfbz+huzGopfFPJhZtlN2IlNWUSzPOdQ/xmWJJvQ8=;
        b=istq9sbhj58cYisvAeCuR5G/LIt7KdOzhPH1bwzZJHL1hgSLFX1uYYdnwvRH9VRqLi
         uFQtJnNb/jkK/NHic0Qhn6hwOcUbL6NJ04wOfmPprc5wim0eVNLEKa/eVCHEk1+bhZwf
         tZWSJDWmhbEFqdMlrmGuFDe1Ism9+6RsS16Fvl/rRTNQGs7vvpMrFJBwUUptyTG/uzHW
         jr9D5QpQFeOwJHEm+bhbgsSLFtgmN5fpt6BDCKPv/Zop0KFGkjsz0EjvnYSHwrNMUdmi
         DlYIzmggcFzYMZWZroVwM1jPjLlltwuWv1alwIVcNvLXUJmqEd7vebmGX+uHsU7M1z+6
         svLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nJHfbz+huzGopfFPJhZtlN2IlNWUSzPOdQ/xmWJJvQ8=;
        b=BqxBDbU/fxKxgKg4j3KsX8AMdZ7DQ0B9f8yjmPd6rJ3FXCFPmAd1q3P4l3xsIA9R9U
         C/kyWSI4N1rE6O55tAYyuOgUe0yRR2vW9/ZpMc6cpUGjmy+LJHXnR+gbnShv6F7hgujN
         uHiSDaBAsjmKx0Ycgkyt+6WIq4aiMD4k8z2YzqWP8PCVaXkv1j4APvF/PIw6syLhjEKe
         TlpXuyrIpr8DFGp3dWfwGEzJRMd1R6uuPYY3gluNViwCgx0SlzqKjSawEY4dmdUhh8vW
         2hoanNRjiXeNKUzztosm+FyOAtsPrNrfat2duW6D/RRWFaoo62sTW38ESS3UERoVB4Q/
         v59w==
X-Gm-Message-State: APjAAAUEGcT4Kbjdu9GiKqG2pNWugZwpqEIht9tWT9LCY9/TSi3ZFKkI
        cfbCNdgCP/gDlAPg0Jl3bHbBMw==
X-Google-Smtp-Source: APXvYqxtbfOmi8JmtMhTSlPA/AjPQRoE3qO3PPjBR5B3uDHyHoPTQCPQFcWFKcHQq3GO0FyhJnRMsQ==
X-Received: by 2002:adf:dec8:: with SMTP id i8mr19954405wrn.217.1566804345323;
        Mon, 26 Aug 2019 00:25:45 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a26sm10821324wmg.45.2019.08.26.00.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 00:25:44 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] clk: meson: g12a: add support for SM1 GP1 PLL
Date:   Mon, 26 Aug 2019 09:25:36 +0200
Message-Id: <20190826072539.27725-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190826072539.27725-1-narmstrong@baylibre.com>
References: <20190826072539.27725-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the new GP1 PLL for the Amlogic SM1 SoC, used to feed the new
DynamIQ Shared Unit of the ARM Cores Complex.

This also adds a dedicated set of clock and compatible for SM1.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/g12a.c | 300 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/g12a.h |  11 +-
 2 files changed, 310 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index c3f0ffc3280d..34dfac4b4dc6 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -1443,6 +1443,69 @@ static struct clk_regmap g12a_gp0_pll = {
 	},
 };
 
+static struct clk_regmap sm1_gp1_pll_dco = {
+	.data = &(struct meson_clk_pll_data){
+		.en = {
+			.reg_off = HHI_GP1_PLL_CNTL0,
+			.shift   = 28,
+			.width   = 1,
+		},
+		.m = {
+			.reg_off = HHI_GP1_PLL_CNTL0,
+			.shift   = 0,
+			.width   = 8,
+		},
+		.n = {
+			.reg_off = HHI_GP1_PLL_CNTL0,
+			.shift   = 10,
+			.width   = 5,
+		},
+		.frac = {
+			.reg_off = HHI_GP1_PLL_CNTL1,
+			.shift   = 0,
+			.width   = 17,
+		},
+		.l = {
+			.reg_off = HHI_GP1_PLL_CNTL0,
+			.shift   = 31,
+			.width   = 1,
+		},
+		.rst = {
+			.reg_off = HHI_GP1_PLL_CNTL0,
+			.shift   = 29,
+			.width   = 1,
+		},
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "gp1_pll_dco",
+		.ops = &meson_clk_pll_ro_ops,
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "xtal",
+		},
+		.num_parents = 1,
+		/* This clock feeds the DSU, avoid disabling it */
+		.flags = CLK_IS_CRITICAL,
+	},
+};
+
+static struct clk_regmap sm1_gp1_pll = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_GP1_PLL_CNTL0,
+		.shift = 16,
+		.width = 3,
+		.flags = (CLK_DIVIDER_POWER_OF_TWO |
+			  CLK_DIVIDER_ROUND_CLOSEST),
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "gp1_pll",
+		.ops = &clk_regmap_divider_ro_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&sm1_gp1_pll_dco.hw
+		},
+		.num_parents = 1,
+	},
+};
+
 /*
  * Internal hifi pll emulation configuration parameters
  */
@@ -4121,6 +4184,228 @@ static struct clk_hw_onecell_data g12b_hw_onecell_data = {
 	.num = NR_CLKS,
 };
 
+static struct clk_hw_onecell_data sm1_hw_onecell_data = {
+	.hws = {
+		[CLKID_SYS_PLL]			= &g12a_sys_pll.hw,
+		[CLKID_FIXED_PLL]		= &g12a_fixed_pll.hw,
+		[CLKID_FCLK_DIV2]		= &g12a_fclk_div2.hw,
+		[CLKID_FCLK_DIV3]		= &g12a_fclk_div3.hw,
+		[CLKID_FCLK_DIV4]		= &g12a_fclk_div4.hw,
+		[CLKID_FCLK_DIV5]		= &g12a_fclk_div5.hw,
+		[CLKID_FCLK_DIV7]		= &g12a_fclk_div7.hw,
+		[CLKID_FCLK_DIV2P5]		= &g12a_fclk_div2p5.hw,
+		[CLKID_GP0_PLL]			= &g12a_gp0_pll.hw,
+		[CLKID_MPEG_SEL]		= &g12a_mpeg_clk_sel.hw,
+		[CLKID_MPEG_DIV]		= &g12a_mpeg_clk_div.hw,
+		[CLKID_CLK81]			= &g12a_clk81.hw,
+		[CLKID_MPLL0]			= &g12a_mpll0.hw,
+		[CLKID_MPLL1]			= &g12a_mpll1.hw,
+		[CLKID_MPLL2]			= &g12a_mpll2.hw,
+		[CLKID_MPLL3]			= &g12a_mpll3.hw,
+		[CLKID_DDR]			= &g12a_ddr.hw,
+		[CLKID_DOS]			= &g12a_dos.hw,
+		[CLKID_AUDIO_LOCKER]		= &g12a_audio_locker.hw,
+		[CLKID_MIPI_DSI_HOST]		= &g12a_mipi_dsi_host.hw,
+		[CLKID_ETH_PHY]			= &g12a_eth_phy.hw,
+		[CLKID_ISA]			= &g12a_isa.hw,
+		[CLKID_PL301]			= &g12a_pl301.hw,
+		[CLKID_PERIPHS]			= &g12a_periphs.hw,
+		[CLKID_SPICC0]			= &g12a_spicc_0.hw,
+		[CLKID_I2C]			= &g12a_i2c.hw,
+		[CLKID_SANA]			= &g12a_sana.hw,
+		[CLKID_SD]			= &g12a_sd.hw,
+		[CLKID_RNG0]			= &g12a_rng0.hw,
+		[CLKID_UART0]			= &g12a_uart0.hw,
+		[CLKID_SPICC1]			= &g12a_spicc_1.hw,
+		[CLKID_HIU_IFACE]		= &g12a_hiu_reg.hw,
+		[CLKID_MIPI_DSI_PHY]		= &g12a_mipi_dsi_phy.hw,
+		[CLKID_ASSIST_MISC]		= &g12a_assist_misc.hw,
+		[CLKID_SD_EMMC_A]		= &g12a_emmc_a.hw,
+		[CLKID_SD_EMMC_B]		= &g12a_emmc_b.hw,
+		[CLKID_SD_EMMC_C]		= &g12a_emmc_c.hw,
+		[CLKID_AUDIO_CODEC]		= &g12a_audio_codec.hw,
+		[CLKID_AUDIO]			= &g12a_audio.hw,
+		[CLKID_ETH]			= &g12a_eth_core.hw,
+		[CLKID_DEMUX]			= &g12a_demux.hw,
+		[CLKID_AUDIO_IFIFO]		= &g12a_audio_ififo.hw,
+		[CLKID_ADC]			= &g12a_adc.hw,
+		[CLKID_UART1]			= &g12a_uart1.hw,
+		[CLKID_G2D]			= &g12a_g2d.hw,
+		[CLKID_RESET]			= &g12a_reset.hw,
+		[CLKID_PCIE_COMB]		= &g12a_pcie_comb.hw,
+		[CLKID_PARSER]			= &g12a_parser.hw,
+		[CLKID_USB]			= &g12a_usb_general.hw,
+		[CLKID_PCIE_PHY]		= &g12a_pcie_phy.hw,
+		[CLKID_AHB_ARB0]		= &g12a_ahb_arb0.hw,
+		[CLKID_AHB_DATA_BUS]		= &g12a_ahb_data_bus.hw,
+		[CLKID_AHB_CTRL_BUS]		= &g12a_ahb_ctrl_bus.hw,
+		[CLKID_HTX_HDCP22]		= &g12a_htx_hdcp22.hw,
+		[CLKID_HTX_PCLK]		= &g12a_htx_pclk.hw,
+		[CLKID_BT656]			= &g12a_bt656.hw,
+		[CLKID_USB1_DDR_BRIDGE]		= &g12a_usb1_to_ddr.hw,
+		[CLKID_MMC_PCLK]		= &g12a_mmc_pclk.hw,
+		[CLKID_UART2]			= &g12a_uart2.hw,
+		[CLKID_VPU_INTR]		= &g12a_vpu_intr.hw,
+		[CLKID_GIC]			= &g12a_gic.hw,
+		[CLKID_SD_EMMC_A_CLK0_SEL]	= &g12a_sd_emmc_a_clk0_sel.hw,
+		[CLKID_SD_EMMC_A_CLK0_DIV]	= &g12a_sd_emmc_a_clk0_div.hw,
+		[CLKID_SD_EMMC_A_CLK0]		= &g12a_sd_emmc_a_clk0.hw,
+		[CLKID_SD_EMMC_B_CLK0_SEL]	= &g12a_sd_emmc_b_clk0_sel.hw,
+		[CLKID_SD_EMMC_B_CLK0_DIV]	= &g12a_sd_emmc_b_clk0_div.hw,
+		[CLKID_SD_EMMC_B_CLK0]		= &g12a_sd_emmc_b_clk0.hw,
+		[CLKID_SD_EMMC_C_CLK0_SEL]	= &g12a_sd_emmc_c_clk0_sel.hw,
+		[CLKID_SD_EMMC_C_CLK0_DIV]	= &g12a_sd_emmc_c_clk0_div.hw,
+		[CLKID_SD_EMMC_C_CLK0]		= &g12a_sd_emmc_c_clk0.hw,
+		[CLKID_MPLL0_DIV]		= &g12a_mpll0_div.hw,
+		[CLKID_MPLL1_DIV]		= &g12a_mpll1_div.hw,
+		[CLKID_MPLL2_DIV]		= &g12a_mpll2_div.hw,
+		[CLKID_MPLL3_DIV]		= &g12a_mpll3_div.hw,
+		[CLKID_FCLK_DIV2_DIV]		= &g12a_fclk_div2_div.hw,
+		[CLKID_FCLK_DIV3_DIV]		= &g12a_fclk_div3_div.hw,
+		[CLKID_FCLK_DIV4_DIV]		= &g12a_fclk_div4_div.hw,
+		[CLKID_FCLK_DIV5_DIV]		= &g12a_fclk_div5_div.hw,
+		[CLKID_FCLK_DIV7_DIV]		= &g12a_fclk_div7_div.hw,
+		[CLKID_FCLK_DIV2P5_DIV]		= &g12a_fclk_div2p5_div.hw,
+		[CLKID_HIFI_PLL]		= &g12a_hifi_pll.hw,
+		[CLKID_VCLK2_VENCI0]		= &g12a_vclk2_venci0.hw,
+		[CLKID_VCLK2_VENCI1]		= &g12a_vclk2_venci1.hw,
+		[CLKID_VCLK2_VENCP0]		= &g12a_vclk2_vencp0.hw,
+		[CLKID_VCLK2_VENCP1]		= &g12a_vclk2_vencp1.hw,
+		[CLKID_VCLK2_VENCT0]		= &g12a_vclk2_venct0.hw,
+		[CLKID_VCLK2_VENCT1]		= &g12a_vclk2_venct1.hw,
+		[CLKID_VCLK2_OTHER]		= &g12a_vclk2_other.hw,
+		[CLKID_VCLK2_ENCI]		= &g12a_vclk2_enci.hw,
+		[CLKID_VCLK2_ENCP]		= &g12a_vclk2_encp.hw,
+		[CLKID_DAC_CLK]			= &g12a_dac_clk.hw,
+		[CLKID_AOCLK]			= &g12a_aoclk_gate.hw,
+		[CLKID_IEC958]			= &g12a_iec958_gate.hw,
+		[CLKID_ENC480P]			= &g12a_enc480p.hw,
+		[CLKID_RNG1]			= &g12a_rng1.hw,
+		[CLKID_VCLK2_ENCT]		= &g12a_vclk2_enct.hw,
+		[CLKID_VCLK2_ENCL]		= &g12a_vclk2_encl.hw,
+		[CLKID_VCLK2_VENCLMMC]		= &g12a_vclk2_venclmmc.hw,
+		[CLKID_VCLK2_VENCL]		= &g12a_vclk2_vencl.hw,
+		[CLKID_VCLK2_OTHER1]		= &g12a_vclk2_other1.hw,
+		[CLKID_FIXED_PLL_DCO]		= &g12a_fixed_pll_dco.hw,
+		[CLKID_SYS_PLL_DCO]		= &g12a_sys_pll_dco.hw,
+		[CLKID_GP0_PLL_DCO]		= &g12a_gp0_pll_dco.hw,
+		[CLKID_HIFI_PLL_DCO]		= &g12a_hifi_pll_dco.hw,
+		[CLKID_DMA]			= &g12a_dma.hw,
+		[CLKID_EFUSE]			= &g12a_efuse.hw,
+		[CLKID_ROM_BOOT]		= &g12a_rom_boot.hw,
+		[CLKID_RESET_SEC]		= &g12a_reset_sec.hw,
+		[CLKID_SEC_AHB_APB3]		= &g12a_sec_ahb_apb3.hw,
+		[CLKID_MPLL_PREDIV]		= &g12a_mpll_prediv.hw,
+		[CLKID_VPU_0_SEL]		= &g12a_vpu_0_sel.hw,
+		[CLKID_VPU_0_DIV]		= &g12a_vpu_0_div.hw,
+		[CLKID_VPU_0]			= &g12a_vpu_0.hw,
+		[CLKID_VPU_1_SEL]		= &g12a_vpu_1_sel.hw,
+		[CLKID_VPU_1_DIV]		= &g12a_vpu_1_div.hw,
+		[CLKID_VPU_1]			= &g12a_vpu_1.hw,
+		[CLKID_VPU]			= &g12a_vpu.hw,
+		[CLKID_VAPB_0_SEL]		= &g12a_vapb_0_sel.hw,
+		[CLKID_VAPB_0_DIV]		= &g12a_vapb_0_div.hw,
+		[CLKID_VAPB_0]			= &g12a_vapb_0.hw,
+		[CLKID_VAPB_1_SEL]		= &g12a_vapb_1_sel.hw,
+		[CLKID_VAPB_1_DIV]		= &g12a_vapb_1_div.hw,
+		[CLKID_VAPB_1]			= &g12a_vapb_1.hw,
+		[CLKID_VAPB_SEL]		= &g12a_vapb_sel.hw,
+		[CLKID_VAPB]			= &g12a_vapb.hw,
+		[CLKID_HDMI_PLL_DCO]		= &g12a_hdmi_pll_dco.hw,
+		[CLKID_HDMI_PLL_OD]		= &g12a_hdmi_pll_od.hw,
+		[CLKID_HDMI_PLL_OD2]		= &g12a_hdmi_pll_od2.hw,
+		[CLKID_HDMI_PLL]		= &g12a_hdmi_pll.hw,
+		[CLKID_VID_PLL]			= &g12a_vid_pll_div.hw,
+		[CLKID_VID_PLL_SEL]		= &g12a_vid_pll_sel.hw,
+		[CLKID_VID_PLL_DIV]		= &g12a_vid_pll.hw,
+		[CLKID_VCLK_SEL]		= &g12a_vclk_sel.hw,
+		[CLKID_VCLK2_SEL]		= &g12a_vclk2_sel.hw,
+		[CLKID_VCLK_INPUT]		= &g12a_vclk_input.hw,
+		[CLKID_VCLK2_INPUT]		= &g12a_vclk2_input.hw,
+		[CLKID_VCLK_DIV]		= &g12a_vclk_div.hw,
+		[CLKID_VCLK2_DIV]		= &g12a_vclk2_div.hw,
+		[CLKID_VCLK]			= &g12a_vclk.hw,
+		[CLKID_VCLK2]			= &g12a_vclk2.hw,
+		[CLKID_VCLK_DIV1]		= &g12a_vclk_div1.hw,
+		[CLKID_VCLK_DIV2_EN]		= &g12a_vclk_div2_en.hw,
+		[CLKID_VCLK_DIV4_EN]		= &g12a_vclk_div4_en.hw,
+		[CLKID_VCLK_DIV6_EN]		= &g12a_vclk_div6_en.hw,
+		[CLKID_VCLK_DIV12_EN]		= &g12a_vclk_div12_en.hw,
+		[CLKID_VCLK2_DIV1]		= &g12a_vclk2_div1.hw,
+		[CLKID_VCLK2_DIV2_EN]		= &g12a_vclk2_div2_en.hw,
+		[CLKID_VCLK2_DIV4_EN]		= &g12a_vclk2_div4_en.hw,
+		[CLKID_VCLK2_DIV6_EN]		= &g12a_vclk2_div6_en.hw,
+		[CLKID_VCLK2_DIV12_EN]		= &g12a_vclk2_div12_en.hw,
+		[CLKID_VCLK_DIV2]		= &g12a_vclk_div2.hw,
+		[CLKID_VCLK_DIV4]		= &g12a_vclk_div4.hw,
+		[CLKID_VCLK_DIV6]		= &g12a_vclk_div6.hw,
+		[CLKID_VCLK_DIV12]		= &g12a_vclk_div12.hw,
+		[CLKID_VCLK2_DIV2]		= &g12a_vclk2_div2.hw,
+		[CLKID_VCLK2_DIV4]		= &g12a_vclk2_div4.hw,
+		[CLKID_VCLK2_DIV6]		= &g12a_vclk2_div6.hw,
+		[CLKID_VCLK2_DIV12]		= &g12a_vclk2_div12.hw,
+		[CLKID_CTS_ENCI_SEL]		= &g12a_cts_enci_sel.hw,
+		[CLKID_CTS_ENCP_SEL]		= &g12a_cts_encp_sel.hw,
+		[CLKID_CTS_VDAC_SEL]		= &g12a_cts_vdac_sel.hw,
+		[CLKID_HDMI_TX_SEL]		= &g12a_hdmi_tx_sel.hw,
+		[CLKID_CTS_ENCI]		= &g12a_cts_enci.hw,
+		[CLKID_CTS_ENCP]		= &g12a_cts_encp.hw,
+		[CLKID_CTS_VDAC]		= &g12a_cts_vdac.hw,
+		[CLKID_HDMI_TX]			= &g12a_hdmi_tx.hw,
+		[CLKID_HDMI_SEL]		= &g12a_hdmi_sel.hw,
+		[CLKID_HDMI_DIV]		= &g12a_hdmi_div.hw,
+		[CLKID_HDMI]			= &g12a_hdmi.hw,
+		[CLKID_MALI_0_SEL]		= &g12a_mali_0_sel.hw,
+		[CLKID_MALI_0_DIV]		= &g12a_mali_0_div.hw,
+		[CLKID_MALI_0]			= &g12a_mali_0.hw,
+		[CLKID_MALI_1_SEL]		= &g12a_mali_1_sel.hw,
+		[CLKID_MALI_1_DIV]		= &g12a_mali_1_div.hw,
+		[CLKID_MALI_1]			= &g12a_mali_1.hw,
+		[CLKID_MALI]			= &g12a_mali.hw,
+		[CLKID_MPLL_50M_DIV]		= &g12a_mpll_50m_div.hw,
+		[CLKID_MPLL_50M]		= &g12a_mpll_50m.hw,
+		[CLKID_SYS_PLL_DIV16_EN]	= &g12a_sys_pll_div16_en.hw,
+		[CLKID_SYS_PLL_DIV16]		= &g12a_sys_pll_div16.hw,
+		[CLKID_CPU_CLK_DYN0_SEL]	= &g12a_cpu_clk_premux0.hw,
+		[CLKID_CPU_CLK_DYN0_DIV]	= &g12a_cpu_clk_mux0_div.hw,
+		[CLKID_CPU_CLK_DYN0]		= &g12a_cpu_clk_postmux0.hw,
+		[CLKID_CPU_CLK_DYN1_SEL]	= &g12a_cpu_clk_premux1.hw,
+		[CLKID_CPU_CLK_DYN1_DIV]	= &g12a_cpu_clk_mux1_div.hw,
+		[CLKID_CPU_CLK_DYN1]		= &g12a_cpu_clk_postmux1.hw,
+		[CLKID_CPU_CLK_DYN]		= &g12a_cpu_clk_dyn.hw,
+		[CLKID_CPU_CLK]			= &g12a_cpu_clk.hw,
+		[CLKID_CPU_CLK_DIV16_EN]	= &g12a_cpu_clk_div16_en.hw,
+		[CLKID_CPU_CLK_DIV16]		= &g12a_cpu_clk_div16.hw,
+		[CLKID_CPU_CLK_APB_DIV]		= &g12a_cpu_clk_apb_div.hw,
+		[CLKID_CPU_CLK_APB]		= &g12a_cpu_clk_apb.hw,
+		[CLKID_CPU_CLK_ATB_DIV]		= &g12a_cpu_clk_atb_div.hw,
+		[CLKID_CPU_CLK_ATB]		= &g12a_cpu_clk_atb.hw,
+		[CLKID_CPU_CLK_AXI_DIV]		= &g12a_cpu_clk_axi_div.hw,
+		[CLKID_CPU_CLK_AXI]		= &g12a_cpu_clk_axi.hw,
+		[CLKID_CPU_CLK_TRACE_DIV]	= &g12a_cpu_clk_trace_div.hw,
+		[CLKID_CPU_CLK_TRACE]		= &g12a_cpu_clk_trace.hw,
+		[CLKID_PCIE_PLL_DCO]		= &g12a_pcie_pll_dco.hw,
+		[CLKID_PCIE_PLL_DCO_DIV2]	= &g12a_pcie_pll_dco_div2.hw,
+		[CLKID_PCIE_PLL_OD]		= &g12a_pcie_pll_od.hw,
+		[CLKID_PCIE_PLL]		= &g12a_pcie_pll.hw,
+		[CLKID_VDEC_1_SEL]		= &g12a_vdec_1_sel.hw,
+		[CLKID_VDEC_1_DIV]		= &g12a_vdec_1_div.hw,
+		[CLKID_VDEC_1]			= &g12a_vdec_1.hw,
+		[CLKID_VDEC_HEVC_SEL]		= &g12a_vdec_hevc_sel.hw,
+		[CLKID_VDEC_HEVC_DIV]		= &g12a_vdec_hevc_div.hw,
+		[CLKID_VDEC_HEVC]		= &g12a_vdec_hevc.hw,
+		[CLKID_VDEC_HEVCF_SEL]		= &g12a_vdec_hevcf_sel.hw,
+		[CLKID_VDEC_HEVCF_DIV]		= &g12a_vdec_hevcf_div.hw,
+		[CLKID_VDEC_HEVCF]		= &g12a_vdec_hevcf.hw,
+		[CLKID_TS_DIV]			= &g12a_ts_div.hw,
+		[CLKID_TS]			= &g12a_ts.hw,
+		[CLKID_GP1_PLL_DCO]		= &sm1_gp1_pll_dco.hw,
+		[CLKID_GP1_PLL]			= &sm1_gp1_pll.hw,
+		[NR_CLKS]			= NULL,
+	},
+	.num = NR_CLKS,
+};
+
 /* Convenience table to populate regmap in .probe */
 static struct clk_regmap *const g12a_clk_regmaps[] = {
 	&g12a_clk81,
@@ -4336,6 +4621,8 @@ static struct clk_regmap *const g12a_clk_regmaps[] = {
 	&g12b_cpub_clk_axi,
 	&g12b_cpub_clk_trace_sel,
 	&g12b_cpub_clk_trace,
+	&sm1_gp1_pll_dco,
+	&sm1_gp1_pll,
 };
 
 static const struct reg_sequence g12a_init_regs[] = {
@@ -4532,6 +4819,15 @@ static const struct meson_g12a_data g12b_clkc_data = {
 	.dvfs_setup = meson_g12b_dvfs_setup,
 };
 
+static const struct meson_g12a_data sm1_clkc_data = {
+	.eeclkc_data = {
+		.regmap_clks = g12a_clk_regmaps,
+		.regmap_clk_num = ARRAY_SIZE(g12a_clk_regmaps),
+		.hw_onecell_data = &sm1_hw_onecell_data,
+	},
+	.dvfs_setup = meson_g12a_dvfs_setup,
+};
+
 static const struct of_device_id clkc_match_table[] = {
 	{
 		.compatible = "amlogic,g12a-clkc",
@@ -4541,6 +4837,10 @@ static const struct of_device_id clkc_match_table[] = {
 		.compatible = "amlogic,g12b-clkc",
 		.data = &g12b_clkc_data.eeclkc_data
 	},
+	{
+		.compatible = "amlogic,sm1-clkc",
+		.data = &sm1_clkc_data.eeclkc_data
+	},
 	{}
 };
 
diff --git a/drivers/clk/meson/g12a.h b/drivers/clk/meson/g12a.h
index 559a34cfdfeb..e426b4121b7a 100644
--- a/drivers/clk/meson/g12a.h
+++ b/drivers/clk/meson/g12a.h
@@ -29,6 +29,14 @@
 #define HHI_GP0_PLL_CNTL5		0x054
 #define HHI_GP0_PLL_CNTL6		0x058
 #define HHI_GP0_PLL_STS			0x05C
+#define HHI_GP1_PLL_CNTL0		0x060
+#define HHI_GP1_PLL_CNTL1		0x064
+#define HHI_GP1_PLL_CNTL2		0x068
+#define HHI_GP1_PLL_CNTL3		0x06C
+#define HHI_GP1_PLL_CNTL4		0x070
+#define HHI_GP1_PLL_CNTL5		0x074
+#define HHI_GP1_PLL_CNTL6		0x078
+#define HHI_GP1_PLL_STS			0x07C
 #define HHI_PCIE_PLL_CNTL0		0x098
 #define HHI_PCIE_PLL_CNTL1		0x09C
 #define HHI_PCIE_PLL_CNTL2		0x0A0
@@ -233,8 +241,9 @@
 #define CLKID_CPUB_CLK_AXI			239
 #define CLKID_CPUB_CLK_TRACE_SEL		240
 #define CLKID_CPUB_CLK_TRACE			241
+#define CLKID_GP1_PLL_DCO			242
 
-#define NR_CLKS					242
+#define NR_CLKS					244
 
 /* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/g12a-clkc.h>
-- 
2.22.0

