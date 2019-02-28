Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E33C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F71218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ecpd1AEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732130AbfB1PF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:05:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44076 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731828AbfB1PFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:05:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AFxhbfbU9cLd/YLwM1CyU+maLuCgrVIJLF8gos6CTp8=; b=ecpd1AENyDIAjaqATkl/SHDBCr
        q9QGSAMXay3R8NE9Vy9fvqDEyJ3YDXbKdUOxCXaNZRHgZ/rBTZRN4Ogctn89JRGv0IBNLLvL40F6A
        UfYDZt62WTGpb5cPCOjqGYvcdX35WKI5CIebhBAeXZR1iMgDX8rhei5aa57IQD8AXoPx3EI/XCAxU
        070STMgKOntR0cxrvE0UnpiETh0lHqytiAadEpBuI9heqpwsIgQZxIMQyKi2GC4sjQCcAonYXP+Q7
        t3p1Wq27EY8iK2d8cFdZgNzndqFNQnM/X6Im48kQtAkLVn31OofIQPMpUX976RYyU088fRNlFBYdb
        Iodu1R4Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gzNFH-0002NK-Ki; Thu, 28 Feb 2019 15:05:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C660D202C2DA5; Thu, 28 Feb 2019 16:05:08 +0100 (CET)
Message-Id: <20190228150152.078767622@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 28 Feb 2019 15:54:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH 1/8] kasan,x86: Frob kasan_report() in an exception
References: <20190228145450.289603901@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because __asan_{load,store}{N,1,2,4,8,16}_noabort() get called from
UACCESS context, and kasan_report() is most definitely _NOT_ safe to
be called from there, move it into an exception much like BUG/WARN.

*compile tested only*

Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/bug.h   |   28 ++++++++++++++--------------
 arch/x86/include/asm/kasan.h |   15 +++++++++++++++
 include/asm-generic/bug.h    |    1 +
 include/linux/kasan.h        |   12 +++++++++---
 lib/bug.c                    |    9 ++++++++-
 mm/kasan/generic.c           |    4 ++--
 mm/kasan/kasan.h             |    2 +-
 mm/kasan/report.c            |    2 +-
 8 files changed, 51 insertions(+), 22 deletions(-)

--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -30,33 +30,33 @@
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 
-#define _BUG_FLAGS(ins, flags)						\
+#define _BUG_FLAGS(ins, flags, ...)					\
 do {									\
 	asm volatile("1:\t" ins "\n"					\
 		     ".pushsection __bug_table,\"aw\"\n"		\
-		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
-		     "\t"  __BUG_REL(%c0) "\t# bug_entry::file\n"	\
-		     "\t.word %c1"        "\t# bug_entry::line\n"	\
-		     "\t.word %c2"        "\t# bug_entry::flags\n"	\
-		     "\t.org 2b+%c3\n"					\
+		     "2:\t" __BUG_REL(1b)      "\t# bug_entry::bug_addr\n" \
+		     "\t"  __BUG_REL(%c[file]) "\t# bug_entry::file\n"	\
+		     "\t.word %c[line]"        "\t# bug_entry::line\n"	\
+		     "\t.word %c[flag]"        "\t# bug_entry::flags\n"	\
+		     "\t.org 2b+%c[size]\n"				\
 		     ".popsection"					\
-		     : : "i" (__FILE__), "i" (__LINE__),		\
-			 "i" (flags),					\
-			 "i" (sizeof(struct bug_entry)));		\
+		     : : [file] "i" (__FILE__), [line] "i" (__LINE__),	\
+			 [flag] "i" (flags),				\
+			 [size] "i" (sizeof(struct bug_entry)), ##__VA_ARGS__);	\
 } while (0)
 
 #else /* !CONFIG_DEBUG_BUGVERBOSE */
 
-#define _BUG_FLAGS(ins, flags)						\
+#define _BUG_FLAGS(ins, flags, ...)					\
 do {									\
 	asm volatile("1:\t" ins "\n"					\
 		     ".pushsection __bug_table,\"aw\"\n"		\
 		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
-		     "\t.word %c0"        "\t# bug_entry::flags\n"	\
-		     "\t.org 2b+%c1\n"					\
+		     "\t.word %c[flag]"   "\t# bug_entry::flags\n"	\
+		     "\t.org 2b+%c[size]\n"				\
 		     ".popsection"					\
-		     : : "i" (flags),					\
-			 "i" (sizeof(struct bug_entry)));		\
+		     : : [flag] "i" (flags),				\
+			 [size] "i" (sizeof(struct bug_entry)), ##__VA_ARGS__);	\
 } while (0)
 
 #endif /* CONFIG_DEBUG_BUGVERBOSE */
--- a/arch/x86/include/asm/kasan.h
+++ b/arch/x86/include/asm/kasan.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_KASAN_H
 #define _ASM_X86_KASAN_H
 
+#include <asm/bug.h>
+
 #include <linux/const.h>
 #define KASAN_SHADOW_OFFSET _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
 #define KASAN_SHADOW_SCALE_SHIFT 3
