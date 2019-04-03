Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A894C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4824B21473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOuQN+0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfDCEqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:46:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44529 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbfDCEq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:46:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id i2so7650421pgj.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 21:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=92kBQv2ExA9HVR7NGYsJXBIvGZFlI8rXpeFtbRzTg50=;
        b=QOuQN+0ejO1KMIxRO7llj4QaKrYrVgYUYJoITt4SvaiF0wNZanq01nanG1mrH8MXSS
         EJTXtVU3zGSVzph2hu31VxIRfgbRaQ50Z4OaJQ7+srmDUXr/XcYLhKzxUug5Bj6g5Pmz
         FX0ab8HBF1ywutsN3uf8moY2r3QdpjHy2q2kkYmMGDksxP/QvHsAlnJ6U/7VKmH9ZlNt
         AmlQmJJtgye1TDsrkgGJ1Q92Nn5xorHWV+NjRWG2zdyga/T5u1Pm7hUjtRhx1lZkiHkk
         QDk/If1TZj/TQamFV/t52VO52FF8z9s3sFqKQe25Zn/ejcmp9onC6n7Nz9uR9St5WMQF
         wCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=92kBQv2ExA9HVR7NGYsJXBIvGZFlI8rXpeFtbRzTg50=;
        b=Fm9O0T6np0zIDc4krd2eRiUu3MA0HSnByORyvHgqcRA1iO5OkIKKQULQSutp2Ri+2P
         U1HXGpRon5rHd9KZgkF9RY+08fSrYmMwz0/1IGrrR5dpbGAtZesCSrbNJ9OvWjEvUXwK
         PpMoENiNTVBMCLGyxyaVUNJqPmPXKKySUdkT8xQMi9n6ADgc8De+F85/DMLprxI4jBQ6
         nbQ+gPH7kGemXhiCr9Gtt7mT9wn7DIuN7t6Z3C7/VbiptVDyzrcvrOu3tUrihO495832
         ljfl23ZZCoc8tEjTQp7aEuVnhMCjtt5sIoa/B1OnOPFCmWIf2uHZJ+O1BH0sjGNG7L6a
         x2Zg==
X-Gm-Message-State: APjAAAUFssXIGfLolciGaFAuEsr6gu7O3frq0CDssPrHa1K6/DHxUNjh
        DzsxP+hE7v3NR0Rc49Ycucg=
X-Google-Smtp-Source: APXvYqwaQADbAQUT6V8TikCRYTEfJo/gSMsmK+z8XbPtdNB/RzaQuqFYHDYsQ9U6cselyEBhCJXUjA==
X-Received: by 2002:a63:384:: with SMTP id 126mr40808708pgd.341.1554266785991;
        Tue, 02 Apr 2019 21:46:25 -0700 (PDT)
Received: from localhost (c-71-202-79-220.hsd1.ca.comcast.net. [71.202.79.220])
        by smtp.gmail.com with ESMTPSA id g64sm33858587pfg.13.2019.04.02.21.46.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 21:46:25 -0700 (PDT)
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
Date:   Wed,  3 Apr 2019 07:45:37 +0300
Message-Id: <20190403044540.16322-3-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403044540.16322-1-ynorov@marvell.com>
References: <20190403044540.16322-1-ynorov@marvell.com>
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
index ce9ea804d06d..0c08f18aed88 100644
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
+ * with a \0 or \n.
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

