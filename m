Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9074C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB09920811
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmdTLg9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbfCYVH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:07:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34866 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbfCYVH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:07:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id t21so7035944pfe.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 14:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GY0lBb62Z1iVATnV+m0gDyVgNs1C49ML0/XutpXLjs8=;
        b=mmdTLg9UiX/N1A5ZaqEEgsK4Z+pylWjrHAqTYY0Yz+5sCVRt1c7OLAKMckLP31JHy5
         2WMASsVga6fcW7xwLKwo5drPqZQFb7REtIynrATTdtxTChHzOc1k9SUsC7hI1xQY3vgO
         zE32VGYX+zqRgdY2VA2mrBElNnmoBysvFUXQ+j/vI9nMc6GhTH3yRt3DGoKqqmGRe1K2
         8LQyQ5MCQUw8EdGoiQrG527Tr+mikurisn/Ewvnleu6SQP9Cx5fC95BKvCHVQWcqHBWu
         Dh54vBKWSnbEYxtrQ/CI9qaSCKei7LY7ZKH1yJNmDN+6iFyRV43DsNZAxHL9PyFnYVac
         rS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GY0lBb62Z1iVATnV+m0gDyVgNs1C49ML0/XutpXLjs8=;
        b=tTw5bfjwj0VeodvoJYUV/62L+MEa6y3WgRNn6tobqRnxKrT8m2DbhYUWUC7r54qZj1
         28wS72DXtlw/lO03SmJKOl8nNizFc6w88pLNdzKDkkUFY95Z+7h+/3RHsejCw9mbJIaf
         QuEgQj11eTgmrzWGV3jFHbHZr3DV+gecYToUXGJjE+fEpwsAEUp3PUjkQN4QprjzZ9O2
         aQXLwbGtvASqMfI55hXwf1T7Tqz2GLKcfhylsmZXAV1vvt/jfCyuy25M7NHbQE/cwRre
         dOtpbH6qUdb5khit6lstJjsbdaJ7P3CcLoqyEWJWNJ5hAQ9pNCf/NwIsUCd+XlZ0UaET
         /SLw==
X-Gm-Message-State: APjAAAW7LVY7CLs6zviDfuXq9YnRhEkHdK5ztWlmcKL7WVuHsMwnAfZ2
        LGi5VIHQlOBel4BvgcCmXG4=
X-Google-Smtp-Source: APXvYqwqRICMtaC4r/hcxvJtB5uvAtce3B0EZdc2tZj3SFpSisrplCozuh13coB8yHjWW2W8Ce0flA==
X-Received: by 2002:a63:4620:: with SMTP id t32mr23519881pga.363.1553548075505;
        Mon, 25 Mar 2019 14:07:55 -0700 (PDT)
Received: from localhost ([169.229.22.206])
        by smtp.gmail.com with ESMTPSA id i79sm35719109pfj.28.2019.03.25.14.07.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 14:07:54 -0700 (PDT)
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
Subject: [PATCH 2/6] bitmap_parselist: move non-parser logic to helpers
Date:   Tue, 26 Mar 2019 00:07:44 +0300
Message-Id: <20190325210748.6571-3-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190325210748.6571-1-ynorov@marvell.com>
References: <20190325210748.6571-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move region checking and setting functionality of __bitmap_parselist()
to helpers.

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 lib/bitmap.c | 64 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 53 insertions(+), 11 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index ad1fb7e6ad0e..307a1b20bead 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -477,6 +477,42 @@ int bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
 }
 EXPORT_SYMBOL(bitmap_print_to_pagebuf);
 
+/*
+ * Region 9-38:4/10 describes the following bitmap structure:
+ * 0	   9  12    18			38
+ * .........****......****......****......
+ *	    ^  ^     ^			 ^
+ *      start  off   grlen	       end
+ */
+struct region {
+	unsigned int start;
+	unsigned int off;
+	unsigned int grlen;
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
+	for (start = r->start; start <= r->end; start += r->grlen)
+		bitmap_set(bitmap, start, min(r->end - start + 1, r->off));
+
+	return 0;
+}
+
+static int bitmap_check_region(const struct region *r)
+{
+	if (r->start > r->end || r->grlen == 0 || r->off > r->grlen)
+		return -EINVAL;
+
+	return 0;
+}
+
 /**
  * __bitmap_parselist - convert list format ASCII string to bitmap
  * @buf: read nul-terminated user string from this buffer
@@ -507,10 +543,11 @@ static int __bitmap_parselist(const char *buf, unsigned int buflen,
 		int nmaskbits)
 {
 	unsigned int a, b, old_a, old_b;
-	unsigned int group_size, used_size, off;
+	unsigned int group_size, used_size;
 	int c, old_c, totaldigits, ndigits;
 	const char __user __force *ubuf = (const char __user __force *)buf;
-	int at_start, in_range, in_partial_range;
+	int at_start, in_range, in_partial_range, ret;
+	struct region r;
 
 	totaldigits = c = 0;
 	old_a = old_b = 0;
@@ -599,15 +636,20 @@ static int __bitmap_parselist(const char *buf, unsigned int buflen,
 		/* if no digit is after '-', it's wrong*/
 		if (at_start && in_range)
 			return -EINVAL;
-		if (!(a <= b) || group_size == 0 || !(used_size <= group_size))
-			return -EINVAL;
-		if (b >= nmaskbits)
-			return -ERANGE;
-		while (a <= b) {
-			off = min(b - a + 1, used_size);
-			bitmap_set(maskp, a, off);
-			a += group_size;
-		}
+
+		r.start = a;
+		r.off = used_size;
+		r.grlen = group_size;
+		r.end = b;
+
+		ret = bitmap_check_region(&r);
+		if (ret)
+			return ret;
+
+		ret = bitmap_set_region(&r, maskp, nmaskbits);
+		if (ret)
+			return ret;
+
 	} while (buflen && c == ',');
 	return 0;
 }
-- 
2.17.1

