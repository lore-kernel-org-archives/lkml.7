Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C089C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333E120870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OQTNbI0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfDHKbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:31:34 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:60192 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfDHKbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:31:34 -0400
Received: from mailhost1.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 20DE710C1F65;
        Mon,  8 Apr 2019 03:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1554719494; bh=aPSheZBy6ZUWyLsIaODpHxJgiQ1iymoqrTPB5BCAU+M=;
        h=From:To:Cc:Subject:Date:From;
        b=OQTNbI0u4Sg6zS4GmfWL2RT3ikqbSdXL0n/EYX+jLfRPHX0bOdc5NUqQCuLPp75T1
         vXtWcRQ1gx0SKDOMEVG7+RyPxijf7ZZ0zxo8DZX4jUHrIy49RVHYzIzOsH2012gdtv
         NCezm3joRMs1QvbHuuB84WMXn+jPCrUXEqWbraejRuW2ZvEH3CzYRVBSJZ4NU6rtGR
         IkMAC6cDZzVSd6mMxPoupC04ck28Uupw4hPnfbY8AKMsmRDpFTnTRBmwrn/aZrfQbs
         PKUxNPr1H8wb2G5jjhDTY6MYKSbIh5vjLU0l1SFSI1Sp9gFJljfGFQdNIgzfWD+3xl
         5hvyG0k5AkT1A==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost1.synopsys.com (Postfix) with ESMTP id 606A056F5;
        Mon,  8 Apr 2019 03:31:30 -0700 (PDT)
From:   Vitor Soares <vitor.soares@synopsys.com>
To:     linux-kernel@vger.kernel.org
Cc:     Vitor Soares <vitor.soares@synopsys.com>,
        Eugeniy Paltsev <eugeniy.Paltsev@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jose Abreu <jose.abreu@synopsys.com>,
        Luis Oliveira <luis.oliveira@synopsys.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Nelson Costa <nelson.costa@synopsys.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] reset: axs10x: Implement assert and deassert callbacks
Date:   Mon,  8 Apr 2019 12:31:23 +0200
Message-Id: <33ed7b90da8439aecb3544c3ff7dcfb511e03b8e.1554457026.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some custom IP-block connected to ARC AXS10x board need assert and
deassert functions to control reset signal of selected peripherals.

This patch improve AXS10x reset driver by adding assert and deassert
callbacks.

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>

Cc: Eugeniy Paltsev <eugeniy.Paltsev@synopsys.com>
Cc: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Jose Abreu <jose.abreu@synopsys.com>
Cc: Luis Oliveira <lolivei@synopsys.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Nelson Costa <nelson.costa@synopsys.com>
Cc: Pedro Sousa <pedrom.sousa@synopsys.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/reset-axs10x.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/reset-axs10x.c b/drivers/reset/reset-axs10x.c
index a854ef41..12dac8b 100644
--- a/drivers/reset/reset-axs10x.c
+++ b/drivers/reset/reset-axs10x.c
@@ -37,8 +37,36 @@ static int axs10x_reset_reset(struct reset_controller_dev *rcdev,
 	return 0;
 }
 
+static int axs10x_reset_assert(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	struct axs10x_rst *rst = to_axs10x_rst(rcdev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&rst->lock, flags);
+	writel(readl(rst->regs_rst) & ~BIT(id), rst->regs_rst);
+	spin_unlock_irqrestore(&rst->lock, flags);
+
+	return 0;
+}
+
+static int axs10x_reset_deassert(struct reset_controller_dev *rcdev,
+				 unsigned long id)
+{
+	struct axs10x_rst *rst = to_axs10x_rst(rcdev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&rst->lock, flags);
+	writel(readl(rst->regs_rst) | BIT(id), rst->regs_rst);
+	spin_unlock_irqrestore(&rst->lock, flags);
+
+	return 0;
+}
+
 static const struct reset_control_ops axs10x_reset_ops = {
-	.reset	= axs10x_reset_reset,
+	.reset		= axs10x_reset_reset,
+	.assert		= axs10x_reset_assert,
+	.deassert	= axs10x_reset_deassert,
 };
 
 static int axs10x_reset_probe(struct platform_device *pdev)
-- 
2.7.4

