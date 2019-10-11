Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E237BC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C8F206CD
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xE8LpI6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfJKKqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 06:46:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41702 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbfJKKqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6//5W1KVBTgFdY2EGRaIvYQjFpmynmW/1/5VeV5uNlU=; b=xE8LpI6KEf311SiQRKeDTTryh
        Cn4XPN+1kBAk5ZRadMN7p7mcT94qHxKV3RcQOEMxJO43iSepsbH4v+QcTU6Zj9hFIevBn0kuFr2lC
        JogLpDj9OBXXJdjXjL4Vw4+O3gkc9Z0SiD2MJl5SwDeVThKNBtSPDrDzbANeBO7fWOPQNP/A2Nv18
        Rwn0/xlLoGGSC9KHbyfyBBTymUnaS3coMO+9SlAa+uNzPjs6vRDkSFCLHndzX0j6J7yO1LajLONx0
        xSiBVmCXFmAJ/d/19Z6OYsTEubJCp5xno4LwfC6GVIlX5OCqmwW7tBrNwfKG1pmuslquRCaE/RSkr
        5IwmZfYYQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIsQn-0006dX-8q; Fri, 11 Oct 2019 10:45:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BEDFF301224;
        Fri, 11 Oct 2019 12:44:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 590F4201F7DBB; Fri, 11 Oct 2019 12:45:52 +0200 (CEST)
Date:   Fri, 11 Oct 2019 12:45:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [PATCH v3 5/6] x86/ftrace: Use text_poke()
Message-ID: <20191011104552.GW2328@hirez.programming.kicks-ass.net>
References: <20191007081716.07616230.8@infradead.org>
 <20191007081945.10951536.8@infradead.org>
 <20191008104335.6fcd78c9@gandalf.local.home>
 <20191009224135.2dcf7767@oasis.local.home>
 <20191010092054.GR2311@hirez.programming.kicks-ass.net>
 <20191010091956.48fbcf42@gandalf.local.home>
 <20191010140513.GT2311@hirez.programming.kicks-ass.net>
 <20191010115449.22044b53@gandalf.local.home>
 <20191010172819.GS2328@hirez.programming.kicks-ass.net>
 <20191010134830.72ccef3d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010134830.72ccef3d@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 01:48:30PM -0400, Steven Rostedt wrote:
> On Thu, 10 Oct 2019 19:28:19 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > That is, I really hate the above "set_ro" hack. This is because you
> > > moved the ro setting to create_trampoline() and then forcing the
> > > text_poke() on text that has just been created. I prefer to just modify
> > > it and then setting it to ro before it gets executed. Otherwise we need
> > > to do all these dances.  
> > 
> > I thought create_trampoline() finished the whole thing; if it does not,
> > either make create_trampoline() do everything, or add a
> > finish_trampoline() callback to mark it complete.
> 
> I'm good with a finish_trampoline(). I can make a patch that does that.

I found it easier to just make create_trampoline do it all. The below
patch seems to cure both issues for me.

