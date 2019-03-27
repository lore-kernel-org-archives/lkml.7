Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A32C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0392075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WrOZnux8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbfC0Tvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:51:49 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46657 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729381AbfC0Tvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 15:51:49 -0400
Received: by mail-ua1-f66.google.com with SMTP id v7so50258uak.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 12:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZtHr4JPeCg91ihWiUcGr2uK2mi+PMwRZ8iP/7/zC0gg=;
        b=WrOZnux8a7iPl9MuKH530IQzJaH1K953croGMy3TVkHKgwYAASFW8a6gyJhh88vuCP
         QQgfdjESH3+TE+Q4GfAxA9PD15t41Wp0Sd9YiIrLMwZs0Ih9oPskKpTuebCDSju/Tzek
         cRSkh/LIKTbK92iB4uctkeDRBoBP1wXBLza3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZtHr4JPeCg91ihWiUcGr2uK2mi+PMwRZ8iP/7/zC0gg=;
        b=P6zsUPZCWxqa57EsfszMwf+U9DjyMf1/gMVna6tvncrvsdSrEr0EliQUkoI4PVh92o
         Hvy74LRTnlAwpiw41mD5omsNoGdKtBrs/ZvAySilk8FQgc00GGUO3zKWzO8nZ3fFqP45
         Ozn44Ru9RoIM26Ncrh6dy9l4KM6sMdpZilCKctvnCvaixrBr+ncxQzY6Xe3oqEQ1L/e7
         7IV0htaEhbsvi81VvyRTD4FXEO1S/3wymhewx/Hht1VyIKkkLHUl5pR3pmBJDGTgb7AA
         7ghBHaZbZ8tnXyfE74cOVEbJOYpTVt82DA8Gya04jLqT2L2JgEh56nRnHM8nQ2WEwtj9
         YDoA==
X-Gm-Message-State: APjAAAU/CcHven5X8wBcEzASgYXvbx5PrNOZBfsnEXo2MGGMwvVcy/nD
        mM/zs3lySSrNdWee15KYUd+Osn/9bjI=
X-Google-Smtp-Source: APXvYqzYKWa17s9wEOCovnRAiYajTMfccDPSoZH/cWuGK5Jve6to5lqm5yI4AMTJsm3AN06PX3CJ2w==
X-Received: by 2002:ab0:702a:: with SMTP id u10mr6226491ual.5.1553716307314;
        Wed, 27 Mar 2019 12:51:47 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id d188sm4996777vka.48.2019.03.27.12.51.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 12:51:46 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id w26so9645788vsk.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 12:51:45 -0700 (PDT)
X-Received: by 2002:a67:6983:: with SMTP id e125mr22627980vsc.222.1553716305244;
 Wed, 27 Mar 2019 12:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190312173248.13490-1-alisaidi@amazon.com> <20190312173248.13490-3-alisaidi@amazon.com>
 <CAGXu5jJ5sj3emOT2QPxQkNQk0qbU6zEfu9=Omfhx_p0nCKPSjA@mail.gmail.com>
