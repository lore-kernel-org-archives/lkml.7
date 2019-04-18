Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D7CC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D29B205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="teiV11uL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388111AbfDRGtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:49:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37997 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfDRGtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:49:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so731313pgl.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 23:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=AXMa+Azt/dOU4Y6GZ4BwUwm/ktKuKR/i75lOLSQoX8k=;
        b=teiV11uL/KeES7DuBT7aLS/RyTdCVaK6SO6NFnjZIm7ovhNyOAYsdBhlYittOIbE5w
         yCHafa/ZIDeGT4zvNotDbEK9E44RiRFBVUCeEtktUS9hCJHKm9Vye46j59x0xcuORjgB
         ZmmjwkqiEN2CqtA20DPmoBaMIUzZT/2J6TPmGhBogxBUloDOE/zC+r8pJ/e0+fkPM2X7
         1PerNowdlSiQM/DbahKane9PiXjnU4p3IXnGmjkGILWOs5CyD1YGrxdN+U/FdTHoj1s/
         snQT/V7ee5s4jjw2cR0tvX4huCG04Qir8CZd2diDuqlJOFT+R5C1AaB3eyZKtdEcifJ3
         CEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=AXMa+Azt/dOU4Y6GZ4BwUwm/ktKuKR/i75lOLSQoX8k=;
        b=oTjUoL7bBpm/eDcrKk84SAtoDVM6iHJBtH93yf//UiWEzFljZbuGlecF95pddvHiwb
         BGWmLOEtKI3QsGMgvZeanOX3ICsyxUyTHFJflok2n1ENnVhfB6AQx9ldNc9P34uREcDt
         1wIxJ8oNpOY2F30a9A0nhx0FCgP6nX662pdopok6bNzXsWG54MS/nzyF5bCwF599zdGM
         ae6J9QvKn7J1VX7jcKHTvrALr96aQPAzt4glqEDkNQ6lbNWnEcCSSl9gpvFytZr6ttaV
         SXEW8JxQgEtPy/lCyoLrNxAgJzjMLmG2lCSCsVuW5CJ9UqXyl1EQhgLZG8/wUwH6T0r1
         CXzw==
X-Gm-Message-State: APjAAAWCcbIf+w/YQqaOZ5CFqE8HUxydyZfVSXlJxqV7WcDJz76FNSwR
        3PdWaPIJmF+4/WqMMVQlbW2ZXmoYoxIsxA==
X-Google-Smtp-Source: APXvYqyjzE2ONvgWByoMLirKG9TSevUqnfBvbroSB6sw0OLVz0brCZRlAB5N9wDTYTg2ZhyiVL4Iqw==
X-Received: by 2002:a63:e051:: with SMTP id n17mr87103884pgj.19.1555570143328;
        Wed, 17 Apr 2019 23:49:03 -0700 (PDT)
Received: from compute1 ([123.51.210.126])
        by smtp.gmail.com with ESMTPSA id c62sm2191032pfg.33.2019.04.17.23.49.01
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Apr 2019 23:49:02 -0700 (PDT)
Date:   Thu, 18 Apr 2019 14:48:55 +0800
From:   Jerry Lin <wahahab11@gmail.com>
To:     Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>, jon.nettleton@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Jerry Lin <wahahab11@gmail.com>
Subject: [PATCH] staging: olpc_dcon: Convert all uses of old GPIO API to new
 descriptor API
Message-ID: <20190418064855.GA27108@compute1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit eliminate all uses of legacy integer base GPIO API in
olpc_dcon_xo_1_5.c and replace them with new descriptor GPIO API like
those in olpc_dcon_xo_1.c.

Also pull some common code with olpc_dcon_xo_1.c to olpc_dcon.h for code
sharing.

Signed-off-by: Jerry Lin <wahahab11@gmail.com>
---
 drivers/staging/olpc_dcon/olpc_dcon.h        |  5 +++
 drivers/staging/olpc_dcon/olpc_dcon_xo_1.c   |  7 +---
 drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c | 56 ++++++++++++++++++++++++++--
 3 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/olpc_dcon/olpc_dcon.h b/drivers/staging/olpc_dcon/olpc_dcon.h
index c987aaf..22d976a 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon.h
+++ b/drivers/staging/olpc_dcon/olpc_dcon.h
@@ -97,6 +97,11 @@ struct dcon_platform_data {
 	int (*read_status)(u8 *status);
 };
 
+struct dcon_gpio {
+	const char *name;
+	unsigned long flags;
+};
+
 #include <linux/interrupt.h>
 
 irqreturn_t dcon_interrupt(int irq, void *id);
