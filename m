Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB9ECA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 20:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D724921928
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 20:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733049AbfJWUI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 16:08:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfJWUI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 16:08:56 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3B3520650;
        Wed, 23 Oct 2019 20:08:53 +0000 (UTC)
Date:   Wed, 23 Oct 2019 16:08:52 -0400
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
Message-ID: <20191023160852.0606bc68@gandalf.local.home>
In-Reply-To: <20191023193442.35lhhrqnyn3bfwpq@ast-mbp.dhcp.thefacebook.com>
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
        <20191023193442.35lhhrqnyn3bfwpq@ast-mbp.dhcp.thefacebook.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2019 12:34:43 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > Would this work for you?  
> 
> Yes!
> Looks great. More comments below.

Awesome!

> 
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 6adaf18b3365..de3372bd08ae 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -159,6 +159,7 @@ config X86
> >  	select HAVE_DYNAMIC_FTRACE
> >  	select HAVE_DYNAMIC_FTRACE_WITH_REGS
> >  	select HAVE_DYNAMIC_FTRACE_WITH_IPMODIFY
> > +	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> >  	select HAVE_EBPF_JIT
> >  	select HAVE_EFFICIENT_UNALIGNED_ACCESS
> >  	select HAVE_EISA
> > diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> > index c38a66661576..34da1e424391 100644
> > --- a/arch/x86/include/asm/ftrace.h
> > +++ b/arch/x86/include/asm/ftrace.h
> > @@ -28,6 +28,12 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
> >  	return addr;
> >  }
> >  
> > +static inline void ftrace_set_call_func(struct pt_regs *regs, unsigned long addr)
> > +{
> > +	/* Emulate a call */
> > +	regs->orig_ax = addr;  
> 
> This probably needs a longer comment :)

Yes, when I get this to a submission point, I plan on having *a lot*
more comments all over the place.


> 
> > +	.if \make_call
> > +	movq ORIG_RAX(%rsp), %rax
> > +	movq %rax, MCOUNT_REG_SIZE-8(%rsp)  
> 
> reading asm helps.
> 
> > +config HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> > +	bool
> > +
> >  config HAVE_FTRACE_MCOUNT_RECORD
> >  	bool
> >  	help
> > @@ -565,6 +568,11 @@ config DYNAMIC_FTRACE_WITH_IPMODIFY_ONLY
> >  	depends on DYNAMIC_FTRACE
> >  	depends on HAVE_DYNAMIC_FTRACE_WITH_IPMODIFY
> >  
> > +config DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> > +	def_bool y
> > +	depends on DYNAMIC_FTRACE
> > +	depends on HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS  
> 
> It seems to me that it's a bit of overkill to add new config knob
> for every ftrace feature.
> HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS (that arch defined) would
> be enough to check and return error in register_ftrace_direct()
> right?

IIRC, we started doing this because it allows the dependencies to be
defined in the kernel/trace directory. That is, if
CONFIG_DYNAMIC_FATRCE_WITH_DIRECT_CALLS is set, then we know that
direct calls *and* DYNAMIC_FTRACE is enabled. It cuts down on some of
the more complex #if or the arch needing to do

 select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS if DYNAMIC_FTRACE

It may be overkill, but it does keep the pain in one place.

