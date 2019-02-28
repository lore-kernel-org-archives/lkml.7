Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDE8C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175222083D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbfB1Lxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 06:53:44 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:33709 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfB1Lxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 06:53:44 -0500
Received: by mail-ua1-f65.google.com with SMTP id q17so18586097uam.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 03:53:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TcJwoA8exl8075X2LFgyOfIWV3Nji8fTLObRm1fTh8E=;
        b=SsYQsTzn89HW7TBDh0hHrwj/P2gf+aSfWIlNFExb1/Y+vwekGGjXIi5hqZkOHrcFkx
         A1+MqgnmUcmkjyj65luVeEHtUrE45X9TOxZj3mNmXIxY8YROQNpxySH7/oxUUMs1fYfQ
         OX+HhRU+tABUleHJ64vft/lqR14HeAdSxJ4CN1HdGRZHl2xc9WQg41RVRPimOTj+5XrP
         PUNHciBjsQ+CBoWf13eI9lN3JAzeIFE1jdvGi0T+p1JIMhbTdW2d092/IRtfCwGu8Euj
         x3eYg7dm+sujR5GDblnmR3n6jGSQjMkDG5JALBr8lP7MTSjtmL1TB+5hNgLBvMOd8gkT
         LYsQ==
X-Gm-Message-State: AHQUAuYWVKuEp4UpKIidRTpAxgOX89HpGdSa0d7XFHr4cZ7EEUcwT/KK
        m8YwbFEv3CGCtPoRbfOKSUGdCetQCFV9sDAzzHA=
X-Google-Smtp-Source: AHgI3Ib2womPVlCd4lKB7w6IM2Uss8KBwWcgCMw7fXFICaM0ZB86xo+GzFqQ3C2ElIq0yYhPoCdDFn3T7uQTJKWhoB0=
X-Received: by 2002:a67:ead0:: with SMTP id s16mr4434066vso.63.1551354822670;
 Thu, 28 Feb 2019 03:53:42 -0800 (PST)
MIME-Version: 1.0
References: <20190227170608.27963-1-steven.price@arm.com> <20190227170608.27963-10-steven.price@arm.com>
 <CAMuHMdXCjuurBiFzQBeLPUFu=mmSowvb=37XyWmF_=xVhkQm4g@mail.gmail.com> <20190228113653.GB3766@rapoport-lnx>
In-Reply-To: <20190228113653.GB3766@rapoport-lnx>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Feb 2019 12:53:30 +0100
Message-ID: <CAMuHMdU5gn6ftAHNwHNPDoUy_JvcZLcXbkk1hvUmYxtfJRfTTQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/34] m68k: mm: Add p?d_large() definitions
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Steven Price <steven.price@arm.com>, Linux MM <linux-mm@kvack.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Thu, Feb 28, 2019 at 12:37 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> On Wed, Feb 27, 2019 at 08:27:40PM +0100, Geert Uytterhoeven wrote:
> > On Wed, Feb 27, 2019 at 6:07 PM Steven Price <steven.price@arm.com> wrote:
> > > walk_page_range() is going to be allowed to walk page tables other than
> > > those of user space. For this it needs to know when it has reached a
> > > 'leaf' entry in the page tables. This information is provided by the
> > > p?d_large() functions/macros.
> > >
> > > For m68k, we don't support large pages, so add stubs returning 0
> > >
> > > CC: Geert Uytterhoeven <geert@linux-m68k.org>
> > > CC: linux-m68k@lists.linux-m68k.org
> > > Signed-off-by: Steven Price <steven.price@arm.com>
> >
> > Thanks for your patch!
> >
> > >  arch/m68k/include/asm/mcf_pgtable.h      | 2 ++
> > >  arch/m68k/include/asm/motorola_pgtable.h | 2 ++
> > >  arch/m68k/include/asm/pgtable_no.h       | 1 +
> > >  arch/m68k/include/asm/sun3_pgtable.h     | 2 ++
> > >  4 files changed, 7 insertions(+)
> >
> > If the definitions are the same, why not add them to
> > arch/m68k/include/asm/pgtable.h instead?
>
> Maybe I'm missing something, but why the stubs have to be defined in
> arch/*/include/asm/pgtable.h rather than in include/asm-generic/pgtable.h?

That would even make more sense, given most architectures don't
support huge pages.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
