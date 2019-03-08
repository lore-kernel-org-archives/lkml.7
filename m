Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A249C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 11:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C085220851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 11:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfCHLzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 06:55:55 -0500
Received: from foss.arm.com ([217.140.101.70]:57224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfCHLzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 06:55:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A63B80D;
        Fri,  8 Mar 2019 03:55:54 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 063193F706;
        Fri,  8 Mar 2019 03:55:51 -0800 (PST)
Date:   Fri, 8 Mar 2019 11:55:49 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Mikael Pettersson <mikpe@it.uu.se>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] ARM: futex: make futex_detect_cmpxchg more reliable
Message-ID: <20190308115546.GM3567@e103592.cambridge.arm.com>
References: <20190307091514.2489338-1-arnd@arndb.de>
 <20190307091514.2489338-2-arnd@arndb.de>
 <CAKwvOdk=9j2HvtWOpdOEw9sm0Nh2oU3c1c6+hJJ5WMweAM=4EQ@mail.gmail.com>
 <20190307234850.nsbpkfcit3lnmytu@shell.armlinux.org.uk>
 <CAKv+Gu9VM2Vs3Q8+bPLsnt08dOmba6j54gnhiHkk=AHRzG8tVA@mail.gmail.com>
 <20190308095308.hjjrzdp4fzbbtnnv@shell.armlinux.org.uk>
 <CAKv+Gu_szWgw-KJASLYGJ6hJXh5K8WxnUn+UQkm7jUup=rqG6w@mail.gmail.com>
 <20190308103429.ycasmpt6tcpsoqps@shell.armlinux.org.uk>
 <CAKv+Gu_9=G3U6Yaw8fLfTP3QT38WdwrFaC-BqLTCr2NihWA2ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_9=G3U6Yaw8fLfTP3QT38WdwrFaC-BqLTCr2NihWA2ZA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

