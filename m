Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C13ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 02:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34C4214B2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 02:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733146AbfJWCDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 22:03:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbfJWCDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 22:03:04 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63B6B2086D;
        Wed, 23 Oct 2019 02:03:01 +0000 (UTC)
Date:   Tue, 22 Oct 2019 22:02:59 -0400
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
Message-ID: <20191022220259.70f7306b@gandalf.local.home>
In-Reply-To: <20191022181740.5a2893a6@gandalf.local.home>
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
        <20191022181740.5a2893a6@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/8W=AiJJlYQ.Y5+44aa7oTpl"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_/8W=AiJJlYQ.Y5+44aa7oTpl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, 22 Oct 2019 18:17:40 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > your solution is to reduce the overhead.
> > my solution is to remove it competely. See the difference?  
> 
> You're just trimming it down. I'm curious to what overhead you save by
> not saving all parameter registers, and doing a case by case basis?

I played with adding a ftrace_ip_caller, that only modifies the ip, and
passes a regs with bare minimum saved (allowing the callback to modify
the regs->ip).

I modified the test-events-sample to just hijack the do_raw_spin_lock()
function, which is a very hot path, as it is called by most of the
spin_lock code.

I then ran:

 # perf stat -r 20 /work/c/hackbench 50

vanilla, as nothing is happening.

I then enabled the test-events-sample with the new ftrace ip
modification only.

I then had it do the hijack of do_raw_spin_lock() with the current
ftrace_regs_caller that kprobes and live kernel patching use.

The improvement was quite noticeable.

Baseline: (no tracing)

# perf stat -r 20 /work/c/hackbench 50
Time: 1.146
Time: 1.120
Time: 1.102
Time: 1.099
Time: 1.136
Time: 1.123
Time: 1.128
Time: 1.115
Time: 1.111
Time: 1.192
Time: 1.160
Time: 1.156
Time: 1.135
Time: 1.144
Time: 1.150
Time: 1.120
Time: 1.121
Time: 1.120
Time: 1.106
Time: 1.127

 Performance counter stats for '/work/c/hackbench 50' (20 runs):

          9,056.18 msec task-clock                #    6.770 CPUs utilized            ( +-  0.26% )
           148,461      context-switches          #    0.016 M/sec                    ( +-  2.58% )
            18,397      cpu-migrations            #    0.002 M/sec                    ( +-  3.24% )
            54,029      page-faults               #    0.006 M/sec                    ( +-  0.63% )
    33,227,808,738      cycles                    #    3.669 GHz                      ( +-  0.25% )
    23,314,273,335      stalled-cycles-frontend   #   70.16% frontend cycles idle     ( +-  0.25% )
    23,568,794,330      instructions              #    0.71  insn per cycle         
                                                  #    0.99  stalled cycles per insn  ( +-  0.26% )
     3,756,521,438      branches                  #  414.802 M/sec                    ( +-  0.29% )
        36,949,690      branch-misses             #    0.98% of all branches          ( +-  0.46% )

            1.3377 +- 0.0213 seconds time elapsed  ( +-  1.59% )

Using IPMODIFY without regs:

# perf stat -r 20 /work/c/hackbench 50
Time: 1.193
Time: 1.115
Time: 1.145
Time: 1.129
Time: 1.121
Time: 1.132
Time: 1.136
Time: 1.156
Time: 1.133
Time: 1.131
Time: 1.138
Time: 1.150
Time: 1.147
Time: 1.137
Time: 1.178
Time: 1.121
Time: 1.142
Time: 1.158
Time: 1.143
Time: 1.168

 Performance counter stats for '/work/c/hackbench 50' (20 runs):

          9,231.39 msec task-clock                #    6.917 CPUs utilized            ( +-  0.39% )
           136,822      context-switches          #    0.015 M/sec                    ( +-  3.06% )
            17,308      cpu-migrations            #    0.002 M/sec                    ( +-  2.61% )
            54,521      page-faults               #    0.006 M/sec                    ( +-  0.57% )
    33,875,937,399      cycles                    #    3.670 GHz                      ( +-  0.39% )
    23,575,136,580      stalled-cycles-frontend   #   69.59% frontend cycles idle     ( +-  0.41% )
    24,246,404,007      instructions              #    0.72  insn per cycle         
                                                  #    0.97  stalled cycles per insn  ( +-  0.33% )
     3,878,453,510      branches                  #  420.138 M/sec                    ( +-  0.36% )
        47,653,911      branch-misses             #    1.23% of all branches          ( +-  0.43% )

           1.33462 +- 0.00440 seconds time elapsed  ( +-  0.33% )


