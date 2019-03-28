Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDEDC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29F3206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfC1NN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:13:57 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:57770 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfC1NNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:13:54 -0400
Received: from ramsan ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id tRDr1z0063XaVaC01RDr99; Thu, 28 Mar 2019 14:13:51 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1h9Uqt-0005Fo-2a; Thu, 28 Mar 2019 14:13:51 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1h9Uqt-0004uk-1T; Thu, 28 Mar 2019 14:13:51 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Benoit Parrot <bparrot@ti.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/3] gpio: Remove obsolete comment about gpiochip_free_hogs() usage
Date:   Thu, 28 Mar 2019 14:13:49 +0100
Message-Id: <20190328131349.18838-4-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190328131349.18838-1-geert+renesas@glider.be>
References: <20190328131349.18838-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpiochip_free_hogs() was always called from gpiochip_remove(), not
of_gpiochip_remove().  It is now also called from the failure patch in
gpiochip_add_data_with_key().

Fixes: f625d4601759f1cf ("gpio: add GPIO hogging mechanism")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpio/gpiolib.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index ed4da07effe0ac40..ec326bd84b1f1c50 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4449,8 +4449,6 @@ int gpiod_hog(struct gpio_desc *desc, const char *name,
 /**
  * gpiochip_free_hogs - Scan gpio-controller chip and release GPIO hog
  * @chip:	gpio chip to act on
- *
- * This is only used by of_gpiochip_remove to free hogged gpios
  */
 static void gpiochip_free_hogs(struct gpio_chip *chip)
 {
-- 
2.17.1

