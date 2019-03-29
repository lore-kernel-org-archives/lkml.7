Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E716EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BE72184D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9tVVjx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbfC2DEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 23:04:13 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38060 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbfC2DEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 23:04:13 -0400
Received: by mail-pl1-f196.google.com with SMTP id g37so310133plb.5;
        Thu, 28 Mar 2019 20:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tvDsEaR5RVMjQmpl7pvXE6aMRh7V9pplB1t4MlLyGlo=;
        b=l9tVVjx+aEWiEWC6CwVS8J3GwCm51Rj2E6HqC9eJnyGCQUIh1MVdSqhjsZHnms2Iv7
         MLz7B5w9G7FiDgSk74g6rnzWp+vLSZoE0Fyr1t/o2BuV8k47BIkWFFRqAfNAFDGIaxJK
         eD6tAPsMqSYyRpK5mAI/xWBO2dYr6acNmqeJDC7KOSEmKNhRtKUAgFjGrQ3Wq23pdxcL
         6ILzXpCZmdVCCgYxJJ8cz8aczA0V5SHcqFzRXYeZlM2KHaM2FDXV4KnKAmxaMhbbnfwm
         wyY/x21zKwLH95FtVlVPc6+h1mZAkfhGXRGFSFTBy+UpQ72k+W3NkVXg8wLK5Sf8vAQ8
         U9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tvDsEaR5RVMjQmpl7pvXE6aMRh7V9pplB1t4MlLyGlo=;
        b=T3/o5MrjBbz1DiXFXWGmtuG6TFGhIj0tvqwxNAUTZKjr8/VOK+eKlK//Mk0NvZi+pw
         negt2M773S2uKFQ2Ks8dmjugrBA4pHsxop9tyco4s007Xk9YL97zeJ7saggw4TL67jXC
         IMgPCbCFpdGtC8C0BBdgEQPq6mPWM4ZvZewyWxR7xlHB1eNQmCsI+F2N8ytFrU7WJJsR
         wUMAfR0gnDuLaHkzqk7IdpLUg6IXmOJ3hKz4jpe4bOkGCeitsMh9yFOLXqZEn8GYApjk
         E6BxJM7Yfw054D7jYmfdoMqCR08qbCRWLEp/L/Q4VMLsZLc2k/WSjO7i5jr5VB+zCskY
         48+w==
X-Gm-Message-State: APjAAAW1xm1KQMARctywHPIXfKM4UhLNDeX7K8YVowKcVN+2kfp64FNx
        Kf17gR4MWEw/GkkZSum9k9c=
X-Google-Smtp-Source: APXvYqym6fvwUFI7HLO94yJuUsFZUzM1NU578GYk1TBDaZRuCZbhNmpJ6GxLnFhCX7imUSSTS+8EqA==
X-Received: by 2002:a17:902:a714:: with SMTP id w20mr47383803plq.331.1553828652412;
        Thu, 28 Mar 2019 20:04:12 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:ba2:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id m67sm739087pfj.70.2019.03.28.20.04.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 20:04:11 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v14 04/11] gpio: 104-idi-48: Utilize for_each_set_clump8 macro
Date:   Fri, 29 Mar 2019 12:05:07 +0900
Message-Id: <6523418679ed2a9dc3d9b955891623313ca01f55.1553828158.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1553828158.git.vilhelm.gray@gmail.com>
References: <cover.1553828158.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace verbose implementation in get_multiple/set_multiple callbacks
with for_each_set_clump8 macro to simplify code and improve clarity.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-104-idi-48.c | 36 +++++++---------------------------
 1 file changed, 7 insertions(+), 29 deletions(-)

diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index 88dc6f2449f6..9b43964b0412 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -93,42 +93,20 @@ static int idi_48_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	unsigned long *bits)
 {
 	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
-	size_t i;
+	unsigned long offset;
+	unsigned long gpio_mask;
 	static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
-	const unsigned int gpio_reg_size = 8;
-	unsigned int bits_offset;
-	size_t word_index;
-	unsigned int word_offset;
-	unsigned long word_mask;
-	const unsigned long port_mask = GENMASK(gpio_reg_size - 1, 0);
+	unsigned int port_addr;
 	unsigned long port_state;
 
 	/* clear bits array to a clean slate */
 	bitmap_zero(bits, chip->ngpio);
 
-	/* get bits are evaluated a gpio port register at a time */
-	for (i = 0; i < ARRAY_SIZE(ports); i++) {
-		/* gpio offset in bits array */
-		bits_offset = i * gpio_reg_size;
+	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+		port_addr = idi48gpio->base + ports[offset / 8];
+		port_state = inb(port_addr) & gpio_mask;
 
-		/* word index for bits array */
-		word_index = BIT_WORD(bits_offset);
-
-		/* gpio offset within current word of bits array */
-		word_offset = bits_offset % BITS_PER_LONG;
-
-		/* mask of get bits for current gpio within current word */
-		word_mask = mask[word_index] & (port_mask << word_offset);
-		if (!word_mask) {
-			/* no get bits in this port so skip to next one */
-			continue;
-		}
-
-		/* read bits from current gpio port */
-		port_state = inb(idi48gpio->base + ports[i]);
-
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= (port_state << word_offset) & word_mask;
+		bitmap_set_value8(bits, port_state, offset);
 	}
 
 	return 0;
-- 
2.21.0