The current ftrace_regs_caller: (old way of doing it)

# perf stat -r 20 /work/c/hackbench 50
Time: 1.114
Time: 1.153
Time: 1.236
Time: 1.208
Time: 1.179
Time: 1.183
Time: 1.217
Time: 1.190
Time: 1.157
Time: 1.172
Time: 1.215
Time: 1.165
Time: 1.171
Time: 1.188
Time: 1.176
Time: 1.217
Time: 1.341
Time: 1.238
Time: 1.363
Time: 1.287

 Performance counter stats for '/work/c/hackbench 50' (20 runs):

          9,522.76 msec task-clock                #    6.653 CPUs utilized            ( +-  0.36% )
           131,347      context-switches          #    0.014 M/sec                    ( +-  3.37% )
            17,090      cpu-migrations            #    0.002 M/sec                    ( +-  3.56% )
            54,126      page-faults               #    0.006 M/sec                    ( +-  0.71% )
    34,942,273,861      cycles                    #    3.669 GHz                      ( +-  0.35% )
    24,517,757,272      stalled-cycles-frontend   #   70.17% frontend cycles idle     ( +-  0.35% )
    24,684,124,265      instructions              #    0.71  insn per cycle         
                                                  #    0.99  stalled cycles per insn  ( +-  0.34% )
     3,859,734,617      branches                  #  405.317 M/sec                    ( +-  0.38% )
        47,286,857      branch-misses             #    1.23% of all branches          ( +-  0.70% )

            1.4313 +- 0.0244 seconds time elapsed  ( +-  1.70% )


In summary we have:

Baseline: (no tracing)

    33,227,808,738      cycles                    #    3.669 GHz                      ( +-  0.25% )
            1.3377 +- 0.0213 seconds time elapsed  ( +-  1.59% )

Just ip modification:

    33,875,937,399      cycles                    #    3.670 GHz                      ( +-  0.39% )
           1.33462 +- 0.00440 seconds time elapsed  ( +-  0.33% )

Full regs as done today:

    34,942,273,861      cycles                    #    3.669 GHz                      ( +-  0.35% )
            1.4313 +- 0.0244 seconds time elapsed  ( +-  1.70% )


Note, the hijack function is done very naively, the function trampoline
is called twice.

  do_raw_spin_lock()
    call ftrace_ip_caller
      call my_highjack_func
        test pip (true)
        call my_do_spin_lock()
          call do_raw_spin_lock()
            call ftrace_ip_caller
              call my_highjack_func
                test pip (false)

We could work on ways to not do this double call, but I just wanted to
get some kind of test case out.

This method could at least help with live kernel patching.

Attached is the patch I used. To switch back to full regs, just
remove the comma and uncomment the SAVE_REGS flag in the
trace-events-samples.c file.

-- Steve

--MP_/8W=AiJJlYQ.Y5+44aa7oTpl
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=test.patch

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d6e1faa28c58..6adaf18b3365 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -158,6 +158,7 @@ config X86
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
+	select HAVE_DYNAMIC_FTRACE_WITH_IPMODIFY
 	select HAVE_EBPF_JIT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_EISA
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 024c3053dbba..009b60426926 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -283,6 +283,12 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 		ret = update_ftrace_func(ip, new);
 	}
 
+	if (!ret) {
+		ip = (unsigned long)(&ftrace_ip_call);
+		new = ftrace_call_replace(ip, (unsigned long)func);
+		ret = update_ftrace_func(ip, new);
+	}
+
 	return ret;
 }
 