@@ -26,8 +28,21 @@
 #ifndef __ASSEMBLY__
 
 #ifdef CONFIG_KASAN
+
 void __init kasan_early_init(void);
 void __init kasan_init(void);
+
+static __always_inline void
+kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip)
+{
+	unsigned long rdi = addr, rsi = size, rdx = is_write, rcx = ip;
+
+	_BUG_FLAGS(ASM_UD2, BUGFLAG_KASAN,
+		   "D" (rdi), "S" (rsi), "d" (rdx), "c" (rcx));
+	annotate_reachable();
+}
+#define kasan_report kasan_report
+
 #else
 static inline void kasan_early_init(void) { }
 static inline void kasan_init(void) { }
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -10,6 +10,7 @@
 #define BUGFLAG_WARNING		(1 << 0)
 #define BUGFLAG_ONCE		(1 << 1)
 #define BUGFLAG_DONE		(1 << 2)
+#define BUGFLAG_KASAN		(1 << 3)
 #define BUGFLAG_TAINT(taint)	((taint) << 8)
 #define BUG_GET_TAINT(bug)	((bug)->flags >> 8)
 #endif
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -83,6 +83,9 @@ size_t kasan_metadata_size(struct kmem_c
 bool kasan_save_enable_multi_shot(void);
 void kasan_restore_multi_shot(bool enabled);
 
+void __kasan_report(unsigned long addr, size_t size,
+		bool is_write, unsigned long ip);
+
 #else /* CONFIG_KASAN */
 
 static inline void kasan_unpoison_shadow(const void *address, size_t size) {}
@@ -153,8 +156,14 @@ static inline void kasan_remove_zero_sha
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
@@ -177,9 +186,6 @@ void kasan_init_tags(void);
 
 void *kasan_reset_tag(const void *addr);
 
-void kasan_report(unsigned long addr, size_t size,
-		bool is_write, unsigned long ip);
-
 #else /* CONFIG_KASAN_SW_TAGS */
 
 static inline void kasan_init_tags(void) { }
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -47,6 +47,7 @@
 #include <linux/bug.h>
 #include <linux/sched.h>
 #include <linux/rculist.h>
+#include <linux/kasan.h>
 
 extern struct bug_entry __start___bug_table[], __stop___bug_table[];
 
@@ -144,7 +145,7 @@ enum bug_trap_type report_bug(unsigned l
 {
 	struct bug_entry *bug;
 	const char *file;
-	unsigned line, warning, once, done;
+	unsigned line, warning, once, done, kasan;
 
 	if (!is_valid_bugaddr(bugaddr))
 		return BUG_TRAP_TYPE_NONE;
@@ -167,6 +168,7 @@ enum bug_trap_type report_bug(unsigned l
 		line = bug->line;
 #endif
 		warning = (bug->flags & BUGFLAG_WARNING) != 0;
+		kasan = (bug->flags & BUGFLAG_KASAN) != 0;
 		once = (bug->flags & BUGFLAG_ONCE) != 0;
 		done = (bug->flags & BUGFLAG_DONE) != 0;
 
@@ -188,6 +190,11 @@ enum bug_trap_type report_bug(unsigned l
 		return BUG_TRAP_TYPE_WARN;
 	}
 
+	if (kasan) {
+		__kasan_report(regs->di, regs->si, regs->dx, regs->cx);
+		return BUG_TRAP_TYPE_WARN;
+	}
+
 	printk(KERN_DEFAULT CUT_HERE);
 
 	if (file)
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -228,7 +228,7 @@ void __asan_unregister_globals(struct ka
 EXPORT_SYMBOL(__asan_unregister_globals);
 
 #define DEFINE_ASAN_LOAD_STORE(size)					\
-	void __asan_load##size(unsigned long addr)			\
+	notrace void __asan_load##size(unsigned long addr)		\
 	{								\
 		check_memory_region_inline(addr, size, false, _RET_IP_);\
 	}								\
@@ -236,7 +236,7 @@ EXPORT_SYMBOL(__asan_unregister_globals)
 	__alias(__asan_load##size)					\
 	void __asan_load##size##_noabort(unsigned long);		\
 	EXPORT_SYMBOL(__asan_load##size##_noabort);			\
-	void __asan_store##size(unsigned long addr)			\
+	notrace void __asan_store##size(unsigned long addr)		\
 	{								\
 		check_memory_region_inline(addr, size, true, _RET_IP_);	\
 	}								\
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -130,7 +130,7 @@ void check_memory_region(unsigned long a
 void *find_first_bad_addr(void *addr, size_t size);
 const char *get_bug_type(struct kasan_access_info *info);
 
-void kasan_report(unsigned long addr, size_t size,
+void __kasan_report(unsigned long addr, size_t size,
 		bool is_write, unsigned long ip);
 void kasan_report_invalid_free(void *object, unsigned long ip);
 
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


