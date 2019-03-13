Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F17C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B562177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504616;
	bh=HY7aH7MPgf3lQ97DqJigxboLI6eglJWGgmS5kD+pETM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Y1kiU9rbZ47jDPGmRkr0uXiqz3erQy6a0vwmKuA1JhQDTQ1a72jla4p3jyMi3GhEg
	 gMkhNsqE/1RYMdGMf8r29G6efuZ6IgJnaRwrLa0miaolg5NB83hK8SBE8dVv2fSKIz
	 faKCCOnq5Hn7I8uzktU98kTV5DFIeTfIF/w15SeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfCMTQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:16:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728780AbfCMTQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:16:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24D4E2075C;
        Wed, 13 Mar 2019 19:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504610;
        bh=HY7aH7MPgf3lQ97DqJigxboLI6eglJWGgmS5kD+pETM=;
        h=From:To:Cc:Subject:Date:From;
        b=1JslxoP1Ac/NrHzj2bCaJMXDX8JnlCFuSPE1KHpK1sL52u95KJuXUSa0+fHZlibv3
         G116MSSFcsOwDQGNE+cCHStkpPO7hDOX22I7PQdC2RPNP3Mhh6ddvj25vCH4yaO11N
         gmeujOebvC6ki3nSFQLOYXtHBXPe5ih/ejISaDQo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 01/24] clk: sunxi: A31: Fix wrong AHB gate number
Date:   Wed, 13 Mar 2019 15:16:24 -0400
Message-Id: <20190313191647.160171-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andre Przywara <andre.przywara@arm.com>

[ Upstream commit ee0b27a3a4da0b0ed2318aa092f8856896e9450b ]

According to the manual the gate clock for MMC3 is at bit 11, and NAND1
is controlled by bit 12.

Fix the gate bit definitions in the clock driver.

Fixes: c6e6c96d8fa6 ("clk: sunxi-ng: Add A31/A31s clocks")
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
index 6ea5401e6881..7f1281298651 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
@@ -252,9 +252,9 @@ static SUNXI_CCU_GATE(ahb1_mmc1_clk,	"ahb1-mmc1",	"ahb1",
 static SUNXI_CCU_GATE(ahb1_mmc2_clk,	"ahb1-mmc2",	"ahb1",
 		      0x060, BIT(10), 0);
 static SUNXI_CCU_GATE(ahb1_mmc3_clk,	"ahb1-mmc3",	"ahb1",
-		      0x060, BIT(12), 0);
+		      0x060, BIT(11), 0);
 static SUNXI_CCU_GATE(ahb1_nand1_clk,	"ahb1-nand1",	"ahb1",
-		      0x060, BIT(13), 0);
+		      0x060, BIT(12), 0);
 static SUNXI_CCU_GATE(ahb1_nand0_clk,	"ahb1-nand0",	"ahb1",
 		      0x060, BIT(13), 0);
 static SUNXI_CCU_GATE(ahb1_sdram_clk,	"ahb1-sdram",	"ahb1",
-- 
2.19.1

