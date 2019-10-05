Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F44C47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 17:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A127B20862
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 17:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtTkvCMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbfJERsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 13:48:11 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33621 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbfJERsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 13:48:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id a22so9650381ljd.0;
        Sat, 05 Oct 2019 10:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zZNhhY18FkUYxvdXBrS9itssQiFFzeLtJaoj2JXXqAk=;
        b=jtTkvCMsQgr40/rZr3sfAWiXsVC5Mb0CPSkge70CEpdEOidUIudxC8niXaDGhWVpCN
         xthvy1+fHAOCxDSmVgY6LemehDRQ191Jc6gPTbQ/+LCEE+5IssCv8wzhoHqxMvnihb82
         IPDHZe1brvCfW7E4f6Nh14Opcssh9IFaqDO8Yb1YEABU5jGKBAAROYLBiD/0XyQ/IgFE
         f2sdW9N/aptywiNQW60MwzRzz650BBkJYjDF24GiPvH+PGd7cpHhPCg0bZHq9KuMps9m
         itvSa2tPml/I779B99fvIn4mdck7hsAbX9YBteUf4nWkGWzSEKWpP47fWjKxxCc88SOO
         5LmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zZNhhY18FkUYxvdXBrS9itssQiFFzeLtJaoj2JXXqAk=;
        b=gcfIHHZ8g65dbco3b09qv1dHPRguiwfw0pNu2Xex349FSKUrfod/3Z0SUPxpTc4DpW
         +0bWgHXTDAj1/t5aN+ygwWfeZkmNYHsCmlk3PouAqMKzZFXcqIxtwmrX3qs3okaxmP7n
         x4dJ+jmrtXZ+ZRn8yUezlTWgJEuxRQxeAGlGbTL8wVnBUpQVmi20Q8YlYJfhUWEp356s
         EJ7NdwlSEe3/0O7kQa3M7Z6VbzZYOgHCNa7yzq+DPSH+HHi99q7xFXdPwPpmBoWy+H/D
         i1NWoG/U7ENjD7nwRRxqtoTeNs7oSzuJU0ZoKXMXaFeKI+PAlFmR5vU5NYFFUfLIcg/U
         urWw==
X-Gm-Message-State: APjAAAXZlwqnXr2g+Ca6zcf+Su6fF/+s7Y5Oa7AQgM1yPJV9oJVb/OcU
        8vM+5P5JYdK27r050B57uqMsWj+EMvawgDUp5Jc=
X-Google-Smtp-Source: APXvYqyDTVdWUGO5xjrtoW4jt+ynij/gt/LXHlMt9W9ChbP/s/3mf4bHlmQek4xkzkDbqQEPxBWAZwptk/D2PJ51pbk=
X-Received: by 2002:a2e:2d5:: with SMTP id y82mr13655515lje.230.1570297688612;
 Sat, 05 Oct 2019 10:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1570292505.git.joe@perches.com> <09a42c7275afa7e6e9e3fc57a15122201fccd6f7.1570292505.git.joe@perches.com>
In-Reply-To: <09a42c7275afa7e6e9e3fc57a15122201fccd6f7.1570292505.git.joe@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 5 Oct 2019 19:47:57 +0200
Message-ID: <CANiq72=KMcYmcHL442OKwDBJj3czey-XtjtOBTLqh_HAsoJAzA@mail.gmail.com>
Subject: Re: [PATCH 3/4] Documentation/process: Add fallthrough pseudo-keyword
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 5, 2019 at 6:47 PM Joe Perches <joe@perches.com> wrote:
>
> diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
> index 56280e108d5a..a0ffdc8daef3 100644
> --- a/Documentation/process/deprecated.rst
> +++ b/Documentation/process/deprecated.rst
> @@ -122,14 +122,27 @@ memory adjacent to the stack (when built without `CONFIG_VMAP_STACK=y`)
>
>  Implicit switch case fall-through
>  ---------------------------------
> -The C language allows switch cases to "fall through" when
> -a "break" statement is missing at the end of a case. This,
> -however, introduces ambiguity in the code, as it's not always
> -clear if the missing break is intentional or a bug. As there
> -have been a long list of flaws `due to missing "break" statements
> +The C language allows switch cases to "fall-through" when a "break" statement
> +is missing at the end of a case. This, however, introduces ambiguity in the
> +code, as it's not always clear if the missing break is intentional or a bug.
> +
> +As there have been a long list of flaws `due to missing "break" statements
>  <https://cwe.mitre.org/data/definitions/484.html>`_, we no longer allow
> -"implicit fall-through". In order to identify an intentional fall-through
> -case, we have adopted the marking used by static analyzers: a comment
> -saying `/* Fall through */`. Once the C++17 `__attribute__((fallthrough))`
> -is more widely handled by C compilers, static analyzers, and IDEs, we can
> -switch to using that instead.
> +"implicit fall-through".
> +
> +In order to identify intentional fall-through cases, we have adopted a
> +pseudo-keyword macro 'fallthrough' which expands to gcc's extension
> +__attribute__((__fallthrough__)).  `Statement Attributes
> +<https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html>`_
> +
> +When the C17/C18  [[fallthrough]] syntax is more commonly supported by

Note that C17/C18 does not have [[fallthrough]]. C++17 introduced it,
as it is mentioned above. I would keep the
__attribute__((fallthrough)) -> [[fallthrough]] change you did,
though, since that is indeed the standard syntax (given the paragraph
references C++17).

I was told by Aaron Ballman (who is proposing them for C) that it is
more or less likely that it becomes standardized in C2x. However, it
is still not added to the draft (other attributes are already,
though). See N2268 and N2269:

    http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2268.pdf (fallthrough)
    http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2269.pdf
(attributes in general)

Cheers,
Miguel
