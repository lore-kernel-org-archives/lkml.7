Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921E3C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454F1205ED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575490862;
	bh=lO0lBJgLyqcoBTyVD8Q+rC9hNWl674FfWN001V3gRtU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eBOQFRcr5Ac+czOnF2aZ31l0vlfchmbT4FFSXOO843kgqYRmsAjyzHX/4D8YUyXki
	 N5QJmhlbFNeo8XLR6AatAwwM/h1sNNIjjL40I7yRSecldcVVDqxcydT+U4DmCuTUfI
	 cG87eKZb3YB+ZKHNamSe6XFx8q0ZFjT0ZkW7E02o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfLDUVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 15:21:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:40252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727887AbfLDUVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 15:21:00 -0500
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 153BE21826
        for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2019 20:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575490859;
        bh=lO0lBJgLyqcoBTyVD8Q+rC9hNWl674FfWN001V3gRtU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=syXInMnBdcHfggC2YZeZqDGzqn7ueusXNnCZSx+2ObCK9uquHBJk4i/VSJLYOgdbO
         CM+zsK5chs3dFq6YujvKCbZkfD3LIGkOXt9MlkweLEdTSvVL66cMs5LYA2lfHO/RMC
         M6I1sTY9A0N8USjX79MsWlwQw6t/7zolppmive5c=
Received: by mail-wm1-f45.google.com with SMTP id t14so1162293wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 12:20:59 -0800 (PST)
X-Gm-Message-State: APjAAAWjdU06m8zx20rJ70AP9XrjhNKWfixGbQLVtre5QShEaq+TUWz8
        z0sP93wrmER2GnUzJwHqlCu+vX7VSvqP+tyqfypONw==
X-Google-Smtp-Source: APXvYqyfNBgNEYvvwr7qmo50hagGPvMbA1TIN+lBkJd1e3JL28NxNFF/kEYPl6ljbu6ey3PBWGE3dz+jzD87ivwzg9M=
X-Received: by 2002:a1c:9c54:: with SMTP id f81mr1523186wme.89.1575490857350;
 Wed, 04 Dec 2019 12:20:57 -0800 (PST)
MIME-Version: 1.0
References: <1570212969-21888-1-git-send-email-chang.seok.bae@intel.com>
 <alpine.DEB.2.21.1911151926380.28787@nanos.tec.linutronix.de>
 <20191115191200.GD22747@tassilo.jf.intel.com> <A78C989F6D9628469189715575E55B236B50834A@IRSMSX104.ger.corp.intel.com>
 <CALCETrXc=-k3fQyxjBok0npjTMr6-Ho7+pkvzDUdG=b52Qz=9g@mail.gmail.com> <A78C989F6D9628469189715575E55B236B508C1A@IRSMSX104.ger.corp.intel.com>
In-Reply-To: <A78C989F6D9628469189715575E55B236B508C1A@IRSMSX104.ger.corp.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 4 Dec 2019 12:20:46 -0800
X-Gmail-Original-Message-ID: <CALCETrWb9jvwOPuupet4n5=JytbS-x37bnn=THniv_d8cNvf_Q@mail.gmail.com>
Message-ID: <CALCETrWb9jvwOPuupet4n5=JytbS-x37bnn=THniv_d8cNvf_Q@mail.gmail.com>
Subject: Re: [PATCH v9 00/17] Enable FSGSBASE instructions
To:     "Metzger, Markus T" <markus.t.metzger@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Pedro Alves <palves@redhat.com>,
        Simon Marchi <simark@simark.ca>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 2, 2019 at 12:23 AM Metzger, Markus T
