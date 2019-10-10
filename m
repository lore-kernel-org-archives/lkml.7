Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBC6ECE58C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 02:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786F820B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 02:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="T9pFEC/h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vzmGa8Jl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732666AbfJJCIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 22:08:04 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:48093 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726659AbfJJCGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 22:06:01 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C3C5221F69;
        Wed,  9 Oct 2019 22:05:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 09 Oct 2019 22:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=8kdG9zhIR956q
        GWhaPFWlTIP80VwjVLkxKENfTlDMS4=; b=T9pFEC/haKQdt6yfBtJSBGMvDidCG
        Wc7V7ru+eoWGwPQn9EL6H04eoPP74i1b32ctbp3u0h9y60Zmd5ldEpfc8WQArat1
        Kf9iWKdCsd1D/HqChep8+PaEr89/OEtOpfVGAoDNU/0l2XcwIQ3gyZDvXTrs1X+9
        3Gn8vDUaWohBPvVMfDX4egdTosQ8pBNGSLa6NhblaqSL/B8ymITsLFrXeawbzi03
        JTjXenIw1CA0knSIEo7aytt5ULQpvDFKjQ4YQKhA9eKpeykHXsfaeEP2CqhRQlKv
        a3Zfc0Ny07H3/5Tf8O7MOmC40ylwMfg645fOLJnC7ade1fef4l+7QsV/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=8kdG9zhIR956qGWhaPFWlTIP80VwjVLkxKENfTlDMS4=; b=vzmGa8Jl
        jmeLM7E89olc4fD/vvKJqaLXhB2HqLvceEvp27OauGTtDr8ADbFJQXv0TJEnzI5z
        kXEVTQhT2FAaqHJj4m+r8zVI1vrNJbrvQ8BT7PLFpb6xG8WenmSBDolYhMe0O4y5
        Mvqdauh2BjWfR2/92zJjXQVrsoi+boEGtTFocmatoQXA4HiTjwrv/qOzJ6lNgVN4
        bLXwRPsPW2EOIdZZpfnXSPykpNC3jh0ofL+40eAQV3vd9QctjgX7jxtmz9F0vyxD
        taiL15tudBLMe+/2aRBeLlfE+BsRS0bRVYrJeYrT5qf0i+soBdvUIobq6jlb0SZ8
        /fT93ZVW0FPmKA==
X-ME-Sender: <xms:B5KeXbVxFuO3-aitgcQhhs2p5qBvkrkRGH-ql_ViIfaTrJGwv2C29g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedriedvgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucfkphepvddtvddrkedurddukedrfedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihiivgep
    td
X-ME-Proxy: <xmx:B5KeXX39t0TUd5lmpFzMwU5YYATuC3t1ttl8lJkkisjHxuS_WtELMw>
    <xmx:B5KeXSYp_GaDcMGXCKEj9syTWGDZgCdZ_ed_FUm0HiIedyvkNQRyLw>
    <xmx:B5KeXaqyXFgQU-E10YIONlatb1Z7Mg5rHlZuN2UKHFtmBRwoNTJo5Q>
    <xmx:B5KeXWeYjp2gYpH70wSoy-OvAMz9B8GQdbfoWPt7vjJ2OahhZU12Tg>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6CA8FD6005D;
        Wed,  9 Oct 2019 22:05:56 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, joel@jms.id.au,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] clk: aspeed: Add RMII RCLK gates for both AST2500 MACs
Date:   Thu, 10 Oct 2019 12:36:55 +1030
Message-Id: <20191010020655.3776-3-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191010020655.3776-1-andrew@aj.id.au>
References: <20191010020655.3776-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RCLK is a fixed 50MHz clock derived from HPLL that is described by a
single gate for each MAC.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
v2: Drop "-gate" from clock names

 drivers/clk/clk-aspeed.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
index abf06fb6453e..411ff5fb2c07 100644
--- a/drivers/clk/clk-aspeed.c
+++ b/drivers/clk/clk-aspeed.c
@@ -14,7 +14,7 @@
 
 #include "clk-aspeed.h"
 
-#define ASPEED_NUM_CLKS		36
+#define ASPEED_NUM_CLKS		38
 
 #define ASPEED_RESET2_OFFSET	32
 
@@ -28,6 +28,7 @@
 #define  AST2400_HPLL_BYPASS_EN	BIT(17)
 #define ASPEED_MISC_CTRL	0x2c
 #define  UART_DIV13_EN		BIT(12)
+#define ASPEED_MAC_CLK_DLY	0x48
 #define ASPEED_STRAP		0x70
 #define  CLKIN_25MHZ_EN		BIT(23)
 #define  AST2400_CLK_SOURCE_SEL	BIT(18)
@@ -462,6 +463,30 @@ static int aspeed_clk_probe(struct platform_device *pdev)
 		return PTR_ERR(hw);
 	aspeed_clk_data->hws[ASPEED_CLK_MAC] = hw;
 
+	if (of_device_is_compatible(pdev->dev.of_node, "aspeed,ast2500-scu")) {
+		/* RMII 50MHz RCLK */
+		hw = clk_hw_register_fixed_rate(dev, "mac12rclk", "hpll", 0,
+						50000000);
+		if (IS_ERR(hw))
+			return PTR_ERR(hw);
+
+		/* RMII1 50MHz (RCLK) output enable */
+		hw = clk_hw_register_gate(dev, "mac1rclk", "mac12rclk", 0,
+				scu_base + ASPEED_MAC_CLK_DLY, 29, 0,
+				&aspeed_clk_lock);
+		if (IS_ERR(hw))
+			return PTR_ERR(hw);
+		aspeed_clk_data->hws[ASPEED_CLK_MAC1RCLK] = hw;
+
+		/* RMII2 50MHz (RCLK) output enable */
+		hw = clk_hw_register_gate(dev, "mac2rclk", "mac12rclk", 0,
+				scu_base + ASPEED_MAC_CLK_DLY, 30, 0,
+				&aspeed_clk_lock);
+		if (IS_ERR(hw))
+			return PTR_ERR(hw);
+		aspeed_clk_data->hws[ASPEED_CLK_MAC2RCLK] = hw;
+	}
+
 	/* LPC Host (LHCLK) clock divider */
 	hw = clk_hw_register_divider_table(dev, "lhclk", "hpll", 0,
 			scu_base + ASPEED_CLK_SELECTION, 20, 3, 0,
-- 
2.20.1

