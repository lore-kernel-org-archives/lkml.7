Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3FBC10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3798720811
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icboAJMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbfCYVIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:08:00 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44738 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730362AbfCYVH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:07:57 -0400
Received: by mail-pl1-f195.google.com with SMTP id g12so533350pll.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 14:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tbO13qcWhpaV3j472zTU1iP58H/m6cB1n2Az+u0mirc=;
        b=icboAJMmijdWFqJUcGosRNwnko3kTFr77VDruCI0b67k27euNhhPjQhf/1of6Yw9Lf
         MNONBHbQG+tmENu0dWE92GK9ykvd7SNI2L9SaTP1OHdM6/8Ulfi8mh1d7Wdhc1ava/D0
         lsYlbRdNHE3/lAtfMusMO+ZiIOSalYzH9tSxFvotvfRNIB5db/bnGNJRZfHSXGMVAXYG
         eYTri0Vuznmqe+veHrKQxLUeCi7/kyT9F5orEcW22cQQflEn4LjYxqUUPL0NUYcH9mLl
         OazRd8fDy1SoedToUEjkGf/BJwBsuQvEjogKVr71fCGpN8Te/eIrcBjwU+bCE2wekIYv
         iUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tbO13qcWhpaV3j472zTU1iP58H/m6cB1n2Az+u0mirc=;
        b=h0hI5k2JFCcPXYNZHMgNoJEeDkXImK2zgJhpdO6GsA1tsJyRP1mQdrWUWCo7mYzn1a
         A83/EDVgFSlPsV1EMl0qJPhAPnyA0P8623ILGngpiTwEglXXIjXIczFIjxlyh2ih6t1x
         nr3H1uqgLgOc0sAevyXgrCHO47Fag25pYD92j2Oy6hSKjsJ/LNPEDkHYbBmDVnH7B4tD
         QK7UyBWHujk4KPn3oWmbUsO1Dso5l4iMGoltDZbej8RrsEv9HYn+2CTdiSRSsICg8JFe
         Gh6kcg16O+b6i3s+ncJJwy3D8EqmtXujyLk9Ig2QTzWe+ABbl3NrrD6SSTEFXoSgiq7F
         XjbQ==
X-Gm-Message-State: APjAAAXtwIrLQLTpcxU29IrgsFbXVY/cLLXx0SODPmMQ2410B52aDKqP
        zH2lwXPlMDnyPjEfb5LPKas=
X-Google-Smtp-Source: APXvYqwqQsOSu1dW78PliMpu+q006bTxW2MAcPZT9yZetvyLNr9VCnRe8Grksnrk0Qpgv2HOJBnvSg==
X-Received: by 2002:a17:902:2aa6:: with SMTP id j35mr27171125plb.56.1553548076969;
        Mon, 25 Mar 2019 14:07:56 -0700 (PDT)
Received: from localhost ([169.229.22.206])
        by smtp.gmail.com with ESMTPSA id r82sm30454861pfa.161.2019.03.25.14.07.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 14:07:56 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Yury Norov <ynorov@marvell.com>, Yury Norov <yury.norov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] bitmap_parselist: rework input string parser
Date:   Tue, 26 Mar 2019 00:07:45 +0300
Message-Id: <20190325210748.6571-4-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190325210748.6571-1-ynorov@marvell.com>
References: <20190325210748.6571-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The requirement for this rework is to keep the __bitmap_parselist()
copy-less and single-pass but make it more readable and maintainable by
splitting into logical parts and removing explicit nested cycles and
opaque local variables.

__bitmap_parselist() can parse userspace inputs and therefore we cannot
use simple_strtoul() to parse numbers.

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 lib/bitmap.c | 247 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 148 insertions(+), 99 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 307a1b20bead..aa15e529f364 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -513,6 +513,139 @@ static int bitmap_check_region(const struct region *r)
 	return 0;
 }
 
