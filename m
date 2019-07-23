Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF48C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9BB217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563889387;
	bh=lpuL+EZ8Wd2LNNDofJ1Vmkit+yVhNieoW2WZW6wxTbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B/DhzqVIzBOzBb/HpGpL9jHw3qUQVltYCwib+EoWgpst5F3D01Nsv8SUUbkTSEEJG
	 HIAh87ri57PVgD9DATt7AsDQvXItnc+LUpD7WdoDpT0Wo5JO+Dpe7SkYyjBiopGVlP
	 x0kfj6u3R4EjJqotJf52pNRa6JRBAy0xOPsJX4Ig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732887AbfGWNnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:43:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbfGWNnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:43:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37E5E21738;
        Tue, 23 Jul 2019 13:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563889384;
        bh=lpuL+EZ8Wd2LNNDofJ1Vmkit+yVhNieoW2WZW6wxTbc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fpcz3JMEYktpZ1GlQru9DtoSrnMnRtqV3ChygsiiUFmQHUNjPPs9jDEDNbBHloUIE
         47EURATsT6Q2suaifGJ4beIGIT4pE2p+6gEh5BuYK5invipIKdderJYrukVowyC+t1
         ab680OX84BuQ1n7t7NP+EeXLcOFCpz0kMimqkECY=
Date:   Tue, 23 Jul 2019 15:43:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Mike Lothian <mike@fireburn.co.uk>,
        Tom Lendacky <thomas.lendacky@amd.com>, bhe@redhat.com,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, lijiang@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v3 1/2] x86/mm: Identify the end of the kernel area to be
 reserved
Message-ID: <20190723134302.GA7144@kroah.com>
References: <7db7da45b435f8477f25e66f292631ff766a844c.1560969363.git.thomas.lendacky@amd.com>
 <20190713145909.30749-1-mike@fireburn.co.uk>
 <alpine.DEB.2.21.1907141215350.1669@nanos.tec.linutronix.de>
 <CAHbf0-EPfgyKinFuOP7AtgTJWVSVqPmWwMSxzaH=Xg-xUUVWCA@mail.gmail.com>
 <alpine.DEB.2.21.1907151011590.1669@nanos.tec.linutronix.de>
 <CAHbf0-F9yUDJ=DKug+MZqsjW+zPgwWaLUC40BLOsr5+t4kYOLQ@mail.gmail.com>
 <alpine.DEB.2.21.1907151118570.1669@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907151140080.1669@nanos.tec.linutronix.de>
 <CAMe9rOqMqkQ0LNpm25yE_Yt0FKp05WmHOrwc0aRDb53miFKM+w@mail.gmail.com>
 <20190723130513.GA25290@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723130513.GA25290@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 03:05:14PM +0200, Greg KH wrote:
> On Mon, Jul 15, 2019 at 01:16:48PM -0700, H.J. Lu wrote:
> > On Mon, Jul 15, 2019 at 3:35 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > On Mon, 15 Jul 2019, Thomas Gleixner wrote:
> > > > On Mon, 15 Jul 2019, Mike Lothian wrote:
> > > > > That build failure is from the current tip of Linus's tree
> > > > > If the fix is in, then it hasn't fixed the issue
> > > >
> > > > The reverted commit caused a build fail with gold as well. Let me stare at
> > > > your issue.
> > >
> > > So with gold the build fails in the reloc tool complaining about that
> > > relocation:
> > >
> > >   Invalid absolute R_X86_64_32S relocation: __end_of_kernel_reserve
> > >
> > > The commit does:
> > >
> > > +extern char __end_of_kernel_reserve[];
> > > +
> > >
> > >  void __init setup_arch(char **cmdline_p)
> > >  {
> > > +       /*
> > > +        * Reserve the memory occupied by the kernel between _text and
> > > +        * __end_of_kernel_reserve symbols. Any kernel sections after the
> > > +        * __end_of_kernel_reserve symbol must be explicitly reserved with a
> > > +        * separate memblock_reserve() or they will be discarded.
> > > +        */
> > >         memblock_reserve(__pa_symbol(_text),
> > > -                        (unsigned long)__bss_stop - (unsigned long)_text);
> > > +                        (unsigned long)__end_of_kernel_reserve - (unsigned long)_text);
> > >
> > > So it replaces __bss_stop with __end_of_kernel_reserve here.
> > >
> > > --- a/arch/x86/kernel/vmlinux.lds.S
> > > +++ b/arch/x86/kernel/vmlinux.lds.S
> > > @@ -368,6 +368,14 @@ SECTIONS
> > >                 __bss_stop = .;
> > >         }
> > >
> > > +       /*
> > > +        * The memory occupied from _text to here, __end_of_kernel_reserve, is
> > > +        * automatically reserved in setup_arch(). Anything after here must be
> > > +        * explicitly reserved using memblock_reserve() or it will be discarded
> > > +        * and treated as available memory.
> > > +        */
> > > +       __end_of_kernel_reserve = .;
> > >
> > > And from the linker script __bss_stop and __end_of_kernel_reserve are
> > > exactly the same. From System.map (of a successful ld build):
> > >
> > > ffffffff82c00000 B __brk_base
> > > ffffffff82c00000 B __bss_stop
> > > ffffffff82c00000 B __end_bss_decrypted
> > > ffffffff82c00000 B __end_of_kernel_reserve
> > > ffffffff82c00000 B __start_bss_decrypted
> > > ffffffff82c00000 B __start_bss_decrypted_unused
> > >
> > > So how on earth can gold fail with that __end_of_kernel_reserve change?
> > >
> > > For some unknown reason it turns that relocation into an absolute
> > > one. That's clearly a gold bug^Wfeature and TBH, I'm more than concerned
> > > about that kind of behaviour.
> > >
> > > If we just revert that commit, then what do we achieve? We paper over the
> > > underlying problem, which is not really helping anything.
> > >
> > > Aside of that gold still fails to build the X32 VDSO and it does so for a
> > > very long time....
> > >
> > > Until we really understand what the problem is, this stays as is.
> > >
> > > @H.J.: Any insight on that?
> > >
> > 
> > Since building a workable kernel for different kernel configurations isn't a
> > requirement for gold, I don't recommend gold for kernel.
> 
> Um, it worked before this commit, and now it doesn't.  "Some" companies
> are using gold for linking the kernel today...

Oh nevermind, I see the rest of the thread where it's now not being
allowed, sorry for the noise.

greg k-h
