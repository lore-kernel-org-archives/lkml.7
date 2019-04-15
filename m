Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971AFC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590A42183F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IKBmw3XY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfDORWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:22:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39684 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbfDORWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 13:22:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id i17so8934061pfo.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 10:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+mE2WlVOlQDHrdfVPs4jeGL5idXKFnti0WOfTPDaPjE=;
        b=IKBmw3XYshrRSOUFEm62H8OxKrfsb98fO6wqOtIlHQboaqcVJBDjZvk9bSTRIojxj7
         CZVeT6JFP3umwj70TV/PNcnCzRPacsSP4/3xQfqofeG69qtxI3Rk8H0FIsPWX16RAYQI
         pcLwKqaS1vTr6ELcTJyIAS26z55gpnpgE7EsPjP4FH0gWuLnLsbkw8LWFdhgUP8Y+/nx
         +Fl72Dkymnh/kFxZyltGKKiUXK++Iy2dA5iY0sMjVpaIi1GcVh/3VWgwC2jFdrSpYv67
         XQo2N6EZAF8rR2G5uThv4XJHrCpbbwMO3qbcwPaUGrbW++W5YPylPo5GKwVm2NSOLZCw
         uZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+mE2WlVOlQDHrdfVPs4jeGL5idXKFnti0WOfTPDaPjE=;
        b=bVNx4E2qr8/JSwZXxAjETbKeabnzADkmtbuj27aU+D1hOybh/Ot+ZBCa0Xn324xRIz
         SM7prOxiV8iNkihadX9rTHzku6fyAehxllI2hRnLW4syuatkY+SeABpg9ntsEb8WNYJV
         RPNb7yrj+Ja/tNFpok7DiGUtcNt6as/cF//fsmTxVAuzSAbn8Me+Jn3s4WQWZ9XUg7bO
         polFN0KENR7OWrSkrd8xx1LznL+egO3CHhW8AIinJ/inCvqn6EibXgzbHzopaAhSVDlh
         krJJhIc2N9Yh6MZP/boVsz5IOfPfpYE5fLYg36A6J8VG1eLtWz/Ja98vR+Ith6ntL40L
         eEuw==
X-Gm-Message-State: APjAAAXhW08IgpMHDbw3BQjOmWmbPfPG6QNK1Dnn7rNM4ZFAHHZ+4gbE
        /K00C8PS4a0mGNP4VA/DFLhEhpEJ1qY5ppc2sWaXGg==
X-Google-Smtp-Source: APXvYqza+JVamNwhFns15QJ/u0+HVDZBniaLdqhvh3PW8jJy8QWtXgv/E7ELaoUPZqA5lhxPPr1WalR5q93wlmF/+Gs=
X-Received: by 2002:a62:448d:: with SMTP id m13mr77381509pfi.182.1555348958872;
 Mon, 15 Apr 2019 10:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190415143821.GA46880@beast> <20190415170604.GA44415@lakrids.cambridge.arm.com>
In-Reply-To: <20190415170604.GA44415@lakrids.cambridge.arm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 15 Apr 2019 10:22:27 -0700
Message-ID: <CAKwvOdk_jFQKW2C2=925So_dvZ6dm03AXMZ9Nk+O1J2xyhE2EA@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: sysreg: make mrs_s and msr_s macros work with
 Clang and LTO
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Alex Matveev <alxmtvv@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 10:06 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Mon, Apr 15, 2019 at 07:38:21AM -0700, Kees Cook wrote:
> > From: Alex Matveev <alxmtvv@gmail.com>
> >
> > Clang's integrated assembler does not allow assembly macros defined
> > in one inline asm block using the .macro directive to be used across
> > separate asm blocks. LLVM developers consider this a feature and not a
> > bug, recommending code refactoring:
> >
> >   https://bugs.llvm.org/show_bug.cgi?id=19749
> >
> > As binutils doesn't allow macros to be redefined, this change uses
> > UNDEFINE_MRS_S and UNDEFINE_MSR_S to define corresponding macros
> > in-place and workaround gcc and clang limitations on redefining macros
> > across different assembler blocks.
> >
> > Specifically, the current state after preprocessing looks like this:
> >
> > asm volatile(".macro mXX_s ... .endm");
> > void f()
> > {
> >       asm volatile("mXX_s a, b");
> > }
> >
> > With GCC, it gives macro redefinition error because sysreg.h is included
> > in multiple source files, and assembler code for all of them is later
> > combined for LTO (I've seen an intermediate file with hundreds of
> > identical definitions).
> >
> > With clang, it gives macro undefined error because clang doesn't allow
> > sharing macros between inline asm statements.
> >
> > I also seem to remember catching another sort of undefined error with
> > GCC due to reordering of macro definition asm statement and generated
> > asm code for function that uses the macro.
> >
> > The solution with defining and undefining for each use, while certainly
> > not elegant, satisfies both GCC and clang, LTO and non-LTO.
> >
> > Signed-off-by: Alex Matveev <alxmtvv@gmail.com>
> > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > v3: split out patch as stand-alone, added more uses in irqflags,
> >     updated commit log, based on discussion in
> >     https://lore.kernel.org/patchwork/patch/851580/
> > ---
> >  arch/arm64/include/asm/irqflags.h | 12 +++++--
> >  arch/arm64/include/asm/kvm_hyp.h  |  8 +++--
> >  arch/arm64/include/asm/sysreg.h   | 55 +++++++++++++++++++++----------
> >  3 files changed, 53 insertions(+), 22 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> > index 43d8366c1e87..06d3987d1546 100644
> > --- a/arch/arm64/include/asm/irqflags.h
> > +++ b/arch/arm64/include/asm/irqflags.h
> > @@ -43,7 +43,9 @@ static inline void arch_local_irq_enable(void)
> >       asm volatile(ALTERNATIVE(
> >               "msr    daifclr, #2             // arch_local_irq_enable\n"
> >               "nop",
> > +             DEFINE_MSR_S
> >               "msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
> > +             UNDEFINE_MSR_S
>
> If we do need this, can we wrap this in a larger CPP macro that does the
> whole sequence of defining, using, and undefining the asm macros?

I agree that would be cleaner.  For example, __mrs_s/__msr_s can
ALMOST do this (be used in arch/arm64/include/asm/irqflags.h) except
for the input/output constraints.  Maybe the constraints can be
removed from the cpp macro definition, then the constraints be left to
the macro expansion sites?  That way the DEFINE_MXX_S/UNDEFINE_MXX_S
can be hidden in the cpp macro itself.

>
> It would be nice if we could simply rely on a more recent binutils these
> days, which supports the generic S<op0>_<op1>_<cn>_<Cm>_<op2> sysreg
> definition. That would mean we could get rid of the whole msr_s/mrs_s
> hack by turning that into a CPP macro which built that name.
>
> It looks like binutils has been able to do that since September 2014...
>
> Are folk using toolchains older than that to compile kernels?

Do you have a link to a commit?  If we can pinpoint the binutils
version, that might help.

Also, I look forward to this patch for use of Clang's integrated
assembler (regardless of LTO).  I remember getting frustrated trying
to figure out how to resolve this for both assemblers, and I had
forgotten this solution existed.
-- 
Thanks,
~Nick Desaulniers
