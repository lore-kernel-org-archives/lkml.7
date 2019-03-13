Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0461FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD702173C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504233;
	bh=hfXkIWQ8Scgwqcfuq9XYPFASLJ7GafPf9vlreKA0Rzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hxR2O9aJiufllzLYxyITLZjmGvVHu+RtORViw8Fyg+nPNCbB5zsmX3EIBzgWcnLv3
	 QzJwXrnnHvRvYSm9vfBNUiQixvpLP/C61diskuhh6/S57srvqxqOjdfQ6Z4zSKB5Mz
	 eZbiD2z7idAMNkS2a9/kqiTTX/QH937/XBR/rGXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfCMTKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:10:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbfCMTKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:10:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68C542147C;
        Wed, 13 Mar 2019 19:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504229;
        bh=hfXkIWQ8Scgwqcfuq9XYPFASLJ7GafPf9vlreKA0Rzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oZufe1AIsVqEbK8BqRu5ALo2MOlGHtNx9mFUZsgnyMI6RPVJmHuH4oj0Foay1wMtY
         5hKahg1AHqkEtWrstzn4e3vBdb/QXYE+X39c6ehWzgf4BiT3hyBKEiL7B19XfuY2Sa
         NfVFBylqc0p6BSf8OQAEm93idyF3ceja8OWMSW2Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 03/60] clk: sunxi: A31: Fix wrong AHB gate number
Date:   Wed, 13 Mar 2019 15:09:24 -0400
Message-Id: <20190313191021.158171-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191021.158171-1-sashal@kernel.org>
References: <20190313191021.158171-1-sashal@kernel.org>
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
index 3b97f60540ad..609970c0b666 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
@@ -264,9 +264,9 @@ static SUNXI_CCU_GATE(ahb1_mmc1_clk,	"ahb1-mmc1",	"ahb1",
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

