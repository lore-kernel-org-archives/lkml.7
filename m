Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0600BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B52206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sS0MVDMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfCNMbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:31:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34198 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfCNMbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:31:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so3899507pgq.1;
        Thu, 14 Mar 2019 05:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UifkzEkFRqXu3yixaaw6yvTChu7M21y6ZQxvlg1zFMs=;
        b=sS0MVDMDyFcESOfK3Nol8/Q9B+4Nq7OBizGym/jfhkZlhXLU9qaRP6cu4TLyqsxpdP
         T+67ww1K+a5bDz9/uvJhZpx6XAt7LqHkiY/4jGQ2K/Uv9ycyFEHqD6MpWTX5D+/C8LZz
         nWCrs2WKQJv3X+k+icsJNiOYtS5hdrVOS1OUExDpeDyHGC+b/pxVo7yVviZDGh9EnES9
         U5QXzA5y4Yp9wgoTr9uinS/Bdy73Ls7b0q2iQ+LuKofZKwy/AnpKnF8xTIZfs0IL98hf
         fds9yWMwj/yd22EWN6ACH+4PQv9V7c8xm2pQ4BQ1E1sUQ3f+ezVaXEXRZpiw0m6bEMhN
         vquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UifkzEkFRqXu3yixaaw6yvTChu7M21y6ZQxvlg1zFMs=;
        b=KnrPquOF77g/ofOxnBUcNPuQj6u6a8Cth7bV6AyLXJfUlMEmKJbWM9T7DnrqoJUgjn
         QdaC9qVCqRbrbSyqw+yhwnEHCy/fSyBTyDjgv//7w44p/FQtJnBn+ApjM/sXMj1huHob
         nar4VV1E+qwIe+6oRgj0ouwe9yYfSmwJ65jCZuJ82u4loqQ+qk1n2/1WRdg58JWF8siX
         xRiN85V8JymfOqonEd/Lz5MBaq2hPfknY9S9EoJaYAKTpPapSkVvRyUmOjIKVhppOnWc
         ajRc1cgGioU3R9nVVzKsVIEounzIAbCnObcFRb+D1IFuTl6wPSdHi8ykwl35KF4LMVNh
         PaCA==
X-Gm-Message-State: APjAAAX5uHII1nTJb0j4laKLUc65ro+COXDkrQ5zLVfWZMDQrxeACodF
        JKVDjrDjQxDq330G8OP88UQ=
X-Google-Smtp-Source: APXvYqxRMyrpEmHYR/ILhPTW1Bg/IeYMXzo2jTUTJ/0icyFY2AGGTdVBvD1DUJFo/IuPL0FXmtdrZQ==
X-Received: by 2002:a65:4547:: with SMTP id x7mr36531973pgr.350.1552566706556;
        Thu, 14 Mar 2019 05:31:46 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a4:3974:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id l184sm23077547pfc.41.2019.03.14.05.31.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 05:31:46 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com, bgolaszewski@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v10 09/10] gpio: uniphier: Utilize for_each_set_clump8 macro
Date:   Thu, 14 Mar 2019 21:32:37 +0900
Message-Id: <9487b6bd8f9c2242448729f5f8fc9534f724b221.1552566114.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1552566113.git.vilhelm.gray@gmail.com>
References: <cover.1552566113.git.vilhelm.gray@gmail.com>
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

