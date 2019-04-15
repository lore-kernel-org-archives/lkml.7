Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6B1C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A7E21900
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355624;
	bh=A4dKhwai7p3KTIy4UBC/QM+jGPVTdJObu7aKvtsdq8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0sPTC6KRfSdZcwwge7kLlvLnAjqEyBRv3mEk91cWRwR84QT7d4qbYkWBjL9/vvIWc
	 61XQCu3cDhhg0rvLk91Fu8n/hktArkTxmaKOJHYU9VW2uH5jUld+OtU2DDHJT+myd7
	 H2QNoA1fAapYnY4RxcrAiL29ZnnUivYHNhn2EhxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731618AbfDOTNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:13:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731210AbfDOTNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:13:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 379F4218A1;
        Mon, 15 Apr 2019 19:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355614;
        bh=A4dKhwai7p3KTIy4UBC/QM+jGPVTdJObu7aKvtsdq8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jGly4g9GbmpPDMxsxqKcZF6nfyde8tGvGCfEyhG+ftXpr0LOrrtBLgq2Z+mGQRQi9
         C/SrZDC1P9IhC3epYRY4HtdWWjd5zp+IaFwehREd6RrzOviOq3W+D+iw0mAfBuND7b
         iFhruWxyYYvTWkTi4hIjZj5EvDg7OzDUACi+wZ1Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Potapenko <glider@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Y Knight <jyknight@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 5.0 102/117] x86/asm: Use stricter assembly constraints in bitops
Date:   Mon, 15 Apr 2019 21:01:12 +0200
Message-Id: <20190415183749.962018205@linuxfoundation.org>
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

From: Alexander Potapenko <glider@google.com>

commit 5b77e95dd7790ff6c8fbf1cd8d0104ebed818a03 upstream.

There's a number of problems with how arch/x86/include/asm/bitops.h
is currently using assembly constraints for the memory region
bitops are modifying:

1) Use memory clobber in bitops that touch arbitrary memory

Certain bit operations that read/write bits take a base pointer and an
arbitrarily large offset to address the bit relative to that base.
Inline assembly constraints aren't expressive enough to tell the
compiler that the assembly directive is going to touch a specific memory
location of unknown size, therefore we have to use the "memory" clobber
to indicate that the assembly is going to access memory locations other
than those listed in the inputs/outputs.

To indicate that BTR/BTS instructions don't necessarily touch the first
sizeof(long) bytes of the argument, we also move the address to assembly
inputs.

This particular change leads to size increase of 124 kernel functions in
a defconfig build. For some of them the diff is in NOP operations, other
end up re-reading values from memory and may potentially slow down the
execution. But without these clobbers the compiler is free to cache
the contents of the bitmaps and use them as if they weren't changed by
the inline assembly.

2) Use byte-sized arguments for operations touching single bytes.

Passing a long value to ANDB/ORB/XORB instructions makes the compiler
treat sizeof(long) bytes as being clobbered, which isn't the case. This
may theoretically lead to worse code in the case of heavy optimization.

Practical impact:

I've built a defconfig kernel and looked through some of the functions
generated by GCC 7.3.0 with and without this clobber, and didn't spot
any miscompilations.

However there is a (trivial) theoretical case where this code leads to
miscompilation:

  https://lkml.org/lkml/2019/3/28/393

using just GCC 8.3.0 with -O2.  It isn't hard to imagine someone writes
such a function in the kernel someday.

So the primary motivation is to fix an existing misuse of the asm
directive, which happens to work in certain configurations now, but
isn't guaranteed to work under different circumstances.

[ --mingo: Added -stable tag because defconfig only builds a fraction
  of the kernel and the trivial testcase looks normal enough to
  be used in existing or in-development code. ]

