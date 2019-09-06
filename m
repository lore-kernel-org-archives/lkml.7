Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC954C43140
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 08:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D034A206A5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 08:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392529AbfIFIpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 04:45:49 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:56182 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391657AbfIFIpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 04:45:44 -0400
Received: from ramsan ([84.194.98.4])
        by xavier.telenet-ops.be with bizsmtp
        id y8lh2000105gfCL018lhBh; Fri, 06 Sep 2019 10:45:41 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1i69sC-0003N3-UY; Fri, 06 Sep 2019 10:45:40 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1i69sC-0005h6-TH; Fri, 06 Sep 2019 10:45:40 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/4] gpio: of: Make of_gpio_simple_xlate() private
Date:   Fri,  6 Sep 2019 10:45:37 +0200
Message-Id: <20190906084539.21838-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190906084539.21838-1-geert+renesas@glider.be>
References: <20190906084539.21838-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 9a95e8d25a140ba9 ("gpio: remove etraxfs driver"), there are
no more users of of_gpio_simple_xlate() outside gpiolib-of.c.
All GPIO drivers that need it now rely on of_gpiochip_add() setting it
up as the default translate function.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpio/gpiolib-of.c |  6 +++---
 include/linux/of_gpio.h   | 11 -----------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 4c6b366cb7bd5cd0..fad3aad667558325 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -637,8 +637,9 @@ static int of_gpiochip_scan_gpios(struct gpio_chip *chip)
  * GPIO chips. This function performs only one sanity check: whether GPIO
  * is less than ngpios (that is specified in the gpio_chip).
  */
-int of_gpio_simple_xlate(struct gpio_chip *gc,
-			 const struct of_phandle_args *gpiospec, u32 *flags)
+static int of_gpio_simple_xlate(struct gpio_chip *gc,
+				const struct of_phandle_args *gpiospec,
+				u32 *flags)
 {
 	/*
 	 * We're discouraging gpio_cells < 2, since that way you'll have to
@@ -662,7 +663,6 @@ int of_gpio_simple_xlate(struct gpio_chip *gc,
 
 	return gpiospec->args[0];
 }
-EXPORT_SYMBOL(of_gpio_simple_xlate);
 
 /**
  * of_mm_gpiochip_add_data - Add memory mapped GPIO chip (bank)
diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
index f9737dea9d1f945a..16967390a3fe3b12 100644
--- a/include/linux/of_gpio.h
+++ b/include/linux/of_gpio.h
@@ -61,10 +61,6 @@ static inline int of_mm_gpiochip_add(struct device_node *np,
 }
 extern void of_mm_gpiochip_remove(struct of_mm_gpio_chip *mm_gc);
 
-extern int of_gpio_simple_xlate(struct gpio_chip *gc,
-				const struct of_phandle_args *gpiospec,
-				u32 *flags);
-
 #else /* CONFIG_OF_GPIO */
 
 /* Drivers may not strictly depend on the GPIO support, so let them link. */
@@ -77,13 +73,6 @@ static inline int of_get_named_gpio_flags(struct device_node *np,
 	return -ENOSYS;
 }
 
-static inline int of_gpio_simple_xlate(struct gpio_chip *gc,
-				       const struct of_phandle_args *gpiospec,
-				       u32 *flags)
-{
-	return -ENOSYS;
-}
-
 #endif /* CONFIG_OF_GPIO */
 
 /**
-- 
2.17.1

