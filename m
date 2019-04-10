Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2834C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E6D2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="QY2bLy8P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfDJIkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:40:18 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:33899 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726556AbfDJIkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:40:18 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3A7lhK0019574;
        Wed, 10 Apr 2019 10:02:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=XxarnC0+KQFSSuj/i1ROj5fK9wLcaH1nAWonzByvRD8=;
 b=QY2bLy8PqWFlWKeR9M3gBK9teVe89GzKOC1OWTTS+2Q4f83Ss9EjkoVby4KGZItQEtcQ
 8JC5wf5JHwHKlkiLHq/b7KyPLgtVkHc94EjB+CI4yW74uX1TSCv5i8TuXh0CZYYQA/cT
 Hx/FJcHzs/sgoD30FafmZIQiv/8kyiqVZzjESwThdI4fbpOLMeKiFIOLnvebrjpbJ63U
 12tjNBsfIrMKqUhiOhhf4PhOykxC20pWpkIlSoF9mGyTQy5MruadSw7PH29vaXj6ED45
 q5nrFpmhEs653mUHP2utJ0CAnXrd3/PW0HAPprfQgvAufPG0EtvGSifyyNN8dTYWg9tk YQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rprkdnajd-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 10 Apr 2019 10:02:19 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 341A0174;
        Wed, 10 Apr 2019 08:01:08 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EBF4F1115;
        Wed, 10 Apr 2019 08:01:07 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 10 Apr
 2019 10:01:07 +0200
Received: from localhost (10.201.23.31) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 10 Apr 2019 10:01:04
 +0200
From:   Erwan Le Ray <erwan.leray@st.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        "Kevin Hilman" <khilman@baylibre.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Clement Peron <clement.peron@devialet.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Stefan Agner <stefan@agner.ch>,
        Biju Das <biju.das@bp.renesas.com>,
        "Gerald Baeza" <gerald.baeza@st.com>,
        Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Erwan Le Ray <erwan.leray@st.com>,
        "Clement Peron" <peron.clem@gmail.com>,
        Bich Hemon <bich.hemon@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH] ARM: debug: stm32: add UART early console configuration
Date:   Wed, 10 Apr 2019 10:00:39 +0200
Message-ID: <1554883239-12051-1-git-send-email-erwan.leray@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.31]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- This patch allows to configure UART instance for early console by setting
physical and virtual base addresses.
- This patch adds UART early console support for stm32h7 and stm32mp157c.

Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 6d6e033..4ea3e17 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1201,23 +1201,49 @@ choice
 
 	config STM32F4_DEBUG_UART
 		bool "Use STM32F4 UART for low-level debug"
-		depends on ARCH_STM32
+		depends on MACH_STM32F429 || MACH_STM32F469
 		select DEBUG_STM32_UART
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on STM32F4 based platforms, which default UART is wired on
-		  USART1.
+		  USART1, but another UART instance can be selected by modifying
+		  CONFIG_DEBUG_UART_PHYS.
 
 		  If unsure, say N.
 
 	config STM32F7_DEBUG_UART
 		bool "Use STM32F7 UART for low-level debug"
-		depends on ARCH_STM32
+		depends on MACH_STM32F746 || MACH_STM32F769
 		select DEBUG_STM32_UART
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on STM32F7 based platforms, which default UART is wired on
-		  USART1.
+		  USART1, but another UART instance can be selected by modifying
+		  CONFIG_DEBUG_UART_PHYS.
+
+		  If unsure, say N.
+
+	config STM32H7_DEBUG_UART
+		bool "Use STM32H7 UART for low-level debug"
+		depends on MACH_STM32H743
+		select DEBUG_STM32_UART
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on STM32H7 based platforms, which default UART is wired on
+		  USART1, but another UART instance can be selected by modifying
+		  CONFIG_DEBUG_UART_PHYS.
+
+		  If unsure, say N.
+
+	config STM32MP1_DEBUG_UART
+		bool "Use STM32MP1 UART for low-level debug"
+		depends on MACH_STM32MP157
+		select DEBUG_STM32_UART
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on STM32MP1 based platforms, wich default UART is wired on
+		  UART4, but another UART instance can be selected by modifying
+		  CONFIG_DEBUG_UART_PHYS and CONFIG_DEBUG_UART_VIRT.
 
 		  If unsure, say N.
 
