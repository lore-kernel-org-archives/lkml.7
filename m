Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34EDC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788BE20811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bi79DGW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfCHKIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 05:08:54 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:33279 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfCHKIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 05:08:53 -0500
Received: by mail-it1-f193.google.com with SMTP id f186so6088200ita.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 02:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Si2wbEn0bpZRXMirqHePsnD3QtKiJ7d5ojEcrTsVCRg=;
        b=Bi79DGW8fSaPbk8fXbqEqOoPn+ZLWYFFMzpzLOTQwB8oV+L9ni6jpC7wO02xgp4lE8
         /n8ZfaOAA1rv62e6eK+UImbLFrugs+HF2fyfwOjVV3lJ6enajEdMrUPNv2G4TYbLEf/9
         RUEqgmNoSHWVkv6ltNJcVeYXVE9suPf70YSSD94SWxCG/k0WIYHMJVeWxZO2juh/Z0mB
         xK5FEXoHWDibmg0W78YyCMEby0/JC/JYUdbbslrjhKO5Y0Op1C6QNc1f6mpMPJzDnvl0
         v8QWFFb/q2NP1uXmyhIkFj6MfRATiDVFuUkQYDz/7X2tYX5l9OSVAF0taclaNKAV/PoB
         O3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Si2wbEn0bpZRXMirqHePsnD3QtKiJ7d5ojEcrTsVCRg=;
        b=NabSgLlXdkFUdbHasf5i6FNEQ0fPR7Uwv0b6jRmJi3c0H+wbJ7FBGx4MKYjOCBFnUG
         rRx9Iajt2duz1ijjNutOvoJJ+1Bz/Pyy9seXAnWVVWTZ1gKAtPa8tq5EalMFw3mhyLIk
         pMZgWp27b905JhCiORZFhqz3561mFEbUAydBYeroCmfxD4l/Z7fA9X5g9jBJNbn0YoVu
         JEnTAQrWPhXV7g4bF5ZuHBGhTbaFiCCwSV5+62dvIWnCwaMuigoJ+aSwoJu1VeFhQjbD
         arlt5nc9QyvVQndhIVG3chIdKhdEMezvgflx1BTcuqs5Lh+s8odqfRXBY/dTok1kCK0l
         F5uA==
X-Gm-Message-State: APjAAAU/bMhry+i89bqbUAF3vynny9kEElMl+rh/m/akXwsV1zY4x6Em
        6TBENjCMb6b+vXbcChw8wVHSjZJATjJQnuCsM0aJTA==
X-Google-Smtp-Source: APXvYqw5oJ2LQIL9Cf8k9TiyzFeXuHP6K5ZYDzlQrcZVKgcDBE/IDWzlo1yuirW5MAVguspDoRXnHwGCxSSJlR0n33U=
X-Received: by 2002:a24:2e90:: with SMTP id i138mr8602756ita.158.1552039732274;
 Fri, 08 Mar 2019 02:08:52 -0800 (PST)
MIME-Version: 1.0
References: <20190307091514.2489338-1-arnd@arndb.de> <20190307091514.2489338-2-arnd@arndb.de>
 <CAKwvOdk=9j2HvtWOpdOEw9sm0Nh2oU3c1c6+hJJ5WMweAM=4EQ@mail.gmail.com>
 <20190307234850.nsbpkfcit3lnmytu@shell.armlinux.org.uk> <CAKv+Gu9VM2Vs3Q8+bPLsnt08dOmba6j54gnhiHkk=AHRzG8tVA@mail.gmail.com>
 <20190308095308.hjjrzdp4fzbbtnnv@shell.armlinux.org.uk>
