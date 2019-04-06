Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F244C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 08:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5A7218C3
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 08:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfDFIq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 04:46:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43033 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfDFIq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 04:46:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x368kQb73123206
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 6 Apr 2019 01:46:26 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x368kPH73123202;
        Sat, 6 Apr 2019 01:46:25 -0700
Date:   Sat, 6 Apr 2019 01:46:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Alexander Potapenko <tipbot@zytor.com>
Message-ID: <tip-5b77e95dd7790ff6c8fbf1cd8d0104ebed818a03@git.kernel.org>
Cc:     mingo@kernel.org, jyknight@google.com, tglx@linutronix.de,
        hpa@zytor.com, peterz@infradead.org, dvlasenk@redhat.com,
        linux-kernel@vger.kernel.org, paulmck@linux.ibm.com,
        stable@vger.kernel.org, bp@alien8.de,
        torvalds@linux-foundation.org, dvyukov@google.com,
        glider@google.com, brgerst@gmail.com, luto@kernel.org
Reply-To: bp@alien8.de, paulmck@linux.ibm.com, stable@vger.kernel.org,
          brgerst@gmail.com, luto@kernel.org,
          torvalds@linux-foundation.org, dvyukov@google.com,
          glider@google.com, peterz@infradead.org, jyknight@google.com,
          mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          dvlasenk@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190402112813.193378-1-glider@google.com>
References: <20190402112813.193378-1-glider@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/asm: Use stricter assembly constraints in
 bitops
Git-Commit-ID: 5b77e95dd7790ff6c8fbf1cd8d0104ebed818a03
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5b77e95dd7790ff6c8fbf1cd8d0104ebed818a03
Gitweb:     https://git.kernel.org/tip/5b77e95dd7790ff6c8fbf1cd8d0104ebed818a03
Author:     Alexander Potapenko <glider@google.com>
AuthorDate: Tue, 2 Apr 2019 13:28:13 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 6 Apr 2019 09:52:02 +0200

x86/asm: Use stricter assembly constraints in bitops

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
---
 arch/x86/include/asm/bitops.h | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index d153d570bb04..8e790ec219a5 100644
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
@@ -73,7 +74,7 @@ set_bit(long nr, volatile unsigned long *addr)
 			: "memory");
 	} else {
 		asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
-			: BITOP_ADDR(addr) : "Ir" (nr) : "memory");
+			: : RLONG_ADDR(addr), "Ir" (nr) : "memory");
 	}
 }
 
@@ -88,7 +89,7 @@ set_bit(long nr, volatile unsigned long *addr)
  */
 static __always_inline void __set_bit(long nr, volatile unsigned long *addr)
 {
-	asm volatile(__ASM_SIZE(bts) " %1,%0" : ADDR : "Ir" (nr) : "memory");
+	asm volatile(__ASM_SIZE(bts) " %1,%0" : : ADDR, "Ir" (nr) : "memory");
 }
 
 /**
@@ -110,8 +111,7 @@ clear_bit(long nr, volatile unsigned long *addr)
 			: "iq" ((u8)~CONST_MASK(nr)));
 	} else {
 		asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
-			: BITOP_ADDR(addr)
-			: "Ir" (nr));
+			: : RLONG_ADDR(addr), "Ir" (nr) : "memory");
 	}
 }
 
@@ -131,7 +131,7 @@ static __always_inline void clear_bit_unlock(long nr, volatile unsigned long *ad
 
 static __always_inline void __clear_bit(long nr, volatile unsigned long *addr)
 {
-	asm volatile(__ASM_SIZE(btr) " %1,%0" : ADDR : "Ir" (nr));
+	asm volatile(__ASM_SIZE(btr) " %1,%0" : : ADDR, "Ir" (nr) : "memory");
 }
 
 static __always_inline bool clear_bit_unlock_is_negative_byte(long nr, volatile unsigned long *addr)
@@ -139,7 +139,7 @@ static __always_inline bool clear_bit_unlock_is_negative_byte(long nr, volatile
 	bool negative;
 	asm volatile(LOCK_PREFIX "andb %2,%1"
 		CC_SET(s)
-		: CC_OUT(s) (negative), ADDR
+		: CC_OUT(s) (negative), WBYTE_ADDR(addr)
 		: "ir" ((char) ~(1 << nr)) : "memory");
 	return negative;
 }
@@ -155,13 +155,9 @@ static __always_inline bool clear_bit_unlock_is_negative_byte(long nr, volatile
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
 
@@ -176,7 +172,7 @@ static __always_inline void __clear_bit_unlock(long nr, volatile unsigned long *
  */
 static __always_inline void __change_bit(long nr, volatile unsigned long *addr)
 {
-	asm volatile(__ASM_SIZE(btc) " %1,%0" : ADDR : "Ir" (nr));
+	asm volatile(__ASM_SIZE(btc) " %1,%0" : : ADDR, "Ir" (nr) : "memory");
 }
 
 /**
@@ -196,8 +192,7 @@ static __always_inline void change_bit(long nr, volatile unsigned long *addr)
 			: "iq" ((u8)CONST_MASK(nr)));
 	} else {
 		asm volatile(LOCK_PREFIX __ASM_SIZE(btc) " %1,%0"
-			: BITOP_ADDR(addr)
-			: "Ir" (nr));
+			: : RLONG_ADDR(addr), "Ir" (nr) : "memory");
 	}
 }
 
@@ -242,8 +237,8 @@ static __always_inline bool __test_and_set_bit(long nr, volatile unsigned long *
 
 	asm(__ASM_SIZE(bts) " %2,%1"
 	    CC_SET(c)
-	    : CC_OUT(c) (oldbit), ADDR
-	    : "Ir" (nr));
+	    : CC_OUT(c) (oldbit)
+	    : ADDR, "Ir" (nr) : "memory");
 	return oldbit;
 }
 
@@ -282,8 +277,8 @@ static __always_inline bool __test_and_clear_bit(long nr, volatile unsigned long
 
 	asm volatile(__ASM_SIZE(btr) " %2,%1"
 		     CC_SET(c)
-		     : CC_OUT(c) (oldbit), ADDR
-		     : "Ir" (nr));
+		     : CC_OUT(c) (oldbit)
+		     : ADDR, "Ir" (nr) : "memory");
 	return oldbit;
 }
 
@@ -294,8 +289,8 @@ static __always_inline bool __test_and_change_bit(long nr, volatile unsigned lon
 
 	asm volatile(__ASM_SIZE(btc) " %2,%1"
 		     CC_SET(c)
-		     : CC_OUT(c) (oldbit), ADDR
-		     : "Ir" (nr) : "memory");
+		     : CC_OUT(c) (oldbit)
+		     : ADDR, "Ir" (nr) : "memory");
 
 	return oldbit;
 }
@@ -326,7 +321,7 @@ static __always_inline bool variable_test_bit(long nr, volatile const unsigned l
 	asm volatile(__ASM_SIZE(bt) " %2,%1"
 		     CC_SET(c)
 		     : CC_OUT(c) (oldbit)
-		     : "m" (*(unsigned long *)addr), "Ir" (nr));
+		     : "m" (*(unsigned long *)addr), "Ir" (nr) : "memory");
 
 	return oldbit;
 }
