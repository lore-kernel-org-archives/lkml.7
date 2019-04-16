Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B019C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F8E2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbfDPT5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:57:43 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:47519 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbfDPT5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:57:42 -0400
Received: from orion.localdomain ([95.117.99.70]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N4i7l-1gosy33tjz-011f1Y; Tue, 16 Apr 2019 21:57:41 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: [PATCH 4/4] input: keyboard: gpio-keys-polled: skip oftree code when CONFIG_OF disabled
Date:   Tue, 16 Apr 2019 21:57:25 +0200
Message-Id: <1555444645-15156-5-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1555444645-15156-1-git-send-email-info@metux.net>
References: <1555444645-15156-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:mvqVlM/Ve9qfMnQh0P0SBJ3tmiUqICi2lk/C5OUytIrVpdTa4SZ
 LsNBXSDfD8Za8Tf6lGTRsF24S9BNAvpOieRP2KaFttZ0QDI4qXyQSKbN+ROP5jOI0KoClKN
 GPAHcZYMMwelHcbFbikWVGTAUEqrsfQL5NuAmVHdsOmwiQqKdWtrgOOhSnTeNp+4D+ZmTfb
 hfYxVgvuCVXgHxjdw8VkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YJ/bmDr3HXk=:0CtQ9OEf8RQvJuxyTHOS7u
 A/yRQaovxLUYV1fMit9AUL+62hbqa0enIxs9Dd8WHt+eZUzeo4AapTN6ylg0lgYN0K9oOPYG3
 rqjpXesJJ7rs37XEsK04ryHUazH27PogxzWucXVQcF1I/vbpL5GqpR7kp79i2a/P4775tSVOl
 GHvsTU0IlwrRMyGKr4ThFXK7K4O0U7lgVhLvSPZJt48rHsMEgOVRpToQH96PVwQE1tAcdod70
 wwVb0ccnncfrsm/mHaPH6WTxzRty1H3PoOXXZ1TO+cnLW4ERcN5LrbNl00Z21918nom2u6PDt
 IuYjA44Z3Y22dQx/ldKvF/KMASYRLGjSR6PWcRrPLZFhVP1HTWoK9zRQB5tUHajIbOT984Zko
 3VrGahkMDbxz+vhCeCyz/JvZOlRz494DUVYF4Bagxn3Exq6/HzI3gUIiIw2KOomriiHbXEvFm
 a4Staq2gwN/MCCVKEgZLu1vY433NuP+GGo/KAPN7NaJqH/KOAWbiQ2C2Q/Mjw8t6r0z2oRcOZ
 a8jH/JSNku1uu8HZh1Tlnntgmz0PygKthFpWoksezYDoJDDkoQr1EUlSODWlMuhHwd3stWxHn
 OqrceO8Acj4GjQvrjhjtE276SwJR1wa/M6wiaBTT3CC1GITRX21/4P7jheajxwhzyqEbx1f8y
 pAaz5glwSSe1AjPqMwjEuNC/sKZ7gK0XBx9HCl/3oz/YVKPbHt4bbXl71bWXMXK3pfyrc04LO
 DVlmujk8pDHga75iiCg5ZV8Ph7cOuBOBn4Lk/Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

we don't need to build in oftree probing stuff when oftree isn't
enabled at all.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/input/keyboard/gpio_keys_polled.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index 3f773b2..fbccb89 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -147,6 +147,7 @@ static void gpio_keys_polled_close(struct input_polled_dev *dev)
 static struct gpio_keys_platform_data *
 gpio_keys_polled_get_devtree_pdata(struct device *dev)
 {
+#ifdef CONFIG_OF
 	struct gpio_keys_platform_data *pdata;
 	struct gpio_keys_button *button;
 	struct fwnode_handle *child;
@@ -200,6 +201,9 @@ static void gpio_keys_polled_close(struct input_polled_dev *dev)
 	}
 
 	return pdata;
+#else /* CONFIG_OF */
+	return ERR_PTR(-ENOENT);
+#endif /* CONFIG_OF */
 }
 
 static void gpio_keys_polled_set_abs_params(struct input_dev *input,
@@ -226,7 +230,7 @@ static void gpio_keys_polled_set_abs_params(struct input_dev *input,
 	{ .compatible = "gpio-keys-polled", },
 	{ },
 };
-MODULE_DEVICE_TABLE(of, gpio_keys_polled_of_match);
+MODULE_DEVICE_TABLE_OF(gpio_keys_polled_of_match);
 
 static struct gpio_desc *gpio_keys_polled_get_gpiod_fwnode(
 	struct device *dev,
@@ -452,7 +456,9 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 	.probe	= gpio_keys_polled_probe,
 	.driver	= {
 		.name	= DRV_NAME,
+#ifdef CONFIG_OF
 		.of_match_table = gpio_keys_polled_of_match,
+#endif /* CONFIG_OF */
 	},
 };
 module_platform_driver(gpio_keys_polled_driver);
-- 
1.9.1

