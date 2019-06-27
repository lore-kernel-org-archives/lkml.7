Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4483CC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 167592086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561645150;
	bh=7l+G3OI0iTgTgknQe8KxTvPvTzZQhJrekFsGJa7hyYg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=EqvZUAcF5bA2ouUinRD0WCMT9q3gqI1lvzy4w6SEXoANJPmvco06U10s9BV7C5y9P
	 uIpbR+Je71l2iRWUexPug9E53urNLpnlW0vdbJysw7VT/GTNkJjz6DtNwOArXLcK+6
	 eimuIIHNEXz1qSrzSlDouJdOS1nlHiUqUTppBjSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfF0OTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 10:19:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfF0OTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 10:19:08 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E7C82085A;
        Thu, 27 Jun 2019 14:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561645147;
        bh=7l+G3OI0iTgTgknQe8KxTvPvTzZQhJrekFsGJa7hyYg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vuaBI8+RGyRA8VSmPV72RvBXWywSPtbT9Vo+BrkEqDUqYYOiMToYzu3B05OxLgjSA
         A4k/L1zJOW1anoyAmsHn+oh686egYKzYMeia7AUFamQ18WFYuEMXkrtBOVRxub9nDe
         WznU6i9/a3Y5YxGxGbvPJ1vk9Vv+8tdN9KAlG+0I=
Date:   Thu, 27 Jun 2019 23:19:03 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 7/7] powerpc/kprobes: Allow probing on any ftrace
 address
Message-Id: <20190627231903.79166dc2647c475de245b37d@kernel.org>
In-Reply-To: <da4200e511f4863b153b0721f3913a75aa3bf80d.1561634177.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1561634177.git.naveen.n.rao@linux.vnet.ibm.com>
        <da4200e511f4863b153b0721f3913a75aa3bf80d.1561634177.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2019 16:53:55 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> With KPROBES_ON_FTRACE, kprobe is allowed to be inserted on instructions
> that branch to _mcount (referred to as ftrace location). With
> -mprofile-kernel, we now include the preceding 'mflr r0' as being part
> of the ftrace location.
> 
> However, by default, probing on an instruction that is not actually the
> branch to _mcount() is prohibited, as that is considered to not be at an
> instruction boundary. This is not the case on powerpc, so allow the same
> by overriding arch_check_ftrace_location()
> 
> In addition, we update kprobe_ftrace_handler() to detect this scenarios
> and to pass the proper nip to the pre and post probe handlers.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> ---
>  arch/powerpc/kernel/kprobes-ftrace.c | 32 +++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/kprobes-ftrace.c b/arch/powerpc/kernel/kprobes-ftrace.c
> index 972cb28174b2..23c840748183 100644
> --- a/arch/powerpc/kernel/kprobes-ftrace.c
> +++ b/arch/powerpc/kernel/kprobes-ftrace.c
> @@ -12,15 +12,35 @@
>  #include <linux/preempt.h>
>  #include <linux/ftrace.h>
>  
> +/*
> + * With -mprofile-kernel, we patch two instructions -- the branch to _mcount
> + * as well as the preceding 'mflr r0'. Both these instructions are claimed
> + * by ftrace and we should allow probing on either instruction.
> + */
> +int arch_check_ftrace_location(struct kprobe *p)
> +{
> +	if (ftrace_location((unsigned long)p->addr))
> +		p->flags |= KPROBE_FLAG_FTRACE;
> +	return 0;
> +}
> +
>  /* Ftrace callback handler for kprobes */
>  void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
>  			   struct ftrace_ops *ops, struct pt_regs *regs)
>  {
>  	struct kprobe *p;
> +	int mflr_kprobe = 0;
>  	struct kprobe_ctlblk *kcb;
>  
>  	p = get_kprobe((kprobe_opcode_t *)nip);
> -	if (unlikely(!p) || kprobe_disabled(p))
> +	if (!p) {
> +		p = get_kprobe((kprobe_opcode_t *)(nip - MCOUNT_INSN_SIZE));
> +		if (unlikely(!p))
> +			return;
> +		mflr_kprobe = 1;
> +	}
> +
> +	if (kprobe_disabled(p))
>  		return;
>  
>  	kcb = get_kprobe_ctlblk();
> @@ -33,6 +53,9 @@ void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
>  		 */
>  		regs->nip -= MCOUNT_INSN_SIZE;
>  
> +		if (mflr_kprobe)
> +			regs->nip -= MCOUNT_INSN_SIZE;
> +
>  		__this_cpu_write(current_kprobe, p);
>  		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
>  		if (!p->pre_handler || !p->pre_handler(p, regs)) {
> @@ -45,6 +68,8 @@ void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
>  				kcb->kprobe_status = KPROBE_HIT_SSDONE;
>  				p->post_handler(p, regs, 0);
>  			}
> +			if (mflr_kprobe)
> +				regs->nip += MCOUNT_INSN_SIZE;
>  		}
>  		/*
>  		 * If pre_handler returns !0, it changes regs->nip. We have to
> @@ -57,6 +82,11 @@ NOKPROBE_SYMBOL(kprobe_ftrace_handler);
>  
>  int arch_prepare_kprobe_ftrace(struct kprobe *p)
>  {
> +	if ((unsigned long)p->addr & 0x03) {
> +		pr_err("Attempt to register kprobe at an unaligned address\n");
> +		return -EILSEQ;
> +	}
> +
>  	p->ainsn.insn = NULL;
>  	p->ainsn.boostable = -1;
>  	return 0;
> -- 
> 2.22.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
