Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B14BC76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 21:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9AF2171F
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 21:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxieWWDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfGUV2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 17:28:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34248 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfGUV2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 17:28:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so10440107pgc.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 14:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hVV6l1sPGAk+7cFguHuHijLKb+0pglb9+uAKALWEs54=;
        b=YxieWWDsYKu7n0dWQ21TqttQCCtxcZchsSXM7vJhnJUDeMZOlIQoUgwQFJ8v3BEPpN
         IaWqig/YwT//X9ZnE/u/R6yuYekdZjH134pBem7RoYKmHlrrRm73n4UQ9yM3/qJ0xu9m
         uNB9KlXFB0/9ct0Jyu/Qwfx7PsUNVYHxUzseJ6yW3jJ5M8Cv7kma9ODfp/1RLuyTMdr2
         6vq4+VgVQD+ABLe+AWLhef0WoPbfZITNUcRg5TFMV8BvZL/wpZX8a7onNRgR9qZHAPeu
         3q1QZ7tMHkHm4UMZ4uS1yWZFvJv+Mmu4+xR+Nhh1d6HGwf0+VF+z4veNfBo4bU0clS0z
         CbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hVV6l1sPGAk+7cFguHuHijLKb+0pglb9+uAKALWEs54=;
        b=idu48nwhMDMI1W4KHFyQboIUL5ah9tk280iSivLra2d778iEGNo+rWcy6hTwcA9Gvl
         7a4X0R9F2n0y38PB3tdhh17W98D0zo1PWdLMlhrLtMRqPsxcJEWVw4NsEDAFw+m5EeWg
         6OKFgSN4DVLLzEQhpbunkZb7Ab926+Eq0x4m7LHSAeAk2hAYKVvnn2OdpHUv/nHgF0oq
         /RxR1Di9YuyKMmIYEmTwTFSv3VnSPgjxVi2/cEEiRUcGwYlV7LZ5ajDho2G/gWbCFii8
         nNMdB7cMqU5nnNBgpC36W5i8UMzBnhghLedY1kSsJF50HM8hkQ/TCRdrfhyTUGVsseiO
         x4uQ==
X-Gm-Message-State: APjAAAVt1XwwwJFCjA4brNfMurIQ+pbdhbUKqSNSlTr/cHK1Z7dbSDUw
        pTgGWBRdYH5Wvi9USipiWs0=
X-Google-Smtp-Source: APXvYqxEo4HzZH7d510SsDM2tS+z/qPL9t7izU3hxvvOVZeye9DgxVV/3UTqFqIJJ1pbndlvE4lSLw==
X-Received: by 2002:a17:90a:cb18:: with SMTP id z24mr22605274pjt.108.1563744520125;
        Sun, 21 Jul 2019 14:28:40 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:105:2ef8:a909:5e8d:6363:7009])
        by smtp.gmail.com with ESMTPSA id t9sm37970510pji.18.2019.07.21.14.28.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 14:28:39 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Willem de Bruijn <willemb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Tobin C . Harding" <tobin@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Yury Norov <ynorov@marvell.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 5/7] lib: rework bitmap_parse()
Date:   Sun, 21 Jul 2019 14:27:51 -0700
Message-Id: <20190721212753.3287-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190721212753.3287-1-yury.norov@gmail.com>
References: <20190721212753.3287-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Yury Norov <ynorov@marvell.com>

bitmap_parse() is ineffective and full of opaque variables and opencoded
parts. It leads to hard understanding and usage of it. This rework
includes:
 - remove bitmap_shift_left() call from the cycle. Now it makes the
   complexity of the algorithm as O(nbits^2). In the suggested approach
   the input string is parsed in reverse direction, so no shifts needed;
 - relax requirement on a single comma and no white spaces between chunks.
   It is considered useful in scripting, and it aligns with
   bitmap_parselist();
 - split bitmap_parse() to small readable helpers;
 - make an explicit calculation of the end of input line at the
   beginning, so users of the bitmap_parse() won't bother doing this.

Signed-off-by: Yury Norov <ynorov@marvell.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitmap.h |   8 +-
 lib/bitmap.c           | 178 ++++++++++++++++++++---------------------
 2 files changed, 87 insertions(+), 99 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index f58e97446abcf..c3e84864cc335 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -172,7 +172,7 @@ bitmap_find_next_zero_area(unsigned long *map,
 					      align_mask, 0);
 }
 