<markus.t.metzger@intel.com> wrote:
>
> > On Fri, Nov 29, 2019 at 6:56 AM Metzger, Markus T
> > <markus.t.metzger@intel.com> wrote:
> > >
> > > > On Fri, Nov 15, 2019 at 07:29:17PM +0100, Thomas Gleixner wrote:
> > > > > On Fri, 4 Oct 2019, Chang S. Bae wrote:
> > > > > >
> > > > > > Updates from v8 [10]:
> > > > > > * Internalized the interrupt check in the helper functions (Andy L.)
> > > > > > * Simplified GS base helper functions (Tony L.)
> > > > > > * Changed the patch order to put the paranoid path changes before the
> > > > > >   context switch changes (Tony L.)
> > > > > > * Fixed typos (Randy D.) and massaged a few sentences in the
> > documentation
> > > > > > * Massaged the FSGSBASE enablement message
> > > > >
> > > > > That still lacks what Andy requested quite some time ago in the V8 thread:
> > > > >
> > > > >      https://lore.kernel.org/lkml/034aaf3a-a93d-ec03-0bbd-
> > > > 068e1905b774@kernel.org/
> > > > >
> > > > >   "I also think that, before this series can have my ack, it needs an
> > > > >    actual gdb maintainer to chime in, publicly, and state that they have
> > > > >    thought about and tested the ABI changes and that gdb still works on
> > > > >    patched kernels with and without FSGSBASE enabled.  I realize that there
> > > > >    were all kinds of discussions, but they were all quite theoretical, and
> > > > >    I think that the actual patches need to be considered by people who
> > > > >    understand the concerns.  Specific test cases would be nice, too."
> > > > >
> > > > > What's the state of this?
> > >
> > > On branch users/mmetzger/fsgs in sourceware.org/git/binutils-gdb.git,
> > > there's a GDB test covering the behavior discussed theoretically back then.
> > >
> > > It covers modifying the selector as well as the base from GDB and using
> > > the modified values for inferior calls as well as for resuming the inferior.
> > >
> > > Current kernels allow changing the selector and provide the resulting
> > > base back to the ptracer.  They also allow changing the base as long as
> > > the selector is zero.  That's the behavior we wanted to preserve IIRC.
> >
> > The general kernel rule is that we don't break working applications.
> > Other than that, we're allowed to change the ABI if existing working
> > applications don't break.  I can't tell whether you wrote a test that
> > detects a behavior change or whether you wrote a test that tests
> > behavior that gdb or other programs actually rely on.
>
> Well, that's a tough question.  The test covers GDB's behavior on today's
> systems.  GDB itself does not actually rely on that behavior.  That is, GDB
> itself wouldn't break.  You couldn't do all that you could do with it before,
> though.

GDB does rely on at least some behavior.  If I tell gdb to call a
function on my behalf, doesn't it save the old state, call the
function, and then restore the state?  Surely it expects the restore
operation to actually restore the state.

>
> It would be GDB's users that are affected.  How do you tell if anyone is
> actually relying on it?

No clue.  But at least if this type of use is mostly interactive, then
users should be that badly affected.

It also helps that very, very few 64-bit applications use nonzero
segments at all.  They used to because of a kernel optimization to
automatically load a segment if an FS or GSBASE less than 4GB was
requested, but that's been gone for a while.  Calling
set_thread_area() at all in a 64-bit program requires considerable
gymnastics, and distributions can and do disable modify_ldt() outright
without significant ill effects.

So we're mostly talking about compatibility with 32-bit programs and
exotic users like Wine and DOSEMU.

>
>
> > Certainly, with a 32-bit *gdb*, writing a nonzero value to FS or GS
> > using ptrace should change the base accordingly.  I think the current
> > patches get this wrong.
> >
> > With a 64-bit gdb and a 32-bit inferior, in an ideal world, everything
> > would work just like full 64-bit, since that's how the hardware works.
>
> Not sure what you mean.  The h/w runs in compatibility mode and the
> inferior cannot set the base directly, can it?

I think there's a general impedance mismatch between gdb and the
kernel/hw here.  On Linux on a 64-bit machine, there's isn't really a
strong concept of a "32-bit process" versus a "64-bit process".  All
tasks have 64-bit values in RAX, all tasks have R8-R15, all tasks have
a GDT and an LDT, etc.  "32-bit tasks" are merely tasks that happen to
be running with a compatibility selector loaded into CS at the time.
Tasks can and do switch freely between compatibility and long mode
using LJMP or LRET.  As far as I can tell, however, gdb doesn't really
understand this and thinks that 32-bit tasks are their own special
thing.

This causes me real problems: gdb explodes horribly if I connect gdb
to QEMU's gdbserver (qemu -s) and try to debug during boot when the
inferior switches between 32-bit and long mode.

