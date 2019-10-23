Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5B2CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DB42086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407208AbfJWQXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:23:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407111AbfJWQXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:23:12 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AE602084C;
        Wed, 23 Oct 2019 16:23:08 +0000 (UTC)
Date:   Wed, 23 Oct 2019 12:23:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
Message-ID: <20191023122307.756b4978@gandalf.local.home>
In-Reply-To: <20191022215841.2qsmhd6vxi4mwade@ast-mbp.dhcp.thefacebook.com>
References: <CAADnVQLn+Fh-UgSRD9SZCT7WYOez5De04iCZucYbA9mYxPm2AQ@mail.gmail.com>
        <20191021231630.49805757@oasis.local.home>
        <20191021231904.4b968dc1@oasis.local.home>
        <20191022040532.fvpxcs74i4mn4rc6@ast-mbp.dhcp.thefacebook.com>
        <20191022071956.07e21543@gandalf.local.home>
        <20191022094455.6a0a1a27@gandalf.local.home>
        <20191022175052.frjzlnjjfwwfov64@ast-mbp.dhcp.thefacebook.com>
        <20191022141021.2c4496c2@gandalf.local.home>
        <20191022204620.jp535nfvfubjngzd@ast-mbp.dhcp.thefacebook.com>
        <20191022170430.6af3b360@gandalf.local.home>
        <20191022215841.2qsmhd6vxi4mwade@ast-mbp.dhcp.thefacebook.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019 14:58:43 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> Neither of two statements are true. The per-function generated trampoline
> I'm talking about is bpf specific. For a function with two arguments it's just:
> push rbp 
> mov rbp, rsp
> push rdi
> push rsi
> lea  rdi,[rbp-0x10]
> call jited_bpf_prog
> pop rsi
> pop rdi
> leave
> ret
> 
> fentry's nop is replaced with call to the above.
> That's it.
> kprobe and live patching has no use out of it.
> 

Below is a patch that allows you to do this, and you don't need to
worry about patching the nops. And it also allows to you hook directly
to any function and still allow kprobes and tracing on those same
functions (as long as they don't modify the ip, but in the future, we
may be able to allow that too!). And this code does not depend on
Peter's code either.

All you need to do is:

	register_ftrace_direct((unsigned long)func_you_want_to_trace,
			       (unsigned long)your_trampoline);


I added to trace-event-samples.c:

void my_direct_func(raw_spinlock_t *lock)
{
	trace_printk("taking %p\n", lock);
}

extern void my_tramp(void *);

asm (
"       .pushsection    .text, \"ax\", @progbits\n"
"   my_tramp:"
#if 1
"       pushq %rbp\n"
"	movq %rsp, %rbp\n"
"	pushq %rdi\n"
"	call my_direct_func\n"
"	popq %rdi\n"
"	leave\n"
#endif
"	ret\n"
"       .popsection\n"
);


(the #if was for testing purposes)

And then in the module load and unload:

	ret = register_ftrace_direct((unsigned long)do_raw_spin_lock,
				     (unsigned long)my_tramp);

	unregister_ftrace_direct((unsigned long)do_raw_spin_lock,
				 (unsigned long)my_tramp);

respectively.

And what this does is if there's only a single callback to the
registered function, it changes the nop in the function to call your
trampoline directly (just like you want this to do!). But if we add
another callback, a direct_ops ftrace_ops gets added to the list of the
functions to go through, and this will set up the code to call your
trampoline after it calls all the other callbacks.

The called trampoline will be called as if it was called directly from
the nop.

OK, I wrote this up quickly, and it has some bugs, but nothing that
can't be straighten out (specifically, the checks fail if you add a
function trace to one of the direct callbacks, but this can be dealt
with).

Note, the work needed to port this to other archs is rather minimal
(just need to tweak the ftrace_regs_caller and have a way to pass back
the call address via pt_regs that is not saved).

Alexei,

Would this work for you?

-- Steve

[ This is on top of the last patch I sent ]

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6adaf18b3365..de3372bd08ae 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -159,6 +159,7 @@ config X86
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_DYNAMIC_FTRACE_WITH_IPMODIFY
+	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_EBPF_JIT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_EISA
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index c38a66661576..34da1e424391 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -28,6 +28,12 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 	return addr;
 }
 
