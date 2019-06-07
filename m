Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB2CC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE61208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfFGJum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 05:50:42 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:50476 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfFGJum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 05:50:42 -0400
Received: from ramsan ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id Mlqg200053XaVaC01lqgyh; Fri, 07 Jun 2019 11:50:40 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZBWB-00040D-W7; Fri, 07 Jun 2019 11:50:40 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZBWB-0002TP-Tp; Fri, 07 Jun 2019 11:50:39 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-renesas-soc@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] irqchip: Enable compile-testing for Renesas drivers
Date:   Fri,  7 Jun 2019 11:50:36 +0200
Message-Id: <20190607095036.9466-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable compile-testing for all Renesas interrupt controller drivers,
except for RENESAS_H8300H_INTC.  The latter relies on a function
(ctrl_bclr()) that is not available on other architectures.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/irqchip/Kconfig | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 2d3b5a27cc988ab6..fe509b88f99a8f10 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -217,17 +217,26 @@ config RDA_INTC
 	select IRQ_DOMAIN
 
 config RENESAS_INTC_IRQPIN
-	bool
+	bool "Renesas INTC External IRQ Pin Support" if COMPILE_TEST
 	select IRQ_DOMAIN
+	help
+	  Enable support for the Renesas Interrupt Controller for external
+	  interrupt pins, as found on SH/R-Mobile and R-Car Gen1 SoCs.
 
 config RENESAS_IRQC
-	bool
+	bool "Renesas R-Mobile APE6 and R-Car IRQC support" if COMPILE_TEST
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
+	help
+	  Enable support for the Renesas Interrupt Controller for external
+	  devices, as found on R-Mobile APE6, R-Car Gen2, and R-Car Gen3 SoCs.
 
 config RENESAS_RZA1_IRQC
-	bool
+	bool "Renesas RZ/A1 IRQC support" if COMPILE_TEST
 	select IRQ_DOMAIN_HIERARCHY
+	help
+	  Enable support for the Renesas RZ/A1 Interrupt Controller, to use up
+	  to 8 external interrupts with configurable sense select.
 
 config ST_IRQCHIP
 	bool
@@ -303,8 +312,11 @@ config RENESAS_H8300H_INTC
 	select IRQ_DOMAIN
 
 config RENESAS_H8S_INTC
-        bool
+	bool "Renesas H8S Interrupt Controller Support" if COMPILE_TEST
 	select IRQ_DOMAIN
+	help
+	  Enable support for the Renesas H8/300 Interrupt Controller, as found
+	  on Renesas H8S SoCs.
 
 config IMX_GPCV2
 	bool
-- 
2.17.1

