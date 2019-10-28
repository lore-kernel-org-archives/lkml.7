Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0718CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F2D20717
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391097AbfJ1Qfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:35:41 -0400
Received: from foss.arm.com ([217.140.110.172]:42724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729420AbfJ1Qfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:35:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F03761FB;
        Mon, 28 Oct 2019 09:35:39 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D03093F6C4;
        Mon, 28 Oct 2019 09:35:37 -0700 (PDT)
Date:   Mon, 28 Oct 2019 16:35:33 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 05/17] add support for Clang's Shadow Call Stack (SCS)
Message-ID: <20191028163532.GA52213@lakrids.cambridge.arm.com>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191024225132.13410-1-samitolvanen@google.com>
 <20191024225132.13410-6-samitolvanen@google.com>
 <20191025105643.GD40270@lakrids.cambridge.arm.com>
 <CABCJKuc+XiDRdqfvjwCF7y=1wX3QO0MCUpeu4Gdcz91+nmnEAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKuc+XiDRdqfvjwCF7y=1wX3QO0MCUpeu4Gdcz91+nmnEAQ@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 01:49:21PM -0700, Sami Tolvanen wrote:
> On Fri, Oct 25, 2019 at 3:56 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > > +#define SCS_END_MAGIC        0xaf0194819b1635f6UL
> >
> > Keyboard smash? ... or is there a prize for whoever figures out the
> > secret? ;)
> 
> It's a random number, so if someone figures out a secret in it,
> they'll definitely deserve a prize. :)

I'll Cc some treasure hunters. :)

> > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > index bcdf53125210..ae7ebe9f0586 100644
> > > --- a/kernel/fork.c
> > > +++ b/kernel/fork.c
> > > @@ -94,6 +94,7 @@
> > >  #include <linux/livepatch.h>
> > >  #include <linux/thread_info.h>
> > >  #include <linux/stackleak.h>
> > > +#include <linux/scs.h>
> >
> > Nit: alphabetical order, please (this should come before stackleak.h).
> 
> The includes in kernel/fork.c aren't in alphabetical order, so I just
> added this to the end here.

Fair enough. It looked otherwise in the context, and we generally aim
for that as a soft rule.

[...]

> > > +static inline void *__scs_base(struct task_struct *tsk)
> > > +{
> > > +     return (void *)((uintptr_t)task_scs(tsk) & ~(SCS_SIZE - 1));
> > > +}
> >
> > We only ever assign the base to task_scs(tsk), with the current live
> > value being in a register that we don't read. Are we expecting arch code
> > to keep this up-to-date with the register value?
> >
> > I would have expected that we just leave this as the base (as we do for
> > the regular stack in the task struct), and it's down to arch code to
> > save/restore the current value where necessary.
> >
> > Am I missing some caveat with that approach?
> 
> To keep the address of the currently active shadow stack out of
> memory, the arm64 implementation clears this field when it loads x18
> and saves the current value before a context switch. The generic code
> doesn't expect the arch code to necessarily do so, but does allow it.
> This requires us to use __scs_base() when accessing the base pointer
> and to reset it in idle tasks before they're reused, hence
> scs_task_reset().

Ok. That'd be worth a comment somewhere, since it adds a number of
things which would otherwise be unnecessary.

IIUC this assumes an adversary who knows the address of a task's
thread_info, and has an arbitrary-read (to extract the SCS base from
thead_info) and an arbitrary-write (to modify the SCS area).

Assuming that's the case, I don't think this buys much. If said
adversary controls two userspace threads A and B, they only need to wait
until A is context-switched out or in userspace, and read A's SCS base
using B.

Given that, I'd rather always store the SCS base in the thread_info, and
simplify the rest of the code manipulating it.

Thanks,
Mark.
