Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B2AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7172075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxJAI+wr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731847AbfC0FBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:01:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41155 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbfC0FBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:01:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id f6so5225299pgs.8;
        Tue, 26 Mar 2019 22:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0I71euHhTT2+JwpcW5o8Nyy8nGlG1C3w/bjF+uE002A=;
        b=RxJAI+wrrnLYuf5zN1LqQ0NfP/sRXnHsNkAerPKlXipn3hfibBfpYNyEyXZkV27rvv
         1LEtXRdFz0qjzjnTAvIiYMA7TjHI+7o38Xb1wpFPFC4MdzacMWClpF8uQ7jJ1UssfKw1
         NB/D4Jyx2Uk4Qdb/dFms8L9Jc3b44ezmBnZYRsKGnCl4WvSJ19dj9zQRdArtaD1+95JK
         61n7uZiyp4TctN6ocARJffFWWb41MXz6CajEq9rf19Lzpxi26YPHA5faOg5po3ZiRTJ9
         fUW2GoFH5cew28D6mPeJepXDvgqNDmDzbkUeJLo1WUSS7T5dZDPknOzeL37S6/XoDpSM
         s3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0I71euHhTT2+JwpcW5o8Nyy8nGlG1C3w/bjF+uE002A=;
        b=TVsLPGcO7sgKGy8VgUMlYhKg4U9wZso/++x1oyFM5rFiQykr/I7eIbWdONor7KcEI2
         lQszT+Q/tNAS9Xt54LexJq+W6AoIMblo6c1XgkBA4S9Go0wru5cFcQ4+fxHGvQI1YsLi
         XD6B9MecB+59l1qpgyVmiGFn/RtAslWHuzVsh3eKbkZab0F2YoUM+wAhbVXCHEZchvRK
         gwKjbhw5UyaPPtThzzZvjR589BWwu6dihdHCq+4/Ig1Z3T/uLdtMTG0ufgKEiz3DnpEF
         eKaaKCYtBzhT90G8f2uqnoieFaNo7L/1vXWZmgSvYHrbaPg4rzcsTtkVOginMl+SB1cn
         EDOQ==
X-Gm-Message-State: APjAAAWSvA8Xer2o2kp/yYKLxMdosmbLBnuyFMgI9vIlgprN9JarFxWz
        FYEQZNZeDIGvNLDrlmnP5MM=
X-Google-Smtp-Source: APXvYqy8zgtoeHpZ4u2hckq1rici1mAiaKRLX+aQROjYLbCJtAExdV6KIq7Rxz2ipsv5r7oqvAD8NA==
X-Received: by 2002:aa7:82d9:: with SMTP id f25mr33179072pfn.45.1553662904075;
        Tue, 26 Mar 2019 22:01:44 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:6014:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id 143sm2358172pge.50.2019.03.26.22.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 22:01:43 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v13 10/11] gpio: 74x164: Utilize the for_each_set_clump8 macro
Date:   Wed, 27 Mar 2019 14:02:39 +0900
Message-Id: <645f16f1d1ad3f215e34a82f457e06725fcf8f56.1553661964.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1553661964.git.vilhelm.gray@gmail.com>
References: <cover.1553661964.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace verbose implementation in set_multiple callback with
for_each_set_clump8 macro to simplify code and improve clarity.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Reid <preid@electromag.com.au>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-74x164.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
index fb7b620763a2..0bbf1162bb31 100644
--- a/drivers/gpio/gpio-74x164.c
+++ b/drivers/gpio/gpio-74x164.c
@@ -9,6 +9,7 @@
  *  published by the Free Software Foundation.
  */
 
+#include <linux/bitops.h>
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/spi/spi.h>
@@ -75,20 +76,18 @@ static void gen_74x164_set_multiple(struct gpio_chip *gc, unsigned long *mask,
 				    unsigned long *bits)
 {
 	struct gen_74x164_chip *chip = gpiochip_get_data(gc);
-	unsigned int i, idx, shift;
-	u8 bank, bankmask;
+	unsigned long offset;
+	unsigned long bankmask;
+	size_t bank;
+	unsigned long bitmask;
 
 	mutex_lock(&chip->lock);
-	for (i = 0, bank = chip->registers - 1; i < chip->registers;
-	     i++, bank--) {
-		idx = i / sizeof(*mask);
-		shift = i % sizeof(*mask) * BITS_PER_BYTE;
-		bankmask = mask[idx] >> shift;
-		if (!bankmask)
-			continue;
+	for_each_set_clump8(offset, bankmask, mask, chip->registers * 8) {
+		bank = (chip->registers - 1) - (offset / 8);
+		bitmask = bitmap_get_value8(bits, offset) & bankmask;
 
 		chip->buffer[bank] &= ~bankmask;
-		chip->buffer[bank] |= bankmask & (bits[idx] >> shift);
+		chip->buffer[bank] |= bitmask;
 	}
 	__gen_74x164_write_config(chip);
 	mutex_unlock(&chip->lock);
-- 
2.21.0

