Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31385C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038B82084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfDCOMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:12:13 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:50079 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfDCOMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:12:09 -0400
X-Originating-IP: 109.213.83.19
Received: from localhost (alyon-652-1-60-19.w109-213.abo.wanadoo.fr [109.213.83.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 533402001A;
        Wed,  3 Apr 2019 14:12:05 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 10/12] ARM: configs: at91: unselect PIT
Date:   Wed,  3 Apr 2019 16:11:18 +0200
Message-Id: <20190403141120.32754-11-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
References: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PIT is not required anymore to successfully boot and may actually harm
in case preempt-rt is used because the PIT interrupt is shared.
Disable it so the TCB clocksource is used.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/configs/at91_dt_defconfig | 1 +
 arch/arm/configs/sama5_defconfig   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index e4b1be66b3f5..c8876d0ca41a 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -19,6 +19,7 @@ CONFIG_ARCH_MULTI_V5=y
 CONFIG_ARCH_AT91=y
 CONFIG_SOC_AT91RM9200=y
 CONFIG_SOC_AT91SAM9=y
+# CONFIG_ATMEL_CLOCKSOURCE_PIT is not set
 CONFIG_AEABI=y
 CONFIG_UACCESS_WITH_MEMCPY=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index b0026f73083d..10ebc9481f72 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -20,6 +20,7 @@ CONFIG_ARCH_AT91=y
 CONFIG_SOC_SAMA5D2=y
 CONFIG_SOC_SAMA5D3=y
 CONFIG_SOC_SAMA5D4=y
+# CONFIG_ATMEL_CLOCKSOURCE_PIT is not set
 CONFIG_AEABI=y
 CONFIG_UACCESS_WITH_MEMCPY=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
-- 
2.20.1

