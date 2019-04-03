Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65E3C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18712084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfDCOMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:12:02 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:39111 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfDCOL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:11:57 -0400
Received: from localhost (alyon-652-1-60-19.w109-213.abo.wanadoo.fr [109.213.83.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 1212A100018;
        Wed,  3 Apr 2019 14:11:53 +0000 (UTC)
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
Subject: [PATCH 06/12] ARM: at91: Implement clocksource selection
Date:   Wed,  3 Apr 2019 16:11:14 +0200
Message-Id: <20190403141120.32754-7-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
References: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow selecting and unselecting the PIT clocksource driver so it doesn't
have to be compiled when unused.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/mach-at91/Kconfig | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 903f23c309df..da1d97a06c53 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -107,6 +107,29 @@ config SOC_AT91SAM9
 	    AT91SAM9X35
 	    AT91SAM9XE
 
+comment "Clocksource driver selection"
+
+config ATMEL_CLOCKSOURCE_PIT
+	bool "Periodic Interval Timer (PIT) support"
+	depends on SOC_AT91SAM9 || SOC_SAMA5
+	default SOC_AT91SAM9 || SOC_SAMA5
+	select ATMEL_PIT
+	help
+	  Select this to get a clocksource based on the Atmel Periodic Interval
+	  Timer. It has a relatively low resolution and the TC Block clocksource
+	  should be preferred.
+
+config ATMEL_CLOCKSOURCE_TCB
+	bool "Timer Counter Blocks (TCB) support"
+	default SOC_AT91RM9200 || SOC_AT91SAM9 || SOC_SAMA5
+	select ATMEL_TCB_CLKSRC
+	help
+	  Select this to get a high precision clocksource based on a
+	  TC block with a 5+ MHz base clock rate.
+	  On platforms with 16-bit counters, two timer channels are combined
+	  to make a single 32-bit timer.
+	  It can also be used as a clock event device supporting oneshot mode.
+
 config HAVE_AT91_UTMI
 	bool
 
-- 
2.20.1

