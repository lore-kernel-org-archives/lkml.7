Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C9FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8B02171F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfDCOLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:11:49 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:36041 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfDCOLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:11:46 -0400
Received: from localhost (alyon-652-1-60-19.w109-213.abo.wanadoo.fr [109.213.83.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id DD95C100018;
        Wed,  3 Apr 2019 14:11:42 +0000 (UTC)
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
Subject: [PATCH 02/12] misc: atmel_tclib: drop AVR32 support
Date:   Wed,  3 Apr 2019 16:11:10 +0200
Message-Id: <20190403141120.32754-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
References: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AVR32 is gone from the kernel, remove its support from tclib.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/misc/atmel_tclib.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c
index 194f774ab3a1..3af27ce7e514 100644
--- a/drivers/misc/atmel_tclib.c
+++ b/drivers/misc/atmel_tclib.c
@@ -17,18 +17,10 @@
  * share individual timers between different drivers.
  */
 
-#if defined(CONFIG_AVR32)
-/* AVR32 has these divide PBB */
-const u8 atmel_tc_divisors[5] = { 0, 4, 8, 16, 32, };
-EXPORT_SYMBOL(atmel_tc_divisors);
-
-#elif defined(CONFIG_ARCH_AT91)
 /* AT91 has these divide MCK */
 const u8 atmel_tc_divisors[5] = { 2, 8, 32, 128, 0, };
 EXPORT_SYMBOL(atmel_tc_divisors);
 
-#endif
-
 static DEFINE_SPINLOCK(tc_list_lock);
 static LIST_HEAD(tc_list);
 
-- 
2.20.1

