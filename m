Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC29C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF02206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558339570;
	bh=raAt8ipYjBhGFbDlGMuzDJpgi0ln4BsxFF01Er+hiOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vg7kVpcE/Jz1wF3d0AO8qJJlEXsw1N2ZUtrEtrb4gmheC9b8lBs4IkDYtjuIwytKi
	 D/0QmVCo/Ay2PmrJltegzUTciccYvy/tZ1SuPZvjTUYdraEbdfrubTs6JZJKt5A3za
	 UG2v0Z1vuzLgLQpw6fyg4sszRPn7w17RByDyeKMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbfETIGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:06:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730931AbfETIFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:05:40 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 849C121743;
        Mon, 20 May 2019 08:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558339539;
        bh=raAt8ipYjBhGFbDlGMuzDJpgi0ln4BsxFF01Er+hiOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jdYWZljd+XAmUtm4/Z1mZgnln1MY3TLs3bGN2c3jBzfPq+orINhXfSAKftcTlfG42
         G2+RG50MhGqJnLEouQF/taYE5GkqfuaPqKJurtmjX5r8y3xw5u0RtkjwIXLmgBy8t9
         0EKyN9ENR6AglhM0KnypGVLs62aHiDQoRQizQPXU=
Received: by wens.tw (Postfix, from userid 1000)
        id 07DF46586A; Mon, 20 May 2019 16:05:32 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 25/25] clk: sunxi-ng: sun8i-r: Use local parent references for SUNXI_CCU_GATE
Date:   Mon, 20 May 2019 16:04:21 +0800
Message-Id: <20190520080421.12575-26-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520080421.12575-1-wens@kernel.org>
References: <20190520080421.12575-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

With the new clk parenting code and SUNXI_CCU_GATE macros, we can
reference parents locally via pointers to struct clk_hw or DT
clock-names.

Convert existing SUNXI_CCU_GATE definitions to SUNXI_CCU_GATE_HWS
as the parent clock is internal to this clock unit.

To avoid duplication of clock definitions, we fix up the parent
reference for A83T in the A83T init function.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-r.c | 37 +++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r.c b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
index 4a111c28b8c3..a7a21feaf143 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
@@ -73,20 +73,26 @@ static struct ccu_div apb0_clk = {
 
 static SUNXI_CCU_M(a83t_apb0_clk, "apb0", "ahb0", 0x0c, 0, 2, 0);
 
-static SUNXI_CCU_GATE(apb0_pio_clk,	"apb0-pio",	"apb0",
-		      0x28, BIT(0), 0);
-static SUNXI_CCU_GATE(apb0_ir_clk,	"apb0-ir",	"apb0",
-		      0x28, BIT(1), 0);
-static SUNXI_CCU_GATE(apb0_timer_clk,	"apb0-timer",	"apb0",
-		      0x28, BIT(2), 0);
-static SUNXI_CCU_GATE(apb0_rsb_clk,	"apb0-rsb",	"apb0",
-		      0x28, BIT(3), 0);
-static SUNXI_CCU_GATE(apb0_uart_clk,	"apb0-uart",	"apb0",
-		      0x28, BIT(4), 0);
-static SUNXI_CCU_GATE(apb0_i2c_clk,	"apb0-i2c",	"apb0",
-		      0x28, BIT(6), 0);
-static SUNXI_CCU_GATE(apb0_twd_clk,	"apb0-twd",	"apb0",
-		      0x28, BIT(7), 0);
+/*
+ * Define the parent as an array that can be reused to save space
+ * instead of having compound literals for each gate. Also have it
+ * non-const so we can change it on the A83T.
+ */
+static const struct clk_hw *apb0_gate_parent[] = { &apb0_clk.common.hw };
+static SUNXI_CCU_GATE_HWS(apb0_pio_clk,		"apb0-pio",
+			  apb0_gate_parent, 0x28, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(apb0_ir_clk,		"apb0-ir",
+			  apb0_gate_parent, 0x28, BIT(1), 0);
+static SUNXI_CCU_GATE_HWS(apb0_timer_clk,	"apb0-timer",
+			  apb0_gate_parent, 0x28, BIT(2), 0);
+static SUNXI_CCU_GATE_HWS(apb0_rsb_clk,		"apb0-rsb",
+			  apb0_gate_parent, 0x28, BIT(3), 0);
+static SUNXI_CCU_GATE_HWS(apb0_uart_clk,	"apb0-uart",
+			  apb0_gate_parent, 0x28, BIT(4), 0);
+static SUNXI_CCU_GATE_HWS(apb0_i2c_clk,		"apb0-i2c",
+			  apb0_gate_parent, 0x28, BIT(6), 0);
+static SUNXI_CCU_GATE_HWS(apb0_twd_clk,		"apb0-twd",
+			  apb0_gate_parent, 0x28, BIT(7), 0);
 
 static const char * const r_mod0_default_parents[] = { "osc32k", "osc24M" };
 static SUNXI_CCU_MP_WITH_MUX_GATE(ir_clk, "ir",
@@ -284,6 +290,9 @@ static void __init sunxi_r_ccu_init(struct device_node *node,
 
 static void __init sun8i_a83t_r_ccu_setup(struct device_node *node)
 {
+	/* Fix apb0 bus gate parents here */
+	apb0_gate_parent[0] = &a83t_apb0_clk.common.hw;
+
 	sunxi_r_ccu_init(node, &sun8i_a83t_r_ccu_desc);
 }
 CLK_OF_DECLARE(sun8i_a83t_r_ccu, "allwinner,sun8i-a83t-r-ccu",
-- 
2.20.1

