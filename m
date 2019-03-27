Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E6BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432E22075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLby6UMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbfC0FAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:00:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41028 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbfC0FAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:00:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id f6so5223345pgs.8;
        Tue, 26 Mar 2019 22:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OkTwC9+bMfKIv7o0Jn0YcCWU1jhpVQZU39lRVQzfxwM=;
        b=kLby6UMMUISj9YX3QMOybUionexQpzW4Cnh9y8rHOG0lTQidh8H25i2C2nMCxgT+iR
         B6cOJUpNVrUL32UMZN5gUFBPXr+nm/LKXbnXE/MURr6L8Co7zasVkTAfWOStrTb6LFMn
         DhIa7tHG9GpyOOZu+6SQkDwgH/bulkp7GTAdYr+J19HxbYw14DRSWej/fk1oPKmqtHQ9
         dhcOYIzhPEugC7fX9og+6X+JYD078OY+GqYmnoqNInAZI0SDPI1YLuCVGnlGvKgqDgnh
         pGamrec1z4Yrez30Ey884dWgAzeMafuBYEhrfhTs4/0xDzKsBSH8w0tPi7n6OUEN7Q19
         BEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OkTwC9+bMfKIv7o0Jn0YcCWU1jhpVQZU39lRVQzfxwM=;
        b=hcCSZk/iFmJY8T4N226jjUciJeUsiSrnCZHhdYfwl4ghB6ezaPAryvW082xOeWy+BN
         9z0bdvgohyAL2buJzGFwgLm5H3sFOj6iHVczy8IxXglfnn+9BXfZktDhOepjYJ6OPPvi
         Oa2BLsp59L755LjIe42NIEJeD3YMQIw0MxnRxewZ67/g46HLt4ZdzTVIGpViI73SqPHU
         cCBs4ilz1LUfapML4zheEEs1E2EcfJ3NR4ZAmg2mzBbvYmteVFHvBg9yyBdyKHCHwmwn
         7Cu33/J77TQLm9nRTPEawUiuec2TNrC03ADMR9acak41iZ4hX/CU0IGOQBK9OXcvBkh/
         zvKA==
X-Gm-Message-State: APjAAAVMqxFrOvLduT0iytmx4wRwjK7hWXJ+YE0kESu9sLRnOdN+KMK2
        STtevXUFjRhRU3/zBuX+4GA=
X-Google-Smtp-Source: APXvYqz1kD55kg6GG7SDVFuBdsfAb/ei7DPNUHoceb7E6zL086rWJB2GQiYauDMqiz2ujovfzzNQvw==
X-Received: by 2002:a63:570d:: with SMTP id l13mr24905748pgb.55.1553662820110;
        Tue, 26 Mar 2019 22:00:20 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:6014:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id e15sm28629604pgk.30.2019.03.26.22.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 22:00:19 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v13 08/11] gpio: pcie-idio-24: Utilize for_each_set_clump8 macro
Date:   Wed, 27 Mar 2019 14:01:13 +0900
Message-Id: <93e629552491a546c838519ee3b0dbe4bc08f3ed.1553661964.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1553661964.git.vilhelm.gray@gmail.com>
References: <cover.1553661964.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-pcie-idio-24.c | 109 ++++++++++++-------------------
 1 file changed, 40 insertions(+), 69 deletions(-)

diff --git a/drivers/gpio/gpio-pcie-idio-24.c b/drivers/gpio/gpio-pcie-idio-24.c
index 52f1647a46fd..924ec916b358 100644
--- a/drivers/gpio/gpio-pcie-idio-24.c
+++ b/drivers/gpio/gpio-pcie-idio-24.c
@@ -198,52 +198,34 @@ static int idio_24_gpio_get_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
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
 		&idio24gpio->reg->out0_7, &idio24gpio->reg->out8_15,
 		&idio24gpio->reg->out16_23, &idio24gpio->reg->in0_7,
 		&idio24gpio->reg->in8_15, &idio24gpio->reg->in16_23,
 	};
+	size_t index;
+	unsigned long port_state;
 	const unsigned long out_mode_mask = BIT(1);
 
 	/* clear bits array to a clean slate */
 	bitmap_zero(bits, chip->ngpio);
 
