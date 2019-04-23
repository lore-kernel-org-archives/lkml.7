Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8B3C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E9B21773
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfDWTpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:45:49 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:32810 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfDWTpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 15:45:49 -0400
X-Greylist: delayed 1197 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Apr 2019 15:45:49 EDT
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1hJ12s-0002YB-00; Tue, 23 Apr 2019 19:25:34 +0000
Date:   Tue, 23 Apr 2019 15:25:34 -0400
From:   Rich Felker <dalias@libc.org>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Jason Gunthorpe <jgg@mellanox.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, musl@lists.openwall.com,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [musl] Re: [PATCH] binfmt_elf: Update READ_IMPLIES_EXEC logic
 for modern CPUs
Message-ID: <20190423192534.GN23599@brightrain.aerifal.cx>
References: <20190423181210.GA2443@beast>
 <CAG48ez0CeTEGDuwr+qAGBwsqm+Drj0dkFfr6_UDc+g-xM4BpiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0CeTEGDuwr+qAGBwsqm+Drj0dkFfr6_UDc+g-xM4BpiA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 09:02:03PM +0200, Jann Horn wrote:
> +linux-api, +musl
> 
> On Tue, Apr 23, 2019 at 8:12 PM Kees Cook <keescook@chromium.org> wrote:
> > The READ_IMPLIES_EXEC work-around was designed for old CPUs lacking NX
> > (to have the visible permission flags on memory regions reflect reality:
> > they are all executable), and for old toolchains that lacked the ELF
> > PT_GNU_STACK marking (under the assumption than toolchains that couldn't
> > even specify memory protection flags may have it wrong for all memory
> > regions).
> >
> > This logic is sensible, but was implemented in a way that equated having
> > a PT_GNU_STACK marked executable as being as "broken" as lacking the
> > PT_GNU_STACK marking entirely. This is not a reasonable assumption
> > for CPUs that have had NX support from the start (or very close to
> > the start). This confusion has led to situations where modern 64-bit
> > programs with explicitly marked executable stack are forced into the
> > READ_IMPLIES_EXEC state when no such thing is needed. (And leads to
> > unexpected failures when mmap()ing regions of device driver memory that
> > wish to disallow VM_EXEC[1].)
> >
> > To fix this, elf_read_implies_exec() is adjusted on arm64 (where NX has
> > always existed and all toolchains include PT_GNU_STACK), and x86 is
> > adjusted to handle this combination of possible outcomes:
> >
> >               CPU: | lacks NX  | has NX, ia32     | has NX, x86_64   |
> >  ELF:              |           |                  |                  |
> >  ------------------------------|------------------|------------------|
> >  missing GNU_STACK | needs RIE | needs RIE        | no RIE           |
> >  GNU_STACK == RWX  | needs RIE | no RIE: stack X  | no RIE: stack X  |
> >  GNU_STACK == RW   | needs RIE | no RIE: stack NX | no RIE: stack NX |
> >
> > This has the effect of making binfmt_elf's EXSTACK_DEFAULT actually take
> > on the correct architecture default of being non-executable on arm64 and
> > x86_64, and being executable on ia32.
> 
> It's probably worth going a bit more into detail in this description
> on how libraries typically allocate thread stacks.
> 
> It looks like glibc will be fine; before commit 54ee14b3882
> (https://sourceware.org/git/?p=glibc.git;a=blobdiff;f=nptl/allocatestack.c;h=dc501650b8629eda4502f2016016f09106cfb526;hp=6ada1fe1381de104153c0627e27f09fe5ad02caa;hb=54ee14b3882;hpb=16a76cd23ce9d3924fa192395e730423e3dc8b36),
> thread stacks were always RWX, and since then, from what I can tell,
> thread stacks were executable depending on the executable's ELF
> headers (as parsed by glibc).
> 
> But e.g. musl's __pthread_create() seems to hardcode
> PROT_READ|PROT_WRITE, which I think would mean that if someone built a
> multithreaded program with nested functions and linked with musl, that
> program would stop working? Or maybe I'm just reading the code wrong.

musl intentionally/explicitly does not support executable stacks. If
you happen to get one from the kernel for the main thread, things
might happen to work, but it's unintended and unsupported
functionality.

Rich
