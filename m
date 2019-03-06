Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF419C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CF620661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iaP2C3LD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfCFNOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 08:14:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41270 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbfCFNN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 08:13:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fb1EgBA4VJ90/W8naKhWowLwPdlXsolvIuUw/+KUcq4=; b=iaP2C3LDBGlXZoRhKQb4/qSGn
        f0wUP/jOH8xu3ywQ5/nZIvaccXEQyze4CJ5rQY9jaRQbc+jSyOm5jdIyI1U0PitkeC2Uh7tiTR4qT
        AYprlDqYR29LjNAFuh+BvVQeyugA5Sg6sea44Yv9ZN0WhgjryEc/St9h4k4ot21P8s9j4crF2bf8U
        ajO+ydjJ1fSeHipQfFos4iTmtGZ+fnF32IqykBc74vJtGplXoPm56yrukXEB7nAq0bd7RbJjlFXTm
        ClMBqvLruzAFaHAmaaTdj/CzRlKWCtFH0UrYGnadpTVZkJTkkFySiYCtbO+nwNVVzQtkOz3bjEG2G
        Msp2miG4Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1WMm-0008Rf-Ml; Wed, 06 Mar 2019 13:13:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1019A20288BA6; Wed,  6 Mar 2019 14:13:47 +0100 (CET)
Date:   Wed, 6 Mar 2019 14:13:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH 1/8] kasan,x86: Frob kasan_report() in an exception
Message-ID: <20190306131347.GX32534@hirez.programming.kicks-ass.net>
References: <20190228145450.289603901@infradead.org>
 <20190228150152.078767622@infradead.org>
 <CACT4Y+b0WyE5En7BVipZiCMmMaj30kaEu3T68H7+-kVP8gqADA@mail.gmail.com>
 <20190301144556.GY32477@hirez.programming.kicks-ass.net>
 <CACT4Y+ZyXAJiKtzoWxY-u7e9HaL7iM9tnFXnFZd7Hdy4uHEOyA@mail.gmail.com>
 <20190301152305.GJ32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301152305.GJ32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 04:23:05PM +0100, Peter Zijlstra wrote:

> But yes, I'll try some annotation, see what that looks like.

OK; that took a lot of time.. and a number of objtool bugs fixed but I
think I have something that I don't hate -- although it is not as solid
as I'd like it to be.


unmodified:

0000 0000000000000150 <__asan_load1>:
0000  150:      48 b8 ff ff ff ff ff    movabs $0xffff7fffffffffff,%rax
0007  157:      7f ff ff
000a  15a:      48 8b 0c 24             mov    (%rsp),%rcx
000e  15e:      48 39 c7                cmp    %rax,%rdi
0011  161:      76 23                   jbe    186 <__asan_load1+0x36>
0013  163:      48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
001a  16a:      fc ff df
001d  16d:      48 89 fa                mov    %rdi,%rdx
0020  170:      48 c1 ea 03             shr    $0x3,%rdx
0024  174:      0f b6 04 02             movzbl (%rdx,%rax,1),%eax
0028  178:      84 c0                   test   %al,%al
002a  17a:      75 01                   jne    17d <__asan_load1+0x2d>
002c  17c:      c3                      retq
002d  17d:      89 fa                   mov    %edi,%edx
002f  17f:      83 e2 07                and    $0x7,%edx
0032  182:      38 d0                   cmp    %dl,%al
0034  184:      7f f6                   jg     17c <__asan_load1+0x2c>
0036  186:      31 d2                   xor    %edx,%edx
0038  188:      be 01 00 00 00          mov    $0x1,%esi
003d  18d:      e9 00 00 00 00          jmpq   192 <__asan_load1+0x42>
003e                    18e: R_X86_64_PLT32     kasan_report-0x4

exception:

