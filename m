Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6F4C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A72C206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dOzQEPkF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbfDBDy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 23:54:28 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39883 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfDBDy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 23:54:28 -0400
Received: by mail-pl1-f196.google.com with SMTP id b65so5537260plb.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 20:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bS9a/wdyzrQl8eX3az2nu97FEDv8n+9ViI7DAmxGGLI=;
        b=dOzQEPkFsOSZ/JaXiC3jkpE3hntOwGrW+pFT4/Of21vxrU+PTTv8QgKGdWhp1CP0OM
         2H4qkFEdY5VwRtTpsw3Mcvl2RfpH3UM/GvM9S2qVTfisy8RLQCGkDAI56lX4ACyaZutU
         anExfsAYF3hcm8gRzYAZ50X5X6iI00JbumE0oPRuVTZfzw26ENt/Jg5T6UA+YSsPQJti
         Rj/AfTdinrIAA7f+ff2gMhqVzwYn3DoKuOaP/XBtrh0XYRmXiFsJPT78GtlaaU2aUhkQ
         +xpqFWm+QArxv6Qf2tDJsxoVZGu+S3AJ6RkEGNW9hRBu1JTmo/L//qn/5jh06SEUmMP2
         TojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bS9a/wdyzrQl8eX3az2nu97FEDv8n+9ViI7DAmxGGLI=;
        b=stoSqTVypcqovmas/zOmTVDl2CMAvuskPvG5wYkcUm2dDZ27W7oZadzz7efCKFb2Ef
         AzquhEXnELTdhXlN+NH8ce9N3I64Chdtfb7g8c19GL7oo5vNx1Dvn+mBPuoANjvkfUGZ
         hKwP8OJPZ9YEnv0yDuBOvBdlXT9n93z1ryHI++pEXbqsUJwjP+L5N5ILWIaYw58sFJM1
         Y4KZROiL8UlC+gaorK7ykmrol0tmVEAh66EsOKPZ/Yg6rf292YzOMuHDFSyRcOXgg3lx
         r97y6DJh6TM3ZSm6knRaR1EUq43dS9AUu1E3xgw1JvnfZy5qRjHdVhRtJVIDH0tm+SPm
         K2rw==
X-Gm-Message-State: APjAAAUFeM19oklgC9jJeV2wP2p+s94XPuZ5LRlSeCz/9okf9R8/KR4P
        h/O9SY3LxDSSmtaU15MvPKBBVCyseE3r/ZoXW9lSXg==
X-Google-Smtp-Source: APXvYqxkeYf/1TfPQYzoZV7sMv/JsIp6VjvXXmY+7RcEjiQLUx1YeYy+SpBMuTcXFJDdsZzwwatnw2gk6QmpVCaPhjs=
X-Received: by 2002:a17:902:8a8b:: with SMTP id p11mr59632904plo.227.1554177266898;
 Mon, 01 Apr 2019 20:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190211193008.24101-1-ndesaulniers@google.com>
 <20190211193008.24101-3-ndesaulniers@google.com> <CAK7LNATZY-K4g81LLvXpjp=+oMSY8L0wQoVXgHt-Bjrb2WXnNg@mail.gmail.com>
 <CAKwvOdmyNFsV=67eLQtETSDJJyDZ8aEJY1+LHuoP4OtpdQOdWQ@mail.gmail.com> <CAK7LNAQMoYNevPns0zSaSx0iU5LA+2146snNDmy9fF8v5ej5tg@mail.gmail.com>
In-Reply-To: <CAK7LNAQMoYNevPns0zSaSx0iU5LA+2146snNDmy9fF8v5ej5tg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 2 Apr 2019 10:54:15 +0700
Message-ID: <CAKwvOd=h9F1hVjE7C=5mjtF0EXnBW9zTuR78gczhHBv9YUT=Cw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] Makefile: lld: tell clang to use lld
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Smith <Peter.Smith@arm.com>,
        Stephen Hines <srhines@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 10:09 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Thu, Feb 14, 2019 at 8:08 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Wed, Feb 13, 2019 at 6:59 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> > >
> > > On Tue, Feb 12, 2019 at 5:42 AM <ndesaulniers@google.com> wrote:
> > > >
> > > > This is needed because clang doesn't select which linker to use based on
> > > > $LD but rather -fuse-ld=lld. This is problematic especially for
> > > > cc-ldoption, which checks for linker flag support via invoking the
> > > > compiler, rather than the linker.
> > >
> > >
> > > Sorry, please explain what kind of problem
> > > this patch solves.
> > >
> > >
> > >
> > > [1] $(LD) is used to link vmlinux, modules, etc.
> > >
> > > [2] $(CC) is used to link vdso, etc.
> > >     and -fuse-ld= selects which linker is invoked from $(CC)
> >
> > It solves case 2.
> >
> > >
> > >
> > > Is it a problem to use a different
> > > type of linker for [1] and [2] ?
> >
> > Ideally, no, but I can think of at least one case where it might be
> > problematic to mix linkers like that:
> > You might be mixing linker flags added via ld-option from one linker
> > that aren't actually supported by the other linker.
>
> You can do this only when you are sure
> that the _exactly_ same linker is used.
>
> In my understanding, -fuse-ld=lld does not guarantee it.

I really don't think we should be mixing and matching linkers during a
kernel build.  When we compile with clang, we don't have escape
hatches that allow for some object files to be compiled with GCC
(mixing clang and GCC compiled object files into one build).
Following the same logic, I think mixing linkers during kernel build
should similarly be dissuaded.  This patch AVOIDS clang using a
different linker than what was specified via $LD, which is CRITICAL
for cc-ldoption kbuild macro.  Masahiro, I hope this patch can be
re-evaluated, or if I'm not understanding your point, that you can
provide additional clarification.

-- 
Thanks,
~Nick Desaulniers
