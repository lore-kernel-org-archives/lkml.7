Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6474FC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A692183F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCjQucvP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733268AbfDQUzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:55:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36195 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733182AbfDQUy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:54:58 -0400
Received: by mail-lj1-f195.google.com with SMTP id r24so23801355ljg.3;
        Wed, 17 Apr 2019 13:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TRX5VowVvRegmnOEqdDkIwN2xpk7VxpNVyT3Fs+CX40=;
        b=MCjQucvPcXFJFSmmdZCJ5FHHieJO897cV8m7pUjvkxJfvY9yi/rmPy7Hwj+EIPO8un
         rKg3Zf6yS8jvTrFi7mpKOuZATsnbmAe35uViLrG4RAeyw2GWqgdY7pFUG9LbfWLybZbK
         l62BfRTg461RzBxflhzcD1a6oRZ0X0o7yDlpcpMeoIiumG8Kvsr6J0cFk5Ir3SRLOdpf
         RLAiTInkA/3xY/G3D6nDzrgIfJgN/N7TA5SmRhs0YrV9EOcTjSpxBk90xds1hhxt2bEk
         AEC1VWWi2PKPIuu/OCxnOThQjqX3afR6PumjbUJRL7BGBVY3PZN2NIHFr/LwPdICk4g9
         cnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TRX5VowVvRegmnOEqdDkIwN2xpk7VxpNVyT3Fs+CX40=;
        b=b4cqOE9M0hdrUxcv8D07Hk/LgVJD306dIGyLNjG+3S1vZZ1cGB3IqnvxocNwesQihs
         F90i8hZi81SOxbN+u4f7Cnd8IqluoMjpA8D+obRt4temf+1p5Nx35RtdIkwmpuQ6/9wk
         bwL0f+e3pKVuybHhvnPsFTBSKoFh982AI+IG5B/pdC5S8B/T6XAfkugsBRexHk7nBB28
         GwHjil/5q4Ie74g2bPbZDSK6JXjrdVDyoopFxPoA/v0+rZpEPyGKoJTtLkFlJzt+ykIS
         BLLX/5N3j0pwUGYA7psc44HLWq75GaZUOGEgCYU9hDQa1vuNYbKoAKlcdo6hYeB8xkGq
         Z7Ew==
X-Gm-Message-State: APjAAAUjjUbaDwf5JOKKVIJfHsZewiGqsGqw98PDyBxD09nx3LB3UeqV
        q4mQwlLBJzBDlyrPYRbb7qKuEbDC
X-Google-Smtp-Source: APXvYqzxpYh1ts6t8JB4A9gGkyf7Jg66DpLUSlnyBU7np14cYL8+HRLPS+w0ZQAPXNVKMj29agAH+g==
X-Received: by 2002:a2e:960b:: with SMTP id v11mr36337917ljh.135.1555534495293;
        Wed, 17 Apr 2019 13:54:55 -0700 (PDT)
Received: from myhost.home (bfw35.neoplus.adsl.tpnet.pl. [83.28.60.35])
        by smtp.gmail.com with ESMTPSA id z206sm4342lfa.53.2019.04.17.13.54.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 13:54:54 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, dtor@google.com, linux@roeck-us.net,
        jacek.anaszewski@gmail.com, Baolin Wang <baolin.wang@linaro.org>,
        Dan Murphy <dmurphy@ti.com>, Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
Subject: [PATCH v4 02/26] leds: class: Improve LED and LED flash class registration API
Date:   Wed, 17 Apr 2019 22:54:15 +0200
Message-Id: <20190417205439.17685-3-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace of_led_classdev_register() with led_classdev_register_ext(), which
accepts easily extendable struct led_init_data, instead of the fixed
struct device_node argument. The latter can be now passed in an fwnode
property of the struct led_init_data.

The modification is driven by the need for passing additional arguments
required for the forthcoming generic mechanism for composing LED names.
Currently the LED name is conveyed in the "name" char pointer property of
the struct led_classdev, which is semantically and functionally incorrect
since it is needed only on LED class device registration, but persists
in the system memory throughout the whole LED class device lifetime.

The change will not break any existing clients since the patch alters
also existing led_classdev{_flash}_register() macro wrappers, that pass
NULL in place of init_data, which leads to using legacy name
initialization path basing on the struct led_classdev's "name" property.

Three existing users of devm_of_led_classdev_registers() are modified
to use devm_led_classdev_register(), which will not impact their
operation since they in fact didn't need to pass struct device_node on
registration from the beginning.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Dan Murphy <dmurphy@ti.com>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Oleh Kravchenko <oleg@kaa.org.ua>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Simon Shields <simon@lineageos.org>
---
 drivers/leds/led-class-flash.c  |  9 +++++----
 drivers/leds/led-class.c        | 29 +++++++++++++++++------------
 drivers/leds/leds-cr0014114.c   |  3 +--
 drivers/leds/leds-gpio.c        |  2 +-
 drivers/leds/leds-pwm.c         |  2 +-
 include/linux/led-class-flash.h | 15 ++++++++++-----
 include/linux/leds.h            | 34 ++++++++++++++++++++++++----------
 7 files changed, 59 insertions(+), 35 deletions(-)

