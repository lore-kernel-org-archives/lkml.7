Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770F7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D6A2133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u3jm7ow2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfDAQYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:24:33 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:37551 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfDAQYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:24:33 -0400
Received: by mail-yw1-f73.google.com with SMTP id x185so7826385ywd.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 09:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Ilqx2Te9+TtxDt5SGoMlUCnXxncrPppgNAYepSlq4eM=;
        b=u3jm7ow2Zb2zv0nFWwJ/gnR+5+h6PY3/IrFUViHGsYA8dqtkiiAEoaADidxSfcM1Gi
         DdKj9VJUPoZL6Tx7iUO2lkzSahqNME4k28GOJp1bZkYJN2gT8U9pdZMAdYwVvdL3HEFv
         ggFIze1u4bBxYYKGM5eCLYFj5YVnkn7rJGF0brC5c2oU0iNFw6Fb0v4kqwY8eVSK0AHx
         81xhh6U+6RMNCfVgIfakaZBeHix8TmoVm60WyzJghaz8qlHq6WwrtQSirdptHrLPs4mR
         s6FhdEQTjPiT3wrTvYt9EmLtu2r/0FZlC4dYEHMCBqMx+AHmBdlSitV1pQdTHjhoQ5Y7
         Y+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Ilqx2Te9+TtxDt5SGoMlUCnXxncrPppgNAYepSlq4eM=;
        b=IVjF/LUdfQQRpYifFjN5hpGtj1tguNpirUlE/8QGWl0yhVqvs5lnG5/4+JCRdvtKo0
         39sjqgYaHNZy8yVCG2BF7cJlZQ1tAeFqgKcUg9vygQeNW7m3IpD32IYKyPaGnwW22xGW
         NjTsQLNZanLXJ/Oyp/drfLRA4A4tyPieLvzQrSAcehVZlgl1ks691aLGwkCliz94IMPE
         hE5r8YG9XmNqiYGvSFQ0QxcwHnkbv83xf76PfISc3VsXUlJpLecCYPbckv/8b+H3+miT
         JiEYb4c9zwMG3qQYPOWTp5Ryacmz4ZWI3fblvX3QLJxfLma431YsAUqgfRwd4NZA/tHs
         Tvww==
X-Gm-Message-State: APjAAAUudGtj+CwunJ3XK3FLP0udtsPlmcK3CcvHUXBlGTBGRuMXgL3o
        ETVQaUP73MUUt3R7Dd8myfEzYBPxZns=
X-Google-Smtp-Source: APXvYqz3bkVxXidiVA6kfDeo5NSd4+OvPfCVdizOvQRvJnHjQOGoMEiXJw1bEOhdDXdcBkAHOXUoUq9nAcA=
X-Received: by 2002:a25:cdca:: with SMTP id d193mr6016339ybf.71.1554135872257;
 Mon, 01 Apr 2019 09:24:32 -0700 (PDT)
Date:   Mon,  1 Apr 2019 18:24:08 +0200
Message-Id: <20190401162408.249668-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH] x86/asm: use memory clobber in bitops that touch arbitrary memory
From:   Alexander Potapenko <glider@google.com>
To:     paulmck@linux.ibm.com, hpa@zytor.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, dvyukov@google.com,
        jyknight@google.com, x86@kernel.org, mingo@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain bit operations that read/write bits take a base pointer and an
arbitrarily large offset to address the bit relative to that base.
Inline assembly constraints aren't expressive enough to tell the
compiler that the assembly directive is going to touch a specific memory
location of unknown size, therefore we have to use the "memory" clobber
to indicate that the assembly is going to access memory locations other
than those listed in the inputs/outputs.

This particular patch leads to size increase of 124 kernel functions in
a defconfig build. For some of them the diff is in NOP operations, other
end up re-reading values from memory and may potentially slow down the
execution. But without these clobbers the compiler is free to cache
the contents of the bitmaps and use them as if they weren't changed by
the inline assembly.

Signed-off-by: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: James Y Knight <jyknight@google.com>
---
 arch/x86/include/asm/bitops.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index d153d570bb04..20e4950827d9 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -111,7 +111,7 @@ clear_bit(long nr, volatile unsigned long *addr)
 	} else {
 		asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
 			: BITOP_ADDR(addr)
-			: "Ir" (nr));
+			: "Ir" (nr) : "memory");
 	}
 }
 
@@ -131,7 +131,7 @@ static __always_inline void clear_bit_unlock(long nr, volatile unsigned long *ad
 
 static __always_inline void __clear_bit(long nr, volatile unsigned long *addr)
 {
-	asm volatile(__ASM_SIZE(btr) " %1,%0" : ADDR : "Ir" (nr));
+	asm volatile(__ASM_SIZE(btr) " %1,%0" : ADDR : "Ir" (nr) : "memory");
 }
 
 static __always_inline bool clear_bit_unlock_is_negative_byte(long nr, volatile unsigned long *addr)
@@ -176,7 +176,7 @@ static __always_inline void __clear_bit_unlock(long nr, volatile unsigned long *
  */
 static __always_inline void __change_bit(long nr, volatile unsigned long *addr)
 {
-	asm volatile(__ASM_SIZE(btc) " %1,%0" : ADDR : "Ir" (nr));
+	asm volatile(__ASM_SIZE(btc) " %1,%0" : ADDR : "Ir" (nr) : "memory");
 }
 
 /**
@@ -197,7 +197,7 @@ static __always_inline void change_bit(long nr, volatile unsigned long *addr)
 	} else {
 		asm volatile(LOCK_PREFIX __ASM_SIZE(btc) " %1,%0"
 			: BITOP_ADDR(addr)
-			: "Ir" (nr));
+			: "Ir" (nr) : "memory");
 	}
 }
 
@@ -243,7 +243,7 @@ static __always_inline bool __test_and_set_bit(long nr, volatile unsigned long *
 	asm(__ASM_SIZE(bts) " %2,%1"
 	    CC_SET(c)
 	    : CC_OUT(c) (oldbit), ADDR
-	    : "Ir" (nr));
+	    : "Ir" (nr) : "memory");
 	return oldbit;
 }
 
@@ -283,7 +283,7 @@ static __always_inline bool __test_and_clear_bit(long nr, volatile unsigned long
 	asm volatile(__ASM_SIZE(btr) " %2,%1"
 		     CC_SET(c)
 		     : CC_OUT(c) (oldbit), ADDR
-		     : "Ir" (nr));
+		     : "Ir" (nr) : "memory");
 	return oldbit;
 }
 
@@ -326,7 +326,7 @@ static __always_inline bool variable_test_bit(long nr, volatile const unsigned l
 	asm volatile(__ASM_SIZE(bt) " %2,%1"
 		     CC_SET(c)
 		     : CC_OUT(c) (oldbit)
-		     : "m" (*(unsigned long *)addr), "Ir" (nr));
+		     : "m" (*(unsigned long *)addr), "Ir" (nr) : "memory");
 
 	return oldbit;
 }
-- 
2.21.0.392.gf8f6787159e-goog

