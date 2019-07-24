Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A7FC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A39214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Y8l89H10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390025AbfGXU3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:29:44 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36354 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389224AbfGXU3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:29:42 -0400
Received: by mail-qk1-f193.google.com with SMTP id g18so34761028qkl.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 13:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jMuXZCkU9Ct89wOn6NBnDyHgJz0Yj3VpJrE3krYoMBo=;
        b=Y8l89H10hDJOBdtg0LtWprl/ct7QZfhT5686p+b9YXoN+oy3Eclg3xjZXguHL3KwmO
         abUyx4EoNNPkVVU0UByMLrD6y7rbBUYgi4E3RQTBS+z94H/nZiuLXHMLAIWoui/4bUlG
         PnOwXPkgW2UZbhsNwQW7pkaX5YGilXWuOsloqeV9lUjsAB5aRFrEvXvwgp1wTqFrQ5O5
         g1sz3KrIkBtUt7opmlF21wev+CI73210Iu930+Biwds/yzbhGeNO7TMcZPbQ5q4pZb2A
         WmUz2zd/8AtntvDiB3BIrPjWuzlzNdxRPx/fCF+GhdkaF562DDlA746+0Fk4qMHUBFiJ
         9BpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jMuXZCkU9Ct89wOn6NBnDyHgJz0Yj3VpJrE3krYoMBo=;
        b=qSJuXAQyaU/8RRX0OKUElKTYigFROSzYCe334lNgevEn/gorFeJjZVhn9jXkS1Xzlf
         c1dtXOTQPxnhU9jPW3rfz71ZIm7tuZFJsLntQhD8GnJ2fEiMu3vdQuVcR0HxszlxoJQp
         Ztvm4pmNUuG9yBC2w3Q/kvBfH3CBYDnL7mniCCWnkDU1w7URQHl3QNMprZc58X+5+JEn
         9AVLXlnN1vd7FzMoRLyPaXk7qPDthh5Jqgmc9hM67nwYwDKoMphwe8ZaXCWhUflPfmYo
         YMsgQQTC22fAEUX/MlOB4oMJ8y1Q0ju2lM2eGCiSU6S3SaGJzTxP2Am1kYwFg9aEaKDD
         0LAg==
X-Gm-Message-State: APjAAAXVicAi0KtWQenEFnv81Oh3uOh+85FTvltig3eIpriypXT8cx5d
        oEfn3RgqxmT4GNGcdw+0xCS0LQ==
X-Google-Smtp-Source: APXvYqw9LTSo4+/ExlpXauIFR9jBl5GdjmT+cEkMwOIsoifwY6EF1GRlgatrSdGiKHpe4HSQVmcY2g==
X-Received: by 2002:a05:620a:10bc:: with SMTP id h28mr55522007qkk.289.1564000181815;
        Wed, 24 Jul 2019 13:29:41 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id r205sm24529121qke.115.2019.07.24.13.29.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 13:29:41 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     davem@davemloft.net, arnd@arndb.de, dhowells@redhat.com,
        ndesaulniers@google.com, morbo@google.com, jyknight@google.com,
        natechancellor@gmail.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH v2] asm-generic: fix -Wtype-limits compiler warnings
Date:   Wed, 24 Jul 2019 16:29:26 -0400
Message-Id: <1564000166-31428-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit d66acc39c7ce ("bitops: Optimise get_order()") introduced a
compilation warning because "rx_frag_size" is an "ushort" while
PAGE_SHIFT here is 16. The commit changed the get_order() to be a
multi-line macro where compilers insist to check all statements in the
macro even when __builtin_constant_p(rx_frag_size) will return false as
"rx_frag_size" is a module parameter.

In file included from ./arch/powerpc/include/asm/page_64.h:107,
                 from ./arch/powerpc/include/asm/page.h:242,
                 from ./arch/powerpc/include/asm/mmu.h:132,
                 from ./arch/powerpc/include/asm/lppaca.h:47,
                 from ./arch/powerpc/include/asm/paca.h:17,
                 from ./arch/powerpc/include/asm/current.h:13,
                 from ./include/linux/thread_info.h:21,
                 from ./arch/powerpc/include/asm/processor.h:39,
                 from ./include/linux/prefetch.h:15,
                 from drivers/net/ethernet/emulex/benet/be_main.c:14:
drivers/net/ethernet/emulex/benet/be_main.c: In function
'be_rx_cqs_create':
./include/asm-generic/getorder.h:54:9: warning: comparison is always
true due to limited range of data type [-Wtype-limits]
   (((n) < (1UL << PAGE_SHIFT)) ? 0 :  \
         ^
drivers/net/ethernet/emulex/benet/be_main.c:3138:33: note: in expansion
of macro 'get_order'
  adapter->big_page_size = (1 << get_order(rx_frag_size)) * PAGE_SIZE;
                                 ^~~~~~~~~

Fix it by moving all of this multi-line macro into a proper function,
and killing __get_order() off.

Fixes: d66acc39c7ce ("bitops: Optimise get_order()")
Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: Kill off __get_order() per Andrew.
    Update the comments per David.
    Remove a variable "order" to be consistent with the rest of return
    statements.

 include/asm-generic/getorder.h | 50 +++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 30 deletions(-)

diff --git a/include/asm-generic/getorder.h b/include/asm-generic/getorder.h
index c64bea7a52be..e9f20b813a69 100644
--- a/include/asm-generic/getorder.h
+++ b/include/asm-generic/getorder.h
@@ -7,24 +7,6 @@
 #include <linux/compiler.h>
 #include <linux/log2.h>
 
-/*
- * Runtime evaluation of get_order()
- */
-static inline __attribute_const__
-int __get_order(unsigned long size)
-{
-	int order;
-
-	size--;
-	size >>= PAGE_SHIFT;
-#if BITS_PER_LONG == 32
-	order = fls(size);
-#else
-	order = fls64(size);
-#endif
-	return order;
-}
-
 /**
  * get_order - Determine the allocation order of a memory size
  * @size: The size for which to get the order
@@ -43,19 +25,27 @@ int __get_order(unsigned long size)
  * to hold an object of the specified size.
  *
  * The result is undefined if the size is 0.
- *
- * This function may be used to initialise variables with compile time
- * evaluations of constants.
  */
-#define get_order(n)						\
-(								\
-	__builtin_constant_p(n) ? (				\
-		((n) == 0UL) ? BITS_PER_LONG - PAGE_SHIFT :	\
-		(((n) < (1UL << PAGE_SHIFT)) ? 0 :		\
-		 ilog2((n) - 1) - PAGE_SHIFT + 1)		\
-	) :							\
-	__get_order(n)						\
-)
+static inline __attribute_const__ int get_order(unsigned long size)
+{
+	if (__builtin_constant_p(size)) {
+		if (!size)
+			return BITS_PER_LONG - PAGE_SHIFT;
+
+		if (size < (1UL << PAGE_SHIFT))
+			return 0;
+
+		return ilog2((size) - 1) - PAGE_SHIFT + 1;
+	}
+
+	size--;
+	size >>= PAGE_SHIFT;
+#if BITS_PER_LONG == 32
+	return fls(size);
+#else
+	return fls64(size);
+#endif
+}
 
 #endif	/* __ASSEMBLY__ */
 
-- 
1.8.3.1