0000 0000000000000150 <__asan_load1>:
0000  150:      48 b8 ff ff ff ff ff    movabs $0xffff7fffffffffff,%rax
0007  157:      7f ff ff
000a  15a:      48 8b 0c 24             mov    (%rsp),%rcx
000e  15e:      48 39 c7                cmp    %rax,%rdi
0011  161:      76 23                   jbe    186 <__asan_load1+0x36>
0013  163:      48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
001a  16a:      fc ff df
001d  16d:      48 89 fa                mov    %rdi,%rdx
0020  170:      48 c1 ea 03             shr    $0x3,%rdx
0024  174:      0f b6 04 02             movzbl (%rdx,%rax,1),%eax
0028  178:      84 c0                   test   %al,%al
002a  17a:      75 01                   jne    17d <__asan_load1+0x2d>
002c  17c:      c3                      retq
002d  17d:      89 fa                   mov    %edi,%edx
002f  17f:      83 e2 07                and    $0x7,%edx
0032  182:      38 d0                   cmp    %dl,%al
0034  184:      7f f6                   jg     17c <__asan_load1+0x2c>
0036  186:      65 48 8b 04 25 00 00    mov    %gs:0x0,%rax
003d  18d:      00 00
003b                    18b: R_X86_64_32S       current_task
003f  18f:      8b 80 68 08 00 00       mov    0x868(%rax),%eax
0045  195:      85 c0                   test   %eax,%eax
0047  197:      75 e3                   jne    17c <__asan_load1+0x2c>
0049  199:      be 01 00 00 00          mov    $0x1,%esi
004e  19e:      31 d2                   xor    %edx,%edx
0050  1a0:      0f 0b                   ud2
0052  1a2:      c3                      retq

annotated:

0000 0000000000000150 <__asan_load1>:
0000  150:      48 b8 ff ff ff ff ff    movabs $0xffff7fffffffffff,%rax
0007  157:      7f ff ff
000a  15a:      53                      push   %rbx
000b  15b:      48 8b 4c 24 08          mov    0x8(%rsp),%rcx
0010  160:      48 39 c7                cmp    %rax,%rdi
0013  163:      76 24                   jbe    189 <__asan_load1+0x39>
0015  165:      48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
001c  16c:      fc ff df
001f  16f:      48 89 fa                mov    %rdi,%rdx
0022  172:      48 c1 ea 03             shr    $0x3,%rdx
0026  176:      0f b6 04 02             movzbl (%rdx,%rax,1),%eax
002a  17a:      84 c0                   test   %al,%al
002c  17c:      75 02                   jne    180 <__asan_load1+0x30>
002e  17e:      5b                      pop    %rbx
002f  17f:      c3                      retq
0030  180:      89 fa                   mov    %edi,%edx
0032  182:      83 e2 07                and    $0x7,%edx
0035  185:      38 d0                   cmp    %dl,%al
0037  187:      7f f5                   jg     17e <__asan_load1+0x2e>
0039  189:      9c                      pushfq
003a  18a:      5b                      pop    %rbx
003b  18b:      90                      nop
003c  18c:      90                      nop
003d  18d:      90                      nop
003e  18e:      31 d2                   xor    %edx,%edx
0040  190:      be 01 00 00 00          mov    $0x1,%esi
0045  195:      e8 00 00 00 00          callq  19a <__asan_load1+0x4a>
0046                    196: R_X86_64_PLT32     __kasan_report-0x4
004a  19a:      53                      push   %rbx
004b  19b:      9d                      popfq
004c  19c:      5b                      pop    %rbx
004d  19d:      c3                      retq


---
--- a/arch/x86/include/asm/kasan.h
+++ b/arch/x86/include/asm/kasan.h
@@ -28,6 +28,23 @@
 #ifdef CONFIG_KASAN
 void __init kasan_early_init(void);
 void __init kasan_init(void);
+
+#include <asm/smap.h>
+
+extern void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip);
+
+static __always_inline
+void kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip)
+{
+	unsigned long flags;
+
+	flags = smap_save();
+	__kasan_report(addr, size, is_write, ip);
+	smap_restore(flags);
+
+}
+#define kasan_report kasan_report
+
 #else
 static inline void kasan_early_init(void) { }
 static inline void kasan_init(void) { }
--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -46,6 +46,8 @@
 
 #ifdef CONFIG_X86_SMAP
 
+#include <asm/irqflags.h>
+
 static __always_inline void clac(void)
 {
 	/* Note: a barrier is implicit in alternative() */
@@ -58,6 +60,18 @@ static __always_inline void stac(void)
 	alternative("", __stringify(__ASM_STAC), X86_FEATURE_SMAP);
 }
 
