Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B5FC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DACEB20678
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfK0N7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 08:59:53 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39739 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfK0N7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 08:59:40 -0500
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iZxqv-0005PC-Jd; Wed, 27 Nov 2019 14:59:33 +0100
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iZxqv-0008EN-3R; Wed, 27 Nov 2019 14:59:33 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     bgolaszewski@baylibre.com, linus.walleij@linaro.org,
        support.opensource@diasemi.com, lee.jones@linaro.org,
        robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        stwiss.opensource@diasemi.com, Adam.Thomson.Opensource@diasemi.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v2 1/5] gpio: add support to get local gpio number
Date:   Wed, 27 Nov 2019 14:59:28 +0100
Message-Id: <20191127135932.7223-2-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127135932.7223-1-m.felsch@pengutronix.de>
References: <20191127135932.7223-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes consumers needs to know the gpio-chip local gpio number of a
'struct gpio_desc' for further configuration. This is often the case for
mfd devices.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/gpio/gpiolib.c        |  6 ++++++
 include/linux/gpio/consumer.h | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 104ed299d5ea..7709648313fc 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4377,6 +4377,12 @@ int gpiod_count(struct device *dev, const char *con_id)
 }
 EXPORT_SYMBOL_GPL(gpiod_count);
 
+int gpiod_to_offset(struct gpio_desc *desc)
+{
+	return gpio_chip_hwgpio(desc);
+}
+EXPORT_SYMBOL_GPL(gpiod_to_offset);
+
 /**
  * gpiod_get - obtain a GPIO for a given GPIO function
  * @dev:	GPIO consumer, can be NULL for system-global GPIOs
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index b70af921c614..e2178c3bf7fd 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -60,6 +60,9 @@ enum gpiod_flags {
 /* Return the number of GPIOs associated with a device / function */
 int gpiod_count(struct device *dev, const char *con_id);
 
+/* Get the local chip offset from a global desc */
+int gpiod_to_offset(struct gpio_desc *desc);
+
 /* Acquire and dispose GPIOs */
 struct gpio_desc *__must_check gpiod_get(struct device *dev,
 					 const char *con_id,
@@ -189,6 +192,13 @@ static inline int gpiod_count(struct device *dev, const char *con_id)
 	return 0;
 }
 
+static inline int gpiod_to_offset(struct gpio_desc *desc)
+{
+	/* GPIO can never have been requested */
+	WARN_ON(desc);
+	return 0;
+}
+
 static inline struct gpio_desc *__must_check gpiod_get(struct device *dev,
 						       const char *con_id,
 						       enum gpiod_flags flags)
-- 
2.20.1

