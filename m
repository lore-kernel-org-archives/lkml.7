Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3694C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03BB21871
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kv2gkFD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfC2DGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 23:06:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37948 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfC2DGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 23:06:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so483422pgl.5;
        Thu, 28 Mar 2019 20:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dQT+4k892SeDr0jEBp9yKTp//A73nSq2Dh+saIUctZQ=;
        b=Kv2gkFD/LfDZMH1yUpLLoQDeqknfoK2lmKmZINCPIJux3BnDlSkBr6LPLIf87oGC3b
         Ei8zGBJkWMjQ0scq5CY73vpbcAOHrmOABVjLkqQySEIBEG/aQZsqZLweiLkeNvF3Sekd
         dJClA+LYa5pkxaXsO3xK0p8NcfUr/36Ulkn81DQrZMrw6x3Ak/2kWaWrqa66vijrNFbE
         //jN8YUXaQ9cO8S+hsNa/3si9t0kDXW55ilykTX1CJI40OiIoNOa0wMnn6Gv9gODcNvZ
         ydBObKmbQ8tsbP8gSuRLqhYjuFQokdKmoY9nw+L4t4aMn09FJi4qxkYfdjqP9jjZKTPc
         V+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dQT+4k892SeDr0jEBp9yKTp//A73nSq2Dh+saIUctZQ=;
        b=toIsC1fYyNKK+nJ48IKyqv8FRkNosl51cJo9ZyJ17qMpqelG3Mumk6IhLBAlGBkhWC
         fHts/CbUM3+F0iU8OJ84/4pZ8aLyjDQ/NgVIAxj0tA2gEHcvRI1wTdUcKv/zuOt0rLSD
         AvQgd4Ii1tDk4ewpXLCiD+eBk0QDohvErCuRQ0L78EWG3GVKJ9BeQ+8Pyl6K6IvSS+fB
         T31krbJoqqaF8pbSpZSkswaLpj1Z2aDPEYVXEHRzEy31LEL8561GlBKZRng89DoDQWKG
         hPotEwnMjeiqfhjkbT92wNxeyPIcqqQLH8C6MH/x3N1iuoUSs8lSObbsLzIgf97lFGRe
         FJ3g==
X-Gm-Message-State: APjAAAUDpqSjzSOGbeRYKqhZ4jH8Vs3M6BxUIUqFAR6JAsD68ntqSpEi
        F67KfpSgPgc8cnOvrgfyzJk=
X-Google-Smtp-Source: APXvYqwvCTl69l0VdR73TwLG64piqZSCIotkCo4f2C8z4dMSswzCr5Ql2nYhiK/1MXIBZ8JY4tYZCw==
X-Received: by 2002:a65:4689:: with SMTP id h9mr17001919pgr.295.1553828771474;
        Thu, 28 Mar 2019 20:06:11 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:ba2:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id w68sm724917pfb.176.2019.03.28.20.06.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 20:06:10 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v14 10/11] gpio: 74x164: Utilize the for_each_set_clump8 macro
Date:   Fri, 29 Mar 2019 12:07:07 +0900
Message-Id: <a72dd02c5f2cdca674b279c84cc401ff526033e9.1553828158.git.vilhelm.gray@gmail.com>
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
for_each_set_clump8 macro to simplify code and improve clarity.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Reid <preid@electromag.com.au>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-74x164.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
index fb7b620763a2..de1e8b37e102 100644
--- a/drivers/gpio/gpio-74x164.c
+++ b/drivers/gpio/gpio-74x164.c
@@ -9,6 +9,7 @@
  *  published by the Free Software Foundation.
  */
 
+#include <linux/bitops.h>
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/spi/spi.h>
@@ -75,20 +76,18 @@ static void gen_74x164_set_multiple(struct gpio_chip *gc, unsigned long *mask,
 				    unsigned long *bits)
 {
 	struct gen_74x164_chip *chip = gpiochip_get_data(gc);
-	unsigned int i, idx, shift;
-	u8 bank, bankmask;
+	unsigned long offset;
+	unsigned long bankmask;
+	size_t bank;
+	unsigned long bitmask;
 
 	mutex_lock(&chip->lock);
-	for (i = 0, bank = chip->registers - 1; i < chip->registers;
-	     i++, bank--) {
-		idx = i / sizeof(*mask);
-		shift = i % sizeof(*mask) * BITS_PER_BYTE;
-		bankmask = mask[idx] >> shift;
-		if (!bankmask)
-			continue;
+	for_each_set_clump8(offset, bankmask, mask, chip->registers * 8) {
+		bank = chip->registers - 1 - offset / 8;
+		bitmask = bitmap_get_value8(bits, offset) & bankmask;
 
 		chip->buffer[bank] &= ~bankmask;
-		chip->buffer[bank] |= bankmask & (bits[idx] >> shift);
+		chip->buffer[bank] |= bitmask;
 	}
 	__gen_74x164_write_config(chip);
 	mutex_unlock(&chip->lock);
-- 
2.21.0

