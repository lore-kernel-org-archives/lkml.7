Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44E5C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB83207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575996249;
	bh=MEGV/SVGM9k2aiXKfSeTNVtTgqpQIdxWrdYHmc0Kd7I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PXk69Pn1bwkQvu5oYyBqJVq9U1NFDrTztyR5RAjJkO2M4VNt0zk7qxwqyFckb3JsK
	 AQD75XZtA9HxDaJhyN8/9ea6ve8DYBR0LOnDSOOxA6rOjsq6ywXu/LnrvafPqaZ8QE
	 MWrrzJVB+QoLdLwzyfQhikofrqX1n2/IiO3nTmEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfLJQoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 11:44:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727553AbfLJQoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 11:44:08 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81B452073D;
        Tue, 10 Dec 2019 16:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575996246;
        bh=MEGV/SVGM9k2aiXKfSeTNVtTgqpQIdxWrdYHmc0Kd7I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kFpiLNnXlwQOsXYUIfpMUE7Gr0PllEyXRLwNG46KKr5P2bpiH2kIEEZd6C1wOtgw+
         98rNnLeFIU41xgwGJyu7E7FNmlPKPlE0mcfCvLpLXcjPfupVYwFI+vmnR7dUoZ8AHM
         yfuvuspCNlwh3nS8Y6QNt1o69cx8qqMnh0la0Zqc=
Date:   Wed, 11 Dec 2019 01:44:01 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, namit@vmware.com, hpa@zytor.com,
        luto@kernel.org, ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        jeyu@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH -tip 1/2] x86/alternative: Sync bp_patching update for
 avoiding NULL pointer exception
Message-Id: <20191211014401.2f0c27f259a83d1f32aa6f2e@kernel.org>
In-Reply-To: <20191209143940.GI2810@hirez.programming.kicks-ass.net>
References: <157483420094.25881.9190014521050510942.stgit@devnote2>
        <157483421229.25881.15314414408559963162.stgit@devnote2>
        <20191209143940.GI2810@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, 9 Dec 2019 15:39:40 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Nov 27, 2019 at 02:56:52PM +0900, Masami Hiramatsu wrote:
> 
> > diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> > index 4552795a8df4..9505096e2cd1 100644
> > --- a/arch/x86/kernel/alternative.c
> > +++ b/arch/x86/kernel/alternative.c
> > @@ -1134,8 +1134,14 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
> >  	 * sync_core() implies an smp_mb() and orders this store against
> >  	 * the writing of the new instruction.
> >  	 */
> > -	bp_patching.vec = NULL;
> >  	bp_patching.nr_entries = 0;
> > +	/*
> > +	 * This sync_core () ensures that all int3 handlers in progress
> > +	 * have finished. This allows poke_int3_handler () after this to
> > +	 * avoid touching bp_paching.vec by checking nr_entries == 0.
> > +	 */
> > +	text_poke_sync();
> > +	bp_patching.vec = NULL;
> >  }
> 
> How's something like this instead? Under the assumption that it is rare
> to actually hit the INT3 and even more rare to actually hit this race,
> the below should be a lot cheaper.

Ah, this reminds me of my atomic-refcounter method for kpatch idea
and module unloading.

This looks good, but I feel it is a bit complicated.

If we use atomic (and spin-wait) here, can we use atomic_inc_not_zero()
in the poke_int3_handler() at first for making sure the bp_batching is
under operation or not?
I think it makes things simpler, like below.

---------
atomic_t bp_refcnt;

poke_int3_handler()
{
	smp_rmb();
	if (!READ_ONCE(bp_patching.nr_entries))
		return 0;
	if (!atomic_inc_not_zero(&bp_refcnt))
		return 0;
	smp_mb__after_atomic();
	[use bp_patching]
	atomic_dec(&bp_refcnt);
}

text_poke_bp_batch()
{
	bp_patching.vec = tp;
	bp_patching.nr_entries = nr_entries;
	smp_wmb();
	atomic_inc(&bp_refcnt);
	...
	atomic_dec(&bp_refcnt);
	/* wait for all running poke_int3_handler(). */
	atomic_cond_read_acquire(&bp_refcnt, !VAL);
	bp_patching.vec = NULL;
	bp_patching.nr_entries = 0;
}
---------

Thank you,


