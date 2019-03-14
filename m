Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6192EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258A020693
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ck7GLcpy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfCNM3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:29:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44260 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfCNM3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:29:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id a3so3712902pff.11;
        Thu, 14 Mar 2019 05:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fq6Xm53C+heMXT2c+ND0di1HUX14yEET8qKlzoFNfpw=;
        b=Ck7GLcpyG6wLhHl5A0PNRGDMVGSWdvreR9shUs1kcEsyr2w4FWN/ygos1sZsT+cdCi
         7dTW4CTApaRASe7cnYM84Szvazoj5wTcuCpYy76YpyGYSPVhNSAMI+EYoQ76cPzQfhiA
         OIJjRDAy5iTMszFp5hdA0uYdMOq8ncPn7ClCUCxsW7bSyAdcMBE79dpg3fF7m1mFUNFs
         xh7W9PGxIafqueYac7Nhdoi5FXQucwjz9D/MMRabWS9HNyhBMmw+2wnTlOAJlIUeiWoR
         pcCq/VDhlJn+SGD96E1MC1Om44ckVDoZJWQh+huf3+2u475PTfSiu3vfIOS7xqbILtmD
         DaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fq6Xm53C+heMXT2c+ND0di1HUX14yEET8qKlzoFNfpw=;
        b=c6lOV66mF52jqxbZctFuNgBNI2jkZKpVAkHf3FREkj+oYow3+ICMRcSKKZau6b6dc6
         yHrI3fVesdv04OPbsP5qRIz5LUR1rIfAs6zV/YtvJw745/DyIziA1o31aSWG4N4oUcnY
         90hbzYH15cG+GqEEmms3nEl3RwGMS1Ttbmuvv6eDZcl6ixkwSUlQiQ6Zn+q3NkXor0Cm
         K+C9uGcL4Z8Py118R1kJAbhwflTKfADFZWjFsSUXNwU3FWkCwD2Z0y5XP8+OKD1xigcR
         ROuYvbU7qxtQu/7+JQFiRwNbO/MSYPsIkHpSHNn8fOfCsIxSShugtZ+bA8KYhasgYzcT
         BNIw==
X-Gm-Message-State: APjAAAXcLlJh3yv2Zw3RccGEmXeWGWWssdkOU5tW6FXXwmqadFIcWuIc
        ekXsj5z8Rgwp0iyaD8QDFUw=
X-Google-Smtp-Source: APXvYqxzAQX9w1BWqiu5T2oM2H1q3X0lR4pNz3Z8C9cG00cB+QxlRrzSofJUB/mxr/DW4W0PAImhEg==
X-Received: by 2002:a17:902:112c:: with SMTP id d41mr51072666pla.177.1552566553320;
        Thu, 14 Mar 2019 05:29:13 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a4:3974:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id g2sm26358279pfm.144.2019.03.14.05.29.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 05:29:12 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com, bgolaszewski@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v10 01/10] bitops: Introduce the for_each_set_clump8 macro
