Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD13CA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 01:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D072166E
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 01:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571708131;
	bh=o6+8wjkhGz7V5FRJAWa3awCJ4sRokrOP9rRUFRXKrxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=nkO1ktYlqZGiOx44zi4VqEc+BnbJF2jleWTpwn0QllECwZ65X3Ue0MaUe1LexyG1v
	 LliUTSnYSsd0xgK/O1Va4wBT0Q3g5WP2ufz+Jcfo4kvBMv9stsIHhAeJGwezmWlBZc
	 K6T0GAybUGw7u+hyFOgh89c3dwZ5fXL4yJdzWt80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387427AbfJVBfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 21:35:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbfJVBf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 21:35:29 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70A1E214B2;
        Tue, 22 Oct 2019 01:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571708128;
        bh=o6+8wjkhGz7V5FRJAWa3awCJ4sRokrOP9rRUFRXKrxM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n/sAz0FKI11FxlI/znzMiIyiaKFOcQUkucRccookJwldd5PYRwK19UttSuTIskL4h
         k999ez8ShCu+qF4ypEtLE7oA1JqQwSJnnTqEq3P9jMHqpysK6mfArhrxR8HMueSc+Y
         wG9Fydhvxen3z0iDPVfoL9mdwcU8JtPYt4MsgXn4=
Date:   Tue, 22 Oct 2019 10:35:21 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org,
        paulmck@kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v4 12/16] x86/kprobes: Fix ordering
Message-Id: <20191022103521.3015bc5e128cd68fa645013c@kernel.org>
In-Reply-To: <20191018074634.629386219@infradead.org>
References: <20191018073525.768931536@infradead.org>
        <20191018074634.629386219@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2019 09:35:37 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Kprobes does something like:
> 
> register:
> 	arch_arm_kprobe()
> 	  text_poke(INT3)
>           /* guarantees nothing, INT3 will become visible at some point, maybe */
> 
>         kprobe_optimizer()
> 	  /* guarantees the bytes after INT3 are unused */
> 	  syncrhonize_rcu_tasks();
> 	  text_poke_bp(JMP32);
> 	  /* implies IPI-sync, kprobe really is enabled */
> 
> 
> unregister:
> 	__disarm_kprobe()
> 	  unoptimize_kprobe()
> 	    text_poke_bp(INT3 + tail);
> 	    /* implies IPI-sync, so tail is guaranteed visible */
>           arch_disarm_kprobe()
>             text_poke(old);
> 	    /* guarantees nothing, old will maybe become visible */
> 
> 	synchronize_rcu()
> 
>         free-stuff

Note that this is only for the case of optimized kprobe.
(On some probe points we can not optimize it)

> 
> Now the problem is that on register, the synchronize_rcu_tasks() does
> not imply sufficient to guarantee all CPUs have already observed INT3
> (although in practise this is exceedingly unlikely not to have
> happened) (similar to how MEMBARRIER_CMD_PRIVATE_EXPEDITED does not
> imply MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE).

OK, so the sync_core() after int3 is needed to guarantee the probe
is enabled on each core.

> 
> Worse, even if it did, we'd have to do 2 synchronize calls to provide
> the guarantee we're looking for, the first to ensure INT3 is visible,
> the second to guarantee nobody is then still using the instruction
> bytes after INT3.

I think this 2nd guarantee is done by syncrhonize_rcu() if we
put sync_core() after int3. syncrhonize_rcu() ensures that
all cores once scheduled and all interrupts have done.

> 
> Similar on unregister; the synchronize_rcu() between
> __unregister_kprobe_top() and __unregister_kprobe_bottom() does not
> guarantee all CPUs are free of the INT3 (and observe the old text).

I agree with putting sync_core() after putting/removing INT3.