+static inline void ftrace_set_call_func(struct pt_regs *regs, unsigned long addr)
+{
+	/* Emulate a call */
+	regs->orig_ax = addr;
+}
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 struct dyn_arch_ftrace {
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 5930810bf71d..3fcaf03566b0 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -88,6 +88,7 @@ EXPORT_SYMBOL(__fentry__)
 	movq %rdi, RDI(%rsp)
 	movq %r8, R8(%rsp)
 	movq %r9, R9(%rsp)
+	movq $0, ORIG_RAX(%rsp)
 	/*
 	 * Save the original RBP. Even though the mcount ABI does not
 	 * require this, it helps out callers.
@@ -114,7 +115,23 @@ EXPORT_SYMBOL(__fentry__)
 	subq $MCOUNT_INSN_SIZE, %rdi
 	.endm
 
-.macro restore_mcount_regs
+.macro restore_mcount_regs make_call=0 save_flags=0
+
+	/* ftrace_regs_caller can modify %rbp */
+	movq RBP(%rsp), %rbp
+
+	.if \make_call
+	movq ORIG_RAX(%rsp), %rax
+	movq %rax, MCOUNT_REG_SIZE-8(%rsp)
+
+	/* Swap the flags with orig_rax */
+	.if \save_flags
+	movq MCOUNT_REG_SIZE(%rsp), %rdi
+	movq %rdi, MCOUNT_REG_SIZE-8(%rsp)
+	movq %rax, MCOUNT_REG_SIZE(%rsp)
+	.endif
+	.endif
+
 	movq R9(%rsp), %r9
 	movq R8(%rsp), %r8
 	movq RDI(%rsp), %rdi
@@ -123,10 +140,11 @@ EXPORT_SYMBOL(__fentry__)
 	movq RCX(%rsp), %rcx
 	movq RAX(%rsp), %rax
 
-	/* ftrace_regs_caller can modify %rbp */
-	movq RBP(%rsp), %rbp
-
+	.if \make_call
+	addq $MCOUNT_REG_SIZE-8, %rsp
+	.else
 	addq $MCOUNT_REG_SIZE, %rsp
+	.endif
 
 	.endm
 
@@ -189,10 +207,17 @@ GLOBAL(ftrace_ip_call)
 
 	/* Handlers can change the RIP */
 	movq RIP(%rsp), %rax
-	movq %rax, MCOUNT_REG_SIZE(%rsp)
+	movq	%rax, MCOUNT_REG_SIZE(%rsp)
 
-	restore_mcount_regs
+	/* If ORIG_RAX is anything but zero, make this a call to that */
+	movq ORIG_RAX(%rsp), %rax
+	cmpq	$0, %rax
+	je	1f
+	restore_mcount_regs make_call=1
+	jmp	2f
 
+1:	restore_mcount_regs
+2:
 	/*
 	 * As this jmp to ftrace_epilogue can be a short jump
 	 * it must not be copied into the trampoline.
@@ -261,7 +286,15 @@ GLOBAL(ftrace_regs_call)
 	movq R10(%rsp), %r10
 	movq RBX(%rsp), %rbx
 
-	restore_mcount_regs
+	/* If ORIG_RAX is anything but zero, make this a call to that */
+	movq ORIG_RAX(%rsp), %rax
+	cmpq	$0, %rax
+	je	1f
+	restore_mcount_regs make_call=1 save_flags=1
+	jmp	2f
+
+1:	restore_mcount_regs
+2:
 
 	/* Restore flags */
 	popfq
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index ba1cf5640639..9b7e3ec647c7 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -144,6 +144,7 @@ ftrace_func_t ftrace_ops_get_func(struct ftrace_ops *ops);
  * TRACE_ARRAY - The ops->private points to a trace_array descriptor.
  * PERMANENT - Set when the ops is permanent and should not be affected by
  *             ftrace_enabled.
+ * DIRECT - Used by the direct ftrace_ops helper for direct functions.
  */
 enum {
 	FTRACE_OPS_FL_ENABLED			= 1 << 0,
@@ -163,6 +164,7 @@ enum {
 	FTRACE_OPS_FL_RCU			= 1 << 14,
 	FTRACE_OPS_FL_TRACE_ARRAY		= 1 << 15,
 	FTRACE_OPS_FL_PERMANENT                 = 1 << 16,
+	FTRACE_OPS_FL_DIRECT			= 1 << 17,
 };
 
 #ifdef CONFIG_DYNAMIC_FTRACE
@@ -226,6 +228,8 @@ extern enum ftrace_tracing_type_t ftrace_tracing_type;
  */
 int register_ftrace_function(struct ftrace_ops *ops);
 int unregister_ftrace_function(struct ftrace_ops *ops);
+int register_ftrace_direct(unsigned long ip, unsigned long addr);
+int unregister_ftrace_direct(unsigned long ip, unsigned long addr);
 
 extern void ftrace_stub(unsigned long a0, unsigned long a1,
 			struct ftrace_ops *op, struct pt_regs *regs);
@@ -335,6 +339,7 @@ bool is_ftrace_trampoline(unsigned long addr);
  *  DISABLED - the record is not ready to be touched yet
  *  IP       - the record wants ip modification only (no regs)
  *  IP_EN    - the record has ip modification only
+ *  DIRECT   - there is a direct function to call
  *
  * When a new ftrace_ops is registered and wants a function to save
  * pt_regs, the rec->flag REGS is set. When the function has been
@@ -352,10 +357,11 @@ enum {
 	FTRACE_FL_DISABLED	= (1UL << 25),
 	FTRACE_FL_IP		= (1UL << 24),
 	FTRACE_FL_IP_EN		= (1UL << 23),
+	FTRACE_FL_DIRECT	= (1UL << 22),
 };
 
-#define FTRACE_REF_MAX_SHIFT	23
-#define FTRACE_FL_BITS		9
+#define FTRACE_REF_MAX_SHIFT	22
+#define FTRACE_FL_BITS		10
 #define FTRACE_FL_MASKED_BITS	((1UL << FTRACE_FL_BITS) - 1)
 #define FTRACE_FL_MASK		(FTRACE_FL_MASKED_BITS << FTRACE_REF_MAX_SHIFT)
 #define FTRACE_REF_MAX		((1UL << FTRACE_REF_MAX_SHIFT) - 1)
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index a1b88b810b8a..85403d321ee6 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -36,6 +36,9 @@ config HAVE_DYNAMIC_FTRACE_WITH_REGS
 config HAVE_DYNAMIC_FTRACE_WITH_IPMODIFY
 	bool
 
+config HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	bool
+
 config HAVE_FTRACE_MCOUNT_RECORD
 	bool
 	help
@@ -565,6 +568,11 @@ config DYNAMIC_FTRACE_WITH_IPMODIFY_ONLY
 	depends on DYNAMIC_FTRACE
 	depends on HAVE_DYNAMIC_FTRACE_WITH_IPMODIFY
 
+config DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	def_bool y
+	depends on DYNAMIC_FTRACE
+	depends on HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+
 config FUNCTION_PROFILER
 	bool "Kernel function profiler"
 	depends on FUNCTION_TRACER
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index fec64bf679e8..c0fa24b75c35 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1030,6 +1030,7 @@ static bool update_all_ops;
 struct ftrace_func_entry {
 	struct hlist_node hlist;
 	unsigned long ip;
+	unsigned long direct; /* for direct lookup only */
 };
 
 struct ftrace_func_probe {
@@ -1379,16 +1380,32 @@ ftrace_hash_rec_enable_modify(struct ftrace_ops *ops, int filter_hash);
 static int ftrace_hash_ipmodify_update(struct ftrace_ops *ops,
 				       struct ftrace_hash *new_hash);
 
-static struct ftrace_hash *
-__ftrace_hash_move(struct ftrace_hash *src)
+static void transfer_hash(struct ftrace_hash *dst, struct ftrace_hash *src)
 {
 	struct ftrace_func_entry *entry;
-	struct hlist_node *tn;
 	struct hlist_head *hhd;
+	struct hlist_node *tn;
+	int size;
+	int i;
+
+	dst->flags = src->flags;
+
+	size = 1 << src->size_bits;
+	for (i = 0; i < size; i++) {
+		hhd = &src->buckets[i];
+		hlist_for_each_entry_safe(entry, tn, hhd, hlist) {
+			remove_hash_entry(src, entry);
+			__add_hash_entry(dst, entry);
+		}
+	}
+}
+
+static struct ftrace_hash *
+__ftrace_hash_move(struct ftrace_hash *src)
+{
 	struct ftrace_hash *new_hash;
 	int size = src->count;
 	int bits = 0;
-	int i;
 
 	/*
 	 * If the new source is empty, just return the empty_hash.
@@ -1410,16 +1427,7 @@ __ftrace_hash_move(struct ftrace_hash *src)
 	if (!new_hash)
 		return NULL;
 
-	new_hash->flags = src->flags;
-
-	size = 1 << src->size_bits;
-	for (i = 0; i < size; i++) {
-		hhd = &src->buckets[i];
-		hlist_for_each_entry_safe(entry, tn, hhd, hlist) {
-			remove_hash_entry(src, entry);
-			__add_hash_entry(new_hash, entry);
-		}
-	}
+	transfer_hash(new_hash, src);
 
 	return new_hash;
 }
@@ -1543,6 +1551,26 @@ static int ftrace_cmp_recs(const void *a, const void *b)
 	return 0;
 }
 
+struct dyn_ftrace *lookup_rec(unsigned long start, unsigned long end)
+{
+	struct ftrace_page *pg;
+	struct dyn_ftrace *rec = NULL;
+	struct dyn_ftrace key;
+
+	key.ip = start;
+	key.flags = end;	/* overload flags, as it is unsigned long */
+
+	for (pg = ftrace_pages_start; pg; pg = pg->next) {
+		if (end < pg->records[0].ip ||
+		    start >= (pg->records[pg->index - 1].ip + MCOUNT_INSN_SIZE))
+			continue;
+		rec = bsearch(&key, pg->records, pg->index,
+			      sizeof(struct dyn_ftrace),
+			      ftrace_cmp_recs);
+	}
+	return rec;
+}
+
 /**
  * ftrace_location_range - return the first address of a traced location
  *	if it touches the given ip range
@@ -1557,23 +1585,11 @@ static int ftrace_cmp_recs(const void *a, const void *b)
  */
 unsigned long ftrace_location_range(unsigned long start, unsigned long end)
 {
-	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
-	struct dyn_ftrace key;
 
-	key.ip = start;
-	key.flags = end;	/* overload flags, as it is unsigned long */
-
-	for (pg = ftrace_pages_start; pg; pg = pg->next) {
-		if (end < pg->records[0].ip ||
-		    start >= (pg->records[pg->index - 1].ip + MCOUNT_INSN_SIZE))
-			continue;
-		rec = bsearch(&key, pg->records, pg->index,
-			      sizeof(struct dyn_ftrace),
-			      ftrace_cmp_recs);
-		if (rec)
-			return rec->ip;
-	}
+	rec = lookup_rec(start, end);
+	if (rec)
+		return rec->ip;
 
 	return 0;
 }
@@ -1744,6 +1760,9 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
 			if (FTRACE_WARN_ON(ftrace_rec_count(rec) == FTRACE_REF_MAX))
 				return false;
 
+			if (ops->flags & FTRACE_OPS_FL_DIRECT)
+				rec->flags |= FTRACE_FL_DIRECT;
+
 			/*
 			 * If there's only a single callback registered to a
 			 * function, and the ops has a trampoline registered
@@ -1783,6 +1802,9 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
 				return false;
 			rec->flags--;
 
+			if (ops->flags & FTRACE_OPS_FL_DIRECT)
+				rec->flags &= ~FTRACE_FL_DIRECT;
+
 			/*
 			 * If the rec had REGS enabled and the ops that is
 			 * being removed had REGS set, then see if there is
@@ -2356,6 +2378,156 @@ ftrace_find_tramp_ops_new(struct dyn_ftrace *rec)
 	return NULL;
 }
 
+static struct ftrace_hash *direct_functions = EMPTY_HASH;
+static DEFINE_MUTEX(direct_mutex);
+
+static unsigned long find_rec_direct(unsigned long ip)
+{
+	struct ftrace_func_entry *entry;
+
+	entry = __ftrace_lookup_ip(direct_functions, ip);
+	if (!entry)
+		return FTRACE_REGS_ADDR;
+
+	return entry->direct;
+}
+
+static void call_direct_funcs(unsigned long ip, unsigned long pip,
+			      struct ftrace_ops *ops, struct pt_regs *regs)
+{
+	unsigned long addr;
+
+	addr = find_rec_direct(ip);
+	if (addr == FTRACE_REGS_ADDR)
+		return;
+
+	ftrace_set_call_func(regs, addr);
+}
+
+struct ftrace_ops direct_ops = {
+	.func		= call_direct_funcs,
+	.flags		= FTRACE_OPS_FL_IPMODIFY | FTRACE_OPS_FL_RECURSION_SAFE
+#if 1
+					| FTRACE_OPS_FL_DIRECT
+#endif
+#ifndef CONFIG_DYNAMIC_FTRACE_WITH_IPMODIFY_ONLY
+					| FTRACE_OPS_FL_SAVE_REGS
+#endif
+	,
+};
+
+int register_ftrace_direct(unsigned long ip, unsigned long addr)
+{
+	struct ftrace_func_entry *entry;
+	struct dyn_ftrace *rec;
+	int ret = -EBUSY;
+
+	mutex_lock(&direct_mutex);
+
+	if (find_rec_direct(ip) != FTRACE_REGS_ADDR)
+		goto out_unlock;
+
+	rec = lookup_rec(ip, ip);
+	ret = -ENODEV;
+	if (!rec)
+		goto out_unlock;
+
+	if (WARN_ON(rec->flags & FTRACE_FL_DIRECT))
+		goto out_unlock;
+
+	/* Make sure the ip points to the exact record */
+	ip = rec->ip;
+
+	ret = -ENOMEM;
+	if (ftrace_hash_empty(direct_functions) ||
+	    direct_functions->count > 2 * (1 << direct_functions->size_bits)) {
+		struct ftrace_hash *new_hash;
+		int size = ftrace_hash_empty(direct_functions) ? 0 :
+			direct_functions->count + 1;
+		int bits;
+
+		if (size < 32)
+			size = 32;
+
+		for (size /= 2; size; size >>= 1)
+			bits++;
+
+		/* Don't allocate too much */
+		if (bits > FTRACE_HASH_MAX_BITS)
+			bits = FTRACE_HASH_MAX_BITS;
+
+		new_hash = alloc_ftrace_hash(bits);
+		if (!new_hash)
+			goto out_unlock;
+
+		transfer_hash(new_hash, direct_functions);
+		free_ftrace_hash(direct_functions);
+		direct_functions = new_hash;
+	}
+
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		goto out_unlock;
+
+	entry->ip = ip;
+	entry->direct = addr;
+	__add_hash_entry(direct_functions, entry);
+
+	ret = ftrace_set_filter_ip(&direct_ops, ip, 0, 0);
+	if (ret)
+		remove_hash_entry(direct_functions, entry);
+
+	if (!ret && !(direct_ops.flags & FTRACE_OPS_FL_ENABLED))
+		ret = register_ftrace_function(&direct_ops);
+
+ out_unlock:
+	mutex_unlock(&direct_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(register_ftrace_direct);
+
+int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
+{
+	struct ftrace_func_entry *entry;
+	struct dyn_ftrace *rec;
+	int ret = -ENODEV;
+
+	mutex_lock(&direct_mutex);
+
+
+	entry = __ftrace_lookup_ip(direct_functions, ip);
+	if (!entry) {
+		/* OK if it is off by a little */
+		rec = lookup_rec(ip, ip);
+		if (!rec || rec->ip == ip)
+			goto out_unlock;
+
+		entry = __ftrace_lookup_ip(direct_functions, rec->ip);
+		if (!entry) {
+			WARN_ON(rec->flags & FTRACE_FL_DIRECT);
+			goto out_unlock;
+		}
+
+		WARN_ON(!(rec->flags & FTRACE_FL_DIRECT));
+	}
+
+	remove_hash_entry(direct_functions, entry);
+
+	if (!direct_functions->count)
+		unregister_ftrace_function(&direct_ops);
+
+	ret = ftrace_set_filter_ip(&direct_ops, ip, 1, 0);
+	WARN_ON(ret);
+
+ out_unlock:
+	mutex_unlock(&direct_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(unregister_ftrace_direct);
+
+
 /**
  * ftrace_get_addr_new - Get the call address to set to
  * @rec:  The ftrace record descriptor
@@ -2370,6 +2542,10 @@ unsigned long ftrace_get_addr_new(struct dyn_ftrace *rec)
 {
 	struct ftrace_ops *ops;
 
+	if ((rec->flags & FTRACE_FL_DIRECT) &&
+	    (ftrace_rec_count(rec) == 1))
+		return find_rec_direct(rec->ip);
+
 	/* Trampolines take precedence over regs */
 	if (rec->flags & FTRACE_FL_TRAMP) {
 		ops = ftrace_find_tramp_ops_new(rec);
@@ -3523,10 +3699,17 @@ static int t_show(struct seq_file *m, void *v)
 	if (iter->flags & FTRACE_ITER_ENABLED) {
 		struct ftrace_ops *ops;
 
-		seq_printf(m, " (%ld)%s%s",
+		seq_printf(m, " (%ld)%s%s%s",
 			   ftrace_rec_count(rec),
 			   rec->flags & FTRACE_FL_REGS ? " R" : "  ",
-			   rec->flags & FTRACE_FL_IP ? " I" : "  ");
+			   rec->flags & FTRACE_FL_IP ? " I" : "  ",
+			   rec->flags & FTRACE_FL_DIRECT ? " D": "  ");
+		if (rec->flags & FTRACE_FL_DIRECT) {
+			unsigned long direct;
+			direct = find_rec_direct(rec->ip);
+			if (direct != FTRACE_REGS_ADDR)
+				seq_printf(m, " -->%pS\n", (void *)direct);
+		}
 		if (rec->flags & FTRACE_FL_TRAMP_EN) {
 			ops = ftrace_find_tramp_ops_any(rec);
 			if (ops) {
diff --git a/samples/trace_events/trace-events-sample.c b/samples/trace_events/trace-events-sample.c
index e87d9decb994..f01f54f45fdc 100644
--- a/samples/trace_events/trace-events-sample.c
+++ b/samples/trace_events/trace-events-sample.c
@@ -19,8 +19,6 @@ int x;
 
 static void my_do_spin_lock(raw_spinlock_t *lock)
 {
-	int ret;
-
 //	trace_printk("takeing %p\n", lock);
 	do_raw_spin_lock(lock);
 	/* Force not having a tail call */
@@ -29,6 +27,28 @@ static void my_do_spin_lock(raw_spinlock_t *lock)
 	x++;
 }
 
+void my_direct_func(raw_spinlock_t *lock)
+{
+	trace_printk("taking %p\n", lock);
+}
+
+extern void my_tramp(void *);
+
+asm (
+"       .pushsection    .text, \"ax\", @progbits\n"
+"   my_tramp:"
+#if 1
+"       pushq %rbp\n"
+"	movq %rsp, %rbp\n"
+"	pushq %rdi\n"
+"	call my_direct_func\n"
+"	popq %rdi\n"
+"	leave\n"
+#endif
+"	ret\n"
+"       .popsection\n"
+);
+
 static void my_hijack_func(unsigned long ip, unsigned long pip,
 			   struct ftrace_ops *ops, struct pt_regs *regs)
 {
@@ -152,6 +172,9 @@ static int __init trace_event_init(void)
 {
 	int ret;
 
+	ret = register_ftrace_direct((unsigned long)do_raw_spin_lock,
+				     (unsigned long)my_tramp);
+	return 0;
 	ret = ftrace_set_filter_ip(&my_ops, (unsigned long)do_raw_spin_lock, 0, 0);
 	if (!ret)
 		register_ftrace_function(&my_ops);
@@ -166,6 +189,9 @@ static int __init trace_event_init(void)
 
 static void __exit trace_event_exit(void)
 {
+	unregister_ftrace_direct((unsigned long)do_raw_spin_lock,
+				 (unsigned long)my_tramp);
+	return;
 	unregister_ftrace_function(&my_ops);
 	return;
 	kthread_stop(simple_tsk);