In-Reply-To: <20190308095308.hjjrzdp4fzbbtnnv@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 8 Mar 2019 11:08:40 +0100
Message-ID: <CAKv+Gu_szWgw-KJASLYGJ6hJXh5K8WxnUn+UQkm7jUup=rqG6w@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: futex: make futex_detect_cmpxchg more reliable
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Mikael Pettersson <mikpe@it.uu.se>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Martin <Dave.Martin@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2019 at 10:53, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Fri, Mar 08, 2019 at 09:57:45AM +0100, Ard Biesheuvel wrote:
> > On Fri, 8 Mar 2019 at 00:49, Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Thu, Mar 07, 2019 at 11:39:08AM -0800, Nick Desaulniers wrote:
> > > > On Thu, Mar 7, 2019 at 1:15 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > >
> > > > > Passing registers containing zero as both the address (NULL pointer)
> > > > > and data into cmpxchg_futex_value_locked() leads clang to assign
> > > > > the same register for both inputs on ARM, which triggers a warning
> > > > > explaining that this instruction has unpredictable behavior on ARMv5.
> > > > >
> > > > > /tmp/futex-7e740e.s: Assembler messages:
> > > > > /tmp/futex-7e740e.s:12713: Warning: source register same as write-back base
> > > > >
> > > > > This patch was suggested by Mikael Pettersson back in 2011 (!) with gcc-4.4,
> > > > > as Mikael wrote:
> > > > >  "One way of fixing this is to make uaddr an input/output register, since
> > > > >  "that prevents it from overlapping any other input or output."
> > > > >
> > > > > but then withdrawn as the warning was determined to be harmless, and it
> > > > > apparently never showed up again with later gcc versions.
> > > > >
> > > > > Now the same problem is back when compiling with clang, and we are trying
> > > > > to get clang to build the kernel without warnings, as gcc normally does.
> > > > >
> > > > > Cc: Mikael Pettersson <mikpe@it.uu.se>
> > > > > Cc: Mikael Pettersson <mikpelinux@gmail.com>
> > > > > Cc: Dave Martin <Dave.Martin@arm.com>
> > > > > Link: https://lore.kernel.org/linux-arm-kernel/20009.45690.158286.161591@pilspetsen.it.uu.se/
> > > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > > ---
> > > > >  arch/arm/include/asm/futex.h | 10 +++++-----
> > > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/arch/arm/include/asm/futex.h b/arch/arm/include/asm/futex.h
> > > > > index 0a46676b4245..79790912974e 100644
> > > > > --- a/arch/arm/include/asm/futex.h
> > > > > +++ b/arch/arm/include/asm/futex.h
> > > > > @@ -110,13 +110,13 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
> > > > >         preempt_disable();
> > > > >         __ua_flags = uaccess_save_and_enable();
> > > > >         __asm__ __volatile__("@futex_atomic_cmpxchg_inatomic\n"
> > > > > -       "1:     " TUSER(ldr) "  %1, [%4]\n"
> > > > > -       "       teq     %1, %2\n"
> > > > > +       "1:     " TUSER(ldr) "  %1, [%2]\n"
> > > > > +       "       teq     %1, %3\n"
> > > > >         "       it      eq      @ explicit IT needed for the 2b label\n"
> > > > > -       "2:     " TUSER(streq) "        %3, [%4]\n"
> > > > > +       "2:     " TUSER(streq) "        %4, [%2]\n"
> > > > >         __futex_atomic_ex_table("%5")
> > > > > -       : "+r" (ret), "=&r" (val)
> > > > > -       : "r" (oldval), "r" (newval), "r" (uaddr), "Ir" (-EFAULT)
> > > > > +       : "+&r" (ret), "=&r" (val), "+&r" (uaddr)
> > > > > +       : "r" (oldval), "r" (newval), "Ir" (-EFAULT)
> > > > >         : "cc", "memory");
> > > > >         uaccess_restore(__ua_flags);
> > > >
> > > > Underspecification of constraints to extended inline assembly is a
> > > > common issue exposed by other compilers (and possibly but in-effect
> > > > infrequently compiler upgrades).
> > > > So the reordering of the constraints means the in the assembly (notes
> > > > for other reviewers):
> > > > %2 -> %3
> > > > %3 -> %4
> > > > %4 -> %2
> > > > Yep, looks good to me, thanks for finding this old patch and resending, Arnd!
> > >
> > > I don't see what is "underspecified" in the original constraints.
> > > Please explain.
> > >
> >
> > I agree that that statement makes little sense.
> >
> > As Russell points out in the referenced thread, there is nothing wrong
> > with the generated assembly, given that the UNPREDICTABLE opcode is
> > unreachable in practice. Unfortunately, we have no way to flag this
> > diagnostic as a known false positive, and AFAICT, there is no reason
> > we couldn't end up with the same diagnostic popping up for GCC builds
> > in the future, considering that the register assignment matches the
> > constraints. (We have seen somewhat similar issues where constant
> > folded function clones are emitted with a constant argument that could
> > never occur in reality [0])
> >
> > Given the above, the only meaningful way to invoke this function is
> > with different registers assigned to %3 and %4, and so tightening the
> > constraints to guarantee that does not actually result in worse code
> > (except maybe for the instantiations that we won't ever call in the
> > first place). So I think we should fix this.
> >
> > I wonder if just adding
> >
> > BUG_ON(__builtin_constant_p(uaddr));
> >
> > at the beginning makes any difference - this shouldn't result in any
> > object code differences since the conditional will always evaluate to
> > false at build time for instantiations we care about.
> >
> >
> > [0] https://lore.kernel.org/lkml/9c74d635-d0d1-0893-8093-ce20b0933fc7@redhat.com/
>
> What I'm actually asking is:
>
> The GCC manual says that input operands _may_ overlap output operands
> since GCC assumes that input operands are consumed before output
> operands are written.  This is an explicit statement.
>
> The GCC manual does not say that input operands may overlap with each
> other, and the behaviour of GCC thus far (apart from one version,
> presumably caused by a bug) has been that input operands are unique.
>

