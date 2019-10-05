Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA7AC4740A
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 17:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9237222C8
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 17:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmnkvKAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbfJERRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 13:17:51 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34305 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfJERRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 13:17:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id j19so9602510lja.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 10:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aOGwf0ucGcTkS6kG4Kqk1TV9ERcqoABUEj/aVR2d/Z8=;
        b=nmnkvKAnmJ6huZwLDkCbI0BEMZz0U8eNx9E3GwVdoU8kYKN/jHK+JoN/4Tuo3frO4R
         BcYnL9nLZxSH1mKKGsVA4dAM6ovSFVaBo4xJWx6CmqYOA599+ckIlBAu1Fh+GZRObNle
         E1eSKC2s/JuahQdWmCAePmmoD/uvO01Cbfva3VjcNP7R4QuROA7VMXbYVNVGgaH1GHs7
         IMqMcvm4Ctz4J8gtDSo/JxqnxLGnc7Q1D3uOfIl/aU9jpUF5+AJWCCGH9n+5Zlb3Iq5I
         eTvzOpNlkWQEcQEMReCgy9S3vBvKWct2BWfpV22ZA6d0YRVGn9nH/Dot7oNZNfcqT0QS
         D+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aOGwf0ucGcTkS6kG4Kqk1TV9ERcqoABUEj/aVR2d/Z8=;
        b=EImhgyLI/ArLrxbPnSfo7nRnHNktIJCu6dnmAVrur1TwF5Ddbz+dVQ2VbtAvTn9jly
         5KJ5oqM0XPx83O7viTRjEwWfyO0g+LNbTLIiA5FQV4OY+9kcm/vk0x2V9TRBk2IUDkkX
         hC88VZwiWuaSalwlnLgzRU+y9R4SPVtW6JnLMesls4/t2Si9HPyXX8PpxaigV8KesTcp
         weJZSEXRZAjNrnpxxypl5+p8jgOJHvTuJPAdQjEaHMvyQb5YMHA4dclMjPvp0koSS2bK
         mXPhKhCZZx792dUVBubfu2Lbs+iPaAYzORkrI6+5/+YzlEfdzzRV2tKMd21ayHbGTGtC
         169w==
X-Gm-Message-State: APjAAAUA99XRBnX+jjCzAT1aIU8DzweCWYOnHLFsFDWi/d1MrJS1gvmg
        f66p7EGRghBpY6hSuwZ1/qLwwqp28v81O7VvOI8=
X-Google-Smtp-Source: APXvYqyf/R203uk2dgYx0dAoz07OE5wQM2/VxwGuukp6SCj3pp06/9Av8SFyEJVAMxTC6tvX/q3IcsKfaB2lYXQp5R8=
X-Received: by 2002:a2e:9a4e:: with SMTP id k14mr9654449ljj.129.1570295867498;
 Sat, 05 Oct 2019 10:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1570292505.git.joe@perches.com> <79237afe056af8d81662f183491e3589922b8ddd.1570292505.git.joe@perches.com>
In-Reply-To: <79237afe056af8d81662f183491e3589922b8ddd.1570292505.git.joe@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 5 Oct 2019 19:17:36 +0200
Message-ID: <CANiq72kU2_s=58HqdN6VMGDAh_+G+dtns9xzoc4huSVwP+ZXUg@mail.gmail.com>
Subject: Re: [PATCH 2/4] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Sat, Oct 5, 2019 at 6:46 PM Joe Perches <joe@perches.com> wrote:
>
> Reserve the pseudo keyword 'fallthrough' for the ability to convert the
> various case block /* fallthrough */ style comments to appear to be an
> actual reserved word with the same gcc case block missing fallthrough
> warning capability.
>
> All switch/case blocks now must end in one of:
>
>         break;
>         fallthrough;
>         goto <label>;
>         return [expression];
>         continue;
>
> fallthough is gcc's __attribute__((__fallthrough__)) which was introduced
> in gcc version 7..

Nits: double period, missing "r" in fallthough.

> fallthrough devolves to an empty "do {} while (0)" if the compiler
> version (any version less than gcc 7) does not support the attribute.

Perhaps add a short note why (empty statement warnings maybe? I don't
remember them but it was months ago so maybe it changed).

> Signed-off-by: Joe Perches <joe@perches.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Please add Dan's Suggested-by and copy the things I wrote in the
commit message when I proposed this:

  https://github.com/ojeda/linux/commit/668f011a2706ea555987e263f609a5deba9c7fc4

> ---
>  include/linux/compiler_attributes.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> index 6b318efd8a74..cdf016596659 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -40,6 +40,7 @@
>  # define __GCC4_has_attribute___noclone__             1
>  # define __GCC4_has_attribute___nonstring__           0
>  # define __GCC4_has_attribute___no_sanitize_address__ (__GNUC_MINOR__ >= 8)
> +# define __GCC4_has_attribute___fallthrough__         0

This goes after __externally_visible__.

>  #endif
>
>  /*
> @@ -185,6 +186,22 @@
>  # define __noclone
>  #endif
>
> +/*
> + * Add the pseudo keyword 'fallthrough' so case statement blocks
> + * must end with any of these keywords:
> + *   break;
> + *   fallthrough;
> + *   goto <label>;
> + *   return [expression];
> + *
> + *  gcc: https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#Statement-Attributes

This also goes after __externally_visible__.

Please add:

  * Optional: only supported since gcc >= 7.1
  * Optional: only supported since clang >= 10
  * Optional: not supported by icc

As well as:

  clang: https://clang.llvm.org/docs/AttributeReference.html#fallthrough

See how I did it in the link above:

  https://github.com/ojeda/linux/commit/668f011a2706ea555987e263f609a5deba9c7fc4

> + */
> +#if __has_attribute(__fallthrough__)
> +# define fallthrough                    __attribute__((__fallthrough__))
> +#else
> +# define fallthrough                    do {} while (0)  /* fallthrough */
> +#endif
> +
>  /*
>   * Note the missing underscores.
>   *
> --
> 2.15.0
>

Cheers,
Miguel
