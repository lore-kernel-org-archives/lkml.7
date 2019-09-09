Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC652C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 03:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964772196F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 03:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wn43Lrt6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387732AbfIIDdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 23:33:23 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:47031 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387679AbfIIDdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 23:33:19 -0400
Received: by mail-lj1-f193.google.com with SMTP id e17so11170740ljf.13
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 20:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JJXeGDrdOVL1Ar542WRO/+yxnsmdW/6kRFsDglLjd2s=;
        b=Wn43Lrt6oi47f6m9o/F3A3voMpSEgy9ZFuHuNYdVgE7I35gzMAyJ799XvYj0po7GZG
         qE204nFfTscfPJ5L7l4Ib9d3BVS8ED+8xFjJO1zsesb81fE6lXyKv4OHsWOLwE084nmC
         68j/kwmEHs6m5c1aiHih1DfsYO0Cofkcy4v2e69XKjf9Bv9AIEo3+t4AxUHNR2xwFrHx
         OROMYXCbqMpGSWVmSS4qbmnHapx1Jonp0/vcVpfq8ogYUmhWUX5HabpV0uPRnGe7f8kX
         UQbArFOENXWZffeBSc78kz6rOoDkTU6APyzaTWIolv2p3bkE0D0QzpE9bkJQkmY07DSJ
         TEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JJXeGDrdOVL1Ar542WRO/+yxnsmdW/6kRFsDglLjd2s=;
        b=HDqS1cMwtopGtjgMV7AQtqVz2yK7usD6fDa30o3RtGdZJ8+lrmyccaKgcLP7ugOOKB
         4oYCNsP4VKSAxy2GXL2zYPSaJ1adlfGII+TPGQeNkKsi/ZLcEfHR5YnIartr/e3abpq1
         DEKqGfaLyQEftFBHO3meM3/xIMXHKFsPC5JZ33vpIQ2z+X4HOT8iZFmZsZGoYCx8RwVc
         HHIKQPx7tFjWODrlaKyejJ/Y3lvIUWj+ArlIz4jeKWMBJ4XBekvuulkoSL6reqbaIE1f
         4YNKNrsLva9IpHFtDWqYnf9aswrwDZfBsfLcmwU6ikrbznezaC3FPodf53tHAIMUHfg4
         wCLw==
X-Gm-Message-State: APjAAAVhmX5cgqcUCTP4roqkyU4z5b9WduQuGDeIp48gqfJLArSwX5Cj
        u2CnzbW/94wYb1Cm6IVyfmc=
X-Google-Smtp-Source: APXvYqzmA93Y8edBmjC0XSF0YbiRZknNZVJWXglAhrl5Fkp3DasW4iSQcJECL4vDlAyN4nlli3pFFg==
X-Received: by 2002:a2e:9dd5:: with SMTP id x21mr14030981ljj.182.1567999997002;
        Sun, 08 Sep 2019 20:33:17 -0700 (PDT)
Received: from localhost.localdomain (128-73-37-85.broadband.corbina.ru. [128.73.37.85])
        by smtp.gmail.com with ESMTPSA id f22sm2783605lfk.56.2019.09.08.20.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 20:33:16 -0700 (PDT)
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
Cc:     Yury Norov <yury.norov@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 5/7] lib: rework bitmap_parse()
Date:   Sun,  8 Sep 2019 20:30:19 -0700
Message-Id: <20190909033021.11600-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909033021.11600-1-yury.norov@gmail.com>
References: <20190909033021.11600-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitmap.h |   8 +-
 lib/bitmap.c           | 178 ++++++++++++++++++++---------------------
 2 files changed, 87 insertions(+), 99 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 90528f12bdfa6..bad43c4a5eaca 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -176,7 +176,7 @@ bitmap_find_next_zero_area(unsigned long *map,
 					      align_mask, 0);
 }
 
-extern int __bitmap_parse(const char *buf, unsigned int buflen, int is_user,
+extern int bitmap_parse(const char *buf, unsigned int buflen,
 			unsigned long *dst, int nbits);
 extern int bitmap_parse_user(const char __user *ubuf, unsigned int ulen,
 			unsigned long *dst, int nbits);
@@ -431,12 +431,6 @@ static inline void bitmap_shift_left(unsigned long *dst, const unsigned long *sr
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
index 51ee14577166e..008f53714950a 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -353,97 +353,6 @@ EXPORT_SYMBOL(bitmap_find_next_zero_area_off);
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
@@ -464,7 +373,7 @@ int bitmap_parse_user(const char __user *ubuf,
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
-	ret = bitmap_parse(buf, ulen, maskp, nmaskbits);
+	ret = bitmap_parse(buf, UINT_MAX, maskp, nmaskbits);
 
 	kfree(buf);
 	return ret;
@@ -575,6 +484,14 @@ static const char *bitmap_find_region(const char *str)
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
@@ -698,6 +615,83 @@ int bitmap_parselist_user(const char __user *ubuf,
 }
 EXPORT_SYMBOL(bitmap_parselist_user);
 
+static const char *bitmap_get_x32_reverse(const char *start,
+					const char *end, u32 *num)
+{
+	u32 ret = 0;
+	int c, i;
+
+	if (!isxdigit(*end))
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
+	if (isxdigit(*end))
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

