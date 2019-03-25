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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744A1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C4720850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCJi6P0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbfCYGCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:02:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41393 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729373AbfCYGCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:02:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id f6so1579179pgs.8;
        Sun, 24 Mar 2019 23:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ez7ZzkC0Ak7aYk3BUE6/NHn4l6C5sfpy4Uv8mjEL3xM=;
        b=VCJi6P0v7PMWaX+AcmGNy17eE7dSpng3HsjixnR1IbTAFeRSW6kM/SN4IT9qGsqyPe
         buTKNmokd9md7Mst7vgiFJb+9Mu4HM8zykhdZczHMSnHQkG3LVE9nG0rz1XB4hCewMur
         GeRB5Jb1lJ0tMUhO4rqsfhihuXR3ZNOX3vr1DrWSTEaUXcoSXD420EgihRjG2tZA21TW
         i+ON9j/r+GHJ8v9ENStjlSzXc2yNFqRpZtANKu/BUQfn5tlMaiiNjejEF63s3yx0QECZ
         Pan2TM6mUYrgbROBVwDsO5JO6Su57H3u/uyCV+Ukctmcv7ZXxEl8M/qDOPX6JtzJcpEL
         LY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ez7ZzkC0Ak7aYk3BUE6/NHn4l6C5sfpy4Uv8mjEL3xM=;
        b=tQVw15RSLKOS/P3LOuvL4qPSMCtHrfV25RYbcdReM9ShbVL8vherHOzr/RPx5YORpL
         KFehwcxPoGNfwPBhBNyuc8XX3pMNaSqqEoef7oGbfQf4hNyE8BwwFH56LdXnCMydc5Zp
         3ERcct4W5IUpBcNEUlV2ORJP3UWafXf+v2gPLdl6nnWdb5aRIiqqH2hBDXICYYjVgWHL
         F9XhRB9MriAIWwwTqwMH9Nci4EhZiSWNZrrz1N+nlJsZoPd9T4fUeAsH48+awNf9CLWm
         LYqjLJKww4WikvhD2U4MdoCtQ4YEKX+lbAddIAqH3Q6HG8j8z7gdJOt6MVquZEX9jNAf
         iTtA==
X-Gm-Message-State: APjAAAUDOdQs2QLH95Od87SeEUxj2xQp5ckS2wo5HQX2jrgBWUTYaEWh
        McGdKbupizCLFW53RGhh2U0=
X-Google-Smtp-Source: APXvYqyJX1OKLzcw9XTWvb8RMbdMXvszO+qx+gHh4PgykeRMVMxJz/OJ+CmMkh0YgWOpEL0qdtgAUg==
X-Received: by 2002:a63:e554:: with SMTP id z20mr20226843pgj.234.1553493737475;
        Sun, 24 Mar 2019 23:02:17 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:e068:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id t82sm10820235pfa.153.2019.03.24.23.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 23:02:16 -0700 (PDT)
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
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v11 01/11] bitops: Introduce the for_each_set_clump8 macro
Date:   Mon, 25 Mar 2019 15:03:13 +0900
Message-Id: <64f9eed704899d31b34798c7ec7a42f28fd2d051.1553492741.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1553492741.git.vilhelm.gray@gmail.com>
References: <cover.1553492741.git.vilhelm.gray@gmail.com>
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
index 602af23b98c7..f19a7bc8f559 100644
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