+static __always_inline unsigned long smap_save(void)
+{
+	unsigned long flags = arch_local_save_flags();
+	clac();
+	return flags;
+}
+
+static __always_inline void smap_restore(unsigned long flags)
+{
+	arch_local_irq_restore(flags);
+}
+
 /* These macros can be used in asm() statements */
 #define ASM_CLAC \
 	ALTERNATIVE("", __stringify(__ASM_CLAC), X86_FEATURE_SMAP)
@@ -69,6 +83,9 @@ static __always_inline void stac(void)
 static inline void clac(void) { }
 static inline void stac(void) { }
 
+static inline unsigned long smap_save(void) { return 0; }
+static inline void smap_restore(unsigned long flags) { }
+
 #define ASM_CLAC
 #define ASM_STAC
 
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -83,6 +83,8 @@ size_t kasan_metadata_size(struct kmem_c
 bool kasan_save_enable_multi_shot(void);
 void kasan_restore_multi_shot(bool enabled);
 
+void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip);
+
 #else /* CONFIG_KASAN */
 
 static inline void kasan_unpoison_shadow(const void *address, size_t size) {}
@@ -153,8 +155,14 @@ static inline void kasan_remove_zero_sha
 static inline void kasan_unpoison_slab(const void *ptr) { }
 static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
 
+static inline void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip) { }
+
 #endif /* CONFIG_KASAN */
 
+#ifndef kasan_report
+#define kasan_report(addr, size, is_write, ip) __kasan_report(addr, size, is_write, ip)
+#endif
+
 #ifdef CONFIG_KASAN_GENERIC
 
 #define KASAN_SHADOW_INIT 0
@@ -177,9 +185,6 @@ void kasan_init_tags(void);
 
 void *kasan_reset_tag(const void *addr);
 
-void kasan_report(unsigned long addr, size_t size,
-		bool is_write, unsigned long ip);
-
 #else /* CONFIG_KASAN_SW_TAGS */
 
 static inline void kasan_init_tags(void) { }