oN fRI, Mar 08, 2019 at 11:45:21AM +0100, Ard Biesheuvel wrote:
> On Fri, 8 Mar 2019 at 11:34, Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > On Fri, Mar 08, 2019 at 11:08:40AM +0100, Ard Biesheuvel wrote:
> > > On Fri, 8 Mar 2019 at 10:53, Russell King - ARM Linux admin
> > > <linux@armlinux.org.uk> wrote:
> > > >
> > > > On Fri, Mar 08, 2019 at 09:57:45AM +0100, Ard Biesheuvel wrote:
> > > > > On Fri, 8 Mar 2019 at 00:49, Russell King - ARM Linux admin
> > > > > <linux@armlinux.org.uk> wrote:
> > > > > >
> > > > > > On Thu, Mar 07, 2019 at 11:39:08AM -0800, Nick Desaulniers wrote:
> > > > > > > On Thu, Mar 7, 2019 at 1:15 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > > >
> > > > > > > > Passing registers containing zero as both the address (NULL pointer)
> > > > > > > > and data into cmpxchg_futex_value_locked() leads clang to assign
> > > > > > > > the same register for both inputs on ARM, which triggers a warning
> > > > > > > > explaining that this instruction has unpredictable behavior on ARMv5.
> > > > > > > >
> > > > > > > > /tmp/futex-7e740e.s: Assembler messages:
> > > > > > > > /tmp/futex-7e740e.s:12713: Warning: source register same as write-back base
> > > > > > > >
> > > > > > > > This patch was suggested by Mikael Pettersson back in 2011 (!) with gcc-4.4,
> > > > > > > > as Mikael wrote:
> > > > > > > >  "One way of fixing this is to make uaddr an input/output register, since
> > > > > > > >  "that prevents it from overlapping any other input or output."
> > > > > > > >
> > > > > > > > but then withdrawn as the warning was determined to be harmless, and it
> > > > > > > > apparently never showed up again with later gcc versions.
> > > > > > > >
> > > > > > > > Now the same problem is back when compiling with clang, and we are trying
> > > > > > > > to get clang to build the kernel without warnings, as gcc normally does.
> > > > > > > >
> > > > > > > > Cc: Mikael Pettersson <mikpe@it.uu.se>
> > > > > > > > Cc: Mikael Pettersson <mikpelinux@gmail.com>
> > > > > > > > Cc: Dave Martin <Dave.Martin@arm.com>
> > > > > > > > Link: https://lore.kernel.org/linux-arm-kernel/20009.45690.158286.161591@pilspetsen.it.uu.se/
> > > > > > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > > > > > ---
> > > > > > > >  arch/arm/include/asm/futex.h | 10 +++++-----
> > > > > > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/arch/arm/include/asm/futex.h b/arch/arm/include/asm/futex.h
> > > > > > > > index 0a46676b4245..79790912974e 100644
> > > > > > > > --- a/arch/arm/include/asm/futex.h
> > > > > > > > +++ b/arch/arm/include/asm/futex.h
> > > > > > > > @@ -110,13 +110,13 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
> > > > > > > >         preempt_disable();
> > > > > > > >         __ua_flags = uaccess_save_and_enable();
> > > > > > > >         __asm__ __volatile__("@futex_atomic_cmpxchg_inatomic\n"
> > > > > > > > -       "1:     " TUSER(ldr) "  %1, [%4]\n"
> > > > > > > > -       "       teq     %1, %2\n"
> > > > > > > > +       "1:     " TUSER(ldr) "  %1, [%2]\n"
> > > > > > > > +       "       teq     %1, %3\n"
> > > > > > > >         "       it      eq      @ explicit IT needed for the 2b label\n"
> > > > > > > > -       "2:     " TUSER(streq) "        %3, [%4]\n"
> > > > > > > > +       "2:     " TUSER(streq) "        %4, [%2]\n"
> > > > > > > >         __futex_atomic_ex_table("%5")
> > > > > > > > -       : "+r" (ret), "=&r" (val)
> > > > > > > > -       : "r" (oldval), "r" (newval), "r" (uaddr), "Ir" (-EFAULT)
> > > > > > > > +       : "+&r" (ret), "=&r" (val), "+&r" (uaddr)
> > > > > > > > +       : "r" (oldval), "r" (newval), "Ir" (-EFAULT)
> > > > > > > >         : "cc", "memory");
> > > > > > > >         uaccess_restore(__ua_flags);
> > > > > > >
> > > > > > > Underspecification of constraints to extended inline assembly is a
> > > > > > > common issue exposed by other compilers (and possibly but in-effect
> > > > > > > infrequently compiler upgrades).
> > > > > > > So the reordering of the constraints means the in the assembly (notes
> > > > > > > for other reviewers):
> > > > > > > %2 -> %3
> > > > > > > %3 -> %4
> > > > > > > %4 -> %2
> > > > > > > Yep, looks good to me, thanks for finding this old patch and resending, Arnd!
> > > > > >
> > > > > > I don't see what is "underspecified" in the original constraints.
> > > > > > Please explain.
> > > > > >
> > > > >
> > > > > I agree that that statement makes little sense.
> > > > >
> > > > > As Russell points out in the referenced thread, there is nothing wrong
> > > > > with the generated assembly, given that the UNPREDICTABLE opcode is
> > > > > unreachable in practice. Unfortunately, we have no way to flag this
> > > > > diagnostic as a known false positive, and AFAICT, there is no reason
> > > > > we couldn't end up with the same diagnostic popping up for GCC builds
> > > > > in the future, considering that the register assignment matches the
> > > > > constraints. (We have seen somewhat similar issues where constant
> > > > > folded function clones are emitted with a constant argument that could
> > > > > never occur in reality [0])
> > > > >
> > > > > Given the above, the only meaningful way to invoke this function is
> > > > > with different registers assigned to %3 and %4, and so tightening the
> > > > > constraints to guarantee that does not actually result in worse code
> > > > > (except maybe for the instantiations that we won't ever call in the
> > > > > first place). So I think we should fix this.
> > > > >
> > > > > I wonder if just adding
> > > > >
> > > > > BUG_ON(__builtin_constant_p(uaddr));
> > > > >
> > > > > at the beginning makes any difference - this shouldn't result in any
> > > > > object code differences since the conditional will always evaluate to
> > > > > false at build time for instantiations we care about.
> > > > >
> > > > >
> > > > > [0] https://lore.kernel.org/lkml/9c74d635-d0d1-0893-8093-ce20b0933fc7@redhat.com/
> > > >
> > > > What I'm actually asking is:
> > > >
> > > > The GCC manual says that input operands _may_ overlap output operands
> > > > since GCC assumes that input operands are consumed before output
> > > > operands are written.  This is an explicit statement.
> > > >
> > > > The GCC manual does not say that input operands may overlap with each
> > > > other, and the behaviour of GCC thus far (apart from one version,
> > > > presumably caused by a bug) has been that input operands are unique.
> > > >
> > >
> > > Not entirely. I have run into issues where GCC assumes that registers
> > > that are only used for input operands are left untouched by the asm
> > > code. I.e., if you put an asm() block in a loop and modify an input
> > > register, your code may break on the next pass, even if the input
> > > register does not overlap with an output register.
> >
> > GCC has had the expectation for decades that _input_ operands are not
> > changed in value by the code in the assembly.  This isn't quite the
> > same thing as the uniqueness of the register allocation for input
> > operands.
> >
> > > To me, that seems to suggest that whether or not inputs may overlap is
> > > irrelevant, since they are not expected to be modified.
> >
> > How is:
> >
> >         stmfd   sp!, {r0-r3, ip, lr}
> >         bl      foo
> >         ldmfd   sp!, {r0-r3, ip, lr}
> >
> > where r1 may be an input operand (to pass an argument to foo) any
> > different from:
> >
> >         ldrt    r0, [r1]
> >
> > as far as whether r1 is modified in both cases?  In both cases, the
> > value of r1 is read and written by both instructions, but in both
> > cases the value of r1 remains the same no matter what the value of r1
> > was.
> >
> > The "input operands should not be modified" is entirely orthogonal to
> > the input operand register allocation.
> >
> 
> The question is whether it is reasonable for GCC to use the same
> register for input operands that have the same value. From the
> assumption that GCC makes that the asm will not modified follows
> directly that we can use the same register for different operands.

