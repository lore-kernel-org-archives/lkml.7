Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFBEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D502075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uQyk8R0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfC0FB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:01:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38580 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbfC0FB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:01:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id 10so9147170pfo.5;
        Tue, 26 Mar 2019 22:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kZSRiSxJh+YYsNmeIydN7WXteuBFfpjUBowwMs4kNhU=;
        b=uQyk8R0py7UcGbhlLGdW/9Nv1ykF7ezJedfRqJMZf/2BH3uU9YMwLv2AxpRIQEL0tJ
         fDXgKX03TyTUWCj6FdlVlx/c6dkOR5uhFbuJhHI4Rj0v+bnjAja5EdqVQV8O7OJYzZNY
         RzrxlaON7mgw22IlE+Ni4o7/M93Uvmqm0wxO75WjbxSNo9v02/tMYCmyKC/Clu0r1KLj
         fyPBXTegeWjZzictHs0EG+R+dyS+YT3GH8vNhX7VsYq0bVF4BTEqrTx0S699XB+LmHeB
         GUdPF1POnQGe2cFxFE36FF/by/CVHbwwC8JTZoDLuhD/U3YBPqMKWxD+7KibfJLUmbfO
         tOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kZSRiSxJh+YYsNmeIydN7WXteuBFfpjUBowwMs4kNhU=;
        b=BMn7zfNbGh5opcIphf7+eZ8ciaKamd/ui8uqjbNwitLSY6ZQnMGZJ6ecDgg95teIkv
         1jk/hjmI4l2ehWawu2R23KZMEOqkyGf6JORLfUcLKj3zt2Sp8Ei9FyiXpRJn9aLylTqb
         Tef1WPWv34xht/hZXU+J4N7ykRj8op172nAPJEPOZZYUigaEUydiUYa3B9lENj4MVUf5
         VV1Qi3ZMO1PdtPD1WFq5iBz69ESjFtatQHbaF2DsNVq1IiL77Z/5WVu20DGUQDBTv7mw
         ZBhqDGKuRGO1L5HQ6zgxP+Zzn5UrBaxVE4/lo39xmeWOldBbZa/Wei5rig/beXd5Ot+J
         7dmA==
X-Gm-Message-State: APjAAAV5dRCVMJbXDApkjGA1lmgu5kNLkgf2MTpdkGIEO1DMLDdBtoW2
        SlHdrhUo/6Z9PDVhSYatdRM=
X-Google-Smtp-Source: APXvYqy8chgZQxN1dbU1Rt8odCCSTgnvSjwQecTcyPAZzo6VKRdqUrpBsaL34+XVHdAO/Z1iurzsAA==
X-Received: by 2002:aa7:8190:: with SMTP id g16mr6378755pfi.92.1553662885842;
        Tue, 26 Mar 2019 22:01:25 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:6014:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id k10sm31080261pgj.11.2019.03.26.22.01.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 22:01:25 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v13 09/11] gpio: uniphier: Utilize for_each_set_clump8 macro
Date:   Wed, 27 Mar 2019 14:02:20 +0900
Message-Id: <a06773f804f02086b3ef907184d5799e8820eb48.1553661964.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1553661964.git.vilhelm.gray@gmail.com>
References: <cover.1553661964.git.vilhelm.gray@gmail.com>
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

