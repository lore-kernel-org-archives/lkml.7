Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF33CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD6B20B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbfKDNhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 08:37:03 -0500
Received: from foss.arm.com ([217.140.110.172]:43160 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbfKDNhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:37:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6117A1FB;
        Mon,  4 Nov 2019 05:37:02 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2702E3F6C4;
        Mon,  4 Nov 2019 05:37:00 -0800 (PST)
Date:   Mon, 4 Nov 2019 13:36:58 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        deller@gmx.de, duwe@suse.de, James.Bottomley@HansenPartnership.com,
        james.morse@arm.com, jeyu@kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, linux-parisc@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, svens@stackframe.org,
        takahiro.akashi@linaro.org, will@kernel.org
Subject: Re: [PATCHv2 1/8] ftrace: add ftrace_init_nop()
Message-ID: <20191104133657.GE45140@lakrids.cambridge.arm.com>
References: <20191029165832.33606-1-mark.rutland@arm.com>
 <20191029165832.33606-2-mark.rutland@arm.com>
 <daad0785-a33f-3cfb-cf0f-657b6c677257@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daad0785-a33f-3cfb-cf0f-657b6c677257@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2019 at 05:49:00PM +0530, Amit Daniel Kachhap wrote:
> Hi Mark,

Hi Amit,

Thanks for the review!
 
> On 10/29/19 10:28 PM, Mark Rutland wrote:
> > Architectures may need to perform special initialization of ftrace
> > callsites, and today they do so by special-casing ftrace_make_nop() when
> > the expected branch address is MCOUNT_ADDR. In some cases (e.g. for
> > patchable-function-entry), we don't have an mcount-like symbol and don't
> s/an mcount/a mcount.
> > want a synthetic MCOUNT_ADDR, but we may need to perform some
> > initialization of callsites.
> > 
> > To make it possible to separate initialization from runtime
> > modification, and to handle cases without an mcount-like symbol, this
> Same as above.

Using 'an' in both of these cases is correct, even though 'mcount'
starts with a consonant, since it's pronounced as-if it were 'emcount'.
I will leave this as-is.

> > patch adds an optional ftrace_init_nop() function that architectures can
> > implement, which does not pass a branch address.
> > 
> > Where an architecture does not provide ftrace_init_nop(), we will fall
> > back to the existing behaviour of calling ftrace_make_nop() with
> > MCOUNT_ADDR.
> > 
> > At the same time, ftrace_code_disable() is renamed to
> > ftrace_nop_initialize() to make it clearer that it is intended to
> > intialize a callsite into a disabled state, and is not for disabling a
> > callsite that has been runtime enabled. The kerneldoc description of rec
> > arguments is updated to cover non-mcount callsites.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Torsten Duwe <duwe@suse.de>
> > ---
> >   include/linux/ftrace.h | 35 ++++++++++++++++++++++++++++++++---
> >   kernel/trace/ftrace.c  |  6 +++---
> >   2 files changed, 35 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index 8a8cb3c401b2..9867d90d635e 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -499,7 +499,7 @@ static inline int ftrace_disable_ftrace_graph_caller(void) { return 0; }
> >   /**
> >    * ftrace_make_nop - convert code into nop
> >    * @mod: module structure if called by module load initialization
> > - * @rec: the mcount call site record
> > + * @rec: the call site record (e.g. mcount/fentry)
> >    * @addr: the address that the call site should be calling
> >    *
> >    * This is a very sensitive operation and great care needs
> > @@ -520,9 +520,38 @@ static inline int ftrace_disable_ftrace_graph_caller(void) { return 0; }
> >   extern int ftrace_make_nop(struct module *mod,
> >   			   struct dyn_ftrace *rec, unsigned long addr);
> > +
> > +/**
> > + * ftrace_init_nop - initialize a nop call site
> > + * @mod: module structure if called by module load initialization
> > + * @rec: the call site record (e.g. mcount/fentry)
> > + *
> > + * This is a very sensitive operation and great care needs
> > + * to be taken by the arch.  The operation should carefully
> > + * read the location, check to see if what is read is indeed
> > + * what we expect it to be, and then on success of the compare,
> > + * it should write to the location.
> > + *
> > + * The code segment at @rec->ip should contain the contents created by
> > + * the compiler
> Nit: Will it be better to write it as "@rec->ip should store the adjusted
> ftrace entry address of the call site" or something like that.

This was the specific wording requested by Steve, and it's trying to
describe the instructions at rec->ip, rather than the value of rec->ip,
so I think it's better to leave this as-is.

> > + *
> > + * Return must be:
> > + *  0 on success
> > + *  -EFAULT on error reading the location
> > + *  -EINVAL on a failed compare of the contents
> > + *  -EPERM  on error writing to the location
> > + * Any other value will be considered a failure.
> > + */
> > +#ifndef ftrace_init_nop
> > +static inline int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
> > +{
> > +	return ftrace_make_nop(mod, rec, MCOUNT_ADDR);
> > +}
> > +#endif
> > +
> Now that ftrace_init_nop is also an arch implemented function so it may be
> added in Documentation/trace/ftrace-design.rst along with ftrace_make_nop.
> In general also, adding some description about patchable-function-entry
> in kernel Documentation will be useful.

I agree that would be a good thing, but as Steve suggests I will leave
this for subsequent rework, as I think that also implies more
rework/renaming in the core code (e.g. to more cleanly separate the
notion of a callsite from mcount specifically).

Steve, if you'd like help with that (or review), I'd be happy to help.

Thanks,
Mark.
