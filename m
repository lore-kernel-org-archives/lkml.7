Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA79DC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 16:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7318021774
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 16:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575046326;
	bh=KI3uxiq4vgVfVkbvGeaNtNf9vb3FxFoBDHBuP3alHnI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=c9fCM3DeA+zqKyYWMd7diJ3Qp5BEJLM3FOsqZhtLb9WMg7g1s5HyyfE7F4bONo8Qw
	 nJUZRlpuvthPwZhyOrYelzDkKhStrKlGuYx/jcxcDhlg63v08JFGOg4dnLUAbny8K/
	 nShVrDi6yqmKJnZDNZ5Nvhec3i+ZH6a/4vfHi9jI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfK2QwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 11:52:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:34906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbfK2QwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 11:52:04 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00BCA217D6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 16:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575046323;
        bh=KI3uxiq4vgVfVkbvGeaNtNf9vb3FxFoBDHBuP3alHnI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JQuk2XzlczKnZk615EiIIEqrGL6jtjLFjrNQiW5vz7RG0O1zsFeFV3JO/FSh8vyab
         OfAoB+NHYIyxjCiq0GzqqoDJ+7ZrIq3CLZ+0+HNIPuv/Aglv2LmzWLE5DAlEX7XcbZ
         MqBz1ZI8r1H1z5O4UOP784UN8CojmRJ/nbdl3tbE=
Received: by mail-wr1-f53.google.com with SMTP id n1so36009657wra.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 08:52:02 -0800 (PST)
X-Gm-Message-State: APjAAAXUFElcnXRAATSCRbD9MZ7WWkjrC2pBjauhs0+eSmGw8p01bkho
        mn5W4d0voGuDkg3y+8r0O+cc/PAgDsqJFjuturCX7g==
X-Google-Smtp-Source: APXvYqySVoFzuLEO3oO3co1aaIbt8yk2TeBtXkuz07Sp4DVXsjReprZWYpv4VdqlV7epxEjme3/3bbIDzH7Xne8LNsQ=
X-Received: by 2002:adf:f20b:: with SMTP id p11mr43830730wro.195.1575046321380;
 Fri, 29 Nov 2019 08:52:01 -0800 (PST)
MIME-Version: 1.0
References: <1570212969-21888-1-git-send-email-chang.seok.bae@intel.com>
 <alpine.DEB.2.21.1911151926380.28787@nanos.tec.linutronix.de>
 <20191115191200.GD22747@tassilo.jf.intel.com> <A78C989F6D9628469189715575E55B236B50834A@IRSMSX104.ger.corp.intel.com>
In-Reply-To: <A78C989F6D9628469189715575E55B236B50834A@IRSMSX104.ger.corp.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 29 Nov 2019 08:51:49 -0800
X-Gmail-Original-Message-ID: <CALCETrXc=-k3fQyxjBok0npjTMr6-Ho7+pkvzDUdG=b52Qz=9g@mail.gmail.com>
Message-ID: <CALCETrXc=-k3fQyxjBok0npjTMr6-Ho7+pkvzDUdG=b52Qz=9g@mail.gmail.com>
Subject: Re: [PATCH v9 00/17] Enable FSGSBASE instructions
To:     "Metzger, Markus T" <markus.t.metzger@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "luto@kernel.org" <luto@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
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

