Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C169FC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 16:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88EFB21850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 16:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PO0SsL/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfKRQUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 11:20:12 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38296 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfKRQUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 11:20:12 -0500
Received: by mail-oi1-f193.google.com with SMTP id a14so15837703oid.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 08:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vFDYWWex6iRLOgdk1JIotXQ89HmdObyXOaIPkDF429E=;
        b=PO0SsL/cZc1EnX8IsvAlOlmSWDfgsXgUcbkWDJSbXhYQ/O16mAxzNXj7/s9qnhwllx
         cB8Ewh+z5jAOc5AzFHvCa+ijHyMj7OczSAP/+FrRirW9+7CL/AvkyrYDQMMxuOxMko5Q
         RCQhuC8/UpsuQOSPE76iq1xfbYUi646/9oWV6C9rB4eBNl+IxsldE7WFWM4ME32s/bgC
         3IJlETatFKFEYl/D9o/UtRXZUQb+hZBE7rruBnb+GoQLjqce6pt1GNSg5fyq3kcmdDVT
         x5e7jbPBVJthBahav/hfIvVeYdFq2Ez/ECRux1+0tA0uyNMbGKdnoW5JwjmuZ8NZjHX3
         iMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vFDYWWex6iRLOgdk1JIotXQ89HmdObyXOaIPkDF429E=;
        b=YFszVrSl23WYbNbVNSKpxUR/D3AZUk7IEj8JlQbyIto8NPEviTHVp+KpFOEDOr5Gw8
         +pNIsjDlIjqTikZmt3n+oYwDKaP7QPo22Uw/4DVrKIXQQzO+E07KG2nkThw1jAu+rNHv
         WB4/851TLVX9kE2UcEnWWKq6iCACSjsT4bVn8D8nk95dWcbmy4BZ+DM+3YVk5Dpf/XIu
         XngAVotQCQSFgWdRPKbL+ixMUHWFz5rJ6P2K3hMvr1NRwsBZqX9/euMwf/hzivl1pfRU
         k2sJyMaDtfWd5Gw3VCtG8ttZZByx7s3yux9trb+0k0K/C3vJEakH/X5iOPeU69SEGA/k
         6z1Q==
X-Gm-Message-State: APjAAAUxppl50+k7Peqo4Vl+KcRdp9UJjmvPmo9brR+l7+Avyaa3J72l
        H3M5wO/T3tixZlKZMj73TvjiI0XsZe4gRg6ONlyYMw==
X-Google-Smtp-Source: APXvYqw+KKzzd/AE/OnyrneLv5VHUUg/59mvCFzaf/yHa5uT6qanRxc07y7qoK/vdP4xLBMcOay5oq9TfQigZrTlbB4=
X-Received: by 2002:aca:ccd1:: with SMTP id c200mr21380309oig.157.1574094010691;
 Mon, 18 Nov 2019 08:20:10 -0800 (PST)
MIME-Version: 1.0
References: <20191115191728.87338-1-jannh@google.com> <20191115191728.87338-2-jannh@google.com>
 <20191118142144.GC6363@zn.tnic> <CACT4Y+bCOr=du1QEg8TtiZ-X6U+8ZPR4N07rJOeSCsd5h+zO3w@mail.gmail.com>
In-Reply-To: <CACT4Y+bCOr=du1QEg8TtiZ-X6U+8ZPR4N07rJOeSCsd5h+zO3w@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 18 Nov 2019 17:19:44 +0100
Message-ID: <CAG48ez1AWW7FkvU31ahy=0ZiaAreSMz=FFA0u8-XkXT9hNdWKA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] x86/traps: Print non-canonical address on #GP
To:     Dmitry Vyukov <dvyukov@google.com>
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

On Mon, Nov 18, 2019 at 5:03 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> On Mon, Nov 18, 2019 at 3:21 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Fri, Nov 15, 2019 at 08:17:27PM +0100, Jann Horn wrote:
> > >  dotraplinkage void
> > >  do_general_protection(struct pt_regs *regs, long error_code)
> > >  {
> > > @@ -547,8 +581,15 @@ do_general_protection(struct pt_regs *regs, long error_code)
> > >                       return;
> > >
> > >               if (notify_die(DIE_GPF, desc, regs, error_code,
> > > -                            X86_TRAP_GP, SIGSEGV) != NOTIFY_STOP)
> > > -                     die(desc, regs, error_code);
> > > +                            X86_TRAP_GP, SIGSEGV) == NOTIFY_STOP)
> > > +                     return;
> > > +
> > > +             if (error_code)
> > > +                     pr_alert("GPF is segment-related (see error code)\n");
> > > +             else
> > > +                     print_kernel_gp_address(regs);
> > > +
> > > +             die(desc, regs, error_code);
> >
> > Right, this way, those messages appear before the main "general
> > protection ..." message:
> >
> > [    2.434372] traps: probably dereferencing non-canonical address 0xdfff000000000001
> > [    2.442492] general protection fault: 0000 [#1] PREEMPT SMP
> >
> > Can we glue/merge them together? Or is this going to confuse tools too much:
> >
> > [    2.542218] general protection fault while derefing a non-canonical address 0xdfff000000000001: 0000 [#1] PREEMPT SMP
> >
> > (and that sentence could be shorter too:
> >
> >         "general protection fault for non-canonical address 0xdfff000000000001"
> >
> > looks ok to me too.)
>
> This exact form will confuse syzkaller crash parsing for Linux kernel:
> https://github.com/google/syzkaller/blob/1daed50ac33511e1a107228a9c3b80e5c4aebb5c/pkg/report/linux.go#L1347
> It expects a "general protection fault:" line for these crashes.
>
> A graceful way to update kernel crash messages would be to add more
> tests with the new format here:
> https://github.com/google/syzkaller/tree/1daed50ac33511e1a107228a9c3b80e5c4aebb5c/pkg/report/testdata/linux/report
> Update parsing code. Roll out new version. Update all other testing
> systems that detect and parse kernel crashes. Then commit kernel
> changes.

So for syzkaller, it'd be fine as long as we keep the colon there?
Something like:

general protection fault: derefing non-canonical address
0xdfff000000000001: 0000 [#1] PREEMPT SMP

And it looks like the 0day test bot doesn't have any specific pattern
for #GP, it seems to just look for the panic triggered by
panic-on-oops as far as I can tell (oops=panic in lkp-exec/qemu, no
"general protection fault" in etc/dmesg-kill-pattern).

> An unfortunate consequence of offloading testing to third-party systems...

And of not having a standard way to signal "this line starts something
that should be reported as a bug"? Maybe as a longer-term idea, it'd
help to have some sort of extra prefix byte that the kernel can print
to say "here comes a bug report, first line should be the subject", or
something like that, similar to how we have loglevels...