@@ -715,9 +721,12 @@ static inline void tramp_free(void *tramp) { }
 
 /* Defined as markers to the end of the ftrace default trampolines */
 extern void ftrace_regs_caller_end(void);
+extern void ftrace_ip_caller_end(void);
 extern void ftrace_epilogue(void);
 extern void ftrace_caller_op_ptr(void);
 extern void ftrace_regs_caller_op_ptr(void);
+extern void ftrace_ip_caller_op_ptr(void);
+extern void ftrace_caller_op_ptr(void);
 
 /* movq function_trace_op(%rip), %rdx */
 /* 0x48 0x8b 0x15 <offset-to-ftrace_trace_op (4 bytes)> */
@@ -763,6 +772,10 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 		start_offset = (unsigned long)ftrace_regs_caller;
 		end_offset = (unsigned long)ftrace_regs_caller_end;
 		op_offset = (unsigned long)ftrace_regs_caller_op_ptr;
+	} else if (ops->flags & FTRACE_OPS_FL_IPMODIFY) {
+		start_offset = (unsigned long)ftrace_ip_caller;
+		end_offset = (unsigned long)ftrace_ip_caller_end;
+		op_offset = (unsigned long)ftrace_ip_caller_op_ptr;
 	} else {
 		start_offset = (unsigned long)ftrace_caller;
 		end_offset = (unsigned long)ftrace_epilogue;
@@ -771,6 +784,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 
 	size = end_offset - start_offset;
 
+	printk("create tramploine to %pS\n", (void *)start_offset);
 	/*
 	 * Allocate enough size to store the ftrace_caller code,
 	 * the iret , as well as the address of the ftrace_ops this
@@ -840,14 +854,17 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	return 0;
 }
 
-static unsigned long calc_trampoline_call_offset(bool save_regs)
+static unsigned long calc_trampoline_call_offset(int flags)
 {
 	unsigned long start_offset;
 	unsigned long call_offset;
 
-	if (save_regs) {
+	if (flags & FTRACE_OPS_FL_SAVE_REGS) {
 		start_offset = (unsigned long)ftrace_regs_caller;
 		call_offset = (unsigned long)ftrace_regs_call;
+	} else if (flags & FTRACE_OPS_FL_IPMODIFY) {
+		start_offset = (unsigned long)ftrace_ip_caller;
+		call_offset = (unsigned long)ftrace_ip_call;
 	} else {
 		start_offset = (unsigned long)ftrace_caller;
 		call_offset = (unsigned long)ftrace_call;
@@ -882,7 +899,7 @@ void arch_ftrace_update_trampoline(struct ftrace_ops *ops)
 		npages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	}
 
-	offset = calc_trampoline_call_offset(ops->flags & FTRACE_OPS_FL_SAVE_REGS);
+	offset = calc_trampoline_call_offset(ops->flags);
 	ip = ops->trampoline + offset;
 
 	func = ftrace_ops_get_func(ops);
@@ -927,7 +944,6 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
 static void *static_tramp_func(struct ftrace_ops *ops, struct dyn_ftrace *rec)
 {
 	unsigned long offset;
-	bool save_regs = rec->flags & FTRACE_FL_REGS_EN;
 	void *ptr;
 
 	if (ops && ops->trampoline) {
@@ -942,10 +958,12 @@ static void *static_tramp_func(struct ftrace_ops *ops, struct dyn_ftrace *rec)
 		return NULL;
 	}
 
-	offset = calc_trampoline_call_offset(save_regs);
+	offset = calc_trampoline_call_offset(rec->flags);
 
-	if (save_regs)
+	if (rec->flags & FTRACE_FL_REGS_EN)
 		ptr = (void *)FTRACE_REGS_ADDR + offset;
+	else if (rec->flags & FTRACE_FL_IP_EN)
+		ptr = (void *)FTRACE_IP_ADDR + offset;
 	else
 		ptr = (void *)FTRACE_ADDR + offset;
 
@@ -960,7 +978,7 @@ void *arch_ftrace_trampoline_func(struct ftrace_ops *ops, struct dyn_ftrace *rec
 	if (!ops || !(ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP))
 		return static_tramp_func(ops, rec);
 
-	offset = calc_trampoline_call_offset(ops->flags & FTRACE_OPS_FL_SAVE_REGS);
+	offset = calc_trampoline_call_offset(ops->flags);
 	return addr_from_call((void *)ops->trampoline + offset);
 }
 
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 809d54397dba..5930810bf71d 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -172,6 +172,39 @@ WEAK(ftrace_stub)
 	retq
 ENDPROC(ftrace_caller)
 
+
+ENTRY(ftrace_ip_caller)
+	save_mcount_regs
+	/* save_mcount_regs fills in first two parameters */
+
+GLOBAL(ftrace_ip_caller_op_ptr)
+	/* Load the ftrace_ops into the 3rd parameter */
+	movq function_trace_op(%rip), %rdx
+
+	/* regs go into 4th parameter */
+	leaq (%rsp), %rcx
+
+GLOBAL(ftrace_ip_call)
+	call ftrace_stub
+
+	/* Handlers can change the RIP */
+	movq RIP(%rsp), %rax
+	movq %rax, MCOUNT_REG_SIZE(%rsp)
+
+	restore_mcount_regs
+
+	/*
+	 * As this jmp to ftrace_epilogue can be a short jump
+	 * it must not be copied into the trampoline.
+	 * The trampoline will add the code to jump
+	 * to the return.
+	 */
+GLOBAL(ftrace_ip_caller_end)
+
+	jmp ftrace_epilogue
+
+ENDPROC(ftrace_ip_caller)
+
 ENTRY(ftrace_regs_caller)
 	/* Save the current flags before any operations that can change them */
 	pushfq
@@ -214,7 +247,7 @@ GLOBAL(ftrace_regs_call)
 
 	/* Copy flags back to SS, to restore them */
 	movq EFLAGS(%rsp), %rax
-	movq %rax, MCOUNT_REG_SIZE(%rsp)
+	movq %rax, MCOUNT_REG_SIZE+8(%rsp)
 
 	/* Handlers can change the RIP */
 	movq RIP(%rsp), %rax
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 8385cafe4f9f..ba1cf5640639 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -333,6 +333,8 @@ bool is_ftrace_trampoline(unsigned long addr);
  *  REGS_EN - the function is set up to save regs.
  *  IPMODIFY - the record allows for the IP address to be changed.
  *  DISABLED - the record is not ready to be touched yet
+ *  IP       - the record wants ip modification only (no regs)
+ *  IP_EN    - the record has ip modification only
  *
  * When a new ftrace_ops is registered and wants a function to save
  * pt_regs, the rec->flag REGS is set. When the function has been
@@ -348,10 +350,12 @@ enum {
 	FTRACE_FL_TRAMP_EN	= (1UL << 27),
 	FTRACE_FL_IPMODIFY	= (1UL << 26),
 	FTRACE_FL_DISABLED	= (1UL << 25),
+	FTRACE_FL_IP		= (1UL << 24),
+	FTRACE_FL_IP_EN		= (1UL << 23),
 };
 
-#define FTRACE_REF_MAX_SHIFT	25
-#define FTRACE_FL_BITS		7
+#define FTRACE_REF_MAX_SHIFT	23
+#define FTRACE_FL_BITS		9
 #define FTRACE_FL_MASKED_BITS	((1UL << FTRACE_FL_BITS) - 1)
 #define FTRACE_FL_MASK		(FTRACE_FL_MASKED_BITS << FTRACE_REF_MAX_SHIFT)
 #define FTRACE_REF_MAX		((1UL << FTRACE_REF_MAX_SHIFT) - 1)
@@ -458,8 +462,10 @@ extern void ftrace_replace_code(int enable);
 extern int ftrace_update_ftrace_func(ftrace_func_t func);
 extern void ftrace_caller(void);
 extern void ftrace_regs_caller(void);
+extern void ftrace_ip_caller(void);
 extern void ftrace_call(void);
 extern void ftrace_regs_call(void);
+extern void ftrace_ip_call(void);
 extern void mcount_call(void);
 
 void ftrace_modify_all_code(int command);
@@ -475,8 +481,14 @@ void ftrace_modify_all_code(int command);
 #ifndef FTRACE_REGS_ADDR
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 # define FTRACE_REGS_ADDR ((unsigned long)ftrace_regs_caller)
+# ifdef CONFIG_DYNAMIC_FTRACE_WITH_IPMODIFY_ONLY
+#  define FTRACE_IP_ADDR ((unsigned long)ftrace_ip_caller)
+# else
+#  define FTRACE_IP_ADDR FTRACE_REGS_ADDR
+# endif
 #else
 # define FTRACE_REGS_ADDR FTRACE_ADDR
+# define FTRACE_IP_ADDR FTRACE_ADDR
 #endif
 #endif
 
diff --git a/kernel/locking/spinlock_debug.c b/kernel/locking/spinlock_debug.c
index 399669f7eba8..c2037587dc95 100644
--- a/kernel/locking/spinlock_debug.c
+++ b/kernel/locking/spinlock_debug.c
@@ -114,6 +114,7 @@ void do_raw_spin_lock(raw_spinlock_t *lock)
 	mmiowb_spin_lock();
 	debug_spin_lock_after(lock);
 }
