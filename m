Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0874EC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 15:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CA9205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 15:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbfD2PMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 11:12:07 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:41368 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbfD2PMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 11:12:07 -0400
Received: from ramsan ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id 6FC52000R3XaVaC06FC56W; Mon, 29 Apr 2019 17:12:05 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hL7wr-0002S7-6d; Mon, 29 Apr 2019 17:12:05 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hL7wr-0005dw-4D; Mon, 29 Apr 2019 17:12:05 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] irqchip: Remove unneeded select IRQ_DOMAIN
Date:   Mon, 29 Apr 2019 17:12:03 +0200
Message-Id: <20190429151203.21650-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRQ_DOMAIN_HIERARCHY selects IRQ_DOMAIN, hence there is no need for
drivers to select both.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/irqchip/Kconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 5438abb1babaf042..c4ed19cb2be778be 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -6,7 +6,6 @@ config IRQCHIP
 
 config ARM_GIC
 	bool
-	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
@@ -33,7 +32,6 @@ config GIC_NON_BANKED
 
 config ARM_GIC_V3
 	bool
-	select IRQ_DOMAIN
 	select GENERIC_IRQ_MULTI_HANDLER
 	select IRQ_DOMAIN_HIERARCHY
 	select PARTITION_PERCPU
@@ -59,7 +57,6 @@ config ARM_GIC_V3_ITS_FSL_MC
 
 config ARM_NVIC
 	bool
-	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_IRQ_CHIP
 
@@ -352,7 +349,6 @@ config STM32_EXTI
 config QCOM_IRQ_COMBINER
 	bool "QCOM IRQ combiner support"
 	depends on ARCH_QCOM && ACPI
-	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
 	help
 	  Say yes here to add support for the IRQ combiner devices embedded
@@ -369,7 +365,6 @@ config IRQ_UNIPHIER_AIDET
 config MESON_IRQ_GPIO
        bool "Meson GPIO Interrupt Multiplexer"
        depends on ARCH_MESON
-       select IRQ_DOMAIN
        select IRQ_DOMAIN_HIERARCHY
        help
          Support Meson SoC Family GPIO Interrupt Multiplexer
@@ -385,7 +380,6 @@ config GOLDFISH_PIC
 config QCOM_PDC
 	bool "QCOM PDC"
 	depends on ARCH_QCOM
-	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
 	help
 	  Power Domain Controller driver to manage and configure wakeup
-- 
2.17.1

