Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1803C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC1D20811
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8bfgdC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbfCYGWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:22:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44716 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729587AbfCYGWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:22:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id i2so5737007pgj.11;
        Sun, 24 Mar 2019 23:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wovyItwhuu6up6N9d5xqiEvzR3TkCWii5hwPk2X/3Vc=;
        b=k8bfgdC35YuzrdwsSZ5zBZxonj7tKQjAvBUnLY2G4c8ouxJD6tExysVXc6o5BBagd/
         Khu6FvIiiyiyUsC3nknsLh1+Q+eiOzMiYH9hwsoWkAeIFU8RJWy5G0wysmfJnstvHaqQ
         05rAE2kU3QlP15HFXZLPcfii+diLOtsVTTizIno/D7tC72ofXmMKMnLkGkHjmRSwyZ9p
         2OMDeCGUPfUWVkksAcAbKlJAfmoAPMvQSE6rJZgB5Da0L3Kzt0uBVfI+pLpjIYyLzb4P
         ypFLghvE5G0lR93kxTq1y5oLey6CQzl3EkK9W4/F4gkS/xs5GZRjprjJ9PSIkmFXW9FC
         pN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wovyItwhuu6up6N9d5xqiEvzR3TkCWii5hwPk2X/3Vc=;
        b=ToFiTGToxb1ifcAAr/rXB0IYtSicKME6WeQ+bQjjiMbB1Sumr4Fd4fdLdE0c0xq4Qk
         JaK3JsYW4PbxvlVHJ475jcp7ZUdcK15dfUZVGq8nxoTpM/KuDPU10g6PMldyjMSHun13
         bOsHn7eeuevkNSnQTidQVWcY/FVsTluOXnSTn/tmYqoYzarMv/NH6a+K7RgOzxsDNHAo
         Ar4jxLYd1D8m5S+EyDoADJEAaQAf811V+6DA0GWVsfITUmsMmIrfO+Yf3BBBWf9Ewb5y
         umgL2zEpu4B8BhJiu1AYTvufulTD1YKC97+9rHXO81+QvMfNYQjagm2zluG0ONjGhiFU
         CYrQ==
X-Gm-Message-State: APjAAAXEgdqUbOymYwdENuqTzpy+uUOH3attRaP3b8gx1A/qbZHCuBVj
        gQgbq0JoSP8GXrsLiJNGZnU=
X-Google-Smtp-Source: APXvYqwO1uw8Gsq1gIvv4tV3BZ28qRzs7qbFCmIfifMlhXyJO9IqvrfTljiqn4sirx/Rrm8jdPoF2w==
X-Received: by 2002:a65:6645:: with SMTP id z5mr22214836pgv.251.1553494972350;
        Sun, 24 Mar 2019 23:22:52 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:e068:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id 15sm19598988pfy.148.2019.03.24.23.22.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 23:22:51 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v12 04/11] gpio: 104-idi-48: Utilize for_each_set_clump8 macro
Date:   Mon, 25 Mar 2019 15:23:47 +0900
Message-Id: <e71d49801f040bb01e7c8893f80c8504edc40718.1553494625.git.vilhelm.gray@gmail.com>
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

