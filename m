Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D13BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 11:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F6D214B2
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 11:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388633AbfJVL2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 07:28:49 -0400
Received: from [217.140.110.172] ([217.140.110.172]:49864 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2387405AbfJVL2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 07:28:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E47011007;
        Tue, 22 Oct 2019 04:28:23 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6E213F718;
        Tue, 22 Oct 2019 04:28:21 -0700 (PDT)
Date:   Tue, 22 Oct 2019 12:28:11 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        amit.kachhap@arm.com, ard.biesheuvel@linaro.org,
        catalin.marinas@arm.com, deller@gmx.de, duwe@suse.de,
        james.morse@arm.com, jeyu@kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, mingo@redhat.com, peterz@infradead.org,
        svens@stackframe.org, takahiro.akashi@linaro.org, will@kernel.org
Subject: Re: [PATCH 1/8] ftrace: add ftrace_init_nop()
Message-ID: <20191022112811.GA11583@lakrids.cambridge.arm.com>
References: <20191021163426.9408-1-mark.rutland@arm.com>
 <20191021163426.9408-2-mark.rutland@arm.com>
 <20191021140756.613a1bac@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021140756.613a1bac@gandalf.local.home>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 02:07:56PM -0400, Steven Rostedt wrote:
> On Mon, 21 Oct 2019 17:34:19 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > Architectures may need to perform special initialization of ftrace
> > callsites, and today they do so by special-casing ftrace_make_nop() when
> > the expected branch address is MCOUNT_ADDR. In some cases (e.g. for
> > patchable-function-entry), we don't have an mcount-like symbol and don't
> > want a synthetic MCOUNT_ADDR, but we may need to perform some
> > initialization of callsites.
> > 
> > To make it possible to separate initialization from runtime
> > modification, and to handle cases without an mcount-like symbol, this
> > patch adds an optional ftrace_init_nop() function that architectures can
> > implement, which does not pass a branch address.
> > 
> > Where an architecture does not provide ftrace_init_nop(), we will fall
> > back to the existing behaviour of calling ftrace_make_nop() with
> > MCOUNT_ADDR.
> > 
> > At the same time, ftrace_code_disable() is renamed to
> > ftrace_code_init_disabled() to make it clearer that it is intended to
> > intialize a callsite into a disabled state, and is not for disabling a
> > callsite that has been runtime enabled.
> 
> To make the name even better, let's just rename it to:
> 
>  ftrace_nop_initialization()
> 
> I think that may be the best description for it.

Perhaps ftrace_nop_initialize(), so that it's not a noun?

I've made it ftrace_nop_initialization() in my branch for now.

> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index f296d89be757..afd7e210e595 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -2493,15 +2493,22 @@ struct dyn_ftrace *ftrace_rec_iter_record(struct ftrace_rec_iter *iter)
> >  	return &iter->pg->records[iter->index];
> >  }
> >  
> > +#ifndef ftrace_init_nop
> > +static int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
> > +{
> > +	return ftrace_make_nop(mod, rec, MCOUNT_ADDR);
> > +}
> > +#endif
> 
> Can you place the above in the ftrace.h header. That's where that would
> belong.
> 
> #ifndef ftrace_init_nop
> struct module;
> static inline int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
> {
> 	return ftrace_make_nop(mod, rec, MCOUNT_ADDR);
> }
> #endif

True.

I've put this immediately after ftrace_make_nop() in the header, and
given it a kerneldoc comment. There's a declaration for struct module at
the top of the header, so I've just relied on that

That looks like:

| /**
|  * ftrace_init_nop - initialize a nop call site
|  * @mod: module structure if called by module load initialization
|  * @rec: the mcount call site record
|  *
|  * This is a very sensitive operation and great care needs
|  * to be taken by the arch.  The operation should carefully
|  * read the location, check to see if what is read is indeed
|  * what we expect it to be, and then on success of the compare,
|  * it should write to the location.
|  *
|  * The code segment at @rec->ip should be as initialized by the
|  * compiler
|  *
|  * Return must be:
|  *  0 on success
|  *  -EFAULT on error reading the location
|  *  -EINVAL on a failed compare of the contents
|  *  -EPERM  on error writing to the location
|  * Any other value will be considered a failure.
|  */
| #ifndef ftrace_init_nop
| static int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
| {
| 	return ftrace_make_nop(mod, rec, MCOUNT_ADDR);
| }
| #endif

Thanks,
Mark.
