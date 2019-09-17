Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0983C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9209220678
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388890AbfIQIT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 04:19:26 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46548 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388815AbfIQIT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:19:26 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iA8hm-0005Uf-40; Tue, 17 Sep 2019 10:19:22 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        finley.xiao@rock-chips.com, zhangqing@rock-chips.com,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 2/5] clk: rockchip: Add div50 clocks for px30 sdmmc, emmc, sdio and nandc
Date:   Tue, 17 Sep 2019 10:19:00 +0200
Message-Id: <20190917081903.25139-2-heiko@sntech.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190917081903.25139-1-heiko@sntech.de>
References: <20190917081903.25139-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finley Xiao <finley.xiao@rock-chips.com>

Some IPs, such as NAND, EMMC, SDIO and SDMMC need clock of 50%  duty
cycle, divfree50 can generate clock of 50% duty cycle even in odd
value divisor.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-px30.c | 44 ++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk-px30.c b/drivers/clk/rockchip/clk-px30.c
index 3a501896b280..a973394f3d65 100644
--- a/drivers/clk/rockchip/clk-px30.c
+++ b/drivers/clk/rockchip/clk-px30.c
@@ -167,6 +167,10 @@ PNAME(mux_uart5_p)		= { "clk_uart5_src", "clk_uart5_np5", "clk_uart5_frac" };
 PNAME(mux_cif_out_p)		= { "xin24m", "dummy_cpll", "npll", "usb480m" };
 PNAME(mux_dclk_vopb_p)		= { "dclk_vopb_src", "dclk_vopb_frac", "xin24m" };
 PNAME(mux_dclk_vopl_p)		= { "dclk_vopl_src", "dclk_vopl_frac", "xin24m" };
+PNAME(mux_nandc_p)		= { "clk_nandc_div", "clk_nandc_div50" };
+PNAME(mux_sdio_p)		= { "clk_sdio_div", "clk_sdio_div50" };
+PNAME(mux_emmc_p)		= { "clk_emmc_div", "clk_emmc_div50" };
+PNAME(mux_sdmmc_p)		= { "clk_sdmmc_div", "clk_sdmmc_div50" };
 PNAME(mux_gmac_p)		= { "clk_gmac_src", "gmac_clkin" };
 PNAME(mux_gmac_rmii_sel_p)	= { "clk_gmac_rx_tx_div20", "clk_gmac_rx_tx_div2" };
 PNAME(mux_rtc32k_pmu_p)		= { "xin32k", "pmu_pvtm_32k", "clk_rtc32k_frac", };
