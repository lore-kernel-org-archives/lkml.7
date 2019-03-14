Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFD4C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8496721019
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfCNLVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:21:23 -0400
Received: from hermes.aosc.io ([199.195.250.187]:37377 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbfCNLVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:21:23 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 195AD844C2;
        Thu, 14 Mar 2019 11:21:18 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH] clk: sunxi-ng: f1c100s: fix USB PHY gate bit offset
Date:   Thu, 14 Mar 2019 19:21:08 +0800
Message-Id: <20190314112108.6150-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bit offset of the USB PHY clock gate on F1C100s should be 1, not 8.

Fix this problem.

Fixes: 0380126eb9af ("clk: sunxi-ng: add support for suniv F1C100s SoC")
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
index a09dfbe36402..dc9f0a365664 100644
--- a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
+++ b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
@@ -240,7 +240,7 @@ static SUNXI_CCU_MUX_WITH_GATE(spdif_clk, "spdif", i2s_spdif_parents,
 /* The BSP header file has a CIR_CFG, but no mod clock uses this definition */
 
 static SUNXI_CCU_GATE(usb_phy0_clk,	"usb-phy0",	"osc24M",
-		      0x0cc, BIT(8), 0);
+		      0x0cc, BIT(1), 0);
 
 static SUNXI_CCU_GATE(dram_ve_clk,	"dram-ve",	"pll-ddr",
 		      0x100, BIT(0), 0);
-- 
2.18.1

