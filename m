Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DBDC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAB420665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iKGNUOra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733291AbfGWPSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:18:44 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:46546 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728591AbfGWPSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:18:41 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CCD4BC016E;
        Tue, 23 Jul 2019 15:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563895121; bh=V99jsKPj9ZINSDZP4sTZylKQQLnXIujiCEwzh1g9t8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iKGNUOrasZCMC9+kZKjpUHHUXke+tPvQieQ55MLYiS6aKqZFB41Q+Tnpgf14UWVqw
         9dU7hF0ahnTkY9HtXJrnGZE7WN4fJI20YL8ljYXompnus8RDds9x21X/fV32oGnFw+
         oSH8cTt7Evbv/A5nWjxh48VO+9bOufsYEwWOiADqBtWT/VWzT3IZbN4fUGENWVdeI9
         xUI3NyB6pKW2NEvhkVo7ia2VF+ES4hKdODspgQ+ctV4iijTmmZtPBEdbGprii2YUXf
         MURuiMTR+T1PDvCYdLJNuSsSnyLqWEMuA+giYKIpBkAsgdfJSJP2xzD6xw7tmqyT9j
         NUn7RhH2+UofQ==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 9B42FA0057;
        Tue, 23 Jul 2019 15:18:39 +0000 (UTC)
From:   Luis Oliveira <Luis.Oliveira@synopsys.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Joao.Pinto@synopsys.com,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: [RESEND V2 2/2] reset: Add DesignWare IP support to simple reset
Date:   Tue, 23 Jul 2019 17:17:28 +0200
Message-Id: <1563895048-30038-3-git-send-email-luis.oliveira@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563895048-30038-1-git-send-email-luis.oliveira@synopsys.com>
References: <1563895048-30038-1-git-send-email-luis.oliveira@synopsys.com>
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
-no changes

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