Signed-off-by: Alexander Potapenko <glider@google.com>
Cc: <stable@vger.kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: James Y Knight <jyknight@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20190402112813.193378-1-glider@google.com
[ Edited the changelog, tidied up one of the defines. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/bitops.h |   41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -36,16 +36,17 @@
  * bit 0 is the LSB of addr; bit 32 is the LSB of (addr+1).
  */
 
-#define BITOP_ADDR(x) "+m" (*(volatile long *) (x))
+#define RLONG_ADDR(x)			 "m" (*(volatile long *) (x))
+#define WBYTE_ADDR(x)			"+m" (*(volatile char *) (x))
 
-#define ADDR				BITOP_ADDR(addr)
+#define ADDR				RLONG_ADDR(addr)
 
 /*
  * We do the locked ops that don't return the old value as
  * a mask operation on a byte.
  */
 #define IS_IMMEDIATE(nr)		(__builtin_constant_p(nr))
-#define CONST_MASK_ADDR(nr, addr)	BITOP_ADDR((void *)(addr) + ((nr)>>3))
+#define CONST_MASK_ADDR(nr, addr)	WBYTE_ADDR((void *)(addr) + ((nr)>>3))
 #define CONST_MASK(nr)			(1 << ((nr) & 7))
 
 /**
@@ -73,7 +74,7 @@ set_bit(long nr, volatile unsigned long
 			: "memory");
 	} else {
 		asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
-			: BITOP_ADDR(addr) : "Ir" (nr) : "memory");
+			: : RLONG_ADDR(addr), "Ir" (nr) : "memory");
 	}
 }
 
@@ -88,7 +89,7 @@ set_bit(long nr, volatile unsigned long
  */
 static __always_inline void __set_bit(long nr, volatile unsigned long *addr)
 {
-	asm volatile(__ASM_SIZE(bts) " %1,%0" : ADDR : "Ir" (nr) : "memory");
+	asm volatile(__ASM_SIZE(bts) " %1,%0" : : ADDR, "Ir" (nr) : "memory");
 }
 
 /**
@@ -110,8 +111,7 @@ clear_bit(long nr, volatile unsigned lon
 			: "iq" ((u8)~CONST_MASK(nr)));
 	} else {
 		asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
-			: BITOP_ADDR(addr)
-			: "Ir" (nr));
+			: : RLONG_ADDR(addr), "Ir" (nr) : "memory");
 	}
 }
 
@@ -131,7 +131,7 @@ static __always_inline void clear_bit_un
 
 static __always_inline void __clear_bit(long nr, volatile unsigned long *addr)
 {
-	asm volatile(__ASM_SIZE(btr) " %1,%0" : ADDR : "Ir" (nr));
+	asm volatile(__ASM_SIZE(btr) " %1,%0" : : ADDR, "Ir" (nr) : "memory");
 }
 
 static __always_inline bool clear_bit_unlock_is_negative_byte(long nr, volatile unsigned long *addr)
@@ -139,7 +139,7 @@ static __always_inline bool clear_bit_un
 	bool negative;
 	asm volatile(LOCK_PREFIX "andb %2,%1"
 		CC_SET(s)
-		: CC_OUT(s) (negative), ADDR
+		: CC_OUT(s) (negative), WBYTE_ADDR(addr)
 		: "ir" ((char) ~(1 << nr)) : "memory");
 	return negative;
 }
@@ -155,13 +155,9 @@ static __always_inline bool clear_bit_un
  * __clear_bit() is non-atomic and implies release semantics before the memory
  * operation. It can be used for an unlock if no other CPUs can concurrently
  * modify other bits in the word.
- *
- * No memory barrier is required here, because x86 cannot reorder stores past
- * older loads. Same principle as spin_unlock.
  */
 static __always_inline void __clear_bit_unlock(long nr, volatile unsigned long *addr)
 {
-	barrier();
 	__clear_bit(nr, addr);
 }
 
@@ -176,7 +172,7 @@ static __always_inline void __clear_bit_
  */
 static __always_inline void __change_bit(long nr, volatile unsigned long *addr)
 {
-	asm volatile(__ASM_SIZE(btc) " %1,%0" : ADDR : "Ir" (nr));
+	asm volatile(__ASM_SIZE(btc) " %1,%0" : : ADDR, "Ir" (nr) : "memory");
 }
 
 /**
@@ -196,8 +192,7 @@ static __always_inline void change_bit(l
 			: "iq" ((u8)CONST_MASK(nr)));
 	} else {
 		asm volatile(LOCK_PREFIX __ASM_SIZE(btc) " %1,%0"
-			: BITOP_ADDR(addr)
-			: "Ir" (nr));
+			: : RLONG_ADDR(addr), "Ir" (nr) : "memory");
 	}
 }
 
@@ -242,8 +237,8 @@ static __always_inline bool __test_and_s
 
 	asm(__ASM_SIZE(bts) " %2,%1"
 	    CC_SET(c)
-	    : CC_OUT(c) (oldbit), ADDR
-	    : "Ir" (nr));
+	    : CC_OUT(c) (oldbit)
+	    : ADDR, "Ir" (nr) : "memory");
 	return oldbit;
 }
 
@@ -282,8 +277,8 @@ static __always_inline bool __test_and_c
 
 	asm volatile(__ASM_SIZE(btr) " %2,%1"
 		     CC_SET(c)
-		     : CC_OUT(c) (oldbit), ADDR
-		     : "Ir" (nr));
+		     : CC_OUT(c) (oldbit)
+		     : ADDR, "Ir" (nr) : "memory");
 	return oldbit;
 }
 
@@ -294,8 +289,8 @@ static __always_inline bool __test_and_c
 
 	asm volatile(__ASM_SIZE(btc) " %2,%1"
 		     CC_SET(c)
-		     : CC_OUT(c) (oldbit), ADDR
-		     : "Ir" (nr) : "memory");
+		     : CC_OUT(c) (oldbit)
+		     : ADDR, "Ir" (nr) : "memory");
 
 	return oldbit;
 }
@@ -326,7 +321,7 @@ static __always_inline bool variable_tes
 	asm volatile(__ASM_SIZE(bt) " %2,%1"
 		     CC_SET(c)
 		     : CC_OUT(c) (oldbit)
-		     : "m" (*(unsigned long *)addr), "Ir" (nr));
+		     : "m" (*(unsigned long *)addr), "Ir" (nr) : "memory");
 
 	return oldbit;
 }


