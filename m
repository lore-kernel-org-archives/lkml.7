Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527A4C48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B57F20659
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfF0PHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 11:07:17 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:53253 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfF0PHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 11:07:15 -0400
Received: from orion.localdomain ([77.7.61.149]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MMGAg-1hxUuc45x8-00JKkU; Thu, 27 Jun 2019 17:07:13 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: [PATCH 2/2] input: keyboard: gpio_keys_polled: use gpio lookup table
Date:   Thu, 27 Jun 2019 17:07:11 +0200
Message-Id: <1561648031-15887-2-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1561648031-15887-1-git-send-email-info@metux.net>
References: <1561648031-15887-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:Hws2lYSPQtdaxdpUg6NBrrKVEUPAKMyNeoto5GP7O+U7Xkcpqrd
 2mWcXYfu8XmG83R2WRmzSYzSjEV2K1og3vtcerofW80wUoNdIGLTIbR8S3is2aiiiETGm2a
 r7SODDJC87ehNkod8A5lwTCeSahelvLURI/FggYced+RjNJILVQKj95+l5qMbXn+EVPubpT
 qy87Gw4c+z9AMifD2Sp8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a+OiVhE6TGU=:8qp48L5Fo8wJUr7L3QRmiB
 SOFrXvdTDjOOFStpe2qwKEP1JmNkXLE9n8Xe8hJLH6zcMScz3SXh2rdjsFKtfLCScC47OuLX5
 bsXP5SL2ot39fgulGChfD5UEL8hG+VimhjFOFeYY1AtFzQogXSUU/i37JkD6HYv6Oar5he10n
 am81SYr5AtPqNFp4TKpCbXpzdjcZBxwfwW1oGpjDztM9a20VGUSgkZJSXz1FNDScfbs0Fyd99
 VGXcTLipnPO3PECD9R1rNAR5FzUi9wgBKCnh8nX9fokjfSthzrqfgkqdqsoVYtblmP9AFD7lY
 0bVSt7FaDC7DkXypbc1EJe1RW/f76Anp0ylKlCiLPOEhhL7VI99j0N6oDkq0B3aMw2FLXfdTL
 g0unQr5AjI8aYXobdpvcAWyev/v02Hd4x52Yg7KtAgZhlGlJZ6rBnPOCia2ujd+cfUGRNVY+m
 PfCYZaBx257vtFqqGcQmFSfydlgYnydc4DflBn1BLqSkWUm2GNy+hwEMJlMqsQqDN5/RQqLva
 74WzkZ05qicdMy8ShDExRVgM55DON94RyF/iynfmN6U6G1niHNXnhm5ICtpjN9zf6d+tFjver
 ViU2/D7vNf9i6b7AL2QUdbX266WQjQFTO82YVp7AEM7LjFiVVIp2fi74UnskEnYe6wFFSOo12
 3rqmvPr92fLefC6hgZQVIwO4I+Pcyyq8MEwXtk5ldB8I7tYB9cxQQ3qQAQMh86tzZVFfz3tFp
 og1qyui7WTGkuH1CMOf4C6fxH+Moc4jKw8yjzw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support the recently introduced gpio lookup tables for
attaching to gpio lines. So, harcoded gpio numbers aren't
needed anymore.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/input/keyboard/gpio_keys_polled.c | 167 +++++++++++++++++++++---------
 1 file changed, 119 insertions(+), 48 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index c168493..667b226 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
+#include <linux/gpio/machine.h>
 #include <linux/gpio_keys.h>
 #include <linux/property.h>
 
@@ -224,6 +225,119 @@ static void gpio_keys_polled_set_abs_params(struct input_dev *input,
 };
 MODULE_DEVICE_TABLE(of, gpio_keys_polled_of_match);
 
+static struct gpio_desc *gpio_keys_polled_get_gpiod_fwnode(
+	struct device *dev,
+	int idx,
+	const char *desc)
+{
+	struct gpio_desc *gpiod;
+	struct fwnode_handle *child;
+	int x;
+
+	/* get the idx'th child node */
+	child = device_get_next_child_node(dev, NULL);
+	while (child && x) {
+		child = device_get_next_child_node(dev, child);
+		x--;
+	}
+
+	if (!child) {
+		dev_err(dev, "missing oftree child node #%d\n", idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	gpiod = devm_fwnode_get_gpiod_from_child(dev,
+						 NULL,
+						 child,
+						 GPIOD_IN,
+						 desc);
+	if (IS_ERR(gpiod)) {
+		if (PTR_ERR(gpiod) != -EPROBE_DEFER)
+			dev_err(dev,
+				"failed to get gpio: %ld\n",
+				PTR_ERR(gpiod));
+		fwnode_handle_put(child);
+		return gpiod;
+	}
+
+	return gpiod;
+}
+
+static struct gpio_desc *gpio_keys_polled_get_gpiod_legacy(
+	struct device *dev,
+	int idx,
+	const struct gpio_keys_button *button)
+{
+	/*
+	 * Legacy GPIO number so request the GPIO here and
+	 * convert it to descriptor.
+	 */
+	unsigned int flags = GPIOF_IN;
+	struct gpio_desc *gpiod;
+	int error;
+
+	dev_info(dev, "hardcoded gpio IDs are deprecated.\n");
+
+	if (button->active_low)
+		flags |= GPIOF_ACTIVE_LOW;
+
+	error = devm_gpio_request_one(dev, button->gpio,
+			flags, button->desc ? : DRV_NAME);
+	if (error) {
+		dev_err(dev,
+			"unable to claim gpio %u, err=%d\n",
+			button->gpio, error);
+		return ERR_PTR(error);
+	}
+
+	gpiod = gpio_to_desc(button->gpio);
+	if (!gpiod) {
+		dev_err(dev,
+			"unable to convert gpio %u to descriptor\n",
+			button->gpio);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return gpiod;
+}
+
+static struct gpio_desc *gpio_keys_polled_get_gpiod(
+	struct device *dev,
+	int idx,
+	const struct gpio_keys_button *button)
+{
+	struct gpio_desc *gpiod = NULL;
+	int error;
+
+	/* No legacy static platform data - use oftree */
+	if (!dev_get_platdata(dev)) {
+		return gpio_keys_polled_get_gpiod_fwnode(
+			dev, idx, button->desc);
+	}
+
+	gpiod = devm_gpiod_get_index(dev, NULL, idx, GPIOF_IN);
+
+	if (!IS_ERR(gpiod)) {
+		dev_info(dev, "picked gpiod idx %d from gpio table\n", idx);
+		gpiod_set_consumer_name(gpiod, button->desc ? : DRV_NAME);
+		return gpiod;
+	}
+
+	if (PTR_ERR(gpiod) != -ENOENT) {
+		dev_err(dev, "failed fetching gpiod #%d: %d\n",
+			idx, PTR_ERR(gpiod));
+		return gpiod;
+	}
+
+	/* Use legacy gpio id, if defined */
+	if (gpio_is_valid(button->gpio)) {
+		return gpio_keys_polled_get_gpiod_legacy(
+			dev, idx, button);
+	}
+
+	return ERR_PTR(-ENOENT);
+}
+
 static int gpio_keys_polled_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -288,57 +402,14 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 
 		if (button->wakeup) {
 			dev_err(dev, DRV_NAME " does not support wakeup\n");
-			fwnode_handle_put(child);
 			return -EINVAL;
 		}
 
-		if (!dev_get_platdata(dev)) {
-			/* No legacy static platform data */
-			child = device_get_next_child_node(dev, child);
-			if (!child) {
-				dev_err(dev, "missing child device node\n");
-				return -EINVAL;
-			}
-
-			bdata->gpiod = devm_fwnode_get_gpiod_from_child(dev,
-								NULL, child,
-								GPIOD_IN,
-								button->desc);
-			if (IS_ERR(bdata->gpiod)) {
-				error = PTR_ERR(bdata->gpiod);
-				if (error != -EPROBE_DEFER)
-					dev_err(dev,
-						"failed to get gpio: %d\n",
-						error);
-				fwnode_handle_put(child);
-				return error;
-			}
-		} else if (gpio_is_valid(button->gpio)) {
-			/*
-			 * Legacy GPIO number so request the GPIO here and
-			 * convert it to descriptor.
-			 */
-			unsigned flags = GPIOF_IN;
-
-			if (button->active_low)
-				flags |= GPIOF_ACTIVE_LOW;
-
-			error = devm_gpio_request_one(dev, button->gpio,
-					flags, button->desc ? : DRV_NAME);
-			if (error) {
-				dev_err(dev,
-					"unable to claim gpio %u, err=%d\n",
-					button->gpio, error);
-				return error;
-			}
-
-			bdata->gpiod = gpio_to_desc(button->gpio);
-			if (!bdata->gpiod) {
-				dev_err(dev,
-					"unable to convert gpio %u to descriptor\n",
-					button->gpio);
-				return -EINVAL;
-			}
+		bdata->gpiod = gpio_keys_polled_get_gpiod(dev, i, button);
+
+		if (IS_ERR(bdata->gpiod)) {
+			dev_err(dev, "failed to fetch gpiod #%d\n", i);
+			return PTR_ERR(bdata->gpiod);
 		}
 
 		bdata->last_state = -1;
-- 
1.9.1

