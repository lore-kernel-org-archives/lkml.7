Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2457C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D712068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="pis+WSuj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfK0Nfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 08:35:52 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51149 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfK0NfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 08:35:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id l17so7141841wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 05:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2P46jLQH53L0bSs7wrWGmrID6nlk6qTfagoHAkQM3lw=;
        b=pis+WSujWhUrHbUSxEjqy+CteEBYETKcGNz1PPsBUwdelFBzIJsqHC6DK6LCxi2sX5
         8y+yxV2OxIBVMqSyDeaZkAf6oJ7UAC6ZKN+6g3sX6DvS7hjGPizDrVC0iDxjNTF4a821
         XuCnnkb11iBH2MEQkslYBZXwZQxWEPfxAKAFL8y96rjOoJg3AcK0NCZkgutVPUgy/EBD
         3sEV4pBB5dtkUtWSOANCeEn5AyBfXpVsF2Fj97o8Jv5N8ERtJyXA/W1LoXP2gtiX4XFc
         90q7jYbo0M1mr1lwD7ZddtukCW2VaultR7wSKU4AijYQlCn+Tk00RfPUQUJ5gnMJm1Nd
         JqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2P46jLQH53L0bSs7wrWGmrID6nlk6qTfagoHAkQM3lw=;
        b=aFv0+6jtBzOyBkE7FPJ7KXNN4mENqMzwCpmoUcqBpYN3J0yspR97BKXFw0khgN+IQc
         Rm1Ap+OMq2Q45kSaLHLtrVgXCAg3NT9BxvjZaM1TERtqeDaZcg4PFYWrhlFfzNqUDxfu
         5zIuJBxgB471V2crNwQBDgtFkPjZE+iMBVk+7fXJTY78FDpXuKlZtvCqcaz/yPI7PIOL
         I34OEJYbjtb/X/zpSNz+e3OpiKyz0W61C5iyIWzRWu5A/h7hzhSbPLLYNXgVRBIKrKav
         N0SkS84znQ0kJiGrgmPgGHckTToVS3PpxxBC9oOsWHKARMy2J0Zye9CWSkKD+xjL06fS
         e02A==
X-Gm-Message-State: APjAAAWo8bYXNH0ZMRvi2qS5UU1xcY0lIGel4qtrrDdrztu/AMBlmasS
        zeGa8/069VFnbdncTx2MnJTFL1qL6fc=
X-Google-Smtp-Source: APXvYqxNHEQ3gduCM+/d0RgzRf59h2m41Rc2S1Xg84Jafi8b54BlM4BnhgVxnHHx33/RmCH93xzIcw==
X-Received: by 2002:a1c:560b:: with SMTP id k11mr4710274wmb.153.1574861723165;
        Wed, 27 Nov 2019 05:35:23 -0800 (PST)
Received: from debian-brgl.home (lfbn-1-7087-108.w90-116.abo.wanadoo.fr. [90.116.255.108])
        by smtp.gmail.com with ESMTPSA id k18sm19663687wrm.82.2019.11.27.05.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 05:35:22 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 3/8] gpiolib: convert the type of hwnum to unsigned int in gpiochip_get_desc()
Date:   Wed, 27 Nov 2019 14:35:05 +0100
Message-Id: <20191127133510.10614-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191127133510.10614-1-brgl@bgdev.pl>
References: <20191127133510.10614-1-brgl@bgdev.pl>
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

