Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD111C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F453218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gf1b45VQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387934AbfB1RqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:46:24 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48598 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732473AbfB1RqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1tIRHaljqGjsTO1apj67lwRFzWZnSUB4T1+xsg6UD7c=; b=Gf1b45VQf+eom9qcjvjELnBgk
        RcZXJUq9jiBZ+fcUB73RGOHANCIX71hjazFHtWz2CAeE3Lb8PJmykQ53+rSRk7cwLVxsbNeTcfSTs
        91Eh26lFT3SYY8hHf4q5zSzZetk1MSlj9K/O0+zpi4BALwXTJarclL3bKt4oK9OJoF+Edz0E9Plmw
        1lbyiSERaPL6PyreFqddKdbm7+DlmVBjhNNYo4s9aIPSQB8k4ZSelmw4EsDHuai1U3H5pVlMKJZtd
        iIfozKsDAqkSvPxLwpOi32SjbOJ/TwPLSUoZruVymDMWOxh1n0RMSxuLX0NJY3Q5cGkmDtLLkmk4y
        yMRuBQjsw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gzPl2-0007Mj-0p; Thu, 28 Feb 2019 17:46:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 834C8202C2DA7; Thu, 28 Feb 2019 18:46:05 +0100 (CET)
Date:   Thu, 28 Feb 2019 18:46:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH 1/8] kasan,x86: Frob kasan_report() in an exception
Message-ID: <20190228174605.GF32494@hirez.programming.kicks-ass.net>
References: <20190228145450.289603901@infradead.org>
 <20190228150152.078767622@infradead.org>
 <CACT4Y+b0WyE5En7BVipZiCMmMaj30kaEu3T68H7+-kVP8gqADA@mail.gmail.com>
 <20190228154551.GE32494@hirez.programming.kicks-ass.net>
 <CACT4Y+ZJpDtHdF-NTy9RrhoOPMtko6VeXwkgR1yjFa5VFfGysQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZJpDtHdF-NTy9RrhoOPMtko6VeXwkgR1yjFa5VFfGysQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 05:03:09PM +0100, Dmitry Vyukov wrote:

> I am missing some knowledge about SMAP to answer this.
> In short, these tools insert lots of callbacks into runtime for memory
> accesses, function entry/exit, atomicops and some other. These
> callbacks can do things of different complexity.
> Humm... perhaps we could just disable SMAP for KMSAN/KTSAN. It's
> possible, right? If we have it enabled with KASAN, that should be
> enough.

SMAP detects access to _PAGE_USER pages; that is, such access is only
allowed when EFLAGS.AC=1, otherwise they'll fault.

I again don't know enough about KASAN to say if it does that; but I
suspect it only tracks kernel memory state.

> Also, what's the actual problem with KASAN+SMAP? Is it warnings from
> static analysis tool? Or there are also some runtime effects? What
> effects?

Both; so because of the above semantics, things like copy_to_user() will
have to do STAC (set EFLAGS.AC=1), then do the actual copies to the user
addresses, and then CLAC (clear the AC flag again).

The desire is to have AC=1 sections as small as possible, such that as
much code as possible is ran with AC=0 and will trap on unintended
accesses.

Also; the scheduler doesn't (but I have a patch for that, but I'd prefer
to not have to use it) context switch EFLAGS. This means that if we land
in the scheduler while AC=1, the next task will resume with AC=1.

Consequently, if that task returns to userspace before it gets scheduled
again, we'll continue our previous task (that left with AC=1) with AC=0
and it'll then fault where no fault were expected.

Anyway; the objtool annotation basically tracks the EFLAGS.AC state
(through STAC/CLAC instructions -- no PUSHF/POPF) and disallows any
CALL/RET while AC=1.

This is where the __asan_{load,store}*() stuff went *splat*. GCC inserts
those calls in the middle of STAC/CLAC (AC=1) and we then have to mark
the functions as AC-safe. objtool validates those on the same rules, no
further CALLs that are not also safe.

Things like __fentry__ are inherently unsafe because they use
preempt_disable/preempt_enable, where the latter has a CALL
__preempt_schedule (and is thus very unsafe). Similarly with
kasan_report(), it does all sorts of things that are not safe to do.

> Is it possible to disable the SMAP runtime checks once we enter
> kasan_report() past report_enabled() check? We could restrict it to
> "just finish printing this bug report whatever it takes and then
> whatever" if it makes things simpler.
> It would be nice if we could restrict it to something like:
> 
> @@ -291,6 +303,7 @@ void kasan_report(unsigned long addr, size_t size,
>         if (likely(!report_enabled()))
>                 return;
> +       disable_smap();
> 
> And then enforce panic at the end of report if smap is enabled.

That would be a CLAC, and the current rules disallow CLAC for AC-safe
functions.

Furthermore, kasan_report() isn't fatal, right? So it would have to
restore the state on exit. That makes the validation state much more
complicated.

Let me try and frob some of the report_enabled() stuff before the #UD.
