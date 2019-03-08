Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D9DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C7D20684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fg4bn+zH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfCHI6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 03:58:01 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:37138 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfCHI56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 03:57:58 -0500
Received: by mail-it1-f193.google.com with SMTP id z124so20290418itc.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 00:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0l0UkbPuWg3Yfm5mWI5EkFcmW5g1NccNKQ7wPTtpamM=;
        b=fg4bn+zH4d9iW7yy2N8SgiF1Hoi05jRLY7Ndok3rt4HtPk2h3Q+wuFnOrJJ9gvGl7C
         2qicLoK90tHtHhwtKm3njk9xVW32e6IVgfRZr170pry0uqoS1AIYgDB1xTw6/bFrOk5G
         Nlf/bVQA7un48xCMOVjL7BPiyYnt5fMmiRiSDnCpp0CEg/HR8qjjdWpa9bJwoN/wy0Ep
         rZPZMb/oIDbS9vRcS1iPVioX526sEFmMoZAKtWnoqKAwKD572oSCxP/HcDCUQL+Fexuv
         /6tk7PtvZTagDOi4n2rjgTBRuqvOsrVXAAyLuTfoaUE27LLwO2MTe8+4FE2vF0tWXmS1
         hQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0l0UkbPuWg3Yfm5mWI5EkFcmW5g1NccNKQ7wPTtpamM=;
        b=qiAvZJSBGN6E0VC5i1TKJKzMsahcZlwNRvDzVduqFjaQ+6KbO82tB1lPyeuaYOph7A
         SPCUKhmVYz9j+kq8RuhUMhtOUZAdwnOR0hgQ/qeO7DN1tiXhADoA9nvfjWzpL2d3YmEY
         nRyvtOC8rBTaMtC+nB7uJeDaMo9fsIUte9euHbz8lkLDaOSbovbBQLGtsqXpmeyFl9H9
         LB2XaPTtDVtopVvpuROryM8PvRBGXYfd65JkwAVCV2l20uiK/gZl9HC1Lgy5Q51yGwCM
         rZvEcebqVTq3JHQAalYab9n5+/MBaOJ47RcxNNWVPmt5Fql9ALvuXD1HT9J5YQ6IOBoy
         qDPA==
X-Gm-Message-State: APjAAAUfe5pR2bWW4AeuqP2EUWG6pZLMj78cGXEe3j1TF8f0TgWPEUU9
        7GZ/ENAX1ptBsqFyAgOUhimY3H6qrMIQg+z+gZCRlw==
X-Google-Smtp-Source: APXvYqwY7tCybzhwR6Oy+fJQ0HcguVngu1crlCDImgnphPlQaRYL0ixsyT32XeKH7zjX5GcUteB/SMTI7ork65+ocUo=
X-Received: by 2002:a24:2e90:: with SMTP id i138mr8456368ita.158.1552035477184;
 Fri, 08 Mar 2019 00:57:57 -0800 (PST)
MIME-Version: 1.0
References: <20190307091514.2489338-1-arnd@arndb.de> <20190307091514.2489338-2-arnd@arndb.de>
 <CAKwvOdk=9j2HvtWOpdOEw9sm0Nh2oU3c1c6+hJJ5WMweAM=4EQ@mail.gmail.com> <20190307234850.nsbpkfcit3lnmytu@shell.armlinux.org.uk>
In-Reply-To: <20190307234850.nsbpkfcit3lnmytu@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 8 Mar 2019 09:57:45 +0100
Message-ID: <CAKv+Gu9VM2Vs3Q8+bPLsnt08dOmba6j54gnhiHkk=AHRzG8tVA@mail.gmail.com>
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

