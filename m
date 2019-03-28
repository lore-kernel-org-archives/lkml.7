Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2547BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007C4206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfC1NN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:13:56 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:45908 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfC1NNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:13:54 -0400
Received: from ramsan ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id tRDr1z0033XaVaC01RDr6A; Thu, 28 Mar 2019 14:13:51 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1h9Uqt-0005Fj-1J; Thu, 28 Mar 2019 14:13:51 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1h9Uqt-0004ue-0E; Thu, 28 Mar 2019 14:13:51 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Benoit Parrot <bparrot@ti.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/3] gpio: of: Fix of_gpiochip_add() error path
Date:   Thu, 28 Mar 2019 14:13:47 +0100
Message-Id: <20190328131349.18838-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190328131349.18838-1-geert+renesas@glider.be>
References: <20190328131349.18838-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the call to of_gpiochip_scan_gpios() in of_gpiochip_add() fails, no
error handling is performed.  This lead to the need of callers to call
of_gpiochip_remove() on failure, which causes "BAD of_node_put() on ..."
if the failure happened before the call to of_node_get().

Fix this by adding proper error handling.

Note that calling gpiochip_remove_pin_ranges() multiple times causes no
harm: subsequent calls are a no-op.

Fixes: dfbd379ba9b7431e ("gpio: of: Return error if gpio hog configuration failed")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpio/gpiolib-of.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 8b9c3ab70f6eade4..257be7bac032a855 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -717,7 +717,13 @@ int of_gpiochip_add(struct gpio_chip *chip)
 
 	of_node_get(chip->of_node);
 
-	return of_gpiochip_scan_gpios(chip);
+	status = of_gpiochip_scan_gpios(chip);
+	if (status) {
+		of_node_put(chip->of_node);
+		gpiochip_remove_pin_ranges(chip);
+	}
+
+	return status;
 }
 
 void of_gpiochip_remove(struct gpio_chip *chip)
-- 
2.17.1

