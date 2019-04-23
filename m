Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1639AC10F11
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 00:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D0A20859
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 00:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555980892;
	bh=X0n27fJoDdtD2RbG4dVrME8rlHDP9i0euoRWLm404Q8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uLznMijkSV4l6LTHbTBkvEoY0StbuTYhRRAI4+h3cFAVI9SIJ40XPVsCMEt6ccyPF
	 h/IWKQAB6fRsXq5oQs/hJTdX+aDifgViy/rCo0/m3aE14ec+EBuXaCe0VDcoCon7Xg
	 Lxhrm9Lh/ZUJkns7GVr6iX5adxlVMqqd91l8s/Qc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfDWAyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 20:54:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfDWAyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 20:54:51 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C85E52175B
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 00:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555980890;
        bh=X0n27fJoDdtD2RbG4dVrME8rlHDP9i0euoRWLm404Q8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EdxRAyEkIwjK2+nQVzBY9nvmYzLLzOt5jTUQijcOwjSWV4L09kSp7FYRwf/wesJdR
         cbtQND9kidtnCJQkH1vc0whhYcqZFaaHHjFVxXwnoN1ArvYjZToj5pSJzK2EsvfeE9
         cU5pFd8lz3nsonQUr3WnPUAnr74GPUJE5j16Jkgk=
Received: by mail-wr1-f47.google.com with SMTP id b1so6471472wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 17:54:49 -0700 (PDT)
X-Gm-Message-State: APjAAAW2YWt8utZ6x5lPR0Ecifsvel5oKWRHFGezbM5TJp+99p1Rlv7P
        UXjrX6LTVbb9upvhB7cirTHowH6OXqHeupj5z6TlBw==
X-Google-Smtp-Source: APXvYqzjKmNjncIWvmu8EQiIqdZi11bTpXU/ymHxfg1oCYOTAw7FEURSdOcjgUzGmqd16VGyvAUa9JuN40TAO5k+fk0=
X-Received: by 2002:a5d:63c7:: with SMTP id c7mr548265wrw.199.1555980888373;
 Mon, 22 Apr 2019 17:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190421160600.GA31092@avx2> <20190421182842.GD35603@gmail.com>
 <8B42CD57-9343-4234-A96D-80337BFFDF0E@zytor.com> <20190421211007.GA30444@avx2>
 <20190422103449.GA75723@gmail.com> <BFD71398-0BDC-4045-91E9-C70A22FF6E73@amacapital.net>
 <20190422220948.GB26031@avx2>
In-Reply-To: <20190422220948.GB26031@avx2>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 22 Apr 2019 17:54:35 -0700
X-Gmail-Original-Message-ID: <CALCETrWqPStQqv2xCJZLzsqTE-9L9U08CMApWyKD1zwjrrH4ow@mail.gmail.com>
Message-ID: <CALCETrWqPStQqv2xCJZLzsqTE-9L9U08CMApWyKD1zwjrrH4ow@mail.gmail.com>
Subject: Re: [PATCH] x86_64: uninline TASK_SIZE
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 3:09 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> On Mon, Apr 22, 2019 at 07:30:40AM -0700, Andy Lutomirski wrote:
> >
> >
> > > On Apr 22, 2019, at 3:34 AM, Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > >
> > > * Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > >
> > >>>>> +++ b/arch/x86/kernel/task_size_64.c
> > >>>>> @@ -0,0 +1,9 @@
> > >>>>> +#include <linux/export.h>
> > >>>>> +#include <linux/sched.h>
> > >>>>> +#include <linux/thread_info.h>
> > >>>>> +
> > >>>>> +unsigned long _task_size(void)
> > >>>>> +{
> > >>>>> +    return test_thread_flag(TIF_ADDR32) ? IA32_PAGE_OFFSET :
> > >>>> TASK_SIZE_MAX;
> > >>>>> +}
> > >>>>> +EXPORT_SYMBOL(_task_size);
> > >>>>
> > >>>> Good idea - but instead of adding yet another compilation unit, why not
> > >>>>
> > >>>> stick _task_size() into arch/x86/kernel/process_64.c, which is the
> > >>>> canonical place for process management related arch functions?
> > >>>>
> > >>>> Thanks,
> > >>>>
> > >>>>    Ingo
> > >>>
> > >>> Better yet... since TIF_ADDR32 isn't something that changes randomly,
> > >>> perhaps this should be a separate variable?
> > >>
> > >> Maybe. I only thought about putting every 32-bit related flag under
> > >> CONFIG_COMPAT to further eradicate bloat (and force everyone else to
> > >> keep an eye on it, ha-ha).
> > >
> > > Basically TIF_ADDR32 is only set for a task if set_personality_ia32() is
> > > called, which function is called in the following circumstances:
> > >
> > > - arch/x86/ia32/ia32_aout.c:load_aout_binary()
> > >
> > >   This is in exec(), when a new binary is loaded for the current task,
> > >   via search_binary_handler() and exec_binprm(). Ordering is
> > >   synchronous, AFAICS there can be no race between TASK_SIZE users and
> > >   the set_personality_ia32() call which is always for the current task.
> > >
> > > - in COMPAT_SET_PERSONALITY(), which through macro detours ends up being
> > >   in SET_PERSONALITY2(), which is used in fs/compat_binfmt_elf.c's
> > >   load_elf_binary(), used in a similar fashion in exec() as the AOUT
> > >   case above. One particular macro detour of note is that
> > >   fs/compat_binfmt_elf.c #includes fs/binfmt_elf.c and re-defines the
> > >   personality setting method to map to set_personality_ia32().
> > >
> > > When set_personality_ia32() is called then TIF_ADDR32 is set
> > > unconditionally, without any Kconfig variations.
> > >
> > > TIF_ADDR32 is cleared:
> > >
> > > - In set_personality_64bit(), when a 64-bit binary is loaded via
> > >   fs/binfmt_elf.c.
> > >
> > > - It also defaults to clear in the init task, which is inherited by the
> > >   initial kernel threads and any user-space task they might end up
> > >   executing.
> > >
> > > So the conclusion is that IMO we can safely put TASK_SIZE into a new
> > > thread_info()->task_size field, and:
> > >
> > > - change ->task_size to the 32-bit address space in
> > >   set_personality_ia32()
> > >
> > > - change ->task_size to teh 64-bit address space in the init task and in
> > >   set_personality_64bit().
> > >
> > > This should cover it I think, unless I missed something.
> > >
> >
> > Are there really enough TASK_SIZE users to justify any of this?
>
> Saving 2KB on a defconfig is quite a lot.

Saving 2kB of text by adding 8 bytes to thread_info seems rather
dubious to me.  You only need 256 tasks before you lose.  My
not-particularly-loaded laptop has 865 tasks right now.

As a general principle, the mere existence of TIF_ADDR32 is a bug.
The value of that flag is *wrong* under the 32-bit variant of CRIU.
How about instead making some more progress toward getting rid of
dubious TASK_SIZE users?  I'm working on a little series to get rid of
most of them.  Meanwhile: it sure looks like a large fraction of the
users are confused as to whether TASK_SIZE is the highest user address
or the lowest non-user address.
