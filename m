Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3D5C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 07:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202D020836
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 07:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3s/GXb+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfCCHru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 02:47:50 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45969 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfCCHru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 02:47:50 -0500
Received: by mail-pf1-f193.google.com with SMTP id v21so954891pfm.12;
        Sat, 02 Mar 2019 23:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ShWnQ4n5foUkzD6q0EUYaaxbLy/TY+i7Ft3bXpmfRg=;
        b=K3s/GXb+qCLU0tBYbjBhACOHRqxVXy2BWt5nyY+EvGvmDBAC7MK9VBL/i9RznuxDjb
         1RWbpzO1U2Yn7QVl+uUxTwp2Lh3HJZCuy1YsIQ+SnBUBW+OSxZ47/stUiOUO1X24WApq
         kUpZmhyburujHHRvLdYqnB6KXa6+PJH1SF93j9FUT8Zts5rQf2RcQ46nZscCTFjljzEu
         M3CoCh/u7zsq9wqWYQF4W0llTsv/YS10EYOrCfCDlpCE91P51dqtXii2ghQHWOckIPe1
         FyuyzDMT0DXMpv8gtxsVodAw8oPkNg/2X1sQxVj1ODG1pV0zkIyKX392ccLS28bpeedJ
         Xp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ShWnQ4n5foUkzD6q0EUYaaxbLy/TY+i7Ft3bXpmfRg=;
        b=L8kfIErlfxGqJIECI5Fh7wmJy/VAaJnmvnyKHixp9ooA4ZJP0RvN7pallubkoac3x3
         BszgTr/Oj+CvqlLyW27dMH9BEF0AIHhtuW00w+ItqH9JmsoEFHuu6WUcmL0mggjNufYJ
         75OeJMOegSfRTRWXBJquhc29gFHXDJVR+cvCtdC6qzocm380uiO7eQprnRiBZokJw2hc
         +YiLhoL/D/bxZz+A3DKG0K6HSrtR2mYLuZD0QPgN6xuIx6SwzBho9PQhyMRE4B0V6l05
         prj0fnjKzWcDsfiyS5B/dxtTZouOuKxHmvPBgFqLUiR9XPUXB3/YZj2CF0WWvjn7o83Z
         0n0A==
X-Gm-Message-State: APjAAAUgVpArhY1tNXwvWqBU8T70FcBuWCvjNjTgmD7c9rO+9Rgrg2u+
        D3fkHRIgyzR12QiTjdp6tvc=
X-Google-Smtp-Source: APXvYqwSy53757lsDFOC+awhk1BMnvhr27fsGj+61YyFheroHA9PEVmgQnFH9Af4uXRvS4HNYIogqQ==
X-Received: by 2002:a63:8042:: with SMTP id j63mr12561873pgd.36.1551599269023;
        Sat, 02 Mar 2019 23:47:49 -0800 (PST)
Received: from localhost.localdomain ([2001:268:c0a5:3b5c:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id s1sm3443392pgv.30.2019.03.02.23.47.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 23:47:48 -0800 (PST)
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
Subject: [PATCH v9 1/9] bitops: Introduce the for_each_set_clump8 macro
Date:   Sun,  3 Mar 2019 16:48:36 +0900
Message-Id: <12b3a364ac7fc32194fa6f55911dd800aca92a56.1551598603.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1551598603.git.vilhelm.gray@gmail.com>
References: <cover.1551598603.git.vilhelm.gray@gmail.com>
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
Cc: Andrew Morton <akpm@linux-foundation.org>
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

