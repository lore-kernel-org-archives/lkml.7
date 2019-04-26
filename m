Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D4DC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF341206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfDZVr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 17:47:59 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:38491 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfDZVrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 17:47:36 -0400
X-Originating-IP: 90.66.53.80
Received: from localhost (lfbn-1-3034-80.w90-66.abo.wanadoo.fr [90.66.53.80])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id A832040004;
        Fri, 26 Apr 2019 21:47:33 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Romain Izard <romain.izard.pro@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 5/9] clocksource/drivers/tcb_clksrc: move Kconfig option
Date:   Fri, 26 Apr 2019 23:47:14 +0200
Message-Id: <20190426214718.13470-6-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426214718.13470-1-alexandre.belloni@bootlin.com>
References: <20190426214718.13470-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the ATMEL_TCB_CLKSRC option to drivers/clocksource and make it silent
if COMPILE_TEST is not selected.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clocksource/Kconfig |  7 +++++++
 drivers/misc/Kconfig        | 14 --------------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 171502a356aa..e38ef4906e30 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -410,6 +410,13 @@ config ATMEL_ST
 	help
 	  Support for the Atmel ST timer.
 
+config ATMEL_TCB_CLKSRC
+	bool "Atmel TC Block timer driver" if COMPILE_TEST
+	depends on HAS_IOMEM
+	select TIMER_OF if OF
+	help
+	  Support for Timer Counter Blocks on Atmel SoCs.
+
 config CLKSRC_EXYNOS_MCT
 	bool "Exynos multi core timer driver" if COMPILE_TEST
 	depends on ARM || ARM64
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 268a01d3d6f3..c84033909395 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -59,20 +59,6 @@ config ATMEL_TCLIB
 	  blocks found on many Atmel processors.  This facilitates using
 	  these blocks by different drivers despite processor differences.
 
-config ATMEL_TCB_CLKSRC
-	bool "TC Block Clocksource"
-	depends on ARCH_AT91
-	select TIMER_OF if OF
-	default y
-	help
-	  Select this to get a high precision clocksource based on a
-	  TC block with a 5+ MHz base clock rate.  Two timer channels
-	  are combined to make a single 32-bit timer.
-
-	  When GENERIC_CLOCKEVENTS is defined, the third timer channel
-	  may be used as a clock event device supporting oneshot mode
-	  (delays of up to two seconds) based on the 32 KiHz clock.
-
 config DUMMY_IRQ
 	tristate "Dummy IRQ handler"
 	default n
-- 
2.20.1

