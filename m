Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15ACC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D21820835
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556040134;
	bh=grcgrY3pMNmTEi4dSVR08aPt/HGdaYVJ6mWMikEzvUs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EMvsDzwbvTF6C5QWxhhW+7gVYwDdpUlvNO+3w8jsXQB/I9iYSw+F98AZksFaPtASp
	 TT7NAPg9qykfmrlWFtERnoFZ8j+SXQ+gvUwP//3IeRqqNF/mZILcovBWMClopNtJWu
	 xajrQ44T/abHqlLEvIJxP0HaSJMHhsmokuwY+UkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbfDWRWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:22:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbfDWRWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:22:12 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BBFF20835
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 17:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556040131;
        bh=grcgrY3pMNmTEi4dSVR08aPt/HGdaYVJ6mWMikEzvUs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TFvMj1OASrW2PlOIHHSLsph+0jExDlsQlVW4xOTve7R36W62W+x087LP6tQSXJ4aC
         /Wwb3/T4y2xj8k8EVsFm8/QssePYTsviHys+teFjv6sHZ4bDhb/3FSQVVDCxYApDKW
         Nx4Dhk2thpuVrL7Tg4VQYkerFchuWLxT3jgohfSs=
Received: by mail-wr1-f53.google.com with SMTP id c6so15542259wrm.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 10:22:11 -0700 (PDT)
X-Gm-Message-State: APjAAAXdWlcOsyyebqcwgKOGIaOzKAxpMXKF2A77bDh+xdl2cElk5XUG
        Av4fk2K7SkcCp+C8WOAoSAVNbEESUasZ9Wv6KByWsw==
X-Google-Smtp-Source: APXvYqz0dnWd+OqSFRxr4ToX7Ha0sJSPHAM3OlQKuWvWzyh44rFyzyCBlPmXOReWGFGQIUecUk+OfvdE/4oVBH2TZtI=
X-Received: by 2002:adf:fb4a:: with SMTP id c10mr3061569wrs.309.1556040129985;
 Tue, 23 Apr 2019 10:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190421160600.GA31092@avx2> <20190421182842.GD35603@gmail.com>
 <8B42CD57-9343-4234-A96D-80337BFFDF0E@zytor.com> <20190421211007.GA30444@avx2>
 <20190422103449.GA75723@gmail.com> <BFD71398-0BDC-4045-91E9-C70A22FF6E73@amacapital.net>
 <20190422220948.GB26031@avx2> <CALCETrWqPStQqv2xCJZLzsqTE-9L9U08CMApWyKD1zwjrrH4ow@mail.gmail.com>
 <20190423111258.GA23410@gmail.com>
In-Reply-To: <20190423111258.GA23410@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 23 Apr 2019 10:21:59 -0700
X-Gmail-Original-Message-ID: <CALCETrWtK4G7-o=pQoeyzLFTpiR9giGy2jYTU10xt6S8FsMk+Q@mail.gmail.com>
Message-ID: <CALCETrWtK4G7-o=pQoeyzLFTpiR9giGy2jYTU10xt6S8FsMk+Q@mail.gmail.com>
Subject: Re: [PATCH] x86_64: uninline TASK_SIZE
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 4:13 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Andy Lutomirski <luto@kernel.org> wrote:
>
> > > Saving 2KB on a defconfig is quite a lot.
> >
> > Saving 2kB of text by adding 8 bytes to thread_info seems rather
> > dubious to me.  You only need 256 tasks before you lose.  My
> > not-particularly-loaded laptop has 865 tasks right now.
>
> I was suggesting current->task_size or thread_info->task_size as a way to
> 100% avoid the function call overhead. Worth a tiny amount of RAM - even
> with 1 million tasks it's only 4MB of RAM. ;-)
>
> Some TASK_SIZE users are prominent syscalls: mmap(),
>
> > As a general principle, the mere existence of TIF_ADDR32 is a bug. The
> > value of that flag is *wrong* under the 32-bit variant of CRIU. How
> > about instead making some more progress toward getting rid of dubious
> > TASK_SIZE users?  I'm working on a little series to get rid of most of
> > them.  Meanwhile: it sure looks like a large fraction of the users are
> > confused as to whether TASK_SIZE is the highest user address or the
> > lowest non-user address.
>
> I really like that, replacing TASK_SIZE with *nothing* would be even
> faster.
>
> In fact instead of just reducing its usage I'd suggest removing TASK_SIZE
> altogether and renaming TASK_SIZE_MAX back to TASK_SIZE, or something
> like that - the confusion from the deceptively macro-ish naming of
> TASK_SIZE is real.
>
> The original commit of making TASK_SIZE dynamic on the task's compat flag
> was done in:
>
>   84929801e14d: [PATCH] x86_64: TASK_SIZE fixes for compatibility mode processes
>
> Here's the justification given:
>
>     Appended patch will setup compatibility mode TASK_SIZE properly.  This will
>     fix atleast three known bugs that can be encountered while running
>     compatibility mode apps.
>
>     a) A malicious 32bit app can have an elf section at 0xffffe000.  During
>        exec of this app, we will have a memory leak as insert_vm_struct() is
>        not checking for return value in syscall32_setup_pages() and thus not
>        freeing the vma allocated for the vsyscall page.  And instead of exec
>        failing (as it has addresses > TASK_SIZE), we were allowing it to
>        succeed previously.
>
>     b) With a 32bit app, hugetlb_get_unmapped_area/arch_get_unmapped_area
>        may return addresses beyond 32bits, ultimately causing corruption
>        because of wrap-around and resulting in SEGFAULT, instead of returning
>        ENOMEM.
>
>     c) 32bit app doing this below mmap will now fail.
>
>       mmap((void *)(0xFFFFE000UL), 0x10000UL, PROT_READ|PROT_WRITE,
>             MAP_FIXED|MAP_PRIVATE|MAP_ANON, 0, 0);
>
> I believe a) is addressed by getting rid of the vsyscall page - but it
> might also not be a current problem because the vsyscall page has its own
> gate-vma now.
>

