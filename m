Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0A6C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 614302171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555074649;
	bh=9TYnNOkKN7PclYqzIvTgdBQJt2JY7yg9K+3L9vIW/0E=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=tdTNEkWb4/W5m14LpC/lpNDJ7x/NZXWE1yj4QVfRlL6iuTj+8HWRNC+ejZ2G0t9j2
	 owao5mMpABa1I4QlS0aPj+QNDbofzVdgLPPG4bGdZnQvcYOo4bn/5GHwn1zS/XVKK4
	 xqTlJ3ThI49/D+T6kNXnvhRx6scvTFYmDG6EmZdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfDLNKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:10:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44307 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfDLNKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:10:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id y7so11853741wrn.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 06:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Pp2wCUtfhGtn1pGb5cuDWo7L+B1L/GDnvM/SuwdnAjE=;
        b=DkmNeXYimlWU7fHG/+/674XhqOfIAQgCzrGNbt6aPTrYB93ff+GlRdbAN0Lrr2KS49
         YfR/rHYRRUoWVqwG2EUBR8QjBCAtSWR2Dw7UHGHHvWqsR+xIG3jI8RY2t37uFX+OTwq9
         S2hNb/XpqmyFDfMnzcYRhbsHtsUjByx/+W5LrRT8PX1Ng0HjdZ7KjDCeXjsBpS4owgVz
         wBAuJYmw93OtIkLiEk/qvZZYugv8bYRtd6GYjRLbqGmlhe0qN3owcPHOk5S5gH6/UwBE
         X5o43mfk94puN7Vo8CGHsqE4yCwod/WlOoUedqdT6eNKQeW79xYjxIzdvLRJwF4pczB3
         851g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=Pp2wCUtfhGtn1pGb5cuDWo7L+B1L/GDnvM/SuwdnAjE=;
        b=AZnK7toP+lc2EynyRD77cNVS3cA1AsBG1WbJC/rhFtgQTyhIdOMXjty56KdMKL8Z9D
         yxtJnqIw3y/6K/HWeRQkLd6tr7n4qArT+F/yl4Z8bR7JATfsdhu+LbdbzCk2HTwZ0QnY
         WFLbkbaBSTzDzg4KL6P8yDMmqudmbpeth6s6t9Q3iW7opwM7TGPHOBNfGHo+vMU95bGR
         SxCdE/2WrpE+mfbRD1BBBBndi9QYoatkW0lZYSrn4j+MLWaesYOd+QSTyhccpYW3qJzP
         vHymWf4U2SC+JysBn9Du4asVERcuyQpiLH/5fxAvnjGdts2GOpJWPgklEj1PR72aOeEz
         4ZLA==
X-Gm-Message-State: APjAAAVuvISJwVGRXbCP5JC/sKSHJzhBKjxcnw9rp/aDAI5HPu2MQR7S
        1L07A5L+ih9uKlE8cfs3NGk=
X-Google-Smtp-Source: APXvYqw2X6UhcbVoQ1t51P7QRmz7Sb0JTwdGtJn3iYR+zPch2/d9XQF3Lxpvlk3BGt/Bwr8XpWnYdQ==
X-Received: by 2002:adf:f68d:: with SMTP id v13mr34956936wrp.6.1555074644897;
        Fri, 12 Apr 2019 06:10:44 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v184sm15681233wma.6.2019.04.12.06.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 06:10:44 -0700 (PDT)
Date:   Fri, 12 Apr 2019 15:10:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fixes
Message-ID: <20190412131042.GA52595@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: 5b77e95dd7790ff6c8fbf1cd8d0104ebed818a03 x86/asm: Use stricter assembly constraints in bitops

Fix typos in user-visible resctrl parameters, and also fix assembly 
constraint bugs that might result in miscompilation.

 Thanks,

	Ingo

------------------>
Alexander Potapenko (1):
      x86/asm: Use stricter assembly constraints in bitops

Xiaochen Shen (1):
      x86/resctrl: Fix typos in the mba_sc mount option


 arch/x86/include/asm/bitops.h          | 41 +++++++++++++++-------------------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  6 ++---
 2 files changed, 21 insertions(+), 26 deletions(-)

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
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 399601eda8e4..54b9eef3eea9 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2039,14 +2039,14 @@ static int rdt_get_tree(struct fs_context *fc)
 enum rdt_param {
 	Opt_cdp,
 	Opt_cdpl2,
-	Opt_mba_mpbs,
+	Opt_mba_mbps,
 	nr__rdt_params
 };
 
 static const struct fs_parameter_spec rdt_param_specs[] = {
 	fsparam_flag("cdp",		Opt_cdp),
 	fsparam_flag("cdpl2",		Opt_cdpl2),
-	fsparam_flag("mba_mpbs",	Opt_mba_mpbs),
+	fsparam_flag("mba_MBps",	Opt_mba_mbps),
 	{}
 };
 
@@ -2072,7 +2072,7 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_cdpl2:
 		ctx->enable_cdpl2 = true;
 		return 0;
-	case Opt_mba_mpbs:
+	case Opt_mba_mbps:
 		if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 			return -EINVAL;
 		ctx->enable_mba_mbps = true;
