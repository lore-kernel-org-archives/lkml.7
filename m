Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4578EC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D52222469
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573655506;
	bh=sFAK/lXQzc1rSSIs573NkQjUMflCzZ8fJg39hw+x8RI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=g5CjDngTbNAFPbwBqLALWvM4Dsg/vs9Iu1v/MpzHaixfTwQjc3865PXK8boeWWGN+
	 fd6KH+wCF3SNcV3TxCf8MK/3pdLmB6Z4oZzHRElQNCHuPmMELj5IDp67XV6Sey6cuW
	 cohp4K1tIVbe320n3YbX/SNP1mbqAdqq1SlDtAYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfKMObp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 09:31:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:33440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbfKMObo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 09:31:44 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E458222CD;
        Wed, 13 Nov 2019 14:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573655503;
        bh=sFAK/lXQzc1rSSIs573NkQjUMflCzZ8fJg39hw+x8RI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Hl5LhmpQvx3OdbPBooPO2bt2Sh6yz62kDCRxeLduZ2tF7NbB77gICTOmIrEJhuzJK
         qgAcTNu9YTMKWn6isUhQe8OOrLruHTVWWtAE43M+++J8B1PS5n5bMmVm39LibM6VRi
         vj2rc4wVaENgi1n3wn/7fNk6b4UCtx+JpMHVkxXE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 09E5E35227FC; Wed, 13 Nov 2019 06:31:41 -0800 (PST)
Date:   Wed, 13 Nov 2019 06:31:41 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org,
        alexei.starovoitov@gmail.com, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH -v5 12/17] x86/kprobes: Fix ordering
Message-ID: <20191113143140.GD2865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191111131252.921588318@infradead.org>
 <20191111132458.162172862@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111132458.162172862@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 02:13:04PM +0100, Peter Zijlstra wrote:
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
> 
> Now the problem is that on register, the synchronize_rcu_tasks() does
> not imply sufficient to guarantee all CPUs have already observed INT3
> (although in practise this is exceedingly unlikely not to have
> happened) (similar to how MEMBARRIER_CMD_PRIVATE_EXPEDITED does not
> imply MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE).
> 
> Worse, even if it did, we'd have to do 2 synchronize calls to provide
> the guarantee we're looking for, the first to ensure INT3 is visible,
> the second to guarantee nobody is then still using the instruction
> bytes after INT3.
> 
> Similar on unregister; the synchronize_rcu() between
> __unregister_kprobe_top() and __unregister_kprobe_bottom() does not
> guarantee all CPUs are free of the INT3 (and observe the old text).
> 
> Therefore, sprinkle some IPI-sync love around. This guarantees that
> all CPUs agree on the text and RCU once again provides the required
> guaranteed.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: hpa@zytor.com
> Cc: paulmck@kernel.org

With a phrase like "IPI-sync love" in the commit log...  ;-)

Acked-by: Paul E. McKenney <paulmck@kernel.org>

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
>  
>  /*
> 
> 