I suspect that whatever issue this is predates my involvement in Linux
:)  The "gate" VMA, aka vsyscall, is at 0xffffffffff600000, and the
vDSO setup code shouldn't anywhere near that fragile.  Also, if this
really a bug, we have it for the 64-bit case, too, and TASK_SIZE isn't
going to help.


> b) shouldn't be an issue if the mmap allocator correctly treats the
> compat bit - this doesn't require generic TASK_SIZE variations though, as
> the mmap allocator is already specific to arch/x86/.

This was mostly fixed by the CRIU folks a while back, I think.

>
> c) is a variant of a) I believe, which should be fixed by now.
>
> I just looked through some of the current TASK_SIZE users, and *ALL* of
> them seem dubious to me, with the exception of the mmap allocators. In

Even the munmap one seems to be a bug.

> fact some of them seem to be active bugs:
>
> kernel/:
>
>  - PR_SET_MM_MAP, PR_SET_MM_MAP_SIZE, prctl_set_mm() et al. Ugh, what a
>    nasty prctl()! But besides that, the TASK_SIZE restriction to the ABI
>    looks questionable: if we offer this CRIU functionality then why
>    should it be impossible for a 32-bit CRIU task to switch to 64-bit?
>
>  - kernel/events/core.c: TASK_SIZE_MAX should be a fine filter here, in
>    fact it's probably *wrong* to restrict the profiling data here just
>    because the task happens to be in 32-bit compat mode.

Yep.  I have a patch fo rthis.

>
>  - kernel/rseq.c: is this TASK_SIZE restriction even required, wouldn't
>    TASK_SIZE_MAX be sufficient?

Presumably.

> So I concur 100% that most TASK_SIZE uses are questionable. In fact think
> 84929801e14d was a mistake, and we should effectively revert it
> carefully, by:
>
>  - First by moving almost all TASK_SIZE users over to TASK_SIZE_MAX,
>    analyzing and justifying the impact case by case.
>
>  - Then making the mmap allocators compat compatible (ha) without relying
>    on TASK_SIZE.

I have a somewhat hacky patch for this right now.

>
>  - Renaming TASK_SIZE back to TASK_SIZE_MAX and getting rid of the
>    TASK_SIZE and TASK_SIZE_MAX differentiation.
>
> Or am I missing some complication?

Seems like a great idea to me.

BTW, what the heck is up with get_gate_page()?  I'm struggling to
understand what it's even trying to do.  If there's an architecture
that allows a user program to mremap() or otherwise position its gate
VMA between TASK_SIZE and TASK_SIZE_MAX, then that code is going to
explode horribly.

A whole bunch of work in this direction is here:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=x86/fixes

It's almost entirely untested.
