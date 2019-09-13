Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65488C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 07:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266FF20CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 07:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="I76RqvCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfIMHWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 03:22:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34008 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbfIMHWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 03:22:47 -0400
Received: from zn.tnic (p200300EC2F0DC500B05269A39FD21165.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:c500:b052:69a3:9fd2:1165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A9DD31EC067D;
        Fri, 13 Sep 2019 09:22:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1568359364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=X3Udr9sC/l1Q1hVt9ycu7j7EcAJ1UzWynNihP7CDYOA=;
        b=I76RqvCTx5X0MOXrUnHClXVzNNKPaY+y0s3PrVNCGDsbjB7dOQoxzQdlHL0Pc6O37Vid7E
        WJVA9wQntA/YdGt2o39N5fOEb1x4e3ibVBcHo3ALNqsdo36xPLUPx0J2CNvT33oKxeW09U
        u4be4q84lC4L25h7H073Iq2tyFeAiRg=
Date:   Fri, 13 Sep 2019 09:22:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     x86-ml <x86@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [RFC] Improve memset
Message-ID: <20190913072237.GA12381@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

since the merge window is closing in and y'all are on a conference, I
thought I should take another stab at it. It being something which Ingo,
Linus and Peter have suggested in the past at least once.

Instead of calling memset:

ffffffff8100cd8d:       e8 0e 15 7a 00          callq  ffffffff817ae2a0 <__memset>

and having a JMP inside it depending on the feature supported, let's simply
have the REP; STOSB directly in the code:

...
ffffffff81000442:       4c 89 d7                mov    %r10,%rdi
ffffffff81000445:       b9 00 10 00 00          mov    $0x1000,%ecx

<---- new memset
ffffffff8100044a:       f3 aa                   rep stos %al,%es:(%rdi)
ffffffff8100044c:       90                      nop
ffffffff8100044d:       90                      nop
ffffffff8100044e:       90                      nop
<----

ffffffff8100044f:       4c 8d 84 24 98 00 00    lea    0x98(%rsp),%r8
ffffffff81000456:       00
...

And since the majority of x86 boxes out there is Intel, they haz
X86_FEATURE_ERMS so they won't even need to alternative-patch those call
sites when booting.

In order to patch on machines which don't set X86_FEATURE_ERMS, I need
to do a "reversed" patching of sorts, i.e., patch when the x86 feature
flag is NOT set. See the below changes in alternative.c which basically
add a flags field to struct alt_instr and thus control the patching
behavior in apply_alternatives().

The result is this:

static __always_inline void *memset(void *dest, int c, size_t n)
{
        void *ret, *dummy;

        asm volatile(ALTERNATIVE_2_REVERSE("rep; stosb",
                                           "call memset_rep",  X86_FEATURE_ERMS,
                                           "call memset_orig", X86_FEATURE_REP_GOOD)
                : "=&D" (ret), "=a" (dummy)
                : "0" (dest), "a" (c), "c" (n)
                /* clobbers used by memset_orig() and memset_rep_good() */
                : "rsi", "rdx", "r8", "r9", "memory");

        return dest;
}

and so in the !ERMS case, we patch in a call to the memset_rep() version
which is the old variant in memset_64.S. There we need to do some reg
shuffling because I need to map the registers from where REP; STOSB
expects them to where the x86_64 ABI wants them. Not a big deal - a push
and two moves and a pop at the end.

If X86_FEATURE_REP_GOOD is not set either, we fallback to another call
to the original unrolled memset.

The rest of the diff is me trying to untangle memset()'s definitions
from the early code too because we include kernel proper headers there
and all kinds of crazy include hell ensues but that later.

Anyway, this is just a pre-alpha version to get people's thoughts and
see whether I'm in the right direction or you guys might have better
ideas.

Thx.

---

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/boot/compressed/Makefile             |  1 +
 arch/x86/boot/compressed/eboot.c              |  3 +-
 arch/x86/boot/compressed/misc.h               |  2 +
 arch/x86/boot/compressed/pgtable_64.c         |  2 +-
 arch/x86/boot/string.h                        |  2 +
 arch/x86/entry/vdso/Makefile                  |  2 +-
 arch/x86/include/asm/alternative-asm.h        |  1 +
 arch/x86/include/asm/alternative.h            | 37 ++++++---
 arch/x86/include/asm/cpufeature.h             |  2 +
 arch/x86/include/asm/string_64.h              | 25 +++++-
 arch/x86/kernel/alternative.c                 | 24 ++++--
 arch/x86/lib/memset_64.S                      | 76 ++++++++-----------
 .../firmware/efi/libstub/efi-stub-helper.c    |  1 +
 tools/objtool/special.c                       |  6 +-
 14 files changed, 116 insertions(+), 68 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 6b84afdd7538..d0f465c535f3 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -38,6 +38,7 @@ KBUILD_CFLAGS += $(call cc-option,-fno-stack-protector)
 KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
 KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
 KBUILD_CFLAGS += -Wno-pointer-sign
+KBUILD_CFLAGS += -D_SETUP
 
 KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
 GCOV_PROFILE := n
diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index d6662fdef300..767eb3d0b640 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -6,6 +6,8 @@
  *
  * ----------------------------------------------------------------------- */
 
+#include "../string.h"
+
 #include <linux/efi.h>
 #include <linux/pci.h>
 
@@ -14,7 +16,6 @@
 #include <asm/setup.h>
 #include <asm/desc.h>
 
-#include "../string.h"
 #include "eboot.h"
 
 static efi_system_table_t *sys_table;
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index c8181392f70d..b712c3e7273f 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -16,6 +16,8 @@
 /* cpu_feature_enabled() cannot be used this early */
 #define USE_EARLY_PGTABLE_L5
 
+#include "../string.h"
+
 #include <linux/linkage.h>
 #include <linux/screen_info.h>
 #include <linux/elf.h>
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index c8862696a47b..7ad83d90aaa7 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -1,9 +1,9 @@
+#include "../string.h"
 #include <linux/efi.h>
 #include <asm/e820/types.h>
 #include <asm/processor.h>
 #include <asm/efi.h>
 #include "pgtable.h"
-#include "../string.h"
 
 /*
  * __force_order is used by special_insns.h asm code to force instruction
diff --git a/arch/x86/boot/string.h b/arch/x86/boot/string.h
index 38d8f2f5e47e..cd970beefc5d 100644
--- a/arch/x86/boot/string.h
+++ b/arch/x86/boot/string.h
@@ -2,6 +2,8 @@
 #ifndef BOOT_STRING_H
 #define BOOT_STRING_H
 
+#include <linux/types.h>
+
 /* Undef any of these macros coming from string_32.h. */
 #undef memcpy
 #undef memset
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 8df549138193..3b9d7b2d20d0 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -23,7 +23,7 @@ VDSO32-$(CONFIG_X86_32)		:= y
 VDSO32-$(CONFIG_IA32_EMULATION)	:= y
 
 # files to link into the vdso
-vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o
+vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o ../../lib/memset_64.o
 
 # files to link into kernel
 obj-y				+= vma.o
diff --git a/arch/x86/include/asm/alternative-asm.h b/arch/x86/include/asm/alternative-asm.h
index 464034db299f..78a60c46c472 100644
--- a/arch/x86/include/asm/alternative-asm.h
+++ b/arch/x86/include/asm/alternative-asm.h
@@ -43,6 +43,7 @@
 	.byte \orig_len
 	.byte \alt_len
 	.byte \pad_len
+	.byte 0
 .endm
 
 /*
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 094fbc9c0b1c..2a20604b933d 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -4,6 +4,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/bits.h>
 #include <linux/types.h>
 #include <linux/stddef.h>
 #include <linux/stringify.h>
@@ -55,6 +56,11 @@
 	".long 999b - .\n\t"					\
 	".popsection\n\t"
 
+/*
+ * Patch in reverse order, when the feature bit is *NOT* set.
+ */
+#define ALT_FLAG_REVERSE	BIT(0)
+
 struct alt_instr {
 	s32 instr_offset;	/* original instruction */
 	s32 repl_offset;	/* offset to replacement instruction */
@@ -62,6 +68,7 @@ struct alt_instr {
 	u8  instrlen;		/* length of original instruction */
 	u8  replacementlen;	/* length of new instruction */
 	u8  padlen;		/* length of build-time padding */
+	u8  flags;		/* patching flags */
 } __packed;
 
 /*
@@ -142,13 +149,14 @@ static inline int alternatives_text_reserved(void *start, void *end)
 		" - (" alt_slen ")), 0x90\n"							\
 	alt_end_marker ":\n"
 
-#define ALTINSTR_ENTRY(feature, num)					      \
+#define ALTINSTR_ENTRY(feature, num, flags)				      \
 	" .long 661b - .\n"				/* label           */ \
 	" .long " b_replacement(num)"f - .\n"		/* new instruction */ \
 	" .word " __stringify(feature) "\n"		/* feature bit     */ \
 	" .byte " alt_total_slen "\n"			/* source len      */ \
 	" .byte " alt_rlen(num) "\n"			/* replacement len */ \
-	" .byte " alt_pad_len "\n"			/* pad len */
+	" .byte " alt_pad_len "\n"			/* pad len	   */ \
+	" .byte " __stringify(flags) "\n"		/* flags	   */
 
 #define ALTINSTR_REPLACEMENT(newinstr, feature, num)	/* replacement */	\
 	"# ALT: replacement " #num "\n"						\
@@ -158,29 +166,40 @@ static inline int alternatives_text_reserved(void *start, void *end)
 #define ALTERNATIVE(oldinstr, newinstr, feature)			\
 	OLDINSTR(oldinstr, 1)						\
 	".pushsection .altinstructions,\"a\"\n"				\
-	ALTINSTR_ENTRY(feature, 1)					\
+	ALTINSTR_ENTRY(feature, 1, 0)					\
 	".popsection\n"							\
 	".pushsection .altinstr_replacement, \"ax\"\n"			\
 	ALTINSTR_REPLACEMENT(newinstr, feature, 1)			\
 	".popsection\n"
 
-#define ALTERNATIVE_2(oldinstr, newinstr1, feature1, newinstr2, feature2)\
+#define ALTERNATIVE_2(oldinstr, newinstr1, feature1, newinstr2, feature2) \
 	OLDINSTR_2(oldinstr, 1, 2)					\
 	".pushsection .altinstructions,\"a\"\n"				\
-	ALTINSTR_ENTRY(feature1, 1)					\
-	ALTINSTR_ENTRY(feature2, 2)					\
+	ALTINSTR_ENTRY(feature1, 1, 0)					\
+	ALTINSTR_ENTRY(feature2, 2, 0)					\
 	".popsection\n"							\
 	".pushsection .altinstr_replacement, \"ax\"\n"			\
 	ALTINSTR_REPLACEMENT(newinstr1, feature1, 1)			\
 	ALTINSTR_REPLACEMENT(newinstr2, feature2, 2)			\
 	".popsection\n"
 
+#define ALTERNATIVE_2_REVERSE(def, alt1, ft1, alt2, ft2)		\
+	OLDINSTR_2(def, 1, 2)						\
+	".pushsection .altinstructions,\"a\"\n"				\
+	ALTINSTR_ENTRY(ft1, 1, ALT_FLAG_REVERSE)			\
+	ALTINSTR_ENTRY(ft2, 2, ALT_FLAG_REVERSE)			\
+	".popsection\n"							\
+	".pushsection .altinstr_replacement, \"ax\"\n"			\
+	ALTINSTR_REPLACEMENT(alt1, ft1, 1)				\
+	ALTINSTR_REPLACEMENT(alt2, ft2, 2)				\
+	".popsection\n"
+
 #define ALTERNATIVE_3(oldinsn, newinsn1, feat1, newinsn2, feat2, newinsn3, feat3) \
 	OLDINSTR_3(oldinsn, 1, 2, 3)						\
 	".pushsection .altinstructions,\"a\"\n"					\
-	ALTINSTR_ENTRY(feat1, 1)						\
-	ALTINSTR_ENTRY(feat2, 2)						\
-	ALTINSTR_ENTRY(feat3, 3)						\
+	ALTINSTR_ENTRY(feat1, 1, 0)						\
+	ALTINSTR_ENTRY(feat2, 2, 0)						\
+	ALTINSTR_ENTRY(feat3, 3, 0)						\
 	".popsection\n"								\
 	".pushsection .altinstr_replacement, \"ax\"\n"				\
 	ALTINSTR_REPLACEMENT(newinsn1, feat1, 1)				\
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 59bf91c57aa8..eb936caf6657 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -184,6 +184,7 @@ static __always_inline bool _static_cpu_has(u16 bit)
 		 " .byte 3b - 1b\n"		/* src len */
 		 " .byte 5f - 4f\n"		/* repl len */
 		 " .byte 3b - 2b\n"		/* pad len */
+		 " .byte 0\n"			/* flags */
 		 ".previous\n"
 		 ".section .altinstr_replacement,\"ax\"\n"
 		 "4: jmp %l[t_no]\n"
@@ -196,6 +197,7 @@ static __always_inline bool _static_cpu_has(u16 bit)
 		 " .byte 3b - 1b\n"		/* src len */
 		 " .byte 0\n"			/* repl len */
 		 " .byte 0\n"			/* pad len */
+		 " .byte 0\n"			/* flags */
 		 ".previous\n"
 		 ".section .altinstr_aux,\"ax\"\n"
 		 "6:\n"
diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 75314c3dbe47..a242f5fbca8b 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -5,6 +5,8 @@
 #ifdef __KERNEL__
 #include <linux/jump_label.h>
 
+#include <asm/cpufeatures.h>
+
 /* Written 2002 by Andi Kleen */
 
 /* Even with __builtin_ the compiler may decide to use the out of line
@@ -15,8 +17,27 @@ extern void *memcpy(void *to, const void *from, size_t len);
 extern void *__memcpy(void *to, const void *from, size_t len);
 
 #define __HAVE_ARCH_MEMSET
-void *memset(void *s, int c, size_t n);
-void *__memset(void *s, int c, size_t n);
+extern void *memset_rep(void *s, int c, size_t n);
+extern void *memset_orig(void *s, int c, size_t n);
+
+#ifndef _SETUP
+static __always_inline void *memset(void *dest, int c, size_t n)
+{
+	void *ret, *dummy;
+
+	asm volatile(ALTERNATIVE_2_REVERSE("rep; stosb",
+					   "call memset_rep",  X86_FEATURE_ERMS,
+					   "call memset_orig", X86_FEATURE_REP_GOOD)
+		: "=&D" (ret), "=a" (dummy)
+		: "0" (dest), "a" (c), "c" (n)
+		/* clobbers used by memset_orig() and memset_rep_good() */
+		: "rsi", "rdx", "r8", "r9", "memory");
+
+	return dest;
+}
+
+#define __memset(s, c, n) memset(s, c, n)
+#endif
 
 #define __HAVE_ARCH_MEMSET16
 static inline void *memset16(uint16_t *s, uint16_t v, size_t n)
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 9d3a971ea364..9fca4fbecd4f 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -390,18 +390,32 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		replacement = (u8 *)&a->repl_offset + a->repl_offset;
 		BUG_ON(a->instrlen > sizeof(insn_buff));
 		BUG_ON(a->cpuid >= (NCAPINTS + NBUGINTS) * 32);
