Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AED0C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D31206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mA1m/GpZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfFDXpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 19:45:18 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42103 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfFDXpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:45:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so3452526pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 16:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pAF1nhNaQqoPMpolwvg/JAe82jlicWnSiM9EjTEOxhk=;
        b=mA1m/GpZgtjcwGSNOBusHF5wHHicaIKMOVEHEXFoF8B9u/4lWJAgYuP/IwAbVWSu3V
         DaYSwZ3qRGkh1U7OObYLBrumTo3h/r9zw9BRI9sqpGFNjAzoP5MtLpjaimcpxasjj6D5
         Ery+qoDBjy1joIuQXZizdAsfRPD6wknB6vofA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pAF1nhNaQqoPMpolwvg/JAe82jlicWnSiM9EjTEOxhk=;
        b=HYbOr/gtEOi/RV8qYGh756B1XmborbZGxgpExD6gxqim2Bct4Dzln6vGd0R3Bgzbt2
         7KCsBi1WI6L6yfDoc/QDOu8DgOpJfwGkJlHBZKkTPMp/BOjKDGk17eyR/nAj+EDjiYzR
         U2TF8QrjeBySb/8DnaEpRiiayfQAY8PeOZMfbaU+1ak5qZPr/xYA64XqnBmROeZoPxv4
         ZGwuCZPL7dbh70T5Z6PSiJ9vBtLPvAC39Utz02WYv03WCH7714YTE+OE3dYZj7RzQ+Yf
         MZqyPUFARTYnIJePVv9wqVhs5KBvb00K8VbB+4k5auDEl+PA2QuUAIHEkr7ZZpiL2hH7
         xGVA==
X-Gm-Message-State: APjAAAULFcdpwV14Zjjp1VoZh0K4RsCZoR0VdomXUjrdXVip0SQF4nac
        +igeT231A1vR9ZsGy147TffmqA==
X-Google-Smtp-Source: APXvYqyy8BjS3jkFSzyi0YnYFT+9xtTMnJnZPNpT1rSvJwtESYV7i7sFDghQ1lJnVId+MZp8WYM/GQ==
X-Received: by 2002:a65:52c9:: with SMTP id z9mr415642pgp.177.1559691914149;
        Tue, 04 Jun 2019 16:45:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e20sm17710905pfi.35.2019.06.04.16.45.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 16:45:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] x86/asm: Pin sensitive CR4 bits
Date:   Tue,  4 Jun 2019 16:44:21 -0700
Message-Id: <20190604234422.29391-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604234422.29391-1-keescook@chromium.org>
References: <20190604234422.29391-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several recent exploits have used direct calls to the native_write_cr4()
function to disable SMEP and SMAP before then continuing their exploits
using userspace memory access. This pins bits of CR4 so that they cannot
be changed through a common function. This is not intended to be general
ROP protection (which would require CFI to defend against properly), but
rather a way to avoid trivial direct function calling (or CFI bypasses
via a matching function prototype) as seen in:

https://googleprojectzero.blogspot.com/2017/05/exploiting-linux-kernel-via-packet.html
(https://github.com/xairy/kernel-exploits/tree/master/CVE-2017-7308)

The goals of this change:
 - pin specific bits (SMEP, SMAP, and UMIP) when writing CR4.
 - avoid setting the bits too early (they must become pinned only after
   CPU feature detection and selection has finished).
 - pinning mask needs to be read-only during normal runtime.
 - pinning needs to be checked after write to avoid jumps past the
   preceding "or".

Using __ro_after_init on the mask is done so it can't be first disabled
with a malicious write.

Since these bits are global state (once established by the boot CPU
and kernel boot parameters), they are safe to write to secondary CPUs
before those CPUs have finished feature detection. As such, the bits are
written with an "or" performed before the register write as that is both
easier and uses a few bytes less storage of a location we don't have:
read-only per-CPU data. (Note that initialization via cr4_init_shadow()
isn't early enough to avoid early native_write_cr4() calls.)

A check is performed after the register write because an attack could
just skip over the "or" before the register write. Such a direct jump
is possible because of how this function may be built by the compiler
(especially due to the removal of frame pointers) where it doesn't add
a stack frame (function exit may only be a retq without pops) which
is sufficient for trivial exploitation like in the timer overwrites
mentioned above).

The asm argument constraints gain the "+" modifier to convince the
compiler that it shouldn't make ordering assumptions about the arguments
or memory, and treat them as changed.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2:
- move setup until after CPU feature detection and selection.
- refactor to use static branches to have atomic enabling.
- only perform the "or" after a failed check.
---
 arch/x86/include/asm/special_insns.h | 24 +++++++++++++++++++++++-
 arch/x86/kernel/cpu/common.c         | 18 ++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 0a3c4cab39db..284a77d52fea 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -6,6 +6,8 @@
 #ifdef __KERNEL__
 
 #include <asm/nops.h>
+#include <asm/processor-flags.h>
+#include <linux/jump_label.h>
 
 /*
  * Volatile isn't enough to prevent the compiler from reordering the
@@ -16,6 +18,10 @@
  */
 extern unsigned long __force_order;
 
+/* Starts false and gets enabled once CPU feature detection is done. */
+DECLARE_STATIC_KEY_FALSE(cr_pinning);
+extern unsigned long cr4_pinned_bits;
+
 static inline unsigned long native_read_cr0(void)
 {
 	unsigned long val;
@@ -74,7 +80,23 @@ static inline unsigned long native_read_cr4(void)
 
 static inline void native_write_cr4(unsigned long val)
 {
-	asm volatile("mov %0,%%cr4": : "r" (val), "m" (__force_order));
+	unsigned long bits_missing = 0;
+
+set_register:
+	if (static_branch_likely(&cr_pinning))
+		val |= cr4_pinned_bits;
+
+	asm volatile("mov %0,%%cr4": "+r" (val), "+m" (cr4_pinned_bits));
+
+	if (static_branch_likely(&cr_pinning)) {
+		if (unlikely((val & cr4_pinned_bits) != cr4_pinned_bits)) {
+			bits_missing = ~val & cr4_pinned_bits;
+			goto set_register;
+		}
+		/* Warn after we've set the missing bits. */
+		WARN_ONCE(bits_missing, "CR4 bits went missing: %lx!?\n",
+			  bits_missing);
+	}
 }
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 2c57fffebf9b..6b210be12734 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -366,6 +366,23 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
 	cr4_clear_bits(X86_CR4_UMIP);
 }
 
+DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
+unsigned long cr4_pinned_bits __ro_after_init;
+
+/*
+ * Once CPU feature detection is finished (and boot params have been
+ * parsed), record any of the sensitive CR bits that are set, and
+ * enable CR pinning.
+ */
+static void __init setup_cr_pinning(void)
+{
+	unsigned long mask;
+
+	mask = (X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP);
+	cr4_pinned_bits = this_cpu_read(cpu_tlbstate.cr4) & mask;
+	static_key_enable(&cr_pinning.key);
+}
+
 /*
  * Protection Keys are not available in 32-bit mode.
  */
@@ -1464,6 +1481,7 @@ void __init identify_boot_cpu(void)
 	enable_sep_cpu();
 #endif
 	cpu_detect_tlb(&boot_cpu_data);
+	setup_cr_pinning();
 }
 
 void identify_secondary_cpu(struct cpuinfo_x86 *c)
-- 
2.17.1