+EXPORT_SYMBOL_GPL(do_raw_spin_lock);
 
 int do_raw_spin_trylock(raw_spinlock_t *lock)
 {
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 2a58380ea310..a1b88b810b8a 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -33,6 +33,9 @@ config HAVE_DYNAMIC_FTRACE
 config HAVE_DYNAMIC_FTRACE_WITH_REGS
 	bool
 
+config HAVE_DYNAMIC_FTRACE_WITH_IPMODIFY
+	bool
+
 config HAVE_FTRACE_MCOUNT_RECORD
 	bool
 	help
@@ -557,6 +560,11 @@ config DYNAMIC_FTRACE_WITH_REGS
 	depends on DYNAMIC_FTRACE
 	depends on HAVE_DYNAMIC_FTRACE_WITH_REGS
 
+config DYNAMIC_FTRACE_WITH_IPMODIFY_ONLY
+	def_bool y
+	depends on DYNAMIC_FTRACE
+	depends on HAVE_DYNAMIC_FTRACE_WITH_IPMODIFY
+
 config FUNCTION_PROFILER
 	bool "Kernel function profiler"
 	depends on FUNCTION_TRACER
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index dacb8b50a263..fec64bf679e8 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -326,6 +326,13 @@ int __register_ftrace_function(struct ftrace_ops *ops)
 	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS_IF_SUPPORTED)
 		ops->flags |= FTRACE_OPS_FL_SAVE_REGS;
 #endif