+
+		/*
+		 * Patch only if the feature flag is present or if reverse
+		 * patching is requested, i.e., patch if feature bit is *not*
+		 * present.
+		 */
 		if (!boot_cpu_has(a->cpuid)) {
-			if (a->padlen > 1)
-				optimize_nops(a, instr);
+			if (!(a->flags & ALT_FLAG_REVERSE)) {
+				if (a->padlen > 1)
+					optimize_nops(a, instr);
 
-			continue;
+				continue;
+			}
 		}
 
-		DPRINTK("feat: %d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d), pad: %d",
+		/*
+		 * ... or skip if feature bit is present but reverse is set:
+		 */
+		if (boot_cpu_has(a->cpuid) && (a->flags & ALT_FLAG_REVERSE))
+			continue;
+
+		DPRINTK("feat: %d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d), pad: %d, flags: 0x%x",
 			a->cpuid >> 5,
 			a->cpuid & 0x1f,
 			instr, instr, a->instrlen,
-			replacement, a->replacementlen, a->padlen);
+			replacement, a->replacementlen, a->padlen, a->flags);
 
 		DUMP_BYTES(instr, a->instrlen, "%px: old_insn: ", instr);
 		DUMP_BYTES(replacement, a->replacementlen, "%px: rpl_insn: ", replacement);
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index 9bc861c71e75..f1b459bb310c 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -6,32 +6,27 @@
 #include <asm/alternative-asm.h>
 #include <asm/export.h>
 
