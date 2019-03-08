Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAE0C10F09
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 11:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5E420851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 11:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="piaLsZH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfCHL4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 06:56:05 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37184 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfCHL4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 06:56:05 -0500
Received: by mail-io1-f66.google.com with SMTP id v10so16476033iop.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 03:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JIhdJ+2ABpC1qpvzordD+8hgG4gYzUVY1mItI4ZQdbE=;
        b=piaLsZH78EkICadJuH2GOy5zclZyHIos7U/P2xhCcWBdLGAgHqPk1SBnOvotioqbs/
         BvtbzpW4ZZ111bEYS3R2DnjT9Auk4RTtriOVFVseWstsbkUo1bEsK/c5D/nwloySmvL+
         q8L2cPDa/X+LWg87UNdUIS27F8FnfTDILIL+3+lOWu9Qph/HQLCRMBaPnlmNHJQBr81Y
         reSrinHYYFWECLPofdlHkv75tT+TmxGo28gtiZqUOMQGf5EE5QfJ5/iiO6sReR8fLpFp
         rJFDzKPpXE78xpEGpoI//QzheEpYO4keF5hZ7lOpE/j7Tor1mwhJQyBWQXvPPKqA49/7
         r5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JIhdJ+2ABpC1qpvzordD+8hgG4gYzUVY1mItI4ZQdbE=;
        b=INiUoJTGPo0N9s+Dx4caTIe5YndjhHwdV+zlQ25QJEE/n1MLMjYwBLtQZjVFPkNV3X
         PjGuzTcYinC5AcDicpoxuQgECie0U5Q/5qNBxskbaYlVo5eaSB8V8sW3jW6NC7E7ELwQ
         kbzgMlf7CbgkaAwsSmSya0hKnSyesoJp0KxIfSht5ucQ61RUAHiPwBY3Z/ACG7//QRds
         astQTnxvXf6mssr2IyrzCB1ywRop7e6t8oTinZl0Ofeqn1S6iTz+Ez/+hFuIhUp9qQyG
         q5rkM9dbnkF/ltVM0OnCNnqW4QIqNb8P3zy4wsFjgkTpQkc2XzwWCu9+hQpcS8dP4IWS
         /2gg==
X-Gm-Message-State: APjAAAXRYxRAtFrvDNnfJRl6Jc0mJ8dkhMcPVmAWia7OGtinqYlCxdb1
        ItPv86M+83UOQtCQN6kGaY1BtmncUAWfUYnGCGVL3w==
X-Google-Smtp-Source: APXvYqzZzsd/vPTJerXYx6flRn3lNutD5SAzB2GRPR/vVE8qHSXSS9FjVfRsybwo7seVNM7XQep167jCTTCrkIN4oC4=
X-Received: by 2002:a6b:7b02:: with SMTP id l2mr9782574iop.60.1552046163319;
 Fri, 08 Mar 2019 03:56:03 -0800 (PST)
MIME-Version: 1.0
References: <20190307091514.2489338-1-arnd@arndb.de> <20190307091514.2489338-2-arnd@arndb.de>
 <CAKwvOdk=9j2HvtWOpdOEw9sm0Nh2oU3c1c6+hJJ5WMweAM=4EQ@mail.gmail.com>
 <20190307234850.nsbpkfcit3lnmytu@shell.armlinux.org.uk> <CAKv+Gu9VM2Vs3Q8+bPLsnt08dOmba6j54gnhiHkk=AHRzG8tVA@mail.gmail.com>
 <20190308095308.hjjrzdp4fzbbtnnv@shell.armlinux.org.uk> <CAKv+Gu_szWgw-KJASLYGJ6hJXh5K8WxnUn+UQkm7jUup=rqG6w@mail.gmail.com>
 <20190308103429.ycasmpt6tcpsoqps@shell.armlinux.org.uk> <CAKv+Gu_9=G3U6Yaw8fLfTP3QT38WdwrFaC-BqLTCr2NihWA2ZA@mail.gmail.com>
 <20190308105835.tovswk5rwxusmxdu@shell.armlinux.org.uk>
In-Reply-To: <20190308105835.tovswk5rwxusmxdu@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 8 Mar 2019 12:55:51 +0100
Message-ID: <CAKv+Gu-Od+hBosThTWFooz9FMKnu3g0oNh_2hmidetbB-_YyjQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: futex: make futex_detect_cmpxchg more reliable
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Mikael Pettersson <mikpelinux@gmail.com>,
        Mikael Pettersson <mikpe@it.uu.se>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
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

