Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8AEC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2013D208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mOIsiXuy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfEJR5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 13:57:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44426 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbfEJR5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 13:57:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id z16so3349820pgv.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 10:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VOuGPhrIxeDuwlb+V+gF2cUy7+yMjgBS0voa81cD1ZE=;
        b=mOIsiXuywCZPv+ClDKwfdEW39vo0ZZd0SW0CFsbw9vWXRfIgsEre0tfwCx6q00cfbf
         +htAr/aGnXv9TdCRqWrnxf58uI/XK+KsCn6N8zScRzbFLv7PxzYIyB7AL8F4pRmJFCkT
         vmCsDq+1moLfAjUsPghhqStkiut/s8e9HK7BkK7CNGSl/J+3RbX8EJY/oRq6eIxK2WSt
         3XAWBRR2AM+EF2ULw47RFP4NcjF/nE8Ig6oqFAmYMUoFbdlI/vrNly6VbBN2VoB0OPx0
         HqBQF5hNGtzRHrXXIRquQUcBeYzrr3uKSPPI/OL6U9tRnWli26oH4+RPQ9bdfKxI5ei7
         4Hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VOuGPhrIxeDuwlb+V+gF2cUy7+yMjgBS0voa81cD1ZE=;
        b=U7uxazNySG3P3XWCBJ3ShzBOcOykU/PEPcYbs8eS6LxgzmGXB02IV5PBabsZkgQ6G5
         vAZOqIqJ9U/hFtI4lzE+22CUz+rU/HldSuBmRFuwYYw0NcqVjI1iZk/5vZ+hg/1Mo09P
         gLL+ZejzCna5lhnE4OWg0U8wOLg/N0hYYazXq1Ihw6WKT6cadxQSszB+E5ln+SHeFIYV
         a4e43yTm4g3wpqVsyqTl1EAbsLIfMnPUVAFgcz07wZgaLI8Ye+vp+sjiQ5m//cacfjlJ
         hi7ZaiQUoxIm9IXO1gm7cr5Q+Q0xfXB7rrQ3sEZHNF93kXCJYBfFf+VVMAwA83d9J0SE
         3ZYA==
X-Gm-Message-State: APjAAAVsXNhdvbNZ8g6hmxyGHMsn0y5opg9FczQNdnz7rOE8b5rj0PnY
        eGp6ZNEZs72acWa/94oJN57zLVl4vHxUTicTQqD4Kg==
X-Google-Smtp-Source: APXvYqwOIiIqqwM2z/zA32ar7A1PUfGt4O/YdBnrJgzPsi6hlqYGyzRgcZVHZmsFzYgounGLJwoG1/3yVF1RnyN7MHA=
X-Received: by 2002:a63:f44b:: with SMTP id p11mr14838157pgk.225.1557511033089;
 Fri, 10 May 2019 10:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190509064455.1173-1-yamada.masahiro@socionext.com>
 <CA+icZUX_AgZdH5Z+1+k+oVdYSo7vqzeJsGPndb_Sa8VOSk_yOg@mail.gmail.com> <CAK7LNAS+FQqQZ0RfW8e6mxabUOq9YVk=eEEztmN-+BHnTmDa_w@mail.gmail.com>
In-Reply-To: <CAK7LNAS+FQqQZ0RfW8e6mxabUOq9YVk=eEEztmN-+BHnTmDa_w@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 10 May 2019 10:57:01 -0700
Message-ID: <CAKwvOdkt9eCFdy7pNer7+6ZNz4vFVX_55Fe_98W1RFFzwz3U5Q@mail.gmail.com>
Subject: Re: [PATCH] kbuild: add most of Clang-specific flags unconditionally
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Behan Webster <behanw@converseincode.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 6:54 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Thu, May 9, 2019 at 4:06 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Thu, May 9, 2019 at 8:45 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> > >
> > > We do not support old Clang versions. Upgrade your clang version
> > > if any of these flags is unsupported.
> > >
> > > Let's add flags within ifdef CONFIG_CC_IS_CLANG unconditionally,
> > > except -fcatch-undefined-behavior.
> > >
> > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >
> > Looks good to me.
> >
> > Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>
> >
> > Just as sidenote:
> > I experimented with a snapshot version of clang-9 and lld-9 and could
> > build, link and boot on bare-metal with '-mglobal-merge' on
> > Debian/buster AMD64.
>
>
> The comment says
>  # CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
>  # source of a reference will be _MergedGlobals and not on of the
> whitelisted names.
>  # See modpost pattern 2
>
> So, it seems it is just a matter of modpost,
> but I am not sure enough.
>
> This flag has been here since the initial support.
> (61163efae02040f66a95c8ed17f4407951ba58fa)
>
>
> Perhaps, we should review clang flags one by one again?

Yes, it's always good to re-evaluate if something is just cruft and
can be removed.

+Behan

I don't quite understand the comment about _MergedGlobals, Behan, do
happen to have more context?
-- 
Thanks,
~Nick Desaulniers
