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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97058C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 04:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6527B2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 04:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ttJmL44t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732411AbfC0E64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 00:58:56 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36622 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbfC0E6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 00:58:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id k2so2721881plt.3;
        Tue, 26 Mar 2019 21:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tvDsEaR5RVMjQmpl7pvXE6aMRh7V9pplB1t4MlLyGlo=;
        b=ttJmL44tLwmeymwJk21YO5pD2dbq91CaeW1b2AyPJi9Sl5J2FnhLhAjxGI07JVZ0ev
         GAUnoTmThB2nh0kOiZNRgIRXh9sUjgXjGLE7RRHXP0MLUC4EkXkBDSstM64EDRJ6YqqS
         TFtKVyWQCYL3irrd6qYAZs8JbDNwm/qw8n6UdWxC1aXCjf3zpnvbubMqR2FvGESakekj
         DvJserniuhIzf91JoYxCeyLD6opMp7lemdpPjpAoADet3HJvymtnIIY27MJF92IUjXTS
         +uRkEYqZ4T84bPPnrXA36HLVVVOxcGIV7XMwEe8Gpsx1FuSe0yq4UCs9g1kDr15iuSUs
         uz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tvDsEaR5RVMjQmpl7pvXE6aMRh7V9pplB1t4MlLyGlo=;
        b=p9XmdMyNM8V+wc8t340fA27pcPiYp26slEDfSumiWxq0ZWtT3u66De4tWpKG/O96kG
         CZtqLPU6OTrm1p5k1pfKuAUJ8oros1NBfLPpo6nzFHxY5dHyROAWEURL+zth2uVCe0K+
         rNo2e8UAtMogOrUeEOKZbBRWk5XokDxSkwI2ewfBUtzIZIVQOkQ0yaKQva8jEKzVxzEZ
         CWL4GdSB/bop8dmspcarDtHcyB2qbkUkm1s/pi1SkjEAR3wAtJmdvZamBYpBFSAbeZ9j
         Wg0IJmR1VYEzRg2td2A4EzdfGw1to4V5b6V/dL7I39Y4TKnkDg4dL/s0g0DuPot72oUw
         kbdw==
X-Gm-Message-State: APjAAAVsJ47pMz/H7Fu2zZi5uv+2WYIuXTXvf4yEZJkXV9g2ON6Ul1Qe
        VkXEmdUKhIHXhBvQlQ6pRJU=
X-Google-Smtp-Source: APXvYqyqCK2pgNbDSWh5tfKVfkD1OLh24THmdaZzxauSeDG2Mm7+3YUTDtyZf8C5ZYbDUHkhAAYEqw==
X-Received: by 2002:a17:902:988e:: with SMTP id s14mr22560082plp.167.1553662734795;
        Tue, 26 Mar 2019 21:58:54 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:6014:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id l19sm877015pff.1.2019.03.26.21.58.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 21:58:54 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v13 04/11] gpio: 104-idi-48: Utilize for_each_set_clump8 macro
Date:   Wed, 27 Mar 2019 13:59:50 +0900
Message-Id: <1476995eb0bf988b4a3cc27f0e5e1484933d93ec.1553661964.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1553661964.git.vilhelm.gray@gmail.com>
References: <cover.1553661964.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-104-idi-48.c | 36 +++++++---------------------------
 1 file changed, 7 insertions(+), 29 deletions(-)

diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index 88dc6f2449f6..9b43964b0412 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -93,42 +93,20 @@ static int idi_48_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	unsigned long *bits)
 {
 	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
-	size_t i;
+	unsigned long offset;
+	unsigned long gpio_mask;
 	static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
-	const unsigned int gpio_reg_size = 8;
-	unsigned int bits_offset;
-	size_t word_index;
-	unsigned int word_offset;
-	unsigned long word_mask;
-	const unsigned long port_mask = GENMASK(gpio_reg_size - 1, 0);
+	unsigned int port_addr;
 	unsigned long port_state;
 
 	/* clear bits array to a clean slate */
 	bitmap_zero(bits, chip->ngpio);
 
-	/* get bits are evaluated a gpio port register at a time */
-	for (i = 0; i < ARRAY_SIZE(ports); i++) {
-		/* gpio offset in bits array */
-		bits_offset = i * gpio_reg_size;
+	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
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
+		bitmap_set_value8(bits, port_state, offset);
 	}
 
 	return 0;
-- 
2.21.0

