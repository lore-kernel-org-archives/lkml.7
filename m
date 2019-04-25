Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CECC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3757E20891
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556214585;
	bh=k7j/1g7qfQNqTMzadjTDghyn+ZldaWg22WWJRpeAVjE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=f4jE4MpExCsjEC9WlIrc1/JI/FeY2l3U7vYOQVin8TxZcqyB681Q4YPgD7BcirWPh
	 5L2oYK0j4wD4iVm1EbmkgbkDzA5fZt9rZD07YXkAWrZKK+g2cB0cajB7gMiYqXatye
	 MHT2kph/o0Fv115323rup0+6AiPiayEMlZY/3Sp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbfDYRtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:49:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730040AbfDYRtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:49:43 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 163FE212F5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 17:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556214582;
        bh=k7j/1g7qfQNqTMzadjTDghyn+ZldaWg22WWJRpeAVjE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AeH32e9gKFK/kCCx4QBmNaIi9VoX2FsuBBARmXxzEEqAq3z+dTBgxGXKkfzqgpS2g
         FQvNLn104ZeAtZnGYEoMQykDgBtX2JkgpaAcwQf50dFeJYDfVGi/ds5EZelPMhPuJQ
         LX+mBbOazigTfZCu8jlaN1AH+IO5vQx7DoIF8kgQ=
Received: by mail-wm1-f47.google.com with SMTP id h18so438247wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 10:49:41 -0700 (PDT)
X-Gm-Message-State: APjAAAWVYnb4UGihoVZ+b7ZFU9vfQyVsqV+eTYC6zbIUjryFXhZ7RgDr
        SO2SDXQG7rvHjuGJJ0ATnjiyK2V+Uvt1n+NGN1p4+g==
X-Google-Smtp-Source: APXvYqw7Ywzyncv+PKRVYxY/vhezc7Wd5dx6UuqT0xaAqOy5z7OerjoOtysy1gdphkM0v0uvRZhvaq7RWJSxejWAJfc=
X-Received: by 2002:a7b:c182:: with SMTP id y2mr4262844wmi.83.1556214579825;
 Thu, 25 Apr 2019 10:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190422185805.1169-1-rick.p.edgecombe@intel.com>
 <20190422185805.1169-4-rick.p.edgecombe@intel.com> <20190425162620.GA5199@zn.tnic>
 <B7809434-CEBE-4664-ACE7-BA2412163CC4@gmail.com>
In-Reply-To: <B7809434-CEBE-4664-ACE7-BA2412163CC4@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 25 Apr 2019 10:49:27 -0700
X-Gmail-Original-Message-ID: <CALCETrVkEJuTwYnC4kc7Xk_KEeKGGtuDErNyfL=Oa_CZp+=yOA@mail.gmail.com>
Message-ID: <CALCETrVkEJuTwYnC4kc7Xk_KEeKGGtuDErNyfL=Oa_CZp+=yOA@mail.gmail.com>
Subject: Re: [PATCH v4 03/23] x86/mm: Introduce temporary mm structs
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Damian Tometzki <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>, Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 10:37 AM Nadav Amit <nadav.amit@gmail.com> wrote:
>
> > On Apr 25, 2019, at 9:26 AM, Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Mon, Apr 22, 2019 at 11:57:45AM -0700, Rick Edgecombe wrote:
> >> From: Andy Lutomirski <luto@kernel.org>
> >>
> >> Using a dedicated page-table for temporary PTEs prevents other cores
> >> from using - even speculatively - these PTEs, thereby providing two
> >> benefits:
> >>
> >> (1) Security hardening: an attacker that gains kernel memory writing
> >> abilities cannot easily overwrite sensitive data.
> >>
> >> (2) Avoiding TLB shootdowns: the PTEs do not need to be flushed in
> >> remote page-tables.
> >>
> >> To do so a temporary mm_struct can be used. Mappings which are private
> >> for this mm can be set in the userspace part of the address-space.
> >> During the whole time in which the temporary mm is loaded, interrupts
> >> must be disabled.
> >>
> >> The first use-case for temporary mm struct, which will follow, is for
> >> poking the kernel text.
> >>
> >> [ Commit message was written by Nadav Amit ]
> >>
> >> Cc: Kees Cook <keescook@chromium.org>
> >> Cc: Dave Hansen <dave.hansen@intel.com>
> >> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> >> Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
> >> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> >> Signed-off-by: Nadav Amit <namit@vmware.com>
> >> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> >> ---
> >> arch/x86/include/asm/mmu_context.h | 33 ++++++++++++++++++++++++++++++
> >> 1 file changed, 33 insertions(+)
> >>
> >> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm=
/mmu_context.h
> >> index 19d18fae6ec6..d684b954f3c0 100644
> >> --- a/arch/x86/include/asm/mmu_context.h
> >> +++ b/arch/x86/include/asm/mmu_context.h
> >> @@ -356,4 +356,37 @@ static inline unsigned long __get_current_cr3_fas=
t(void)
> >>      return cr3;
> >> }
> >>
> >> +typedef struct {
> >> +    struct mm_struct *prev;
> >> +} temp_mm_state_t;
> >> +
> >> +/*
> >> + * Using a temporary mm allows to set temporary mappings that are not=
 accessible
> >> + * by other cores. Such mappings are needed to perform sensitive memo=
ry writes
> >
> > s/cores/CPUs/g
> >
> > Yeah, the concept of a thread of execution we call a CPU in the kernel,
> > I'd say. No matter if it is one of the hyperthreads or a single thread
> > in core.
> >
> >> + * that override the kernel memory protections (e.g., W^X), without e=
xposing the
> >> + * temporary page-table mappings that are required for these write op=
erations to
> >> + * other cores.
> >
> > Ditto.
> >
> >> Using temporary mm also allows to avoid TLB shootdowns when the
> >
> > Using a ..
> >
> >> + * mapping is torn down.
> >> + *
> >
> > Nice commenting.
> >
> >> + * Context: The temporary mm needs to be used exclusively by a single=
 core. To
> >> + *          harden security IRQs must be disabled while the temporary=
 mm is
> >                             ^
> >                             ,
> >
> >> + *          loaded, thereby preventing interrupt handler bugs from ov=
erriding
> >> + *          the kernel memory protection.
> >> + */
> >> +static inline temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
> >> +{
> >> +    temp_mm_state_t state;
> >> +
> >> +    lockdep_assert_irqs_disabled();
> >> +    state.prev =3D this_cpu_read(cpu_tlbstate.loaded_mm);
> >> +    switch_mm_irqs_off(NULL, mm, current);
> >> +    return state;
> >> +}
> >> +
> >> +static inline void unuse_temporary_mm(temp_mm_state_t prev)
> >> +{
> >> +    lockdep_assert_irqs_disabled();
> >> +    switch_mm_irqs_off(NULL, prev.prev, current);
> >
> > I think this code would be more readable if you call that
> > temp_mm_state_t variable "temp_state" and the mm_struct pointer "mm" an=
d
> > then you have:
> >
> >       switch_mm_irqs_off(NULL, temp_state.mm, current);
> >
> > And above you'll have:
> >
> >       temp_state.mm =3D ...
>
> Andy, please let me know whether you are fine with this change and I=E2=
=80=99ll
> incorporate it.


I'm okay with it.