Whether "reasonable" or not, GCC does it.  And I don't think this is new
behaviour...

int f(void)
{
	int res;

	asm ("ADD %0, %0, %0" : "=r" (res) : "r" (77), "r" (77));
	
	return res;
}

->

00000000 <f>:
   0:   e3a0004d       mov      r0, #77 ; 0x4d
   4:   e0800000       add      r0, r0, r0
   8:   e12fff1e       bx       lr

> And in fact, since that asm code (when built in ARM mode) does modify
> the register, uaddr should not be an input operand to begin with. In
> other words, there is an actual bug here, and this patch fixes it.

Does the old code modify the register?

As I read it, the register is written (in the ARM case) by the
underlying STRT instruction, but since the post-index offset it 0, the
value written back is the same as the value originally read.

In ARMv7-A,

	strt	r0, [r0], #imm

will store the original (unmodified) value of r0 if I read the
pseudocode correctly.  I can't remember the history, but I think that
older architecture versions provided a choice about whether the
unmodified or modified value was stored.  So gas probably just checks
whether the registers are the same and emits a warning to be on the safe
side.  If #imm is 0 (as in the existing futex code here) then it may
make no difference in practice though.

So, I'm not absolutely convinced there's a bug here, unless this is
truly specified as UNPREDICATABLE in older arch versions.

But the warning it at least annoying and use of "&" to prevent gas
allocating things to the same register is already widespread for "+"
asm arguments, even for arm.

If the _value_ of the affected operand is not changed by the asm, I
think we don't strictly need "+", but we are using "&" here for its
register allocation side-effects, and "&" (for its original purpose at
least) is only applicable to output ("=" or "+") operands.

So I think the patch probably makes sense.

IMHO the gas documentation is misleading (or at least unhelpful).

Cheers
---Dave
