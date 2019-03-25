Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47317C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FC420850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t7dheYot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbfCYGDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:03:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43909 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729447AbfCYGDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:03:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id c8so5591130pfd.10;
        Sun, 24 Mar 2019 23:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wovyItwhuu6up6N9d5xqiEvzR3TkCWii5hwPk2X/3Vc=;
        b=t7dheYot/to1cOshyBqUFiWKdlK6zUPa2kZgUX9ri9YieAOtQx1M8ljQ2y3F+hlMw+
         yZktELnPYVjXjOcQXYhLtjLZvN+Cn+FsSbX0mShwzls2Gkbd0YX0NGM7Ki1+k/6CFeET
         xmwsMxRzJP1jgzh9y1V0BjDNqkvJb/RRlBtlGEiWuzXqEpF6F0jX9PMjfRQvITS4Ad5Z
         JeKOn3E3NcAehXBJ417LE51vyin7ympkxi1bkxRCleUe4yF3Y5dYrqxV5Gt4JWroLbgq
         roCPv0N2VH0J0+FB+tJ3BY3TlWezPpCQTkQ/wlr5TQd4vTwChfvs+GR0g1E2T5j6zqee
         TU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wovyItwhuu6up6N9d5xqiEvzR3TkCWii5hwPk2X/3Vc=;
        b=Br5crryZqGY8I+pZ9ffuUNMH2Q37Po4U9IMCmGmXZ1YjZvrBZsSWPI+8uHYb4Vqvpx
         K15BIb9AVr7ysgw6B4vamnHQ1Mi3CnUaZmLo028GQ3l/+rpiXh45xGLdbun51dM8Vk+N
         ybKj5OiSoClMqKhMbVW00f6HBL8OPmZ3E69ZpvEEJkVEr/a8hw8kqW0s4JfXkA0vufXb
         DjWBRG6P9eVKGPa15+ZF3/AM2X2FuWtTQl6KeAhnDwoviRVlP547oiGSxMo8AeaAOFnM
         K4L3dl65v6qv79qYKJ/jZHOv51+xKnb4u6fDctIhQOEhcUmvaP27+oUXs/7TyaiMWZ0Q
         ZiYw==
X-Gm-Message-State: APjAAAXkjBzSvGr8EMU6W2YkkwPiMoC5XMTm45qvBxDrTYdb0Lih43Sr
        AoA0j0/Yyrtx9EPGfkUdHIw=
X-Google-Smtp-Source: APXvYqw5waGrSLHDsnc18OzsVFHqn2mGhg5skjMtoDXJZ7lHdplfgjMSLhEk0lD7XRiX2TDJzbP8AQ==
X-Received: by 2002:a17:902:2d01:: with SMTP id o1mr23638429plb.155.1553493801272;
        Sun, 24 Mar 2019 23:03:21 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:e068:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id i22sm19433145pfa.88.2019.03.24.23.03.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 23:03:20 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v11 04/11] gpio: 104-idi-48: Utilize for_each_set_clump8 macro
Date:   Mon, 25 Mar 2019 15:04:16 +0900
Message-Id: <f605856ca0fdc167896f9c87e21af137e23d65ed.1553492741.git.vilhelm.gray@gmail.com>
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

