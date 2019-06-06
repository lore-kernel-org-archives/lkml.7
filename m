Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CF1C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD762083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WwN1QI01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbfFFPhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 11:37:10 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:41252 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728871AbfFFPhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:37:07 -0400
Received: from mailhost.synopsys.com (unknown [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4CA32C0B7D;
        Thu,  6 Jun 2019 15:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1559835438; bh=7GB4v+Viwpyg1QsfezOTpg30VWWaMej3TpuKytixbUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WwN1QI01kdmP7Sp0ohR1901FTOp+cG240dugDp+qyx0m2cBfggEJYp5BONvjakE1c
         cZIrDxHKri8t0ms8/IMk+L9AfYGs6Afj/wk1gKeKgaH15bXpWKaYzncxyQsLh2bdCu
         WCJk5NllIxOvc75sJjAo3kpcNR/32lUGOScr8K0Ikf7SS5Waogk3fw41oLXJJvpVkv
         /lAM3s31PvJb51UXNYbD1b2HfVYjtPpGHI3X6QzTobD7hH5SUZmAN0xkjJJNU7ehXv
         Pui0lgxVQl0XY5HGr0qrAnfZ/pWKA/f7nOFZzMNlrOKnF2uzMXik83DJjuC9RMiFJG
         9yVTdDjqGqc+g==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 2C25BA022E;
        Thu,  6 Jun 2019 15:37:06 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 1803F3F1FF;
        Thu,  6 Jun 2019 17:37:06 +0200 (CEST)
From:   Luis Oliveira <Luis.Oliveira@synopsys.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Joao.Pinto@synopsys.com,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: [PATCH V2 1/2] reset: Add DesignWare IP support to simple reset
Date:   Thu,  6 Jun 2019 17:36:27 +0200
Message-Id: <1559835388-2578-2-git-send-email-luis.oliveira@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559835388-2578-1-git-send-email-luis.oliveira@synopsys.com>
References: <1559835388-2578-1-git-send-email-luis.oliveira@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

The reset-simple driver can be now used on DesignWare IPs by
default by selecting the following compatible strings:
 - snps,dw-high-reset for active high resets inputs
 - snps,dw-low-reset for active low resets inputs

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Luis Oliveira <luis.oliveira@synopsys.com>
---
Changelog
- no changes

 drivers/reset/Kconfig        | 2 +-
 drivers/reset/reset-simple.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index d506d32..ac85fd2 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -118,7 +118,7 @@ config RESET_QCOM_PDC
 
 config RESET_SIMPLE
 	bool "Simple Reset Controller Driver" if COMPILE_TEST
-	default ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED
+	default ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED || ARC
 	help
 	  This enables a simple reset controller driver for reset lines that
 	  that can be asserted and deasserted by toggling bits in a contiguous,
diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
index 77fbba3..79e73be 100644
--- a/drivers/reset/reset-simple.c
+++ b/drivers/reset/reset-simple.c
@@ -129,6 +129,9 @@ static const struct of_device_id reset_simple_dt_ids[] = {
 		.data = &reset_simple_active_low },
 	{ .compatible = "aspeed,ast2400-lpc-reset" },
 	{ .compatible = "aspeed,ast2500-lpc-reset" },
+	{ .compatible = "snps,dw-high-reset" },
+	{ .compatible = "snps,dw-low-reset",
+		.data = &reset_simple_active_low },
 	{ /* sentinel */ },
 };
 
-- 
2.7.4

