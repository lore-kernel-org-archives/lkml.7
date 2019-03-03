Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE67C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 07:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA4220866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 07:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bam77vDD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfCCHt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 02:49:57 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36431 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfCCHt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 02:49:56 -0500
Received: by mail-pf1-f195.google.com with SMTP id n22so972144pfa.3;
        Sat, 02 Mar 2019 23:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JhQ28KZcd91XNKjTCGWYQ1G7G3aiOZwynfHwUrGcvPU=;
        b=Bam77vDD1tCuqDxCF0IcCKgnNzw8GpQon75PFQFQEOOepcG0dtY0LydsboWhTUhgTM
         LFYthlyHTGGr3mGihCHLzkdk+aQj+AklVfYXjk7xd/6A35DLVmdEKSpEfmmPaZS8HQm/
         /qmJbh9yscMIOal6u7SLsv+4lZ/wgoMY0LNDr83uHRs9md9+B33Mup8U352U124TGII+
         oosd01G1jb2qG2oEMSeKsOOleLFvWEEU7iyuNldaOK/gwv6uE9UIekgYWnKBZ2IpiaCm
         Esa+9dX/CnXb8H0ENDNdjGKxY5p9+REOnNmck9E9761k3V2uJyvNI3rMy098CU3Z7PCI
         BSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JhQ28KZcd91XNKjTCGWYQ1G7G3aiOZwynfHwUrGcvPU=;
        b=s/1/8+qiSNT+pT6E+T4uQNlN+9YgEVSiD4Tz0pfUWUEdV7njSs7ijsCE2c2JajX9cO
         MTbxEg0YE0Etk0IAxpgBw5tLoI7sXKAr78G4PIAa+owSTokGnb5Ees8q2UNAYPvirvmb
         niTerx0CmsM3P0e6bWoDHmbVueaxJM3IWobLvD+B7gU0SGfo900FHvW7P3fx8FiXhrRf
         vEh1yl37cG1pkR6ChR4F2EoLge8+RHkOjy9sCaOSkhO3TfOhjtvn5/AOqjl9nYxP36JM
         QEAjPeti8zv3KbLd5ROWvYXpOnjpjHNJGtl7vJQx7E1N1F50hqwssSo8qJsNyUAYIj68
         XHKg==
X-Gm-Message-State: APjAAAUse/h0VBMPWdil8YFPo1pLXGipXs+41b3kJ2o3eebA4TLtkDTh
        Pw51lNpojCZfw+z1ZQGQNTY=
X-Google-Smtp-Source: APXvYqwGqFl0d/l1kXcUR+JEMAN+AdTga040FQBJQpmxnclXVEpXD35y02QTWkfd2hVGCraLprjWhA==
X-Received: by 2002:a63:c0b:: with SMTP id b11mr9994330pgl.388.1551599395879;
        Sat, 02 Mar 2019 23:49:55 -0800 (PST)
Received: from localhost.localdomain ([2001:268:c0a5:3b5c:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id j14sm3692361pfe.12.2019.03.02.23.49.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 23:49:55 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com, bgolaszewski@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v9 6/9] gpio: ws16c48: Utilize for_each_set_clump8 macro
Date:   Sun,  3 Mar 2019 16:50:42 +0900
Message-Id: <f5a180f6527f47d036f64db12f40bb2543f1c3c7.1551598603.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1551598603.git.vilhelm.gray@gmail.com>
References: <cover.1551598603.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-ws16c48.c | 72 +++++++++++--------------------------
 1 file changed, 20 insertions(+), 52 deletions(-)

diff --git a/drivers/gpio/gpio-ws16c48.c b/drivers/gpio/gpio-ws16c48.c
index 5cf3697bfb15..1d071a3d3e81 100644
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
+	unsigned int offset;
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
+		bitmap_set_value8(bits, chip->ngpio, port_state, offset);
 	}
 
 	return 0;
@@ -203,39 +180,30 @@ static void ws16c48_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct ws16c48_gpio *const ws16c48gpio = gpiochip_get_data(chip);
-	unsigned int i;
-	const unsigned int gpio_reg_size = 8;
-	unsigned int port;
-	unsigned int iomask;
+	unsigned int offset;
+	unsigned long gpio_mask;
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
-
-		port = i / gpio_reg_size;
+	for_each_set_clump8(offset, gpio_mask, mask, chip->ngpio) {
+		index = offset / 8;
+		port_addr = ws16c48gpio->base + index;
 
 		/* mask out GPIO configured for input */
-		iomask = mask[BIT_WORD(i)] & ~ws16c48gpio->io_state[port];
-		bitmask = iomask & bits[BIT_WORD(i)];
+		gpio_mask &= ~ws16c48gpio->io_state[index];
+		bitmask = bitmap_get_value8(bits, chip->ngpio, offset) &
+			  gpio_mask;
 
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

