Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340C3C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B8F217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfDKOMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 10:12:20 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:41101 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfDKOMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 10:12:20 -0400
X-Originating-IP: 109.213.33.177
Received: from localhost (alyon-652-1-42-177.w109-213.abo.wanadoo.fr [109.213.33.177])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id A313C1BF219;
        Thu, 11 Apr 2019 14:12:17 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] ARM: lpc32xx: stop overwriting TEST_CLK_SEL
Date:   Thu, 11 Apr 2019 16:12:09 +0200
Message-Id: <20190411141209.3106-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the UDA1380 is described in some lpc3250 device trees, there is
currently no real user of that codec. Anyway, if the codec needs a clock,
it should take it explicitly.

lpc3250_machine_init is called for all the lpc32xx machines and some are
using test1_clk (for example to strobe an HW watchdog). Overwriting
TEST_CLK_SEL prevents booting those platforms.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/mach-lpc32xx/phy3250.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index fdbb1409c32b..1db8508493a5 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -128,11 +128,6 @@ static void __init lpc3250_machine_init(void)
 {
 	lpc32xx_serial_init();
 
-	/* Test clock needed for UDA1380 initial init */
-	__raw_writel(LPC32XX_CLKPWR_TESTCLK2_SEL_MOSC |
-		LPC32XX_CLKPWR_TESTCLK_TESTCLK2_EN,
-		LPC32XX_CLKPWR_TEST_CLK_SEL);
-
 	of_platform_default_populate(NULL, lpc32xx_auxdata_lookup, NULL);
 }
 
-- 
2.20.1

