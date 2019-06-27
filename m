Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB1DC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74AD5208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfF0QNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 12:13:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbfF0QNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 12:13:47 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60B1A20659;
        Thu, 27 Jun 2019 16:13:46 +0000 (UTC)
Date:   Thu, 27 Jun 2019 12:13:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 4/7] powerpc/ftrace: Additionally nop out the
 preceding mflr with -mprofile-kernel
Message-ID: <20190627121344.25b5449a@gandalf.local.home>
In-Reply-To: <1561648598.uvetvkj39x.naveen@linux.ibm.com>
References: <cover.1561634177.git.naveen.n.rao@linux.vnet.ibm.com>
        <841386feda429a1f0d4b7442c3ede1ed91466f92.1561634177.git.naveen.n.rao@linux.vnet.ibm.com>
        <20190627110819.4892780f@gandalf.local.home>
        <1561648598.uvetvkj39x.naveen@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2019 20:58:20 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> 
> > But interesting, I don't see a synchronize_rcu_tasks() call
> > there.  
> 
> We felt we don't need it in this case. We patch the branch to ftrace 
> with a nop first. Other cpus should see that first. But, now that I 
> think about it, should we add a memory barrier to ensure the writes get 
> ordered properly?

Do you send an ipi to the other CPUs. I would just to be safe.

> >> -	if (patch_instruction((unsigned int *)ip, pop)) {
> >> +	/*
> >> +	 * Our original call site looks like:
> >> +	 *
> >> +	 * bl <tramp>
> >> +	 * ld r2,XX(r1)
> >> +	 *
> >> +	 * Milton Miller pointed out that we can not simply nop the branch.
> >> +	 * If a task was preempted when calling a trace function, the nops
> >> +	 * will remove the way to restore the TOC in r2 and the r2 TOC will
> >> +	 * get corrupted.
> >> +	 *
> >> +	 * Use a b +8 to jump over the load.
> >> +	 */
> >> +	if (patch_instruction((unsigned int *)ip, PPC_INST_BRANCH | 8)) {
> >>  		pr_err("Patching NOP failed.\n");
> >>  		return -EPERM;
> >>  	}
> >> +#endif /* CONFIG_MPROFILE_KERNEL */
> >>  
> >>  	return 0;
> >>  }
> >> @@ -421,6 +429,26 @@ static int __ftrace_make_nop_kernel(struct dyn_ftrace *rec, unsigned long addr)
> >>  		return -EPERM;
> >>  	}
> >>  
> >> +#ifdef CONFIG_MPROFILE_KERNEL  
> > 
> > I would think you need to break this up into two parts as well, with a
> > synchronize_rcu_tasks() in between.
> > 
> > Imagine this scenario:
> > 
> > 	<func>:
> > 	nop <-- interrupt comes here, and preempts the task
> > 	nop
> > 
> > First change.
> > 
> > 	<func>:
> > 	mflr	r0
> > 	nop
> > 
> > Second change.
> > 
> > 	<func>:
> > 	mflr	r0
> > 	bl	_mcount
> > 
> > Task returns from interrupt
> > 
> > 	<func>:
> > 	mflr	r0
> > 	bl	_mcount <-- executes here
> > 
> > It never did the mflr r0, because the last command that was executed
> > was a nop before it was interrupted. And yes, it can be interrupted
> > on a nop!  
> 
> We are handling this through ftrace_replace_code() and 
> __ftrace_make_call_prep() below. For FTRACE_UPDATE_MAKE_CALL, we patch 
> in the mflr, followed by smp_call_function(isync) and 
> synchronize_rcu_tasks() before we proceed to patch the branch to ftrace.
> 
> I don't see any other scenario where we end up in 
> __ftrace_make_nop_kernel() without going through ftrace_replace_code().  
> For kernel modules, this can happen during module load/init and so, I 
> patch out both instructions in __ftrace_make_call() above without any 
> synchronization.
> 
> Am I missing anything?
> 

No, I think I got confused ;-), it's the patch out that I was worried
about, but when I was going through the scenario, I somehow turned it
into the patching in (which I already audited :-p). I was going to
reply with just the top part of this email, but then the confusion
started :-/

OK, yes, patching out should be fine, and you already covered the
patching in. Sorry for the noise.

Just to confirm and totally remove the confusion, the patch does:

	<func>:
	mflr	r0 <-- preempt here
	bl	_mcount

	<func>:
	mflr	r0
	nop

And this is fine regardless.

OK, Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
