Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A765C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37B620645
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qGKVeRb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfFKKos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 06:44:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53098 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbfFKKos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AVtW90u3NFcF26SkpkAMjvyARL0cd0oCTLADXgU7p0o=; b=qGKVeRb/9tebJCNZWUtMrCCj9
        CHtjbRDxNLj2kiQmBIo4gfj+8cF7huZtfQgx1o6hSSuoZnGuYPz6B8mPLBOvrh0fWH1BY6ZqP7aEA
        uN5mAPyIScwJ6Hdy9k1mRJYezMfHZxr4ecxta1FaOUgpY2tQkk8dDU7d2RYGum/TfhzzU86xdWWJ/
        RaT9bmHHh03a5pEoeO2JBS0trzbUvf7EiW5cCZb4bf3wxJi6xjyEH7BcJf5eXPyyYjaOMyq+OdrBm
        lE7I1UYcvi9zze7ikDwRx/s5yn6mX9Tc3d1XQBXTnUe3LhzoW20TVpsGvCzRKcE3v5Eggw3nH53qQ
        Sx8jt9FMg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1haeG4-00045r-OX; Tue, 11 Jun 2019 10:44:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2446B2063D749; Tue, 11 Jun 2019 12:44:02 +0200 (CEST)
Date:   Tue, 11 Jun 2019 12:44:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 08/15] x86/alternatives: Teach text_poke_bp() to emulate
 instructions
Message-ID: <20190611104402.GW3436@hirez.programming.kicks-ass.net>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.005681046@infradead.org>
 <20190608004708.7646b287151cf613838ce05f@kernel.org>
 <20190607173427.GK3436@hirez.programming.kicks-ass.net>
 <CAHk-=wg9dk6jXUcAE3FRkwHMqOra1MerS1Ehfgx-a2QQ22-Esg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg9dk6jXUcAE3FRkwHMqOra1MerS1Ehfgx-a2QQ22-Esg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 10:48:06AM -0700, Linus Torvalds wrote:
> On Fri, Jun 7, 2019 at 10:34 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > I was/am lazy and didn't want to deal with:
> >
> > arch/x86/include/asm/nops.h:#define GENERIC_NOP5_ATOMIC NOP_DS_PREFIX,GENERIC_NOP4
> > arch/x86/include/asm/nops.h:#define K8_NOP5_ATOMIC 0x66,K8_NOP4
> > arch/x86/include/asm/nops.h:#define K7_NOP5_ATOMIC NOP_DS_PREFIX,K7_NOP4
> > arch/x86/include/asm/nops.h:#define P6_NOP5_ATOMIC P6_NOP5
> 
> Ugh. Maybe we could just pick one atomic sequence, and not have the
> magic atomic nops be dynamic.

That'd be nice..

> It's essentially what STATIC_KEY_INIT_NOP #define seems to do anyway.

Well, that picks something, we'll overwrite it with the ideal nop later,
once we've figured out what it should be.

> NOP5_ATOMIC is already special, and not used for the normal nop
> rewriting, only for kprobe/jump_label/ftrace.

Right, but esp ftrace means there's a _lot_ of them around.

> So I suspect we could just replace all cases of
> 
>    ideal_nops[NOP_ATOMIC5]
> 
> with
> 
>    STATIC_KEY_INIT_NOP
> 
> and get rid of the whole "let's optimize the atomic 5-byte nop" entirely.
> 
> Hmm?

So we have:

GENERIC (x86_32):	leal ds:0x00(,%esi,1),%esi
K8 (x86_64):		osp osp osp osp nop
K7 (x86_32):		leal ds:0x00(,%eax,1),%eax
P6 (x86_64):		nopl 0x00(%eax,%eax,1)

And I guess the $64k question is if there's any actual performance
difference between the k8 and p6 variants on chips we still care about.

Most modern chips seem to end up selecting p6.

Anyway, the proposed patch looks like so:

---
Subject: x86: Remove ideal_nops[NOP_ATOMIC5]

