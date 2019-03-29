Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B451C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198122184D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rw2qkKCS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfC2DFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 23:05:12 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37173 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfC2DFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 23:05:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id q6so313770pll.4;
        Thu, 28 Mar 2019 20:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PqXTy5leW1u0qHG2FvwK5coDmQU6qYHNOD3tv8uuTcU=;
        b=rw2qkKCSDVz/Tpp1+Y5IyUbsMzLRJ9+s4Cz/WjhER5Jybu9T6Y5N60EEBl71gjCs/X
         S1tSVCrxBfo/ImRC9QyElTBpmHI3VRHOKL3z4VGs9ms/XDdwke57w/r+D1RVg9GgHK5q
         DRUzR/RVlCyWxU5vIQCvCG65ojVMyKlMInJaMuCvrUcBDrWUxGKK04mMgS9mG5OZ+VLC
         KbMlkzRksYlMgjqdbtKpCO/ge5iSxSz+MnEYH6NU+a6PyrsAiZASiRtb4p/gEqWds55X
         qfXVcwqK656KCl01JcEw68ZOKbacIYh459e0dEsC9eVPGkDaw3NcP9rjRlbe9zb8cu+D
         ikVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PqXTy5leW1u0qHG2FvwK5coDmQU6qYHNOD3tv8uuTcU=;
        b=MTp5aPORd73ynPvGVaLIQc/FWMkumqo9FFox+U3I1g3eTnA05+cvEhH3CMZbtByhbe
         Trh3aEZ4i1cz8d5YuB3J+8xlhyM/NXqxV7dumgiS0bJF0XTlKAwEuaKXkD88RuBiVnNX
         XXrzsy8512pSaVgN/ozVGwITn4qt10ksVCcas4yE1NnfG3KCwYr9oX5SdziU8n8bwflR
         UjIGK0jApc0WjnZWO3L9st+MrEbqBb0pDjx+mc/L79UaTk/Kf3Ah4fCcaVsJDfd/O96o
         nvMxTbUlCOFOPL9jMB6tqwhoiyFMj8ntSzZ0QzUtr89uUFvAKl2p8hbuqZnPVmB9ViBM
         r9LA==
X-Gm-Message-State: APjAAAXBjETWvDP9/9r/Ycvor06HmBauX0syUe4k4YXV+ddcbCR2hNHh
        XN+Wt3nDIHq6i5hwVpAtxco=
X-Google-Smtp-Source: APXvYqwm/vmhMs1fugXusZtfLAQ45dsVVfOHhFRxC8MtOhTqDQtGGbtS+df14mtlC60BCAhd7KKNwg==
X-Received: by 2002:a17:902:822:: with SMTP id 31mr2944849plk.290.1553828711252;
        Thu, 28 Mar 2019 20:05:11 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:ba2:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id o5sm107443pfa.135.2019.03.28.20.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 20:05:10 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v14 07/11] gpio: pci-idio-16: Utilize for_each_set_clump8 macro
Date:   Fri, 29 Mar 2019 12:06:07 +0900
Message-Id: <074936a78128d5a2e604c8cca6e49c647c9e1f8f.1553828158.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-pci-idio-16.c | 75 ++++++++++++---------------------
 1 file changed, 27 insertions(+), 48 deletions(-)

diff --git a/drivers/gpio/gpio-pci-idio-16.c b/drivers/gpio/gpio-pci-idio-16.c
index 6b7349783223..a67388db28ad 100644
--- a/drivers/gpio/gpio-pci-idio-16.c
+++ b/drivers/gpio/gpio-pci-idio-16.c
@@ -108,45 +108,23 @@ static int idio_16_gpio_get_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
-	size_t i;
-	const unsigned int gpio_reg_size = 8;
-	unsigned int bits_offset;
-	size_t word_index;
-	unsigned int word_offset;
-	unsigned long word_mask;
-	const unsigned long port_mask = GENMASK(gpio_reg_size - 1, 0);
-	unsigned long port_state;
+	unsigned long offset;
+	unsigned long gpio_mask;
 	void __iomem *ports[] = {
 		&idio16gpio->reg->out0_7, &idio16gpio->reg->out8_15,
 		&idio16gpio->reg->in0_7, &idio16gpio->reg->in8_15,
 	};
+	void __iomem *port_addr;
+	unsigned long port_state;
 
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
+	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+		port_addr = ports[offset / 8];
+		port_state = ioread8(port_addr) & gpio_mask;
 
-		/* read bits from current gpio port */
-		port_state = ioread8(ports[i]);
-
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= (port_state << word_offset) & word_mask;
+		bitmap_set_value8(bits, port_state, offset);
 	}
 
 	return 0;
@@ -186,30 +164,31 @@ static void idio_16_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
+	unsigned long offset;
+	unsigned long gpio_mask;
+	void __iomem *ports[] = {
+		&idio16gpio->reg->out0_7, &idio16gpio->reg->out8_15,
+	};
+	size_t index;
+	void __iomem *port_addr;
+	unsigned long bitmask;
 	unsigned long flags;
-	unsigned int out_state;
+	unsigned long out_state;
 
-	raw_spin_lock_irqsave(&idio16gpio->lock, flags);
+	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+		index = offset / 8;
+		port_addr = ports[index];
 
-	/* process output lines 0-7 */
-	if (*mask & 0xFF) {
-		out_state = ioread8(&idio16gpio->reg->out0_7) & ~*mask;
-		out_state |= *mask & *bits;
-		iowrite8(out_state, &idio16gpio->reg->out0_7);
-	}
+		bitmask = bitmap_get_value8(bits, offset) & gpio_mask;
+
+		raw_spin_lock_irqsave(&idio16gpio->lock, flags);
 
-	/* shift to next output line word */
-	*mask >>= 8;
+		out_state = ioread8(port_addr) & ~gpio_mask;
+		out_state |= bitmask;
+		iowrite8(out_state, port_addr);
 
-	/* process output lines 8-15 */
-	if (*mask & 0xFF) {
-		*bits >>= 8;
-		out_state = ioread8(&idio16gpio->reg->out8_15) & ~*mask;
-		out_state |= *mask & *bits;
-		iowrite8(out_state, &idio16gpio->reg->out8_15);
+		raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
 	}
-
-	raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
 }
 
 static void idio_16_irq_ack(struct irq_data *data)
-- 
2.21.0