+
+#ifndef CONFIG_DYNAMIC_FTRACE_WITH_IPMODIFY_ONLY
+	if (ops->flags & FTRACE_OPS_FL_IPMODIFY &&
+	    !(ops->flags & FTRACE_OPS_FL_SAVE_REGS))
+		return -EINVAL;
+#endif
+
 	if (!ftrace_enabled && (ops->flags & FTRACE_OPS_FL_PERMANENT))
 		return -EBUSY;
 
@@ -1625,6 +1632,26 @@ static bool test_rec_ops_needs_regs(struct dyn_ftrace *rec)
 	return  keep_regs;
 }
 
+/* Test if ops registered to this rec needs ip only */
+static bool test_rec_ops_needs_ipmod(struct dyn_ftrace *rec)
+{
+	struct ftrace_ops *ops;
+	bool keep_ip = false;
+
+	for (ops = ftrace_ops_list;
+	     ops != &ftrace_list_end; ops = ops->next) {
+		/* pass rec in as regs to have non-NULL val */
+		if (ftrace_ops_test(ops, rec->ip, rec)) {
+			if (ops->flags & FTRACE_OPS_FL_IPMODIFY) {
+				keep_ip = true;
+				break;
+			}
+		}
+	}
+
+	return  keep_ip;
+}
+
 static struct ftrace_ops *
 ftrace_find_tramp_ops_any(struct dyn_ftrace *rec);
 static struct ftrace_ops *