As far as FSGSBASE goes, a "32-bit task" absolutely can set
independent values in FS and FSBASE, although it's awkward to do so:
the task would have to do a far transfer to long mode, then WRFSBASE,
then far transfer back to compat mode.  But this entire sequence of
events could occur without entering the kernel at all, and the ptrace
API should be able to represent the result.  I think that, ideally, a
64-bit debugger would understand the essential 64-bitness of even
compat tasks and work sensibly.  I don't really expect gdb to be able
to do this any time soon, though.

>
>
> > But we don't necessary live in an ideal world.
> >
> > With a 64-bit gdb and a 64-bit inferior, the inferior can set FS to
> > some nonzero value and then set FSBASE to an arbitrary 64-bit number,
> > and FS will retain its value.  ptrace needs to give gdb some way to
> > read, save, and restore this state.
>
> With Chang's patch series, that actually works.  You can set FS and then
> set FSBASE without setting FS to zero previously.  The tests do not cover
> that since on current system that leads to the inferior crashing in read_fs().
>
>
> > I think the ideal behavior is that 64-bit ptrace callers should
> > control FS and FSBASE independently.  The question is: will that break
> > things?  If it will, then we'll need to make sure that there is an API
> > by which a debugger can independently control FS and FSBASE, and we'll
> > also need to make sure that whatever existing API debuggers use to
> > change FS and expect FSBASE to magically change as well continue to
> > have that effect.
>
> We had discussed this some time ago and proposed the following behavior: "
> https://lore.kernel.org/lkml/1521481767-22113-15-git-send-email-chang.seok.bae@intel.com/
>
>         In a summary, ptracer's update on FS/GS selector and base
>         yields such results on tracee's base:
>         - When FS/GS selector only changed (to nonzero), fetch base
>         from GDT/LDT (legacy behavior)
>         - When FS/GS base (regardless of selector) changed, tracee
>         will have the base
> "

Indeed.  But I never understood how this behavior could be implemented
with the current ABI.  As I understand it, gdb only ever sets the
inferior register state by using a single ptrace() call to load the
entire state, which means that the kernel does not know whether just
FS is being written or whether FS and FSBASE are being written.

What actual ptrace() call does gdb use when a 64-bit gdb debugs a
64-bit inferior?  How about a 32-bit inferior?

>
> The ptracer would need to read registers back after changing the selector
> to get the updated base.

What would the actual API be?

I think it could make sense to add a whole new ptrace() command to
tell the tracee to, in effect, MOV a specified value to a segment
register.  This call would have the actual correct semantics in which
it would return an error code if the specified value is invalid and
would return 0 on success.  And then a second ptrace() call could be
issued to read out FSBASE or GSBASE if needed.  Would this be useful?
What gdb commands would invoke it?

>
> The only time when both change at the same time, then, is when registers
> are restored after returning from an inferior call.  And then, it's the base
> we want to take priority since we previously ensured that the base is always
> up-to-date.

Right.  But how does the kernel tell the difference?

> >
> > The base of a segment in a descriptor table is 32 bits, full stop.
> > This is a hardware limitation and has nothing to do with the kernel.
> > base_addr is correctly unsigned int in the kernel headers.  If you
> > actually find a system where base_addr is unsigned long and unsigned
> > long is 64 bits, then your test will malfunction.
>
> The modify_ldt(2) man page says: "
>        The user_desc structure is defined in <asm/ldt.h> as:
>
>            struct user_desc {
>                unsigned int  entry_number;
>                unsigned long base_addr;
>                unsigned int  limit;
>                unsigned int  seg_32bit:1;
>                unsigned int  contents:2;
>                unsigned int  read_exec_only:1;
>                unsigned int  limit_in_pages:1;
>                unsigned int  seg_not_present:1;
>                unsigned int  useable:1;
>            };
> "
>
> The declaration in asm/ldt.h actually defines base_addr as unsigned int.
>
> So my comment about 'some 64-bit systems' is wrong and should actually
> say 'all systems'.  Will fix.

>
> That by itself is not an issue as long as the main executable is not loaded at
> a high address.  I only ran into problems with that on some ubuntu system
> in our test pool.

In my test cases, I use mmap() with MAP_32BIT to avoid this issue.
