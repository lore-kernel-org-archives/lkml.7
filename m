Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8F8C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31A820678
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389201AbfIQITl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 04:19:41 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46544 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbfIQIT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:19:26 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iA8hm-0005Uf-FF; Tue, 17 Sep 2019 10:19:22 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        finley.xiao@rock-chips.com, zhangqing@rock-chips.com,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 3/5] clk: rockchip: move px30 critical clocks to correct clock controller
Date:   Tue, 17 Sep 2019 10:19:01 +0200
Message-Id: <20190917081903.25139-3-heiko@sntech.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190917081903.25139-1-heiko@sntech.de>
References: <20190917081903.25139-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clocks in the px30 critical clock section are from the regular cru not
the pmucru, so move them to the correct place.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-px30.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk-px30.c b/drivers/clk/rockchip/clk-px30.c
index a973394f3d65..5c77da1e3abc 100644
--- a/drivers/clk/rockchip/clk-px30.c
+++ b/drivers/clk/rockchip/clk-px30.c
@@ -976,7 +976,7 @@ static struct rockchip_clk_branch px30_clk_pmu_branches[] __initdata = {
 	GATE(0, "pclk_cru_pmu", "pclk_pmu_pre", CLK_IGNORE_UNUSED, PX30_PMU_CLKGATE_CON(0), 8, GFLAGS),
 };
 
-static const char *const px30_pmucru_critical_clocks[] __initconst = {
+static const char *const px30_cru_critical_clocks[] __initconst = {
 	"aclk_bus_pre",
 	"pclk_bus_pre",
 	"hclk_bus_pre",
@@ -1021,6 +1021,9 @@ static void __init px30_clk_init(struct device_node *np)
 				     &px30_cpuclk_data, px30_cpuclk_rates,
 				     ARRAY_SIZE(px30_cpuclk_rates));
 
+	rockchip_clk_protect_critical(px30_cru_critical_clocks,
+				      ARRAY_SIZE(px30_cru_critical_clocks));
+
 	rockchip_register_softrst(np, 12, reg_base + PX30_SOFTRST_CON(0),
 				  ROCKCHIP_SOFTRST_HIWORD_MASK);
 
@@ -1053,9 +1056,6 @@ static void __init px30_pmu_clk_init(struct device_node *np)
 	rockchip_clk_register_branches(ctx, px30_clk_pmu_branches,
 				       ARRAY_SIZE(px30_clk_pmu_branches));
 
-	rockchip_clk_protect_critical(px30_pmucru_critical_clocks,
-				      ARRAY_SIZE(px30_pmucru_critical_clocks));
-
 	rockchip_clk_of_add_provider(np, ctx);
 }
 CLK_OF_DECLARE(px30_cru_pmu, "rockchip,px30-pmucru", px30_pmu_clk_init);
-- 
2.20.1

