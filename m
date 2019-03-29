Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAACC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D12A21871
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLbSzD3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfC2DEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 23:04:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41097 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfC2DEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 23:04:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id 188so327822pfd.8;
        Thu, 28 Mar 2019 20:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qhXdbnOxR8IcT7b6oZcrLksWSW3Riv+VrvVQHErm2EM=;
        b=fLbSzD3w3zCgtresbccjv/SejzzXYViVr+zkBe1DiQmO89fKWqn/mAeiiYjXCimeSP
         DqABINzeipztDrT27cJeViqsCO6J1dkeYWvQYo14JyzJG9lW9RjwwUtCWMwqVz1PgYqL
         xeG+6kk2xKOPeGFQwqPY0L/Ram6uom9RAcvYUh2ktDWO76F6PX1LY2Gs3NFEMhTjEOXt
         G7ipG+F+cO6frL3PvLCJZu44NgZIQRl36c3prQQARz3IaTM9fKKZMMP89bfUYLNed43J
         ZpxAEgvwKUC2dyVxssM57XDJ0cNNfIAFUhcxqPGzICt0snTQPBPJrS94LUVmM6rxh6Ah
         xMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qhXdbnOxR8IcT7b6oZcrLksWSW3Riv+VrvVQHErm2EM=;
        b=uh0UGojpdqe8yaqqu+X0y0iAXmDKq8S5Df83+LEG4hIjxPiERd7ZwpCiJqqbWZjUIN
         489gnOjptTvEmIB1ZwD9DVa91oALAjWgoukEioAuSFPv/ZBzDo0cPdys1EUgTljsd+pJ
         emIpgwnO1VMqxG/qUVdlzeG/+wh6YX+Vhz8XsQ7TGFGb+in4APjiPeqPUjrbtIidjuLe
         IimjA25bYuzUHB67jxh/Pd6T7rfCH1RrivlAv4JIyx9uqVLojG13d9xBrEN5J3cRUPvn
         +jXbbqgG7Og6ukI91/m4WWMd8Cm2lx9SwzHSPDSE2Tun6HFVf2QR5VapHsWvuWFTcrph
         JYOg==
X-Gm-Message-State: APjAAAWfaJ7uzaBj8/nTkv/Mgdh4veuxA4GkLXHp3UMPu7L/WrN/8gLO
        siPOd5ei0izeM8eEIbcfoDU=
X-Google-Smtp-Source: APXvYqwEdUIKM8m/0l5GnoFIXn1qzN2MOFWQVLlE07qz/5yaqaCI03QDf3s9nSzN+fSks9UMZDnL+A==
X-Received: by 2002:a63:c505:: with SMTP id f5mr40071923pgd.87.1553828691857;
        Thu, 28 Mar 2019 20:04:51 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:ba2:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id d11sm648622pgq.6.2019.03.28.20.04.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 20:04:51 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v14 06/11] gpio: ws16c48: Utilize for_each_set_clump8 macro
Date:   Fri, 29 Mar 2019 12:05:48 +0900
Message-Id: <abe7941afe4ad5adde6fbed242ed5d4825132e8d.1553828158.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-ws16c48.c | 73 ++++++++++---------------------------
 1 file changed, 20 insertions(+), 53 deletions(-)

diff --git a/drivers/gpio/gpio-ws16c48.c b/drivers/gpio/gpio-ws16c48.c
index 5cf3697bfb15..ee30417d6394 100644
--- a/drivers/gpio/gpio-ws16c48.c
+++ b/drivers/gpio/gpio-ws16c48.c
@@ -134,42 +134,19 @@ static int ws16c48_gpio_get_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct ws16c48_gpio *const ws16c48gpio = gpiochip_get_data(chip);
-	const unsigned int gpio_reg_size = 8;
-	size_t i;
-	const size_t num_ports = chip->ngpio / gpio_reg_size;
-	unsigned int bits_offset;
-	size_t word_index;
-	unsigned int word_offset;
-	unsigned long word_mask;
-	const unsigned long port_mask = GENMASK(gpio_reg_size - 1, 0);
+	unsigned long offset;
+	unsigned long gpio_mask;
+	unsigned int port_addr;
 	unsigned long port_state;
 
 	/* clear bits array to a clean slate */
 	bitmap_zero(bits, chip->ngpio);
 
-	/* get bits are evaluated a gpio port register at a time */
-	for (i = 0; i < num_ports; i++) {
-		/* gpio offset in bits array */
-		bits_offset = i * gpio_reg_size;
+	for_each_set_clump8(offset, gpio_mask, mask, chip->ngpio) {
+		port_addr = ws16c48gpio->base + offset / 8;
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
-		port_state = inb(ws16c48gpio->base + i);
-
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= (port_state << word_offset) & word_mask;
+		bitmap_set_value8(bits, port_state, offset);
 	}
 
 	return 0;
@@ -203,39 +180,29 @@ static void ws16c48_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct ws16c48_gpio *const ws16c48gpio = gpiochip_get_data(chip);
-	unsigned int i;
-	const unsigned int gpio_reg_size = 8;
-	unsigned int port;
-	unsigned int iomask;
-	unsigned int bitmask;
+	unsigned long offset;
+	unsigned long gpio_mask;
+	size_t index;
+	unsigned int port_addr;
+	unsigned long bitmask;
 	unsigned long flags;
 
-	/* set bits are evaluated a gpio register size at a time */
-	for (i = 0; i < chip->ngpio; i += gpio_reg_size) {
-		/* no more set bits in this mask word; skip to the next word */
-		if (!mask[BIT_WORD(i)]) {
-			i = (BIT_WORD(i) + 1) * BITS_PER_LONG - gpio_reg_size;
-			continue;
-		}
-
-		port = i / gpio_reg_size;
+	for_each_set_clump8(offset, gpio_mask, mask, chip->ngpio) {
+		index = offset / 8;
+		port_addr = ws16c48gpio->base + index;
 
 		/* mask out GPIO configured for input */
-		iomask = mask[BIT_WORD(i)] & ~ws16c48gpio->io_state[port];
-		bitmask = iomask & bits[BIT_WORD(i)];
+		gpio_mask &= ~ws16c48gpio->io_state[index];
+		bitmask = bitmap_get_value8(bits, offset) & gpio_mask;
 
 		raw_spin_lock_irqsave(&ws16c48gpio->lock, flags);
 
 		/* update output state data and set device gpio register */
-		ws16c48gpio->out_state[port] &= ~iomask;
-		ws16c48gpio->out_state[port] |= bitmask;
-		outb(ws16c48gpio->out_state[port], ws16c48gpio->base + port);
+		ws16c48gpio->out_state[index] &= ~gpio_mask;
+		ws16c48gpio->out_state[index] |= bitmask;
+		outb(ws16c48gpio->out_state[index], port_addr);
 
 		raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
-
-		/* prepare for next gpio register set */
-		mask[BIT_WORD(i)] >>= gpio_reg_size;
-		bits[BIT_WORD(i)] >>= gpio_reg_size;
 	}
 }
 
-- 
2.21.0

