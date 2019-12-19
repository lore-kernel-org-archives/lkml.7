Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F09FC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2435224679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="SWPQN6U5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfLSRPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:15:43 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40098 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbfLSRPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:15:39 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so6432148wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 09:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XhiSom0iVO5AHRS5ZUjMyBcC2AAQ3b6I6WYo2HMzPrk=;
        b=SWPQN6U52q64ZPmqFofySJ402F+H0ckaDHl99RXhe/e2LryuutBlW6t+dABXiDAhFe
         QJPJx/w5IjIIhfP2oEGkB//h2+TWYEcLNBOcOUOU4Jz12ml54NanVvwcsNHLXITUzMSP
         m049gzgohL4S579+RX136l3jd/9UwjBewrdlLOn/o+KbFwasTlukpH8xERZoXQPcuQ6+
         +TU7TF53TVQ03wpSSJf08n0PkvV1p9/qUOddg4uvymTXTKis3AD256c5VBlKFD63KmHS
         d8Qnhh5rWpQmmbT5rzyFfi4tC2eYLR5PbIosb+0q3JzVknLsdcU8WE9KlqxhhfWFkU0E
         Pe5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XhiSom0iVO5AHRS5ZUjMyBcC2AAQ3b6I6WYo2HMzPrk=;
        b=oY1NS7CiLa3LWlD47Ag/tEherw/MJJDlCs9ZFiWzBHCz8cLTZcExFJeclkcxOipSBs
         GgxdCz6dtaQMXvp8Qms33hm96BMVsT/YV/JinT+gtUYdpxhIzKeLjUNiZLHgAnrQLIh3
         Zat+G2RLNet7y8M+3o4PHdxBlz/uEW4cpIl2x3qmRJGb8ahm+YNat6fI4lHrCd6Fmalc
         mJICQHmkmZnEWvQ35cwn3M2Lic0mIFV2bjqUL0JEpGROKGglptaSECWB3+2OF1H3eYDn
         2SrkqvqgxdM11Lrp/I83BM+aHvRApQPd5Rx0awaUNVvdwbd2W99Kt/DojTGEgbL9VQpe
         fVgw==
X-Gm-Message-State: APjAAAX7wMnFwfM53/EKG0KnNjCtsXt8sb3Xl21Z+BSisL5VhYEBXiu3
        VJGtoIInAObaGl8JCXNb6tMoYQ==
X-Google-Smtp-Source: APXvYqwE6tJDR5YKpKGyKSmR7DJqhpeUc9tFwjGGXDRfmjIokbxHVco+zkNTNvsbYfDHAgfdyiDTwA==
X-Received: by 2002:a05:600c:2218:: with SMTP id z24mr11302607wml.50.1576775738540;
        Thu, 19 Dec 2019 09:15:38 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id q6sm7401428wrx.72.2019.12.19.09.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 09:15:38 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 03/13] gpiolib: convert the type of hwnum to unsigned int in gpiochip_get_desc()
Date:   Thu, 19 Dec 2019 18:15:18 +0100
Message-Id: <20191219171528.6348-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191219171528.6348-1-brgl@bgdev.pl>
References: <20191219171528.6348-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

gpiochip_get_desc() takes a u16 hwnum, but it turns out most users don't
respect that and usually pass an unsigned int. Since implicit casting to
a smaller type is dangerous - let's change the type of hwnum to unsigned
int in gpiochip_get_desc() and in gpiochip_request_own_desc() where the
size of hwnum is not respected either and who's a user of the former.

This is safe as we then check the hwnum against the number of lines
before proceeding in gpiochip_get_desc().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/gpio/gpiolib.c      | 5 +++--
 drivers/gpio/gpiolib.h      | 3 ++-
 include/linux/gpio/driver.h | 3 ++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 72211407469f..b3ffb079e323 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -140,7 +140,7 @@ EXPORT_SYMBOL_GPL(gpio_to_desc);
  * in the given chip for the specified hardware number.
  */
 struct gpio_desc *gpiochip_get_desc(struct gpio_chip *chip,
-				    u16 hwnum)
+				    unsigned int hwnum)
 {
 	struct gpio_device *gdev = chip->gpiodev;
 
@@ -2990,7 +2990,8 @@ EXPORT_SYMBOL_GPL(gpiochip_is_requested);
  * A pointer to the GPIO descriptor, or an ERR_PTR()-encoded negative error
  * code on failure.
  */
-struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *chip, u16 hwnum,
+struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *chip,
+					    unsigned int hwnum,
 					    const char *label,
 					    enum gpio_lookup_flags lflags,
 					    enum gpiod_flags dflags)
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index ca9bc1e4803c..a1cbeabadc69 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -78,7 +78,8 @@ struct gpio_array {
 	unsigned long		invert_mask[];
 };
 
-struct gpio_desc *gpiochip_get_desc(struct gpio_chip *chip, u16 hwnum);
+struct gpio_desc *gpiochip_get_desc(struct gpio_chip *chip,
+				    unsigned int hwnum);
 int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 				  unsigned int array_size,
 				  struct gpio_desc **desc_array,
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index e2480ef94c55..4f032de10bae 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -715,7 +715,8 @@ gpiochip_remove_pin_ranges(struct gpio_chip *chip)
 
 #endif /* CONFIG_PINCTRL */
 
-struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *chip, u16 hwnum,
+struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *chip,
+					    unsigned int hwnum,
 					    const char *label,
 					    enum gpio_lookup_flags lflags,
 					    enum gpiod_flags dflags);
-- 
2.23.0