diff --git a/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c b/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c
index a542864..02c0598 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c
+++ b/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c
@@ -26,11 +26,6 @@ enum dcon_gpios {
 	OLPC_DCON_BLANK,
 };
 
-struct dcon_gpio {
-	const char *name;
-	unsigned long flags;
-};
-
 static const struct dcon_gpio gpios_asis[] = {
 	[OLPC_DCON_STAT0] = { .name = "dcon_stat0", .flags = GPIOD_ASIS },
 	[OLPC_DCON_STAT1] = { .name = "dcon_stat1", .flags = GPIOD_ASIS },
@@ -39,7 +34,7 @@ static const struct dcon_gpio gpios_asis[] = {
 	[OLPC_DCON_BLANK] = { .name = "dcon_blank", .flags = GPIOD_ASIS },
 };
 
-struct gpio_desc *gpios[5];
+static struct gpio_desc *gpios[5];
 
 static int dcon_init_xo_1(struct dcon_priv *dcon)
 {
diff --git a/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c b/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c
index 838daa2..52cdcd2 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c
+++ b/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c
@@ -7,7 +7,9 @@
 
 #include <linux/acpi.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/i2c.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio/machine.h>
 #include <asm/olpc.h>
 
 /* TODO: this eventually belongs in linux/vx855.h */
@@ -38,6 +40,33 @@
 
 #define PREFIX "OLPC DCON:"
 
+enum dcon_gpios {
+	OLPC_DCON_STAT0,
+	OLPC_DCON_STAT1,
+	OLPC_DCON_LOAD,
+};
+
+struct gpiod_lookup_table gpios_table = {
+	.dev_id = NULL,
+	.table = {
+		GPIO_LOOKUP("VX855 South Bridge", VX855_GPIO(1), "dcon_load",
+			    GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("VX855 South Bridge", VX855_GPI(10), "dcon_stat0",
+			    GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("VX855 South Bridge", VX855_GPI(11), "dcon_stat1",
+			    GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
+static const struct dcon_gpio gpios_asis[] = {
+	[OLPC_DCON_STAT0] = { .name = "dcon_stat0", .flags = GPIOD_ASIS },
+	[OLPC_DCON_STAT1] = { .name = "dcon_stat1", .flags = GPIOD_ASIS },
+	[OLPC_DCON_LOAD] = { .name = "dcon_load", .flags = GPIOD_ASIS },
+};
+
+static struct gpio_desc *gpios[3];
+
 static void dcon_clear_irq(void)
 {
 	/* irq status will appear in PMIO_Rx50[6] (RW1C) on gpio12 */
@@ -57,6 +86,25 @@ static int dcon_was_irq(void)
 static int dcon_init_xo_1_5(struct dcon_priv *dcon)
 {
 	unsigned int irq;
+	const struct dcon_gpio *pin = &gpios_asis[0];
+	int i;
+	int ret;
+
+	/* Add GPIO look up table */
+	gpios_table.dev_id = dev_name(&dcon->client->dev);
+	gpiod_add_lookup_table(&gpios_table);
+
+	/* Get GPIO descriptor */
+	for (i = 0; i < ARRAY_SIZE(gpios_asis); i++) {
+		gpios[i] = devm_gpiod_get(&dcon->client->dev, pin[i].name,
+					  pin[i].flags);
+		if (IS_ERR(gpios[i])) {
+			ret = PTR_ERR(gpios[i]);
+			pr_err("failed to request %s GPIO: %d\n", pin[i].name,
+			       ret);
+			return ret;
+		}
+	}
 
 	dcon_clear_irq();
 
@@ -131,7 +179,7 @@ static void dcon_wiggle_xo_1_5(void)
 
 static void dcon_set_dconload_xo_1_5(int val)
 {
-	gpio_set_value(VX855_GPIO(1), val);
+	gpiod_set_value(gpios[OLPC_DCON_LOAD], val);
 }
 
 static int dcon_read_status_xo_1_5(u8 *status)
@@ -140,8 +188,8 @@ static int dcon_read_status_xo_1_5(u8 *status)
 		return -1;
 
 	/* i believe this is the same as "inb(0x44b) & 3" */
-	*status = gpio_get_value(VX855_GPI(10));
-	*status |= gpio_get_value(VX855_GPI(11)) << 1;
+	*status = gpiod_get_value(gpios[OLPC_DCON_STAT0]);
+	*status |= gpiod_get_value(gpios[OLPC_DCON_STAT1]) << 1;
 
 	dcon_clear_irq();
 
-- 
2.7.4

