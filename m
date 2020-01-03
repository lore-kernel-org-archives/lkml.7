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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9F9C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 20:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4475222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 20:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7GVuA8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgACU25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 15:28:57 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:36102 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbgACU24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 15:28:56 -0500
Received: by mail-qv1-f68.google.com with SMTP id m14so778286qvl.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 12:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jXlFrv5suVl3y6O6KE2LYcFNn/cTU2G8H8GW8PfkEq8=;
        b=s7GVuA8OGitfoyLpLMB3qYwYMnWzkc4h+tQJxA5H0v08yhtPNc8u4NPSUB57eBPXAg
         Zcj8NxAE9xuQKkd6mqXp5xIOXTNkH2mw8xeCOd71ucQAZIIQ3LDKlFRyjMKNbOm4z7Ca
         zn2TMm9vVlmAQzCerUnqCYJRlYjZRKawDAOyxRUsEbzgVJOJhynW3swPcuM/Su+Fioh7
         wcHxQct/0sUMybjuiMBwgqGbzZJEZ4IZMR/tUP/Wk6jgjA0y+eKRoV946ZQRUYo4JT8x
         mp+H+0n0aJJRs5Qzv8soiMcM1Tq93qoWHwcbIoe4AYZuvc4EKXUtAoI6KcSLoJwv7st4
         6EfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jXlFrv5suVl3y6O6KE2LYcFNn/cTU2G8H8GW8PfkEq8=;
        b=got7E66lzkmNpdI0B2EwK21fbgBtkgD12qZDtElAw5bUKibKkrp+NlJQsKOkKh5QE2
         Xt2KuP+3I6OCbE16gU+7x2cfI6o82LKNzFuErU0MILEICj2PTbWWKx24u7/3j+9JY2+r
         x+e5qXl2XV01+mVtBv3bTZP/9KM31yvfccKH+YvrOA0u9SCvZetft96hJR+s1UG0ZmWQ
         EC1es11Hl6Ebf5D9JOmAkL+UZEzOMdoKHcU8NKByJ+iAts3LgW2RWUQ/+MkB4txI9QfK
         hF+Y1CBAd0k1WDImPHCW+/VAeC1pmBUhQCFcsjtw1bl7pkQTU6Rqki7ilq+CybWcEh0v
         EMnA==
X-Gm-Message-State: APjAAAWlxKBUhGF+agldc8apH2Dz9SYKlLryuDKAI8RE4tTpRrpaggvI
        gEKi7BCi0xyUAKwgirAnqPfyC8bO
X-Google-Smtp-Source: APXvYqzuRZfG31q/XzYzMHkV2L8iZiM/HaHTCJiIOqZ2TE40Y0vHUtFABKCaOn1h4AVLCzyYgDo+PQ==
X-Received: by 2002:a0c:8d0a:: with SMTP id r10mr65705052qvb.7.1578083335456;
        Fri, 03 Jan 2020 12:28:55 -0800 (PST)
Received: from yury-thinkpad.dhcp.amer.jpmchase.net ([2604:2000:4185:2300:b196:4884:e960:2cb8])
        by smtp.gmail.com with ESMTPSA id y91sm19048347qtd.28.2020.01.03.12.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 12:28:54 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Allison Randal <allison@lohutok.net>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] uapi: rename ext2_swab() to swab() and share globally in swab.h
Date:   Fri,  3 Jan 2020 12:28:44 -0800
Message-Id: <20200103202846.21616-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ext2_swab() is defined locally in lib/find_bit.c However it is not specific
to ext2, neither to bitmaps.

There are many potential users of it, so rename it to just swab() and move
to include/uapi/linux/swab.h

ABI guarantees that size of unsigned long corresponds to BITS_PER_LONG,
therefore drop unneeded cast.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/swab.h      |  1 +
 include/uapi/linux/swab.h | 10 ++++++++++
 lib/find_bit.c            | 16 ++--------------
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/include/linux/swab.h b/include/linux/swab.h
index e466fd159c857..bcff5149861a9 100644
--- a/include/linux/swab.h
+++ b/include/linux/swab.h
@@ -7,6 +7,7 @@
 # define swab16 __swab16
 # define swab32 __swab32
 # define swab64 __swab64
+# define swab __swab
 # define swahw32 __swahw32
 # define swahb32 __swahb32
 # define swab16p __swab16p
diff --git a/include/uapi/linux/swab.h b/include/uapi/linux/swab.h
index 23cd84868cc3b..fa7f97da5b768 100644
--- a/include/uapi/linux/swab.h
+++ b/include/uapi/linux/swab.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <asm/bitsperlong.h>
 #include <asm/swab.h>
 
 /*
@@ -132,6 +133,15 @@ static inline __attribute_const__ __u32 __fswahb32(__u32 val)
 	__fswab64(x))
 #endif
 
+static __always_inline unsigned long __swab(const unsigned long y)
+{
+#if BITS_PER_LONG == 64
+	return __swab64(y);
+#else /* BITS_PER_LONG == 32 */
+	return __swab32(y);
+#endif
+}
+
 /**
  * __swahw32 - return a word-swapped 32-bit value
  * @x: value to wordswap
diff --git a/lib/find_bit.c b/lib/find_bit.c
index e35a76b291e69..06e503c339f37 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -149,18 +149,6 @@ EXPORT_SYMBOL(find_last_bit);
 
 #ifdef __BIG_ENDIAN
 
-/* include/linux/byteorder does not support "unsigned long" type */
-static inline unsigned long ext2_swab(const unsigned long y)
-{
-#if BITS_PER_LONG == 64
-	return (unsigned long) __swab64((u64) y);
-#elif BITS_PER_LONG == 32
-	return (unsigned long) __swab32((u32) y);
-#else
-#error BITS_PER_LONG not defined
-#endif
-}
-
 #if !defined(find_next_bit_le) || !defined(find_next_zero_bit_le)
 static inline unsigned long _find_next_bit_le(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long nbits,
@@ -177,7 +165,7 @@ static inline unsigned long _find_next_bit_le(const unsigned long *addr1,
 	tmp ^= invert;
 
 	/* Handle 1st word. */
-	tmp &= ext2_swab(BITMAP_FIRST_WORD_MASK(start));
+	tmp &= swab(BITMAP_FIRST_WORD_MASK(start));
 	start = round_down(start, BITS_PER_LONG);
 
 	while (!tmp) {
@@ -191,7 +179,7 @@ static inline unsigned long _find_next_bit_le(const unsigned long *addr1,
 		tmp ^= invert;
 	}
 
-	return min(start + __ffs(ext2_swab(tmp)), nbits);
+	return min(start + __ffs(swab(tmp)), nbits);
 }
 #endif
 
-- 
2.20.1

