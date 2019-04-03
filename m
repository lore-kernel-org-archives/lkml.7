Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3495C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB752084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfDCOLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:11:50 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:40755 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfDCOLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:11:49 -0400
X-Originating-IP: 109.213.83.19
Received: from localhost (alyon-652-1-60-19.w109-213.abo.wanadoo.fr [109.213.83.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id DBC2624001D;
        Wed,  3 Apr 2019 14:11:45 +0000 (UTC)
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
Subject: [PATCH 03/12] misc: atmel_tclib: move definitions to header file
Date:   Wed,  3 Apr 2019 16:11:11 +0200
Message-Id: <20190403141120.32754-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
References: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move atmel_tc_divisors and atmel_tcb_dt_ids definitions to the header file
so they can be used without using tclib.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/misc/atmel_tclib.c   | 24 ------------------------
 include/soc/at91/atmel_tcb.h | 21 ++++++++++++++++++++-
 2 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c
index 3af27ce7e514..c79190525862 100644
--- a/drivers/misc/atmel_tclib.c
+++ b/drivers/misc/atmel_tclib.c
@@ -17,10 +17,6 @@
  * share individual timers between different drivers.
  */
 
-/* AT91 has these divide MCK */
-const u8 atmel_tc_divisors[5] = { 2, 8, 32, 128, 0, };
-EXPORT_SYMBOL(atmel_tc_divisors);
-
 static DEFINE_SPINLOCK(tc_list_lock);
 static LIST_HEAD(tc_list);
 
@@ -72,26 +68,6 @@ void atmel_tc_free(struct atmel_tc *tc)
 EXPORT_SYMBOL_GPL(atmel_tc_free);
 
 #if defined(CONFIG_OF)
-static struct atmel_tcb_config tcb_rm9200_config = {
-	.counter_width = 16,
-};
-
-static struct atmel_tcb_config tcb_sam9x5_config = {
-	.counter_width = 32,
-};
-
-static const struct of_device_id atmel_tcb_dt_ids[] = {
-	{
-		.compatible = "atmel,at91rm9200-tcb",
-		.data = &tcb_rm9200_config,
-	}, {
-		.compatible = "atmel,at91sam9x5-tcb",
-		.data = &tcb_sam9x5_config,
-	}, {
-		/* sentinel */
-	}
-};
-
 MODULE_DEVICE_TABLE(of, atmel_tcb_dt_ids);
 #endif
 
diff --git a/include/soc/at91/atmel_tcb.h b/include/soc/at91/atmel_tcb.h
index c3c7200ce151..cb0c5f53cd46 100644
--- a/include/soc/at91/atmel_tcb.h
+++ b/include/soc/at91/atmel_tcb.h
@@ -76,8 +76,27 @@ extern struct atmel_tc *atmel_tc_alloc(unsigned block);
 extern void atmel_tc_free(struct atmel_tc *tc);
 
 /* platform-specific ATMEL_TC_TIMER_CLOCKx divisors (0 means 32KiHz) */
-extern const u8 atmel_tc_divisors[5];
+static const u8 atmel_tc_divisors[] = { 2, 8, 32, 128, 0, };
 
+static const struct atmel_tcb_config tcb_rm9200_config = {
+	.counter_width = 16,
+};
+
+static const struct atmel_tcb_config tcb_sam9x5_config = {
+	.counter_width = 32,
+};
+
+static const struct of_device_id atmel_tcb_dt_ids[] = {
+	{
+		.compatible = "atmel,at91rm9200-tcb",
+		.data = &tcb_rm9200_config,
+	}, {
+		.compatible = "atmel,at91sam9x5-tcb",
+		.data = &tcb_sam9x5_config,
+	}, {
+		/* sentinel */
+	}
+};
 
 /*
  * Two registers have block-wide controls.  These are: configuring the three
-- 
2.20.1