-.weak memset
-
 /*
  * ISO C memset - set a memory block to a byte value. This function uses fast
  * string to get better performance than the original function. The code is
  * simpler and shorter than the original function as well.
  *
  * rdi   destination
- * rsi   value (char)
- * rdx   count (bytes)
+ * rax   value (char)
+ * rcx   count (bytes)
  *
  * rax   original destination
  */
-ENTRY(memset)
-ENTRY(__memset)
-	/*
-	 * Some CPUs support enhanced REP MOVSB/STOSB feature. It is recommended
-	 * to use it when possible. If not available, use fast string instructions.
-	 *
-	 * Otherwise, use original memset function.
-	 */
-	ALTERNATIVE_2 "jmp memset_orig", "", X86_FEATURE_REP_GOOD, \
-		      "jmp memset_erms", X86_FEATURE_ERMS
-
-	movq %rdi,%r9
-	movq %rdx,%rcx
+ENTRY(memset_rep)
+	/* stash retval */
+	push %rdi
+
+	/* value to memset with is in %rax */
+	mov %rax, %rsi
+
+	/* count is in %rcx, stash it */
+	movq %rcx, %rdx
+
 	andl $7,%edx
 	shrq $3,%rcx
 	/* expand byte value  */
@@ -41,35 +36,22 @@ ENTRY(__memset)
 	rep stosq
 	movl %edx,%ecx
 	rep stosb
