Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B3BC43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 03:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D43205F4
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 03:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aErqj1J9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfD1D3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 23:29:54 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40627 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfD1D3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 23:29:50 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so3410147plr.7
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 20:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8MwBITuhxG1VeA1aGZXSwXUCGwU9n/qmMP/2Z7ItEJc=;
        b=aErqj1J9BfG+3aUgdbwZyBeZITAY1W2ePmHlJ+I3KSRRjunjqu/K1c3ZjIFvG1/6hd
         UeDqTjwcHIs9VD1EPoouo+Hba3SXappP9TqKjMOsZ/5+GKHQXU0QwN7DmJ2ji7bSFqRc
         FBAE1BbBGXMacFBgXhpEH+5GIjZeop/dc+Rh4kSST8fhscNDSWnzlbdXGz4cn3hWt1lp
         96/spEm3bbW6Eb50gYj7jYIOEsX716X9uE/XUn7sjvv9zQqyKRX0imF35k4Cl1ZzAKTk
         vhdgoAiTSUiBSDsqLadSvC5AthTXSC+BqX2fv4mi6FVcEqMJFOvK7fM+mvF1V88IwWFT
         to2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8MwBITuhxG1VeA1aGZXSwXUCGwU9n/qmMP/2Z7ItEJc=;
        b=BAK8mfBztdrdIXSjaCc7oufkOnw3cq7QaY+Oo+jbpDaoMcCJ1Lc0+P9IZkxbGn/qBl
         zQKIk+XAc0W9nmSXcd2lm2dvbMDmCt7y8fV6aCJm7AM5s4Q+V83hq656pWmlOv2X5u2I
         WtFMbhAODdpXHHNjOdDNmU0rCHNeRkJNUqTwZGAcrXwok7hmB2tyZwKAxv9fsJMBF8mV
         IQb2Flrim9H5m5R5lzOrSD7lslo7wP8FE8xTRXG0QfRcW0v91GUodN8sXTBQW2NqXee7
         CAR5yNNlPBAvsTIin8ArgKwjnSh9Erb6wGIrAw72scn/x7517z6CixkCS79TJhUjRFel
         PrcQ==
X-Gm-Message-State: APjAAAWV/FXbeySqCVVO4gUG0NSjzaEdrR4u67VWUER1X9azNR6Lx8FQ
        +ytX7spY8xgjMtuMLslMWCw=
X-Google-Smtp-Source: APXvYqyKVgWKl+EdEOv8IHaQrM+VyzQYCHG/LoksAyX9SG7aYeLcoDTnMCHop3p61ccUYQrfsKruAQ==
X-Received: by 2002:a17:902:be12:: with SMTP id r18mr37672776pls.11.1556422189777;
        Sat, 27 Apr 2019 20:29:49 -0700 (PDT)
Received: from localhost ([2601:640:6:3484:bc53:6e04:b584:e900])
        by smtp.gmail.com with ESMTPSA id o68sm45146356pfi.140.2019.04.27.20.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 20:29:49 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
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
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Yury Norov <ynorov@marvell.com>, linux-kernel@vger.kernel.org,
        Yury Norov <yury.norov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 4/6] lib: rework bitmap_parse()
Date:   Sat, 27 Apr 2019 20:29:34 -0700
Message-Id: <20190428032936.1317-5-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190428032936.1317-1-ynorov@marvell.com>
References: <20190428032936.1317-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bitmap_parse() is ineffective and full of opaque variables and opencoded
parts. It leads to hard understanding of it. This rework includes:
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
---
 include/linux/bitmap.h |   8 +-
 lib/bitmap.c           | 179 ++++++++++++++++++++---------------------
 2 files changed, 88 insertions(+), 99 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index f58e97446abc..c3e84864cc33 100644
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
index 300732031fad..c276c7e0bb53 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -335,97 +335,6 @@ EXPORT_SYMBOL(bitmap_find_next_zero_area_off);
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
@@ -446,7 +355,7 @@ int bitmap_parse_user(const char __user *ubuf,
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
-	ret = bitmap_parse(buf, ulen, maskp, nmaskbits);
+	ret = bitmap_parse(buf, UINT_MAX, maskp, nmaskbits);
 
 	kfree(buf);
 	return ret;
@@ -545,6 +454,11 @@ static inline bool end_of_region(char c)
 	return __end_of_region(c) || end_of_str(c);
 }
 
+static inline bool in_str(const char *start, const char *ptr)
+{
+	return start <= ptr;
+}
+
 /*
  * The format allows commas and whitespases at the beginning
  * of the region.
@@ -557,6 +471,14 @@ static const char *bitmap_find_region(const char *str)
 	return end_of_str(*str) ? NULL : str;
 }
 
+static const char *bitmap_find_region_rev(const char *start, const char *end)
+{
+	while (in_str(start, end) && __end_of_region(*end))
+		end--;
+
+	return end;
+}
+
 static const char *bitmap_parse_region(const char *str, struct region *r)
 {
 	str = bitmap_getnum(str, &r->start);
@@ -680,6 +602,79 @@ int bitmap_parselist_user(const char __user *ubuf,
 }
 EXPORT_SYMBOL(bitmap_parselist_user);
 
+static const char *bitmap_get_hex32_rev(const char *start,
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
+		if (!in_str(start, end) || __end_of_region(*end))
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
+	while (in_str(start, (end = bitmap_find_region_rev(start, end)))) {
+		if (!chunks--)
+			return -EOVERFLOW;
+
+		end = bitmap_get_hex32_rev(start, end, bitmap++);
+		if (IS_ERR(end))
+			return PTR_ERR(end);
+	}
+
+	unset_bit = (BITS_TO_U32(nmaskbits) - chunks) * 32;
+	if (unset_bit < nmaskbits) {
+		bitmap_clear(maskp, unset_bit, nmaskbits);
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
2.17.1

