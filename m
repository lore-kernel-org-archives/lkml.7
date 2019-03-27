Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FCDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30422075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oKFjBYi+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733224AbfC0KdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:33:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45298 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfC0KdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 06:33:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so17868432wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 03:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oQOUvLGRpWjiMhiamun1ayTj9h3bNVF0q4KNDo0oUXU=;
        b=oKFjBYi+ozYleU4uNun2bpFOb0RUFTD0QgkeEzLKM7aPoDye5PDqZNg5IW7rbz6PSo
         Cek5jQB9UkAIgDcuS9pJ17Cg4ZtAvbkEvsUpmNPuA3TLwxs1Bbmichmq+whIe1C2Vcdq
         VqjAZG506XuNGxTDHw0EyVWBLkM64gemgu+DOckPbcrghhpenPPTxxE3FkrDpEGu/dOM
         7WCQZurToVBu3ZSOkysgpXrRlfQue53wHPqwWjxxVwpVXbQqcrokkzN0tHi3IR600UcA
         7xYApDJzlYINKDtE7Kv89woshRO7Ynjpjk8RKjk3r4GTen5ky3Oy9vLPZIi4U5ReeJkB
         yJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oQOUvLGRpWjiMhiamun1ayTj9h3bNVF0q4KNDo0oUXU=;
        b=CyPmib3KihiFlhRLuDUJEbhC/pd1Dee0OPmj/fPl6WLqmUSRFwQtXNmHCM5/ZkswJ7
         OOWHYn+vcuZ991WeIbsrFg2BrkQ72NLP2W0Cl/DiWA+laFCeEk2rOe8V2OILeVkfaU5n
         OWvOJ82xhBk+F1jv4sqKLjla7AM9QF+MQSaH5KZz4xbUJzIaRctDiPaSQtYveXIhdGAV
         ykJl2uft39dUnYVaVOO5aLI0P2YIQVDxc48Ybfz5kIVsuAB37D8NhQgyGU+FpaL9k4TB
         Sk9JlcArabA/NMAgmXlvnTQjt5Rn+bvzs3hIgAp3KoE/5j2dlf0Yu11PfrYmxLF7cwOk
         9xUw==
X-Gm-Message-State: APjAAAVl+NE5S+FRbtcXbEXazFKx4uL+MKBiimgI5oVU4w4HvtVDge1G
        kxktCndYdKumVorltVRvHIN1jQ==
X-Google-Smtp-Source: APXvYqyDEKSJ+I+MuHNz+KA6XdoEtOr5tbehTLs8j+CEA3S2NNy3vI13aSmszQ25+LZp6aP7VaH8Jw==
X-Received: by 2002:adf:c7c8:: with SMTP id y8mr24793762wrg.149.1553682792566;
        Wed, 27 Mar 2019 03:33:12 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a20sm27017513wmb.17.2019.03.27.03.33.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Mar 2019 03:33:11 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH RFC 2/6] clk: meson: g12a: Add support for G12B CPUB clocks
Date:   Wed, 27 Mar 2019 11:33:04 +0100
Message-Id: <20190327103308.25058-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190327103308.25058-1-narmstrong@baylibre.com>
References: <20190327103308.25058-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch support for the specific Amlogic G12B clocks.

G12B clock driver is very close, the main differences are :
- the clock tree is duplicated for the both clusters, and the
  SYS_PLL are swapped between the clusters
- G12A has additional clocks like for CSI an other components

Here only the cpu clock tree is handled.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/g12a.c | 456 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/g12a.h |  20 +-
 2 files changed, 475 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 244aeea57638..03b4c78f558f 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -150,6 +150,57 @@ static struct clk_regmap g12a_sys_pll = {
 	},
 };
 