Not entirely. I have run into issues where GCC assumes that registers
that are only used for input operands are left untouched by the asm
code. I.e., if you put an asm() block in a loop and modify an input
register, your code may break on the next pass, even if the input
register does not overlap with an output register.

To me, that seems to suggest that whether or not inputs may overlap is
irrelevant, since they are not expected to be modified.

> Clang appears to be different: it allows input operands that are
> registers, and contain the same constant value to be the same physical
> register.
>
> The assertion is that the constraints are under-specified.  I am
> questioning that assertion.
>
> If the constraints are under-specified, I would have expected gcc-4.4's
> behaviour to have persisted, and we would've been told by gcc's
> developers to fix our code.  That didn't happen, and instead gcc seems
> to have been fixed.  So, my conclusion is that it is intentional that
> input operands to asm() do not overlap with themselves.
>

Whether we hit the error or not is not deterministic. Like in the
ilog2() case I quoted, GCC may decide to instantiate a constant folded
['curried', if you will] clone of a function, and so even if any calls
to futex_atomic_cmpxchg_inatomic() with constant NULL args for newval
and uaddr are compiled, it does not mean they occur like that in the C
code.

> It seems to me that the work-around for clang is to change every input
> operand to be an output operand with a "+&r" contraint - an operand
> that is both read and written by the "instruction", and that the operand
> is "earlyclobber".  For something that is really only read, that seems
> strange.
>
> Also, reading GCC's manual, it would appear that "+&" is wrong.
>
> `+'
>      Means that this operand is both read and written by the
>      instruction.
>
>      When the compiler fixes up the operands to satisfy the constraints,
>      it needs to know which operands are inputs to the instruction and
>      which are outputs from it.  `=' identifies an output; `+'
>      identifies an operand that is both input and output; all other
>                                    ^^^^^^^^^^^^^^^^^^^^^
>      operands are assumed to be input only.
>
> `&'
>      Means (in a particular alternative) that this operand is an
>      "earlyclobber" operand, which is modified before the instruction is
>      finished using the input operands.  Therefore, this operand may
>      not lie in a register that is used as an input operand or as part
>      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>      of any memory address.
>
> So "+" says that this operand is an input but "&" says that it must not
> be in a register that is used as an input.  That's contradictory, and I
> think we can expect GCC to barf or at least end up doing strange stuff,
> if not with existing versions, then with future versions.
>

I wondered about the same thing: given that the asm itself is a black
box to the compiler, it can never reuse an in/output register for
output, so when it is clobbered is irrelevant.

> Hence, I'm asking for clarification why it is thought that the existing
> code underspecifies the asm constraints, and I'm trying to get some more
> thought about what the constraints should be, in case there is a need to
> use "better" constraints.
>

I think the constraints are correct, but as I argued before,
tightening the constraints to ensure that uaddr and newval are not
mapped onto the same register should not result in any object code
changes, except for the case where the compiler instantiated a
constprop clone that is bogus to begin with.