> 
> ---
>  arch/x86/kernel/alternative.c | 69 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 53 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 30e86730655c..12f2d193109d 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -953,6 +953,8 @@ static struct bp_patching_desc {
>  	int nr_entries;
>  } bp_patching;
>  
> +static atomic_t bp_handlers;
> +
>  static inline void *text_poke_addr(struct text_poke_loc *tp)
>  {
>  	return _stext + tp->rel_addr;
> @@ -973,8 +975,8 @@ NOKPROBE_SYMBOL(patch_cmp);
>  int notrace poke_int3_handler(struct pt_regs *regs)
>  {
>  	struct text_poke_loc *tp;
> +	int nr, len, ret = 0;
>  	void *ip;
> -	int len;
>  
>  	/*
>  	 * Having observed our INT3 instruction, we now must observe
> @@ -987,12 +989,21 @@ int notrace poke_int3_handler(struct pt_regs *regs)
>  	 * Idem for other elements in bp_patching.
>  	 */
>  	smp_rmb();
> -
> -	if (likely(!bp_patching.nr_entries))
> +	if (!READ_ONCE(bp_patching.nr_entries))
>  		return 0;
>  
> +	atomic_inc(&bp_handlers);
> +	/*
> +	 * 'ACQUIRE', everything happens after the increment.
> +	 */
> +	smp_mb__after_atomic();
> +
> +	nr = smp_load_acquire(&bp_patching.nr_entries);
> +	if (likely(!nr))
> +		goto out;
> +
>  	if (user_mode(regs))
> -		return 0;
> +		goto out;
>  
>  	/*
>  	 * Discount the INT3. See text_poke_bp_batch().
> @@ -1002,16 +1013,16 @@ int notrace poke_int3_handler(struct pt_regs *regs)
>  	/*
>  	 * Skip the binary search if there is a single member in the vector.
>  	 */
> -	if (unlikely(bp_patching.nr_entries > 1)) {
> -		tp = bsearch(ip, bp_patching.vec, bp_patching.nr_entries,
> +	if (unlikely(nr > 1)) {
> +		tp = bsearch(ip, bp_patching.vec, nr,
>  			     sizeof(struct text_poke_loc),
>  			     patch_cmp);
>  		if (!tp)
> -			return 0;
> +			goto out;
>  	} else {
>  		tp = bp_patching.vec;
>  		if (text_poke_addr(tp) != ip)
> -			return 0;
> +			goto out;
>  	}
>  
>  	len = text_opcode_size(tp->opcode);
> @@ -1023,7 +1034,7 @@ int notrace poke_int3_handler(struct pt_regs *regs)
>  		 * Someone poked an explicit INT3, they'll want to handle it,
>  		 * do not consume.
>  		 */
> -		return 0;
> +		goto out;
>  
>  	case CALL_INSN_OPCODE:
>  		int3_emulate_call(regs, (long)ip + tp->rel32);
> @@ -1038,7 +1049,14 @@ int notrace poke_int3_handler(struct pt_regs *regs)
>  		BUG();
>  	}
>  
> -	return 1;
> +	ret = 1;
> +out:
> +	/*
> +	 * 'RELEASE", everything happens before the decrement.
> +	 */
> +	smp_mb__before_atomic();
> +	atomic_dec(&bp_handlers);
> +	return ret;
>  }
>  NOKPROBE_SYMBOL(poke_int3_handler);
>  
> @@ -1076,7 +1094,12 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
>  	lockdep_assert_held(&text_mutex);
>  
>  	bp_patching.vec = tp;
> -	bp_patching.nr_entries = nr_entries;
> +	/*
> +	 * bp_patching.vec = tp			nr = bp_patching.nr_entries
> +	 * REL					ACQ
> +	 * bp_patching.nr_entries = nr_entries	tp = bp_patching.vec[]
> +	 */
> +	smp_store_release(&bp_patching.nr_entries, nr_entries);
>  
>  	/*
>  	 * Corresponding read barrier in int3 notifier for making sure the
> @@ -1134,13 +1157,27 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
>  	 * sync_core() implies an smp_mb() and orders this store against
>  	 * the writing of the new instruction.
>  	 */
> -	bp_patching.nr_entries = 0;
> +	WRITE_ONCE(bp_patching.nr_entries, 0);
>  	/*
> -	 * This sync_core () call ensures that all INT3 handlers in progress
> -	 * have finished. This allows poke_int3_handler() after this to
> -	 * avoid touching bp_paching.vec by checking nr_entries == 0.
> +	 * nr_entries = 0	bp_handlers++
> +	 * MB			MB
> +	 * VAL = bp_handlers	nr = nr_entries
> +	 */
> +	smp_mb();
> +	/*
> +	 * Guarantee all poke_int3_handler()s that have observed
> +	 * @bp_patching.nr_enties have completed before we clear
> +	 * bp_patching.vec.
> +	 *
> +	 * We can't do this before text_poke_sync() because then there
> +	 * might still be observable INT3 instructions.
> +	 */
> +	atomic_cond_read_acquire(&bp_handlers, !VAL);
> +	/*
> +	 * bp_handlers == 0		tp = bp_patching.vec[]
> +	 * ACQ				MB
> +	 * bp_patching.vec = NULL	bp_handlers--;
>  	 */
> -	text_poke_sync();
>  	bp_patching.vec = NULL;
>  }
>  


-- 
Masami Hiramatsu <mhiramat@kernel.org>