---
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1213,6 +1213,11 @@ void text_poke_queue(void *addr, const v
 {
 	struct text_poke_loc *tp;
 
+	if (unlikely(system_state == SYSTEM_BOOTING)) {
+		text_poke_early(addr, opcode, len);
+		return;
+	}
+
 	text_poke_flush(addr);
 
 	tp = &tp_vec[tp_vec_nr++];
@@ -1230,10 +1235,15 @@ void text_poke_queue(void *addr, const v
  * dynamically allocated memory. This function should be used when it is
  * not possible to allocate memory.
  */
-void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate)
+void __ref text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate)
 {
 	struct text_poke_loc tp;
 
+	if (unlikely(system_state == SYSTEM_BOOTING)) {
+		text_poke_early(addr, opcode, len);
+		return;
+	}
+
 	text_poke_loc_init(&tp, addr, opcode, len, emulate);
 	text_poke_bp_batch(&tp, 1);
 }
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -34,6 +34,8 @@
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
+static int ftrace_poke_late = 0;
+
 int ftrace_arch_code_modify_prepare(void)
     __acquires(&text_mutex)
 {
@@ -43,12 +45,15 @@ int ftrace_arch_code_modify_prepare(void
 	 * ftrace has it set to "read/write".
 	 */
 	mutex_lock(&text_mutex);
+	ftrace_poke_late = 1;
 	return 0;
 }
 
 int ftrace_arch_code_modify_post_process(void)
     __releases(&text_mutex)
 {
+	text_poke_finish();
+	ftrace_poke_late = 0;
 	mutex_unlock(&text_mutex);
 	return 0;
 }
@@ -116,7 +121,10 @@ ftrace_modify_code_direct(unsigned long
 		return ret;
 
 	/* replace the text with the new text */
-	text_poke_early((void *)ip, new_code, MCOUNT_INSN_SIZE);
+	if (ftrace_poke_late)
+		text_poke_queue((void *)ip, new_code, MCOUNT_INSN_SIZE, NULL);
+	else
+		text_poke_early((void *)ip, new_code, MCOUNT_INSN_SIZE);
 	return 0;
 }
 
@@ -308,11 +316,12 @@ union ftrace_op_code_union {
 #define RET_SIZE		1
 
 static unsigned long
-create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
+create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size, ftrace_func_t func)
 {
 	unsigned long start_offset;
 	unsigned long end_offset;
 	unsigned long op_offset;
+	unsigned long call_offset;
 	unsigned long offset;
 	unsigned long npages;
 	unsigned long size;
@@ -329,10 +338,12 @@ create_trampoline(struct ftrace_ops *ops
 		start_offset = (unsigned long)ftrace_regs_caller;
 		end_offset = (unsigned long)ftrace_regs_caller_end;
 		op_offset = (unsigned long)ftrace_regs_caller_op_ptr;
+		call_offset = (unsigned long)ftrace_regs_call;
 	} else {
 		start_offset = (unsigned long)ftrace_caller;
 		end_offset = (unsigned long)ftrace_epilogue;
 		op_offset = (unsigned long)ftrace_caller_op_ptr;
+		call_offset = (unsigned long)ftrace_call;
 	}
 
 	size = end_offset - start_offset;
@@ -389,6 +400,14 @@ create_trampoline(struct ftrace_ops *ops
 	/* put in the new offset to the ftrace_ops */
 	memcpy(trampoline + op_offset, &op_ptr, OP_REF_SIZE);
 
+	/* put in the call to the function */
+	mutex_lock(&text_mutex);
+	call_offset -= start_offset;
+	memcpy(trampoline + call_offset,
+			text_gen_insn(CALL_INSN_OPCODE, trampoline + call_offset, func),
+			CALL_INSN_SIZE);
+	mutex_unlock(&text_mutex);
+
 	/* ALLOC_TRAMP flags lets us know we created it */
 	ops->flags |= FTRACE_OPS_FL_ALLOC_TRAMP;
 
@@ -426,23 +445,23 @@ void arch_ftrace_update_trampoline(struc
 	unsigned int size;
 	const char *new;
 
-	if (ops->trampoline) {
-		/*
-		 * The ftrace_ops caller may set up its own trampoline.
-		 * In such a case, this code must not modify it.
-		 */
-		if (!(ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP))
-			return;
-	} else {
-		ops->trampoline = create_trampoline(ops, &size);
+	if (!ops->trampoline) {
+		ops->trampoline = create_trampoline(ops, &size, ftrace_ops_get_func(ops));
 		if (!ops->trampoline)
 			return;
 		ops->trampoline_size = size;
+		return;
 	}
 
+	/*
+	 * The ftrace_ops caller may set up its own trampoline.
+	 * In such a case, this code must not modify it.
+	 */
+	if (!(ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP))
+		return;
+
 	offset = calc_trampoline_call_offset(ops->flags & FTRACE_OPS_FL_SAVE_REGS);
 	ip = ops->trampoline + offset;
-
 	func = ftrace_ops_get_func(ops);
 
 	mutex_lock(&text_mutex);
