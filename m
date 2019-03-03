Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5975C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 07:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A797F2070B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 07:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXiKnpZe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbfCCHsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 02:48:53 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40700 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfCCHsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 02:48:53 -0500
Received: by mail-pl1-f196.google.com with SMTP id bj4so1019082plb.7;
        Sat, 02 Mar 2019 23:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wovyItwhuu6up6N9d5xqiEvzR3TkCWii5hwPk2X/3Vc=;
        b=eXiKnpZevNwmTcamVOu5dvTkOTzeJHUS3N7oxCh6oN/eUC/IOXFVHczGOZY8H2SvOW
         viPL4N0S1C/g4As1/2iqAQTqsfv+d38J4qd3qqdWMFDk6Xbbvkii2F6HjFpYNY2aBnbc
         jZCgn1XWouMsQvMbdAE7gO78LifKT8C128YaA2pZRvmWBFUflqzJJgrreU/EkDQDlMQM
         c5G/rnuEjk4PYxWPYI6E8O2ev2mU81LWbY9xRTKq+8TcBVcwsV+ZS4u5ElX5KG1l8qBl
         ABtV0SlWBwBrSGS1td16eDdY8vmaunw9R0S/coPVgaGvVAyWmTB6qRMTVHWey87B/57Q
         r+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wovyItwhuu6up6N9d5xqiEvzR3TkCWii5hwPk2X/3Vc=;
        b=XAVdFccmiMa7G+sav5kKgjW3CJovouf22cIM0EaKq5Rg0GFqddng8bW1h7Bj8nept5
         1eYEEdoSJtkIBHw9+RGRvp1VZxbep0d38AOxCU2VzkKgUbvMDmoiXl8bf7aW+sEOcs+g
         jsJ0qsDXLN9z0Ayeqttc7HqFG51485c3jPqjqrbVZRsc5fDHws48RlcZB/8tGVDZzj6h
         wdp/QE1p1BgseKj1H6JkGKA31Jdcl9Mr01dVueKWgEOz8uv/9tFNV6hTPWqrNjfXdnqM
         n/igg/jMdl87YSPecBdN/SqoKdeOflwAjTsY8eewywB6dfVYAWB42uXmKzEX6dDv36Az
         lRQA==
X-Gm-Message-State: APjAAAXAsRqBVFcvMlFFdx+SErskgFIXjIe/LXrWjJ8sr0W5+4lH7g80
        nx+nF2Kj/6wvqG2fSv+mE4A=
X-Google-Smtp-Source: APXvYqxKvXnNRkzJ3XKz8Dvb0TZTczUrUD0RwTzhdC44b8wCEU11Ii75h7s7ilHi/hAKi8sdJSYEVg==
X-Received: by 2002:a17:902:a414:: with SMTP id p20mr13908371plq.289.1551599332376;
        Sat, 02 Mar 2019 23:48:52 -0800 (PST)
Received: from localhost.localdomain ([2001:268:c0a5:3b5c:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id f125sm4464483pfc.91.2019.03.02.23.48.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 23:48:51 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com, bgolaszewski@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v9 4/9] gpio: 104-idi-48: Utilize for_each_set_clump8 macro
Date:   Sun,  3 Mar 2019 16:49:39 +0900
Message-Id: <1292b15bc62e72d01d45e60fbd33a4da850fa2d5.1551598603.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1551598603.git.vilhelm.gray@gmail.com>
References: <cover.1551598603.git.vilhelm.gray@gmail.com>
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