@@ -460,16 +464,40 @@ static struct rockchip_clk_branch px30_clk_branches[] __initdata = {
 	/* PD_MMC_NAND */
 	GATE(HCLK_MMC_NAND, "hclk_mmc_nand", "hclk_peri_pre", 0,
 			PX30_CLKGATE_CON(6), 0, GFLAGS),
-	COMPOSITE(SCLK_NANDC, "clk_nandc", mux_gpll_cpll_npll_p, 0,
+	COMPOSITE(SCLK_NANDC_DIV, "clk_nandc_div", mux_gpll_cpll_npll_p, 0,
 			PX30_CLKSEL_CON(15), 6, 2, MFLAGS, 0, 5, DFLAGS,
+			PX30_CLKGATE_CON(5), 11, GFLAGS),
+	COMPOSITE(SCLK_NANDC_DIV50, "clk_nandc_div50", mux_gpll_cpll_npll_p, 0,
+			PX30_CLKSEL_CON(15), 6, 2, MFLAGS, 8, 5, DFLAGS,
+			PX30_CLKGATE_CON(5), 12, GFLAGS),
+	COMPOSITE_NODIV(SCLK_NANDC, "clk_nandc", mux_nandc_p,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
+			PX30_CLKSEL_CON(15), 15, 1, MFLAGS,
 			PX30_CLKGATE_CON(5), 13, GFLAGS),
 
-	COMPOSITE(SCLK_SDIO, "clk_sdio", mux_gpll_cpll_npll_xin24m_p, 0,
+	COMPOSITE(SCLK_SDIO_DIV, "clk_sdio_div", mux_gpll_cpll_npll_xin24m_p, 0,
 			PX30_CLKSEL_CON(18), 14, 2, MFLAGS, 0, 8, DFLAGS,
+			PX30_CLKGATE_CON(6), 1, GFLAGS),
+	COMPOSITE_DIV_OFFSET(SCLK_SDIO_DIV50, "clk_sdio_div50",
+			mux_gpll_cpll_npll_xin24m_p, 0,
+			PX30_CLKSEL_CON(18), 14, 2, MFLAGS,
+			PX30_CLKSEL_CON(19), 0, 8, DFLAGS,
+			PX30_CLKGATE_CON(6), 2, GFLAGS),
+	COMPOSITE_NODIV(SCLK_SDIO, "clk_sdio", mux_sdio_p,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
+			PX30_CLKSEL_CON(19), 15, 1, MFLAGS,
 			PX30_CLKGATE_CON(6), 3, GFLAGS),
 
-	COMPOSITE(SCLK_EMMC, "clk_emmc", mux_gpll_cpll_npll_xin24m_p, 0,
+	COMPOSITE(SCLK_EMMC_DIV, "clk_emmc_div", mux_gpll_cpll_npll_xin24m_p, 0,
 			PX30_CLKSEL_CON(20), 14, 2, MFLAGS, 0, 8, DFLAGS,
+			PX30_CLKGATE_CON(6), 4, GFLAGS),
+	COMPOSITE_DIV_OFFSET(SCLK_EMMC_DIV50, "clk_emmc_div50", mux_gpll_cpll_npll_xin24m_p, 0,
+			PX30_CLKSEL_CON(20), 14, 2, MFLAGS,
+			PX30_CLKSEL_CON(21), 0, 8, DFLAGS,
+			PX30_CLKGATE_CON(6), 5, GFLAGS),
+	COMPOSITE_NODIV(SCLK_EMMC, "clk_emmc", mux_emmc_p,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
+			PX30_CLKSEL_CON(21), 15, 1, MFLAGS,
 			PX30_CLKGATE_CON(6), 6, GFLAGS),
 
 	COMPOSITE(SCLK_SFC, "clk_sfc", mux_gpll_cpll_p, 0,
@@ -494,8 +522,16 @@ static struct rockchip_clk_branch px30_clk_branches[] __initdata = {
 	/* PD_SDCARD */
 	GATE(0, "hclk_sdmmc_pre", "hclk_peri_pre", 0,
 			PX30_CLKGATE_CON(6), 12, GFLAGS),
-	COMPOSITE(SCLK_SDMMC, "clk_sdmmc", mux_gpll_cpll_npll_xin24m_p, 0,
+	COMPOSITE(SCLK_SDMMC_DIV, "clk_sdmmc_div", mux_gpll_cpll_npll_xin24m_p, 0,
 			PX30_CLKSEL_CON(16), 14, 2, MFLAGS, 0, 8, DFLAGS,
+			PX30_CLKGATE_CON(6), 13, GFLAGS),
+	COMPOSITE_DIV_OFFSET(SCLK_SDMMC_DIV50, "clk_sdmmc_div50", mux_gpll_cpll_npll_xin24m_p, 0,
+			PX30_CLKSEL_CON(16), 14, 2, MFLAGS,
+			PX30_CLKSEL_CON(17), 0, 8, DFLAGS,
+			PX30_CLKGATE_CON(6), 14, GFLAGS),
+	COMPOSITE_NODIV(SCLK_SDMMC, "clk_sdmmc", mux_sdmmc_p,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
+			PX30_CLKSEL_CON(17), 15, 1, MFLAGS,
 			PX30_CLKGATE_CON(6), 15, GFLAGS),
 
 	/* PD_USB */
-- 
2.20.1

