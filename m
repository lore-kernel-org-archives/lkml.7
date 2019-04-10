Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8029C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D022064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554907953;
	bh=g4osCrKq+22QLWsN69Fmuyv4USBLacWJISbR5jlUrTA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Izr5jcXWDfLnpLdDp3vg5eeaiRyGvk+oPn3vf3pJe5eFtg4toT9ZvS/bcZNvfKKQ4
	 pGXD4pR+V/KXUGBnscxdv6FYm9M8aC5X7O/l3bVSHqi+15xNGqUflgl+jpeLS09KGh
	 lCam7KHUn9GgmJqVirBStvohrSLvz31MQKdUGS5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732868AbfDJOwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:52:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728729AbfDJOwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:52:31 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39FB920820
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 14:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554907950;
        bh=g4osCrKq+22QLWsN69Fmuyv4USBLacWJISbR5jlUrTA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xgs/HTVYhoG6KrnGuRbI4c038u5UFoZ3iCC4T2xl7CW6LuqU7w+9SL3tTAXTUF3OP
         r5InUbk0o7NUAh32vvX6d6HI6GtFyw3JUHw5RhJyW9KY4Vjqy/4XD0u0VPRIPmyq4u
         JcAAIWofdYh3DJ/wmNDoJZmXck9D2KuxpXWe/1YY=
Received: by mail-wm1-f53.google.com with SMTP id n25so2936213wmk.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 07:52:30 -0700 (PDT)
X-Gm-Message-State: APjAAAX78c7gRQAUPY4qxvaMTnAfQoBBcpmtIrFJA6pP0d+4yeJJVJU4
        5Q8VAzDR9Nr98wzyLt2wL3kNLubN2vdxRnjlCIDR5A==
X-Google-Smtp-Source: APXvYqzvKQXbAeJwI/iVK740P1/LzXvKi03d8G3tFL6vNphZNoVaSBWVNZmjIrQzNxXowBE5dXqNN7m1570U5PZ3q1g=
X-Received: by 2002:a1c:6c04:: with SMTP id h4mr3171069wmc.135.1554907948798;
 Wed, 10 Apr 2019 07:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190408061358.21288-1-elena.reshetova@intel.com>
 <20190408124940.hb4d2mvwue7aydjj@treble> <20190410082642.GA35032@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C48943@IRSMSX102.ger.corp.intel.com> <2236FBA76BA1254E88B949DDB74E612BA4C48B15@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4C48B15@IRSMSX102.ger.corp.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 10 Apr 2019 07:52:17 -0700
X-Gmail-Original-Message-ID: <CALCETrWA8r6_zbfrYV-E-iykoEj-Fw=HeRQ5mAM4iSPrfU8jKw@mail.gmail.com>
Message-ID: <CALCETrWA8r6_zbfrYV-E-iykoEj-Fw=HeRQ5mAM4iSPrfU8jKw@mail.gmail.com>
Subject: Re: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
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

On Wed, Apr 10, 2019 at 3:24 AM Reshetova, Elena
<elena.reshetova@intel.com> wrote:
>
>
> > > > On Mon, Apr 08, 2019 at 09:13:58AM +0300, Elena Reshetova wrote:
> > > > > diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> > > > > index 7bc105f47d21..38ddc213a5e9 100644
> > > > > --- a/arch/x86/entry/common.c
> > > > > +++ b/arch/x86/entry/common.c
> > > > > @@ -35,6 +35,12 @@
> > > > >  #define CREATE_TRACE_POINTS
> > > > >  #include <trace/events/syscalls.h>
> > > > >
> > > > > +#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
> > > > > +#include <linux/random.h>
> > > > > +
> > > > > +void *alloca(size_t size);
> > > > > +#endif
> > > > > +
> > > > >  #ifdef CONFIG_CONTEXT_TRACKING
> > > > >  /* Called on entry from user mode with IRQs off. */
> > > > >  __visible inline void enter_from_user_mode(void)
> > > > > @@ -273,6 +279,13 @@ __visible void do_syscall_64(unsigned long nr, struct
> > > pt_regs *regs)
> > > > >  {
> > > > >         struct thread_info *ti;
> > > > >
> > > > > +#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
> > > > > +       size_t offset = ((size_t)prandom_u32()) % 256;
> > > > > +       char *ptr = alloca(offset);
> > > > > +
> > > > > +       asm volatile("":"=m"(*ptr));
> > > > > +#endif
> > > > > +
> > > > >         enter_from_user_mode();
> > > > >         local_irq_enable();
> > > > >         ti = current_thread_info();
> > > >
> > > > Would it make sense to also do this for the compat syscalls
> > > > (do_fast_syscall_32, do_int80_syscall_32)?
> > >
> > > Could someone please include the full patch, with justification and
> > > performance impact analysis etc.? Can only find the code part of the
> > > thread on lkml, which leaves out this context.
> > >
> >
> > Sorry, this is very weird, I cannot find it either from lkml, but it was sent there
> > to begin with (and as visible from reply-to headers).
> >
> > Do you want me to resent original version or with "do_fast_syscall_32,
> > do_int80_syscall_32" additions (I am finishing testing them now).
>
> I will resend the original x86_64 now since this is the one I tested and
> measured properly. The 32 bit changes seem to work fine inside my 32 bit VM,
> but since I don't have any real 32 bit HW, I am hesitant to send them out without
> real HW testing and measuring.
>
> This is the asm code for 32 bits (note it requires __builtin_alloca definition and not just alloca,
> so I will change the 64 bit version to use it also):
>
> #ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
>     size_t offset = ((size_t)prandom_u32()) % 256;
> 0xc10025b6 call   0xc146f7d0 <prandom_u32>
> 0xc10025bb movzbl %al,%eax
>     char *ptr = __builtin_alloca(offset);
> 0xc10025be add    $0x12,%eax
> 0xc10025c1 and    $0x1fc,%eax
> 0xc10025c6 sub    %eax,%esp
> 0xc10025c8 lea    0x27(%esp),%eax
> 0xc10025cc and    $0xfffffff0,%eax
>
> Also, the result is 47 different random offsets produced,
> which is slightly better than 33 offsets for x86_64.
>

I would suggest that you macro-ify this thing:

#ifdef WHATEVER
#define add_random_stack_offset() do { void *addr = ... } while (0)
#else
#define add_random_stack_offset() do {} while (0)
#endif

since you'll end up with more than one call site.