> 
> Therefore, sprinkle some IPI-sync love around. This guarantees that
> all CPUs agree on the text and RCU once again provides the required
> guaranteed.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: hpa@zytor.com
> Cc: paulmck@kernel.org
> Cc: mathieu.desnoyers@efficios.com
> ---
>  arch/x86/include/asm/text-patching.h |    1 +
>  arch/x86/kernel/alternative.c        |   11 ++++++++---
>  arch/x86/kernel/kprobes/core.c       |    2 ++
>  arch/x86/kernel/kprobes/opt.c        |   12 ++++--------
>  4 files changed, 15 insertions(+), 11 deletions(-)
> 
> --- a/arch/x86/include/asm/text-patching.h
> +++ b/arch/x86/include/asm/text-patching.h
> @@ -42,6 +42,7 @@ extern void text_poke_early(void *addr,
>   * an inconsistent instruction while you patch.
>   */
>  extern void *text_poke(void *addr, const void *opcode, size_t len);
> +extern void text_poke_sync(void);
>  extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
>  extern int poke_int3_handler(struct pt_regs *regs);
>  extern void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate);
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -936,6 +936,11 @@ static void do_sync_core(void *info)
>  	sync_core();
>  }
>  
> +void text_poke_sync(void)
> +{
> +	on_each_cpu(do_sync_core, NULL, 1);
> +}
> +
>  struct text_poke_loc {
>  	s32 rel_addr; /* addr := _stext + rel_addr */
>  	s32 rel32;
> @@ -1085,7 +1090,7 @@ static void text_poke_bp_batch(struct te
>  	for (i = 0; i < nr_entries; i++)
>  		text_poke(text_poke_addr(&tp[i]), &int3, sizeof(int3));
>  
> -	on_each_cpu(do_sync_core, NULL, 1);
> +	text_poke_sync();
>  
>  	/*
>  	 * Second step: update all but the first byte of the patched range.
> @@ -1107,7 +1112,7 @@ static void text_poke_bp_batch(struct te
>  		 * not necessary and we'd be safe even without it. But
>  		 * better safe than sorry (plus there's not only Intel).
>  		 */
> -		on_each_cpu(do_sync_core, NULL, 1);
> +		text_poke_sync();
>  	}
>  
>  	/*
> @@ -1123,7 +1128,7 @@ static void text_poke_bp_batch(struct te
>  	}
>  
>  	if (do_sync)
> -		on_each_cpu(do_sync_core, NULL, 1);
> +		text_poke_sync();
>  
>  	/*
>  	 * sync_core() implies an smp_mb() and orders this store against
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -502,11 +502,13 @@ int arch_prepare_kprobe(struct kprobe *p
>  void arch_arm_kprobe(struct kprobe *p)
>  {
>  	text_poke(p->addr, ((unsigned char []){INT3_INSN_OPCODE}), 1);
> +	text_poke_sync();
>  }
>  
>  void arch_disarm_kprobe(struct kprobe *p)
>  {
>  	text_poke(p->addr, &p->opcode, 1);
> +	text_poke_sync();
>  }

This looks good to me.

>  
>  void arch_remove_kprobe(struct kprobe *p)
> --- a/arch/x86/kernel/kprobes/opt.c
> +++ b/arch/x86/kernel/kprobes/opt.c
> @@ -444,14 +444,10 @@ void arch_optimize_kprobes(struct list_h
>  /* Replace a relative jump with a breakpoint (int3).  */
>  void arch_unoptimize_kprobe(struct optimized_kprobe *op)
>  {
> -	u8 insn_buff[JMP32_INSN_SIZE];
> -
> -	/* Set int3 to first byte for kprobes */
> -	insn_buff[0] = INT3_INSN_OPCODE;
> -	memcpy(insn_buff + 1, op->optinsn.copied_insn, DISP32_SIZE);
> -
> -	text_poke_bp(op->kp.addr, insn_buff, JMP32_INSN_SIZE,
> -		     text_gen_insn(JMP32_INSN_OPCODE, op->kp.addr, op->optinsn.insn));
> +	arch_arm_kprobe(&op->kp);
> +	text_poke(op->kp.addr + INT3_INSN_SIZE,
> +		  op->optinsn.copied_insn, DISP32_SIZE);
> +	text_poke_sync();
>  }

For this part, I thought it was same as what text_poke_bp() does.
But, indeed, this looks better (simpler & lighter) than using
text_poke_bp()...

So, in total, this looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>


Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
