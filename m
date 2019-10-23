Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BDCCA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 19:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EAB220640
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 19:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0aqmp+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733123AbfJWTmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 15:42:10 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38477 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731949AbfJWTmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 15:42:09 -0400
Received: by mail-pl1-f196.google.com with SMTP id w8so10591644plq.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 12:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1BdKjGUf/i8XE9JAWNux071yqthCw0rl3d9t1MaVfnE=;
        b=L0aqmp+hurNXVarGwR+9LtaJf/UHr2Nsm3oUobvX7vYn4gUCjqAzhYn2Pe0AnmyOGx
         Q515Zj3k9zg5zKoMqCHd6lst5hkIznHluNJPCpmVqfz0CubNb4OtzL1YyudL0RhXivCz
         xcEjePgv1bs6etQiDIoGDTpuWMtAjgADc+WRMiomAeEDA/msW23D0T3+8g3K/XV8UjT6
         RE7pKY0L6D/tkfubx5Rw2cA/RYIUp1+2Ntpg7xA7t+BvFCYbskteMXy9zotnI8lXB7TS
         QChV+Lv2fPMBQR18CxeOh7lVypSuyS2mGEL+Y30sfubGGQ0MgMndZTBjXYwbw/wnUFsY
         Osig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1BdKjGUf/i8XE9JAWNux071yqthCw0rl3d9t1MaVfnE=;
        b=ShlGdfzFmEqFiYllv4T6U6u55MQuwctmd6OXvLUdY0ZoDOdII/RAPqE5edRvzzZCwz
         IH4URjduzEZlc22tE6GjV84hu1D1rXfftfDMhgjHvdEhnlzsiBT7KkFadLZFng57gfMW
         PP+lPQS8K69V0TTJbISR46qHcctLELYBHQcw4Rfwo9OHveHRwU63o1bu43pzIsK9FyNZ
         esS8wxsQlpyiYwr5cs0OHRIZfCU1SHbZniy6zqERasPchWIOOh3XRc+tdtWjy3lD9EK+
         rTf7+Tk5bhIBj82f1ZSrxgZnlKfC9WEnSzR/bTPjCaEPP9c527vALLNkl4MJW+fx/z6y
         f0Vg==
X-Gm-Message-State: APjAAAUi33AIyRZfhwfXnc5to07ZZROTwQIFsdtO6CKkvhr9GTS1EvJT
        9/wRCGme0qBz1MRDNhNvtDY=
X-Google-Smtp-Source: APXvYqxZx7Y+QGS7l/HIi7NGU4SyzfZ/kZDv8JUMhsob+LaBNDAJOP9B0xUg4jAomLs0L7K3uZQcKA==
X-Received: by 2002:a17:902:d68f:: with SMTP id v15mr9035802ply.206.1571859286641;
        Wed, 23 Oct 2019 12:34:46 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::741a])
        by smtp.gmail.com with ESMTPSA id c14sm27335901pfm.179.2019.10.23.12.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 12:34:45 -0700 (PDT)
Date:   Wed, 23 Oct 2019 12:34:43 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
Message-ID: <20191023193442.35lhhrqnyn3bfwpq@ast-mbp.dhcp.thefacebook.com>
References: <20191021231904.4b968dc1@oasis.local.home>
 <20191022040532.fvpxcs74i4mn4rc6@ast-mbp.dhcp.thefacebook.com>
 <20191022071956.07e21543@gandalf.local.home>
 <20191022094455.6a0a1a27@gandalf.local.home>
 <20191022175052.frjzlnjjfwwfov64@ast-mbp.dhcp.thefacebook.com>
 <20191022141021.2c4496c2@gandalf.local.home>
 <20191022204620.jp535nfvfubjngzd@ast-mbp.dhcp.thefacebook.com>
 <20191022170430.6af3b360@gandalf.local.home>
 <20191022215841.2qsmhd6vxi4mwade@ast-mbp.dhcp.thefacebook.com>
 <20191023122307.756b4978@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023122307.756b4978@gandalf.local.home>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 12:23:06PM -0400, Steven Rostedt wrote:
