Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E38C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A7E2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355727;
	bh=WvdxNWhfu86TFr5kc+o9igrBs1ywMP3YufYZFiWd8R8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NRobHa2t2SrEBgxb/MaAQtjR/6t812H41hyyOByO+F+feyzQrV79VJOG5q1xsrST/
	 9czhmXL9sFMaqM7Bnh71XIQCaTTfBQ5f0+d2bx9VkEshjmkSQNH9c2KS4+mylC2aL/
	 v8kE6g3FYj4lWHVs8CHMvxIXjJVHd+GKnmbWQKgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbfDOTP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:15:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730881AbfDOTOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:14:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 729DE2073F;
        Mon, 15 Apr 2019 19:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355650;
        bh=WvdxNWhfu86TFr5kc+o9igrBs1ywMP3YufYZFiWd8R8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d3p8s8iZ2262sBCrbdwvuamdZju/LL3Vex7k6kMXXcyUjc0YiHKo5+gQS4Bmw0w3k
         sb09aW10/TOKWMBomMOFwTnEpzcXsMD/xBzAcsw4q5CC+b43tqq9bGJ1tEQIgjLmSd
         NXgsvJLcMeKwqz18EUfzHCJcV/NK5zp4o0rw8nW4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>
Subject: [PATCH 5.0 101/117] x86/asm: Remove dead __GNUC__ conditionals
Date:   Mon, 15 Apr 2019 21:01:11 +0200
Message-Id: <20190415183749.921875504@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

commit 88ca66d8540ca26119b1428cddb96b37925bdf01 upstream.

The minimum supported gcc version is >= 4.6, so these can be removed.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190111084931.24601-1-linux@rasmusvillemoes.dk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/bitops.h    |    6 ------
 arch/x86/include/asm/string_32.h |   20 --------------------
 arch/x86/include/asm/string_64.h |   15 ---------------
 3 files changed, 41 deletions(-)

--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -36,13 +36,7 @@
  * bit 0 is the LSB of addr; bit 32 is the LSB of (addr+1).
  */
 
-#if __GNUC__ < 4 || (__GNUC__ == 4 && __GNUC_MINOR__ < 1)
-/* Technically wrong, but this avoids compilation errors on some gcc
-   versions. */
-#define BITOP_ADDR(x) "=m" (*(volatile long *) (x))
-#else
 #define BITOP_ADDR(x) "+m" (*(volatile long *) (x))
-#endif
 
 #define ADDR				BITOP_ADDR(addr)
 
--- a/arch/x86/include/asm/string_32.h
+++ b/arch/x86/include/asm/string_32.h
@@ -179,14 +179,7 @@ static inline void *__memcpy3d(void *to,
  *	No 3D Now!
  */
 
-#if (__GNUC__ >= 4)
 #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
-#else
-#define memcpy(t, f, n)				\
-	(__builtin_constant_p((n))		\
-	 ? __constant_memcpy((t), (f), (n))	\
-	 : __memcpy((t), (f), (n)))
-#endif
 
 #endif
 #endif /* !CONFIG_FORTIFY_SOURCE */
@@ -282,12 +275,7 @@ void *__constant_c_and_count_memset(void
 
 	{
 		int d0, d1;
-#if __GNUC__ == 4 && __GNUC_MINOR__ == 0
-		/* Workaround for broken gcc 4.0 */
-		register unsigned long eax asm("%eax") = pattern;
-#else
 		unsigned long eax = pattern;
-#endif
 
 		switch (count % 4) {
 		case 0:
@@ -321,15 +309,7 @@ void *__constant_c_and_count_memset(void
 #define __HAVE_ARCH_MEMSET
 extern void *memset(void *, int, size_t);
 #ifndef CONFIG_FORTIFY_SOURCE
-#if (__GNUC__ >= 4)
 #define memset(s, c, count) __builtin_memset(s, c, count)
-#else
-#define memset(s, c, count)						\
-	(__builtin_constant_p(c)					\
-	 ? __constant_c_x_memset((s), (0x01010101UL * (unsigned char)(c)), \
-				 (count))				\
-	 : __memset((s), (c), (count)))
-#endif
 #endif /* !CONFIG_FORTIFY_SOURCE */
 
 #define __HAVE_ARCH_MEMSET16
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -14,21 +14,6 @@
 extern void *memcpy(void *to, const void *from, size_t len);
 extern void *__memcpy(void *to, const void *from, size_t len);
 
-#ifndef CONFIG_FORTIFY_SOURCE
-#if (__GNUC__ == 4 && __GNUC_MINOR__ < 3) || __GNUC__ < 4
-#define memcpy(dst, src, len)					\
-({								\
-	size_t __len = (len);					\
-	void *__ret;						\
-	if (__builtin_constant_p(len) && __len >= 64)		\
-		__ret = __memcpy((dst), (src), __len);		\
-	else							\
-		__ret = __builtin_memcpy((dst), (src), __len);	\
-	__ret;							\
-})
-#endif
-#endif /* !CONFIG_FORTIFY_SOURCE */
-
 #define __HAVE_ARCH_MEMSET
 void *memset(void *s, int c, size_t n);
 void *__memset(void *s, int c, size_t n);


