Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365D8CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 20:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022C12054F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 20:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LoSD3OZa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfJYUtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 16:49:35 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40804 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfJYUte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 16:49:34 -0400
Received: by mail-vs1-f65.google.com with SMTP id v10so2364900vsc.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 13:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B01qVjfF1LUa0PK52bjL02zxaBRU3eQBI1v+W/4JeHk=;
        b=LoSD3OZaEiLCMCyYB7WH+dmOE3giL1Rn/oOCaqr8KZIUPs9oNnBAX6h7DIpplETh/t
         Omaop/utJ7AeIZA9zdG2w3rvVFoP7cm2sHz8InOOQrKWFNZwxRR99vskLqIZWxI+akK7
         Cn8Rjj+QMmBCU8FITbSo18rQdoyRMsKUvjpt6Ar8qszVQ65XaVmFB+VKjRWHMe854GK3
         ASqeAGPJEm1/jq31LvxmrmHzMfPkeiCJgRdv49M55kLjJgk0flgNf6HmaNmtlpmBIPyW
         bbCRcDAnLzrC5k0HlPPGloTl1WOPl/1JYKEDPIqkdq+OQXGt/qBiXYUzNyt2hflsRSK0
         sD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B01qVjfF1LUa0PK52bjL02zxaBRU3eQBI1v+W/4JeHk=;
        b=WtEkPP1Q/zXQnWNUAyF2K6nVgx45nSDzTZyoVEA7H6g83O9IQqJZ+CbFn972SHkrsJ
         qdOqmIYe7COh2v8s17exATboeW52wILaZ7/TiHkSmvK+4L584sJ7PI8dNpapaVnFSsQP
         T0HIUBhACN9FBZFKjtDKYBArIZc3CrCjiZhzeoBk7jKl7VRlmAXW+wBxdiEUnmkK2XRU
         /Tlqthts8L+r8BcqH1iZFhsNwBWFmkDxnRfiuYJL+ammEXaFv3HhLSNgs5/UgLCsKsZ/
         pCI2JWGYS6g/j8opMCiUEJuhZX734kI1wo4oz9RdXAH3Oi4bc9gnSjitb0ApELahOS66
         b5jA==
X-Gm-Message-State: APjAAAU1yyIXuIHYwYewZFvbuiH/Xs9XXwDA0txJpQgY8lyoXio7HYng
        wymqL/oswUvdXDObwqjqwHep0gy+qo8T55Zk4negHA==
X-Google-Smtp-Source: APXvYqzcB7+AMsKpePQsUZyUkWAMYpmk/dddGNr2g0bTzgYSUkedQgyZ3hkkauso52AIP99G7DNDWaPuxb1mAJtXqiU=
X-Received: by 2002:a67:ffc7:: with SMTP id w7mr3154037vsq.15.1572036572738;
 Fri, 25 Oct 2019 13:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191024225132.13410-1-samitolvanen@google.com> <20191024225132.13410-6-samitolvanen@google.com>
 <20191025105643.GD40270@lakrids.cambridge.arm.com>
In-Reply-To: <20191025105643.GD40270@lakrids.cambridge.arm.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 25 Oct 2019 13:49:21 -0700
Message-ID: <CABCJKuc+XiDRdqfvjwCF7y=1wX3QO0MCUpeu4Gdcz91+nmnEAQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/17] add support for Clang's Shadow Call Stack (SCS)
To:     Mark Rutland <mark.rutland@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 3:56 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > +#define SCS_SIZE     1024
>
> I think it'd be worth a comment on how this size was chosen. IIRC this
> empirical?

Correct. I'll add a comment.

> > +#define SCS_END_MAGIC        0xaf0194819b1635f6UL
>
> Keyboard smash? ... or is there a prize for whoever figures out the
> secret? ;)

It's a random number, so if someone figures out a secret in it,
they'll definitely deserve a prize. :)

> > +static inline void task_set_scs(struct task_struct *tsk, void *s)
> > +{
> > +     task_thread_info(tsk)->shadow_call_stack = s;
> > +}
>
> This should probably be named get and set, or have:
>
> #define task_scs(tsk)   (task_thread_info(tsk)->shadow_call_stack)
>
> ... which can have a trivial implementation as NULL for the !SCS case.

Sure, sounds good.

> For all the trivial wrappers you can put the implementation on the same
> line as the prototype. That makes it a bit easier to compare against the
> prototypes on the other side of the ifdeffery.
>
> e.g. this lot can be:
>
> static inline void *task_scs(struct task_struct *tsk) { return 0; }
> static inline void task_set_scs(struct task_struct *tsk, void *s) { }
> static inline void scs_init(void) { }

Agreed.

> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index bcdf53125210..ae7ebe9f0586 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -94,6 +94,7 @@
> >  #include <linux/livepatch.h>
> >  #include <linux/thread_info.h>
> >  #include <linux/stackleak.h>
> > +#include <linux/scs.h>
>
> Nit: alphabetical order, please (this should come before stackleak.h).

The includes in kernel/fork.c aren't in alphabetical order, so I just
added this to the end here.

> > +     retval = scs_prepare(p, node);
> > +     if (retval)
> > +             goto bad_fork_cleanup_thread;
>
> Can we please fold scs_prepare() into scs_task_init() and do this in
> dup_task_struct()? That way we set this up consistently in one place,
> where we're also allocating the regular stack.

Yes, that does sound cleaner. I'll change that.

> > +     scs_task_reset(idle);
>
> I'm a bit confused by this -- please see comments below on
> scs_task_reset().

> > +static inline void *__scs_base(struct task_struct *tsk)
> > +{
> > +     return (void *)((uintptr_t)task_scs(tsk) & ~(SCS_SIZE - 1));
> > +}
>
> We only ever assign the base to task_scs(tsk), with the current live
> value being in a register that we don't read. Are we expecting arch code
> to keep this up-to-date with the register value?
>
> I would have expected that we just leave this as the base (as we do for
> the regular stack in the task struct), and it's down to arch code to
> save/restore the current value where necessary.
>
> Am I missing some caveat with that approach?

To keep the address of the currently active shadow stack out of
memory, the arm64 implementation clears this field when it loads x18
and saves the current value before a context switch. The generic code
doesn't expect the arch code to necessarily do so, but does allow it.
This requires us to use __scs_base() when accessing the base pointer
and to reset it in idle tasks before they're reused, hence
scs_task_reset().

> > +     BUILD_BUG_ON(SCS_SIZE > PAGE_SIZE);
>
> It's probably worth a comment on why we rely on SCS_SIZE <= PAGE_SIZE.

Ack.

> > +static inline unsigned long *scs_magic(struct task_struct *tsk)
> > +{
> > +     return (unsigned long *)(__scs_base(tsk) + SCS_SIZE - sizeof(long));
>
> Slightly simpler as:
>
>         return (unsigned long *)(__scs_base(tsk) + SCS_SIZE) - 1;

Yes, that's a bit cleaner.

I'll fix these in v3. Thank you for the review!

Sami