By picking a single/fixed NOP5_ATOMIC instruction things become simpler.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/jump_label.h | 12 +++---------
 arch/x86/include/asm/nops.h       | 17 ++++++++---------
 arch/x86/kernel/alternative.c     |  8 --------
 arch/x86/kernel/ftrace.c          |  3 ++-
 arch/x86/kernel/jump_label.c      | 37 ++++++-------------------------------
 arch/x86/kernel/kprobes/core.c    |  3 ++-
 6 files changed, 21 insertions(+), 59 deletions(-)

diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 65191ce8e1cf..a3d45abcda95 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -4,12 +4,6 @@
 
 #define JUMP_LABEL_NOP_SIZE 5
 
-#ifdef CONFIG_X86_64
-# define STATIC_KEY_INIT_NOP P6_NOP5_ATOMIC
-#else
-# define STATIC_KEY_INIT_NOP GENERIC_NOP5_ATOMIC
-#endif
-
 #include <asm/asm.h>
 #include <asm/nops.h>
 
@@ -21,7 +15,7 @@
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
 	asm_volatile_goto("1:"
-		".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
+		".byte " __stringify(NOP5_ATOMIC) "\n\t"
 		".pushsection __jump_table,  \"aw\" \n\t"
 		_ASM_ALIGN "\n\t"
 		".long 1b - ., %l[l_yes] - . \n\t"
@@ -61,7 +55,7 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 	.long		\target - .Lstatic_jump_after_\@
 .Lstatic_jump_after_\@:
 	.else
-	.byte		STATIC_KEY_INIT_NOP
+	.byte		NOP5_ATOMIC
 	.endif
 	.pushsection __jump_table, "aw"
 	_ASM_ALIGN
@@ -73,7 +67,7 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 .macro STATIC_JUMP_IF_FALSE target, key, def
 .Lstatic_jump_\@:
 	.if \def
-	.byte		STATIC_KEY_INIT_NOP
+	.byte		NOP5_ATOMIC
 	.else
 	/* Equivalent to "jmp.d32 \target" */
 	.byte		0xe9
diff --git a/arch/x86/include/asm/nops.h b/arch/x86/include/asm/nops.h
index 12f12b5cf2ca..14cf05e645f5 100644
--- a/arch/x86/include/asm/nops.h
+++ b/arch/x86/include/asm/nops.h
@@ -28,7 +28,6 @@
 #define GENERIC_NOP6 0x8d,0xb6,0x00,0x00,0x00,0x00
 #define GENERIC_NOP7 0x8d,0xb4,0x26,0x00,0x00,0x00,0x00
 #define GENERIC_NOP8 GENERIC_NOP1,GENERIC_NOP7
-#define GENERIC_NOP5_ATOMIC NOP_DS_PREFIX,GENERIC_NOP4
 
 /* Opteron 64bit nops
    1: nop
@@ -44,7 +43,6 @@
 #define K8_NOP6	K8_NOP3,K8_NOP3
 #define K8_NOP7	K8_NOP4,K8_NOP3
 #define K8_NOP8	K8_NOP4,K8_NOP4
-#define K8_NOP5_ATOMIC 0x66,K8_NOP4
 
 /* K7 nops
    uses eax dependencies (arbitrary choice)
@@ -63,7 +61,6 @@
 #define K7_NOP6	0x8d,0x80,0,0,0,0
 #define K7_NOP7	0x8D,0x04,0x05,0,0,0,0
 #define K7_NOP8	K7_NOP7,K7_NOP1
-#define K7_NOP5_ATOMIC NOP_DS_PREFIX,K7_NOP4
 
 /* P6 nops
    uses eax dependencies (Intel-recommended choice)
@@ -86,7 +83,12 @@
 #define P6_NOP6	0x66,0x0f,0x1f,0x44,0x00,0
 #define P6_NOP7	0x0f,0x1f,0x80,0,0,0,0
 #define P6_NOP8	0x0f,0x1f,0x84,0x00,0,0,0,0
-#define P6_NOP5_ATOMIC P6_NOP5
+
+#ifdef CONFIG_X86_64
+#define NOP5_ATOMIC	P6_NOP5
+#else
+#define NOP5_ATOMIC	NOP_DS_PREFIX,GENERIC_NOP4
+#endif
 
 #ifdef __ASSEMBLY__
 #define _ASM_MK_NOP(x) .byte x
@@ -103,7 +105,6 @@
 #define ASM_NOP6 _ASM_MK_NOP(K7_NOP6)
 #define ASM_NOP7 _ASM_MK_NOP(K7_NOP7)
 #define ASM_NOP8 _ASM_MK_NOP(K7_NOP8)
-#define ASM_NOP5_ATOMIC _ASM_MK_NOP(K7_NOP5_ATOMIC)
 #elif defined(CONFIG_X86_P6_NOP)
 #define ASM_NOP1 _ASM_MK_NOP(P6_NOP1)
 #define ASM_NOP2 _ASM_MK_NOP(P6_NOP2)
@@ -113,7 +114,6 @@
 #define ASM_NOP6 _ASM_MK_NOP(P6_NOP6)
 #define ASM_NOP7 _ASM_MK_NOP(P6_NOP7)
 #define ASM_NOP8 _ASM_MK_NOP(P6_NOP8)
-#define ASM_NOP5_ATOMIC _ASM_MK_NOP(P6_NOP5_ATOMIC)
 #elif defined(CONFIG_X86_64)
 #define ASM_NOP1 _ASM_MK_NOP(K8_NOP1)
 #define ASM_NOP2 _ASM_MK_NOP(K8_NOP2)
@@ -123,7 +123,6 @@
 #define ASM_NOP6 _ASM_MK_NOP(K8_NOP6)
 #define ASM_NOP7 _ASM_MK_NOP(K8_NOP7)
 #define ASM_NOP8 _ASM_MK_NOP(K8_NOP8)
-#define ASM_NOP5_ATOMIC _ASM_MK_NOP(K8_NOP5_ATOMIC)
 #else
 #define ASM_NOP1 _ASM_MK_NOP(GENERIC_NOP1)
 #define ASM_NOP2 _ASM_MK_NOP(GENERIC_NOP2)
@@ -133,11 +132,11 @@
 #define ASM_NOP6 _ASM_MK_NOP(GENERIC_NOP6)
 #define ASM_NOP7 _ASM_MK_NOP(GENERIC_NOP7)
 #define ASM_NOP8 _ASM_MK_NOP(GENERIC_NOP8)
-#define ASM_NOP5_ATOMIC _ASM_MK_NOP(GENERIC_NOP5_ATOMIC)
 #endif
 
+#define ASM_NOP5_ATOMIC _ASM_MK_NOP(NOP5_ATOMIC)
+
 #define ASM_NOP_MAX 8
-#define NOP_ATOMIC5 (ASM_NOP_MAX+1)	/* Entry for the 5-byte atomic NOP */
 
 #ifndef __ASSEMBLY__
 extern const unsigned char * const *ideal_nops;
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 0d57015114e7..4c0250049d4f 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -90,7 +90,6 @@ static const unsigned char intelnops[] =
 	GENERIC_NOP6,
 	GENERIC_NOP7,
 	GENERIC_NOP8,
-	GENERIC_NOP5_ATOMIC
 };
 static const unsigned char * const intel_nops[ASM_NOP_MAX+2] =
 {
@@ -103,7 +102,6 @@ static const unsigned char * const intel_nops[ASM_NOP_MAX+2] =
 	intelnops + 1 + 2 + 3 + 4 + 5,
 	intelnops + 1 + 2 + 3 + 4 + 5 + 6,
 	intelnops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
-	intelnops + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8,
 };
 #endif
 