On Fri, Nov 29, 2019 at 6:56 AM Metzger, Markus T
<markus.t.metzger@intel.com> wrote:
>
> > On Fri, Nov 15, 2019 at 07:29:17PM +0100, Thomas Gleixner wrote:
> > > On Fri, 4 Oct 2019, Chang S. Bae wrote:
> > > >
> > > > Updates from v8 [10]:
> > > > * Internalized the interrupt check in the helper functions (Andy L.)
> > > > * Simplified GS base helper functions (Tony L.)
> > > > * Changed the patch order to put the paranoid path changes before the
> > > >   context switch changes (Tony L.)
> > > > * Fixed typos (Randy D.) and massaged a few sentences in the documentation
> > > > * Massaged the FSGSBASE enablement message
> > >
> > > That still lacks what Andy requested quite some time ago in the V8 thread:
> > >
> > >      https://lore.kernel.org/lkml/034aaf3a-a93d-ec03-0bbd-
> > 068e1905b774@kernel.org/
> > >
> > >   "I also think that, before this series can have my ack, it needs an
> > >    actual gdb maintainer to chime in, publicly, and state that they have
> > >    thought about and tested the ABI changes and that gdb still works on
> > >    patched kernels with and without FSGSBASE enabled.  I realize that there
> > >    were all kinds of discussions, but they were all quite theoretical, and
> > >    I think that the actual patches need to be considered by people who
> > >    understand the concerns.  Specific test cases would be nice, too."
> > >
> > > What's the state of this?
>
> On branch users/mmetzger/fsgs in sourceware.org/git/binutils-gdb.git,
> there's a GDB test covering the behavior discussed theoretically back then.
>
> It covers modifying the selector as well as the base from GDB and using
> the modified values for inferior calls as well as for resuming the inferior.
>
> Current kernels allow changing the selector and provide the resulting
> base back to the ptracer.  They also allow changing the base as long as
> the selector is zero.  That's the behavior we wanted to preserve IIRC.

The general kernel rule is that we don't break working applications.
Other than that, we're allowed to change the ABI if existing working
applications don't break.  I can't tell whether you wrote a test that
detects a behavior change or whether you wrote a test that tests
behavior that gdb or other programs actually rely on.

Certainly, with a 32-bit *gdb*, writing a nonzero value to FS or GS
using ptrace should change the base accordingly.  I think the current
patches get this wrong.

With a 64-bit gdb and a 32-bit inferior, in an ideal world, everything
would work just like full 64-bit, since that's how the hardware works.
But we don't necessary live in an ideal world.

With a 64-bit gdb and a 64-bit inferior, the inferior can set FS to
some nonzero value and then set FSBASE to an arbitrary 64-bit number,
and FS will retain its value.  ptrace needs to give gdb some way to
read, save, and restore this state.

I think the ideal behavior is that 64-bit ptrace callers should
control FS and FSBASE independently.  The question is: will that break
things?  If it will, then we'll need to make sure that there is an API
by which a debugger can independently control FS and FSBASE, and we'll
also need to make sure that whatever existing API debuggers use to
change FS and expect FSBASE to magically change as well continue to
have that effect.

>
> The patch series on branch fsgs_tip_5.4-rc1_100319 at
> github.com/changbae/Linux-kernel.git breaks tests that modify the
> selector and expect that to change the base.
>
> That kernel allows changing the base via ptrace but ignores changes
> to the selector.
>

I don't really understand your test, but I'm pretty sure I found a
couple bugs in the test:

  88 int
  89 switch_fs_read (unsigned int fs)
  90 {
  91   __asm__ volatile ("mov %0, %%fs" :: "rm"(fs) : "memory");
  92
  93   return read_fs ();
  94 }

This has fundamentally inconsistent behavior on Intel vs AMD CPUs.
Intel CPUs will clear FSBASE when you write 0 to FS.  Older AMD CPUs
do *not* clear FSBASE when you write 0 to FS.  Very very new AMD CPUs
behave more like Intel CPUs, I believe.

  40     struct user_desc ud;
  41     int errcode;
  42
  43     memset (&ud, 0, sizeof (ud));
  44     ud.entry_number = entry;
  45     ud.base_addr = (unsigned long) base;
  46     ud.limit = (unsigned int) size;
  47
  48     /* Some 64-bit systems declare ud.base_addr 'unsigned int' instead of
  49        'unsigned long'.
  50
  51        Combined with address space layout randomization, this might
  52        truncate our base address and result in a crash when we try to read
  53        segment-relative.
  54
  55        Checking the field size would exclude too many systems so we settle
  56        for checking whether we actually truncated the address.  */
  57
  58     if (ud.base_addr != (unsigned long) base)
  59       return 0u;

The base of a segment in a descriptor table is 32 bits, full stop.
This is a hardware limitation and has nothing to do with the kernel.
base_addr is correctly unsigned int in the kernel headers.  If you
actually find a system where base_addr is unsigned long and unsigned
long is 64 bits, then your test will malfunction.
