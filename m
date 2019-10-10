Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4EEC47404
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 02:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D2420B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 02:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="PcALcLoS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OADQjVjK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732739AbfJJCJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 22:09:56 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:46333 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732219AbfJJCHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 22:07:55 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id E78A120B51;
        Wed,  9 Oct 2019 22:06:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 09 Oct 2019 22:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=gXUmnVUli/y3V
        yBEI1euJF3NoxsH2wWbrvVYjkbZXEc=; b=PcALcLoSErFFMgcGP3yoKmL5V9SR2
        Aq5Xd4l476/HxSLI+yD27EJ6md1PgnZHryesUb8rpM6nAGyFh28WVnRZa0LWwFZh
        KOtCOydKJe5hJuwDZjyoH2EsAK80M90iaYX93mVNFfi2aPCZWm4p9CZzWNDIP2s4
        WPzFJ8tlKz22qY5NyMO4I4v1CImj8YuRXzkNGFijAKxu7SoI+3kkm2uzX46TU0AY
        tZ/CC2ItEhNavB9ZVpoS1OlBqGzzI6gMp0Jg/zxjG4p0oETbFBl7AQ/AqBgz4Gk6
        e6xCHNlZ7Cc839QkbXAGhNASiN7Hq/FVdWiZLRUwv/ibqO8RiC+vSH78Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=gXUmnVUli/y3VyBEI1euJF3NoxsH2wWbrvVYjkbZXEc=; b=OADQjVjK
        8QHHZgsoAIicXVU7HvxV8g9SfcvScREj+avAdguj54fEc5jb0yDPPUnk/+Hls98t
        hOIybqyEiRw95fVOpQ8pYfqiTlicvtLo24uGc+LC179XrozvDOf1UHfTIP00qMJJ
        6jgPYxmceyMSxhsPX3K3nG1ieuTfDlFEnpDQZaG+6DfmpiSoQigkr5hC0MxjiMN0
        oxEb6eitUwqLipp1bEr682gP5lbubawTIzmpC1cpFQUjfyOg8EsBT5AJD+rjIvYw
        A3Dy1Zcdqldj4+Yu24SNHW1w6TbAkY6dKTtr+lBk3DozitTURhVjgvyaiVhIdeCV
        72NyBGJXpUBZyQ==
X-ME-Sender: <xms:JJKeXTx1g7CIjuMVtqLDktx2bbUcFz9tA0WJcTJCNgNewOVzag5PdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedriedvgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucfkphepvddtvddrkedurddukedrfedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihiivgep
    vd
X-ME-Proxy: <xmx:JJKeXe-MO_XqAvPbUVol9xOSbV3gt0s1wGp4V1acWt7vPeW2Z4D0OQ>
    <xmx:JJKeXYbJnw-D09bRU5ROZpXO_yMa_z88GdPn55mVmxgMrYKxlKR1XQ>
    <xmx:JJKeXa8RGO0C0KVNB9AnsEaBKy123ptoMlIPTPpHkS5lA5rcdgeYMg>
    <xmx:JJKeXXHWJNjxUJvz0ZZBJOdC4h51Q6dpz5TsczpHK6uuxDliBn9p4w>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7F6F98005C;
        Wed,  9 Oct 2019 22:06:25 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, joel@jms.id.au,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] clk: ast2600: Add RMII RCLK gates for all four MACs
Date:   Thu, 10 Oct 2019 12:37:25 +1030
Message-Id: <20191010020725.3990-3-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191010020725.3990-1-andrew@aj.id.au>
References: <20191010020725.3990-1-andrew@aj.id.au>
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
index 1c1bb39bb04e..85acc7cdc83c 100644
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
+	hw = clk_hw_register_gate(dev, "mac1rclk", "mac12rclk", 0,
+			scu_g6_base + ASPEED_MAC12_CLK_DLY, 29, 0,
+			&aspeed_g6_clk_lock);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+	aspeed_g6_clk_data->hws[ASPEED_CLK_MAC1RCLK] = hw;
+
+	/* RMII2 50MHz (RCLK) output enable */
+	hw = clk_hw_register_gate(dev, "mac2rclk", "mac12rclk", 0,
+			scu_g6_base + ASPEED_MAC12_CLK_DLY, 30, 0,
+			&aspeed_g6_clk_lock);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+	aspeed_g6_clk_data->hws[ASPEED_CLK_MAC2RCLK] = hw;
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
+	hw = clk_hw_register_gate(dev, "mac3rclk", "mac34rclk", 0,
+			scu_g6_base + ASPEED_MAC34_CLK_DLY, 29, 0,
+			&aspeed_g6_clk_lock);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+	aspeed_g6_clk_data->hws[ASPEED_CLK_MAC3RCLK] = hw;
+
+	/* RMII4 50MHz (RCLK) output enable */
+	hw = clk_hw_register_gate(dev, "mac4rclk", "mac34rclk", 0,
+			scu_g6_base + ASPEED_MAC34_CLK_DLY, 30, 0,
+			&aspeed_g6_clk_lock);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+	aspeed_g6_clk_data->hws[ASPEED_CLK_MAC4RCLK] = hw;
+
 	/* LPC Host (LHCLK) clock divider */
 	hw = clk_hw_register_divider_table(dev, "lhclk", "hpll", 0,
 			scu_g6_base + ASPEED_G6_CLK_SELECTION1, 20, 3, 0,
-- 
2.20.1