+static struct clk_regmap g12b_sys1_pll_dco = {
+	.data = &(struct meson_clk_pll_data){
+		.en = {
+			.reg_off = HHI_SYS1_PLL_CNTL0,
+			.shift   = 28,
+			.width   = 1,
+		},
+		.m = {
+			.reg_off = HHI_SYS1_PLL_CNTL0,
+			.shift   = 0,
+			.width   = 8,
+		},
+		.n = {
+			.reg_off = HHI_SYS1_PLL_CNTL0,
+			.shift   = 10,
+			.width   = 5,
+		},
+		.l = {
+			.reg_off = HHI_SYS1_PLL_CNTL0,
+			.shift   = 31,
+			.width   = 1,
+		},
+		.rst = {
+			.reg_off = HHI_SYS1_PLL_CNTL0,
+			.shift   = 29,
+			.width   = 1,
+		},
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "sys1_pll_dco",
+		.ops = &meson_clk_pll_ro_ops,
+		.parent_names = (const char *[]){ IN_PREFIX "xtal" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap g12b_sys1_pll = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_SYS1_PLL_CNTL0,
+		.shift = 16,
+		.width = 3,
+		.flags = CLK_DIVIDER_POWER_OF_TWO,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "sys1_pll",
+		.ops = &clk_regmap_divider_ro_ops,
+		.parent_names = (const char *[]){ "sys1_pll_dco" },
+		.num_parents = 1,
+	},
+};
+
 static struct clk_regmap g12a_sys_pll_div16_en = {
 	.data = &(struct clk_regmap_gate_data){
 		.offset = HHI_SYS_CPU_CLK_CNTL1,
@@ -303,6 +354,165 @@ static struct clk_regmap g12a_cpu_clk = {
 		.parent_names = (const char *[]){ "cpu_clk_dyn",
 						  "sys_pll" },
 		.num_parents = 2,
+		/*
+		 * Until we add support for DVFS, this clock tree feeds
+		 * the second CPU cluster and should not be disabled
+		 */
+		.flags = CLK_IS_CRITICAL,
+	},
+};
+
+/* Datasheet names this field as "Final_mux_sel" */
+static struct clk_regmap g12b_cpu_clk = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL0,
+		.mask = 0x1,
+		.shift = 11,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cpu_clk",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_names = (const char *[]){ "cpu_clk_dyn",
+						  "sys1_pll" },
+		.num_parents = 2,
+		/*
+		 * Until we add support for DVFS, this clock tree feeds
+		 * the second CPU cluster and should not be disabled
+		 */
+		.flags = CLK_IS_CRITICAL,
+	},
+};
+
+/* Datasheet names this field as "premux0" */
+static struct clk_regmap g12b_cpub_clk_dyn0_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SYS_CPUB_CLK_CNTL,
+		.mask = 0x3,
+		.shift = 0,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cpub_clk_dyn0_sel",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_names = (const char *[]){ IN_PREFIX "xtal",
+						  "fclk_div2",
+						  "fclk_div3" },
+		.num_parents = 3,
+	},
+};
+
+/* Datasheet names this field as "mux0_divn_tcnt" */
+static struct clk_regmap g12b_cpub_clk_dyn0_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_SYS_CPUB_CLK_CNTL,
+		.shift = 4,
+		.width = 6,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cpub_clk_dyn0_div",
+		.ops = &clk_regmap_divider_ro_ops,
+		.parent_names = (const char *[]){ "cpub_clk_dyn0_sel" },
+		.num_parents = 1,
+	},
+};
+
+/* Datasheet names this field as "postmux0" */
+static struct clk_regmap g12b_cpub_clk_dyn0 = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SYS_CPUB_CLK_CNTL,
+		.mask = 0x1,
+		.shift = 2,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cpub_clk_dyn0",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_names = (const char *[]){ "cpub_clk_dyn0_sel",
+						  "cpub_clk_dyn0_div" },
+		.num_parents = 2,
+	},
+};
+
+/* Datasheet names this field as "premux1" */
+static struct clk_regmap g12b_cpub_clk_dyn1_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SYS_CPUB_CLK_CNTL,
+		.mask = 0x3,
+		.shift = 16,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cpub_clk_dyn1_sel",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_names = (const char *[]){ IN_PREFIX "xtal",
+						  "fclk_div2",
+						  "fclk_div3" },
+		.num_parents = 3,
+	},
+};
+
+/* Datasheet names this field as "Mux1_divn_tcnt" */
+static struct clk_regmap g12b_cpub_clk_dyn1_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_SYS_CPUB_CLK_CNTL,
+		.shift = 20,
+		.width = 6,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cpub_clk_dyn1_div",
+		.ops = &clk_regmap_divider_ro_ops,
+		.parent_names = (const char *[]){ "cpub_clk_dyn1_sel" },
+		.num_parents = 1,
+	},
+};
+
+/* Datasheet names this field as "postmux1" */
+static struct clk_regmap g12b_cpub_clk_dyn1 = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SYS_CPUB_CLK_CNTL,
+		.mask = 0x1,
+		.shift = 18,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cpub_clk_dyn1",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_names = (const char *[]){ "cpub_clk_dyn1_sel",
+						  "cpub_clk_dyn1_div" },
+		.num_parents = 2,
+	},
+};
+
+/* Datasheet names this field as "Final_dyn_mux_sel" */
+static struct clk_regmap g12b_cpub_clk_dyn = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SYS_CPUB_CLK_CNTL,
+		.mask = 0x1,
+		.shift = 10,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cpub_clk_dyn",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_names = (const char *[]){ "cpub_clk_dyn0",
+						  "cpub_clk_dyn1" },
+		.num_parents = 2,
+	},
+};
+
+/* Datasheet names this field as "Final_mux_sel" */
+static struct clk_regmap g12b_cpub_clk = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SYS_CPUB_CLK_CNTL,
+		.mask = 0x1,
+		.shift = 11,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cpub_clk",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_names = (const char *[]){ "cpub_clk_dyn",
+						  "sys_pll" },
+		.num_parents = 2,
+		/*
+		 * Until we add support for DVFS, this clock tree feeds
+		 * the second CPU cluster and should not be disabled
+		 */
+		.flags = CLK_IS_CRITICAL,
 	},
 };
 
