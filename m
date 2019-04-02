Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45D2C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2B32082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="AJX8EVbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfDBEuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 00:50:37 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:20968 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfDBEuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 00:50:37 -0400
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x324oLWn023524;
        Tue, 2 Apr 2019 13:50:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x324oLWn023524
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554180621;
        bh=Ot1g9otCYSqxn64EcrHD9PXVgmm5v6Q6Og8Hl4kquwY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AJX8EVbqK5YI5KQ6p8ESwkxx7pLNy85VgoBP4qGRQXOW6WJopCbFv2oMdLKgDZjrM
         0FG8XR04z8v7dtHDaVAY6I/67zfyXP8y2sGDodZhT/emtk8W3T+6Qmo5stn6JZxBy+
         qeQEx+IGfpvQGm2vEpOz7beZcrm7lKmx60/yLkCDUrC1kcL3CljBxY4zYsCvJVmA5m
         DBQNjySdJAjAV/3YFSuLwBTZTgsCS9mQ6+Se6BI9yYm1as3HmSYhkAZ+bHaIUAfQP/
         QqNNRMzS4RVQNEcNRewxYjickSBBKi81IvtsHCgx8xyRPC4Vs4TMlKcr6ijUq44jRd
         QzoWcTDNQ/iYA==
X-Nifty-SrcIP: [209.85.222.54]
Received: by mail-ua1-f54.google.com with SMTP id t15so3367632uao.5;
        Mon, 01 Apr 2019 21:50:21 -0700 (PDT)
X-Gm-Message-State: APjAAAV0RbC7ARJCCZtQiw39mi1qwFuXXERqPRDAcGaghaSF+qNRbcz7
        /igS6Yj2e02Gm1bQOTtieGfp40Oh1QP/OhpzVKU=
X-Google-Smtp-Source: APXvYqwZdz/XoNBogZ+RcHk/g6RRL3v1LCPTPJZC4hJFyWfUQek0JufJdcQPGLB6t42eqYjFtT/9Cgux3dYO0JsRETk=
X-Received: by 2002:ab0:1c1b:: with SMTP id a27mr6083926uaj.60.1554180620552;
 Mon, 01 Apr 2019 21:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190211193008.24101-1-ndesaulniers@google.com>
 <20190211193008.24101-3-ndesaulniers@google.com> <CAK7LNATZY-K4g81LLvXpjp=+oMSY8L0wQoVXgHt-Bjrb2WXnNg@mail.gmail.com>
 <CAKwvOdmyNFsV=67eLQtETSDJJyDZ8aEJY1+LHuoP4OtpdQOdWQ@mail.gmail.com>
 <CAK7LNAQMoYNevPns0zSaSx0iU5LA+2146snNDmy9fF8v5ej5tg@mail.gmail.com> <CAKwvOd=h9F1hVjE7C=5mjtF0EXnBW9zTuR78gczhHBv9YUT=Cw@mail.gmail.com>
In-Reply-To: <CAKwvOd=h9F1hVjE7C=5mjtF0EXnBW9zTuR78gczhHBv9YUT=Cw@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 2 Apr 2019 13:49:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQw7nPwykOEV5i+yWjkxzgf1gPa5ewFhDxbbn8XXjwFUA@mail.gmail.com>
Message-ID: <CAK7LNAQw7nPwykOEV5i+yWjkxzgf1gPa5ewFhDxbbn8XXjwFUA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] Makefile: lld: tell clang to use lld
To:     Nick Desaulniers <ndesaulniers@google.com>
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

Hi Nick,


On Tue, Apr 2, 2019 at 12:54 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sat, Feb 16, 2019 at 10:09 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > On Thu, Feb 14, 2019 at 8:08 AM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Wed, Feb 13, 2019 at 6:59 AM Masahiro Yamada
> > > <yamada.masahiro@socionext.com> wrote:
> > > >
> > > > On Tue, Feb 12, 2019 at 5:42 AM <ndesaulniers@google.com> wrote:
> > > > >
> > > > > This is needed because clang doesn't select which linker to use based on
> > > > > $LD but rather -fuse-ld=lld. This is problematic especially for
> > > > > cc-ldoption, which checks for linker flag support via invoking the
> > > > > compiler, rather than the linker.
> > > >
> > > >
> > > > Sorry, please explain what kind of problem
> > > > this patch solves.
> > > >
> > > >
> > > >
> > > > [1] $(LD) is used to link vmlinux, modules, etc.
> > > >
> > > > [2] $(CC) is used to link vdso, etc.
> > > >     and -fuse-ld= selects which linker is invoked from $(CC)
> > >
> > > It solves case 2.
> > >
> > > >
> > > >
> > > > Is it a problem to use a different
> > > > type of linker for [1] and [2] ?
> > >
> > > Ideally, no, but I can think of at least one case where it might be
> > > problematic to mix linkers like that:
> > > You might be mixing linker flags added via ld-option from one linker
> > > that aren't actually supported by the other linker.
> >
> > You can do this only when you are sure
> > that the _exactly_ same linker is used.
> >
> > In my understanding, -fuse-ld=lld does not guarantee it.
>
> I really don't think we should be mixing and matching linkers during a
> kernel build.  When we compile with clang, we don't have escape
> hatches that allow for some object files to be compiled with GCC
> (mixing clang and GCC compiled object files into one build).
> Following the same logic, I think mixing linkers during kernel build
> should similarly be dissuaded.  This patch AVOIDS clang using a
> different linker than what was specified via $LD, which is CRITICAL
> for cc-ldoption kbuild macro.  Masahiro, I hope this patch can be
> re-evaluated, or if I'm not understanding your point, that you can
> provide additional clarification.
>



You can pass an absolute pass to LD, like

make LD=/path/to/my/llvm/install/dir/bin/ld.lld

This clarifies which linker is being used
even when multiple versions of llvm are installed
on the machine.


However, -fuse-ld=lld is ambiguous.
Will it use the first ld.lld found in PATH?

So, you cannot avoid mixing linkers by this means.


If we could do -fuse=$(LD), I would agree with it.
Clang accepts -fuse=<absolute-path>, GCC does not.

Is there a way to control the linker search path?


-- 
Best Regards
Masahiro Yamada
