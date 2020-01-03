Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7E2C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 20:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F56222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 20:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQj0Vt2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgACU3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 15:29:04 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37596 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbgACU25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 15:28:57 -0500
Received: by mail-qv1-f68.google.com with SMTP id f16so16700382qvi.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 12:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=E83wgRqyHBhU4D4z8XzMATUD/R3LBsUPHNQ0AmfZeZU=;
        b=jQj0Vt2YMKxRwpDt66BcIDs7au0Ujz3T1AlJMFL6YzHQArlsO4+o1wy+cOTkbaVfxJ
         gWve+VU0PDZXFTGPEw7VsyqbVm7aouGv1IJnWhBWN7ssEuBWYCqFSE11uVv9NQtPe+7o
         Ec+e5pBVTdaIMofRsdFo79/b8B0tohHRXZSw+nbpTfQ03ZFYxJEdMIJzigcK6ZGqtftP
         LkO74RQF/Ltj51umVhFNdL+Dw0pBadzQ1y/aiRjkM/g2Qu1liM5Y03PU+y8G0yKNS5iL
         3St+M5cA+zS+HIhN1pHm/OmmrO+X0XLWK0bMeGnP58INoCMNdDdDNclbXFEcoNlvMSTQ
         5bQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E83wgRqyHBhU4D4z8XzMATUD/R3LBsUPHNQ0AmfZeZU=;
        b=MyYgSd+1hneppIy9i1R1/Wy28AsU6vhFs7b2lENW0fN5TG/6esCcgzn59eUumbsxkW
         i9jhUYwKJEPclpWPKlgqHiMuuNDoUrG/oP2jgws+uur3wXoGEWrQ0jqqNi9lXyfOq/X6
         pQ8PYpKuYU5jd5ZBHX7Dtg44Z/2wRZymufReZBI0a9msqAGjqh/pVpMx6vC5GJ5qMwgr
         eGuQwpdWCf8Mu82/iNYlGk7yIJXQsAhgUPg6vrgDK5LAEEAOomyI1nUGop6srfqzvQZ4
         quappEHcZNXucfrKjbLYEc/VbhcUlWo/yBHswb1B9fsJJ6KBulfSNKEU7U9PpS/D0a2C
         b2Fg==
X-Gm-Message-State: APjAAAVdIeFwSZztkQnM9b/XeQvvcYHcKGrkJKYIEWv/l+BXmjMcUc4P
        mxbuPWKnCJRfOFnoYjaPu/8=
X-Google-Smtp-Source: APXvYqzIm4pXPWxqQmjmEdB3E4AkLUTeaDOWh6AuC5w2XEyz+ClU8d91kuwHvuDmzcif3d57hjtkkg==
X-Received: by 2002:ad4:42d1:: with SMTP id f17mr68782316qvr.30.1578083336454;
        Fri, 03 Jan 2020 12:28:56 -0800 (PST)
Received: from yury-thinkpad.dhcp.amer.jpmchase.net ([2604:2000:4185:2300:b196:4884:e960:2cb8])
        by smtp.gmail.com with ESMTPSA id y91sm19048347qtd.28.2020.01.03.12.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 12:28:55 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Allison Randal <allison@lohutok.net>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] lib/find_bit.c: join _find_next_bit{_le}
Date:   Fri,  3 Jan 2020 12:28:45 -0800
Message-Id: <20200103202846.21616-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200103202846.21616-1-yury.norov@gmail.com>
References: <20200103202846.21616-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_find_next_bit and _find_next_bit_le are very similar functions.
It's possible to join them by adding 1 parameter and a couple of
simple checks. It's simplify maintenance and make possible to
shrink the size of .text by un-inlining the unified function (in
the following patch).

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/find_bit.c | 64 +++++++++++++++-----------------------------------
 1 file changed, 19 insertions(+), 45 deletions(-)

diff --git a/lib/find_bit.c b/lib/find_bit.c
index 06e503c339f37..c03cbecb2b1f6 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -17,9 +17,9 @@
 #include <linux/export.h>
 #include <linux/kernel.h>
 
-#if !defined(find_next_bit) || !defined(find_next_zero_bit) || \
-		!defined(find_next_and_bit)
-
+#if !defined(find_next_bit) || !defined(find_next_zero_bit) ||			\
+	!defined(find_next_bit_le) || !defined(find_next_zero_bit_le) ||	\
+	!defined(find_next_and_bit)
 /*
  * This is a common helper function for find_next_bit, find_next_zero_bit, and
  * find_next_and_bit. The differences are:
@@ -29,9 +29,9 @@
  */
 static inline unsigned long _find_next_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long nbits,