+static long get_char(char *c, const char *str, int is_user)
+{
+	if (unlikely(is_user))
+		return __get_user(*c, (const char __force __user *)str);
+
+	*c = *str;
+	return 0;
+}
+
+static const char *bitmap_getnum(unsigned int *num, const char *str,
+			    const char *const end, int is_user)
+{
+	unsigned int n = 0;
+	const char *_str;
+	long ret;
+	char c;
+
+	for (_str = str, *num = 0; _str <= end; _str++) {
+		ret = get_char(&c, _str, is_user);
+		if (ret)
+			return ERR_PTR(ret);
+
+		if (!isdigit(c)) {
+			if (_str == str)
+				return ERR_PTR(-EINVAL);
+
+			return _str;
+		}
+
+		*num = *num * 10 + (c - '0');
+		if (*num < n)
+			return ERR_PTR(-EOVERFLOW);
+
+		n = *num;
+	}
+
+	return _str;
+}
+
+static const char *bitmap_find_region(const char *str,
+			const char *const end, int is_user)
+{
+	long ret;
+	char c;
+
+	for (; str <= end; str++) {
+		ret = get_char(&c, str, is_user);
+		if (ret)
+			return ERR_PTR(ret);
+
+		/* Unexpected end of line. */
+		if (c == 0 || c == '\n')
+			return NULL;
+
+		/*
+		 * The format allows commas and whitespases
+		 * at the beginning of the region, so skip it.
+		 */
+		if (!isspace(c) && c != ',')
+			break;
+	}
+
+	return str <= end ? str : NULL;
+}
+
+static const char *bitmap_parse_region(struct region *r, const char *str,
+				 const char *const end, int is_user)
+{
+	long ret;
+	char c;
+
+	str = bitmap_getnum(&r->start, str, end, is_user);
+	if (IS_ERR(str))
+		return str;
+
+	ret = get_char(&c, str, is_user);
+	if (ret)
+		return (char *)ret;
+
+	if (c == 0 || c == '\n') {
+		str = end + 1;
+		goto no_end;
+	}
+
+	if (isspace(c) || c == ',')
+		goto no_end;
+
+	if (c != '-')
+		return ERR_PTR(-EINVAL);
+
+	str = bitmap_getnum(&r->end, str + 1, end, is_user);
+	if (IS_ERR(str))
+		return str;
+
+	ret = get_char(&c, str, is_user);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (c == 0 || c == '\n') {
+		str = end + 1;
+		goto no_pattern;
+	}
+
+	if (isspace(c) || c == ',')
+		goto no_pattern;
+
+	if (c != ':')
+		return ERR_PTR(-EINVAL);
+
+	str = bitmap_getnum(&r->off, str + 1, end, is_user);
+	if (IS_ERR(str))
+		return str;
+
+	ret = get_char(&c, str, is_user);
+	if (ret)
+		return (char *)ret;
+
+	if (c != '/')
+		return ERR_PTR(-EINVAL);
+
+	str = bitmap_getnum(&r->grlen, str + 1, end, is_user);
+
+	return str;
+
+no_end:
+	r->end = r->start;
+no_pattern:
+	r->off = r->end + 1;
+	r->grlen = r->end + 1;
+
+	return str;
+}
+
 /**
  * __bitmap_parselist - convert list format ASCII string to bitmap
  * @buf: read nul-terminated user string from this buffer
@@ -534,113 +667,28 @@ static int bitmap_check_region(const struct region *r)
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
+static int __bitmap_parselist(const char *buf, const char *const end,
 		int is_user, unsigned long *maskp,
 		int nmaskbits)
 {
-	unsigned int a, b, old_a, old_b;
-	unsigned int group_size, used_size;
-	int c, old_c, totaldigits, ndigits;
-	const char __user __force *ubuf = (const char __user __force *)buf;
-	int at_start, in_range, in_partial_range, ret;
 	struct region r;
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
-
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
-
-			if (c == ':') {
-				old_a = a;
-				old_b = b;
-				at_start = 1;
-				in_range = 0;
-				in_partial_range = 1;
-				a = b = 0;
-				continue;
-			}
-
-			if (c == '-') {
-				if (at_start || in_range)
-					return -EINVAL;
-				b = 0;
-				in_range = 1;
-				at_start = 1;
-				continue;
-			}
 
-			if (!isdigit(c))
-				return -EINVAL;
-
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
+	while (buf && buf <= end) {
+		buf = bitmap_find_region(buf, end, is_user);
+		if (buf == NULL)
+			return 0;
 
-		r.start = a;
-		r.off = used_size;
-		r.grlen = group_size;
-		r.end = b;
+		buf = bitmap_parse_region(&r, buf, end, is_user);
+		if (IS_ERR(buf))
+			return PTR_ERR(buf);
 
 		ret = bitmap_check_region(&r);
 		if (ret)
@@ -649,14 +697,14 @@ static int __bitmap_parselist(const char *buf, unsigned int buflen,
 		ret = bitmap_set_region(&r, maskp, nmaskbits);
 		if (ret)
 			return ret;
+	}
 
-	} while (buflen && c == ',');
 	return 0;
 }
 
 int bitmap_parselist(const char *bp, unsigned long *maskp, int nmaskbits)
 {
-	return __bitmap_parselist(bp, UINT_MAX, 0, maskp, nmaskbits);
+	return __bitmap_parselist(bp, (char *)SIZE_MAX, 0, maskp, nmaskbits);
 }
 EXPORT_SYMBOL(bitmap_parselist);
 
@@ -683,7 +731,8 @@ int bitmap_parselist_user(const char __user *ubuf,
 	if (!access_ok(ubuf, ulen))
 		return -EFAULT;
 	return __bitmap_parselist((const char __force *)ubuf,
-					ulen, 1, maskp, nmaskbits);
+				  (const char __force *)ubuf + ulen - 1,
+				  1, maskp, nmaskbits);
 }
 EXPORT_SYMBOL(bitmap_parselist_user);
 
-- 
2.17.1

