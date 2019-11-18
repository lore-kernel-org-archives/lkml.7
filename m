Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B84C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 16:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC355218AE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 16:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pt744SvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfKRQ3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 11:29:55 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37958 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfKRQ3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 11:29:55 -0500
Received: by mail-qv1-f68.google.com with SMTP id q19so6782548qvs.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 08:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EWpMW0feycxyW1VyPAp6s2ygtKt8fZ0jnVixWgUidTo=;
        b=Pt744SvNC62j6opLgPWAFSwqWlUntb6xcrd1f5fnDvNbHG1WGPOuFs7TkWF8poPM9u
         wQEr626LBed+U9NMcY06zOUyfJHkaxDQLnC6Sp2QwCsEPj6CSDf70MfcTo9GVQ/y1fG7
         vXUkpZrGDuMjyH8j8LLYHeETAKAOzeK6ik62SAfPNuQB8Beg+t7MwBTtqKTklNrBmIlk
         9+OXNWb+918b1LePPSrscR+Y66OxczYn/6Plb20ABke2OSFkPxM67jDrbRsVAHFJeQyN
         yYjxZvXvkEGsxRAO9HwnmXXgSuD4qua+Q2qFlJGpUvODVvbq96P2u/1Xp3Kr9NsqUWwO
         832g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EWpMW0feycxyW1VyPAp6s2ygtKt8fZ0jnVixWgUidTo=;
        b=l7nj0rfqx1CD2qN5PWFozQoCxtSkXHB5KC+q6+3lu7Cio07FtWlrKKAifUoetS4X2A
         sYiXzo/EsN4koKdR6zM5EZFhpnmUBq8ThXlZptkNdw5QSAhe7Mze6BmfFn2ayOehFyhB
         Caf2809pgXzdRbmlqjGUqYkyzMD/Zy4DXEgh15TWTXergfq1jcu+iQ6NM7WRmaE74huZ
         EEYOEaWc+yDzrSLOV1PxRoa2jV/uRloc78h6mG2WJu08Zm3hnYVRu9vmDOioRUGA1XBv
         LtjuzwM5xLI7xMYrw55WWgEBao7Um5VkIFysDW4HX+aRXvniabYpYzqyW+uVYW77EgKK
         Gw6w==
X-Gm-Message-State: APjAAAVyRBdzT39uruXqepwaVpf8EOomUMV3YVEZZHN/jbcbtGMnY7Hk
        74nUAE4v0L88JXfsiABc0SCS0tYdgFP7VGpOqZB4Rg==
X-Google-Smtp-Source: APXvYqxiIw2nVCv0TUcs+kH0pDPIvJdcswUEX4H/6BU4rjqYn+mFj/JCmJHrtf0y+TwS+qcDuFaBevajGJ60AU1Kwcw=
X-Received: by 2002:a05:6214:8ee:: with SMTP id dr14mr27167149qvb.122.1574094593379;
 Mon, 18 Nov 2019 08:29:53 -0800 (PST)
MIME-Version: 1.0
References: <20191115191728.87338-1-jannh@google.com> <20191115191728.87338-2-jannh@google.com>
 <20191118142144.GC6363@zn.tnic> <CACT4Y+bCOr=du1QEg8TtiZ-X6U+8ZPR4N07rJOeSCsd5h+zO3w@mail.gmail.com>
 <CAG48ez1AWW7FkvU31ahy=0ZiaAreSMz=FFA0u8-XkXT9hNdWKA@mail.gmail.com>