@@ -118,7 +116,6 @@ static const unsigned char k8nops[] =
 	K8_NOP6,
 	K8_NOP7,
 	K8_NOP8,
-	K8_NOP5_ATOMIC
 };
 static const unsigned char * const k8_nops[ASM_NOP_MAX+2] =
 {
@@ -131,7 +128,6 @@ static const unsigned char * const k8_nops[ASM_NOP_MAX+2] =
 	k8nops + 1 + 2 + 3 + 4 + 5,
 	k8nops + 1 + 2 + 3 + 4 + 5 + 6,
 	k8nops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
-	k8nops + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8,
 };
 #endif
 
@@ -146,7 +142,6 @@ static const unsigned char k7nops[] =
 	K7_NOP6,
 	K7_NOP7,
 	K7_NOP8,
-	K7_NOP5_ATOMIC
 };
 static const unsigned char * const k7_nops[ASM_NOP_MAX+2] =
 {
@@ -159,7 +154,6 @@ static const unsigned char * const k7_nops[ASM_NOP_MAX+2] =
 	k7nops + 1 + 2 + 3 + 4 + 5,
 	k7nops + 1 + 2 + 3 + 4 + 5 + 6,
 	k7nops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
-	k7nops + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8,
 };
 #endif
 
@@ -174,7 +168,6 @@ static const unsigned char p6nops[] =
 	P6_NOP6,
 	P6_NOP7,
 	P6_NOP8,
