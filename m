Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5176FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29AD12077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbfDXN7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:59:39 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:33622 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfDXN7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:59:38 -0400
Received: from ramsan ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id 4Dzb2000P3XaVaC01Dzbyr; Wed, 24 Apr 2019 15:59:35 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hJIQx-00088l-DS; Wed, 24 Apr 2019 15:59:35 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hJIQx-0006ek-Be; Wed, 24 Apr 2019 15:59:35 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Benoit Parrot <bparrot@ti.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] gpio: Fix gpiochip_add_data_with_key() error path
Date:   Wed, 24 Apr 2019 15:59:33 +0200
Message-Id: <20190424135933.25545-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The err_remove_chip block is too coarse, and may perform cleanup that
must not be done.  E.g. if of_gpiochip_add() fails, of_gpiochip_remove()
is still called, causing:

    OF: ERROR: Bad of_node_put() on /soc/gpio@e6050000
    CPU: 1 PID: 20 Comm: kworker/1:1 Not tainted 5.1.0-rc2-koelsch+ #407
    Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
    Workqueue: events deferred_probe_work_func
    [<c020ec74>] (unwind_backtrace) from [<c020ae58>] (show_stack+0x10/0x14)
    [<c020ae58>] (show_stack) from [<c07c1224>] (dump_stack+0x7c/0x9c)
    [<c07c1224>] (dump_stack) from [<c07c5a80>] (kobject_put+0x94/0xbc)
    [<c07c5a80>] (kobject_put) from [<c0470420>] (gpiochip_add_data_with_key+0x8d8/0xa3c)
    [<c0470420>] (gpiochip_add_data_with_key) from [<c0473738>] (gpio_rcar_probe+0x1d4/0x314)
    [<c0473738>] (gpio_rcar_probe) from [<c052fca8>] (platform_drv_probe+0x48/0x94)

and later, if a GPIO consumer tries to use a GPIO from a failed
controller:

    WARNING: CPU: 0 PID: 1 at lib/refcount.c:156 kobject_get+0x38/0x4c
    refcount_t: increment on 0; use-after-free.
    Modules linked in:
    CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.1.0-rc2-koelsch+ #407
    Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
    [<c020ec74>] (unwind_backtrace) from [<c020ae58>] (show_stack+0x10/0x14)
    [<c020ae58>] (show_stack) from [<c07c1224>] (dump_stack+0x7c/0x9c)
    [<c07c1224>] (dump_stack) from [<c0221580>] (__warn+0xd0/0xec)
    [<c0221580>] (__warn) from [<c02215e0>] (warn_slowpath_fmt+0x44/0x6c)
    [<c02215e0>] (warn_slowpath_fmt) from [<c07c58fc>] (kobject_get+0x38/0x4c)
    [<c07c58fc>] (kobject_get) from [<c068b3ec>] (of_node_get+0x14/0x1c)
    [<c068b3ec>] (of_node_get) from [<c0686f24>] (of_find_node_by_phandle+0xc0/0xf0)
    [<c0686f24>] (of_find_node_by_phandle) from [<c0686fbc>] (of_phandle_iterator_next+0x68/0x154)
    [<c0686fbc>] (of_phandle_iterator_next) from [<c0687fe4>] (__of_parse_phandle_with_args+0x40/0xd0)
    [<c0687fe4>] (__of_parse_phandle_with_args) from [<c0688204>] (of_parse_phandle_with_args_map+0x100/0x3ac)
    [<c0688204>] (of_parse_phandle_with_args_map) from [<c0471240>] (of_get_named_gpiod_flags+0x38/0x380)
    [<c0471240>] (of_get_named_gpiod_flags) from [<c046f864>] (gpiod_get_from_of_node+0x24/0xd8)
    [<c046f864>] (gpiod_get_from_of_node) from [<c0470aa4>] (devm_fwnode_get_index_gpiod_from_child+0xa0/0x144)
    [<c0470aa4>] (devm_fwnode_get_index_gpiod_from_child) from [<c05f425c>] (gpio_keys_probe+0x418/0x7bc)
    [<c05f425c>] (gpio_keys_probe) from [<c052fca8>] (platform_drv_probe+0x48/0x94)

Fix this by splitting the cleanup block, and adding a missing call to
gpiochip_irqchip_remove().

Fixes: 28355f81969962cf ("gpio: defer probe if pinctrl cannot be found")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
---
v2:
  - s/err_free_irqchip_mask/err_free_gpiochip_mask/,
  - Add Reviewed-by.

---
 drivers/gpio/gpiolib.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 982845e8212cc4e4..6e825258978f6074 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1379,7 +1379,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
 
 	status = gpiochip_add_irqchip(chip, lock_key, request_key);
 	if (status)
-		goto err_remove_chip;
+		goto err_free_gpiochip_mask;
 
 	status = of_gpiochip_add(chip);
 	if (status)
@@ -1387,7 +1387,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
 
 	status = gpiochip_init_valid_mask(chip);
 	if (status)
-		goto err_remove_chip;
+		goto err_remove_of_chip;
 
 	for (i = 0; i < chip->ngpio; i++) {
 		struct gpio_desc *desc = &gdev->descs[i];
@@ -1415,14 +1415,18 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
 	if (gpiolib_initialized) {
 		status = gpiochip_setup_dev(gdev);
 		if (status)
-			goto err_remove_chip;
+			goto err_remove_acpi_chip;
 	}
 	return 0;
 
-err_remove_chip:
+err_remove_acpi_chip:
 	acpi_gpiochip_remove(chip);
+err_remove_of_chip:
 	gpiochip_free_hogs(chip);
 	of_gpiochip_remove(chip);
+err_remove_chip:
+	gpiochip_irqchip_remove(chip);
+err_free_gpiochip_mask:
 	gpiochip_free_valid_mask(chip);
 err_remove_irqchip_mask:
 	gpiochip_irqchip_free_valid_mask(chip);
-- 
2.17.1

