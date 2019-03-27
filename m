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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE256C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 04:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949902075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 04:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXnjPTjs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfC0E5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 00:57:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34132 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbfC0E5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 00:57:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id b3so7765857pfd.1;
        Tue, 26 Mar 2019 21:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uip2SJNOxYS4/yCupvO0yCYaokZfoOseJfUme2GdvMI=;
        b=VXnjPTjsu4YySzBI7FUjsuKpACfcIimz0wCHKOW79RkaSxLv7spNkcaKT2scqV7H8v
         SNALUo3sBmzp1jt86RvYXQowaViVEy6gNG2Esxt1f4OiUNu1p7YedEPz1OjiktSo+aPp
         3H2NmDzjrZDlyZivCvs7z0OPi2C2cFN/Ci8+hV8DKYH7bqBtg/7GMnv8c5a1q3ew4SN7
         2x5U8kwYQJJ1kcWFCqPrL20gU1rpYt46wdh4Ck2GDzZnp02Sr8aUVSRMDrjW1IzSyriV
         aQtyhK8bCuOP6NSZEWdvRfRaMxBLCLX1tyhmCbnui4PrKBoGhoBkeqCxwcRvhudZ4Cga
         L3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uip2SJNOxYS4/yCupvO0yCYaokZfoOseJfUme2GdvMI=;
        b=fBzeNaIFbQtd21rWQUuBH1Wz1z2SnlwQSVIFkwEJk211LmOYZk7THLrCESNjOnvFfD
         H7Ygyp4zwmDZUGltqBQ9jYXGIOYmEwR5l7HUKJyDkX0VGp/Dv6v8xwXBc4OytkxAaQVV
         pI6u3+BGh7yxEYJuIEM4g5Fay0wofETu/GBFusyujGKbfFVK0qds8dGHXU2Mk6xHPJy1
         t+1zX8HPyUL6HczfSeaIR7wNhOWwRqZj0Nqu3yhlCapBWcAw//i9Ys2dRdBVmaT7L13R
         YGlgLReIXXp5YCy5tIqWmCZvE5SDXQP0xLU0bX7CAfyURF2c9LNSTn5PDquu2vTfT7LY
         A+wQ==
X-Gm-Message-State: APjAAAXV8TtFRp/UqNMj11fVpDTliWI9d+62J6+S839E1YhBACQg8RTN
        62m4EKnsLPdNXmH4oNxtP2s=
X-Google-Smtp-Source: APXvYqwIBIGzL2EaNaieYfvz6H4C3wp+BjWPMVK5N9esxq/aTuo7hAczrGEKE4BQzsFQkWH0P1a9TA==
X-Received: by 2002:a62:3585:: with SMTP id c127mr32910673pfa.71.1553662670879;
        Tue, 26 Mar 2019 21:57:50 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:6014:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id e22sm27564056pfi.126.2019.03.26.21.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 21:57:50 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v13 01/11] bitops: Introduce the for_each_set_clump8 macro
Date:   Wed, 27 Mar 2019 13:58:45 +0900
Message-Id: <497dc4b5b1f668b54e008e10a43d4108f4a41213.1553661964.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1553661964.git.vilhelm.gray@gmail.com>
References: <cover.1553661964.git.vilhelm.gray@gmail.com>
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
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 include/asm-generic/bitops/find.h | 11 ++++++
 include/linux/bitops.h            |  5 +++
 lib/find_bit.c                    | 58 +++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 8a1ee10014de..b0a99035f64f 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -80,4 +80,15 @@ extern unsigned long find_first_zero_bit(const unsigned long *addr,
 
 #endif /* CONFIG_GENERIC_FIND_FIRST_BIT */
 
+unsigned long bitmap_get_value8(const unsigned long *addr, unsigned long start);
+
+void bitmap_set_value8(unsigned long *addr, unsigned long value,
+		       unsigned long start);
+
+unsigned long find_next_clump8(unsigned long *clump, const unsigned long *addr,
+			       unsigned long size, unsigned long offset);
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
diff --git a/lib/find_bit.c b/lib/find_bit.c
index ee3df93ba69a..71a4e0a31e40 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -218,3 +218,61 @@ EXPORT_SYMBOL(find_next_bit_le);
 #endif
 
 #endif /* __BIG_ENDIAN */
+
+/**
+ * bitmap_get_value8 - get an 8-bit value within a memory region
+ * @addr: address to the bitmap memory region
+ * @start: bit offset of the 8-bit value; must be a multiple of 8
+ *
+ * Returns the 8-bit value located at the @start bit offset within the @addr
+ * memory region.
+ */
+unsigned long bitmap_get_value8(const unsigned long *addr, unsigned long start)
+{
+	const size_t idx = BIT_WORD(start);
+	const unsigned long offset = start % BITS_PER_LONG;
+
+	return (addr[idx] >> offset) & 0xFF;
+}
+EXPORT_SYMBOL(bitmap_get_value8);
+
+/**
+ * bitmap_set_value8 - set an 8-bit value within a memory region
+ * @addr: address to the bitmap memory region
+ * @value: the 8-bit value; values wider than 8 bits may clobber bitmap
+ * @start: bit offset of the 8-bit value; must be a multiple of 8
+ */
+void bitmap_set_value8(unsigned long *addr, unsigned long value,
+		       unsigned long start)
+{
+	const size_t idx = BIT_WORD(start);
+	const unsigned long offset = start % BITS_PER_LONG;
+
+	addr[idx] &= ~(0xFF << offset);
+	addr[idx] |= value << offset;
+}
+EXPORT_SYMBOL(bitmap_set_value8);
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
+unsigned long find_next_clump8(unsigned long *clump, const unsigned long *addr,
+			       unsigned long size, unsigned long offset)
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
+EXPORT_SYMBOL(find_next_clump8);
-- 
2.21.0

