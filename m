Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6580DC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D74208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfDZTBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:01:30 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:46115 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfDZTB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:01:29 -0400
Received: from orion.localdomain ([95.117.100.117]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MnpwC-1gzuiT0pOU-00pMUM; Fri, 26 Apr 2019 21:01:27 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: [PATCH v2 3/3] input: keyboard: gpio-keys-polled: skip oftree code when CONFIG_OF disabled
Date:   Fri, 26 Apr 2019 21:01:22 +0200
Message-Id: <1556305282-24148-4-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556305282-24148-1-git-send-email-info@metux.net>
References: <1556305282-24148-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:kMQozdLXEQPghJnE3MO1V+pvs9P/5sD3z4hKWAyEap3u/EO/sJZ
 U6ouMTZrEUFeOJYKSkMLEJGCaAbvhNPY6UJPbHlYGBq8OFFDMGlizEc1PV7lAW1EbIhsnbA
 x4V8b99z4VZXwc+CiboZanlYioPcpVwcfuXnaNjqwcGfrdsByg23ATAiJH+Jsa74vF6GTw4
 tnEv2MPen+5Gor/PWd7kw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B8GEzLKFPPk=:YlCVPl3+ImJ2KOJ9FNT5bN
 UxTEzl990kS/yd8p6pU40NsMrkdwNv4FjM3qO+NfZ2HhG7Tg9K+A2pIlX1ybwZPxWOZZFvqys
 n9p0SwHPG1f3Ataq0dY0mhqJnhmu32FUF7piS2V4mxrrFxO2zsl1mhMLGesoViuR8o01WdWWx
 uT87aVs5dTcX6mRFkJV7lFWqh1ybrg9NX+fY5QV5/O9h1mdQpQ9siEflR3qnYc6S3n9iVQ02q
 J2+Dnj+Y3f/k+X6nyyRxi1Cf5A8EfXxZ9VBFW0ucGMHRDtYFywOW+nVL3z6hwpGj7G2hOpHOK
 pyMU971wev5VBHyC4iVag1njU4O+kmkJ0r5jNoKI0vWsEAtN/7Glpk93EjMGYUHqQb6/rgrM+
 UI84gjkHiAGZgnrYiAEyKAHwrai5TFXdxGYEJAq1udj17XEQkJfoOVYreiqKGVNbYjnohg+/c
 geHb6hS4G1DfsESeU04pAfxrhMZ1KKN7IbZ1rH6rv3L2VyWFsN3kCgQN9/Pzs3x/wlzAFWcJH
 np968UV7nrymMuPdCOSZI2i3jjiv2Lxy76hFDKq5Ca0Fvyfz+dEj2x68dNgJ1MjxeFOqWaq4Z
 v2J+BcwQUIQ2tXjCZofHoo303QJmTg3PbDGz+KVXBhp2x5pT5NDskBJLKo228zYTQUWFpFHIC
 8p6HlZQSUbq7Y5yzBzA3sgqw6YztDK4pHC/9DxC6ZTpeVz9/K1KoAXmFZZ65tsCUiYmJc9e0Y
 HJDR4pmbHwFWJT/kTb+0hGut/mUBghQy4xKewg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

we don't need to build in oftree probing stuff when oftree isn't
enabled at all.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/input/keyboard/gpio_keys_polled.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index 3f773b2..65860bf 100644
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
@@ -222,11 +226,13 @@ static void gpio_keys_polled_set_abs_params(struct input_dev *input,
 	input_set_abs_params(input, code, min, max, 0, 0);
 }
 
+#ifdef CONFIG_OF
 static const struct of_device_id gpio_keys_polled_of_match[] = {
 	{ .compatible = "gpio-keys-polled", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, gpio_keys_polled_of_match);
+#endif /* CONFIG_OF */
 
 static struct gpio_desc *gpio_keys_polled_get_gpiod_fwnode(
 	struct device *dev,
@@ -452,7 +458,9 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
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