@@ -2774,6 +2984,234 @@ static struct clk_hw_onecell_data g12a_hw_onecell_data = {
 	.num = NR_CLKS,
 };
 
+static struct clk_hw_onecell_data g12b_hw_onecell_data = {
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
+		[CLKID_MPLL_5OM_DIV]		= &g12a_mpll_50m_div.hw,
+		[CLKID_MPLL_5OM]		= &g12a_mpll_50m.hw,
+		[CLKID_SYS_PLL_DIV16_EN]	= &g12a_sys_pll_div16_en.hw,
+		[CLKID_SYS_PLL_DIV16]		= &g12a_sys_pll_div16.hw,
+		[CLKID_CPU_CLK_DYN0_SEL]	= &g12a_cpu_clk_dyn0_sel.hw,
+		[CLKID_CPU_CLK_DYN0_DIV]	= &g12a_cpu_clk_dyn0_div.hw,
+		[CLKID_CPU_CLK_DYN0]		= &g12a_cpu_clk_dyn0.hw,
+		[CLKID_CPU_CLK_DYN1_SEL]	= &g12a_cpu_clk_dyn1_sel.hw,
+		[CLKID_CPU_CLK_DYN1_DIV]	= &g12a_cpu_clk_dyn1_div.hw,
+		[CLKID_CPU_CLK_DYN1]		= &g12a_cpu_clk_dyn1.hw,
+		[CLKID_CPU_CLK_DYN]		= &g12a_cpu_clk_dyn.hw,
+		[CLKID_CPU_CLK]			= &g12b_cpu_clk.hw,
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
+		[CLKID_SYS1_PLL_DCO]		= &g12b_sys1_pll_dco.hw,
+		[CLKID_SYS1_PLL]		= &g12b_sys1_pll.hw,
+		[CLKID_CPUB_CLK_DYN0_SEL]	= &g12b_cpub_clk_dyn0_sel.hw,
+		[CLKID_CPUB_CLK_DYN0_DIV]	= &g12b_cpub_clk_dyn0_div.hw,
+		[CLKID_CPUB_CLK_DYN0]		= &g12b_cpub_clk_dyn0.hw,
+		[CLKID_CPUB_CLK_DYN1_SEL]	= &g12b_cpub_clk_dyn1_sel.hw,
+		[CLKID_CPUB_CLK_DYN1_DIV]	= &g12b_cpub_clk_dyn1_div.hw,
+		[CLKID_CPUB_CLK_DYN1]		= &g12b_cpub_clk_dyn1.hw,
+		[CLKID_CPUB_CLK_DYN]		= &g12b_cpub_clk_dyn.hw,
+		[CLKID_CPUB_CLK]		= &g12b_cpub_clk.hw,
+		[NR_CLKS]			= NULL,
+	},
+	.num = NR_CLKS,
+};
+
 /* Convenience table to populate regmap in .probe */
 static struct clk_regmap *const g12a_clk_regmaps[] = {
 	&g12a_clk81,
@@ -2966,6 +3404,17 @@ static struct clk_regmap *const g12a_clk_regmaps[] = {
 	&g12a_vdec_hevcf_sel,
 	&g12a_vdec_hevcf_div,
 	&g12a_vdec_hevcf,
+	&g12b_cpu_clk,
+	&g12b_sys1_pll_dco,
+	&g12b_sys1_pll,
+	&g12b_cpub_clk_dyn0_sel,
+	&g12b_cpub_clk_dyn0_div,
+	&g12b_cpub_clk_dyn0,
+	&g12b_cpub_clk_dyn1_sel,
+	&g12b_cpub_clk_dyn1_div,
+	&g12b_cpub_clk_dyn1,
+	&g12b_cpub_clk_dyn,
+	&g12b_cpub_clk,
 };
 
 static const struct meson_eeclkc_data g12a_clkc_data = {
@@ -2974,8 +3423,15 @@ static const struct meson_eeclkc_data g12a_clkc_data = {
 	.hw_onecell_data = &g12a_hw_onecell_data
 };
 
+static const struct meson_eeclkc_data g12b_clkc_data = {
+	.regmap_clks = g12a_clk_regmaps,
+	.regmap_clk_num = ARRAY_SIZE(g12a_clk_regmaps),
+	.hw_onecell_data = &g12b_hw_onecell_data
+};
+
 static const struct of_device_id clkc_match_table[] = {
 	{ .compatible = "amlogic,g12a-clkc", .data = &g12a_clkc_data },
+	{ .compatible = "amlogic,g12b-clkc", .data = &g12b_clkc_data },
 	{}
 };
 
diff --git a/drivers/clk/meson/g12a.h b/drivers/clk/meson/g12a.h
index 39c41af70804..efe3f71edc8b 100644
--- a/drivers/clk/meson/g12a.h
+++ b/drivers/clk/meson/g12a.h
@@ -69,6 +69,7 @@
 #define HHI_VDEC4_CLK_CNTL		0x1EC
 #define HHI_HDCP22_CLK_CNTL		0x1F0
 #define HHI_VAPBCLK_CNTL		0x1F4
+#define HHI_SYS_CPUB_CLK_CNTL		0x208
 #define HHI_VPU_CLKB_CNTL		0x20C
 #define HHI_GEN_CLK_CNTL		0x228
 #define HHI_VDIN_MEAS_CLK_CNTL		0x250
@@ -102,6 +103,13 @@
 #define HHI_HDMI_PLL_CNTL5		0x334
 #define HHI_HDMI_PLL_CNTL6		0x338
 #define HHI_SPICC_CLK_CNTL		0x3dc
+#define HHI_SYS1_PLL_CNTL0		0x380
+#define HHI_SYS1_PLL_CNTL1		0x384
+#define HHI_SYS1_PLL_CNTL2		0x388
+#define HHI_SYS1_PLL_CNTL3		0x38c
+#define HHI_SYS1_PLL_CNTL4		0x390
+#define HHI_SYS1_PLL_CNTL5		0x394
+#define HHI_SYS1_PLL_CNTL6		0x398
 
 /*
  * CLKID index values
@@ -195,8 +203,18 @@
 #define CLKID_VDEC_HEVC_DIV			206
 #define CLKID_VDEC_HEVCF_SEL			208
 #define CLKID_VDEC_HEVCF_DIV			209
+#define CLKID_SYS1_PLL_DCO			211
+#define CLKID_SYS1_PLL				212
+#define CLKID_CPUB_CLK_DYN0_SEL			213
+#define CLKID_CPUB_CLK_DYN0_DIV			214
+#define CLKID_CPUB_CLK_DYN0			215
+#define CLKID_CPUB_CLK_DYN1_SEL			216
+#define CLKID_CPUB_CLK_DYN1_DIV			217
+#define CLKID_CPUB_CLK_DYN1			218
+#define CLKID_CPUB_CLK_DYN			219
+#define CLKID_CPUB_CLK				220
 
-#define NR_CLKS					211
+#define NR_CLKS					221
 
 /* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/g12a-clkc.h>
-- 
2.21.0

