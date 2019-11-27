Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD309C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A7E2073F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfK0KCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 05:02:44 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:43874 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfK0KCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 05:02:44 -0500
Received: from ramsan ([84.195.182.253])
        by laurent.telenet-ops.be with bizsmtp
        id Wy2i2100P5USYZQ01y2i3Q; Wed, 27 Nov 2019 11:02:42 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iZu9i-0001wi-HG; Wed, 27 Nov 2019 11:02:42 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iZu9i-0001UV-FI; Wed, 27 Nov 2019 11:02:42 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC] gpiolib: Let gpiod_add_lookup_table() call gpiod_add_lookup_tables()
Date:   Wed, 27 Nov 2019 11:02:41 +0100
Message-Id: <20191127100241.5690-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This saves 20 bytes on arm32, and 44 bytes on arm64.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Interestingly, making gpiod_add_lookup_table() a static inline function
in <linux/gpio/machine.h> increases the caller's code size by 68 bytes
on arm32.
---
 drivers/gpio/gpiolib.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index cb608512ad6bbded..aae01b117bc6450e 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4373,11 +4373,7 @@ EXPORT_SYMBOL_GPL(gpiod_set_array_value_cansleep);
  */
 void gpiod_add_lookup_table(struct gpiod_lookup_table *table)
 {
-	mutex_lock(&gpio_lookup_lock);
-
-	list_add_tail(&table->list, &gpio_lookup_list);
-
-	mutex_unlock(&gpio_lookup_lock);
+	gpiod_add_lookup_tables(&table, 1);
 }
 EXPORT_SYMBOL_GPL(gpiod_add_lookup_table);
 
-- 
2.17.1

