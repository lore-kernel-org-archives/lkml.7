Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC771C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D2B2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dCRP0Pxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbfDBL2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:28:24 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:57332 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDBL2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:28:23 -0400
Received: by mail-pg1-f202.google.com with SMTP id h14so5804502pgn.23
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 04:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7SS6P6JHNXSn0UjPFp+y0uTOg2vVTb/5Uh4qZ9MyEaQ=;
        b=dCRP0PxuLFP45jTz4uhtU0ufNmC9ZifsYoEACf4P5JIimWIvv+W9U8qz7o5VPn/96D
         42wEjyphS1UuE4VO3vuUSJ2DK+kegfUaDClUIfj/XjDZ9jfJitiA2rMIYtr6OB8Ae57h
         a2J6TdWnT2HlyzSS6K/CHgb6QcnBh65fLOxSdE0QrkkaHfJZ3Kz9KEHOZE+aPcfKqS2L
         RpBVlUGqnB4ExbdthFp0FtPb7LqNTEvaKnlXgFwBNQL3C8PKf64qpsg5fzEWTdwUwnK4
         61PU3HkQVmYM+CqSh6d8CttnlRiR/3nRFInFsIOv8cQ7VOWlSJgv9VhTVITAdfPXuHVx
         63Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7SS6P6JHNXSn0UjPFp+y0uTOg2vVTb/5Uh4qZ9MyEaQ=;
        b=Lyx7wG4RVXWzy3DGgBHYCowfjIMLGxiPslpw18uTl5AQmFKneJqyZbJjfwNgKr+i9f
         485CFOJC6Ok/zvDNQsstGQmrUjf1eNqjJSEjfx1cX/veVDxmKxiXe+EQTvNusgxbKH5c
         siJjaJalbkJ6LUSIsKS+/CCNAHLLnAYu5ZB2g9r4ye70dk6SMMpdoHNnAPulBMWA4IvK
         Szds3MfuImvFxc8VT0XsMLF44/q2YrEPoqkUooCy74l1Wowlbod4x8kpE0kHLw5ErGW5
         juJccjN0N4i6365W4cdvRr6EEzyR0lCiPF6+cn5YFZI+9Oaq8O2N45R0RFOZaWqjz7US
         XAag==
X-Gm-Message-State: APjAAAVW5AIl4gLfBa6BrYzYc/z3aKxKhltI3jQBE2j8sdaatgwbOInW
        9OiwVQbveED1p68xTbx07J8xeBwxfv0=
X-Google-Smtp-Source: APXvYqyasNy/YcfzVQmjrVwujWIrn2EFN8+jq+kT0jWf3HBeG55N9gadY6c2bWZD8zQKF0qrUe8QrwSpLEg=
X-Received: by 2002:a17:902:d70a:: with SMTP id w10mr2438682ply.65.1554204502884;
 Tue, 02 Apr 2019 04:28:22 -0700 (PDT)
Date:   Tue,  2 Apr 2019 13:28:13 +0200
Message-Id: <20190402112813.193378-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v2] x86/asm: fix assembly constraints in bitops
From:   Alexander Potapenko <glider@google.com>
To:     paulmck@linux.ibm.com, hpa@zytor.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, dvyukov@google.com,
        jyknight@google.com, x86@kernel.org, mingo@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Use memory clobber in bitops that touch arbitrary memory

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

2. Use byte-sized arguments for operations touching single bytes.

Passing a long value to ANDB/ORB/XORB instructions makes the compiler
treat sizeof(long) bytes as being clobbered, which isn't the case. This
may theoretically lead to worse code in the case of heavy optimization.

Signed-off-by: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: James Y Knight <jyknight@google.com>
---
 v2:
  -- renamed the patch
  -- addressed comment by Peter Zijlstra: don't use "+m" for functions
  returning void
  -- fixed input types for operations touching single bytes
---
 arch/x86/include/asm/bitops.h | 41 +++++++++++++++--------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index d153d570bb04..c0cb9c5d3476 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -36,16 +36,17 @@
  * bit 0 is the LSB of addr; bit 32 is the LSB of (addr+1).
  */
 
-#define BITOP_ADDR(x) "+m" (*(volatile long *) (x))
+#define RLONG_ADDR(x) "m" (*(volatile long *) (x))
+#define WBYTE_ADDR(x) "+m" (*(volatile char *) (x))
 
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
-- 
2.21.0.392.gf8f6787159e-goog

