Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDD3C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57287218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YytU7O4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731804AbfJIP16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:27:58 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:36961 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731785AbfJIP1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:27:55 -0400
Received: by mail-yw1-f68.google.com with SMTP id m7so961733ywe.4;
        Wed, 09 Oct 2019 08:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W+SY6yjQG6ah82xj2QYbshpM9aG1FiA4CAoNvKBotSg=;
        b=YytU7O4Mr0gz7kyPQD4eZtBeA5dJSUNfBOhztctdYxmLpl7HVtMLdxEx20d9wYV02I
         T7NN/5qhMHUYYJfhzJKA3JVtpElQDrumt6yQPI2mja+XbTCSpl2V8kCJ7DXU20Q7S6NJ
         hIzCoosqtECV+MMvbIyPyjs7dsKOgCuOlwL+wCOInPovvX5/0/A1aQGBI6vGS0FA2Vy2
         UcA1uSnuRf7hgNzuaRIpr9Kh9NEIF34qHnRASpyn8OrRGC4EXuEwGBpYr4jB8Vjm9MfE
         Fg9IIDFjgDMapqezD9Nz+n/lDgAKFhZxNfbRoRZY7miIbYS/CP7zTCTN3gOlk3d53I99
         liDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W+SY6yjQG6ah82xj2QYbshpM9aG1FiA4CAoNvKBotSg=;
        b=lPgXpUaJ7U+GKlEwajwdAQ2wdwbeXNx6tpMMQvpn4A9s165mRP8cniWSaV/LJ+m2DR
         xTHXWtf1EZ3s+8Bb9ztXMw3fgGnEMTMZuRe9R4Fy+NItNWPwNuPllPOCwU4+mUtV3e7v
         Qq3hig4i0bjD6jPQCUyHmd5CRq1ZGv9h5jJrImFgJ6o7Yc5Fxex0IY+HHp2mFee3wK31
         XT6aYJjuciY1s34onPjCFU/Jf0BbkUNhOhSMthOiFSIZghku2aZg0anRt/zlOFPpGY+Q
         tmMCGdGBuyCrHxuAvGQugiXGOJ7TbGXIyfGJfjfv/CE22ON6z9TX5NEPA0dazTQUhtPh
         oM+w==
X-Gm-Message-State: APjAAAWipXBJ+LRM2y6gFQ54BROKHAWWUoQokhKcHAnR9K00nDFU5Fpt
        zL9X+h43s5yUB4WdQwy8jq4=
X-Google-Smtp-Source: APXvYqz+pLjuNWlBOfyulbj8EF+i7KB1FzRSxzXYbcY2yuK76RkXlB0ER4nJL58X2PbinSF8InFkgA==
X-Received: by 2002:a0d:d7c2:: with SMTP id z185mr3088421ywd.156.1570634873928;
        Wed, 09 Oct 2019 08:27:53 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id g40sm611863ywk.14.2019.10.09.08.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 08:27:53 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        sean.nyekjaer@prevas.dk, morten.tiljeset@prevas.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v17 12/14] gpio: pisosr: Utilize the for_each_set_clump8 macro
Date:   Wed,  9 Oct 2019 11:27:10 -0400
Message-Id: <7a6080c8fb003ae0fb6a40da103faeabcadb0204.1570633189.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570633189.git.vilhelm.gray@gmail.com>
References: <cover.1570633189.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace verbose implementation in get_multiple callback with
for_each_set_clump8 macro to simplify code and improve clarity.

Cc: Morten Hein Tiljeset <morten.tiljeset@prevas.dk>
Cc: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-pisosr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-pisosr.c b/drivers/gpio/gpio-pisosr.c
index f809a5a8e9eb..9ab2c044ef52 100644
--- a/drivers/gpio/gpio-pisosr.c
+++ b/drivers/gpio/gpio-pisosr.c
@@ -96,16 +96,16 @@ static int pisosr_gpio_get_multiple(struct gpio_chip *chip,
 				    unsigned long *mask, unsigned long *bits)
 {
 	struct pisosr_gpio *gpio = gpiochip_get_data(chip);
-	unsigned int nbytes = DIV_ROUND_UP(chip->ngpio, 8);
-	unsigned int i, j;
+	unsigned long offset;
+	unsigned long gpio_mask;
+	unsigned long buffer_state;
 
 	pisosr_gpio_refresh(gpio);
 
 	bitmap_zero(bits, chip->ngpio);
-	for (i = 0; i < nbytes; i++) {
-		j = i / sizeof(unsigned long);
-		bits[j] |= ((unsigned long) gpio->buffer[i])
-			   << (8 * (i % sizeof(unsigned long)));
+	for_each_set_clump8(offset, gpio_mask, mask, chip->ngpio) {
+		buffer_state = gpio->buffer[offset / 8] & gpio_mask;
+		bitmap_set_value8(bits, buffer_state, offset);
 	}
 
 	return 0;
-- 
2.23.0

