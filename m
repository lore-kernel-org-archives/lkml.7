Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A112C47419
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043B522516
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 15:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="mcNkhykI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfKMPmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 10:42:36 -0500
Received: from mail.efficios.com ([167.114.142.138]:42688 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfKMPmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 10:42:35 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 7E28F41B83A;
        Wed, 13 Nov 2019 10:42:33 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id K58JuUnuzxZg; Wed, 13 Nov 2019 10:42:32 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D95AD41B837;
        Wed, 13 Nov 2019 10:42:32 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D95AD41B837
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1573659752;
        bh=FhDyoaSamwOoit6AZp13rM1I9YEN7KFqbITeNrPBKRs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=mcNkhykIJaAqzMqqqCvDGEFJkNDx/zwMqYny8VKFjabvRBFMvnSGfXoH6vWOwUDvQ
         AmyhIpaPqtQrVlx4qS7L9QAhq6J5NgcwaFmexKu1S7l5cp4ld30l75CtcnJgou/+FD
         zkakI7xPXFkdTUsaOcCl1JOEKxZrbKPyF5jX2hdj4nLlxsQ+g0JCAjP7UZIA8qD2UT
         YlIq15GLLWNWj1loxjNPdDyatTIXVE1gMWTbubRXewVexItlNdSHdIGOwkBvN327h2
         cShmok9/InUyyM1YA3G8pqCNDE5fGq221YNlW4yOJYRplgx4pFR7K2tgOZV+gffOwJ
         ItRdZfdUwKxAg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id ELZuxbM9r3uJ; Wed, 13 Nov 2019 10:42:32 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id BAC4041B81E;
        Wed, 13 Nov 2019 10:42:32 -0500 (EST)
Date:   Wed, 13 Nov 2019 10:42:32 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
        rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        bristot <bristot@redhat.com>, jbaron@akamai.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        paulmck <paulmck@kernel.org>
Message-ID: <394483573.90.1573659752560.JavaMail.zimbra@efficios.com>
In-Reply-To: <20191111132458.162172862@infradead.org>
References: <20191111131252.921588318@infradead.org> <20191111132458.162172862@infradead.org>
Subject: Re: [PATCH -v5 12/17] x86/kprobes: Fix ordering
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3888 (ZimbraWebClient - FF70 (Linux)/8.8.15_GA_3869)
Thread-Topic: x86/kprobes: Fix ordering
Thread-Index: dqf0tEXpjeJ/FwQ1gL/HsGrGYF9OnQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Nov 11, 2019, at 8:13 AM, Peter Zijlstra peterz@infradead.org wrote:

> Kprobes does something like:
> 
> register:
>	arch_arm_kprobe()
>	  text_poke(INT3)
>          /* guarantees nothing, INT3 will become visible at some point, maybe */
> 
>        kprobe_optimizer()
>	  /* guarantees the bytes after INT3 are unused */
>	  syncrhonize_rcu_tasks();

syncrhonize -> synchronize

>	  text_poke_bp(JMP32);
>	  /* implies IPI-sync, kprobe really is enabled */
> 
> 
> unregister:
>	__disarm_kprobe()
>	  unoptimize_kprobe()
>	    text_poke_bp(INT3 + tail);
>	    /* implies IPI-sync, so tail is guaranteed visible */
>          arch_disarm_kprobe()
>            text_poke(old);
>	    /* guarantees nothing, old will maybe become visible */
> 
>	synchronize_rcu()
> 
>        free-stuff
> 
> Now the problem is that on register, the synchronize_rcu_tasks() does
> not imply sufficient to guarantee all CPUs have already observed INT3
> (although in practise this is exceedingly unlikely not to have

practise -> practice

> happened) (similar to how MEMBARRIER_CMD_PRIVATE_EXPEDITED does not
> imply MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE).
> 
> Worse, even if it did, we'd have to do 2 synchronize calls to provide
> the guarantee we're looking for, the first to ensure INT3 is visible,
> the second to guarantee nobody is then still using the instruction
> bytes after INT3.

I'm not entirely convinced about this last statement though. AFAIU:

- Swapping between some instruction and INT3 is OK,
- Swapping back between that INT3 and _original_ instruction is OK,
- Anything else needs to have explicit core serialization.

So I understand the part about requiring the synchronize call to guarantee
that nobody is then still using the instruction bytes following INT3, but not
the rationale for the first synchronization. What operation would theoretically
follow this first synchronize call ?

I understand that this patch modifies arch_{arm,disarm}_kprobe to add
core serialization after inserting/removing the INT3 even in the case
where no optimized kprobes are used, which is heavier than what is
strictly required without optimized kprobes. I'm all fine for the added
simplicity that comes with making this slow-path even slower, but it
would be good to document this subtlety in the code.

Thanks,

Mathieu

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
> Cc: mathieu.desnoyers@efficios.com
> ---
> arch/x86/include/asm/text-patching.h |    1 +
> arch/x86/kernel/alternative.c        |   11 ++++++++---
> arch/x86/kernel/kprobes/core.c       |    2 ++
> arch/x86/kernel/kprobes/opt.c        |   12 ++++--------
> 4 files changed, 15 insertions(+), 11 deletions(-)
> 
> --- a/arch/x86/include/asm/text-patching.h
> +++ b/arch/x86/include/asm/text-patching.h
> @@ -42,6 +42,7 @@ extern void text_poke_early(void *addr,
>  * an inconsistent instruction while you patch.
>  */
> extern void *text_poke(void *addr, const void *opcode, size_t len);
> +extern void text_poke_sync(void);
> extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
> extern int poke_int3_handler(struct pt_regs *regs);
> extern void text_poke_bp(void *addr, const void *opcode, size_t len, const void
> *emulate);
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -936,6 +936,11 @@ static void do_sync_core(void *info)
> 	sync_core();
> }
> 
> +void text_poke_sync(void)
> +{
> +	on_each_cpu(do_sync_core, NULL, 1);
> +}
> +
> struct text_poke_loc {
> 	s32 rel_addr; /* addr := _stext + rel_addr */
> 	s32 rel32;
> @@ -1085,7 +1090,7 @@ static void text_poke_bp_batch(struct te
> 	for (i = 0; i < nr_entries; i++)
> 		text_poke(text_poke_addr(&tp[i]), &int3, sizeof(int3));
> 
> -	on_each_cpu(do_sync_core, NULL, 1);
> +	text_poke_sync();
> 
> 	/*
> 	 * Second step: update all but the first byte of the patched range.
> @@ -1107,7 +1112,7 @@ static void text_poke_bp_batch(struct te
> 		 * not necessary and we'd be safe even without it. But
> 		 * better safe than sorry (plus there's not only Intel).
> 		 */
> -		on_each_cpu(do_sync_core, NULL, 1);
> +		text_poke_sync();
> 	}
> 
> 	/*
> @@ -1123,7 +1128,7 @@ static void text_poke_bp_batch(struct te
> 	}
> 
> 	if (do_sync)
> -		on_each_cpu(do_sync_core, NULL, 1);
> +		text_poke_sync();
> 
> 	/*
> 	 * sync_core() implies an smp_mb() and orders this store against
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -502,11 +502,13 @@ int arch_prepare_kprobe(struct kprobe *p
> void arch_arm_kprobe(struct kprobe *p)
> {
> 	text_poke(p->addr, ((unsigned char []){INT3_INSN_OPCODE}), 1);
> +	text_poke_sync();
> }
> 
> void arch_disarm_kprobe(struct kprobe *p)
> {
> 	text_poke(p->addr, &p->opcode, 1);
> +	text_poke_sync();
> }
> 
> void arch_remove_kprobe(struct kprobe *p)
> --- a/arch/x86/kernel/kprobes/opt.c
> +++ b/arch/x86/kernel/kprobes/opt.c
> @@ -444,14 +444,10 @@ void arch_optimize_kprobes(struct list_h
> /* Replace a relative jump with a breakpoint (int3).  */
> void arch_unoptimize_kprobe(struct optimized_kprobe *op)
> {
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
> }
> 
>  /*

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
