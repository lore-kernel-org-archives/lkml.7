Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87195C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579C021473
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GGrI9Wv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731410AbfEMPle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:41:34 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:41274 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728459AbfEMPle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:41:34 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3EA40C01E9;
        Mon, 13 May 2019 15:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557762098; bh=OxOanAp/g8NXx8Bi7pDKdees/WbGwt+8vXduKshOfkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=GGrI9Wv41G31vKgTVTJlhHO2WUNcWeKrV79YAoUNGB2XgvcTJ5h7ryOEorUGgW+oe
         bZgFK2v1j1wVAKz2033RAeJuvzonqofZvPjsNGLYJvS+EQRNVqIvN9Ha+WMOf4u3TX
         T7VyiWhJmUoTo/ci98rHOqz4Wc9go55Oo2UXDYjP0FRMRl16qhF2J2vtq6sYgPhaf7
         XAoc8E95hFSEzJXCoACqqlUjNwJ6Z+//E1HYSGvbjN0HmMisJAbRVD5PPd/0mjjqQK
         w4hIij79v0YbeeO8abfJC1AhyBCdl38apoV9zl373uQRWBgnZWGsF5YfTOqfvhR11v
         HnGzVwE3n3B0g==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id BB723A009F;
        Mon, 13 May 2019 15:41:32 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id E50DA3F922;
        Mon, 13 May 2019 17:41:31 +0200 (CEST)
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Joao.Pinto@synopsys.com,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: [PATCH 1/2] reset: Add DesignWare IP support to simple reset
Date:   Mon, 13 May 2019 17:41:27 +0200
Message-Id: <1928cabd16a83f1dfdbadc17f302339f00e93ef8.1557759340.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1557759340.git.gustavo.pimentel@synopsys.com>
References: <cover.1557759340.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1557759340.git.gustavo.pimentel@synopsys.com>
References: <cover.1557759340.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reset-simple driver can be now used on DesignWare IPs by
default by selecting the following compatible strings:
 - snps,dw-high-reset for active high resets inputs
 - snps,dw-low-reset for active low resets inputs

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Luis Oliveira <luis.oliveira@synopsys.com>
---
 drivers/reset/Kconfig        | 2 +-
 drivers/reset/reset-simple.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 2c8c23d..2ee69f2 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -117,7 +117,7 @@ config RESET_QCOM_PDC
 
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

