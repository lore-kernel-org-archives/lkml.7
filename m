Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A081C74A26
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02ACA2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Kz5a5tTx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sjRKgULh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfGJOKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 10:10:23 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36623 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727595AbfGJOKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 10:10:23 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id DE6A3220A3;
        Wed, 10 Jul 2019 10:10:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 10 Jul 2019 10:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=oEpi+6+0w26RCxBP4UT6DzJfnA
        X/f9uFoVKZM8Skn8A=; b=Kz5a5tTxNyorBcpc+UNoDcGZpcJKbJC4GIVEch3yMC
        Rhi3ealHNcRancfrfjCRkHgsXQBmT1B55ANVKy9S0SYuEXYdroWXy0G07sMA8BBu
        CNfXnuAcI29EpjBlakDLLMqJoDttEkzNecg47h2RUXU1qbU9dd8jxbmfMo8c6CCx
        JWv0ZjpQM9BrCMhVMUC+TOrNNlvnMI4HmRrZGmFAAvXzPpaneWpaDx+DjaOshBYJ
        +xeGhGESLn9jBWUshcUU4fISJVA1ndYMFre96rIbKJ1bUHoWzgQE+pPLAqV+Pcdm
        s4I8NUEB/03sBb3bmRYxRqSPNvwouIcf98U1twAUiSFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=oEpi+6+0w26RCxBP4
        UT6DzJfnAX/f9uFoVKZM8Skn8A=; b=sjRKgULhpy0LQqshO1disWZtV/hBTF9wo
        ZlAq/FM7O7aKxYNtCcqCk4YlTvJnGeahvgjtCzKNEG9HHZYqmo7YQrpDfR87kEel
        cCu4WeDaL7nywSRsLUsOTMrGDmmZ7O9pOuEAw3Qfn5var7OQan+RAd5ysijMJHJX
        2ljMxd/j3wTifFaNlE1OuYsNbaXSUhvuWwH/AeU8YncMNVDdFAYIl9LVCtcAD5QE
        We94FlOQojDdQXn54u0ZVO5FMX6EkhRqePNBPDUZ/tzquYgK+gbEu8vkmte+kF4D
        dFX0pYQuJyC2tUI+FMTn+3y8FdT1cDdSlJc1h2twwidxoLj3AGz5Q==
X-ME-Sender: <xms:yvElXSJ4SG24WGntwpZq-QBpuocYYGJTvyrV03fgEaxsujcTvdUypQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrgeeigdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptehnughrvgifucfl
    vghffhgvrhihuceorghnughrvgifsegrjhdrihgurdgruheqnecukfhppedugedrvddrke
    ehrddvvdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgr
    uhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:yvElXfIcN6wa89Aem-4o4cq38mA6Xrmkk5-Hb03MnH6UqQb-FaOebg>
    <xmx:yvElXakMZ5-q5tbO8BrhEtIai9q7FXkPuMj5my6h0KhtqgbRPes0XA>
    <xmx:yvElXVOODzsYKupGZl8u3YtjMfBeq7L7n73PZ5VZAYzn400fbDUcNA>
    <xmx:y_ElXVuCWTBgi4BF9t9TP_KiIZHwFybqQBRRBBabXpVOomzIsQPZeg>
Received: from localhost.localdomain (ppp14-2-85-22.adl-apt-pir-bras31.tpg.internode.on.net [14.2.85.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9E52780064;
        Wed, 10 Jul 2019 10:10:14 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-clk@vger.kernel.org
Cc:     Joel Stanley <joel@jms.id.au>, mturquette@baylibre.com,
        sboyd@kernel.org, ryanchen.aspeed@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH] clk: aspeed: Add SDIO gate
Date:   Wed, 10 Jul 2019 23:40:09 +0930
Message-Id: <20190710141009.20651-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joel Stanley <joel@jms.id.au>

The clock divisor comes with an enable bit (gate). This was not
implemented as we didn't have access to SD hardware when writing the
driver. Now that we can test it, add the gate as a parent to the
divisor.

There is no reason to expose the gate separately, so users will enable
it by turning on the ASPEED_CLK_SDIO divisor.

Signed-off-by: Joel Stanley <joel@jms.id.au>
[aj: Minor style cleanup]
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/clk/clk-aspeed.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
index 42b4df6ba249..898291501f45 100644
--- a/drivers/clk/clk-aspeed.c
+++ b/drivers/clk/clk-aspeed.c
@@ -500,9 +500,14 @@ static int aspeed_clk_probe(struct platform_device *pdev)
 		return PTR_ERR(hw);
 	aspeed_clk_data->hws[ASPEED_CLK_MPLL] =	hw;
 
-	/* SD/SDIO clock divider (TODO: There's a gate too) */
-	hw = clk_hw_register_divider_table(dev, "sdio", "hpll", 0,
-			scu_base + ASPEED_CLK_SELECTION, 12, 3, 0,
+	/* SD/SDIO clock divider and gate */
+	hw = clk_hw_register_gate(dev, "sd_extclk_gate", "hpll", 0,
+				  scu_base + ASPEED_CLK_SELECTION, 15, 0,
+				  &aspeed_clk_lock);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+	hw = clk_hw_register_divider_table(dev, "sd_extclk", "sd_extclk_gate",
+			0, scu_base + ASPEED_CLK_SELECTION, 12, 3, 0,
 			soc_data->div_table,
 			&aspeed_clk_lock);
 	if (IS_ERR(hw))
-- 
2.20.1

