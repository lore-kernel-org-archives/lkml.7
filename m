Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2C4C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75EEF20675
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T55gAZfD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388793AbfCAOqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:46:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45472 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388049AbfCAOqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ayRRt9dntHrJoxzSBlBWxfK0TqpBzsvFp8NhMfYDe20=; b=T55gAZfDfjUbH/0BNX529Ocf1
        GBi5GGUqTRUvwtVX/SvWTOuR1v8Hm3/Z8ZKU9T9BMTTOEuMOazqYNNCEAu5Up8EhW1Y45Bu8qbupR
        uNViiEU5AlAZe2IYfPCDgH7HQxib3J9C8ppyNkcatNhR5mt3zgWCaf6kT346af67zrQYdZ03MIBT0
        Jeg7xE3IStSD3/xT1BAHoiGNzEqCUc9UlmzVZ2lFXWMhIik+xF78EgjpHrORXwDE/GX3t0Lu2OQCb
        QWqFgkKn5Amptn+ZeitaL552vgH57VixphPaoi1fuf4WSnRksqbv0c5cAHaDKGSOjJfTAPTeYXd9x
        Uz6pJdSsQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gzjQE-00013n-UM; Fri, 01 Mar 2019 14:45:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DB8E520308686; Fri,  1 Mar 2019 15:45:56 +0100 (CET)
Date:   Fri, 1 Mar 2019 15:45:56 +0100
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
Message-ID: <20190301144556.GY32477@hirez.programming.kicks-ass.net>
References: <20190228145450.289603901@infradead.org>
 <20190228150152.078767622@infradead.org>
 <CACT4Y+b0WyE5En7BVipZiCMmMaj30kaEu3T68H7+-kVP8gqADA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+b0WyE5En7BVipZiCMmMaj30kaEu3T68H7+-kVP8gqADA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 04:22:04PM +0100, Dmitry Vyukov wrote:
> On Thu, Feb 28, 2019 at 4:05 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Because __asan_{load,store}{N,1,2,4,8,16}_noabort() get called from
> > UACCESS context, and kasan_report() is most definitely _NOT_ safe to
> > be called from there, move it into an exception much like BUG/WARN.
> >
> > *compile tested only*
> 
> 
> Please test it by booting KASAN kernel and then loading module
> produced by CONFIG_TEST_KASAN=y. There are too many subtle aspects to
> rely on "compile tested only", reviewers can't catch all of them
> either.

The below boots and survives test_kasan.

I'll now try that annotation you preferred. But I think this is a pretty
neat hack :-)

---
Subject: kasan,x86: Frob kasan_report() in an exception
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Feb 28 15:52:03 CET 2019

Because __asan_{load,store}{N,1,2,4,8,16}_noabort() get called from
UACCESS context, and kasan_report() is most definitely _NOT_ safe to
be called from there, move it into an exception much like BUg/WARN.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/bug.h   |   28 ++++++++++++++--------------
 arch/x86/include/asm/kasan.h |   17 +++++++++++++++++
 include/asm-generic/bug.h    |    1 +
 include/linux/kasan.h        |   12 +++++++++---
 lib/bug.c                    |    9 ++++++++-
 mm/kasan/kasan.h             |    2 +-
 mm/kasan/report.c            |    2 +-
 7 files changed, 51 insertions(+), 20 deletions(-)

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
@@ -2,7 +2,10 @@
 #ifndef _ASM_X86_KASAN_H
 #define _ASM_X86_KASAN_H
 
+#include <asm/bug.h>
+
 #include <linux/const.h>
+#include <linux/sched.h>
 #define KASAN_SHADOW_OFFSET _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
 #define KASAN_SHADOW_SCALE_SHIFT 3
 
@@ -26,8 +29,22 @@
 #ifndef __ASSEMBLY__
 
 #ifdef CONFIG_KASAN
+
 void __init kasan_early_init(void);
 void __init kasan_init(void);
+
+static __always_inline void
+kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip)
+{
+	if (!current->kasan_depth) {
+		unsigned long rdi = addr, rsi = size, rdx = is_write, rcx = ip;
+		_BUG_FLAGS(ASM_UD2, BUGFLAG_KASAN,
+				"D" (rdi), "S" (rsi), "d" (rdx), "c" (rcx));
+		annotate_reachable();
+	}
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
