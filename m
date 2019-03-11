Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69203C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423F4206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfCKJOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:14:25 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46527 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfCKJOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:14:24 -0400
Received: by mail-vs1-f65.google.com with SMTP id b17so2223116vsr.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 02:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PuQeRMisIVhGjNz6Qb/iU/T3AY0VkaMTmKCFjo+Ggng=;
        b=aiEgPuIVNpWaQZ5jxq9ZfOYuXYKS8XbuOTzMyYSO2n9vvyYRn3t0/R0WiKQwHK+EXz
         +kwoLPYex3CNPyoy7gEmmhbLVErOOvFxkD7/pyamb+sk9uz2K4uAOJGtM9T6e6/zrMpA
         YZjkVd+uo/uh5S10S+f2M/0aTz6EmE5jx14jMLyKMvYHvW+Uqm8SdTXj2SARUNY6UsZo
         7nQEs0Ykm6sdPKQkW3y1CYzW9CP3Vc9/m+irv/FBmQquIR3OW+euR03lxDhvV6+/HHBf
         Sx3fkipiOClL7ohQM5765tb9d4snbZfhyjijA4SrO0sUt1NHq2K0Vxzkf35eEekmB4Vh
         FpLQ==
X-Gm-Message-State: APjAAAW/jjGNGvk1xtEv0u/f1yeSsDhexVq1Yl/poABZHEslabEYBAX0
        UtVotcDJuJL0s5gs5cq24UtUFKShN/T9CxGYsEZP1ZIR
X-Google-Smtp-Source: APXvYqwQrHlwNMY6K4fcj0hRsTEqOZELpm9OB/w7iek3jNB072mVO386TVNeDhlqU+mfu2BdJ/pK7M6XTcpEYvCZ/Fg=
X-Received: by 2002:a67:8588:: with SMTP id h130mr15401357vsd.11.1552295663204;
 Mon, 11 Mar 2019 02:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <201903042049.npxcZzps%fengguang.wu@intel.com> <CAMuHMdX365qmWiii=gQLADpW49EMkdDrVJDPWNBpAZuZM0WQFQ@mail.gmail.com>
 <alpine.LNX.2.21.1903051154200.135@nippy.intranet> <alpine.LNX.2.21.1903051357410.135@nippy.intranet>
 <CAMuHMdUuwudbk15GUPPxL+-Gt4zhhSomk-wMAHeTOkoaDOCUAA@mail.gmail.com>
 <alpine.LNX.2.21.1903051948290.147@nippy.intranet> <mvmh8chzo7j.fsf@linux-m68k.org>
 <alpine.LNX.2.21.1903071329140.513@nippy.intranet> <CAMuHMdVzLTO-yYJJ=HqVySX6gqes9cnyspungsB5maduzNt0RA@mail.gmail.com>
 <alpine.LNX.2.21.1903080838260.595@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1903080838260.595@nippy.intranet>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Mar 2019 10:14:11 +0100
Message-ID: <CAMuHMdWr-Y7mfH3gFXfK0fWpEhhdoW9VUkOEwf0nFN8kfr4zrg@mail.gmail.com>
Subject: Re: [m68k:master 1174/1174] arch/m68k/include/asm/string.h:72:25:
 warning: '__builtin_memcpy' forming offset 8 is out of the bounds [0, 7]
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Thu, Mar 7, 2019 at 10:42 PM Finn Thain <fthain@telegraphics.com.au> wrote:
> On Thu, 7 Mar 2019, Geert Uytterhoeven wrote:
> > On Thu, Mar 7, 2019 at 3:59 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> > > On Tue, 5 Mar 2019, Andreas Schwab wrote:
> > > > On Mar 05 2019, Finn Thain <fthain@telegraphics.com.au> wrote:
> > > >
> > > > > interesting that the kernel's strlen implementation in
> > > > > include/linux/string.h can't achieve this.
> > > >
> > > > This implementation is only available if ARCH_HAS_FORTIFY_SOURCE.
> > > >
> > >
> > > I see. Perhaps we could add another definition to that file:
> > >
> > > #if !defined(__NO_FORTIFY) && defined(__OPTIMIZE__) && defined(CONFIG_FORTIFY_SOURCE)
> > > ...
> > > #else
> > > __FORTIFY_INLINE __kernel_size_t strlen(const char *p)
> > > {
> > >         return __builtin_strlen(p);
> > > }
> > > #endif
> > >
> > > I didn't test that.
>
> I've tested it now, it works too. This may be a better solution than
> defining a strlen macro.
>
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 7927b875f80c..ec9c0a206bd3 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -436,6 +436,13 @@ __FORTIFY_INLINE char *strcpy(char *p, const char *q)
>         return p;
>  }
>
> +#else
> +
> +__FORTIFY_INLINE __kernel_size_t strlen(const char *p)
> +{
> +       return __builtin_strlen(p);
> +}
> +
>  #endif
>
>  /**
>
> > But the following patch seems to work...
> > >
> > > diff --git a/arch/m68k/include/asm/string.h b/arch/m68k/include/asm/string.h
> > > index f759d944c449..3cff6b128ed3 100644
> > > --- a/arch/m68k/include/asm/string.h
> > > +++ b/arch/m68k/include/asm/string.h
> > > @@ -71,4 +71,6 @@ extern void *memset(void *, int, __kernel_size_t);
> > >  extern void *memcpy(void *, const void *, __kernel_size_t);
> > >  #define memcpy(d, s, n) __builtin_memcpy(d, s, n)
> > >
> > > +#define strlen(s) __builtin_strlen(s)
> >
> > Shouldn't you add
> >
> >     #define __HAVE_ARCH_STRLEN
> >
> > here...
> >
>
> No, the link fails because the compiler still emits some references to
> strlen().

Despite -ffreestanding?!?

> > > --- a/lib/string.c
> > > +++ b/lib/string.c
> > > @@ -472,6 +472,7 @@ char *strim(char *s)
> > >  EXPORT_SYMBOL(strim);
> > >
> > >  #ifndef __HAVE_ARCH_STRLEN
> > > +#undef strlen
> >
> > ... so you can drop this change?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
