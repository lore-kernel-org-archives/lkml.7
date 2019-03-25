Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC485C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B79E7205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tniDY5Ew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbfCYGZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:25:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40154 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729604AbfCYGZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:25:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id c207so5639667pfc.7;
        Sun, 24 Mar 2019 23:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p6jZFM4uKZmmd8N/chkful+ZD8FsiAd/9uwJICIJ0zk=;
        b=tniDY5EwLN11L7eu43+i1s1Bf9E9i7HV2YfeauI/peDqWD8tGU2R5dqkOGctVVJfui
         i/MvRy8sQhgXUU+mbgvuG+h4RWexOCRA+Veg33w1T1wS27K5s9bZtVaPqvz5lYHzvNWZ
         0nEhRXKCrs3I5AZHdYyf7DvHyGOu4dMOG1Olkpxka0j9vHxPRafIAqNBziUcT42FpZLf
         a+mcGGU3PqcYQYVW6iV6tlfBd8ofNO/IroRs1xEsBNyX0laAYfFqpWceLJ9gAx4RXGOs
         YFnFUMbb3/gt2wVY/Y1nQBUWI+yd5fM13fOzVrkYsBUsi42cqUKJm5mNXXmxe7bLiDUo
         em5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p6jZFM4uKZmmd8N/chkful+ZD8FsiAd/9uwJICIJ0zk=;
        b=rukyfBeqc0Ns+0kmpKKDWDffADSm+ZhT7tcVkAPMiiVMjeK95hlJ9mX7/f1nt05Gif
         25yKjtMc9RV1gdfJFCdbdLg1hHwpq3Ue3uhud8u2Z9iKQHK55fyQHAlOR5cFuwSe5/oh
         nTuQN7k54yYmWI5/anGwCXNi3qPM84QF35libT3dH275yuN1Vlh8zgdc6jjnhnxKhXvx
         wjg1e3E1cno67/HIbe7bGdfROdrdYPUm8V328mv198ZMz5R+JWRG9pYQFa18Xu06FEDo
         oQBGLLkqFDin2nv/DXnUlJvuJR3SUgAvLluQAdb5MJN/8uTlSM2dZLkj/kNMX3pcbHe0
         tZrQ==
X-Gm-Message-State: APjAAAUZsc93FISDueojh7j96Yo/sOzBadyBnR5BHT/qnDz+RT155hx4
        fcI1FR6TGgFXLFZkslfoYwE=
X-Google-Smtp-Source: APXvYqwsG4wMT6D5NTstH+BJC+sL2uKdKWfZk0yHRaCFUmLDoDJQF0+Xwfb5A5errea2GsbkTYEN8A==
X-Received: by 2002:a63:470a:: with SMTP id u10mr22217094pga.17.1553495124097;
        Sun, 24 Mar 2019 23:25:24 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:e068:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id a65sm19978589pgc.72.2019.03.24.23.25.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 23:25:23 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v12 11/11] gpio: 74x164: Utilize the for_each_set_clump8 macro
Date:   Mon, 25 Mar 2019 15:26:18 +0900
Message-Id: <d3cc8680aa3d0d741649ac7402a213db1a789583.1553494625.git.vilhelm.gray@gmail.com>
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
for_each_set_clump8 macro to simplify code and improve clarity.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Reid <preid@electromag.com.au>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-74x164.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
index fb7b620763a2..e43a6de3b6eb 100644
--- a/drivers/gpio/gpio-74x164.c
+++ b/drivers/gpio/gpio-74x164.c
@@ -9,6 +9,7 @@
  *  published by the Free Software Foundation.
  */
 
+#include <linux/bitops.h>
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/spi/spi.h>
@@ -75,20 +76,19 @@ static void gen_74x164_set_multiple(struct gpio_chip *gc, unsigned long *mask,
 				    unsigned long *bits)
 {
 	struct gen_74x164_chip *chip = gpiochip_get_data(gc);
-	unsigned int i, idx, shift;
-	u8 bank, bankmask;
+	unsigned int offset;
+	unsigned long bankmask;
+	const unsigned int ngpio = chip->registers * 8;
+	size_t bank;
+	unsigned int bitmask;
 
 	mutex_lock(&chip->lock);
-	for (i = 0, bank = chip->registers - 1; i < chip->registers;
-	     i++, bank--) {
-		idx = i / sizeof(*mask);
-		shift = i % sizeof(*mask) * BITS_PER_BYTE;
-		bankmask = mask[idx] >> shift;
-		if (!bankmask)
-			continue;
+	for_each_set_clump8(offset, bankmask, mask, ngpio) {
+		bank = (chip->registers - 1) - (offset / 8);
+		bitmask = bitmap_get_value8(bits, ngpio, offset) & bankmask;
 
 		chip->buffer[bank] &= ~bankmask;
-		chip->buffer[bank] |= bankmask & (bits[idx] >> shift);
+		chip->buffer[bank] |= bitmask;
 	}
 	__gen_74x164_write_config(chip);
 	mutex_unlock(&chip->lock);
-- 
2.21.0