@@ -1737,8 +1764,20 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
 			 * If any ops wants regs saved for this function
 			 * then all ops will get saved regs.
 			 */
-			if (ops->flags & FTRACE_OPS_FL_SAVE_REGS)
+			if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
 				rec->flags |= FTRACE_FL_REGS;
+				rec->flags &= ~FTRACE_FL_IP;
+			}
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_IPMODIFY_ONLY
+			/*
+			 * If any ops wants ip modification without regs
+			 * handle that case too.
+			 */
+			if (!(rec->flags & FTRACE_FL_REGS) &&
+			    ops->flags & FTRACE_OPS_FL_IPMODIFY)
+				rec->flags |= FTRACE_FL_IP;
+#endif
 		} else {
 			if (FTRACE_WARN_ON(ftrace_rec_count(rec) == 0))
 				return false;
@@ -1753,8 +1792,18 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
 			if (ftrace_rec_count(rec) > 0 &&
 			    rec->flags & FTRACE_FL_REGS &&
 			    ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
-				if (!test_rec_ops_needs_regs(rec))
+				if (!test_rec_ops_needs_regs(rec)) {
 					rec->flags &= ~FTRACE_FL_REGS;
+
+					/* Downgrade to just ipmodify? */
+					if (test_rec_ops_needs_ipmod(rec))
+						rec->flags |= FTRACE_FL_IP;
+
+			} else if (rec->flags & FTRACE_FL_REGS &&
+				   ops->flags & FTRACE_OPS_FL_IPMODIFY) {
+					if (!test_rec_ops_needs_ipmod(rec))
+						rec->flags &= ~FTRACE_FL_IP;
+				}
 			}
 
 			/*
@@ -2033,7 +2082,8 @@ void ftrace_bug(int failed, struct dyn_ftrace *rec)
 
 		pr_info("ftrace record flags: %lx\n", rec->flags);
 		pr_cont(" (%ld)%s", ftrace_rec_count(rec),
-			rec->flags & FTRACE_FL_REGS ? " R" : "  ");
+			rec->flags & FTRACE_FL_REGS ? " R" :
+			rec->flags & FTRACE_FL_IP ? " r" : "  ");
 		if (rec->flags & FTRACE_FL_TRAMP_EN) {
 			ops = ftrace_find_tramp_ops_any(rec);
 			if (ops) {
@@ -2085,6 +2135,10 @@ static int ftrace_check_record(struct dyn_ftrace *rec, bool enable, bool update)
 		    !(rec->flags & FTRACE_FL_REGS_EN))
 			flag |= FTRACE_FL_REGS;
 
+		if (!(rec->flags & FTRACE_FL_IP) != 
+		    !(rec->flags & FTRACE_FL_IP_EN))
+			flag |= FTRACE_FL_IP;
+
 		if (!(rec->flags & FTRACE_FL_TRAMP) != 
 		    !(rec->flags & FTRACE_FL_TRAMP_EN))
 			flag |= FTRACE_FL_TRAMP;
@@ -2112,6 +2166,12 @@ static int ftrace_check_record(struct dyn_ftrace *rec, bool enable, bool update)
 				else
 					rec->flags &= ~FTRACE_FL_TRAMP_EN;
 			}
+			if (flag & FTRACE_FL_IP) {
+				if (rec->flags & FTRACE_FL_REGS)
+					rec->flags |= FTRACE_FL_IP_EN;
+				else
+					rec->flags &= ~FTRACE_FL_IP_EN;
+			}
 		}
 
 		/*
@@ -2141,7 +2201,7 @@ static int ftrace_check_record(struct dyn_ftrace *rec, bool enable, bool update)
 			 * and REGS states. The _EN flags must be disabled though.
 			 */
 			rec->flags &= ~(FTRACE_FL_ENABLED | FTRACE_FL_TRAMP_EN |
-					FTRACE_FL_REGS_EN);
+					FTRACE_FL_REGS_EN | FTRACE_FL_IP_EN);
 	}
 
 	ftrace_bug_type = FTRACE_BUG_NOP;