-		unsigned long start, unsigned long invert)
+		unsigned long start, unsigned long invert, unsigned long le)
 {
-	unsigned long tmp;
+	unsigned long tmp, mask;
 
 	if (unlikely(start >= nbits))
 		return nbits;
@@ -42,7 +42,12 @@ static inline unsigned long _find_next_bit(const unsigned long *addr1,
 	tmp ^= invert;
 
 	/* Handle 1st word. */
-	tmp &= BITMAP_FIRST_WORD_MASK(start);
+	mask = BITMAP_FIRST_WORD_MASK(start);
+	if (le)
+		mask = swab(mask);
+
+	tmp &= mask;
+
 	start = round_down(start, BITS_PER_LONG);
 
 	while (!tmp) {
@@ -56,6 +61,9 @@ static inline unsigned long _find_next_bit(const unsigned long *addr1,
 		tmp ^= invert;
 	}
 
+	if (le)
+		tmp = swab(tmp);
+
 	return min(start + __ffs(tmp), nbits);
 }
 #endif
@@ -67,7 +75,7 @@ static inline unsigned long _find_next_bit(const unsigned long *addr1,
 unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
 			    unsigned long offset)
 {
-	return _find_next_bit(addr, NULL, size, offset, 0UL);
+	return _find_next_bit(addr, NULL, size, offset, 0UL, 0);
 }
 EXPORT_SYMBOL(find_next_bit);
 #endif
@@ -76,7 +84,7 @@ EXPORT_SYMBOL(find_next_bit);
 unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 				 unsigned long offset)
 {
-	return _find_next_bit(addr, NULL, size, offset, ~0UL);
+	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0);
 }
 EXPORT_SYMBOL(find_next_zero_bit);
 #endif
@@ -86,7 +94,7 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long size,
 		unsigned long offset)
 {
-	return _find_next_bit(addr1, addr2, size, offset, 0UL);
+	return _find_next_bit(addr1, addr2, size, offset, 0UL, 0);
 }
 EXPORT_SYMBOL(find_next_and_bit);
 #endif
@@ -149,45 +157,11 @@ EXPORT_SYMBOL(find_last_bit);
 
 #ifdef __BIG_ENDIAN
 
-#if !defined(find_next_bit_le) || !defined(find_next_zero_bit_le)
-static inline unsigned long _find_next_bit_le(const unsigned long *addr1,
-		const unsigned long *addr2, unsigned long nbits,
-		unsigned long start, unsigned long invert)
-{
-	unsigned long tmp;
-
-	if (unlikely(start >= nbits))
-		return nbits;
-
-	tmp = addr1[start / BITS_PER_LONG];
-	if (addr2)
-		tmp &= addr2[start / BITS_PER_LONG];
-	tmp ^= invert;
-
-	/* Handle 1st word. */
-	tmp &= swab(BITMAP_FIRST_WORD_MASK(start));
-	start = round_down(start, BITS_PER_LONG);
-
-	while (!tmp) {
-		start += BITS_PER_LONG;
-		if (start >= nbits)
-			return nbits;
-
-		tmp = addr1[start / BITS_PER_LONG];
-		if (addr2)
-			tmp &= addr2[start / BITS_PER_LONG];
-		tmp ^= invert;
-	}
-
-	return min(start + __ffs(swab(tmp)), nbits);
-}
-#endif
-
 #ifndef find_next_zero_bit_le
 unsigned long find_next_zero_bit_le(const void *addr, unsigned
 		long size, unsigned long offset)
 {
-	return _find_next_bit_le(addr, NULL, size, offset, ~0UL);
+	return _find_next_bit(addr, NULL, size, offset, ~0UL, 1);
 }
 EXPORT_SYMBOL(find_next_zero_bit_le);
 #endif
@@ -196,7 +170,7 @@ EXPORT_SYMBOL(find_next_zero_bit_le);
 unsigned long find_next_bit_le(const void *addr, unsigned
 		long size, unsigned long offset)
 {
-	return _find_next_bit_le(addr, NULL, size, offset, 0UL);
+	return _find_next_bit(addr, NULL, size, offset, 0UL, 1);
 }
 EXPORT_SYMBOL(find_next_bit_le);
 #endif
-- 
2.20.1

