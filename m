Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0933C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CEC1275BC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfFCRJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:09:33 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38290 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728660AbfFCRJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:09:32 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hXqSg-0004ZW-4y; Mon, 03 Jun 2019 19:09:30 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     broonie@kernel.org, lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        tony.xie@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com, Stephen Boyd <sboyd@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v8 RESEND 5/5] clk: RK808: add RK809 and RK817 support.
Date:   Mon,  3 Jun 2019 19:09:00 +0200
Message-Id: <20190603170900.5195-6-heiko@sntech.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190603170900.5195-1-heiko@sntech.de>
References: <20190603170900.5195-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Xie <tony.xie@rock-chips.com>

RK809 and RK817 are power management IC chips for multimedia products.
most of their functions and registers are same, including the clkout
funciton.

Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/Kconfig     |  9 +++---
 drivers/clk/clk-rk808.c | 64 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index e705aab9e38b..3d3899ee64a0 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -52,13 +52,12 @@ config COMMON_CLK_MAX9485
 	  This driver supports Maxim 9485 Programmable Audio Clock Generator
 
 config COMMON_CLK_RK808
-	tristate "Clock driver for RK805/RK808/RK818"
+	tristate "Clock driver for RK805/RK808/RK809/RK817/RK818"
 	depends on MFD_RK808
 	---help---
-	  This driver supports RK805, RK808 and RK818 crystal oscillator clock. These
-	  multi-function devices have two fixed-rate oscillators,
-	  clocked at 32KHz each. Clkout1 is always on, Clkout2 can off
-	  by control register.
+	  This driver supports RK805, RK809 and RK817, RK808 and RK818 crystal oscillator clock.
+	  These multi-function devices have two fixed-rate oscillators, clocked at 32KHz each.
+	  Clkout1 is always on, Clkout2 can off by control register.
 
 config COMMON_CLK_HI655X
 	tristate "Clock driver for Hi655x" if EXPERT
diff --git a/drivers/clk/clk-rk808.c b/drivers/clk/clk-rk808.c
index 8d90bdf5b946..75f2cf0dfc9f 100644
--- a/drivers/clk/clk-rk808.c
+++ b/drivers/clk/clk-rk808.c
@@ -96,6 +96,68 @@ of_clk_rk808_get(struct of_phandle_args *clkspec, void *data)
 	return idx ? &rk808_clkout->clkout2_hw : &rk808_clkout->clkout1_hw;
 }
 
+static int rk817_clkout2_enable(struct clk_hw *hw, bool enable)
+{
+	struct rk808_clkout *rk808_clkout = container_of(hw,
+							 struct rk808_clkout,
+							 clkout2_hw);
+	struct rk808 *rk808 = rk808_clkout->rk808;
+
+	return regmap_update_bits(rk808->regmap, RK817_SYS_CFG(1),
+				  RK817_CLK32KOUT2_EN,
+				  enable ? RK817_CLK32KOUT2_EN : 0);
+}
+
+static int rk817_clkout2_prepare(struct clk_hw *hw)
+{
+	return rk817_clkout2_enable(hw, true);
+}
+
+static void rk817_clkout2_unprepare(struct clk_hw *hw)
+{
+	rk817_clkout2_enable(hw, false);
+}
+
+static int rk817_clkout2_is_prepared(struct clk_hw *hw)
+{
+	struct rk808_clkout *rk808_clkout = container_of(hw,
+							 struct rk808_clkout,
+							 clkout2_hw);
+	struct rk808 *rk808 = rk808_clkout->rk808;
+	unsigned int val;
+
+	int ret = regmap_read(rk808->regmap, RK817_SYS_CFG(1), &val);
+
+	if (ret < 0)
+		return 0;
+
+	return (val & RK817_CLK32KOUT2_EN) ? 1 : 0;
+}
+
+static const struct clk_ops rk817_clkout2_ops = {
+	.prepare = rk817_clkout2_prepare,
+	.unprepare = rk817_clkout2_unprepare,
+	.is_prepared = rk817_clkout2_is_prepared,
+	.recalc_rate = rk808_clkout_recalc_rate,
+};
+
+static const struct clk_ops *rkpmic_get_ops(long variant)
+{
+	switch (variant) {
+	case RK809_ID:
+	case RK817_ID:
+		return &rk817_clkout2_ops;
+	/*
+	 * For the default case, it match the following PMIC type.
+	 * RK805_ID
+	 * RK808_ID
+	 * RK818_ID
+	 */
+	default:
+		return &rk808_clkout2_ops;
+	}
+}
+
 static int rk808_clkout_probe(struct platform_device *pdev)
 {
 	struct rk808 *rk808 = dev_get_drvdata(pdev->dev.parent);
@@ -127,7 +189,7 @@ static int rk808_clkout_probe(struct platform_device *pdev)
 		return ret;
 
 	init.name = "rk808-clkout2";
-	init.ops = &rk808_clkout2_ops;
+	init.ops = rkpmic_get_ops(rk808->variant);
 	rk808_clkout->clkout2_hw.init = &init;
 
 	/* optional override of the clockname */
-- 
2.20.1

