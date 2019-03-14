Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6790BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C163206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afmsyoRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfCNM3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:29:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42493 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfCNM3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:29:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id r15so965482pfn.9;
        Thu, 14 Mar 2019 05:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5tnH02Yc3JnragyosQ4LQT3N7xcrc3Yee7t/cF7aZ1U=;
        b=afmsyoRZR6TWA9FJLD5BfcEqWqmpjPB9rVYhyp0oYzUnGbT1Pnfl4b5u9zw3LUOux6
         E/GJMatSIN2+oVDq5f38rNIW5jvbWl/u6EV9VmTDgFr9Mvz4U4XjVhqORKNfa5rpSh0+
         rH49wcep/vZ5Ysg0Q81B7YJ+AeqZij78MojNWLZhe3BFmEh3i6MQqs7QiGxuq/YlKWTJ
         NBu18By2/pv3a3HL+2PBZ64c0e7M/ZRDuSwHH9nBwPV/GtlWLLZiSnl1+g56aqfMgXkC
         GnR5mEd1nhmFeNmEjI0fwH7n+LJXfwZTWDSmUeRcl272v2EkvPFC6syWTeF4o9jG/Uzc
         5Tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5tnH02Yc3JnragyosQ4LQT3N7xcrc3Yee7t/cF7aZ1U=;
        b=owONiX9ETQar76i5Qi9XQ4EMKroIV9J46H7zDMDE4jvPQQLwS6eMbAYfbAHHpOxXcw
         ZFbFEm/w0idC8AWA0j0Q8wFsJXUAUz/oEsYNT2mL/1dBfq7hnDouXLA12DHIbtPZxkLY
         dohjjHX91Nm6I2f9pgfL9dOP8eBSnFKed6GZmKfqY2iz/KB2aI+YJY1JDUISjiRNohki
         OkyfNJ/Rf+beQwooPcctubFaGJ+fL3vZQnTuolbwFyIBrhelhn0OraOqZ4naeF/fSlfT
         JrzhW989YSBCi1yHBxAFf7ka/zpPVK/NBo09/e9RRpzjHCpBuw8cyp0Vmxjg9O3QaJcg
         VXqg==
X-Gm-Message-State: APjAAAWf0wyzuvQueFa4hxkNZPiFLCHKg28n1tQhUmcrqV26tBJRydDy
        45sMBn4EJ9iG0u/r6vjeVQw=
X-Google-Smtp-Source: APXvYqw423ATEMoqNrHOhcNG2pTRmU6ZYg2xUtFiWBO3VGcqVA2QpSceHQwaOWAhy9z+5SX2/ghV6A==
X-Received: by 2002:a17:902:1621:: with SMTP id g30mr51058579plg.116.1552566589450;
        Thu, 14 Mar 2019 05:29:49 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a4:3974:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id d16sm22550391pfo.112.2019.03.14.05.29.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 05:29:49 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com, bgolaszewski@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v10 03/10] gpio: 104-dio-48e: Utilize for_each_set_clump8 macro
Date:   Thu, 14 Mar 2019 21:30:42 +0900
Message-Id: <c7cb2444f4ad3899da9b425e3cbd227c193d32a6.1552566114.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1552566113.git.vilhelm.gray@gmail.com>
References: <cover.1552566113.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-104-dio-48e.c | 73 ++++++++++-----------------------
 1 file changed, 22 insertions(+), 51 deletions(-)

diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index 92c8f944bf64..23413d90e944 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -183,46 +183,26 @@ static int dio48e_gpio_get(struct gpio_chip *chip, unsigned offset)
 	return !!(port_state & mask);
 }
 
+static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
+
 static int dio48e_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	unsigned long *bits)
 {
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
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
-		port_state = inb(dio48egpio->base + ports[i]);
+	for_each_set_clump8(offset, gpio_mask, mask, ngpio) {
+		port_addr = dio48egpio->base + ports[offset / 8];
+		port_state = inb(port_addr) & gpio_mask;
 
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= (port_state << word_offset) & word_mask;
+		bitmap_set_value8(bits, ngpio, port_state, offset);
 	}
 
 	return 0;
@@ -252,37 +232,28 @@ static void dio48e_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
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
+		port_addr = dio48egpio->base + ports[index];
 
-		port = i / gpio_reg_size;
-		out_port = (port > 2) ? port + 1 : port;
-		bitmask = mask[BIT_WORD(i)] & bits[BIT_WORD(i)];
+		bitmask = bitmap_get_value8(bits, ngpio, offset) & gpio_mask;
 
 		raw_spin_lock_irqsave(&dio48egpio->lock, flags);
 
 		/* update output state data and set device gpio register */
-		dio48egpio->out_state[port] &= ~mask[BIT_WORD(i)];
-		dio48egpio->out_state[port] |= bitmask;
-		outb(dio48egpio->out_state[port], dio48egpio->base + out_port);
+		dio48egpio->out_state[index] &= ~gpio_mask;
+		dio48egpio->out_state[index] |= bitmask;
+		outb(dio48egpio->out_state[index], port_addr);
 
 		raw_spin_unlock_irqrestore(&dio48egpio->lock, flags);
-
-		/* prepare for next gpio register set */
-		mask[BIT_WORD(i)] >>= gpio_reg_size;
-		bits[BIT_WORD(i)] >>= gpio_reg_size;
 	}
 }
 
-- 
2.21.0

