Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236A7C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6770206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IoDrXIhj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfJGSOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:14:46 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43462 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbfJGSOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:14:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id a2so9146035pfo.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 11:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Aof+lJ1lwyu9yLvpFaqVDdO/hGqaLFM0BeNng/kPgOo=;
        b=IoDrXIhjNEAG2RInFnoSizq0RHLWn0fOQtMv+7VXhTyJ15To1BeDZ0bY7xQkMAz3j/
         IaPFBf7ipuv+MOvtNcgfabFfHnincuNnCH9vN6qqzTqlHyu5J/Wa4jY+9iVsbpcg2Tgh
         yNe9xFiJLdDdOUm8EAvwMVaVMOQe18FHWs9Ze2f0mroUDaQ7qv2p0k22ipUYEx9PAJlc
         2BaERdgVnTEeIQgCADT2VU7HT1lGw1qHPZYxyUEK1LbOaxnntyid96coORp9DboU7xHD
         6+YJkd7M2CsYfmge/HVOajtvEE70IQtD3vm93aYYKIZiyChgaY69wYgo9kkzYP3jzAWI
         bWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Aof+lJ1lwyu9yLvpFaqVDdO/hGqaLFM0BeNng/kPgOo=;
        b=iQjrqiddPOaeuvKNYNU6TH/ZhhLFCRZvgjf/6tJMJhMXGNPLL3iAFx78pSwztFSrED
         YKsNTZYNqK+RytjrTYqAkuLKKWcJs8YexvgWl1rWYoAI8nt/Eonqm5w87rCkUIQitB9/
         w9jw/fFDyE5pU5lU2Px9sn4P/07oycymE/LIjgZny+KVobAO/tSGBZ4kBIzWoEuwH8yz
         ahAA65dyYQ+w/8Va/mX+kVgBYbmWnu/V1eH+TYlDd8LLeSLwQGz5+g8zWKMqNI3XVJ54
         etRxSg+eYqaoVtLhdLW87E0N/9OOUP1bF/ZIexuRHX8wyc8hK6ii70ZMxiudFdzeT30+
         Mr8w==
X-Gm-Message-State: APjAAAVeHlG3+hze4lm32m+Kz1BrWouFAXt7TA5wbNUDqA92rKlddosQ
        codvWYainyW0uY45xsKpQyczKA8CsfNp2oQKE9wDYQ==
X-Google-Smtp-Source: APXvYqwB59dVJaAZwLRfLfYs+uS31KhCGnVD38P9hIXrFI8HVTpOG/f4E3qXeUixe6OwDli7E8LzAAKvA+qjTL8k7uI=
X-Received: by 2002:a17:90a:b285:: with SMTP id c5mr600582pjr.123.1570472082764;
 Mon, 07 Oct 2019 11:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1570292505.git.joe@perches.com> <79237afe056af8d81662f183491e3589922b8ddd.1570292505.git.joe@perches.com>
 <CANiq72kU2_s=58HqdN6VMGDAh_+G+dtns9xzoc4huSVwP+ZXUg@mail.gmail.com>
In-Reply-To: <CANiq72kU2_s=58HqdN6VMGDAh_+G+dtns9xzoc4huSVwP+ZXUg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 7 Oct 2019 11:14:31 -0700
Message-ID: <CAKwvOdkVZ64sLppKxF1XRgarPmCbhw1WLsSq1VcV1tagPgWtUg@mail.gmail.com>
Subject: Re: [PATCH 2/4] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Machek <pavel@ucw.cz>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 5, 2019 at 10:17 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi Joe,
>
> On Sat, Oct 5, 2019 at 6:46 PM Joe Perches <joe@perches.com> wrote:
> >
> > Reserve the pseudo keyword 'fallthrough' for the ability to convert the

Have we precedent already for "pseudo keywords?"  I kind of like the
double underscore prefix we use for attributes (which this is one of),
or at least making macro's ALLCAPS as some sort of convention.
Otherwise, someone might be confused on seeing `fallthrough` sprinkled
throughout the code without knowing how it works. `__fallthough` or
`FALLTHROUGH` are maybe less surprising (and potentially easier to
grep)?  Sorry if this has already been discussed; from Miguel's link
below it looks like there used to be underscore prefixes before?

> > various case block /* fallthrough */ style comments to appear to be an
> > actual reserved word with the same gcc case block missing fallthrough
> > warning capability.
> >
> > All switch/case blocks now must end in one of:
> >
> >         break;
> >         fallthrough;
> >         goto <label>;
> >         return [expression];
> >         continue;
> >
> > fallthough is gcc's __attribute__((__fallthrough__)) which was introduced
> > in gcc version 7..
>
> Nits: double period, missing "r" in fallthough.
>
> > fallthrough devolves to an empty "do {} while (0)" if the compiler
> > version (any version less than gcc 7) does not support the attribute.
>
> Perhaps add a short note why (empty statement warnings maybe? I don't
> remember them but it was months ago so maybe it changed).
>
> > Signed-off-by: Joe Perches <joe@perches.com>
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> Please add Dan's Suggested-by and copy the things I wrote in the
> commit message when I proposed this:
>
>   https://github.com/ojeda/linux/commit/668f011a2706ea555987e263f609a5deba9c7fc4
>
> > ---
> >  include/linux/compiler_attributes.h | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> > index 6b318efd8a74..cdf016596659 100644
> > --- a/include/linux/compiler_attributes.h
> > +++ b/include/linux/compiler_attributes.h
> > @@ -40,6 +40,7 @@
> >  # define __GCC4_has_attribute___noclone__             1
> >  # define __GCC4_has_attribute___nonstring__           0
> >  # define __GCC4_has_attribute___no_sanitize_address__ (__GNUC_MINOR__ >= 8)
> > +# define __GCC4_has_attribute___fallthrough__         0
>
> This goes after __externally_visible__.
>
> >  #endif
> >
> >  /*
> > @@ -185,6 +186,22 @@
> >  # define __noclone
> >  #endif
> >
> > +/*
> > + * Add the pseudo keyword 'fallthrough' so case statement blocks
> > + * must end with any of these keywords:
> > + *   break;
> > + *   fallthrough;
> > + *   goto <label>;
> > + *   return [expression];
> > + *
> > + *  gcc: https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#Statement-Attributes
>
> This also goes after __externally_visible__.
>
> Please add:
>
>   * Optional: only supported since gcc >= 7.1
>   * Optional: only supported since clang >= 10
>   * Optional: not supported by icc
>
> As well as:
>
>   clang: https://clang.llvm.org/docs/AttributeReference.html#fallthrough
>
> See how I did it in the link above:
>
>   https://github.com/ojeda/linux/commit/668f011a2706ea555987e263f609a5deba9c7fc4
>
> > + */
> > +#if __has_attribute(__fallthrough__)
> > +# define fallthrough                    __attribute__((__fallthrough__))
> > +#else
> > +# define fallthrough                    do {} while (0)  /* fallthrough */
> > +#endif
> > +
> >  /*
> >   * Note the missing underscores.
> >   *
> > --
> > 2.15.0
> >
>
> Cheers,
> Miguel



-- 
Thanks,
~Nick Desaulniers
