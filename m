Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F55C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D6E24682
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="lhPHcab9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfLSRQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:16:03 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53404 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfLSRPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:15:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id m24so6226053wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 09:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=izVdkb3B6fuklcEw/hV1XUazbmANjGDXpj//MuY0JEw=;
        b=lhPHcab9tWEUpr5zez2HKjQULIQKo5Si2e1x7Ov5RzMbFYiz2ld3ou8VTSix91i5UX
         IDWTvCrSzIXZMaOzLI52k9Kgl9pk6obwrzpD/1ep0EqDKZK5Xs0ZM3nuE2F407PI/0qb
         QH1NCPnFgNRIRVLwkHZPzSEUyTOPfIZpew1PFSmh3ZLFxuGIk79cOo2PjhUza9Du4b96
         WUcirheee76Zp4T19y53VKSGb1iKmBeuNInZXEqCsNJRVcPabXN0gTSAJDM289TJll6G
         mcgr9KW8H8W8f3bWSkfSpro7M7Bm2RioYzmlI+xB3pii+B86eLxRGxo2V/GPDeKZEN3o
         Q4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=izVdkb3B6fuklcEw/hV1XUazbmANjGDXpj//MuY0JEw=;
        b=Os5EibTggyhJ19eDdFbM4e8GPvfZ8dsCK1LpMh44f6xrgt/inotMf1h5DHJQTHUvFF
         qR5bIQ8yHk+whmhOalnbXmEU5jHk1sHCztPAQ+jbt50aB2Hcv9l1V3q1IeEo3lgRVFtc
         e0bo32OCGhyZJVGkoTN9KcWM3mkMVHkUo7920fsdZ1MrRb8G5c7w9xGQJ3ieJGNVgsrw
         DQjK2aBgrRVnD2Gw3i58QCLmedpmz/VJy+MTh5QPQDntRS3b5gyPluTE5Zqeez9hsxE1
         2B2i8X5sCqa53Q28O7zwc8/jQIh4ehrGNI+jFP0ZaU5CPOx0/2rU1YQLC3PLFZn0L3II
         DwXA==
X-Gm-Message-State: APjAAAVfeqXmb+Tpf7k0T+/KqN0Gn2BUw6EpFRp8lkGPE6BPmq5n//cX
        +BwXWJoTgjWVQU49IsQrRyj66g==
X-Google-Smtp-Source: APXvYqwwdo1gvGGraneMABLw6o9frhqNZr1r88X2HztSEReoffhx/278goQehYKrJ8cm1UbA7+AIlA==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr11451806wmi.0.1576775747685;
        Thu, 19 Dec 2019 09:15:47 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id q6sm7401428wrx.72.2019.12.19.09.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 09:15:46 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 11/13] gpiolib: provide a dedicated function for setting lineinfo
Date:   Thu, 19 Dec 2019 18:15:26 +0100
Message-Id: <20191219171528.6348-12-brgl@bgdev.pl>
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

We'll soon be filling out the gpioline_info structure in multiple
places. Add a separate function that given a gpio_desc sets all relevant
fields.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpiolib.c | 98 ++++++++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 43 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e27cf2113fed..41abf17640de 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1149,6 +1149,60 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	return ret;
 }
 