> On Tue, 22 Oct 2019 14:58:43 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> > Neither of two statements are true. The per-function generated trampoline
> > I'm talking about is bpf specific. For a function with two arguments it's just:
> > push rbp 
> > mov rbp, rsp
> > push rdi
> > push rsi
> > lea  rdi,[rbp-0x10]
> > call jited_bpf_prog
> > pop rsi
> > pop rdi
> > leave
> > ret
> > 
> > fentry's nop is replaced with call to the above.
> > That's it.
> > kprobe and live patching has no use out of it.
> > 
> 
> Below is a patch that allows you to do this, and you don't need to
> worry about patching the nops. And it also allows to you hook directly
> to any function and still allow kprobes and tracing on those same
> functions (as long as they don't modify the ip, but in the future, we
> may be able to allow that too!). And this code does not depend on
> Peter's code either.
> 
> All you need to do is:
> 
> 	register_ftrace_direct((unsigned long)func_you_want_to_trace,
> 			       (unsigned long)your_trampoline);
> 
> 
> I added to trace-event-samples.c:
> 
> void my_direct_func(raw_spinlock_t *lock)
> {
> 	trace_printk("taking %p\n", lock);
> }
> 
> extern void my_tramp(void *);
> 
> asm (
> "       .pushsection    .text, \"ax\", @progbits\n"
> "   my_tramp:"
> #if 1
> "       pushq %rbp\n"
> "	movq %rsp, %rbp\n"
> "	pushq %rdi\n"
> "	call my_direct_func\n"
> "	popq %rdi\n"
> "	leave\n"
> #endif
> "	ret\n"
> "       .popsection\n"
> );
> 
> 
> (the #if was for testing purposes)
> 
> And then in the module load and unload:
> 
> 	ret = register_ftrace_direct((unsigned long)do_raw_spin_lock,
> 				     (unsigned long)my_tramp);
> 
> 	unregister_ftrace_direct((unsigned long)do_raw_spin_lock,
> 				 (unsigned long)my_tramp);
> 
> respectively.
> 
> And what this does is if there's only a single callback to the
> registered function, it changes the nop in the function to call your
> trampoline directly (just like you want this to do!). But if we add
> another callback, a direct_ops ftrace_ops gets added to the list of the
> functions to go through, and this will set up the code to call your
> trampoline after it calls all the other callbacks.
> 
> The called trampoline will be called as if it was called directly from
> the nop.
> 
> OK, I wrote this up quickly, and it has some bugs, but nothing that
> can't be straighten out (specifically, the checks fail if you add a
> function trace to one of the direct callbacks, but this can be dealt
> with).
> 
> Note, the work needed to port this to other archs is rather minimal
> (just need to tweak the ftrace_regs_caller and have a way to pass back
> the call address via pt_regs that is not saved).
> 
> Alexei,
> 
> Would this work for you?

Yes!
Looks great. More comments below.

> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 6adaf18b3365..de3372bd08ae 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -159,6 +159,7 @@ config X86
>  	select HAVE_DYNAMIC_FTRACE
>  	select HAVE_DYNAMIC_FTRACE_WITH_REGS
>  	select HAVE_DYNAMIC_FTRACE_WITH_IPMODIFY
> +	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>  	select HAVE_EBPF_JIT
>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS
>  	select HAVE_EISA
> diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> index c38a66661576..34da1e424391 100644
> --- a/arch/x86/include/asm/ftrace.h
> +++ b/arch/x86/include/asm/ftrace.h
> @@ -28,6 +28,12 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
>  	return addr;
>  }
>  
> +static inline void ftrace_set_call_func(struct pt_regs *regs, unsigned long addr)
> +{
> +	/* Emulate a call */
> +	regs->orig_ax = addr;

This probably needs a longer comment :)

> +	.if \make_call
> +	movq ORIG_RAX(%rsp), %rax
> +	movq %rax, MCOUNT_REG_SIZE-8(%rsp)

reading asm helps.

> +config HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> +	bool
> +
>  config HAVE_FTRACE_MCOUNT_RECORD
>  	bool
>  	help
> @@ -565,6 +568,11 @@ config DYNAMIC_FTRACE_WITH_IPMODIFY_ONLY
>  	depends on DYNAMIC_FTRACE
>  	depends on HAVE_DYNAMIC_FTRACE_WITH_IPMODIFY
>  
> +config DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> +	def_bool y
> +	depends on DYNAMIC_FTRACE
> +	depends on HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS

It seems to me that it's a bit of overkill to add new config knob
for every ftrace feature.
HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS (that arch defined) would
be enough to check and return error in register_ftrace_direct()
right?

