Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22F3C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C052064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfCGIa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:30:57 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45534 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfCGIa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 03:30:56 -0500
Received: by mail-vs1-f67.google.com with SMTP id n14so3957793vsp.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 00:30:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gb4KXmP16O/0dsL+aVHbdGKiNn6WELO1QnvnFFFXLJs=;
        b=cm2MhHFqubwk0SW2lcfu+lpvDp70viloCCt1/VMbOSyyVk/u/s8VhFueppW4SAJlr2
         wOaZVtJ5YSB3CKeI4i0JLlIxk6IozvxUnSeDJt7IUHARmthKduvKBYIZZcbSrY8zDLtT
         WjP/Bd1KLm2/XmWlf959EOUav5bHKn6ZJbJXe6gjS+ry9rpemPY80eORrYa6iHd4Yo3U
         L/5SgxOrXYFod9dEhIH1DbIWrKsDTdXSqLErkICysiyBBBshWpomHCPsHHufnwkrCRsd
         L2RcxixgT69QHh50Y866RQY1OtHKT1FsSCeI+wt1vv+0m+ba7qZ8iy1i/rv4qJ1+k/Jr
         uLlQ==
X-Gm-Message-State: APjAAAVVqaBzO7rHFnl5Bv8D8q6ExoF71ht4BTthmqzV2ZFr7IDmFlxs
        W3ws44w22oWGFPvMFowkx5hLfLdIOe93dcbsg18=
X-Google-Smtp-Source: APXvYqysAN/crQgPKZzn8EzBkRg3jypf7xCATy5UPtueObAw262gBeL/w484PTrpLhPe5ooVt93Za+c3iTkYR/+JzsU=
X-Received: by 2002:a67:fc9a:: with SMTP id x26mr6326984vsp.166.1551947454837;
 Thu, 07 Mar 2019 00:30:54 -0800 (PST)
MIME-Version: 1.0
References: <201903042049.npxcZzps%fengguang.wu@intel.com> <CAMuHMdX365qmWiii=gQLADpW49EMkdDrVJDPWNBpAZuZM0WQFQ@mail.gmail.com>
 <alpine.LNX.2.21.1903051154200.135@nippy.intranet> <alpine.LNX.2.21.1903051357410.135@nippy.intranet>
 <CAMuHMdUuwudbk15GUPPxL+-Gt4zhhSomk-wMAHeTOkoaDOCUAA@mail.gmail.com>
 <alpine.LNX.2.21.1903051948290.147@nippy.intranet> <mvmh8chzo7j.fsf@linux-m68k.org>
 <alpine.LNX.2.21.1903071329140.513@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1903071329140.513@nippy.intranet>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 7 Mar 2019 09:30:43 +0100
Message-ID: <CAMuHMdVzLTO-yYJJ=HqVySX6gqes9cnyspungsB5maduzNt0RA@mail.gmail.com>
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

On Thu, Mar 7, 2019 at 3:59 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> On Tue, 5 Mar 2019, Andreas Schwab wrote:
> > On Mar 05 2019, Finn Thain <fthain@telegraphics.com.au> wrote:
> >
> > > interesting that the kernel's strlen implementation in
> > > include/linux/string.h can't achieve this.
> >
> > This implementation is only available if ARCH_HAS_FORTIFY_SOURCE.
> >
>
> I see. Perhaps we could add another definition to that file:
>
> #if !defined(__NO_FORTIFY) && defined(__OPTIMIZE__) && defined(CONFIG_FORTIFY_SOURCE)
> ...
> #else
> __FORTIFY_INLINE __kernel_size_t strlen(const char *p)
> {
>         return __builtin_strlen(p);
> }
> #endif
>
> I didn't test that. But the following patch seems to work...
>
> diff --git a/arch/m68k/include/asm/string.h b/arch/m68k/include/asm/string.h
> index f759d944c449..3cff6b128ed3 100644
> --- a/arch/m68k/include/asm/string.h
> +++ b/arch/m68k/include/asm/string.h
> @@ -71,4 +71,6 @@ extern void *memset(void *, int, __kernel_size_t);
>  extern void *memcpy(void *, const void *, __kernel_size_t);
>  #define memcpy(d, s, n) __builtin_memcpy(d, s, n)
>
> +#define strlen(s) __builtin_strlen(s)

Shouldn't you add

    #define __HAVE_ARCH_STRLEN

here...

> +
>  #endif /* _M68K_STRING_H_ */
> diff --git a/lib/string.c b/lib/string.c
> index 38e4ca08e757..fe970f2160e5 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -472,6 +472,7 @@ char *strim(char *s)
>  EXPORT_SYMBOL(strim);
>
>  #ifndef __HAVE_ARCH_STRLEN
> +#undef strlen

... so you can drop this change?

>  /**
>   * strlen - Find the length of a string
>   * @s: The string to be sized

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
