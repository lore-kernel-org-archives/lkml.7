Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3A6C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3917A21721
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfFNOL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:11:29 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:38485 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbfFNOL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:11:29 -0400
X-Originating-IP: 90.88.23.150
Received: from dell-desktop.home (aaubervilliers-681-1-81-150.w90-88.abo.wanadoo.fr [90.88.23.150])
        (Authenticated sender: mylene.josserand@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id C3AD04001E;
        Fri, 14 Jun 2019 14:11:17 +0000 (UTC)
From:   =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mylene.josserand@bootlin.com,
        thomas.petazzoni@bootlin.com
Subject: [PATCH v1] tty: serial: max310x: Add optional reset gpio
Date:   Fri, 14 Jun 2019 16:11:12 +0200
Message-Id: <20190614141112.29962-1-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the possibility to use a gpio as reset.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 Documentation/devicetree/bindings/serial/maxim,max310x.txt | 1 +
 drivers/tty/serial/max310x.c                               | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/maxim,max310x.txt b/Documentation/devicetree/bindings/serial/maxim,max310x.txt
index 79e10a05a96a..1d7d8a0b4260 100644
--- a/Documentation/devicetree/bindings/serial/maxim,max310x.txt
+++ b/Documentation/devicetree/bindings/serial/maxim,max310x.txt
@@ -15,6 +15,7 @@ Required properties:
   "osc" if an external clock source is used.
 
 Optional properties:
+- reset-gpios: Gpio to use for reset.
 - gpio-controller: Marks the device node as a GPIO controller.
 - #gpio-cells: Should be two. The first cell is the GPIO number and
   the second cell is used to specify the GPIO polarity:
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index e5aebbf5f302..d056fa2eed1b 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/gpio/driver.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -1413,12 +1414,18 @@ static int max310x_spi_probe(struct spi_device *spi)
 		return ret;
 
 	if (spi->dev.of_node) {
+		struct gpio_desc *reset_gpio;
 		const struct of_device_id *of_id =
 			of_match_device(max310x_dt_ids, &spi->dev);
 		if (!of_id)
 			return -ENODEV;
 
 		devtype = (struct max310x_devtype *)of_id->data;
+		reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
+						     GPIOD_OUT_HIGH);
+		if (IS_ERR(reset_gpio))
+			return PTR_ERR(reset_gpio);
+		gpiod_set_value_cansleep(reset_gpio, 0);
 	} else {
 		const struct spi_device_id *id_entry = spi_get_device_id(spi);
 
-- 
2.11.0

