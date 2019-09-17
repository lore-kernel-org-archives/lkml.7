Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FD7C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251F921670
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389125AbfIQIT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 04:19:29 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46554 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388824AbfIQIT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:19:26 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iA8hn-0005Uf-4y; Tue, 17 Sep 2019 10:19:23 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        finley.xiao@rock-chips.com, zhangqing@rock-chips.com,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 5/5] clk: rockchip: protect the pclk_usb_grf as critical
Date:   Tue, 17 Sep 2019 10:19:03 +0200
Message-Id: <20190917081903.25139-5-heiko@sntech.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190917081903.25139-1-heiko@sntech.de>
References: <20190917081903.25139-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make this clock a real critical clock, so that writes to the usbphy grf
always succeed.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-px30.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-px30.c b/drivers/clk/rockchip/clk-px30.c
index 7a8bc416c947..6fb9c98b7d24 100644
--- a/drivers/clk/rockchip/clk-px30.c
+++ b/drivers/clk/rockchip/clk-px30.c
@@ -799,7 +799,7 @@ static struct rockchip_clk_branch px30_clk_branches[] __initdata = {
 	GATE(0, "pclk_ddrphy", "pclk_top_pre", CLK_IGNORE_UNUSED, PX30_CLKGATE_CON(16), 3, GFLAGS),
 	GATE(PCLK_MIPIDSIPHY, "pclk_mipidsiphy", "pclk_top_pre", 0, PX30_CLKGATE_CON(16), 4, GFLAGS),
 	GATE(PCLK_MIPICSIPHY, "pclk_mipicsiphy", "pclk_top_pre", 0, PX30_CLKGATE_CON(16), 5, GFLAGS),
-	GATE(PCLK_USB_GRF, "pclk_usb_grf", "pclk_top_pre", CLK_IGNORE_UNUSED, PX30_CLKGATE_CON(16), 6, GFLAGS),
+	GATE(PCLK_USB_GRF, "pclk_usb_grf", "pclk_top_pre", 0, PX30_CLKGATE_CON(16), 6, GFLAGS),
 	GATE(0, "pclk_cpu_hoost", "pclk_top_pre", CLK_IGNORE_UNUSED, PX30_CLKGATE_CON(16), 7, GFLAGS),
 
 	/* PD_VI */
@@ -995,6 +995,7 @@ static const char *const px30_cru_critical_clocks[] __initconst = {
 	"usb480m",
 	"clk_uart2",
 	"pclk_uart2",
+	"pclk_usb_grf",
 };
 
 static void __init px30_clk_init(struct device_node *np)
-- 
2.20.1