-extern int __bitmap_parse(const char *buf, unsigned int buflen, int is_user,
+extern int bitmap_parse(const char *buf, unsigned int buflen,
 			unsigned long *dst, int nbits);
 extern int bitmap_parse_user(const char __user *ubuf, unsigned int ulen,
 			unsigned long *dst, int nbits);
@@ -408,12 +408,6 @@ static inline void bitmap_shift_left(unsigned long *dst, const unsigned long *sr
 		__bitmap_shift_left(dst, src, shift, nbits);
 }
 
-static inline int bitmap_parse(const char *buf, unsigned int buflen,
-			unsigned long *maskp, int nmaskbits)
-{
-	return __bitmap_parse(buf, buflen, 0, maskp, nmaskbits);
-}
-
 /**
  * BITMAP_FROM_U64() - Represent u64 value in the format suitable for bitmap.
  * @n: u64 value
diff --git a/lib/bitmap.c b/lib/bitmap.c
index fbd4121c540b8..8fc918e74116d 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -333,97 +333,6 @@ EXPORT_SYMBOL(bitmap_find_next_zero_area_off);
  * second version by Paul Jackson, third by Joe Korty.
  */
 
-#define CHUNKSZ				32
-#define nbits_to_hold_value(val)	fls(val)
-#define BASEDEC 10		/* fancier cpuset lists input in decimal */
-
-/**
- * __bitmap_parse - convert an ASCII hex string into a bitmap.
- * @buf: pointer to buffer containing string.
- * @buflen: buffer size in bytes.  If string is smaller than this
- *    then it must be terminated with a \0.
- * @is_user: location of buffer, 0 indicates kernel space
- * @maskp: pointer to bitmap array that will contain result.
- * @nmaskbits: size of bitmap, in bits.
- *
- * Commas group hex digits into chunks.  Each chunk defines exactly 32
- * bits of the resultant bitmask.  No chunk may specify a value larger
- * than 32 bits (%-EOVERFLOW), and if a chunk specifies a smaller value
- * then leading 0-bits are prepended.  %-EINVAL is returned for illegal
- * characters and for grouping errors such as "1,,5", ",44", "," and "".
- * Leading and trailing whitespace accepted, but not embedded whitespace.
- */
-int __bitmap_parse(const char *buf, unsigned int buflen,
-		int is_user, unsigned long *maskp,
-		int nmaskbits)
-{
-	int c, old_c, totaldigits, ndigits, nchunks, nbits;
-	u32 chunk;
-	const char __user __force *ubuf = (const char __user __force *)buf;
-
-	bitmap_zero(maskp, nmaskbits);
-
-	nchunks = nbits = totaldigits = c = 0;
-	do {
-		chunk = 0;
-		ndigits = totaldigits;
-
-		/* Get the next chunk of the bitmap */
-		while (buflen) {
-			old_c = c;
-			if (is_user) {
-				if (__get_user(c, ubuf++))
-					return -EFAULT;
-			}
-			else
-				c = *buf++;
-			buflen--;
-			if (isspace(c))
-				continue;
-
-			/*
-			 * If the last character was a space and the current
-			 * character isn't '\0', we've got embedded whitespace.
-			 * This is a no-no, so throw an error.
-			 */
-			if (totaldigits && c && isspace(old_c))
-				return -EINVAL;
-
-			/* A '\0' or a ',' signal the end of the chunk */
-			if (c == '\0' || c == ',')
-				break;
-
-			if (!isxdigit(c))
-				return -EINVAL;
-
-			/*
-			 * Make sure there are at least 4 free bits in 'chunk'.
-			 * If not, this hexdigit will overflow 'chunk', so
-			 * throw an error.
-			 */
-			if (chunk & ~((1UL << (CHUNKSZ - 4)) - 1))
-				return -EOVERFLOW;
-
-			chunk = (chunk << 4) | hex_to_bin(c);
-			totaldigits++;
-		}
-		if (ndigits == totaldigits)
-			return -EINVAL;
-		if (nchunks == 0 && chunk == 0)
-			continue;
-
-		__bitmap_shift_left(maskp, maskp, CHUNKSZ, nmaskbits);
-		*maskp |= chunk;
-		nchunks++;
-		nbits += (nchunks == 1) ? nbits_to_hold_value(chunk) : CHUNKSZ;
-		if (nbits > nmaskbits)
-			return -EOVERFLOW;
-	} while (buflen && c == ',');
-
-	return 0;
-}
-EXPORT_SYMBOL(__bitmap_parse);
-
 /**
  * bitmap_parse_user - convert an ASCII hex string in a user buffer into a bitmap
  *
@@ -444,7 +353,7 @@ int bitmap_parse_user(const char __user *ubuf,
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
-	ret = bitmap_parse(buf, ulen, maskp, nmaskbits);
+	ret = bitmap_parse(buf, UINT_MAX, maskp, nmaskbits);
 
 	kfree(buf);
 	return ret;
@@ -555,6 +464,14 @@ static const char *bitmap_find_region(const char *str)
 	return end_of_str(*str) ? NULL : str;
 }
 
+static const char *bitmap_find_region_reverse(const char *start, const char *end)
+{
+	while (start <= end && __end_of_region(*end))
+		end--;
+
+	return end;
+}
+
 static const char *bitmap_parse_region(const char *str, struct region *r)
 {
 	str = bitmap_getnum(str, &r->start);
@@ -678,6 +595,83 @@ int bitmap_parselist_user(const char __user *ubuf,
 }
 EXPORT_SYMBOL(bitmap_parselist_user);
 
+static const char *bitmap_get_x32_reverse(const char *start,
+					const char *end, u32 *num)
+{
+	u32 ret = 0;
+	int c, i;
+
+	if (hex_to_bin(*end) < 0)
+		return ERR_PTR(-EINVAL);
+
+	for (i = 0; i < 32; i += 4) {
+		c = hex_to_bin(*end--);
+		if (c < 0)
+			return ERR_PTR(-EINVAL);
+
+		ret |= c << i;
+
+		if (start > end || __end_of_region(*end))
+			goto out;
+	}
+
+	if (hex_to_bin(*end) >= 0)
+		return ERR_PTR(-EOVERFLOW);
+out:
+	*num = ret;
+	return end;
+}
+
+/**
+ * bitmap_parse - convert an ASCII hex string into a bitmap.
+ * @start: pointer to buffer containing string.
+ * @buflen: buffer size in bytes.  If string is smaller than this
+ *    then it must be terminated with a \0 or \n. In that case,
+ *    UINT_MAX may be provided instead of string length.
+ * @maskp: pointer to bitmap array that will contain result.
+ * @nmaskbits: size of bitmap, in bits.
+ *
+ * Commas group hex digits into chunks.  Each chunk defines exactly 32
+ * bits of the resultant bitmask.  No chunk may specify a value larger
+ * than 32 bits (%-EOVERFLOW), and if a chunk specifies a smaller value
+ * then leading 0-bits are prepended.  %-EINVAL is returned for illegal
+ * characters. Grouping such as "1,,5", ",44", "," or "" is allowed.
+ * Leading, embedded and trailing whitespace accepted.
+ */
+int bitmap_parse(const char *start, unsigned int buflen,
+		unsigned long *maskp, int nmaskbits)
+{
+	const char *end = strnchrnul(start, buflen, '\n') - 1;
+	int chunks = BITS_TO_U32(nmaskbits);
+	u32 *bitmap = (u32 *)maskp;
+	int unset_bit;
+
+	while (1) {
+		end = bitmap_find_region_reverse(start, end);
+		if (start > end)
+			break;
+
+		if (!chunks--)
+			return -EOVERFLOW;
+
+		end = bitmap_get_x32_reverse(start, end, bitmap++);
+		if (IS_ERR(end))
+			return PTR_ERR(end);
+	}
+
+	unset_bit = (BITS_TO_U32(nmaskbits) - chunks) * 32;
+	if (unset_bit < nmaskbits) {
+		bitmap_clear(maskp, unset_bit, nmaskbits - unset_bit);
+		return 0;
+	}
+
+	if (find_next_bit(maskp, unset_bit, nmaskbits) != unset_bit)
+		return -EOVERFLOW;
+
+	return 0;
+}
+EXPORT_SYMBOL(bitmap_parse);
+
 
 #ifdef CONFIG_NUMA
 /**
-- 
2.20.1

