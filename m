Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF01C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 21:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0522171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 21:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555103801;
	bh=scMJmpjNzoXcxWBmnorpgbPGsgZ52M7EB/p8Qgxi7Jk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QWP8/BhbK033KQf8qlmqsKfBpvJluVtjuyZDZ0k84iMvxbmylk8Gb9PqgqBzj6TE4
	 tdwdvIOvIlitPxJV2rKYxGU9iAeoDXpky1trcgH08nRAxT2nioKxEqIOasT0r1PpAq
	 K8fBGkXXD/qXVSO6c9X6W6K0Mc4wXyxXquGMxjMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfDLVQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 17:16:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfDLVQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 17:16:38 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E71FE218FF
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 21:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555103797;
        bh=scMJmpjNzoXcxWBmnorpgbPGsgZ52M7EB/p8Qgxi7Jk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OT82jNcBddOfrrP3efKaOAwmQ8D8E42h0AkjlsKpKqqLJePIVXrKvjoCFEp5/lnFf
         Q/zeAp0gR8ICtXMLRt1MYmAuEzdgglfwsYtLfwKSgEGbY2omTSt/QfZF96av6jpJvk
         SzbBKs6LHEBpVeUqxSynmWd6dk1Q2ls5FiX0eVqg=
Received: by mail-wm1-f42.google.com with SMTP id r186so1300435wmf.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 14:16:36 -0700 (PDT)
X-Gm-Message-State: APjAAAVcFeot0ZDo5nqD2monlmLttTs9TARXfWDVWI73JJvWo90DwnBa
        moTcovWviPq6N3h5Ns6lPQtCKcdX2RnVKGCAwiH7mg==
X-Google-Smtp-Source: APXvYqxJYkS9UPoBreObJziw5s9dPw+j34SXCtF5qd2P3ctZPysMi97EDpDU6d9rxIGzPYtvn5hfUCYsh7XtjyU2D2E=
X-Received: by 2002:a1c:4e19:: with SMTP id g25mr13208641wmh.9.1555103795421;
 Fri, 12 Apr 2019 14:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190408061358.21288-1-elena.reshetova@intel.com>
 <20190408124940.hb4d2mvwue7aydjj@treble> <20190410082642.GA35032@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C48943@IRSMSX102.ger.corp.intel.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C48B15@IRSMSX102.ger.corp.intel.com>
 <CALCETrWA8r6_zbfrYV-E-iykoEj-Fw=HeRQ5mAM4iSPrfU8jKw@mail.gmail.com> <2236FBA76BA1254E88B949DDB74E612BA4C4C052@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4C4C052@IRSMSX102.ger.corp.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 12 Apr 2019 14:16:23 -0700
X-Gmail-Original-Message-ID: <CALCETrUj1LymrDiZ02tY8xbr8a7kiimWq68D5DyuPfYsVLeO=Q@mail.gmail.com>
Message-ID: <CALCETrUj1LymrDiZ02tY8xbr8a7kiimWq68D5DyuPfYsVLeO=Q@mail.gmail.com>
Subject: Re: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 10:36 PM Reshetova, Elena
<elena.reshetova@intel.com> wrote:
>
> > On Wed, Apr 10, 2019 at 3:24 AM Reshetova, Elena
> > <elena.reshetova@intel.com> wrote:
> > >
> > >
> > > > > > On Mon, Apr 08, 2019 at 09:13:58AM +0300, Elena Reshetova wrote:
> > > > > > > diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> > > > > > > index 7bc105f47d21..38ddc213a5e9 100644
> > > > > > > --- a/arch/x86/entry/common.c
> > > > > > > +++ b/arch/x86/entry/common.c
> > > > > > > @@ -35,6 +35,12 @@
> > > > > > >  #define CREATE_TRACE_POINTS
> > > > > > >  #include <trace/events/syscalls.h>
> > > > > > >
> > > > > > > +#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
> > > > > > > +#include <linux/random.h>
> > > > > > > +
> > > > > > > +void *alloca(size_t size);
> > > > > > > +#endif
> > > > > > > +
> > > > > > >  #ifdef CONFIG_CONTEXT_TRACKING
> > > > > > >  /* Called on entry from user mode with IRQs off. */
> > > > > > >  __visible inline void enter_from_user_mode(void)
> > > > > > > @@ -273,6 +279,13 @@ __visible void do_syscall_64(unsigned long nr,
> > struct
> > > > > pt_regs *regs)
> > > > > > >  {
> > > > > > >         struct thread_info *ti;
> > > > > > >
> > > > > > > +#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
> > > > > > > +       size_t offset = ((size_t)prandom_u32()) % 256;
> > > > > > > +       char *ptr = alloca(offset);
> > > > > > > +
> > > > > > > +       asm volatile("":"=m"(*ptr));
> > > > > > > +#endif
> > > > > > > +
> > > > > > >         enter_from_user_mode();
> > > > > > >         local_irq_enable();
> > > > > > >         ti = current_thread_info();
> > > > > >
> > > > > > Would it make sense to also do this for the compat syscalls
> > > > > > (do_fast_syscall_32, do_int80_syscall_32)?
> > > > >
> > > > > Could someone please include the full patch, with justification and
> > > > > performance impact analysis etc.? Can only find the code part of the
> > > > > thread on lkml, which leaves out this context.
> > > > >
> > > >
> > > > Sorry, this is very weird, I cannot find it either from lkml, but it was sent there
> > > > to begin with (and as visible from reply-to headers).
> > > >
> > > > Do you want me to resent original version or with "do_fast_syscall_32,
> > > > do_int80_syscall_32" additions (I am finishing testing them now).
> > >
> > > I will resend the original x86_64 now since this is the one I tested and
> > > measured properly. The 32 bit changes seem to work fine inside my 32 bit VM,
> > > but since I don't have any real 32 bit HW, I am hesitant to send them out without
> > > real HW testing and measuring.
> > >
> > > This is the asm code for 32 bits (note it requires __builtin_alloca definition and not
> > just alloca,
> > > so I will change the 64 bit version to use it also):
> > >
> > > #ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
> > >     size_t offset = ((size_t)prandom_u32()) % 256;
> > > 0xc10025b6 call   0xc146f7d0 <prandom_u32>
> > > 0xc10025bb movzbl %al,%eax
> > >     char *ptr = __builtin_alloca(offset);
> > > 0xc10025be add    $0x12,%eax
> > > 0xc10025c1 and    $0x1fc,%eax
> > > 0xc10025c6 sub    %eax,%esp
> > > 0xc10025c8 lea    0x27(%esp),%eax
> > > 0xc10025cc and    $0xfffffff0,%eax
> > >
> > > Also, the result is 47 different random offsets produced,
> > > which is slightly better than 33 offsets for x86_64.
> > >
> >
> > I would suggest that you macro-ify this thing:
> >
> > #ifdef WHATEVER
> > #define add_random_stack_offset() do { void *addr = ... } while (0)
> > #else
> > #define add_random_stack_offset() do {} while (0)
> > #endif
> >
> > since you'll end up with more than one call site.
>
> Sure, will do. So, you are ok for this to be also called from do_fast_syscall_32
> and do_int80_syscall_32? I can send the resulting patch, just cannot test on any
> real 32 bit HW, only VM.
>

Sounds good to me.