In-Reply-To: <CAG48ez1AWW7FkvU31ahy=0ZiaAreSMz=FFA0u8-XkXT9hNdWKA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 18 Nov 2019 17:29:42 +0100
Message-ID: <CACT4Y+bfF86YY_zEGWO1sK0NwuYgr8Cx0wFewRDq0WL_GBgO0Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] x86/traps: Print non-canonical address on #GP
To:     Jann Horn <jannh@google.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 5:20 PM 'Jann Horn' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> On Mon, Nov 18, 2019 at 5:03 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Mon, Nov 18, 2019 at 3:21 PM Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > On Fri, Nov 15, 2019 at 08:17:27PM +0100, Jann Horn wrote:
> > > >  dotraplinkage void
> > > >  do_general_protection(struct pt_regs *regs, long error_code)
> > > >  {
> > > > @@ -547,8 +581,15 @@ do_general_protection(struct pt_regs *regs, long error_code)
> > > >                       return;
> > > >
> > > >               if (notify_die(DIE_GPF, desc, regs, error_code,
> > > > -                            X86_TRAP_GP, SIGSEGV) != NOTIFY_STOP)
> > > > -                     die(desc, regs, error_code);
> > > > +                            X86_TRAP_GP, SIGSEGV) == NOTIFY_STOP)
> > > > +                     return;
> > > > +
> > > > +             if (error_code)
> > > > +                     pr_alert("GPF is segment-related (see error code)\n");
> > > > +             else
> > > > +                     print_kernel_gp_address(regs);
> > > > +
> > > > +             die(desc, regs, error_code);
> > >
> > > Right, this way, those messages appear before the main "general
> > > protection ..." message:
> > >
> > > [    2.434372] traps: probably dereferencing non-canonical address 0xdfff000000000001
> > > [    2.442492] general protection fault: 0000 [#1] PREEMPT SMP
> > >
> > > Can we glue/merge them together? Or is this going to confuse tools too much:
> > >
> > > [    2.542218] general protection fault while derefing a non-canonical address 0xdfff000000000001: 0000 [#1] PREEMPT SMP
> > >
> > > (and that sentence could be shorter too:
> > >
> > >         "general protection fault for non-canonical address 0xdfff000000000001"
> > >
> > > looks ok to me too.)
> >
> > This exact form will confuse syzkaller crash parsing for Linux kernel:
> > https://github.com/google/syzkaller/blob/1daed50ac33511e1a107228a9c3b80e5c4aebb5c/pkg/report/linux.go#L1347
> > It expects a "general protection fault:" line for these crashes.
> >
> > A graceful way to update kernel crash messages would be to add more
> > tests with the new format here:
> > https://github.com/google/syzkaller/tree/1daed50ac33511e1a107228a9c3b80e5c4aebb5c/pkg/report/testdata/linux/report
> > Update parsing code. Roll out new version. Update all other testing
> > systems that detect and parse kernel crashes. Then commit kernel
> > changes.
>
> So for syzkaller, it'd be fine as long as we keep the colon there?
> Something like:
>
> general protection fault: derefing non-canonical address
> 0xdfff000000000001: 0000 [#1] PREEMPT SMP

Probably. Tests help a lot to answer such questions ;) But presumably
it should break parsing.

> And it looks like the 0day test bot doesn't have any specific pattern
> for #GP, it seems to just look for the panic triggered by
> panic-on-oops as far as I can tell (oops=panic in lkp-exec/qemu, no
> "general protection fault" in etc/dmesg-kill-pattern).
>
> > An unfortunate consequence of offloading testing to third-party systems...
>
> And of not having a standard way to signal "this line starts something
> that should be reported as a bug"? Maybe as a longer-term idea, it'd
> help to have some sort of extra prefix byte that the kernel can print
> to say "here comes a bug report, first line should be the subject", or
> something like that, similar to how we have loglevels...

This would be great.
Also a way to denote crash end.
However we have lots of special logic for subjects, not sure if kernel
could provide good subject:
https://github.com/google/syzkaller/blob/1daed50ac33511e1a107228a9c3b80e5c4aebb5c/pkg/report/linux.go#L537-L1588
Probably it could, but it won't be completely trivial. E.g. if there
is a stall inside of a timer function, it should give the name of the
actual timer callback as identity ("stall in timer_subsystem_foo"). Or
for syscalls we use more disambiguation b/c "in sys_ioclt" is not much
different than saying "there is a bug in kernel" :)
