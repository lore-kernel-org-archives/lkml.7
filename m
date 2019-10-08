Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F5AC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFA220673
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="nq9AxuNJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="azhTnAVe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbfJHLfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 07:35:04 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52337 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730922AbfJHLfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:35:02 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8035720C8D;
        Tue,  8 Oct 2019 07:35:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 08 Oct 2019 07:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=gThk5N8GNyMLN
        R2fmeMG7nM9OnHnu8uWwPrQnFsAqSc=; b=nq9AxuNJYi7vUjMx8pJFjdstQH0FS
        k14wmh0U4nZ6z1PdSgbvbVFn252piJiQB99nRK0v8EZi5l5KpyRz767bpMwGQhSn
        3WgjNxfMFyU4rBhNHkZokF6ffEVsUkvETisW0nH6oC3CCH4easg5+zOQi0hbVoMH
        7CCF2RijCxaWDikVrC7fQkJrAM/Y6Wf3Az9o+pgaXXMfqC2x2pyACoEdTwvtEnAr
        fave4VG2rQ+qiT9MPmaif/uv1vZTwTH7JurEhxuANR3LTyKRcHAMpW4qL+Ri9DfY
        7QMXtey9BhQxOujWg7bUaVZbmTCCrQXCaNHIEdu2tobnOuokdvwpTm4rA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=gThk5N8GNyMLNR2fmeMG7nM9OnHnu8uWwPrQnFsAqSc=; b=azhTnAVe
        MePmCXEgb4KUZk7OZIaKrvELRnhvR8bQG5mxdQbqJ41TZOrdZM2Xu83ffQTuxUch
        M1CG/oUqZ8s2B6W+CCt1Z4UP08pw1x+120cFYDjWDGJOHrWyu/o4Qn2SGmyqc5Uo
        0Z5u7QQMzh3BLAIpZmuwnKIgsc8ALaKvzSoXY35Wp4zqWfdF3bl0iIh/FAsnKEka
        XwWPD0Hl/Td978+McC+F0sT7K8lYoxkfKyZJPUwPKx1uMgsL25yhleYv7RlK+A9b
        dTcgTJvvvVkhYkwb6Cf7dnCpg8uIchBjMcT/jwoJj8Et6V5Yg5cBmdemo2ZCpIRN
        0sQ9/i0GZpna1w==
X-ME-Sender: <xms:ZXScXWBYtgtRhEhqEorFaUiLBm3pBx4-VPUIANtZL2dHpjrnPn6Z4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrheelgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucfkphepvddtfedrheejrddvudehrddujeeknecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihii
    vgepfe
X-ME-Proxy: <xmx:ZXScXWZkkAqowKzUWR7_a09mwSi10l6hx8LZVhIF1anB2c_KZclwIA>
    <xmx:ZXScXUz6PlTBdeTzqnAjWU-X0pJ7l-tgCPLYv06YOIxcObtgRZjSow>
    <xmx:ZXScXe1e1nGXJkH146PrWtthVgwhcZD5mwsu8eMdRz-zEp_Pw12Y3Q>
    <xmx:ZXScXURWNOkvsO_i8Zwz65_YBs-GIm0qv8VznaISEkP6saqKyrUKjA>
Received: from mistburn.lan (203-57-215-178.dyn.iinet.net.au [203.57.215.178])
        by mail.messagingengine.com (Postfix) with ESMTPA id 97DE180059;
        Tue,  8 Oct 2019 07:34:57 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, joel@jms.id.au,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] clk: ast2600: Add RMII RCLK gates for all four MACs
Date:   Tue,  8 Oct 2019 22:05:53 +1030
Message-Id: <20191008113553.13662-3-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008113553.13662-1-andrew@aj.id.au>
References: <20191008113553.13662-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RCLK is a fixed 50MHz clock derived from HPLL/HCLK that is described by a
single gate for each MAC.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/clk/clk-ast2600.c | 47 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
index 1c1bb39bb04e..3d6fc781fee0 100644
--- a/drivers/clk/clk-ast2600.c
+++ b/drivers/clk/clk-ast2600.c
@@ -15,7 +15,7 @@
 
 #include "clk-aspeed.h"
 
