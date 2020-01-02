Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08857C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC54521655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awN66HLX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgABEb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 23:31:28 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:42078 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbgABEbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 23:31:19 -0500
Received: by mail-qv1-f68.google.com with SMTP id dc14so14607761qvb.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 20:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sb6aiHd6T3tirofdsYcXGM6uu2TNQA+PVNItyVMdtRI=;
        b=awN66HLXM5AQwZnBzVh1GWDk+Y8NSLycldayE8eNtnKEakB65HNUYlK689KZmw8k3h
         ihSYp3Bsi74uIN7l2HJAHQ4/1njhbkWOpnDi59YYvxrAjtkpDHpI+Ij+dn/EQFgOmW4Y
         +O+73bE/U0D3zkKMEsCyuh916MHO7ATp67r6Zcy4s8/RD5W/rZjj0wQYGbjKpGgDsQom
         aV8lgRHn2zdhko3MpPwAgX89IlUjEFgUCKE8hfbpEJqOCgzVF+7N/sbd+V0ZgHTb2QHN
         XPgQPCB9qrN8RezBZeDCaWfj7ZKxi0sSE2jS2oSFki0axJUmMsKL9GTVD5xN09JdM90K
         2Ziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sb6aiHd6T3tirofdsYcXGM6uu2TNQA+PVNItyVMdtRI=;
        b=S9YaCqn82qrDQjmUDmER9aogOeuX+E5qs/O44FqwhxgI8waYlRuxk8idGd0CLfmdfj
         JkxCRuBz9geIHuLcUIlhquZVCVqHvpXVM1oUHJ4ZIF/dg/SbmixRuJVdWZS9Dqeb2mLj
         BrfUR5l47u15OTA/VPu9JG2uRw334y2gmmbT20vlHQlqoQU4R42eeTVc7fSBBU6opzua
         qOXLlJu35tCngoOtUJ4nthQzmdN6H01TmplItyC8hjlEiwlSMZCWX604XAqnSbLqDSME
         20gp9nDvMGJvL0SsLNhaBu9B3OhG4HOzssrx40CDxgC4LXlVLeOgZz1rrIFYkigGkFiT
         +T6w==
X-Gm-Message-State: APjAAAWBIiqePseADDHqcDZAykFTh4pWnsQzHRE8vbSmMMTPBuABUHoy
        xFgZnRJEiNmQv4FfZo/HVMU=
X-Google-Smtp-Source: APXvYqyjAKZdISaNUUi8ABbnG6IZB7ir8GCHDMAyKiZblZcjtBPn8tinrg0ndGFj+sq+sHF+y7+UUA==
X-Received: by 2002:a0c:b025:: with SMTP id k34mr61244900qvc.170.1577939477900;
        Wed, 01 Jan 2020 20:31:17 -0800 (PST)
Received: from yury-thinkpad.dhcp.amer.jpmchase.net ([2604:2000:4185:2300:b196:4884:e960:2cb8])
        by smtp.gmail.com with ESMTPSA id 16sm14876857qkj.77.2020.01.01.20.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 20:31:17 -0800 (PST)
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
Date:   Wed,  1 Jan 2020 20:30:29 -0800
Message-Id: <20200102043031.30357-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200102043031.30357-1-yury.norov@gmail.com>
References: <20200102043031.30357-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Yury Norov <yury.norov@gmail.com>

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
 lib/bitmap.c           | 175 +++++++++++++++++++----------------------
 2 files changed, 84 insertions(+), 99 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index ff335b22f23c7..65994b9f68f33 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -182,7 +182,7 @@ bitmap_find_next_zero_area(unsigned long *map,
 					      align_mask, 0);
 }
 
-extern int __bitmap_parse(const char *buf, unsigned int buflen, int is_user,
+extern int bitmap_parse(const char *buf, unsigned int buflen,
 			unsigned long *dst, int nbits);
 extern int bitmap_parse_user(const char __user *ubuf, unsigned int ulen,
 			unsigned long *dst, int nbits);
@@ -450,12 +450,6 @@ static inline void bitmap_replace(unsigned long *dst,
 		__bitmap_replace(dst, old, new, mask, nbits);
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
index b9ac2d42b99e1..5d0acd43a9410 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -365,97 +365,6 @@ EXPORT_SYMBOL(bitmap_find_next_zero_area_off);
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
@@ -476,7 +385,7 @@ int bitmap_parse_user(const char __user *ubuf,
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
-	ret = bitmap_parse(buf, ulen, maskp, nmaskbits);
+	ret = bitmap_parse(buf, UINT_MAX, maskp, nmaskbits);
 
 	kfree(buf);
 	return ret;
@@ -587,6 +496,14 @@ static const char *bitmap_find_region(const char *str)
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
@@ -710,6 +627,80 @@ int bitmap_parselist_user(const char __user *ubuf,
 }
 EXPORT_SYMBOL(bitmap_parselist_user);
 
+static const char *bitmap_get_x32_reverse(const char *start,
+					const char *end, u32 *num)
+{
+	u32 ret = 0;
+	int c, i;
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
+	if (hex_to_bin(*end--) >= 0)
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

