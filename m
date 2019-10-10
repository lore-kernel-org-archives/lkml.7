Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01BCC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840C0206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WrQxU5tF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfJJUhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 16:37:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34799 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfJJUhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:37:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id b128so4654642pfa.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 13:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pMZW5vPXBLhM8tBCY8rJcYa/z4xJ5M13bp7cRgtTWOI=;
        b=WrQxU5tF5m+Khix2/4yuruKyysT8Z2MV/kilxSkNzpffWCRIJkWVquS6e1wBqFvJdw
         rKj38EJcG/L/EyKA9mTA8IX9+/JbCc3q2IyTmlgSfHfnGFQQS8okP0Sx/O4X4XbqVp9Q
         7T7YT1xer82sWAjdYmtlJrGxsst0CuFeNdfp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pMZW5vPXBLhM8tBCY8rJcYa/z4xJ5M13bp7cRgtTWOI=;
        b=l4qqRNwBrJAOFVECGcVx3iZDybLmSD0jQ+TTuYq2OCCG3TjnyF4qvptjpMYkrCwwj3
         iA5Q3ROwt+HBsY1l1ylrP+nScf5/xplsFvk7GdploRd4r00WAhVxzARmo8aQcjZuT3ap
         1m+5/qDDbNvtaxMIMMttru3bgKDReOOuW/5PgrKTdVmytvKCPAAdLEy42WNEGseDBkVU
         qptUytWVvPq2K3hjJHJurwAYy3f4VnkNt4R596FFnwq6BXOjzLvGVhGkJxbfYp7p2YZx
         Uh+0a61XVUnofy/AV2eSo7Y/+TSuADP5V7c6CRKgcwjp62D82RM9rFuLecZxpqWu/t/H
         nzsQ==
X-Gm-Message-State: APjAAAVz9IhbvycEGOINTSVCyKIMimINRhqsz//DJ+LXjklWe5JvvLse
        XFplOrBYfAgmJeNjm2Fz+tAxsw==
X-Google-Smtp-Source: APXvYqyD/JzQhJOgh9hPYw6qY5eBIEtPX/hzktnKfJ/K15sT89niwGA8tgua2UwbHQEJhjVkJibbMA==
X-Received: by 2002:a63:a54d:: with SMTP id r13mr12919802pgu.353.1570739839786;
        Thu, 10 Oct 2019 13:37:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b3sm5077563pjp.13.2019.10.10.13.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 13:37:19 -0700 (PDT)
Date:   Thu, 10 Oct 2019 13:37:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH 2/4] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use
Message-ID: <201910101334.7E09211F@keescook>
References: <cover.1570292505.git.joe@perches.com>
 <79237afe056af8d81662f183491e3589922b8ddd.1570292505.git.joe@perches.com>
 <CANiq72kU2_s=58HqdN6VMGDAh_+G+dtns9xzoc4huSVwP+ZXUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72kU2_s=58HqdN6VMGDAh_+G+dtns9xzoc4huSVwP+ZXUg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2019 at 07:17:36PM +0200, Miguel Ojeda wrote:
> Hi Joe,
> 
> On Sat, Oct 5, 2019 at 6:46 PM Joe Perches <joe@perches.com> wrote:
> >
> > Reserve the pseudo keyword 'fallthrough' for the ability to convert the
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

Perhaps just take this patch directly with Miguel's authorship into the
series and tweak the __fallthrough to fallthrough in subject and body.

-Kees

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
Kees Cook