> 
> > -static struct ftrace_hash *
> > -__ftrace_hash_move(struct ftrace_hash *src)
> > +static void transfer_hash(struct ftrace_hash *dst, struct ftrace_hash *src)
> >  {
> >  	struct ftrace_func_entry *entry;
> > -	struct hlist_node *tn;
> >  	struct hlist_head *hhd;
> > +	struct hlist_node *tn;
> > +	int size;
> > +	int i;
> > +
> > +	dst->flags = src->flags;
> > +
> > +	size = 1 << src->size_bits;
> > +	for (i = 0; i < size; i++) {
> > +		hhd = &src->buckets[i];
> > +		hlist_for_each_entry_safe(entry, tn, hhd, hlist) {
> > +			remove_hash_entry(src, entry);
> > +			__add_hash_entry(dst, entry);  
> 
> I don't quite follow why this is needed.
> I thought alloc_and_copy_ftrace_hash() can already handle it.
> If that is just unrelated cleanup then sure. Looks good.

The alloc and copy is made to always create a new hash (because of the
way we do enabling of new filters in the set_ftrace_filter).

I pulled this part out so that the direct_functions hash only needs to
grow and allocate, when needed. Not to reallocate at every update.

> 
> > +struct ftrace_ops direct_ops = {
> > +	.func		= call_direct_funcs,
> > +	.flags		= FTRACE_OPS_FL_IPMODIFY | FTRACE_OPS_FL_RECURSION_SAFE
> > +#if 1
> > +					| FTRACE_OPS_FL_DIRECT
> > +#endif
> > +#ifndef CONFIG_DYNAMIC_FTRACE_WITH_IPMODIFY_ONLY
> > +					| FTRACE_OPS_FL_SAVE_REGS
> > +#endif  
> 
> With FL_DIRECT the CONFIG_DYNAMIC_FTRACE_WITH_IPMODIFY_ONLY won't be needed, right ?
> At least not for bpf use case.
> Do you see livepatching using it or switching to FL_DIRECT too?

Correct. I talked with Josh on IRC and we are looking into removing the
pushf/popf from the ftrace_regs_caller to see if that helps in the
performance for live patching. I'm also currently working on making
this patch not on top of the IP modify one, so the IP modify doesn't
need to be applied.

This also cleans up the asm code a bit more (getting rid of the macro).


> 
> > +	ret = -ENOMEM;
> > +	if (ftrace_hash_empty(direct_functions) ||
> > +	    direct_functions->count > 2 * (1 << direct_functions->size_bits)) {
> > +		struct ftrace_hash *new_hash;
> > +		int size = ftrace_hash_empty(direct_functions) ? 0 :
> > +			direct_functions->count + 1;
> > +		int bits;
> > +
> > +		if (size < 32)
> > +			size = 32;
> > +
> > +		for (size /= 2; size; size >>= 1)
> > +			bits++;
> > +
> > +		/* Don't allocate too much */
> > +		if (bits > FTRACE_HASH_MAX_BITS)
> > +			bits = FTRACE_HASH_MAX_BITS;
> > +
> > +		new_hash = alloc_ftrace_hash(bits);
> > +		if (!new_hash)
> > +			goto out_unlock;
> > +
> > +		transfer_hash(new_hash, direct_functions);
> > +		free_ftrace_hash(direct_functions);
> > +		direct_functions = new_hash;  
> 
> That's probably racy, no?
> ftrace_get_addr_new() is not holding direct_mutex that
> protects direct_functions.

Yes, there's actually a few places that I noticed needed some more care
with locking. And I also found some that are missing now (without these
changes).

I did say this patch is buggy ;-)


> 
> > +	if (!ret && !(direct_ops.flags & FTRACE_OPS_FL_ENABLED))
> > +		ret = register_ftrace_function(&direct_ops);  
> 
> Having single direct_ops is nice.
> 
> > @@ -2370,6 +2542,10 @@ unsigned long ftrace_get_addr_new(struct dyn_ftrace *rec)
> >  {
> >  	struct ftrace_ops *ops;
> >  
> > +	if ((rec->flags & FTRACE_FL_DIRECT) &&
> > +	    (ftrace_rec_count(rec) == 1))
> > +		return find_rec_direct(rec->ip);
> > +  
> 
> I've started playing with this function as well to
> implement 2nd nop approach I mentioned earlier.
> I'm going to abandon it, since your approach is better.
> It allows not only bpf, but anyone else to register direct.
> 
> I have one more question/request.
> Looks like ftrace can be turned off with sysctl.
> Which means that a person or a script can accidently turn it off
> and all existing kprobe+bpf stuff that is ftrace based will
> be silently switched off.

See http://lkml.kernel.org/r/20191016113316.13415-1-mbenes@suse.cz

I can (and should) add the PERMANENT flag to the direct_ops.

Note, the PERMANENT patches will be added before this one.

> User services will be impacted and will make people unhappy.
> I'm not sure how to solve the existing situation,
> but for FL_DIRECT can you add a check that if particular
> nop is modified to do direct call then the only interface to
> turn it off is to call unregister_ftrace_direct().
> There should no side channel to kill it.
> ftrace_disable and ftrace_kill make me nervous too.

The ftrace_disable and ftrace_kill is when a bug happens that is so bad
that the ftrace can probably kill the system. It's time for a reboot.


> Fast forward a year and imagine few host critical bpf progs
> are running in production and relying on FL_DIRECT.
> Now somebody decided to test new ftrace feature and
> it hit one of FTRACE_WARN_ON().
> That will shutdown the whole ftrace and bpf progs
> will stop executing. I'd like to avoid that.
> May be I misread the code?

It basically freezes it. Current registered ftrace_ops will not be
touched. But nothing can be removed or added.

It's basically saying, "Something totally wrong has happened, and if I
touch the code here, I may panic the box. So don't do anything more!"

And yes, without adding some of theses, I have in fact paniced the box.

This is something that Ingo drilled hard into me, as modifying text is
such a dangerous operation, that there should be constant checks that
things are happening the way they expect them to be, and if anomaly
happens, stop touching everything.

OK, I'll work to get this patch in for the next merge window.

Thanks for the review.

-- Steve
