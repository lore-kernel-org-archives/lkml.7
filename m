Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD831C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DEF2218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255335;
	bh=zRmMNFiElGGpUxreAY3O4rXY33aAI0FbjElgeB6hCXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1ClnRlxPyBMiCPtvDyRvg6y4YUaEiWfgEucfLRMotRbuKbI2voP7kQPE84AT3ojAX
	 CujQtSG9+kRIRQkQQy08zaI1M44dOrj8atja1HA/qeILzMADNC0NxKVJEG2y7kVwcQ
	 ZpLTRCBh33L+1Xv1DW7wlbxtFybSpECWxr5CewkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731908AbfCVLsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:48:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732352AbfCVLst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:48:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99B242075E;
        Fri, 22 Mar 2019 11:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255329;
        bh=zRmMNFiElGGpUxreAY3O4rXY33aAI0FbjElgeB6hCXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iFU3iJy6xrL6v97tPO5KSoCoUqTCTz4S4/2B42UYcbeN/EmDzSi5X4Fz/8EH6Y0wi
         Ah8YM8FIJoi4pjAFJFVtvrxhH8ArxQp663uW8W5TaLwZfFjc5YF0Z2SWAhqsju3ocz
         q+NOCXiZqpEfaInumfDZ+m8PP+3uFgZOpW+HbAsM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 038/183] clk: sunxi: A31: Fix wrong AHB gate number
Date:   Fri, 22 Mar 2019 12:14:26 +0100
Message-Id: <20190322111244.481056716@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 40d5f74cb2ac..d93b4815e65c 100644
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



