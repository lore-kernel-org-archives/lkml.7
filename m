Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05AAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F9C206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfW758lG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfCNMaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:30:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42528 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfCNMaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:30:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id r15so966044pfn.9;
        Thu, 14 Mar 2019 05:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wovyItwhuu6up6N9d5xqiEvzR3TkCWii5hwPk2X/3Vc=;
        b=AfW758lGDfOT0nmEzqbNvKwVxfumX+W8/udGCjXD6F/kVAt+9HW3qbkUb+4xAQrlHH
         AYvMwh96/N5Ddez9BM8eWr9IZUijPL2TVPQELBcOvUtSlvloVDco3F5xGxa2QYq0B883
         /gu79bAOD15xvxV70t0nRKxz+jDfMF2eQ1vFZEOeNFDJKfeY3gU4AJczX4nm5KhQNA84
         AaRUnFYStfFVEE78/q4kBNq8j02L5rSWEEkOLkplz8cZqTCd1dzdaCJgP2F+CRSnWXgU
         OZ/3xcX8RznL7GB8OqRe47m0nLGrdA+7OeRe1cH0d59wujsho13eR1KMNnBCDp/96DsS
         Tjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wovyItwhuu6up6N9d5xqiEvzR3TkCWii5hwPk2X/3Vc=;
        b=XMu4SMxkbQ4KdUBSSjp9tDvP1t4OUQErw9emzi9WdUfiGjADpII88Y1qmacws63BCh
         nG+qQEQ24cEiJIY7t+WaX35MWUi+qJyKHdo+CoP+X+6B1S9+zddkgE9xuBlo0nWuglwu
         ucMyVNa1q5lx616PSrLAwZ+rx6q1PeeX+x+mhwbWYhTMZiXClybU8WQdGY5u/n7A1zhL
         4jUN0IEUnkSTfJR3u4kyqPovw3U+d8FcZkEHPFIvNjn6N7+BEhfDn6qSpaZ615YQDZxi
         RfF3Io7BDklb3fq/SF0wiSeX9Q7IBngy5+81xzA2H0mjlW0QFLSKAcZYH0/etYxoeq2g
         uTyQ==
X-Gm-Message-State: APjAAAUK8sGKEPPcg4qeEtX6Ej5NbGSAv+za2pjU4mh6I/YH+t4r60O4
        preVksoNWgBO1BKu8SccFGc=
X-Google-Smtp-Source: APXvYqzkBFfEOq7My/mjnNtvbYiVspZBPohjmp4JfJkVKzGcZtulSYEO1Yn4cdZul+eFkTi1Vkunww==
X-Received: by 2002:a63:124c:: with SMTP id 12mr29049250pgs.86.1552566607946;
        Thu, 14 Mar 2019 05:30:07 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a4:3974:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id r86sm25075639pfa.82.2019.03.14.05.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 05:30:07 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com, bgolaszewski@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v10 04/10] gpio: 104-idi-48: Utilize for_each_set_clump8 macro
Date:   Thu, 14 Mar 2019 21:30:59 +0900
Message-Id: <ad5a2e67546d10ad2a0350ebd222cac114671f82.1552566114.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-104-idi-48.c | 37 ++++++++--------------------------
 1 file changed, 8 insertions(+), 29 deletions(-)

diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index 88dc6f2449f6..59c571aecf9a 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -93,42 +93,21 @@ static int idi_48_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	unsigned long *bits)
 {
 	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
-	size_t i;
+	unsigned int offset;
+	unsigned long gpio_mask;
 	static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
-	const unsigned int gpio_reg_size = 8;
-	unsigned int bits_offset;
-	size_t word_index;
-	unsigned int word_offset;
-	unsigned long word_mask;
-	const unsigned long port_mask = GENMASK(gpio_reg_size - 1, 0);
+	const unsigned int ngpio = ARRAY_SIZE(ports) * 8;
+	unsigned int port_addr;
 	unsigned long port_state;
 
 	/* clear bits array to a clean slate */
 	bitmap_zero(bits, chip->ngpio);
 
-	/* get bits are evaluated a gpio port register at a time */
-	for (i = 0; i < ARRAY_SIZE(ports); i++) {
-		/* gpio offset in bits array */
-		bits_offset = i * gpio_reg_size;
+	for_each_set_clump8(offset, gpio_mask, mask, ngpio) {
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
+		bitmap_set_value8(bits, ngpio, port_state, offset);
 	}
 
 	return 0;
-- 
2.21.0