+static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
+				  struct gpioline_info *info)
+{
+	struct gpio_chip *chip = desc->gdev->chip;
+	unsigned long flags;
+
+	spin_lock_irqsave(&gpio_lock, flags);
+
+	if (desc->name) {
+		strncpy(info->name, desc->name, sizeof(info->name));
+		info->name[sizeof(info->name) - 1] = '\0';
+	} else {
+		info->name[0] = '\0';
+	}
+
+	if (desc->label) {
+		strncpy(info->consumer, desc->label, sizeof(info->consumer));
+		info->consumer[sizeof(info->consumer) - 1] = '\0';
+	} else {
+		info->consumer[0] = '\0';
+	}
+
+	/*
+	 * Userspace only need to know that the kernel is using this GPIO so
+	 * it can't use it.
+	 */
+	info->flags = 0;
+	if (test_bit(FLAG_REQUESTED, &desc->flags) ||
+	    test_bit(FLAG_IS_HOGGED, &desc->flags) ||
+	    test_bit(FLAG_USED_AS_IRQ, &desc->flags) ||
+	    test_bit(FLAG_EXPORT, &desc->flags) ||
+	    test_bit(FLAG_SYSFS, &desc->flags) ||
+	    !pinctrl_gpio_can_use_line(chip->base + info->line_offset))
+		info->flags |= GPIOLINE_FLAG_KERNEL;
+	if (test_bit(FLAG_IS_OUT, &desc->flags))
+		info->flags |= GPIOLINE_FLAG_IS_OUT;
+	if (test_bit(FLAG_ACTIVE_LOW, &desc->flags))
+		info->flags |= GPIOLINE_FLAG_ACTIVE_LOW;
+	if (test_bit(FLAG_OPEN_DRAIN, &desc->flags))
+		info->flags |= (GPIOLINE_FLAG_OPEN_DRAIN |
+				GPIOLINE_FLAG_IS_OUT);
+	if (test_bit(FLAG_OPEN_SOURCE, &desc->flags))
+		info->flags |= (GPIOLINE_FLAG_OPEN_SOURCE |
+				GPIOLINE_FLAG_IS_OUT);
+	if (test_bit(FLAG_BIAS_DISABLE, &desc->flags))
+		info->flags |= GPIOLINE_FLAG_BIAS_DISABLE;
+	if (test_bit(FLAG_PULL_DOWN, &desc->flags))
+		info->flags |= GPIOLINE_FLAG_BIAS_PULL_DOWN;
+	if (test_bit(FLAG_PULL_UP, &desc->flags))
+		info->flags |= GPIOLINE_FLAG_BIAS_PULL_UP;
+
+	spin_unlock_irqrestore(&gpio_lock, flags);
+}
+
 /*
  * gpio_ioctl() - ioctl handler for the GPIO chardev
  */
@@ -1189,49 +1243,7 @@ static long gpio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		if (IS_ERR(desc))
 			return PTR_ERR(desc);
 
-		if (desc->name) {
-			strncpy(lineinfo.name, desc->name,
-				sizeof(lineinfo.name));
-			lineinfo.name[sizeof(lineinfo.name)-1] = '\0';
-		} else {
-			lineinfo.name[0] = '\0';
-		}
-		if (desc->label) {
-			strncpy(lineinfo.consumer, desc->label,
-				sizeof(lineinfo.consumer));
-			lineinfo.consumer[sizeof(lineinfo.consumer)-1] = '\0';
-		} else {
-			lineinfo.consumer[0] = '\0';
-		}
-
-		/*
-		 * Userspace only need to know that the kernel is using
-		 * this GPIO so it can't use it.
-		 */
-		lineinfo.flags = 0;
-		if (test_bit(FLAG_REQUESTED, &desc->flags) ||
-		    test_bit(FLAG_IS_HOGGED, &desc->flags) ||
-		    test_bit(FLAG_USED_AS_IRQ, &desc->flags) ||
-		    test_bit(FLAG_EXPORT, &desc->flags) ||
-		    test_bit(FLAG_SYSFS, &desc->flags) ||
-		    !pinctrl_gpio_can_use_line(chip->base + lineinfo.line_offset))
-			lineinfo.flags |= GPIOLINE_FLAG_KERNEL;
-		if (test_bit(FLAG_IS_OUT, &desc->flags))
-			lineinfo.flags |= GPIOLINE_FLAG_IS_OUT;
-		if (test_bit(FLAG_ACTIVE_LOW, &desc->flags))
-			lineinfo.flags |= GPIOLINE_FLAG_ACTIVE_LOW;
-		if (test_bit(FLAG_OPEN_DRAIN, &desc->flags))
-			lineinfo.flags |= (GPIOLINE_FLAG_OPEN_DRAIN |
-					   GPIOLINE_FLAG_IS_OUT);
-		if (test_bit(FLAG_OPEN_SOURCE, &desc->flags))
-			lineinfo.flags |= (GPIOLINE_FLAG_OPEN_SOURCE |
-					   GPIOLINE_FLAG_IS_OUT);
-		if (test_bit(FLAG_BIAS_DISABLE, &desc->flags))
-			lineinfo.flags |= GPIOLINE_FLAG_BIAS_DISABLE;
-		if (test_bit(FLAG_PULL_DOWN, &desc->flags))
-			lineinfo.flags |= GPIOLINE_FLAG_BIAS_PULL_DOWN;
-		if (test_bit(FLAG_PULL_UP, &desc->flags))
-			lineinfo.flags |= GPIOLINE_FLAG_BIAS_PULL_UP;
+		gpio_desc_to_lineinfo(desc, &lineinfo);
 
 		if (copy_to_user(ip, &lineinfo, sizeof(lineinfo)))
 			return -EFAULT;
-- 
2.23.0

