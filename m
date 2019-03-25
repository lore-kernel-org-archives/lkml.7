Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C6CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28804205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwqVKKMS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbfCYGEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:04:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46467 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729342AbfCYGEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:04:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id 9so5580356pfj.13;
        Sun, 24 Mar 2019 23:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LbAhFB9V6BisOLUTsbpvSet6qgSjh9MdQ4kQbff2Dwk=;
        b=PwqVKKMSGSxhxKN7Au2TB+BzoEmcE1w/jEZtrJlYLBGEwmz8ULf1pWG2j0/LGWtovG
         wx4eXyQSQwq3ug9iJZBsR1DK7AX3QxX7UlVBxvj2pcHTN/iXP+JWox901huyuvzIKAPG
         7l8OWVureNvuYpp+I80NJ126AWSOgoNGGsM543rdnmQHDNLOtEg8p3COaoOkiNr3vRBj
         CM1nkINpm+NbjujgsyETGdbbDLQ8mJ457BBphNBAZSJzNJJv+V342cog8bfNktDtvggh
         eqKkNH8/CaJ6tFg6B5QXJxrQse8S/kBOOpRyFKEAj2IvKgTg6MKKa77vtpTif8vL+MQP
         vS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LbAhFB9V6BisOLUTsbpvSet6qgSjh9MdQ4kQbff2Dwk=;
        b=GzxL2YJ3CR1mpu+n0ZOa4l3XMRyRaZ5o4rK1f3IkjegYln9QyGHVg1ceGN1pR0Wwfv
         evSkC4xC4ZbT5KGBF+bZdjePnpd7+JMKMyggkAI0E+dv2F7zm2Lc9y+gaMrfG+8LC5GK
         WzMJJisleNHPLghkU45bOSpJBlqBOsiTsNPQYJd055wqe9frh+/myHQPaV4a4sYQYeRu
         b35M3zQhTIlZIwjaFRE8X2Fohq3zTiZSoaXp2QOb+0UnMGvwqe25gp0VMNIZVXdIcexB
         FKZZNNnMCUz4pTuk/A97/eooay7lqKA+SM88nzofOauxEnVJthcg6fmstb1F3MCZoAot
         Sy7A==
X-Gm-Message-State: APjAAAUD4bTDc+fFhYofK0YYDQFAB+jAr7w2zEPLnwQmNn3j31M28I3U
        0qZ8TudR9/enfRGcomfhn2Q=
X-Google-Smtp-Source: APXvYqxGtFKQhfIms0S4Sx0CIXZrTI1OK0EqTLcruiRSdqQwPUA55C8iFjdr/u+iHjpmJTXjtVpVtg==
X-Received: by 2002:a17:902:76c1:: with SMTP id j1mr21210416plt.224.1553493872149;
        Sun, 24 Mar 2019 23:04:32 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:e068:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id m67sm21403332pfj.70.2019.03.24.23.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 23:04:31 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v11 07/11] gpio: pci-idio-16: Utilize for_each_set_clump8 macro
Date:   Mon, 25 Mar 2019 15:05:16 +0900
Message-Id: <4405d4ee08f03855d5884f89e834c6f1c88b26bf.1553492741.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1553492741.git.vilhelm.gray@gmail.com>
References: <cover.1553492741.git.vilhelm.gray@gmail.com>
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
 1 file changed, 28 insertions(+), 47 deletions(-)

diff --git a/drivers/gpio/gpio-pci-idio-16.c b/drivers/gpio/gpio-pci-idio-16.c
index 6b7349783223..b0ed6bb68296 100644
--- a/drivers/gpio/gpio-pci-idio-16.c
+++ b/drivers/gpio/gpio-pci-idio-16.c
@@ -108,45 +108,24 @@ static int idio_16_gpio_get_multiple(struct gpio_chip *chip,
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
+	unsigned int offset;
+	unsigned long gpio_mask;
 	void __iomem *ports[] = {
 		&idio16gpio->reg->out0_7, &idio16gpio->reg->out8_15,
 		&idio16gpio->reg->in0_7, &idio16gpio->reg->in8_15,
 	};
+	const unsigned int ngpio = ARRAY_SIZE(ports) * 8;
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
+	for_each_set_clump8(offset, gpio_mask, mask, ngpio) {
+		port_addr = ports[offset / 8];
+		port_state = ioread8(port_addr) & gpio_mask;
 
-		/* mask of get bits for current gpio within current word */
-		word_mask = mask[word_index] & (port_mask << word_offset);
-		if (!word_mask) {
-			/* no get bits in this port so skip to next one */
-			continue;
-		}
-
-		/* read bits from current gpio port */
-		port_state = ioread8(ports[i]);
-
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= (port_state << word_offset) & word_mask;
+		bitmap_set_value8(bits, ngpio, port_state, offset);
 	}
 
 	return 0;
@@ -186,30 +165,32 @@ static void idio_16_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
+	unsigned int offset;
+	unsigned long gpio_mask;
+	void __iomem *ports[] = {
+		&idio16gpio->reg->out0_7, &idio16gpio->reg->out8_15,
+	};
+	const unsigned int ngpio = ARRAY_SIZE(ports) * 8;
+	size_t index;
+	void __iomem *port_addr;
+	unsigned int bitmask;
 	unsigned long flags;
 	unsigned int out_state;
 
-	raw_spin_lock_irqsave(&idio16gpio->lock, flags);
+	for_each_set_clump8(offset, gpio_mask, mask, ngpio) {
+		index = offset / 8;
+		port_addr = ports[index];
 
-	/* process output lines 0-7 */
-	if (*mask & 0xFF) {
-		out_state = ioread8(&idio16gpio->reg->out0_7) & ~*mask;
-		out_state |= *mask & *bits;
-		iowrite8(out_state, &idio16gpio->reg->out0_7);
-	}
+		bitmask = bitmap_get_value8(bits, ngpio, offset) & gpio_mask;
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

