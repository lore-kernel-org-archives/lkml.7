Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69542C31E50
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 15:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487792184B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 15:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfFOPai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 11:30:38 -0400
Received: from gloria.sntech.de ([185.11.138.130]:53344 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbfFOPai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 11:30:38 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hcAdX-0002kc-Og; Sat, 15 Jun 2019 17:30:35 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, papadakospan@gmail.com,
        sboyd@kernel.org, mturquette@baylibre.com,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 2/3] clk: rockchip: add watchdog pclk on rk3328
Date:   Sat, 15 Jun 2019 17:30:31 +0200
Message-Id: <20190615153032.27772-2-heiko@sntech.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190615153032.27772-1-heiko@sntech.de>
References: <20190615153032.27772-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The watchdog pclk is controlled from the secure GRF but we still
want to mention it explicitly to not use arbitary parent clocks
in the devicetree wdt node, so add a SGRF_GATE for it.

Suggested-by: Leonidas P. Papadakos <papadakospan@gmail.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-rk3328.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/rockchip/clk-rk3328.c b/drivers/clk/rockchip/clk-rk3328.c
index 076b9777a955..c186a1985bf4 100644
--- a/drivers/clk/rockchip/clk-rk3328.c
+++ b/drivers/clk/rockchip/clk-rk3328.c
@@ -791,6 +791,9 @@ static struct rockchip_clk_branch rk3328_clk_branches[] __initdata = {
 	GATE(PCLK_SARADC, "pclk_saradc", "pclk_bus", 0, RK3328_CLKGATE_CON(17), 15, GFLAGS),
 	GATE(0, "pclk_pmu", "pclk_bus", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(28), 3, GFLAGS),
 
+	/* Watchdog pclk is controlled from the secure GRF */
+	SGRF_GATE(PCLK_WDT, "pclk_wdt", "pclk_bus"),
+
 	GATE(PCLK_USB3PHY_OTG, "pclk_usb3phy_otg", "pclk_phy_pre", 0, RK3328_CLKGATE_CON(28), 1, GFLAGS),
 	GATE(PCLK_USB3PHY_PIPE, "pclk_usb3phy_pipe", "pclk_phy_pre", 0, RK3328_CLKGATE_CON(28), 2, GFLAGS),
 	GATE(PCLK_USB3_GRF, "pclk_usb3_grf", "pclk_phy_pre", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(17), 2, GFLAGS),
-- 
2.20.1