@@ -1622,6 +1648,9 @@ config DEBUG_UART_PHYS
 	default 0x3e000000 if DEBUG_BCM_KONA_UART
 	default 0x3f201000 if DEBUG_BCM2836
 	default 0x4000e400 if DEBUG_LL_UART_EFM32
+	default 0x40010000 if STM32MP1_DEBUG_UART
+	default 0x40011000 if STM32F4_DEBUG_UART || STM32F7_DEBUG_UART || \
+				STM32H7_DEBUG_UART
 	default 0x40028000 if DEBUG_AT91_SAMV7_USART1
 	default 0x40081000 if DEBUG_LPC18XX_UART0
 	default 0x40090000 if DEBUG_LPC32XX
@@ -1716,7 +1745,7 @@ config DEBUG_UART_PHYS
 		DEBUG_S3C64XX_UART || \
 		DEBUG_BCM63XX_UART || DEBUG_ASM9260_UART || \
 		DEBUG_SIRFSOC_UART || DEBUG_DIGICOLOR_UA0 || \
-		DEBUG_AT91_UART
+		DEBUG_AT91_UART || DEBUG_STM32_UART
 
 config DEBUG_UART_VIRT
 	hex "Virtual base address of debug UART"
@@ -1784,6 +1813,7 @@ config DEBUG_UART_VIRT
 	default 0xfd012000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_MV78XX0
 	default 0xfd883000 if DEBUG_ALPINE_UART0
 	default 0xfde12000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_DOVE
+	default 0xfe010000 if STM32MP1_DEBUG_UART
 	default 0xfe012000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_ORION5X
 	default 0xfe017000 if DEBUG_MMP_UART2
 	default 0xfe018000 if DEBUG_MMP_UART3
@@ -1832,7 +1862,7 @@ config DEBUG_UART_VIRT
 		DEBUG_S3C64XX_UART || \
 		DEBUG_BCM63XX_UART || DEBUG_ASM9260_UART || \
 		DEBUG_SIRFSOC_UART || DEBUG_DIGICOLOR_UA0 || \
-		DEBUG_AT91_UART
+		DEBUG_AT91_UART || DEBUG_STM32_UART
 
 config DEBUG_UART_8250_SHIFT
 	int "Register offset shift for the 8250 debug UART"
diff --git a/arch/arm/include/debug/stm32.S b/arch/arm/include/debug/stm32.S
index 1abb32f..6446e46 100644
--- a/arch/arm/include/debug/stm32.S
+++ b/arch/arm/include/debug/stm32.S
@@ -4,14 +4,13 @@
  * Author:   Gerald Baeza <gerald.baeza@st.com> for STMicroelectronics.
  */
 
-#define STM32_UART_BASE			0x40011000	/* USART1 */
-
 #ifdef CONFIG_STM32F4_DEBUG_UART
 #define STM32_USART_SR_OFF		0x00
 #define STM32_USART_TDR_OFF		0x04
 #endif
 
-#ifdef CONFIG_STM32F7_DEBUG_UART
+#if defined(CONFIG_STM32F7_DEBUG_UART) || (CONFIG_STM32H7_DEBUG_UART) || \
+	defined(CONFIG_STM32MP1_DEBUG_UART)
 #define STM32_USART_SR_OFF		0x1C
 #define STM32_USART_TDR_OFF		0x28
 #endif
@@ -20,8 +19,8 @@
 #define STM32_USART_TXE			(1 << 7)	/* Tx data reg empty */
 
 .macro	addruart, rp, rv, tmp
-	ldr	\rp,      =STM32_UART_BASE	@ physical base
-	ldr	\rv,      =STM32_UART_BASE      @ virt base /* NoMMU */
+	ldr	\rp, =CONFIG_DEBUG_UART_PHYS @ physical base
+	ldr	\rv, =CONFIG_DEBUG_UART_VIRT @ virt base
 .endm
 
 .macro  senduart,rd,rx
-- 
1.9.1

