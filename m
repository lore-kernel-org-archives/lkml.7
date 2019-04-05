Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0172C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F4F20651
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pf1KklX5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbfDERcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:32:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41207 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731690AbfDERcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:32:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id f6so3424745pgs.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 10:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dC1IyjGQbv3LBRRuenT7WCAU8t3htYK1bgPQAqiLItw=;
        b=Pf1KklX5JwycN3Psdy0i/H4grM1gZYRcCCwPTXPz0YfbgJSEJT7eYsEdxYbeHlj9F8
         rPReY9disASUWqBZDVU/VMds5yn9gIKJfk5bEXgcyQB7X42sFRc6h9z4tmCX47qzVdVt
         caFGy+N0K6uONZFkkt4EKbyXixfQv5cLFv8evZLuc2YrvDtBC36E9GiSRIP3xvg3Y1nZ
         jpDCdbbXhFGURy0KqgujvyIIv/lXotN1iTeSal8j5YkxKIaq3xymSVsaMbVS4vkw0NwE
         w+zHoZ6T7QdPYDc06rT+qgllOyEyhE439jhehR7LiQMggCeijBPPG7ThZI+SSyK86oJ9
         X1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dC1IyjGQbv3LBRRuenT7WCAU8t3htYK1bgPQAqiLItw=;
        b=KTlgi69z949E1geOQ+TdBfWFmR/WCDJfM99cBDhIZ8vnFrGy7AsceVS706Kdbk4I44
         /g0fAMmJjnuJwF45uuwsAHITrEKtYm+cxdb7jItVJk3TY+akFQm3fxTv4risAjTQC91t
         wQ12GnhqSWLDlXkXkJHIVskTqpv3xLEhqX2Mj2ylrgttIY6MJR6pTSoseoIQHQ2Lho2W
         U/CQ8ef5frNvUwEaOV+7JsvvDMfzezKH9rmo3L96UcdOZX4GlDKve4z2WcSs+GxvZ+v+
         EXkZjgPujQWA/ilb+3wh35/f2FJKHRU0XrZQmeiXaJYsCF21z8cpa5abAoVKHKhyFGNK
         4AAA==
X-Gm-Message-State: APjAAAUVdc84gCOT/sDiISIdxHNiCvsu/2Ll1sI8HF5SJVt/l1KoLG0y
        ZiCNNfpqgbUefw0tKxp99fQ=
X-Google-Smtp-Source: APXvYqx/LSDefyltsb1mAiQ4vpB0JOVNl60EJlY8oZf+qh8Xn/LepWOOGmDvuP70cDAnIIhRfqM5Zw==
X-Received: by 2002:a65:6210:: with SMTP id d16mr12994801pgv.110.1554485540261;
        Fri, 05 Apr 2019 10:32:20 -0700 (PDT)
Received: from localhost ([169.229.22.206])
        by smtp.gmail.com with ESMTPSA id x16sm43023578pge.27.2019.04.05.10.32.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 10:32:19 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Mike Travis <travis@sgi.com>
Cc:     Yury Norov <ynorov@marvell.com>, Yury Norov <yury.norov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] lib: rework bitmap_parselist
Date:   Fri,  5 Apr 2019 20:32:08 +0300
Message-Id: <20190405173211.11373-3-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190405173211.11373-1-ynorov@marvell.com>
References: <20190405173211.11373-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove __bitmap_parselist helper and split the function to logical
parts.

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 lib/bitmap.c | 258 +++++++++++++++++++++++++++++----------------------
 1 file changed, 145 insertions(+), 113 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 79ed5538617b..28e17b71f72f 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -477,12 +477,133 @@ int bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
 }
 EXPORT_SYMBOL(bitmap_print_to_pagebuf);
 