-#define ASPEED_G6_NUM_CLKS		67
+#define ASPEED_G6_NUM_CLKS		71
 
 #define ASPEED_G6_SILICON_REV		0x004
 
@@ -40,6 +40,9 @@
 
 #define ASPEED_G6_STRAP1		0x500
 
+#define ASPEED_MAC12_CLK_DLY		0x340
+#define ASPEED_MAC34_CLK_DLY		0x350
+
 /* Globally visible clocks */
 static DEFINE_SPINLOCK(aspeed_g6_clk_lock);
 
@@ -485,6 +488,11 @@ static int aspeed_g6_clk_probe(struct platform_device *pdev)
 		return PTR_ERR(hw);
 	aspeed_g6_clk_data->hws[ASPEED_CLK_SDIO] = hw;
 
+	/* MAC1/2 RMII 50MHz RCLK */
+	hw = clk_hw_register_fixed_rate(dev, "mac12rclk", "hpll", 0, 50000000);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
 	/* MAC1/2 AHB bus clock divider */
 	hw = clk_hw_register_divider_table(dev, "mac12", "hpll", 0,
 			scu_g6_base + ASPEED_G6_CLK_SELECTION1, 16, 3, 0,
@@ -494,6 +502,27 @@ static int aspeed_g6_clk_probe(struct platform_device *pdev)
 		return PTR_ERR(hw);
 	aspeed_g6_clk_data->hws[ASPEED_CLK_MAC12] = hw;
 
+	/* RMII1 50MHz (RCLK) output enable */
+	hw = clk_hw_register_gate(dev, "mac1rclk-gate", "mac12rclk", 0,
+			scu_g6_base + ASPEED_MAC12_CLK_DLY, 29, 0,
+			&aspeed_g6_clk_lock);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+	aspeed_g6_clk_data->hws[ASPEED_CLK_GATE_MAC1RCLK] = hw;
+
+	/* RMII2 50MHz (RCLK) output enable */
+	hw = clk_hw_register_gate(dev, "mac2rclk-gate", "mac12rclk", 0,
+			scu_g6_base + ASPEED_MAC12_CLK_DLY, 30, 0,
+			&aspeed_g6_clk_lock);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+	aspeed_g6_clk_data->hws[ASPEED_CLK_GATE_MAC2RCLK] = hw;
+
+	/* MAC1/2 RMII 50MHz RCLK */
+	hw = clk_hw_register_fixed_rate(dev, "mac34rclk", "hclk", 0, 50000000);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
 	/* MAC3/4 AHB bus clock divider */
 	hw = clk_hw_register_divider_table(dev, "mac34", "hpll", 0,
 			scu_g6_base + 0x310, 24, 3, 0,
@@ -503,6 +532,22 @@ static int aspeed_g6_clk_probe(struct platform_device *pdev)
 		return PTR_ERR(hw);
 	aspeed_g6_clk_data->hws[ASPEED_CLK_MAC34] = hw;
 
+	/* RMII3 50MHz (RCLK) output enable */
+	hw = clk_hw_register_gate(dev, "mac3rclk-gate", "mac34rclk", 0,
+			scu_g6_base + ASPEED_MAC34_CLK_DLY, 29, 0,
+			&aspeed_g6_clk_lock);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+	aspeed_g6_clk_data->hws[ASPEED_CLK_GATE_MAC3RCLK] = hw;
+
+	/* RMII4 50MHz (RCLK) output enable */
+	hw = clk_hw_register_gate(dev, "mac4rclk-gate", "mac34rclk", 0,
+			scu_g6_base + ASPEED_MAC34_CLK_DLY, 30, 0,
+			&aspeed_g6_clk_lock);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+	aspeed_g6_clk_data->hws[ASPEED_CLK_GATE_MAC4RCLK] = hw;
+
 	/* LPC Host (LHCLK) clock divider */
 	hw = clk_hw_register_divider_table(dev, "lhclk", "hpll", 0,
 			scu_g6_base + ASPEED_G6_CLK_SELECTION1, 20, 3, 0,
-- 
2.20.1