-	movq %r9,%rax
-	ret
-ENDPROC(memset)
-ENDPROC(__memset)
-EXPORT_SYMBOL(memset)
-EXPORT_SYMBOL(__memset)
 
-/*
- * ISO C memset - set a memory block to a byte value. This function uses
- * enhanced rep stosb to override the fast string function.
- * The code is simpler and shorter than the fast string function as well.
- *
- * rdi   destination
- * rsi   value (char)
- * rdx   count (bytes)
- *
- * rax   original destination
- */
-ENTRY(memset_erms)
-	movq %rdi,%r9
-	movb %sil,%al
-	movq %rdx,%rcx
-	rep stosb
-	movq %r9,%rax
+	/* restore retval */
+	pop %rax
 	ret
-ENDPROC(memset_erms)
+ENDPROC(memset_rep)
+EXPORT_SYMBOL(memset_rep)
 
 ENTRY(memset_orig)
-	movq %rdi,%r10
+	/* stash retval */
+	push %rdi
+
+	/* value to memset with is in %rax */
+	mov %rax, %rsi
+
+	/* count is in %rcx, stash it */
+	mov %rcx, %rdx
 
 	/* expand byte value  */
 	movzbl %sil,%ecx
@@ -105,8 +87,8 @@ ENTRY(memset_orig)
 	.p2align 4
 .Lhandle_tail:
 	movl	%edx,%ecx
