Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7B8C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1505C20656
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uBxB61F3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfLCXnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 18:43:03 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37420 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfLCXnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 18:43:02 -0500
Received: by mail-pj1-f67.google.com with SMTP id ep17so2165154pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 15:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1OxHtutk6hA28dBcP13TAqzlvKk2lKOdJ3WPlSn/d8Q=;
        b=uBxB61F3xk/UPfo0PM/WCB9wWcWlnn9tx+m5s5ni7sO5yubFDPbYeUwsd1Xr9ZLHXk
         qFffrP2WZ9fTLbOTRJCfW5JrjSTbEGBwKAIBQNV+3vHHKmL8kSBu87Xq2BeT1jOHSLVA
         +f6wqWc/QSIsa+BdofFpZg0vu986rtLubTKRduvc/tWYcIMDwAioR181kAdCURwk3s5c
         /EXNj4O6hQCPYh6Y4QChj1ba+yl2sYnOpUXPjkclbFZB4b/FYvPThE04WBsI0+SQG6qs
         q97LPxZ5HwzxA5J8lR4mn/sRMTztmCgzniV91J0Ku8WOuUmgBK958reThbkupRKeI++P
         H8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1OxHtutk6hA28dBcP13TAqzlvKk2lKOdJ3WPlSn/d8Q=;
        b=SEfoEyZhD3nJXPsiExMPvrUokMjAVGAcFT/gclINh+HiFjoHLKbz9qDpbtkY7tObGz
         oRH4aujPiuDoJhLpmKRIzByRLxK95NnpCf9RdTzPfoqkPKVELUo0FDUMJbXnV4y0qrSf
         eyc3AgtNfDtyWVeXR86RNwzBZw8ZYRyLXE8LsTYTxYqoRnxN8hX4u7yiIMCdx+mN7S8D
         ItlWbZlte5hE1auF67ub7LHN34gKQnABQa9PBOtsv8DMjywq6q3WyHhGCvDgg+OIZ6cp
         yvg2HqKXZIUWDZwtLWwPW3HE/QXLAhLUCiW4Kut1vbt1lMlywmpt4mXmtkDPosPt4Co5
         82Eg==
X-Gm-Message-State: APjAAAXkt9cFBC3pmLSxxH9IFjrxaAMGIBlEJ6tCftG/UQzY02jUfrl3
        oCTzROc4mVM6mW8oPl730zASLpzolmQabdYM+N5dRA==
X-Google-Smtp-Source: APXvYqx74YmiLdGue6ov0CGItqQOhr5aoFMW+ZHNwajbQUlkcMKQiACOe6MPfcXVaEk15NyKto8aP2Tqx74SBbu6mW0=
X-Received: by 2002:a17:902:8ec8:: with SMTP id x8mr519623plo.119.1575416581305;
 Tue, 03 Dec 2019 15:43:01 -0800 (PST)
MIME-Version: 1.0
References: <20191122185522.20582-1-ndesaulniers@google.com> <nycvar.YSQ.7.76.1911291614480.8537@knanqh.ubzr>
In-Reply-To: <nycvar.YSQ.7.76.1911291614480.8537@knanqh.ubzr>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 3 Dec 2019 15:42:50 -0800
Message-ID: <CAKwvOdmAFp=p=z8bhaRHf8uRhUBKpoAYtissyLTk5DC8f-=BUw@mail.gmail.com>
Subject: Re: [PATCH] arm: explicitly place .fixup in .text
To:     Nicolas Pitre <nico@fluxnic.net>,
        Manoj Gupta <manojgupta@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 1:33 PM Nicolas Pitre <nico@fluxnic.net> wrote:
>
> On Fri, 22 Nov 2019, Nick Desaulniers wrote:
>
> > From: Kees Cook <keescook@chromium.org>
> >
> > There's an implicit dependency on the section ordering of the orphaned
> > section .fixup that can break arm_copy_from_user if the linker places
> > the .fixup section before the .text section. Since .fixup is not
> > explicitly placed in the existing ARM linker scripts, the linker is free
> > to order it anywhere with respect to the rest of the sections.
> >
> > Multiple users from different distros (Raspbian, CrOS) reported kernel
> > panics executing seccomp() syscall with Linux kernels linked with LLD.
> >
> > Documentation/x86/exception-tables.rst alludes to the ordering
> > dependency. The relevant quote:
> >
> > ```
> > NOTE:
> > Due to the way that the exception table is built and needs to be ordered,
> > only use exceptions for code in the .text section.  Any other section
> > will cause the exception table to not be sorted correctly, and the
> > exceptions will fail.
> >
> > Things changed when 64-bit support was added to x86 Linux. Rather than
> > double the size of the exception table by expanding the two entries
> > from 32-bits to 64 bits, a clever trick was used to store addresses
> > as relative offsets from the table itself. The assembly code changed
> > from::
> >
> >     .long 1b,3b
> >   to:
> >           .long (from) - .
> >           .long (to) - .
> >
> > and the C-code that uses these values converts back to absolute addresses
> > like this::
> >
> >         ex_insn_addr(const struct exception_table_entry *x)
> >         {
> >                 return (unsigned long)&x->insn + x->insn;
> >         }
> > ```
> >
> > Since the addresses stored in the __ex_table are RELATIVE offsets and
> > not ABSOLUTE addresses, ordering the fixup anywhere that's not
> > immediately preceding .text causes the relative offset of the faulting
> > instruction to be wrong, causing the wrong (or no) address of the fixup
> > handler to looked up in __ex_table.
>
> This explanation makes no sense.
>
> The above is valid only when ARCH_HAS_RELATIVE_EXTABLE is defined. On
> ARM32 it is not, nor would it make sense to be.

