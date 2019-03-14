Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB6EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B8B206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z20N14jd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfCNMau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:30:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37918 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfCNMat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:30:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id n125so3727848pfn.5;
        Thu, 14 Mar 2019 05:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JhQ28KZcd91XNKjTCGWYQ1G7G3aiOZwynfHwUrGcvPU=;
        b=Z20N14jduB0i02AsdL05vaQOwSPD+QSSFBQ9T3qCz7Ejh1x6KtAcRmZsza9tvq0Kvp
         rnTtirBabetLCzTsvGjVqqAYWseTnUV6sEXCop7B3gNT/gbrtuD4/REnBVodpgiZM8J7
         xIZikGUoVuCfF25IgGozDjroghBBww65JbCQg+HceLpELDHYUsUK1CQKLtv8+Br1j44S
         Cd/Qo41WJGs3HdFXsBVOQ/DyZetBklE+WBhcQLyHCQk7V6jvk6VmwNqbnotxdRRhs+2E
         S0fEuBKZpPzVNiaqdHVgYX0D77aU67Kt9Ei4W0a3CuVTTqGybc+gBwCrNM1vxR2GdMo7
         IyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JhQ28KZcd91XNKjTCGWYQ1G7G3aiOZwynfHwUrGcvPU=;
        b=kZfegAx47eMNGrIezHOJekqZGItfc+IdFZSvg+c39JEoDIVaWx4esxO/myfSTtY/L7
         4b2vRp1FW5gFo5sr+v/EdWcUTH4sKK8FNSPa8JXQ2t6PP1vyHPrXlcb9N5Df8Ubnj5eD
         0Z7PbNIbsmU5ikYgVBLFThNDCQvsamMKfxx0xpkzpPvXuEkzsThqRbdCjTRDz0V4GmhQ
         h2DgsfPesqo2lhPCjVBo2VFQ+QNJ39JtdUjzwcf+ZESHysjCGH1moR9l3VXeaiXjZtxG
         42vuQ8Hg1vR3MKqqvn5m8d5LlsPt6PaMJQXz3BdnsMx/q9VFmRDwVjY77pWwMWYjTecS
         zs5A==
X-Gm-Message-State: APjAAAUFxzmCA9gm/VI3RGXE0m5pubhpoCgAxg3NyUviABNSX2hjAgZB
        uc2tqNnf7azuyj78i0begDo=
X-Google-Smtp-Source: APXvYqxsAcdIohIYrCAAKONAfVTAoioViiXPUHVAoW37FVmu9RFKMcerKJbEXnMXhqdFWy+g8Y8fXw==
X-Received: by 2002:aa7:8a59:: with SMTP id n25mr14606746pfa.251.1552566648786;
        Thu, 14 Mar 2019 05:30:48 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a4:3974:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id r82sm24007368pfa.161.2019.03.14.05.30.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 05:30:48 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com, bgolaszewski@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v10 06/10] gpio: ws16c48: Utilize for_each_set_clump8 macro
Date:   Thu, 14 Mar 2019 21:31:36 +0900
Message-Id: <2be67e8cd255884af67e053e21577cdf4c7ab83a.1552566114.git.vilhelm.gray@gmail.com>
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