-	andl    $63&(~7),%ecx
-	jz 		.Lhandle_7
+	andl    $63 & (~7),%ecx
+	jz	.Lhandle_7
 	shrl	$3,%ecx
 	.p2align 4
 .Lloop_8:
@@ -121,12 +103,13 @@ ENTRY(memset_orig)
 	.p2align 4
 .Lloop_1:
 	decl    %edx
-	movb 	%al,(%rdi)
+	movb	%al,(%rdi)
 	leaq	1(%rdi),%rdi
 	jnz     .Lloop_1
 
 .Lende:
-	movq	%r10,%rax
+	/* restore retval */
+	pop %rax
 	ret
 
 .Lbad_alignment:
@@ -140,3 +123,4 @@ ENTRY(memset_orig)
 	jmp .Lafter_bad_alignment
 .Lfinal:
 ENDPROC(memset_orig)
+EXPORT_SYMBOL(memset_orig)
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 3caae7f2cf56..a3fc93e68d5b 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -9,6 +9,7 @@
 
 #include <linux/efi.h>
 #include <asm/efi.h>
+#include <asm/string.h>
 
 #include "efistub.h"
 
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index fdbaa611146d..95f423827fbd 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -23,7 +23,7 @@
 #define JUMP_ORIG_OFFSET	0
 #define JUMP_NEW_OFFSET		4
 
-#define ALT_ENTRY_SIZE		13
+#define ALT_ENTRY_SIZE		14
 #define ALT_ORIG_OFFSET		0
 #define ALT_NEW_OFFSET		4
 #define ALT_FEATURE_OFFSET	8
@@ -172,8 +172,8 @@ int special_get_alts(struct elf *elf, struct list_head *alts)
 			continue;
 
 		if (sec->len % entry->size != 0) {
-			WARN("%s size not a multiple of %d",
-			     sec->name, entry->size);
+			WARN("%s, size %d not a multiple of %d",
+			     sec->name, sec->len, entry->size);
 			return -1;
 		}
 
-- 
2.21.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
