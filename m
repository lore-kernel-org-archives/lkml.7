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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1560C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2C2218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5Efa6TN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfC2DDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 23:03:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43574 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfC2DDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 23:03:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id z9so468739pgu.10;
        Thu, 28 Mar 2019 20:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K34goq+zf1vvl+0PBwq115Mp4iHOPY/zupPfI+vUQAE=;
        b=V5Efa6TNudb05BAu+jsft37SCTSyK3Nz05lSgABhwTr9dPRAszIcUwdt+nYaBN1YUq
         nnkABvG5YB0g+mbL+H4YOeXLTLMWVfra7pf9w1hi3tgYPFOqdXEq4YgMudGJ6RXlcPIn
         5c+GFggYuTno7DCS2U+hdFm9EvEUaH7glYeCT87Mm6zWAm+wbuFqKOQp8QmPPHFR3Etw
         83TK9UyeSc17lP/TJB+beQzngcxHo6eJ/qlRplHyCLTz7Z2R419iblqcXAX+iG+2EMiy
         KqpBpTbVsPCTTxQ0ISWh3jNC/Q2NdMlQjPmN3vqJPH4nLlS4MCIiDiRrUSZCGIkMxsuG
         EE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K34goq+zf1vvl+0PBwq115Mp4iHOPY/zupPfI+vUQAE=;
        b=OPwCsBF6ZRRiL8yWh+kJOu4XxOa8Mng/Y+oZ+xOCTdO3Rom20ZjKK3aV8JlYt6cDeX
         8PaxaDNKi3R0iqESOfweoO68bocXl1dm7AeCuZQdD6wOO9I2cuELgL3Y713QbKXAeheq
         YCl/b6iCqlciwMORRpbbivtTtw36SAzPagkX1snlUrNkv5Tt08RebBaJ59XA6ZtQz1p+
         5Dmi7bmUVicckvTdmb8CYGJtZiM3eJ5NiJ/jgmtxePOwP9s4gvfDQ/b4pO+ogNjTMNZy
         d4khGkIGyR2DZG8K8r+z3b5gcFduS1GVzypGXRESWWcQandyoGb+9yPeiAgwLDULgP0g
         ESlA==
X-Gm-Message-State: APjAAAW68uWQSanCSxmZTbZOVXbgjQwxVA4kHQqW/Hjut16kx/ndc4Gy
        b/GRPB5O50y7PbxmH4LhaGE=
X-Google-Smtp-Source: APXvYqyMfQEASrbwMcf+1MYodXZ4CyjTM5wNZZ2aZtGMR/8wEoFz1iHj6gTxqTHYRgJfKOFim8ijag==
X-Received: by 2002:a65:4542:: with SMTP id x2mr42882493pgr.65.1553828592563;
        Thu, 28 Mar 2019 20:03:12 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:ba2:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id x9sm730532pfn.60.2019.03.28.20.03.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 20:03:11 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v14 01/11] bitops: Introduce the for_each_set_clump8 macro
Date:   Fri, 29 Mar 2019 12:04:08 +0900
Message-Id: <1cc8b30bb3954ca2a0961ffb0a2eed8a005ed670.1553828158.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1553828158.git.vilhelm.gray@gmail.com>
References: <cover.1553828158.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro iterates for each 8-bit group of bits (clump) with set bits,
within a bitmap memory region. For each iteration, "start" is set to the
bit offset of the found clump, while the respective clump value is
stored to the location pointed by "clump". Additionally, the
bitmap_get_value8 and bitmap_set_value8 functions are introduced to
respectively get and set an 8-bit value in a bitmap memory region.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Suggested-by: Lukas Wunner <lukas@wunner.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 include/asm-generic/bitops/find.h | 61 +++++++++++++++++++++++++++++++
 include/linux/bitops.h            |  5 +++
 2 files changed, 66 insertions(+)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 8a1ee10014de..45aa6d718cbd 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -80,4 +80,65 @@ extern unsigned long find_first_zero_bit(const unsigned long *addr,
 
 #endif /* CONFIG_GENERIC_FIND_FIRST_BIT */
 
+/**
+ * bitmap_get_value8 - get an 8-bit value within a memory region
+ * @addr: address to the bitmap memory region
+ * @start: bit offset of the 8-bit value; must be a multiple of 8
+ *
+ * Returns the 8-bit value located at the @start bit offset within the @addr
+ * memory region.
+ */
+static inline unsigned long bitmap_get_value8(const unsigned long *addr,
+					      unsigned long start)
+{
+	const size_t index = BIT_WORD(start);
+	const unsigned long offset = start % BITS_PER_LONG;
+
+	return (addr[index] >> offset) & 0xFF;
+}
+
+/**
+ * bitmap_set_value8 - set an 8-bit value within a memory region
+ * @addr: address to the bitmap memory region
+ * @value: the 8-bit value; values wider than 8 bits may clobber bitmap
+ * @start: bit offset of the 8-bit value; must be a multiple of 8
+ */
+static inline void bitmap_set_value8(unsigned long *addr, unsigned long value,
+				     unsigned long start)
+{
+	const size_t index = BIT_WORD(start);
+	const unsigned long offset = start % BITS_PER_LONG;
+
+	addr[index] &= ~(0xFF << offset);
+	addr[index] |= value << offset;
+}
+
+/**
+ * find_next_clump8 - find next 8-bit clump with set bits in a memory region
+ * @clump: location to store copy of found clump
+ * @addr: address to base the search on
+ * @size: bitmap size in number of bits
+ * @offset: bit offset at which to start searching
+ *
+ * Returns the bit offset for the next set clump; the found clump value is
+ * copied to the location pointed by @clump. If no bits are set, returns @size.
+ */
+static inline unsigned long find_next_clump8(unsigned long *clump,
+					     const unsigned long *addr,
+					     unsigned long size,
+					     unsigned long offset)
+{
+	offset = find_next_bit(addr, size, offset);
+	if (offset == size)
+		return size;
+
+	offset = round_down(offset, 8);
+	*clump = bitmap_get_value8(addr, offset);
+
+	return offset;
+}
+
+#define find_first_clump8(clump, bits, size) \
+	find_next_clump8((clump), (bits), (size), 0)
+
 #endif /*_ASM_GENERIC_BITOPS_FIND_H_ */
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 602af23b98c7..1d9b5efb9bd4 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -40,6 +40,11 @@ extern unsigned long __sw_hweight64(__u64 w);
 	     (bit) < (size);					\
 	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
 
+#define for_each_set_clump8(start, clump, bits, size) \
+	for ((start) = find_first_clump8(&(clump), (bits), (size)); \
+	     (start) < (size); \
+	     (start) = find_next_clump8(&(clump), (bits), (size), (start) + 8))
+
 static inline int get_bitmask_order(unsigned int count)
 {
 	int order;
-- 
2.21.0