+/*
+ * Region 9-38:4/10 describes the following bitmap structure:
+ * 0	   9  12    18			38
+ * .........****......****......****......
+ *	    ^  ^     ^			 ^
+ *      start  off   group_len	       end
+ */
+struct region {
+	unsigned int start;
+	unsigned int off;
+	unsigned int group_len;
+	unsigned int end;
+};
+
+static int bitmap_set_region(const struct region *r,
+				unsigned long *bitmap, int nbits)
+{
+	unsigned int start;
+
+	if (r->end >= nbits)
+		return -ERANGE;
+
+	for (start = r->start; start <= r->end; start += r->group_len)
+		bitmap_set(bitmap, start, min(r->end - start + 1, r->off));
+
+	return 0;
+}
+
+static int bitmap_check_region(const struct region *r)
+{
+	if (r->start > r->end || r->group_len == 0 || r->off > r->group_len)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const char *bitmap_getnum(const char *str, unsigned int *num)
+{
+	unsigned int n = 0, _num = 0;
+
+	if (!isdigit(*str))
+		return ERR_PTR(-EINVAL);
+
+	for (; isdigit(*str); str++) {
+		_num = _num * 10 + (*str - '0');
+		if (_num < n)
+			return ERR_PTR(-EOVERFLOW);
+
+		n = _num;
+	}
+
+	*num = _num;
+
+	return str;
+}
+
+static inline bool end_of_str(char c)
+{
+	return c == '\0' || c == '\n';
+}
+
+static inline bool __end_of_region(char c)
+{
+	return isspace(c) || c == ',';
+}
+
+static inline bool end_of_region(char c)
+{
+	return __end_of_region(c) || end_of_str(c);
+}
+
+/*
+ * The format allows commas and whitespases at the beginning
+ * of the region.
+ */
+static const char *bitmap_find_region(const char *str)
+{
+	while (__end_of_region(*str))
+		str++;
+
+	return end_of_str(*str) ? NULL : str;
+}
+
+static const char *bitmap_parse_region(const char *str, struct region *r)
+{
+	str = bitmap_getnum(str, &r->start);
+	if (IS_ERR(str))
+		return str;
+
+	if (end_of_region(*str))
+		goto no_end;
+
+	if (*str != '-')
+		return ERR_PTR(-EINVAL);
+
+	str = bitmap_getnum(str + 1, &r->end);
+	if (IS_ERR(str))
+		return str;
+
+	if (end_of_region(*str))
+		goto no_pattern;
+
+	if (*str != ':')
+		return ERR_PTR(-EINVAL);
+
+	str = bitmap_getnum(str + 1, &r->off);
+	if (IS_ERR(str))
+		return str;
+
+	if (*str != '/')
+		return ERR_PTR(-EINVAL);
+
+	return bitmap_getnum(str + 1, &r->group_len);
+
+no_end:
+	r->end = r->start;
+no_pattern:
+	r->off = r->end + 1;
+	r->group_len = r->end + 1;
+
+	return end_of_str(*str) ? NULL : str;
+}
+
 /**
- * __bitmap_parselist - convert list format ASCII string to bitmap
- * @buf: read nul-terminated user string from this buffer
- * @buflen: buffer size in bytes.  If string is smaller than this
- *    then it must be terminated with a \0.
- * @is_user: location of buffer, 0 indicates kernel space
+ * bitmap_parselist - convert list format ASCII string to bitmap
+ * @buf: read user string from this buffer; must be terminated
+ *    with a \0 or \n.
  * @maskp: write resulting mask here
  * @nmaskbits: number of bits in mask to be written
  *
@@ -498,127 +619,38 @@ EXPORT_SYMBOL(bitmap_print_to_pagebuf);
  *
  * Returns: 0 on success, -errno on invalid input strings. Error values:
  *
- *   - ``-EINVAL``: second number in range smaller than first
+ *   - ``-EINVAL``: wrong region format
  *   - ``-EINVAL``: invalid character in string
  *   - ``-ERANGE``: bit number specified too large for mask
+ *   - ``-EOVERFLOW``: integer overflow in the input parameters
  */
-static int __bitmap_parselist(const char *buf, unsigned int buflen,
-		int is_user, unsigned long *maskp,
-		int nmaskbits)
+int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
 {
-	unsigned int a, b, old_a, old_b;
-	unsigned int group_size, used_size, off;
-	int c, old_c, totaldigits, ndigits;
-	const char __user __force *ubuf = (const char __user __force *)buf;
-	int at_start, in_range, in_partial_range;
+	struct region r;
+	long ret;
 
-	totaldigits = c = 0;
-	old_a = old_b = 0;
-	group_size = used_size = 0;
 	bitmap_zero(maskp, nmaskbits);
-	do {
-		at_start = 1;
-		in_range = 0;
-		in_partial_range = 0;
-		a = b = 0;
-		ndigits = totaldigits;
 
-		/* Get the next cpu# or a range of cpu#'s */
-		while (buflen) {
-			old_c = c;
-			if (is_user) {
-				if (__get_user(c, ubuf++))
-					return -EFAULT;
-			} else
-				c = *buf++;
-			buflen--;
-			if (isspace(c))
-				continue;
-
-			/* A '\0' or a ',' signal the end of a cpu# or range */
-			if (c == '\0' || c == ',')
-				break;
-			/*
-			* whitespaces between digits are not allowed,
-			* but it's ok if whitespaces are on head or tail.
-			* when old_c is whilespace,
-			* if totaldigits == ndigits, whitespace is on head.
-			* if whitespace is on tail, it should not run here.
-			* as c was ',' or '\0',
-			* the last code line has broken the current loop.
-			*/
-			if ((totaldigits != ndigits) && isspace(old_c))
-				return -EINVAL;
-
-			if (c == '/') {
-				used_size = a;
-				at_start = 1;
-				in_range = 0;
-				a = b = 0;
-				continue;
-			}
+	while (buf) {
+		buf = bitmap_find_region(buf);
+		if (buf == NULL)
+			return 0;
 
-			if (c == ':') {
-				old_a = a;
-				old_b = b;
-				at_start = 1;
-				in_range = 0;
-				in_partial_range = 1;
-				a = b = 0;
-				continue;
-			}
+		buf = bitmap_parse_region(buf, &r);
+		if (IS_ERR(buf))
+			return PTR_ERR(buf);
 
-			if (c == '-') {
-				if (at_start || in_range)
-					return -EINVAL;
-				b = 0;
-				in_range = 1;
-				at_start = 1;
-				continue;
-			}
+		ret = bitmap_check_region(&r);
+		if (ret)
+			return ret;
 
-			if (!isdigit(c))
-				return -EINVAL;
+		ret = bitmap_set_region(&r, maskp, nmaskbits);
+		if (ret)
+			return ret;
+	}
 
-			b = b * 10 + (c - '0');
-			if (!in_range)
-				a = b;
-			at_start = 0;
-			totaldigits++;
-		}
-		if (ndigits == totaldigits)
-			continue;
-		if (in_partial_range) {
-			group_size = a;
-			a = old_a;
-			b = old_b;
-			old_a = old_b = 0;
-		} else {
-			used_size = group_size = b - a + 1;
-		}
-		/* if no digit is after '-', it's wrong*/
-		if (at_start && in_range)
-			return -EINVAL;
-		if (!(a <= b) || group_size == 0 || !(used_size <= group_size))
-			return -EINVAL;
-		if (b >= nmaskbits)
-			return -ERANGE;
-		while (a <= b) {
-			off = min(b - a + 1, used_size);
-			bitmap_set(maskp, a, off);
-			a += group_size;
-		}
-	} while (buflen && c == ',');
 	return 0;
 }
-
-int bitmap_parselist(const char *bp, unsigned long *maskp, int nmaskbits)
-{
-	char *nl  = strchrnul(bp, '\n');
-	int len = nl - bp;
-
-	return __bitmap_parselist(bp, len, 0, maskp, nmaskbits);
-}
 EXPORT_SYMBOL(bitmap_parselist);
 
 
-- 
2.17.1