> -static struct ftrace_hash *
> -__ftrace_hash_move(struct ftrace_hash *src)
> +static void transfer_hash(struct ftrace_hash *dst, struct ftrace_hash *src)
>  {
>  	struct ftrace_func_entry *entry;
> -	struct hlist_node *tn;
>  	struct hlist_head *hhd;
> +	struct hlist_node *tn;
> +	int size;
> +	int i;
> +
> +	dst->flags = src->flags;
> +
> +	size = 1 << src->size_bits;
> +	for (i = 0; i < size; i++) {
> +		hhd = &src->buckets[i];
> +		hlist_for_each_entry_safe(entry, tn, hhd, hlist) {
> +			remove_hash_entry(src, entry);
> +			__add_hash_entry(dst, entry);

I don't quite follow why this is needed.
I thought alloc_and_copy_ftrace_hash() can already handle it.
If that is just unrelated cleanup then sure. Looks good.

> +struct ftrace_ops direct_ops = {
> +	.func		= call_direct_funcs,
> +	.flags		= FTRACE_OPS_FL_IPMODIFY | FTRACE_OPS_FL_RECURSION_SAFE
> +#if 1
> +					| FTRACE_OPS_FL_DIRECT
> +#endif
> +#ifndef CONFIG_DYNAMIC_FTRACE_WITH_IPMODIFY_ONLY
> +					| FTRACE_OPS_FL_SAVE_REGS
> +#endif

With FL_DIRECT the CONFIG_DYNAMIC_FTRACE_WITH_IPMODIFY_ONLY won't be needed, right ?
At least not for bpf use case.
Do you see livepatching using it or switching to FL_DIRECT too?

> +	ret = -ENOMEM;
> +	if (ftrace_hash_empty(direct_functions) ||
> +	    direct_functions->count > 2 * (1 << direct_functions->size_bits)) {
> +		struct ftrace_hash *new_hash;
> +		int size = ftrace_hash_empty(direct_functions) ? 0 :
> +			direct_functions->count + 1;
> +		int bits;
> +
> +		if (size < 32)
> +			size = 32;
> +
> +		for (size /= 2; size; size >>= 1)
> +			bits++;
> +
> +		/* Don't allocate too much */
> +		if (bits > FTRACE_HASH_MAX_BITS)
> +			bits = FTRACE_HASH_MAX_BITS;
> +
> +		new_hash = alloc_ftrace_hash(bits);
> +		if (!new_hash)
> +			goto out_unlock;
> +
> +		transfer_hash(new_hash, direct_functions);
> +		free_ftrace_hash(direct_functions);
> +		direct_functions = new_hash;

That's probably racy, no?
ftrace_get_addr_new() is not holding direct_mutex that
protects direct_functions.

> +	if (!ret && !(direct_ops.flags & FTRACE_OPS_FL_ENABLED))
> +		ret = register_ftrace_function(&direct_ops);

Having single direct_ops is nice.

> @@ -2370,6 +2542,10 @@ unsigned long ftrace_get_addr_new(struct dyn_ftrace *rec)
>  {
>  	struct ftrace_ops *ops;
>  
> +	if ((rec->flags & FTRACE_FL_DIRECT) &&
> +	    (ftrace_rec_count(rec) == 1))
> +		return find_rec_direct(rec->ip);
> +

I've started playing with this function as well to
implement 2nd nop approach I mentioned earlier.
I'm going to abandon it, since your approach is better.
It allows not only bpf, but anyone else to register direct.

I have one more question/request.
Looks like ftrace can be turned off with sysctl.
Which means that a person or a script can accidently turn it off
and all existing kprobe+bpf stuff that is ftrace based will
be silently switched off.
User services will be impacted and will make people unhappy.
I'm not sure how to solve the existing situation,
but for FL_DIRECT can you add a check that if particular
nop is modified to do direct call then the only interface to
turn it off is to call unregister_ftrace_direct().
There should no side channel to kill it.
ftrace_disable and ftrace_kill make me nervous too.
Fast forward a year and imagine few host critical bpf progs
are running in production and relying on FL_DIRECT.
Now somebody decided to test new ftrace feature and
it hit one of FTRACE_WARN_ON().
That will shutdown the whole ftrace and bpf progs
will stop executing. I'd like to avoid that.
May be I misread the code?

