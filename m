Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC7EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFB52184D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWnGgzBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbfC2DFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 23:05:53 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46599 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfC2DFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 23:05:53 -0400
Received: by mail-pl1-f196.google.com with SMTP id y6so294065pll.13;
        Thu, 28 Mar 2019 20:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kZSRiSxJh+YYsNmeIydN7WXteuBFfpjUBowwMs4kNhU=;
        b=KWnGgzBWLTCozh/KEfa65tk/St87oTo2wJuOL8E3BE/4C/OrqxarUzYbKBOoU92/gT
         YfusM2bZaX6obDHs5GmmuXS4odkAhdmnuBrUz/beSE9jdxS1Ctbvk+nvHdfMm3ox3iT+
         gKgoQcVto1yN86P3yQe0QbCdDEx4A+QuQ8l4WRVQoL8xoVfv1PdmzsGgooQ4QbTK/4fc
         RPHibIoV+U9gApNGjB8Grlnx67InMK/tSLNJJSepysfjqJGcm33oiVjwyze5UHeysmpQ
         6vCAE+hUNF+OTmfHN7g4e/zQOM5phBt6mOyH2u4+I8sF5pOEOtA1kk2AArCruucLQpcf
         N7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kZSRiSxJh+YYsNmeIydN7WXteuBFfpjUBowwMs4kNhU=;
        b=U5OzNauYY/OHxnqEbGUFM6+jlgNFI3a5NL+4TLQoTKy4LOO92HDowj3tYkbX3VxXY9
         bPZcKJx8lbkTMtVR1J1CwyvhWWhEEQctRDO76TAC0IMhjyms7N4TqPqlxI5aStR98nlH
         n9PLMpePgVBHad8FOyn5sMfy9T7MS3Vir5/9PKi5jETHqD6azUOYKaKRiWNeIMJaoMlr
         r+MZeyKTq8ARWJ8TcGMY2rp7ohjh8l9k6DmoXMWh4eh0bE2WWIXzgtgs2eXL2rQ31q1F
         odcRJ+Nk0vvbdy11YT7gDAuQcTC+tpaolfU0C/i7+Vh0YTAHAemNcKz+Ci/9OlUwAZ9x
         dPKQ==
X-Gm-Message-State: APjAAAWljXkTUt3F+Nx9KnAoMpJfxDww3WxRCROgyv7XvaHdgGMuBsOB
        RlFwL9R9zqd5JzfP/JK5ivo=
X-Google-Smtp-Source: APXvYqzjdiuEQzvKUGIzvn81X4Wqs4VOKQtF5LYTH98WcXqThbgwMjoEZHdlwlbGWk40c4f8F8ThSg==
X-Received: by 2002:a17:902:b418:: with SMTP id x24mr39789647plr.323.1553828752410;
        Thu, 28 Mar 2019 20:05:52 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:ba2:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id 4sm697551pfo.110.2019.03.28.20.05.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 20:05:51 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v14 09/11] gpio: uniphier: Utilize for_each_set_clump8 macro
Date:   Fri, 29 Mar 2019 12:06:49 +0900
Message-Id: <9758aea685bbc9b6b148977880b971920e7b97b6.1553828158.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1553828158.git.vilhelm.gray@gmail.com>
References: <cover.1553828158.git.vilhelm.gray@gmail.com>
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
index 0f662b297a95..d79c34e9b23b 100644
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
+	unsigned long i;
+	unsigned long bank_mask;
+	unsigned long bank;
+	unsigned long bank_bits;
 
-	for (i = 0; i < chip->ngpio; i += UNIPHIER_GPIO_LINES_PER_BANK) {
+	for_each_set_clump8(i, bank_mask, mask, chip->ngpio) {
 		bank = i / UNIPHIER_GPIO_LINES_PER_BANK;
-		shift = i % BITS_PER_LONG;
-		bank_mask = (mask[BIT_WORD(i)] >> shift) &
-						UNIPHIER_GPIO_BANK_MASK;
-		bank_bits = bits[BIT_WORD(i)] >> shift;
+		bank_bits = bitmap_get_value8(bits, i);
 
 		uniphier_gpio_bank_write(chip, bank, UNIPHIER_GPIO_PORT_DATA,
 					 bank_mask, bank_bits);
-- 
2.21.0