Date:   Thu, 14 Mar 2019 21:30:02 +0900
Message-Id: <0e4d352418252d480dfc7d529604819f8ff88d9c.1552566113.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1552566113.git.vilhelm.gray@gmail.com>
References: <cover.1552566113.git.vilhelm.gray@gmail.com>
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
Cc: Arnd Bergmann <arnd@arndb.de>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 include/asm-generic/bitops/find.h | 14 ++++++
 include/linux/bitops.h            |  5 ++
 lib/find_bit.c                    | 81 +++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 8a1ee10014de..9a76adff59c6 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -80,4 +80,18 @@ extern unsigned long find_first_zero_bit(const unsigned long *addr,
 
 #endif /* CONFIG_GENERIC_FIND_FIRST_BIT */
 
+unsigned long bitmap_get_value8(const unsigned long *const bitmap,
+				const unsigned int size,
+				const unsigned int start);
+
+void bitmap_set_value8(unsigned long *const bitmap, const unsigned int size,
+		       const unsigned long value, const unsigned int start);
+
+unsigned int find_next_clump8(unsigned long *const clump,
+			      const unsigned long *const addr,
+			      unsigned int offset, const unsigned int size);
+
+#define find_first_clump8(clump, bits, size) \
+	find_next_clump8((clump), (bits), 0, (size))
+
 #endif /*_ASM_GENERIC_BITOPS_FIND_H_ */
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 705f7c442691..61c10f20079e 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -40,6 +40,11 @@ extern unsigned long __sw_hweight64(__u64 w);
 	     (bit) < (size);					\
 	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
 
+#define for_each_set_clump8(start, clump, bits, size) \
+	for ((start) = find_first_clump8(&(clump), (bits), (size)); \
+	     (start) < (size); \
+	     (start) = find_next_clump8(&(clump), (bits), (start) + 8, (size)))
+
 static inline int get_bitmask_order(unsigned int count)
 {
 	int order;
diff --git a/lib/find_bit.c b/lib/find_bit.c
index ee3df93ba69a..c2af1f013ea2 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -218,3 +218,84 @@ EXPORT_SYMBOL(find_next_bit_le);
 #endif
 
 #endif /* __BIG_ENDIAN */
+
+/**
+ * bitmap_get_value8 - get an 8-bit value within a memory region
+ * @bitmap: address to the bitmap memory region
+ * @size: bitmap size in number of bits
+ * @start: bit offset of the 8-bit value
+ *
+ * Returns the 8-bit value located at the @start bit offset within the @bitmap
+ * memory region.
+ */
+unsigned long bitmap_get_value8(const unsigned long *const bitmap,
+				const unsigned int size,
+				const unsigned int start)
+{
+	const size_t index = BIT_WORD(start);
+	const unsigned int offset = start % BITS_PER_LONG;
+	const unsigned int low_width = (offset + 8 > BITS_PER_LONG) ?
+				       BITS_PER_LONG - offset : 8;
+	const unsigned long low = bitmap[index] >> offset;
+	const unsigned long high = (low_width < 8 && start + 8 <= size) ?
+				   bitmap[index + 1] << low_width : 0;
+
+	return (low | high) & 0xFF;
+}
+EXPORT_SYMBOL(bitmap_get_value8);
+
+/**
+ * bitmap_set_value8 - set an 8-bit value within a memory region
+ * @bitmap: address to the bitmap memory region
+ * @size: bitmap size in number of bits
+ * @value: the 8-bit value; values wider than 8 bits may clobber bitmap
+ * @start: bit offset of the 8-bit value
+ */
+void bitmap_set_value8(unsigned long *const bitmap, const unsigned int size,
+		       const unsigned long value, const unsigned int start)
+{
+	const size_t index = BIT_WORD(start);
+	const unsigned int offset = start % BITS_PER_LONG;
+	const unsigned int low_width = (offset + 8 > BITS_PER_LONG) ?
+				       BITS_PER_LONG - offset : 8;
+	const unsigned long low_mask = GENMASK(offset + low_width - 1, offset);
+	const unsigned int high_width = 8 - low_width;
+	const unsigned long high_mask = GENMASK(high_width - 1, 0);
+
+	/* set lower portion */
+	bitmap[index] &= ~low_mask;
+	bitmap[index] |= value << offset;
+
+	/* set higher portion if space available in bitmap */
+	if (high_width && start + 8 <= size) {
+		bitmap[index + 1] &= ~high_mask;
+		bitmap[index + 1] |= value >> low_width;
+	}
+}
+EXPORT_SYMBOL(bitmap_set_value8);
+
+/**
+ * find_next_clump8 - find next 8-bit clump with set bits in a memory region
+ * @clump: location to store copy of found clump
+ * @addr: address to base the search on
+ * @offset: bit offset at which to start searching
+ * @size: bitmap size in number of bits
+ *
+ * Returns the bit offset for the next set clump; the found clump value is
+ * copied to the location pointed by @clump. If no bits are set, returns @size.
+ */
+unsigned int find_next_clump8(unsigned long *const clump,
+			      const unsigned long *const addr,
+			      unsigned int offset, const unsigned int size)
+{
+	for (; offset < size; offset += 8) {
+		*clump = bitmap_get_value8(addr, size, offset);
+		if (!*clump)
+			continue;
+
+		return offset;
+	}
+
+	return size;
+}
+EXPORT_SYMBOL(find_next_clump8);
-- 
2.21.0

