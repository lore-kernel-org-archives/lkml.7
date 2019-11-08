Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06127C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F9C215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214836;
	bh=P4rExky2npgISVzRQqzkSOojSANeuOI8O1f1A/oAhMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qn0GrSdULpBg3wJKNra44JdL+vfso+V+Jw5slmeb6n/veb5tBh9PUy/At8THRT9hX
	 ZJ2MOMTS3r+URvkureWfH/kMQYo/nRbIWGdHA4Rhdm938subTyEpMAc050G9wubxtB
	 PwNmGzwrbj7EgQmHvkZiBN6zKqbD6sIGZriF3vM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391864AbfKHMHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:07:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:54098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389104AbfKHLlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:41:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB27921D7F;
        Fri,  8 Nov 2019 11:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213259;
        bh=P4rExky2npgISVzRQqzkSOojSANeuOI8O1f1A/oAhMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yxurgVqGhoFaWtpav6d0MvrKLUvmCpsfsQTB4dsRr9IuJtyPW7TCqzDpKYvbp/Jzp
         ja7k3tNauJjmAO5A028hXx3sXUskOkTKuySTDQ0+1SB3q6Ic2/6BiiNXOh8GjVT0K/
         yyG3Pkk0Yl+DDJF75oce0QylElqBYv8zqTIHHEwc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 124/205] gpio: of: Handle SPI chipselect legacy bindings
Date:   Fri,  8 Nov 2019 06:36:31 -0500
Message-Id: <20191108113752.12502-124-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit 6953c57ab1721ce57914fc5741d0ce0568756bb0 ]

The SPI chipselects are assumed to be active low in the current
binding, so when we want to use GPIO descriptors and handle
the active low/high semantics in gpiolib, we need a special
parsing quirk to deal with this.

We check for the property "spi-cs-high" and if that is
NOT present we assume the CS line is active low.

If the line is tagged as active low in the device tree and
has no "spi-cs-high" property all is fine, the device
tree and the SPI bindings are in agreement.

If the line is tagged as active high in the device tree with
the second cell flag and has no "spi-cs-high" property we
enforce active low semantics (as this is the exception we can
just tag on the flag).

If the line is tagged as active low with the second cell flag
AND tagged with "spi-cs-high" the SPI active high property
takes precedence and we print a warning.

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib-of.c | 50 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index e0f149bdf98ff..fa212c2a7577c 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -58,7 +58,8 @@ static struct gpio_desc *of_xlate_and_get_gpiod_flags(struct gpio_chip *chip,
 }
 
 static void of_gpio_flags_quirks(struct device_node *np,
-				 enum of_gpio_flags *flags)
+				 enum of_gpio_flags *flags,
+				 int index)
 {
 	/*
 	 * Some GPIO fixed regulator quirks.
@@ -92,6 +93,51 @@ static void of_gpio_flags_quirks(struct device_node *np,
 		pr_info("%s uses legacy open drain flag - update the DTS if you can\n",
 			of_node_full_name(np));
 	}
+
+	/*
+	 * Legacy handling of SPI active high chip select. If we have a
+	 * property named "cs-gpios" we need to inspect the child node
+	 * to determine if the flags should have inverted semantics.
+	 */
+	if (IS_ENABLED(CONFIG_SPI_MASTER) &&
+	    of_property_read_bool(np, "cs-gpios")) {
+		struct device_node *child;
+		u32 cs;
+		int ret;
+
+		for_each_child_of_node(np, child) {
+			ret = of_property_read_u32(child, "reg", &cs);
+			if (!ret)
+				continue;
+			if (cs == index) {
+				/*
+				 * SPI children have active low chip selects
+				 * by default. This can be specified negatively
+				 * by just omitting "spi-cs-high" in the
+				 * device node, or actively by tagging on
+				 * GPIO_ACTIVE_LOW as flag in the device
+				 * tree. If the line is simultaneously
+				 * tagged as active low in the device tree
+				 * and has the "spi-cs-high" set, we get a
+				 * conflict and the "spi-cs-high" flag will
+				 * take precedence.
+				 */
+				if (of_property_read_bool(np, "spi-cs-high")) {
+					if (*flags & OF_GPIO_ACTIVE_LOW) {
+						pr_warn("%s GPIO handle specifies active low - ignored\n",
+							of_node_full_name(np));
+						*flags &= ~OF_GPIO_ACTIVE_LOW;
+					}
+				} else {
+					if (!(*flags & OF_GPIO_ACTIVE_LOW))
+						pr_info("%s enforce active low on chipselect handle\n",
+							of_node_full_name(np));
+					*flags |= OF_GPIO_ACTIVE_LOW;
+				}
+				break;
+			}
+		}
+	}
 }
 
 /**
@@ -132,7 +178,7 @@ struct gpio_desc *of_get_named_gpiod_flags(struct device_node *np,
 		goto out;
 
 	if (flags)
-		of_gpio_flags_quirks(np, flags);
+		of_gpio_flags_quirks(np, flags, index);
 
 	pr_debug("%s: parsed '%s' property of node '%pOF[%d]' - status (%d)\n",
 		 __func__, propname, np, index,
-- 
2.20.1