-	/* get bits are evaluated a gpio port register at a time */
-	for (i = 0; i < ARRAY_SIZE(ports) + 1; i++) {
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
+		index = offset / 8;
 
 		/* read bits from current gpio port (port 6 is TTL GPIO) */
-		if (i < 6)
-			port_state = ioread8(ports[i]);
+		if (index < 6)
+			port_state = ioread8(ports[index]);
 		else if (ioread8(&idio24gpio->reg->ctl) & out_mode_mask)
 			port_state = ioread8(&idio24gpio->reg->ttl_out0_7);
 		else
 			port_state = ioread8(&idio24gpio->reg->ttl_in0_7);
 
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= (port_state << word_offset) & word_mask;
+		port_state &= gpio_mask;
+
+		bitmap_set_value8(bits, port_state, offset);
 	}
 
 	return 0;
@@ -294,59 +276,48 @@ static void idio_24_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
-	size_t i;
-	unsigned long bits_offset;
+	unsigned long offset;
 	unsigned long gpio_mask;
-	const unsigned int gpio_reg_size = 8;
-	const unsigned long port_mask = GENMASK(gpio_reg_size, 0);
-	unsigned long flags;
-	unsigned int out_state;
 	void __iomem *ports[] = {
 		&idio24gpio->reg->out0_7, &idio24gpio->reg->out8_15,
 		&idio24gpio->reg->out16_23
 	};
+	size_t index;
+	unsigned long bitmask;
+	unsigned long flags;
+	unsigned long out_state;
 	const unsigned long out_mode_mask = BIT(1);
-	const unsigned int ttl_offset = 48;
-	const size_t ttl_i = BIT_WORD(ttl_offset);
-	const unsigned int word_offset = ttl_offset % BITS_PER_LONG;
-	const unsigned long ttl_mask = (mask[ttl_i] >> word_offset) & port_mask;
-	const unsigned long ttl_bits = (bits[ttl_i] >> word_offset) & ttl_mask;
-
-	/* set bits are processed a gpio port register at a time */
-	for (i = 0; i < ARRAY_SIZE(ports); i++) {
-		/* gpio offset in bits array */
-		bits_offset = i * gpio_reg_size;
-
-		/* check if any set bits for current port */
-		gpio_mask = (*mask >> bits_offset) & port_mask;
-		if (!gpio_mask) {
-			/* no set bits for this port so move on to next port */
-			continue;
-		}
 
-		raw_spin_lock_irqsave(&idio24gpio->lock, flags);
+	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+		index = offset / 8;
 
-		/* process output lines */
-		out_state = ioread8(ports[i]) & ~gpio_mask;
-		out_state |= (*bits >> bits_offset) & gpio_mask;
-		iowrite8(out_state, ports[i]);
+		bitmask = bitmap_get_value8(bits, offset) & gpio_mask;
 
-		raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
-	}
+		raw_spin_lock_irqsave(&idio24gpio->lock, flags);
 
-	/* check if setting TTL lines and if they are in output mode */
-	if (!ttl_mask || !(ioread8(&idio24gpio->reg->ctl) & out_mode_mask))
-		return;
+		/* read bits from current gpio port (port 6 is TTL GPIO) */
+		if (index < 6) {
+			out_state = ioread8(ports[index]);
+		} else if (ioread8(&idio24gpio->reg->ctl) & out_mode_mask) {
+			out_state = ioread8(&idio24gpio->reg->ttl_out0_7);
+		} else {
+			/* skip TTL GPIO if set for input */
+			raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
+			continue;
+		}
 
-	/* handle TTL output */
-	raw_spin_lock_irqsave(&idio24gpio->lock, flags);
+		/* set requested bit states */
+		out_state &= ~gpio_mask;
+		out_state |= bitmask;
 
-	/* process output lines */
-	out_state = ioread8(&idio24gpio->reg->ttl_out0_7) & ~ttl_mask;
-	out_state |= ttl_bits;
-	iowrite8(out_state, &idio24gpio->reg->ttl_out0_7);
+		/* write bits for current gpio port (port 6 is TTL GPIO) */
+		if (index < 6)
+			iowrite8(out_state, ports[index]);
+		else
+			iowrite8(out_state, &idio24gpio->reg->ttl_out0_7);
 
-	raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
+		raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
+	}
 }
 
 static void idio_24_irq_ack(struct irq_data *data)
-- 
2.21.0

