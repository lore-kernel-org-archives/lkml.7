Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C26C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66BEC208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfJJUtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 16:49:36 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:42893 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJUtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:49:35 -0400
X-Originating-IP: 86.202.229.42
Received: from localhost (lfbn-lyo-1-146-42.w86-202.abo.wanadoo.fr [86.202.229.42])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 26EEBE0003;
        Thu, 10 Oct 2019 20:49:29 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Vladimir Zapolskiy <vz@mleia.com>
Cc:     Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] ARM: lpc32xx: debug: add low-level debug support on hsuart
Date:   Thu, 10 Oct 2019 22:49:27 +0200
Message-Id: <20191010204927.15749-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lpc32xx has UARTs that are not 8250 compatible. Add support for low
level debugging on those high speed UARTs.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/Kconfig.debug                  | 18 +++++++++++++++---
 arch/arm/include/debug/lpc32xx_hsuart.S | 24 ++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/include/debug/lpc32xx_hsuart.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 8bcbd0cd739b..b95ce5d97946 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -523,7 +523,16 @@ choice
 		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
-		  on NXP LPC32xx based platforms.
+		  on NXP LPC32xx based platforms using an INS16Cx50 compatible
+		  UART.
+
+	config DEBUG_LPC32XX_HSUART
+		bool "Kernel low-level debugging messages via NXP LPC32xx High Speed  UART"
+		depends on ARCH_LPC32XX
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on NXP LPC32xx based platforms using an high speed (14-clock)
+		  UART.
 
 	config DEBUG_MESON_UARTAO
 		bool "Kernel low-level debugging via Meson6 UARTAO"
@@ -1540,6 +1549,7 @@ config DEBUG_LL_INCLUDE
 				 DEBUG_IMX6SX_UART || \
 				 DEBUG_IMX6UL_UART || \
 				 DEBUG_IMX7D_UART
+	default "debug/lpc32xx_hsuart.S" if DEBUG_LPC32XX_HSUART
 	default "debug/msm.S" if DEBUG_QCOM_UARTDM
 	default "debug/omap2plus.S" if DEBUG_OMAP2PLUS_UART
 	default "debug/renesas-scif.S" if DEBUG_R7S72100_SCIF2
@@ -1619,6 +1629,7 @@ config DEBUG_UART_PHYS
 	default 0x3e000000 if DEBUG_BCM_KONA_UART
 	default 0x3f201000 if DEBUG_BCM2836
 	default 0x4000e400 if DEBUG_LL_UART_EFM32
+	default 0x40014000 if DEBUG_LPC32XX_HSUART
 	default 0x40028000 if DEBUG_AT91_SAMV7_USART1
 	default 0x40081000 if DEBUG_LPC18XX_UART0
 	default 0x40090000 if DEBUG_LPC32XX
@@ -1713,7 +1724,7 @@ config DEBUG_UART_PHYS
 		DEBUG_S3C64XX_UART || \
 		DEBUG_BCM63XX_UART || DEBUG_ASM9260_UART || \
 		DEBUG_SIRFSOC_UART || DEBUG_DIGICOLOR_UA0 || \
-		DEBUG_AT91_UART
+		DEBUG_AT91_UART || DEBUG_LPC32XX_HSUART
 
 config DEBUG_UART_VIRT
 	hex "Virtual base address of debug UART"
@@ -1738,6 +1749,7 @@ config DEBUG_UART_VIRT
 	default 0xf1c28400 if DEBUG_SUNXI_UART1
 	default 0xf1f02800 if DEBUG_SUNXI_R_UART
 	default 0xf31004c0 if DEBUG_MESON_UARTAO
+	default 0xf4014000 if DEBUG_LPC32XX_HSUART
 	default 0xf4090000 if DEBUG_LPC32XX
 	default 0xf4200000 if DEBUG_GEMINI
 	default 0xf6200000 if DEBUG_PXA_UART1
@@ -1823,7 +1835,7 @@ config DEBUG_UART_VIRT
 		DEBUG_S3C64XX_UART || \
 		DEBUG_BCM63XX_UART || DEBUG_ASM9260_UART || \
 		DEBUG_SIRFSOC_UART || DEBUG_DIGICOLOR_UA0 || \
-		DEBUG_AT91_UART
+		DEBUG_AT91_UART || DEBUG_LPC32XX_HSUART
 
 config DEBUG_UART_8250_SHIFT
 	int "Register offset shift for the 8250 debug UART"
diff --git a/arch/arm/include/debug/lpc32xx_hsuart.S b/arch/arm/include/debug/lpc32xx_hsuart.S
new file mode 100644
index 000000000000..7f54bc2cc250
--- /dev/null
+++ b/arch/arm/include/debug/lpc32xx_hsuart.S
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define LPC_HSU_TX		(0x0)
+#define LPC_HSU_LEVEL		(0x4)
+#define LPC_HSU_LEVEL_TX	0xFF00
+
+	.macro	addruart, rp, rv, tmp
+	ldr	\rp, =CONFIG_DEBUG_UART_PHYS		@ System peripherals (phys address)
+	ldr	\rv, =CONFIG_DEBUG_UART_VIRT		@ System peripherals (virt address)
+	.endm
+
+	.macro	senduart,rd,rx
+	str	\rd, [\rx, #(LPC_HSU_TX)]
+	.endm
+
+	.macro	waituart,rd,rx
+	.endm
+
+	.macro	busyuart,rd,rx
+1001:	ldr	\rd, [\rx, #(LPC_HSU_LEVEL)]
+	ands	\rd, \rd, LPC_HSU_LEVEL_TX
+	bne	1001b
+	.endm
+
-- 
2.21.0

