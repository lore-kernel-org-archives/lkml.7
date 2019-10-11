Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121BBECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C33206CD
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t3oc8qWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfJKKvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 06:51:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32844 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfJKKvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1DSgmq9rOYhjzebuDsQlC00oGl36gQOPXQEF36cqBOA=; b=t3oc8qWsA+ED2UeWVqU5ERq0t
        cnpnn+lF/rgtKJyQMd/QAfyG3QhwALfc6iu1+FY5NngMkLXExQK/r9WB8WxGz0oyvLH8Nts7cFfK7
        oqGF7YkMOczXrLyTeJJzRx3lcukZ8GjG+cT62OosEGXNd7qEzqH+qnejWwTRPEjtUyNBTNUrUnAa6
        5b66XzusuFS+QMQ69w6PnRzF/4vDXa6M5i+9G01Hnk9OHsptva6Hga9vPRvWVDXBXDGyq49qIz/ST
        eFmdtN9IrVNUSgs2GEAjQpdgkjxwwS2DaCzE60t6UzfQsDA+DwXK7j2aIpdiurmkDsjt79n0dA9/0
        27R/cG1cA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIsVW-00028N-MU; Fri, 11 Oct 2019 10:50:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BA505305E4E;
        Fri, 11 Oct 2019 12:49:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 609E9201DF214; Fri, 11 Oct 2019 12:50:48 +0200 (CEST)
Date:   Fri, 11 Oct 2019 12:50:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [PATCH v3 5/6] x86/ftrace: Use text_poke()
Message-ID: <20191011105048.GM2359@hirez.programming.kicks-ass.net>
References: <20191008104335.6fcd78c9@gandalf.local.home>
 <20191009224135.2dcf7767@oasis.local.home>
 <20191010092054.GR2311@hirez.programming.kicks-ass.net>
 <20191010091956.48fbcf42@gandalf.local.home>
 <20191010140513.GT2311@hirez.programming.kicks-ass.net>
 <20191010115449.22044b53@gandalf.local.home>
 <20191010172819.GS2328@hirez.programming.kicks-ass.net>
 <20191010134830.72ccef3d@gandalf.local.home>
 <20191011104552.GW2328@hirez.programming.kicks-ass.net>
 <20191011104712.GL2359@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011104712.GL2359@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 12:47:12PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 11, 2019 at 12:45:52PM +0200, Peter Zijlstra wrote:
> > +	if (!ops->trampoline) {
> > +		ops->trampoline = create_trampoline(ops, &size, ftrace_ops_get_func(ops));
> 
> And now that I look at what I send, I see we already pass ops, so no
> need to pass ftrace_ops_get_func().
> 
> Let me respin that.

---
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1209,10 +1209,15 @@ void text_poke_finish(void)
 	text_poke_flush(NULL);
 }
 
-void text_poke_queue(void *addr, const void *opcode, size_t len, const void *emulate)
+void __ref text_poke_queue(void *addr, const void *opcode, size_t len, const void *emulate)
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
 
@@ -313,6 +321,7 @@ create_trampoline(struct ftrace_ops *ops
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
@@ -389,6 +400,15 @@ create_trampoline(struct ftrace_ops *ops
 	/* put in the new offset to the ftrace_ops */
 	memcpy(trampoline + op_offset, &op_ptr, OP_REF_SIZE);
 
+	/* put in the call to the function */
+	mutex_lock(&text_mutex);
+	call_offset -= start_offset;
+	memcpy(trampoline + call_offset,
+	       text_gen_insn(CALL_INSN_OPCODE,
+			     trampoline + call_offset,
+			     ftrace_ops_get_func(ops)), CALL_INSN_SIZE);
+	mutex_unlock(&text_mutex);
+
 	/* ALLOC_TRAMP flags lets us know we created it */
 	ops->flags |= FTRACE_OPS_FL_ALLOC_TRAMP;
 
@@ -426,23 +446,23 @@ void arch_ftrace_update_trampoline(struc
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
+	if (!ops->trampoline) {
 		ops->trampoline = create_trampoline(ops, &size);
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