Hmm...I thought that was the smoking gun. From the description in
Documentation, I thought they meant that exception table entry lookup
was changed to be homogeneous for 32b AND 64b arch's, but as you point
out they're not.  Now with the reference to ARCH_HAS_RELATIVE_EXTABLE,
I know to look through:
include/asm-generic/extable.h
include/linux/extable.h
lib/extable.c
kernel/extable.c
arch/arm/mm/extable.c
arch/arm/mm/fault.c (__do_kernel_fault() calls fixup_exception(),
which is of interest).

Looks like the exception table is sorted by address of faulting
instruction, then binary searched when an exception occurs.  Seems the
exception table is like an array of pairs of addresses (address of
faulting instruction from the get_user() call, address of fixup
handler) (when !ARCH_HAS_RELATIVE_EXTABLE), IIUC.

Reviewing the logs from the bugreport
(https://bugs.chromium.org/p/chromium/issues/detail?id=1020633#c44)
indeed the error string looks like the error message from
__do_kernel_fault() in arch/arm/mm/fault.c where a call to
fixup_exceptions() in arch/arm/mm/extable returned 1 because the call
to search_exception_tables() in kernel/extable.c returned NULL.

So I was right that `no address of the fixup handler to (be) looked up
in __ex_table`, but not quite right about *why* it fails to be looked
up.

search_exception_tables() in kernel/extable.c calls 3 functions:
1. search_kernel_exception_table()
2. search_module_extables()
3. search_bpf_extables()

So the next question is which one of the above should have found the
exception table entry, and why did it not when LLD placed the orphaned
.fixup section BEFORE .text?  All three of the above do some
processing on the address but in the end all call search_extable().

I really don't think kernel modules are involved.

Since we're observing the fault via a call to seccomp(), which IIUC
takes a BPF program when setting a filter (SECCOMP_SET_MODE_FILTER),
I'm curious to look into search_bpf_extables() first.  Maybe
constructing a BPF program involves insertion of special exception
handler?  Looks like bpf programs are stored in an rb_tree called
bpf_tree.  They have an auxiliary field that contains a pointer to an
exception table entry.  "Auxiliary" makes it sounds optional, and the
only assignment I can find to this field is in
arch/x86/net/bpf_jit_comp.c, so I doubt it's relevant for arm.  It
also just looks like it's zero initialized (bpf_prog_alloc_no_stats()
in kernel/bpf/core.c) for arch generic code.

That leaves just search_kernel_exception_table().  I wonder if it
fails because we put garbage entries in, or sorted it improperly?

Oh, and messing around with grep, it looks like entries to the
exception table can be sorted at build time rather than boot time via
CONFIG_BUILDTIME_EXTABLE_SORT?

I don't see the pr_notice from sort_main_extable() (kernel/extable.c
called from start_kernel() in init/main.c) in the bugreports:
https://bugs.chromium.org/p/chromium/issues/attachmentText?aid=421842
https://github.com/ClangBuiltLinux/linux/issues/282
(But IIRC, the log level may not be set to display these).

CONFIG_BUILDTIME_EXTABLE_SORT is selected by arch/arm/Kconfig if
CONFIG_MMU, which I highly suspect is already selected for the above
two reports. (Would an arm32 based chromebook not have an MMU? I doubt
it.)

So there may be an ordering dependency in scripts/sortextable.{c|h}?
Neither mention `fixup`.

Will continue debugging more tomorrow or later this week, but please
stop me if any of the above is also incorrect.  Some ideas for further
experiments:
- scripts/check_extable.sh sounds like some kind of validator.
Manoj/Nathan, I wonder if you linked the problematic kernel with LLD
than ran `./scripts/check_extable.sh vmlinux` if it would warn? Dunno
about all those command line flags though.
- if we apply a similar diff to the patch I posted, but force .fixup
to be before .text for BFD (as LLD is placing the orphaned section
currently), relinked with BFD and could reproduce the issue, that
seems like proof about the implicit section ordering.
```
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 319ccb10846a..adfb5297f359 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -58,6 +58,7 @@ SECTIONS
 #ifdef CONFIG_ARM_MPU
        . = ALIGN(PMSAv8_MINALIGN);
 #endif
+       .fixup : { *(.fixup) }
        .text : {                       /* Real text segment            */
                _stext = .;             /* Text and read-only data      */
                ARM_TEXT
```

-- 
Thanks,
~Nick Desaulniers
