Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801BAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A9421773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbfC2Ime (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:42:34 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:40526 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729139AbfC2Ime (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:42:34 -0400
Received: from ramsan ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id tkiW1z00e3XaVaC01kiWqw; Fri, 29 Mar 2019 09:42:32 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1h9n5r-0001QX-39; Fri, 29 Mar 2019 09:42:31 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1h9n5r-0004RD-27; Fri, 29 Mar 2019 09:42:31 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] gpio: of: Optimize quirk checks
Date:   Fri, 29 Mar 2019 09:42:29 +0100
Message-Id: <20190329084229.17018-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple string comparisons are cheaper than DT lookups, as the latter
involve taking a spinlock and traversing properties.
Hence optimize quirk checks by postponing DT lookups after string
comparisons.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpio/gpiolib-of.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 6a3ec575a404ed9f..3a6bb53d89dfed32 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -86,9 +86,9 @@ static void of_gpio_flags_quirks(struct device_node *np,
 	if (IS_ENABLED(CONFIG_REGULATOR) &&
 	    (of_device_is_compatible(np, "regulator-fixed") ||
 	     of_device_is_compatible(np, "reg-fixed-voltage") ||
-	     (of_device_is_compatible(np, "regulator-gpio") &&
-	      !(strcmp(propname, "enable-gpio") &&
-	        strcmp(propname, "enable-gpios"))))) {
+	     (!(strcmp(propname, "enable-gpio") &&
+		strcmp(propname, "enable-gpios")) &&
+	      of_device_is_compatible(np, "regulator-gpio")))) {
 		/*
 		 * The regulator GPIO handles are specified such that the
 		 * presence or absence of "enable-active-high" solely controls
@@ -119,9 +119,8 @@ static void of_gpio_flags_quirks(struct device_node *np,
 	 * property named "cs-gpios" we need to inspect the child node
 	 * to determine if the flags should have inverted semantics.
 	 */
-	if (IS_ENABLED(CONFIG_SPI_MASTER) &&
-	    of_property_read_bool(np, "cs-gpios") &&
-	    !strcmp(propname, "cs-gpios")) {
+	if (IS_ENABLED(CONFIG_SPI_MASTER) && !strcmp(propname, "cs-gpios") &&
+	    of_property_read_bool(np, "cs-gpios")) {
 		struct device_node *child;
 		u32 cs;
 		int ret;
-- 
2.17.1