In-Reply-To: <CAGXu5jJ5sj3emOT2QPxQkNQk0qbU6zEfu9=Omfhx_p0nCKPSjA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 27 Mar 2019 12:51:33 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKcBmj0kwAqjqROXuOi=90=Upy8-J8WviGMjD6FV_Guxg@mail.gmail.com>
Message-ID: <CAGXu5jKcBmj0kwAqjqROXuOi=90=Upy8-J8WviGMjD6FV_Guxg@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/mmap: handle worst-case heap randomization in mmap_base
To:     Ali Saidi <alisaidi@amazon.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Anthony Liguori <aliguori@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 3:58 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Mar 12, 2019 at 10:33 AM Ali Saidi <alisaidi@amazon.com> wrote:
> >
> > Increase mmap_base by the worst-case brk randomization so that
> > the stack and heap remain apart.
> >
> > In Linux 4.13 a change was committed that special cased the kernel ELF
> > loader when the loader is invoked directly (eab09532d400; binfmt_elf: u=
se
> > ELF_ET_DYN_BASE only for PIE). Generally, the loader isn=E2=80=99t invo=
ked
> > directly and this issue is limited to cases where it is, (e.g to set a
> > non-inheritable LD_LIBRARY_PATH, testing new versions of the loader). I=
n
> > those rare cases, the loader doesn't take into account the amount of br=
k
> > randomization that will be applied by arch_randomize_brk(). This can
> > lead to the stack and heap being arbitrarily close to each other.
>
> In the case of using the loader directly, brk (so helpfully identified
> as "[heap]") is allocated with the _loader_ not the binary. For
> example, with ASLR entirely disabled, you can see this more clearly:
>
> $ /bin/cat /proc/self/maps
> 555555554000-55555555c000 r-xp 00000000 fd:02 34603015
>   /bin/cat
> 55555575b000-55555575c000 r--p 00007000 fd:02 34603015
>   /bin/cat
> 55555575c000-55555575d000 rw-p 00008000 fd:02 34603015
>   /bin/cat
> 55555575d000-55555577e000 rw-p 00000000 00:00 0                          =
[heap]
> ...
> 7ffff7ff7000-7ffff7ffa000 r--p 00000000 00:00 0                          =
[vvar]
> 7ffff7ffa000-7ffff7ffc000 r-xp 00000000 00:00 0                          =
[vdso]
> 7ffff7ffc000-7ffff7ffd000 r--p 00027000 fd:02 49287483
>   /lib/x86_64-linux-gnu/ld-2.27.so
> 7ffff7ffd000-7ffff7ffe000 rw-p 00028000 fd:02 49287483
>   /lib/x86_64-linux-gnu/ld-2.27.so
> 7ffff7ffe000-7ffff7fff000 rw-p 00000000 00:00 0
> 7ffffffde000-7ffffffff000 rw-p 00000000 00:00 0                          =
[stack]
>
> $ /lib/x86_64-linux-gnu/ld-2.27.so /bin/cat /proc/self/maps
> ...
> 7ffff7bcc000-7ffff7bd4000 r-xp 00000000 fd:02 34603015
>   /bin/cat
> 7ffff7bd4000-7ffff7dd3000 ---p 00008000 fd:02 34603015
>   /bin/cat
> 7ffff7dd3000-7ffff7dd4000 r--p 00007000 fd:02 34603015
>   /bin/cat
> 7ffff7dd4000-7ffff7dd5000 rw-p 00008000 fd:02 34603015
>   /bin/cat
> 7ffff7dd5000-7ffff7dfc000 r-xp 00000000 fd:02 49287483
>   /lib/x86_64-linux-gnu/ld-2.27.so
> 7ffff7fb2000-7ffff7fd6000 rw-p 00000000 00:00 0
> 7ffff7ff7000-7ffff7ffa000 r--p 00000000 00:00 0                          =
[vvar]
> 7ffff7ffa000-7ffff7ffc000 r-xp 00000000 00:00 0                          =
[vdso]
> 7ffff7ffc000-7ffff7ffd000 r--p 00027000 fd:02 49287483
>   /lib/x86_64-linux-gnu/ld-2.27.so
> 7ffff7ffd000-7ffff7ffe000 rw-p 00028000 fd:02 49287483
>   /lib/x86_64-linux-gnu/ld-2.27.so
> 7ffff7ffe000-7ffff8020000 rw-p 00000000 00:00 0                          =
[heap]
> 7ffffffde000-7ffffffff000 rw-p 00000000 00:00 0                          =
[stack]
>
> So I think changing this globally isn't the right solution (normally
> brk is between text and mmap). Adjusting the mmap base padding means
> we lose even more memory space. Perhaps it would be better if brk
> allocation would be placed before the mmap region (i.e. use
> ELF_ET_DYN_BASE). This seems to work for me:
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 7d09d125f148..cdaa33f4a3ef 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1131,6 +1131,15 @@ static int load_elf_binary(struct linux_binprm *bp=
rm)
>         current->mm->end_data =3D end_data;
>         current->mm->start_stack =3D bprm->p;
>
> +       /*
> +        * When executing a loader directly (ET_DYN without Interp), move
> +        * the brk area out of the mmap region (since it grows up, and ma=
y
> +        * collide early with the stack growing down), and into the unuse=
d
> +        * ELF_ET_DYN_BASE region.
> +        */
> +       if (!elf_interpreter)
> +               current->mm->brk =3D current->mm->start_brk =3D ELF_ET_DY=
N_BASE;
> +
>         if ((current->flags & PF_RANDOMIZE) && (randomize_va_space > 1)) =
{
>                 current->mm->brk =3D current->mm->start_brk =3D
>                         arch_randomize_brk(current->mm);
>
> $ /lib/x86_64-linux-gnu/ld-2.27.so /bin/cat /proc/self/maps
> 555556de3000-555556e04000 rw-p 00000000 00:00 0                          =
[heap]
> 7f8467da9000-7f8467f90000 r-xp 00000000 fd:01 399295
>   /lib/x86_64-linux-gnu/libc-2.27.so
> ...
> 7f846819a000-7f84681a2000 r-xp 00000000 fd:01 263229
>   /bin/cat
> ...
> 7f84685cb000-7f84685cc000 rw-p 00028000 fd:01 399286
>   /lib/x86_64-linux-gnu/ld-2.27.so
> 7f84685cc000-7f84685cd000 rw-p 00000000 00:00 0
> 7ffce68f8000-7ffce6919000 rw-p 00000000 00:00 0                          =
[stack]
> 7ffce69f0000-7ffce69f3000 r--p 00000000 00:00 0                          =
[vvar]
> 7ffce69f3000-7ffce69f4000 r-xp 00000000 00:00 0                          =
[vdso]
>
> Does anyone see problems with this? (Note that ET_EXEC base is
> 0x400000, so no collision there...)

Adding some more people to CC... what do people think about this
moving of the brk to ELF_ET_DYN_BASE in this corner-case? Anything
that worked before should still work (i.e. the ultimately-launched
binary already had the brk very far from its text, so this should be
no different from a COMPAT_BRK standpoint). The only risk I see here
is that if someone started to suddenly depend on the entire memory
space above the mmap region being available when launching binaries
via a direct loader execs... which seems highly unlikely, I'd hope:
this would mean a binary would not work when execed normally.

--=20
Kees Cook