On Fri, 8 Mar 2019 at 11:58, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Fri, Mar 08, 2019 at 11:45:21AM +0100, Ard Biesheuvel wrote:
> > On Fri, 8 Mar 2019 at 11:34, Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Fri, Mar 08, 2019 at 11:08:40AM +0100, Ard Biesheuvel wrote:
> > > > On Fri, 8 Mar 2019 at 10:53, Russell King - ARM Linux admin
> > > > <linux@armlinux.org.uk> wrote:
> > > > >
> > > > > On Fri, Mar 08, 2019 at 09:57:45AM +0100, Ard Biesheuvel wrote:
> > > > > > On Fri, 8 Mar 2019 at 00:49, Russell King - ARM Linux admin
> > > > > > <linux@armlinux.org.uk> wrote:
> > > > > > >
> > > > > > > On Thu, Mar 07, 2019 at 11:39:08AM -0800, Nick Desaulniers wrote:
> > > > > > > > On Thu, Mar 7, 2019 at 1:15 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > > > >
> > > > > > > > > Passing registers containing zero as both the address (NULL pointer)
> > > > > > > > > and data into cmpxchg_futex_value_locked() leads clang to assign
> > > > > > > > > the same register for both inputs on ARM, which triggers a warning
> > > > > > > > > explaining that this instruction has unpredictable behavior on ARMv5.
> > > > > > > > >
> > > > > > > > > /tmp/futex-7e740e.s: Assembler messages:
> > > > > > > > > /tmp/futex-7e740e.s:12713: Warning: source register same as write-back base
> > > > > > > > >
> > > > > > > > > This patch was suggested by Mikael Pettersson back in 2011 (!) with gcc-4.4,
> > > > > > > > > as Mikael wrote:
> > > > > > > > >  "One way of fixing this is to make uaddr an input/output register, since
> > > > > > > > >  "that prevents it from overlapping any other input or output."
> > > > > > > > >
> > > > > > > > > but then withdrawn as the warning was determined to be harmless, and it
> > > > > > > > > apparently never showed up again with later gcc versions.
> > > > > > > > >
> > > > > > > > > Now the same problem is back when compiling with clang, and we are trying
> > > > > > > > > to get clang to build the kernel without warnings, as gcc normally does.
> > > > > > > > >
> > > > > > > > > Cc: Mikael Pettersson <mikpe@it.uu.se>
> > > > > > > > > Cc: Mikael Pettersson <mikpelinux@gmail.com>
> > > > > > > > > Cc: Dave Martin <Dave.Martin@arm.com>
> > > > > > > > > Link: https://lore.kernel.org/linux-arm-kernel/20009.45690.158286.161591@pilspetsen.it.uu.se/
> > > > > > > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > > > > > > ---
> > > > > > > > >  arch/arm/include/asm/futex.h | 10 +++++-----
> > > > > > > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/arch/arm/include/asm/futex.h b/arch/arm/include/asm/futex.h
> > > > > > > > > index 0a46676b4245..79790912974e 100644
> > > > > > > > > --- a/arch/arm/include/asm/futex.h
> > > > > > > > > +++ b/arch/arm/include/asm/futex.h
> > > > > > > > > @@ -110,13 +110,13 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
> > > > > > > > >         preempt_disable();
> > > > > > > > >         __ua_flags = uaccess_save_and_enable();
> > > > > > > > >         __asm__ __volatile__("@futex_atomic_cmpxchg_inatomic\n"
> > > > > > > > > -       "1:     " TUSER(ldr) "  %1, [%4]\n"
> > > > > > > > > -       "       teq     %1, %2\n"
> > > > > > > > > +       "1:     " TUSER(ldr) "  %1, [%2]\n"
> > > > > > > > > +       "       teq     %1, %3\n"
> > > > > > > > >         "       it      eq      @ explicit IT needed for the 2b label\n"
> > > > > > > > > -       "2:     " TUSER(streq) "        %3, [%4]\n"
> > > > > > > > > +       "2:     " TUSER(streq) "        %4, [%2]\n"
> > > > > > > > >         __futex_atomic_ex_table("%5")
> > > > > > > > > -       : "+r" (ret), "=&r" (val)
> > > > > > > > > -       : "r" (oldval), "r" (newval), "r" (uaddr), "Ir" (-EFAULT)
> > > > > > > > > +       : "+&r" (ret), "=&r" (val), "+&r" (uaddr)
> > > > > > > > > +       : "r" (oldval), "r" (newval), "Ir" (-EFAULT)
> > > > > > > > >         : "cc", "memory");
> > > > > > > > >         uaccess_restore(__ua_flags);
> > > > > > > >
> > > > > > > > Underspecification of constraints to extended inline assembly is a
> > > > > > > > common issue exposed by other compilers (and possibly but in-effect
> > > > > > > > infrequently compiler upgrades).
> > > > > > > > So the reordering of the constraints means the in the assembly (notes
> > > > > > > > for other reviewers):
> > > > > > > > %2 -> %3
> > > > > > > > %3 -> %4
> > > > > > > > %4 -> %2
> > > > > > > > Yep, looks good to me, thanks for finding this old patch and resending, Arnd!
> > > > > > >
> > > > > > > I don't see what is "underspecified" in the original constraints.
> > > > > > > Please explain.
> > > > > > >
> > > > > >
> > > > > > I agree that that statement makes little sense.
> > > > > >
> > > > > > As Russell points out in the referenced thread, there is nothing wrong
> > > > > > with the generated assembly, given that the UNPREDICTABLE opcode is
> > > > > > unreachable in practice. Unfortunately, we have no way to flag this
> > > > > > diagnostic as a known false positive, and AFAICT, there is no reason
> > > > > > we couldn't end up with the same diagnostic popping up for GCC builds
> > > > > > in the future, considering that the register assignment matches the
> > > > > > constraints. (We have seen somewhat similar issues where constant
> > > > > > folded function clones are emitted with a constant argument that could
> > > > > > never occur in reality [0])
> > > > > >
> > > > > > Given the above, the only meaningful way to invoke this function is
> > > > > > with different registers assigned to %3 and %4, and so tightening the
> > > > > > constraints to guarantee that does not actually result in worse code
> > > > > > (except maybe for the instantiations that we won't ever call in the
> > > > > > first place). So I think we should fix this.
> > > > > >
> > > > > > I wonder if just adding
> > > > > >
> > > > > > BUG_ON(__builtin_constant_p(uaddr));
> > > > > >
> > > > > > at the beginning makes any difference - this shouldn't result in any
> > > > > > object code differences since the conditional will always evaluate to
> > > > > > false at build time for instantiations we care about.
> > > > > >
> > > > > >
> > > > > > [0] https://lore.kernel.org/lkml/9c74d635-d0d1-0893-8093-ce20b0933fc7@redhat.com/
> > > > >
> > > > > What I'm actually asking is:
> > > > >
> > > > > The GCC manual says that input operands _may_ overlap output operands
> > > > > since GCC assumes that input operands are consumed before output
> > > > > operands are written.  This is an explicit statement.
> > > > >
> > > > > The GCC manual does not say that input operands may overlap with each
> > > > > other, and the behaviour of GCC thus far (apart from one version,
> > > > > presumably caused by a bug) has been that input operands are unique.
> > > > >
> > > >
> > > > Not entirely. I have run into issues where GCC assumes that registers
> > > > that are only used for input operands are left untouched by the asm
> > > > code. I.e., if you put an asm() block in a loop and modify an input
> > > > register, your code may break on the next pass, even if the input
> > > > register does not overlap with an output register.
> > >
> > > GCC has had the expectation for decades that _input_ operands are not
> > > changed in value by the code in the assembly.  This isn't quite the
> > > same thing as the uniqueness of the register allocation for input
> > > operands.
> > >
> > > > To me, that seems to suggest that whether or not inputs may overlap is
> > > > irrelevant, since they are not expected to be modified.
> > >
> > > How is:
> > >
> > >         stmfd   sp!, {r0-r3, ip, lr}
> > >         bl      foo
> > >         ldmfd   sp!, {r0-r3, ip, lr}
> > >
> > > where r1 may be an input operand (to pass an argument to foo) any
> > > different from:
> > >
> > >         ldrt    r0, [r1]
> > >
> > > as far as whether r1 is modified in both cases?  In both cases, the
> > > value of r1 is read and written by both instructions, but in both
> > > cases the value of r1 remains the same no matter what the value of r1
> > > was.
> > >
> > > The "input operands should not be modified" is entirely orthogonal to
> > > the input operand register allocation.
> > >
> >
> > The question is whether it is reasonable for GCC to use the same
> > register for input operands that have the same value. From the
> > assumption that GCC makes that the asm will not modified follows
> > directly that we can use the same register for different operands.
> >
> > And in fact, since that asm code (when built in ARM mode) does modify
> > the register, uaddr should not be an input operand to begin with. In
> > other words, there is an actual bug here, and this patch fixes it.
>
> Again, you miss my point.
>

Perhaps. So let me summarize what I do understand.

1) if futex_atomic_cmpxchg_inatomic() is instantiated *and executed*
with the same compile time constant value of 0x0 for newval and uaddr,
we end up with an opcode for the STRT instruction that is CONSTRAINED
UNPREDICTABLE, but we will never execute it since the preceding load
will fault and enter the fixup handler.
2) such occurrences of futex_atomic_cmpxchg_inatomic() are unlikely to
occur in the code, but may be instantiated by the compiler when doing
constant propagation (like in the ilog2() case I quoted), but these
instantiations will never be called
3) both clang and gcc may map different inline asm input operands onto
the same register if the value is guaranteed to be the same (i.e.,
they are both compile time constants)

My statement about uaddr was slightly misguided, in the sense that our
invocation of STRT does use the post-index variant, but with an
increment of zero, so the value written back to the register equals
the original value. But it does explain why this opcode is CONSTRAINED
UNPREDICTABLE in the first place.

Given 2) above, I wonder if anyone could confirm whether adding
'BUG_ON(__builtin_constant_p(uaddr))' silences the warning as well.
