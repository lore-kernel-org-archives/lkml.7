Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBD1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE2D20811
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGDM1WXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbfCYGXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:23:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41704 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729587AbfCYGXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:23:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id f6so1619215pgs.8;
        Sun, 24 Mar 2019 23:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rgWDXyitkPfkOwvJZbjg9H8+KzeLJbUpGMI+NATW6JM=;
        b=IGDM1WXrWs00QprYpjPDFyUpmB34OuNPGF2aow50mUHQq6jonCNZIpq6ezMWAkOPLP
         zMSuapjbXeiBcey6Mr8Vp4Ltn22LVSceVltgjtgqurQ3kb/xMCVvl+NtpS41dOjVNOAF
         lXG6lOVi0EWO1BdzsTYnk391w8ZwnQIQXz1R8DFisoUVCgPgIN09WiMl6C/mxcEWkUYY
         nUt7gu660HsIZvvGOZeFwYXOJmu25cKXQMFt5Xsen2mKRYsvVmAbjS2Dshd4o1F6M7Jz
         meKz1GOLXkCbenDZI5tzwiAYiVw/E9gDxxy3LToKMPjHkzVlXtHa01jZFnsWNTM847al
         ofoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rgWDXyitkPfkOwvJZbjg9H8+KzeLJbUpGMI+NATW6JM=;
        b=FJgAJeLL6yueqNrLHpqopMOhVBnKi2LaoX9fUMj4ih5aSlxkh1qCd/Z1T7taxkPPh9
         lslRpE54qanobGNk5kEdVkGU7T0usfCqBKswa40936SYeFvca6arh0LMF/PeKMopXuR/
         3xu7+ujrf/hllHe9M/ZSm65Toap6lAVcnZA98hRzg36JSUlY25VqdGCAfEBSTadukBJV
         j7FY4ZKU/M4QOcqF1t3vSHB1tCHDyy8MWzBQLESOCYCiMVquLG+0+M+zwMmTPAU4cKfX
         Z1rZsvUdUZZYWpKDnPZSy+a3jfcDNXTxf68jOGAOTZE0ShMXOcD+P4uUSk7Y+4DymvXf
         38wQ==
X-Gm-Message-State: APjAAAUPM0ydjVubRCpavwQnagF//eilUA0YfHmkPy9RyqeU5HBhNBOj
        +cn3MQR5tJ7B6sd0jvK+ykA=
X-Google-Smtp-Source: APXvYqyGTv/AJ8DiPXhGlVppglbyoTzXzesGeimDseTZmlJMyXSAFB03SgdphPnP5REhFTE3gqIsmg==
X-Received: by 2002:a17:902:8609:: with SMTP id f9mr23721645plo.85.1553494991874;
        Sun, 24 Mar 2019 23:23:11 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:e068:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id l80sm5413802pfb.60.2019.03.24.23.23.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 23:23:11 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v12 05/11] gpio: gpio-mm: Utilize for_each_set_clump8 macro
Date:   Mon, 25 Mar 2019 15:24:06 +0900
Message-Id: <49eb64a1bf665dd0dbdd1ba4ba25d8fdb4ff8000.1553494625.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1553494625.git.vilhelm.gray@gmail.com>
References: <cover.1553494625.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-gpio-mm.c | 73 +++++++++++--------------------------
 1 file changed, 22 insertions(+), 51 deletions(-)

diff --git a/drivers/gpio/gpio-gpio-mm.c b/drivers/gpio/gpio-gpio-mm.c
index 8c150fd68d9d..4c1037a005ab 100644
--- a/drivers/gpio/gpio-gpio-mm.c
+++ b/drivers/gpio/gpio-gpio-mm.c
@@ -172,46 +172,26 @@ static int gpiomm_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	return !!(port_state & mask);
 }
 
+static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
+
 static int gpiomm_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	unsigned long *bits)
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-	size_t i;
-	static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
-	const unsigned int gpio_reg_size = 8;
-	unsigned int bits_offset;
-	size_t word_index;
-	unsigned int word_offset;
-	unsigned long word_mask;
-	const unsigned long port_mask = GENMASK(gpio_reg_size - 1, 0);
+	unsigned int offset;
+	unsigned long gpio_mask;
+	const unsigned int ngpio = ARRAY_SIZE(ports) * 8;
+	unsigned int port_addr;
 	unsigned long port_state;
 
 	/* clear bits array to a clean slate */
 	bitmap_zero(bits, chip->ngpio);
 
-	/* get bits are evaluated a gpio port register at a time */
-	for (i = 0; i < ARRAY_SIZE(ports); i++) {
-		/* gpio offset in bits array */
-		bits_offset = i * gpio_reg_size;
-
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
-		port_state = inb(gpiommgpio->base + ports[i]);
+	for_each_set_clump8(offset, gpio_mask, mask, ngpio) {
+		port_addr = gpiommgpio->base + ports[offset / 8];
+		port_state = inb(port_addr) & gpio_mask;
 
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= (port_state << word_offset) & word_mask;
+		bitmap_set_value8(bits, ngpio, port_state, offset);
 	}
 
 	return 0;
@@ -242,37 +222,28 @@ static void gpiomm_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-	unsigned int i;
-	const unsigned int gpio_reg_size = 8;
-	unsigned int port;
-	unsigned int out_port;
+	unsigned int offset;
+	unsigned long gpio_mask;
+	const unsigned int ngpio = ARRAY_SIZE(ports) * 8;
+	size_t index;
+	unsigned int port_addr;
 	unsigned int bitmask;
 	unsigned long flags;
 
-	/* set bits are evaluated a gpio register size at a time */
-	for (i = 0; i < chip->ngpio; i += gpio_reg_size) {
-		/* no more set bits in this mask word; skip to the next word */
-		if (!mask[BIT_WORD(i)]) {
-			i = (BIT_WORD(i) + 1) * BITS_PER_LONG - gpio_reg_size;
-			continue;
-		}
+	for_each_set_clump8(offset, gpio_mask, mask, ngpio) {
+		index = offset / 8;
+		port_addr = gpiommgpio->base + ports[index];
 
-		port = i / gpio_reg_size;
-		out_port = (port > 2) ? port + 1 : port;
-		bitmask = mask[BIT_WORD(i)] & bits[BIT_WORD(i)];
+		bitmask = bitmap_get_value8(bits, ngpio, offset) & gpio_mask;
 
 		spin_lock_irqsave(&gpiommgpio->lock, flags);
 
 		/* update output state data and set device gpio register */
-		gpiommgpio->out_state[port] &= ~mask[BIT_WORD(i)];
-		gpiommgpio->out_state[port] |= bitmask;
-		outb(gpiommgpio->out_state[port], gpiommgpio->base + out_port);
+		gpiommgpio->out_state[index] &= ~gpio_mask;
+		gpiommgpio->out_state[index] |= bitmask;
+		outb(gpiommgpio->out_state[index], port_addr);
 
 		spin_unlock_irqrestore(&gpiommgpio->lock, flags);
-
-		/* prepare for next gpio register set */
-		mask[BIT_WORD(i)] >>= gpio_reg_size;
-		bits[BIT_WORD(i)] >>= gpio_reg_size;
 	}
 }
 
-- 
2.21.0