-	P6_NOP5_ATOMIC
 };
 static const unsigned char * const p6_nops[ASM_NOP_MAX+2] =
 {
@@ -187,7 +180,6 @@ static const unsigned char * const p6_nops[ASM_NOP_MAX+2] =
 	p6nops + 1 + 2 + 3 + 4 + 5,
 	p6nops + 1 + 2 + 3 + 4 + 5 + 6,
 	p6nops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
-	p6nops + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8,
 };
 #endif
 
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 0927bb158ffc..6ea5ea506a5f 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -101,7 +101,8 @@ static unsigned long text_ip_addr(unsigned long ip)
 
 static const unsigned char *ftrace_nop_replace(void)
 {
-	return ideal_nops[NOP_ATOMIC5];
+	static const unsigned char nop[] = { NOP5_ATOMIC };
+	return nop;
 }
 
 static int
diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index e631c358f7f4..5a27cf6e1c73 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -40,8 +40,7 @@ static void __ref __jump_label_transform(struct jump_entry *entry,
 					 int init)
 {
 	union jump_code_union jmp;
-	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
-	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
+	const unsigned char nop[] = { NOP5_ATOMIC };
 	const void *expect, *code;
 	int line;
 
@@ -50,21 +49,13 @@ static void __ref __jump_label_transform(struct jump_entry *entry,
 		     (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
 
 	if (type == JUMP_LABEL_JMP) {
-		if (init) {
-			expect = default_nop; line = __LINE__;
-		} else {
-			expect = ideal_nop; line = __LINE__;
-		}
-
+		expect = nop;
+		line = __LINE__;
 		code = &jmp.code;
 	} else {
-		if (init) {
-			expect = default_nop; line = __LINE__;
-		} else {
-			expect = &jmp.code; line = __LINE__;
-		}
-
-		code = ideal_nop;
+		expect = &jmp.code;
+		line = __LINE__;
+		code = nop;
 	}
 
 	if (memcmp((void *)jump_entry_code(entry), expect, JUMP_LABEL_NOP_SIZE))
@@ -108,22 +99,6 @@ static enum {
 __init_or_module void arch_jump_label_transform_static(struct jump_entry *entry,
 				      enum jump_label_type type)
 {
-	/*
-	 * This function is called at boot up and when modules are
-	 * first loaded. Check if the default nop, the one that is
-	 * inserted at compile time, is the ideal nop. If it is, then
-	 * we do not need to update the nop, and we can leave it as is.
-	 * If it is not, then we need to update the nop to the ideal nop.
-	 */
-	if (jlstate == JL_STATE_START) {
-		const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
-		const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
-
-		if (memcmp(ideal_nop, default_nop, 5) != 0)
-			jlstate = JL_STATE_UPDATE;
-		else
-			jlstate = JL_STATE_NO_UPDATE;
-	}
 	if (jlstate == JL_STATE_UPDATE)
 		__jump_label_transform(entry, type, 1);
 }
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 6afd8061dbae..5b9aa5608d0d 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -204,6 +204,7 @@ int can_boost(struct insn *insn, void *addr)
 static unsigned long
 __recover_probed_insn(kprobe_opcode_t *buf, unsigned long addr)
 {
+	static const unsigned char nop[] = { NOP5_ATOMIC };
 	struct kprobe *kp;
 	unsigned long faddr;
 
@@ -247,7 +248,7 @@ __recover_probed_insn(kprobe_opcode_t *buf, unsigned long addr)
 		return 0UL;
 
 	if (faddr)
-		memcpy(buf, ideal_nops[NOP_ATOMIC5], 5);
+		memcpy(buf, nop, 5);
 	else
 		buf[0] = kp->opcode;
 	return (unsigned long)buf;