@@ -2324,6 +2384,8 @@ unsigned long ftrace_get_addr_new(struct dyn_ftrace *rec)
 
 	if (rec->flags & FTRACE_FL_REGS)
 		return (unsigned long)FTRACE_REGS_ADDR;
+	else if (rec->flags & FTRACE_FL_IP)
+		return (unsigned long)FTRACE_IP_ADDR;
 	else
 		return (unsigned long)FTRACE_ADDR;
 }
@@ -2356,6 +2418,8 @@ unsigned long ftrace_get_addr_curr(struct dyn_ftrace *rec)
 
 	if (rec->flags & FTRACE_FL_REGS_EN)
 		return (unsigned long)FTRACE_REGS_ADDR;
+	else if (rec->flags & FTRACE_FL_IP_EN)
+		return (unsigned long)FTRACE_IP_ADDR;
 	else
 		return (unsigned long)FTRACE_ADDR;
 }
@@ -3462,7 +3526,7 @@ static int t_show(struct seq_file *m, void *v)
 		seq_printf(m, " (%ld)%s%s",
 			   ftrace_rec_count(rec),
 			   rec->flags & FTRACE_FL_REGS ? " R" : "  ",
-			   rec->flags & FTRACE_FL_IPMODIFY ? " I" : "  ");
+			   rec->flags & FTRACE_FL_IP ? " I" : "  ");
 		if (rec->flags & FTRACE_FL_TRAMP_EN) {
 			ops = ftrace_find_tramp_ops_any(rec);
 			if (ops) {
diff --git a/samples/trace_events/trace-events-sample.c b/samples/trace_events/trace-events-sample.c
index 1a72b7d95cdc..e87d9decb994 100644
--- a/samples/trace_events/trace-events-sample.c
+++ b/samples/trace_events/trace-events-sample.c
@@ -11,6 +11,41 @@
 #define CREATE_TRACE_POINTS
 #include "trace-events-sample.h"
 
+#include <linux/ftrace.h>
+
+void do_raw_spin_lock(raw_spinlock_t *lock);
+
+int x;
+
+static void my_do_spin_lock(raw_spinlock_t *lock)
+{
+	int ret;
+
+//	trace_printk("takeing %p\n", lock);
+	do_raw_spin_lock(lock);
+	/* Force not having a tail call */
+	if (!x)
+		return;
+	x++;
+}
+
+static void my_hijack_func(unsigned long ip, unsigned long pip,
+			   struct ftrace_ops *ops, struct pt_regs *regs)
+{
+	unsigned long this_func = (unsigned long)my_do_spin_lock;
+
+	if (pip >= this_func && pip <= this_func + 0x10000)
+		return;
+
+	regs->ip = this_func;
+}
+
+static struct ftrace_ops my_ops = {
+	.func = my_hijack_func,
+	.flags = FTRACE_OPS_FL_IPMODIFY | FTRACE_OPS_FL_RECURSION_SAFE,
+//					  | FTRACE_OPS_FL_SAVE_REGS,
+};
+
 static const char *random_strings[] = {
 	"Mother Goose",
 	"Snoopy",
@@ -115,6 +150,13 @@ void foo_bar_unreg(void)
 
 static int __init trace_event_init(void)
 {
+	int ret;
+
+	ret = ftrace_set_filter_ip(&my_ops, (unsigned long)do_raw_spin_lock, 0, 0);
+	if (!ret)
+		register_ftrace_function(&my_ops);
+
+	return 0;
 	simple_tsk = kthread_run(simple_thread, NULL, "event-sample");
 	if (IS_ERR(simple_tsk))
 		return -1;
@@ -124,6 +166,8 @@ static int __init trace_event_init(void)
 
 static void __exit trace_event_exit(void)
 {
+	unregister_ftrace_function(&my_ops);
+	return;
 	kthread_stop(simple_tsk);
 	mutex_lock(&thread_mutex);
 	if (simple_tsk_fn)

--MP_/8W=AiJJlYQ.Y5+44aa7oTpl--
