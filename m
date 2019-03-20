Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807D4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 539022184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfCTKjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:39:33 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:39332 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbfCTKjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:39:32 -0400
Received: from ramsan ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id qAfV1z00B3XaVaC06AfVU0; Wed, 20 Mar 2019 11:39:30 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1h6Yd7-0005La-9L; Wed, 20 Mar 2019 11:39:29 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1h6Yd7-0005X6-7t; Wed, 20 Mar 2019 11:39:29 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH RFC] gpio: pca953x: Configure wake-up path when wake-up is enabled
Date:   Wed, 20 Mar 2019 11:39:27 +0100
Message-Id: <20190320103927.21227-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a device is part of the wake-up path, it should indicate this by
setting its power.wakeup_path field.  This allows the genpd core code to
keep the device enabled during system suspend when needed.

As regulators powering devices are not handled by genpd, the driver
handles these itself, and thus must skip regulator control when the
device is part of the wake-up path.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Note that I don't really need this on the Renesas Ebisu-4D board, as
there is no regulator or PM Domain controlling power to the GPIO
expander on that board.  I did want to have all wake-up path processing
implemented in the driver for completeness, and did test its behavior
with gpio-keys configured as a wake-up source.

However, while this approach is known to work fine on other boards, with
other GPIO and interrupt controllers (gpio-rcar, irq-renesas-irqc,
irq-renesas-intc-irqpin), it wouldn't work on Ebisu-4D, due to different
device suspend ordering.

The proper ordering is:
  1. When gpio-keys is suspended, its suspend handler calls
     enable_irq_wake(), invoking pca953x_irq_set_wake(), and causing
     pca953x_chip.wakeup_path to be incremented,
  2. When gpio-pca953x is suspended, it checks pca953x_chip.wakeup_path,
     and marks the device to be part of the wake-up path.

However, gpio-keys is suspended _after_ gpio-pca953x, breaking the
scheme :-(

So depending on topology, this may work, or not...
---
 drivers/gpio/gpio-pca953x.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 88c94d155e218535..349d0ccb5285a6c4 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -153,6 +153,7 @@ struct pca953x_chip {
 	u8 irq_trig_fall[MAX_BANK];
 	struct irq_chip irq_chip;
 #endif
+	atomic_t wakeup_path;
 
 	struct i2c_client *client;
 	struct gpio_chip gpio_chip;
@@ -581,6 +582,11 @@ static int pca953x_irq_set_wake(struct irq_data *d, unsigned int on)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct pca953x_chip *chip = gpiochip_get_data(gc);
 
+	if (on)
+		atomic_inc(&chip->wakeup_path);
+	else
+		atomic_dec(&chip->wakeup_path);
+
 	return irq_set_irq_wake(chip->client->irq, on);
 }
 
@@ -1100,7 +1106,10 @@ static int pca953x_suspend(struct device *dev)
 
 	regcache_cache_only(chip->regmap, true);
 
-	regulator_disable(chip->regulator);
+	if (atomic_read(&chip->wakeup_path))
+		device_set_wakeup_path(dev);
+	else
+		regulator_disable(chip->regulator);
 
 	return 0;
 }
@@ -1110,10 +1119,12 @@ static int pca953x_resume(struct device *dev)
 	struct pca953x_chip *chip = dev_get_drvdata(dev);
 	int ret;
 
-	ret = regulator_enable(chip->regulator);
-	if (ret != 0) {
-		dev_err(dev, "Failed to enable regulator: %d\n", ret);
-		return 0;
+	if (!atomic_read(&chip->wakeup_path)) {
+		ret = regulator_enable(chip->regulator);
+		if (ret != 0) {
+			dev_err(dev, "Failed to enable regulator: %d\n", ret);
+			return 0;
+		}
 	}
 
 	regcache_cache_only(chip->regmap, false);
-- 
2.17.1

