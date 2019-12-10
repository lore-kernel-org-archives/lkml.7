Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B974C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DAE920836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LPVoBq1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfLJPmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:42:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34364 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbfLJPmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:42:20 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so20663418wrr.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 07:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/574D719hbFtQpR50xV1oDzZQDR7UpeMjBxjWf2LMEo=;
        b=LPVoBq1So4qyMrTR+XkJPFLk0fCI/JMo6fHIL7ZvJQFP+iF/VwW9zbcurfwdUVe/8R
         PPQIbOosvDVevQBjk2ZAN6pzCR25dQEOUz6A7Rgk02axmMl8zKYp+1PdX/62C88tqpri
         MVACKdVsGOc1XbRj+4D2Qb37NoUGdkxiJ143IpdNBaZzomoYvBTgEzpKgp6E+aiicouf
         gGrOA69XXQYSY83R8KWa0VY+9eza8BtLBzOUNfXzgcm3wTLXtF0EEVw8at4f+1bA1T/c
         mPttVS9TercNqow84ffMUOw1YDrvfXqckvTuwMNxLQDywjE4TKr6U7IkiXsZ6xJjDGgR
         UB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/574D719hbFtQpR50xV1oDzZQDR7UpeMjBxjWf2LMEo=;
        b=QBttn9MWCZfHO8DQzOhVQ2kP9uoM1n42VHqf5/7fznARVsR2BhYlpKoGBuw85zvXXK
         PMPWSdStdPOGPhdPGqgHCta9K8d+LTMqsVSAxI6+aaP7LRgUdVa9kNLmvzPCEzfi23pC
         XDLssE6NtqBw6xePVlgkTUdBxRpNT0g+zyeFcsUcjs53Y/1X4zhN06F9Yf9HB7xOraa9
         BeHp4U0ml71mPVz7uKaLGwxP94DKG7Q6zxt1B7r2TuKA9D62iQ/nFO8QfyewArgHfsFe
         b6nYQ/kDvtfMafbF4lCNUmYzGkRqFqwWNk9tRJXx55tBcjKZgieovGzYoXY3AQi/jKiq
         qqVQ==
X-Gm-Message-State: APjAAAWmXwcThYcqKLvnVPvF4kn2lkpxkdHbFjVZgPIW2unmxoDHZ4Op
        3h9ZdAykrNEkXL5p9Iq4TAd62Q==
X-Google-Smtp-Source: APXvYqyoLlaT2Ui3vB4/R0BIlcScHAbDp9A3rKt/+vQxe3CMTESCcRkjuqrLIGbffyTHZELVGhXe3A==
X-Received: by 2002:a5d:51cc:: with SMTP id n12mr4046468wrv.177.1575992539004;
        Tue, 10 Dec 2019 07:42:19 -0800 (PST)
Received: from khouloud-ThinkPad-T470p.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o7sm3469085wmc.41.2019.12.10.07.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 07:42:18 -0800 (PST)
From:   Khouloud Touil <ktouil@baylibre.com>
To:     bgolaszewski@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com, srinivas.kandagatla@linaro.org,
        baylibre-upstreaming@groups.io
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-i2c@vger.kernel.org, linus.walleij@linaro.org,
        Khouloud Touil <ktouil@baylibre.com>
Subject: [PATCH v2 4/4] eeprom: at24: remove the write-protect pin support
Date:   Tue, 10 Dec 2019 16:41:57 +0100
Message-Id: <20191210154157.21930-5-ktouil@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210154157.21930-1-ktouil@baylibre.com>
References: <20191210154157.21930-1-ktouil@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVMEM framework is an interface for the at24 EEPROMs as well as for
other drivers, instead of passing the wp-gpios over the different
drivers each time, it would be better to pass it over the NVMEM
subsystem once and for all.

Removing the support for the write-protect pin after adding it to the
NVMEM subsystem.

Signed-off-by: Khouloud Touil <ktouil@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 0681d5fdd538..8fce49a6d9cd 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -22,7 +22,6 @@
 #include <linux/nvmem-provider.h>
 #include <linux/regmap.h>
 #include <linux/pm_runtime.h>
-#include <linux/gpio/consumer.h>
 
 /* Address pointer is 16 bit. */
 #define AT24_FLAG_ADDR16	BIT(7)
@@ -89,8 +88,6 @@ struct at24_data {
 
 	struct nvmem_device *nvmem;
 
-	struct gpio_desc *wp_gpio;
-
 	/*
 	 * Some chips tie up multiple I2C addresses; dummy devices reserve
 	 * them for us, and we'll use them with SMBus calls.
@@ -457,12 +454,10 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 	 * from this host, but not from other I2C masters.
 	 */
 	mutex_lock(&at24->lock);
-	gpiod_set_value_cansleep(at24->wp_gpio, 0);
 
 	while (count) {
 		ret = at24_regmap_write(at24, buf, off, count);
 		if (ret < 0) {
-			gpiod_set_value_cansleep(at24->wp_gpio, 1);
 			mutex_unlock(&at24->lock);
 			pm_runtime_put(dev);
 			return ret;
@@ -472,7 +467,6 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 		count -= ret;
 	}
 
-	gpiod_set_value_cansleep(at24->wp_gpio, 1);
 	mutex_unlock(&at24->lock);
 
 	pm_runtime_put(dev);
@@ -662,9 +656,6 @@ static int at24_probe(struct i2c_client *client)
 	at24->client[0].client = client;
 	at24->client[0].regmap = regmap;
 
-	at24->wp_gpio = devm_gpiod_get_optional(dev, "wp", GPIOD_OUT_HIGH);
-	if (IS_ERR(at24->wp_gpio))
-		return PTR_ERR(at24->wp_gpio);
 
 	writable = !(flags & AT24_FLAG_READONLY);
 	if (writable) {
-- 
2.17.1