--- a/mm/kasan/generic_report.c
+++ b/mm/kasan/generic_report.c
@@ -118,14 +118,14 @@ const char *get_bug_type(struct kasan_ac
 #define DEFINE_ASAN_REPORT_LOAD(size)                     \
 void __asan_report_load##size##_noabort(unsigned long addr) \
 {                                                         \
-	kasan_report(addr, size, false, _RET_IP_);	  \
+	__kasan_report(addr, size, false, _RET_IP_);	  \
 }                                                         \
 EXPORT_SYMBOL(__asan_report_load##size##_noabort)
 
 #define DEFINE_ASAN_REPORT_STORE(size)                     \
 void __asan_report_store##size##_noabort(unsigned long addr) \
 {                                                          \
-	kasan_report(addr, size, true, _RET_IP_);	   \
+	__kasan_report(addr, size, true, _RET_IP_);	   \
 }                                                          \
 EXPORT_SYMBOL(__asan_report_store##size##_noabort)
 
@@ -142,12 +142,12 @@ DEFINE_ASAN_REPORT_STORE(16);
 
 void __asan_report_load_n_noabort(unsigned long addr, size_t size)
 {
-	kasan_report(addr, size, false, _RET_IP_);
+	__kasan_report(addr, size, false, _RET_IP_);
 }
 EXPORT_SYMBOL(__asan_report_load_n_noabort);
 
 void __asan_report_store_n_noabort(unsigned long addr, size_t size)
 {
-	kasan_report(addr, size, true, _RET_IP_);
+	__kasan_report(addr, size, true, _RET_IP_);
 }
 EXPORT_SYMBOL(__asan_report_store_n_noabort);
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -130,8 +130,6 @@ void check_memory_region(unsigned long a
 void *find_first_bad_addr(void *addr, size_t size);
 const char *get_bug_type(struct kasan_access_info *info);
 
-void kasan_report(unsigned long addr, size_t size,
-		bool is_write, unsigned long ip);
 void kasan_report_invalid_free(void *object, unsigned long ip);
 
 #if defined(CONFIG_KASAN_GENERIC) && \
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -281,7 +281,7 @@ void kasan_report_invalid_free(void *obj
 	end_report(&flags);
 }
 
-void kasan_report(unsigned long addr, size_t size,
+void __kasan_report(unsigned long addr, size_t size,
 		bool is_write, unsigned long ip)
 {
 	struct kasan_access_info info;
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -43,6 +43,7 @@ enum op_dest_type {
 	OP_DEST_REG_INDIRECT,
 	OP_DEST_MEM,
 	OP_DEST_PUSH,
+	OP_DEST_PUSHF,
 	OP_DEST_LEAVE,
 };
 
@@ -57,6 +58,7 @@ enum op_src_type {
 	OP_SRC_REG_INDIRECT,
 	OP_SRC_CONST,
 	OP_SRC_POP,
+	OP_SRC_POPF,
 	OP_SRC_ADD,
 	OP_SRC_AND,
 };
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -357,13 +357,13 @@ int arch_decode_instruction(struct elf *
 		/* pushf */
 		*type = INSN_STACK;
 		op->src.type = OP_SRC_CONST;
-		op->dest.type = OP_DEST_PUSH;
+		op->dest.type = OP_DEST_PUSHF;
 		break;
 
 	case 0x9d:
 		/* popf */
 		*type = INSN_STACK;
-		op->src.type = OP_SRC_POP;
+		op->src.type = OP_SRC_POPF;
 		op->dest.type = OP_DEST_MEM;
 		break;
 
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1359,11 +1359,11 @@ static int update_insn_state_regs(struct
 		return 0;
 
 	/* push */
-	if (op->dest.type == OP_DEST_PUSH)
+	if (op->dest.type == OP_DEST_PUSH || op->dest.type == OP_DEST_PUSHF)
 		cfa->offset += 8;
 
 	/* pop */
-	if (op->src.type == OP_SRC_POP)
+	if (op->src.type == OP_SRC_POP || op->src.type == OP_SRC_POPF)
 		cfa->offset -= 8;
 
 	/* add immediate to sp */
@@ -1620,6 +1620,7 @@ static int update_insn_state(struct inst
 			break;
 
 		case OP_SRC_POP:
+		case OP_SRC_POPF:
 			if (!state->drap && op->dest.type == OP_DEST_REG &&
 			    op->dest.reg == cfa->base) {
 
@@ -1684,6 +1685,7 @@ static int update_insn_state(struct inst
 		break;
 
 	case OP_DEST_PUSH:
+	case OP_DEST_PUSHF:
 		state->stack_size += 8;
 		if (cfa->base == CFI_SP)
 			cfa->offset += 8;
@@ -1774,7 +1776,7 @@ static int update_insn_state(struct inst
 		break;
 
 	case OP_DEST_MEM:
-		if (op->src.type != OP_SRC_POP) {
+		if (op->src.type != OP_SRC_POP && op->src.type != OP_SRC_POPF) {
 			WARN_FUNC("unknown stack-related memory operation",
 				  insn->sec, insn->offset);
 			return -1;
@@ -2071,6 +2073,16 @@ static int validate_branch(struct objtoo
 			if (update_insn_state(insn, &state))
 				return 1;
 
+			if (insn->stack_op.dest.type == OP_DEST_PUSHF) {
+				if (state.uaccess)
+					state.uaccess_stack++;
+			}
+
+			if (insn->stack_op.src.type == OP_SRC_POPF) {
+				if (state.uaccess_stack && !--state.uaccess_stack)
+					state.uaccess = func_uaccess_safe(func);
+			}
+
 			break;
 
 		case INSN_STAC:
@@ -2088,7 +2100,7 @@ static int validate_branch(struct objtoo
 				return 1;
 			}
 
-			if (func_uaccess_safe(func)) {
+			if (func_uaccess_safe(func) && !state.uaccess_stack) {
 				WARN_FUNC("UACCESS-safe disables UACCESS", sec, insn->offset);
 				return 1;
 			}
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -32,6 +32,7 @@ struct insn_state {
 	unsigned char type;
 	bool bp_scratch;
 	bool drap, end, uaccess;
+	int uaccess_stack;
 	int drap_reg, drap_offset;
 	struct cfi_reg vals[CFI_NUM_REGS];
 };
