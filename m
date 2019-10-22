Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6FECA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 12:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59480218AE
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 12:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389137AbfJVMyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 08:54:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387695AbfJVMyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 08:54:32 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC95C2075A;
        Tue, 22 Oct 2019 12:54:29 +0000 (UTC)
Date:   Tue, 22 Oct 2019 08:54:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        amit.kachhap@arm.com, ard.biesheuvel@linaro.org,
        catalin.marinas@arm.com, deller@gmx.de, duwe@suse.de,
        james.morse@arm.com, jeyu@kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, mingo@redhat.com, peterz@infradead.org,
        svens@stackframe.org, takahiro.akashi@linaro.org, will@kernel.org
Subject: Re: [PATCH 1/8] ftrace: add ftrace_init_nop()
Message-ID: <20191022085428.75cfaad6@gandalf.local.home>
In-Reply-To: <20191022112811.GA11583@lakrids.cambridge.arm.com>
References: <20191021163426.9408-1-mark.rutland@arm.com>
        <20191021163426.9408-2-mark.rutland@arm.com>
        <20191021140756.613a1bac@gandalf.local.home>
        <20191022112811.GA11583@lakrids.cambridge.arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019 12:28:11 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> > To make the name even better, let's just rename it to:
> > 
> >  ftrace_nop_initialization()
> > 
> > I think that may be the best description for it.  
> 
> Perhaps ftrace_nop_initialize(), so that it's not a noun?
> 
> I've made it ftrace_nop_initialization() in my branch for now.

I'm fine with ftrace_nop_initialize().

> 
> > > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > > index f296d89be757..afd7e210e595 100644
> > > --- a/kernel/trace/ftrace.c
> > > +++ b/kernel/trace/ftrace.c
> > > @@ -2493,15 +2493,22 @@ struct dyn_ftrace *ftrace_rec_iter_record(struct ftrace_rec_iter *iter)
> > >  	return &iter->pg->records[iter->index];
> > >  }
> > >  
> > > +#ifndef ftrace_init_nop
> > > +static int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
> > > +{
> > > +	return ftrace_make_nop(mod, rec, MCOUNT_ADDR);
> > > +}
> > > +#endif  
> > 
> > Can you place the above in the ftrace.h header. That's where that would
> > belong.
> > 
> > #ifndef ftrace_init_nop
> > struct module;
> > static inline int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
> > {
> > 	return ftrace_make_nop(mod, rec, MCOUNT_ADDR);
> > }
> > #endif  
> 
> True.
> 
> I've put this immediately after ftrace_make_nop() in the header, and
> given it a kerneldoc comment. There's a declaration for struct module at
> the top of the header, so I've just relied on that
> 
> That looks like:
> 
> | /**
> |  * ftrace_init_nop - initialize a nop call site
> |  * @mod: module structure if called by module load initialization
> |  * @rec: the mcount call site record

Perhaps say "mcount/fentry"

> |  *
> |  * This is a very sensitive operation and great care needs
> |  * to be taken by the arch.  The operation should carefully
> |  * read the location, check to see if what is read is indeed
> |  * what we expect it to be, and then on success of the compare,
> |  * it should write to the location.
> |  *
> |  * The code segment at @rec->ip should be as initialized by the

"should be as" is a bit confusing. What about?

 "The code segment at @rec->ip should contain the contents created by
  the compiler".

-- Steve


> |  * compiler
> |  *
> |  * Return must be:
> |  *  0 on success
> |  *  -EFAULT on error reading the location
> |  *  -EINVAL on a failed compare of the contents
> |  *  -EPERM  on error writing to the location
> |  * Any other value will be considered a failure.
> |  */
> | #ifndef ftrace_init_nop
> | static int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
> | {
> | 	return ftrace_make_nop(mod, rec, MCOUNT_ADDR);
> | }
> | #endif
> 
> Thanks,
> Mark.

