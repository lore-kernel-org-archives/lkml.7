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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F53CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B937205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUZivDN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbfCYGFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:05:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34617 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbfCYGFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:05:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id b3so4229275pfd.1;
        Sun, 24 Mar 2019 23:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UifkzEkFRqXu3yixaaw6yvTChu7M21y6ZQxvlg1zFMs=;
        b=cUZivDN2YWWNLkTIYSS6FpIHofsi9nxbjKjplH5GCWNdwnLqzZLYIHVzd0DMyNb/0F
         JfvRjZ39ub+vB+JlNnJEulAXTcC7kJCoZXroxbm64jTDrNDOr/ZgrG98g6gkXJeJ7dkF
         n8ZCBvTgQUvXlBy7f2DZvi3loBxuDWodB8DoWyK2LWYGThL5u6qi8s1mFYVG75RKASyQ
         +VmBfU5mpq0ZYbg76cUhEA3lB5K2OxKme606WKXH2PdIjwEOFJtgY1Pe07L3eicxIHYT
         OpZqL7ktiWVKWd21K2HYs/5QGn0TPruxFiaY2p2PiFcALREQNBY91tY39orS71lN5eku
         w27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UifkzEkFRqXu3yixaaw6yvTChu7M21y6ZQxvlg1zFMs=;
        b=YkLR2muv5Z9psikLRjMBrOaJqmgFsL+N+yjMWl6fHxLiX/k/4Cd2ZJDrJBvUVVG204
         +l24/6m0+ir1q7TwThSzzVAUBIgxa0endMEZDOhv9HFJQjYXup6ERENFs19gTB0dk/D6
         bHa22Mg1j88UqrA4loNS6uOD7wrPp0JBesCaIpglNsrxh8Vk6TJEykAmC2OUXrxNzIiL
         XJsaXpzhXaAMRlwcHVaPXSLG62ssCKMn3brQycT1+cBeLfnffmP82G/sB6w3rM2Pg7hg
         l42Fr7Ggwim6Ki2SGGQI+P4DT/aXKoYAkWE0s0i23ZZHQWcPvtZPGr7mTNhAAC7q6Nlw
         Z0qg==
X-Gm-Message-State: APjAAAWQwM5PH4HzKB6nhuSDwExWse4u5+TsnRagifeWHSu7aAdYv9Rl
        1fAM9eXngc+2x5f03OX2zXQ=
X-Google-Smtp-Source: APXvYqwW/zp/Q8To3dpTdoxUCtqXaOHNaAgv7+rJZJtMlrJQoCPCu3MGz2qZUjdACT3vJv1BfuwrqA==
X-Received: by 2002:a17:902:121:: with SMTP id 30mr23719883plb.315.1553493913056;
        Sun, 24 Mar 2019 23:05:13 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:e068:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id w123sm21668681pfw.72.2019.03.24.23.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 23:05:12 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v11 09/11] gpio: uniphier: Utilize for_each_set_clump8 macro
Date:   Mon, 25 Mar 2019 15:06:09 +0900
Message-Id: <82b21a3c4f84bad98487c450a8b3072ecf1c44c3.1553492741.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1553492741.git.vilhelm.gray@gmail.com>
References: <cover.1553492741.git.vilhelm.gray@gmail.com>
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