On Fri, 8 Mar 2019 at 00:49, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Thu, Mar 07, 2019 at 11:39:08AM -0800, Nick Desaulniers wrote:
> > On Thu, Mar 7, 2019 at 1:15 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > Passing registers containing zero as both the address (NULL pointer)
> > > and data into cmpxchg_futex_value_locked() leads clang to assign
> > > the same register for both inputs on ARM, which triggers a warning
> > > explaining that this instruction has unpredictable behavior on ARMv5.
> > >
> > > /tmp/futex-7e740e.s: Assembler messages:
> > > /tmp/futex-7e740e.s:12713: Warning: source register same as write-back base
> > >
> > > This patch was suggested by Mikael Pettersson back in 2011 (!) with gcc-4.4,
> > > as Mikael wrote:
> > >  "One way of fixing this is to make uaddr an input/output register, since
> > >  "that prevents it from overlapping any other input or output."
> > >
> > > but then withdrawn as the warning was determined to be harmless, and it
> > > apparently never showed up again with later gcc versions.
> > >
> > > Now the same problem is back when compiling with clang, and we are trying
> > > to get clang to build the kernel without warnings, as gcc normally does.
> > >
> > > Cc: Mikael Pettersson <mikpe@it.uu.se>
> > > Cc: Mikael Pettersson <mikpelinux@gmail.com>
> > > Cc: Dave Martin <Dave.Martin@arm.com>
> > > Link: https://lore.kernel.org/linux-arm-kernel/20009.45690.158286.161591@pilspetsen.it.uu.se/
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >  arch/arm/include/asm/futex.h | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/arch/arm/include/asm/futex.h b/arch/arm/include/asm/futex.h
> > > index 0a46676b4245..79790912974e 100644
> > > --- a/arch/arm/include/asm/futex.h
> > > +++ b/arch/arm/include/asm/futex.h
> > > @@ -110,13 +110,13 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
> > >         preempt_disable();
> > >         __ua_flags = uaccess_save_and_enable();
> > >         __asm__ __volatile__("@futex_atomic_cmpxchg_inatomic\n"
> > > -       "1:     " TUSER(ldr) "  %1, [%4]\n"
> > > -       "       teq     %1, %2\n"
> > > +       "1:     " TUSER(ldr) "  %1, [%2]\n"
> > > +       "       teq     %1, %3\n"
> > >         "       it      eq      @ explicit IT needed for the 2b label\n"
> > > -       "2:     " TUSER(streq) "        %3, [%4]\n"
> > > +       "2:     " TUSER(streq) "        %4, [%2]\n"
> > >         __futex_atomic_ex_table("%5")
> > > -       : "+r" (ret), "=&r" (val)
> > > -       : "r" (oldval), "r" (newval), "r" (uaddr), "Ir" (-EFAULT)
> > > +       : "+&r" (ret), "=&r" (val), "+&r" (uaddr)
> > > +       : "r" (oldval), "r" (newval), "Ir" (-EFAULT)
> > >         : "cc", "memory");
> > >         uaccess_restore(__ua_flags);
> >
> > Underspecification of constraints to extended inline assembly is a
> > common issue exposed by other compilers (and possibly but in-effect
> > infrequently compiler upgrades).
> > So the reordering of the constraints means the in the assembly (notes
> > for other reviewers):
> > %2 -> %3
> > %3 -> %4
> > %4 -> %2
> > Yep, looks good to me, thanks for finding this old patch and resending, Arnd!
>
> I don't see what is "underspecified" in the original constraints.
> Please explain.
>

I agree that that statement makes little sense.

As Russell points out in the referenced thread, there is nothing wrong
with the generated assembly, given that the UNPREDICTABLE opcode is
unreachable in practice. Unfortunately, we have no way to flag this
diagnostic as a known false positive, and AFAICT, there is no reason
we couldn't end up with the same diagnostic popping up for GCC builds
in the future, considering that the register assignment matches the
constraints. (We have seen somewhat similar issues where constant
folded function clones are emitted with a constant argument that could
never occur in reality [0])

Given the above, the only meaningful way to invoke this function is
with different registers assigned to %3 and %4, and so tightening the
constraints to guarantee that does not actually result in worse code
(except maybe for the instantiations that we won't ever call in the
first place). So I think we should fix this.

I wonder if just adding

BUG_ON(__builtin_constant_p(uaddr));

at the beginning makes any difference - this shouldn't result in any
object code differences since the conditional will always evaluate to
false at build time for instantiations we care about.


[0] https://lore.kernel.org/lkml/9c74d635-d0d1-0893-8093-ce20b0933fc7@redhat.com/
