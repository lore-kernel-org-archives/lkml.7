Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D20C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71BD420657
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjdEB03/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbfCYGYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:24:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42037 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729604AbfCYGYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:24:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id r15so5627642pfn.9;
        Sun, 24 Mar 2019 23:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UifkzEkFRqXu3yixaaw6yvTChu7M21y6ZQxvlg1zFMs=;
        b=YjdEB03/bL1qKLf54ZWZ8Cx8OaY4qHeFXqQC7ahjJw8t+9gRJWPkqjZQmVg68+HOxl
         InLiArYk1FQUAaK5yZ15U+19TSrApltw0szFgOZp951dNfdKInl3WRNaODE9rwS9TPeI
         2EVc4ci3AjiI57FtJI8zX/Ltxw+tSNMiuTDebpgwgiZkuct/tK42MzJoMqYSd5e6eh3Q
         nazprjUW2izeF4aU7CwO2Ql3NU0ltrjN940DzpNeLQsYfRqggxUKQaVRvDbw2JWdtiBC
         HYdljrEbZyvLJwOgg4kAHslQfgVr9fKAlgU51RG72WR+UL/pls6UnDcLZuTwHosZsyUJ
         wLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UifkzEkFRqXu3yixaaw6yvTChu7M21y6ZQxvlg1zFMs=;
        b=C9ektOF/hewTN/QGFoGUptoela2y6jV5mf4klr3eh7St7yVVEcc9bIYfCV+WX04fAl
         UNne5NAEE8MoDK1RqJ6Xxs1u77k0ZU4mbVUhcP2DPG5TNYOfnGQlHQgMvKHa2j6hdQYV
         vxwgb+5DFnVKegfuknCnM6BPaxYmbe+SEm9/5usEGGFrIpJRCRLoG1wMGS/bkMrmHL5n
         cFFwLjsL6u0TI7W6Kb/TfzqptbR9LajEbAb5gfdWFMyKCPdjnWEABcYxALUPz/oTx6lJ
         28zICmkv0KuyGi/FWxpSgTS/y8GkaDg+lejj5dCzeb7SDheApvVZ4r37oHmiqoDFiZtM
         ZXlQ==
X-Gm-Message-State: APjAAAVOtaGphgV9ojV8WcrVCz9dl2dBTxQJ8QWyjfzZ4ix8pWsWAi4J
        ezhymolrcRZSbl6+WkTVJE8=
X-Google-Smtp-Source: APXvYqx2Mogi4mKA6cNteEHUGvt1E0/OL97PltBMxG53qeXqJaUKoPqFLm2al+SPbMrYgjLLPRx5Hw==
X-Received: by 2002:a63:234c:: with SMTP id u12mr22229188pgm.282.1553495086111;
        Sun, 24 Mar 2019 23:24:46 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:e068:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id p88sm24194193pfa.80.2019.03.24.23.24.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 23:24:45 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v12 09/11] gpio: uniphier: Utilize for_each_set_clump8 macro
Date:   Mon, 25 Mar 2019 15:25:41 +0900
Message-Id: <4d45bc472fabd5f5339a182782b27bd25f82cd49.1553494625.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1553494625.git.vilhelm.gray@gmail.com>
References: <cover.1553494625.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace verbose implementation in set_multiple callback with
for_each_set_clump8 macro to simplify code and improve clarity. An
improvement in this case is that banks that are not masked will now be
skipped.

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-uniphier.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-uniphier.c b/drivers/gpio/gpio-uniphier.c
index 0f662b297a95..df640cb29b9c 100644
--- a/drivers/gpio/gpio-uniphier.c
+++ b/drivers/gpio/gpio-uniphier.c
@@ -15,9 +15,6 @@
 #include <linux/spinlock.h>
 #include <dt-bindings/gpio/uniphier-gpio.h>
 
-#define UNIPHIER_GPIO_BANK_MASK		\
-				GENMASK((UNIPHIER_GPIO_LINES_PER_BANK) - 1, 0)
-
 #define UNIPHIER_GPIO_IRQ_MAX_NUM	24
 
 #define UNIPHIER_GPIO_PORT_DATA		0x0	/* data */
@@ -147,15 +144,14 @@ static void uniphier_gpio_set(struct gpio_chip *chip,
 static void uniphier_gpio_set_multiple(struct gpio_chip *chip,
 				       unsigned long *mask, unsigned long *bits)
 {
-	unsigned int bank, shift, bank_mask, bank_bits;
-	int i;
+	unsigned int i;
+	unsigned long bank_mask;
+	unsigned int bank;
+	unsigned int bank_bits;
 
-	for (i = 0; i < chip->ngpio; i += UNIPHIER_GPIO_LINES_PER_BANK) {
+	for_each_set_clump8(i, bank_mask, mask, chip->ngpio) {
 		bank = i / UNIPHIER_GPIO_LINES_PER_BANK;
-		shift = i % BITS_PER_LONG;
-		bank_mask = (mask[BIT_WORD(i)] >> shift) &
-						UNIPHIER_GPIO_BANK_MASK;
-		bank_bits = bits[BIT_WORD(i)] >> shift;
+		bank_bits = bitmap_get_value8(bits, chip->ngpio, i);
 
 		uniphier_gpio_bank_write(chip, bank, UNIPHIER_GPIO_PORT_DATA,
 					 bank_mask, bank_bits);
-- 
2.21.0