diff --git a/drivers/leds/led-class-flash.c b/drivers/leds/led-class-flash.c
index cf398275a53c..8d1c1177bb9a 100644
--- a/drivers/leds/led-class-flash.c
+++ b/drivers/leds/led-class-flash.c
@@ -285,8 +285,9 @@ static void led_flash_init_sysfs_groups(struct led_classdev_flash *fled_cdev)
 	led_cdev->groups = flash_groups;
 }
 
-int led_classdev_flash_register(struct device *parent,
-				struct led_classdev_flash *fled_cdev)
+int led_classdev_flash_register_ext(struct device *parent,
+				    struct led_classdev_flash *fled_cdev,
+				    struct led_init_data *init_data)
 {
 	struct led_classdev *led_cdev;
 	const struct led_flash_ops *ops;
@@ -312,13 +313,13 @@ int led_classdev_flash_register(struct device *parent,
 	}
 
 	/* Register led class device */
-	ret = led_classdev_register(parent, led_cdev);
+	ret = led_classdev_register_ext(parent, led_cdev, init_data);
 	if (ret < 0)
 		return ret;
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(led_classdev_flash_register);
+EXPORT_SYMBOL_GPL(led_classdev_flash_register_ext);
 
 void led_classdev_flash_unregister(struct led_classdev_flash *fled_cdev)
 {
diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 3c7e3487b373..2f09156b0c63 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -17,6 +17,7 @@
 #include <linux/leds.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/timer.h>
@@ -244,14 +245,16 @@ static int led_classdev_next_name(const char *init_name, char *name,
 }
 
 /**
- * of_led_classdev_register - register a new object of led_classdev class.
+ * led_classdev_register_ext - register a new object of led_classdev class
+ *			       with init data.
  *
  * @parent: parent of LED device
  * @led_cdev: the led_classdev structure for this device.
- * @np: DT node describing this LED
+ * @init_data: LED class device initialization data
  */
-int of_led_classdev_register(struct device *parent, struct device_node *np,
-			    struct led_classdev *led_cdev)
+int led_classdev_register_ext(struct device *parent,
+			      struct led_classdev *led_cdev,
+			      struct led_init_data *init_data)
 {
 	char name[LED_MAX_NAME_SIZE];
 	int ret;
@@ -268,7 +271,8 @@ int of_led_classdev_register(struct device *parent, struct device_node *np,
 		mutex_unlock(&led_cdev->led_access);
 		return PTR_ERR(led_cdev->dev);
 	}
-	led_cdev->dev->of_node = np;
+	if (init_data && init_data->fwnode)
+		led_cdev->dev->of_node = to_of_node(init_data->fwnode);
 
 	if (ret)
 		dev_warn(parent, "Led %s renamed to %s due to name collision",
@@ -313,7 +317,7 @@ int of_led_classdev_register(struct device *parent, struct device_node *np,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(of_led_classdev_register);
+EXPORT_SYMBOL_GPL(led_classdev_register_ext);
 
 /**
  * led_classdev_unregister - unregisters a object of led_properties class.
@@ -358,14 +362,15 @@ static void devm_led_classdev_release(struct device *dev, void *res)
 }
 
 /**
- * devm_of_led_classdev_register - resource managed led_classdev_register()
+ * devm_led_classdev_register_ext - resource managed led_classdev_register_ext()
  *
  * @parent: parent of LED device
  * @led_cdev: the led_classdev structure for this device.
+ * @init_data: LED class device initialization data
  */
-int devm_of_led_classdev_register(struct device *parent,
-				  struct device_node *np,
-				  struct led_classdev *led_cdev)
+int devm_led_classdev_register_ext(struct device *parent,
+				   struct led_classdev *led_cdev,
+				   struct led_init_data *init_data)
 {
 	struct led_classdev **dr;
 	int rc;
@@ -374,7 +379,7 @@ int devm_of_led_classdev_register(struct device *parent,
 	if (!dr)
 		return -ENOMEM;
 
-	rc = of_led_classdev_register(parent, np, led_cdev);
+	rc = led_classdev_register_ext(parent, led_cdev, init_data);
 	if (rc) {
 		devres_free(dr);
 		return rc;
@@ -385,7 +390,7 @@ int devm_of_led_classdev_register(struct device *parent,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(devm_of_led_classdev_register);
+EXPORT_SYMBOL_GPL(devm_led_classdev_register_ext);
 
 static int devm_led_classdev_match(struct device *dev, void *res, void *data)
 {
diff --git a/drivers/leds/leds-cr0014114.c b/drivers/leds/leds-cr0014114.c
index 0e4262462cb9..1c82152764d2 100644
--- a/drivers/leds/leds-cr0014114.c
+++ b/drivers/leds/leds-cr0014114.c
@@ -207,8 +207,7 @@ static int cr0014114_probe_dt(struct cr0014114 *priv)
 		led->ldev.max_brightness	  = CR_MAX_BRIGHTNESS;
 		led->ldev.brightness_set_blocking = cr0014114_set_sync;
 
-		ret = devm_of_led_classdev_register(priv->dev, np,
-						    &led->ldev);
+		ret = devm_led_classdev_register(priv->dev, &led->ldev);
 		if (ret) {
 			dev_err(priv->dev,
 				"failed to register LED device %s, err %d",
diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index 998f2ff6914d..b26cf78993d1 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -112,7 +112,7 @@ static int create_gpio_led(const struct gpio_led *template,
 	if (ret < 0)
 		return ret;
 
-	return devm_of_led_classdev_register(parent, np, &led_dat->cdev);
+	return devm_led_classdev_register(parent, &led_dat->cdev);
 }
 
 struct gpio_leds_priv {
diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index af08bcdc4fd8..fcb3e87a9887 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -114,7 +114,7 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 	if (!led_data->period && (led->pwm_period_ns > 0))
 		led_data->period = led->pwm_period_ns;
 
-	ret = devm_of_led_classdev_register(dev, child, &led_data->cdev);
+	ret = devm_led_classdev_register(dev, &led_data->cdev);
 	if (ret == 0) {
 		priv->num_leds++;
 		led_pwm_set(&led_data->cdev, led_data->cdev.brightness);
diff --git a/include/linux/led-class-flash.h b/include/linux/led-class-flash.h
index 700efaa9e115..ded8d9fa6149 100644
--- a/include/linux/led-class-flash.h
+++ b/include/linux/led-class-flash.h
@@ -90,15 +90,20 @@ static inline struct led_classdev_flash *lcdev_to_flcdev(
 }
 
 /**
- * led_classdev_flash_register - register a new object of led_classdev class
- *				 with support for flash LEDs
- * @parent: the flash LED to register
+ * led_classdev_flash_register_ext - register a new object of LED class with
+ *				     init data and with support for flash LEDs
+ * @parent: LED flash controller device this flash LED is driven by
  * @fled_cdev: the led_classdev_flash structure for this device
+ * @init_data: the LED class flash device initialization data
  *
  * Returns: 0 on success or negative error value on failure
  */
-extern int led_classdev_flash_register(struct device *parent,
-				struct led_classdev_flash *fled_cdev);
+extern int led_classdev_flash_register_ext(struct device *parent,
+					struct led_classdev_flash *fled_cdev,
+					struct led_init_data *init_data);
+
+#define led_classdev_flash_register(parent, fled_cdev)		\
+	led_classdev_flash_register_ext(parent, fled_cdev, NULL)
 
 /**
  * led_classdev_flash_unregister - unregisters an object of led_classdev class
diff --git a/include/linux/leds.h b/include/linux/leds.h
index 78204650fe2a..fab83a2d7bff 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -34,6 +34,11 @@ enum led_brightness {
 	LED_FULL	= 255,
 };
 
+struct led_init_data {
+	/* device fwnode handle */
+	struct fwnode_handle *fwnode;
+};
+
 struct led_classdev {
 	const char		*name;
 	enum led_brightness	 brightness;
@@ -129,16 +134,25 @@ struct led_classdev {
 	struct mutex		led_access;
 };
 
-extern int of_led_classdev_register(struct device *parent,
-				    struct device_node *np,
-				    struct led_classdev *led_cdev);
-#define led_classdev_register(parent, led_cdev)				\
-	of_led_classdev_register(parent, NULL, led_cdev)
-extern int devm_of_led_classdev_register(struct device *parent,
-					 struct device_node *np,
-					 struct led_classdev *led_cdev);
-#define devm_led_classdev_register(parent, led_cdev)			\
-	devm_of_led_classdev_register(parent, NULL, led_cdev)
+/**
+ * led_classdev_register_ext - register a new object of LED class with
+ *			       init data
+ * @parent: LED controller device this LED is driven by
+ * @led_cdev: the led_classdev structure for this device
+ * @init_data: the LED class device initialization data
+ *
+ * Returns: 0 on success or negative error value on failure
+ */
+extern int led_classdev_register_ext(struct device *parent,
+				     struct led_classdev *led_cdev,
+				     struct led_init_data *init_data);
+#define led_classdev_register(parent, led_cdev)			\
+	led_classdev_register_ext(parent, led_cdev, NULL)
+extern int devm_led_classdev_register_ext(struct device *parent,
+					  struct led_classdev *led_cdev,
+					  struct led_init_data *init_data);
+#define devm_led_classdev_register(parent, led_cdev)		\
+	devm_led_classdev_register_ext(parent, led_cdev, NULL)
 extern void led_classdev_unregister(struct led_classdev *led_cdev);
 extern void devm_led_classdev_unregister(struct device *parent,
 					 struct led_classdev *led_cdev);
-- 
2.11.0

