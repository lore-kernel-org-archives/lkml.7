Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB087C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728FF2071F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c0fy+grX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfK1NKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:10:18 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:46424 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfK1NKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:10:18 -0500
Received: by mail-qv1-f67.google.com with SMTP id t9so209850qvh.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 05:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XzZgQRCZD+3idslgSIr896JIp//k3a3oW/TZHuinsT8=;
        b=c0fy+grX7cHYgmNPkyIS9cZrftoy5Wib3atffBwds5SlI5pe3eT2cqJiZGEikhNFG5
         Xya4rrBSwqIJw8qZhqILWhOOOKMCRx7ktvvvxicszo3SA10ox033ClsWOJxpZRDU/eSl
         ckc60WPKB//pZQLaL/ElM3RM5GszDZKXILpyriYSU2PgybOnPaP3HweG8WffyWynlGNt
         dks7hTMxYAXTDM3PIu8++a0/VmRM2mVw6lYvqoMVmKaLvXJsDvVZrjVYhtsZnLSSQQoQ
         CWdavPKWkRF6F42ABRXqKmemavdOb3A5KVEWENlgO3gVXurXMX18LPLOWPe7uwbANnII
         tsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XzZgQRCZD+3idslgSIr896JIp//k3a3oW/TZHuinsT8=;
        b=g2hjx/eqd8b37VR44wuwmbYkeWWfIf8f464ahxdxr1OcJpH7jZpHzMnp0MiIFvgIhk
         lAoShWVKRZ902HkvIbEysas8hCmJPAeKNX04wOADhOELWVtsIM0vFifldj9igIzF3jES
         /kXy8p0H7A9TZohRqbYXpaktFCMfw3Q6REcWQuvdwU4xEArH8tLOlMu4W/ESO+6ufBX3
         pj+ZncMFfrv7oRU3e+TG+r9yOwejy2dq/0B8WTxhyetzeU4THSerCj3cGlzLB5QDb0ew
         bQ09sVWHhAxD8HopXt2jrKEZrue3Fnv2rBZbTfvTQsf29PoiZ7Jn29y66dDImOlGLYil
         2CGA==
X-Gm-Message-State: APjAAAWDGvul0uWtHx5nJDEPtSleVw0wGnqAVRt0vEsn0ImSR4OvE9ir
        OpCkHcSdYxytUDWt5EeHyS61hgom515R23UYNefG8Q==
X-Google-Smtp-Source: APXvYqx472lJ6NH/fZtA/t82VG1hJIZnxbybuySiBpoASQC0e491q414ESKXTHtMRBTm5075kGLs+9AyqSQyLQn4MNU=
X-Received: by 2002:a0c:b064:: with SMTP id l33mr10887868qvc.34.1574946616239;
 Thu, 28 Nov 2019 05:10:16 -0800 (PST)
MIME-Version: 1.0
References: <20191121181519.28637-1-keescook@chromium.org> <CACT4Y+b3JZM=TSvUPZRMiJEPNH69otidRCqq9gmKX53UHxYqLg@mail.gmail.com>
 <201911262134.ED9E60965@keescook> <CACT4Y+bsLJ-wFx_TaXqax3JByUOWB3uk787LsyMVcfW6JzzGvg@mail.gmail.com>
 <CACT4Y+aFiwxT6SO-ABx695Yg3=Zam5saqCo4+FembPwKSV8cug@mail.gmail.com> <201911270952.D66CD15AEC@keescook>
In-Reply-To: <201911270952.D66CD15AEC@keescook>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 28 Nov 2019 14:10:04 +0100
Message-ID: <CACT4Y+b7YtWw57C-1mv1z5bTSa9YpnwhKsgMAtpMuc6J8KXBUg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ubsan: Split out bounds checker
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Alexander Potapenko <glider@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 6:59 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Nov 27, 2019 at 10:34:24AM +0100, Dmitry Vyukov wrote:
> > On Wed, Nov 27, 2019 at 7:54 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > On Wed, Nov 27, 2019 at 6:42 AM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > On Fri, Nov 22, 2019 at 10:07:29AM +0100, Dmitry Vyukov wrote:
> > > > > On Thu, Nov 21, 2019 at 7:15 PM Kees Cook <keescook@chromium.org> wrote:
> > > > > >
> > > > > > v2:
> > > > > >     - clarify Kconfig help text (aryabinin)
> > > > > >     - add reviewed-by
> > > > > >     - aim series at akpm, which seems to be where ubsan goes through?
> > > > > > v1: https://lore.kernel.org/lkml/20191120010636.27368-1-keescook@chromium.org
> > > > > >
> > > > > > This splits out the bounds checker so it can be individually used. This
> > > > > > is expected to be enabled in Android and hopefully for syzbot. Includes
> > > > > > LKDTM tests for behavioral corner-cases (beyond just the bounds checker).
> > > > > >
> > > > > > -Kees
> > > > >
> > > > > +syzkaller mailing list
> > > > >
> > > > > This is great!
> > > >
> > > > BTW, can I consider this your Acked-by for these patches? :)
> > > >
> > > > > I wanted to enable UBSAN on syzbot for a long time. And it's
> > > > > _probably_ not lots of work. But it was stuck on somebody actually
> > > > > dedicating some time specifically for it.
> > > >
> > > > Do you have a general mechanism to test that syzkaller will actually
> > > > pick up the kernel log splat of a new check?
> > >
> > > Yes. That's one of the most important and critical parts of syzkaller :)
> > > The tests for different types of bugs are here:
> > > https://github.com/google/syzkaller/tree/master/pkg/report/testdata/linux/report
> > >
> > > But have 3 for UBSAN, but they may be old and it would be useful to
> > > have 1 example crash per bug type:
> > >
> > > syzkaller$ grep UBSAN pkg/report/testdata/linux/report/*
> > > pkg/report/testdata/linux/report/40:TITLE: UBSAN: Undefined behaviour
> > > in drivers/usb/core/devio.c:LINE
> > > pkg/report/testdata/linux/report/40:[    4.556972] UBSAN: Undefined
> > > behaviour in drivers/usb/core/devio.c:1517:25
> > > pkg/report/testdata/linux/report/41:TITLE: UBSAN: Undefined behaviour
> > > in ./arch/x86/include/asm/atomic.h:LINE
> > > pkg/report/testdata/linux/report/41:[    3.805453] UBSAN: Undefined
> > > behaviour in ./arch/x86/include/asm/atomic.h:156:2
> > > pkg/report/testdata/linux/report/42:TITLE: UBSAN: Undefined behaviour
> > > in kernel/time/hrtimer.c:LINE
> > > pkg/report/testdata/linux/report/42:[   50.583499] UBSAN: Undefined
> > > behaviour in kernel/time/hrtimer.c:310:16
> > >
> > > One of them is incomplete and is parsed as "corrupted kernel output"
> > > (won't be reported):
> > > https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/42
> > >
> > > Also I see that report parsing just takes the first line, which
> > > includes file name, which is suboptimal (too long, can't report 2 bugs
> > > in the same file). We seem to converge on "bug-type in function-name"
> > > format.
> > > The thing about bug titles is that it's harder to change them later.
> > > If syzbot already reported 100 bugs and we change titles, it will
> > > start re-reporting the old one after new names and the old ones will
> > > look stale, yet they still relevant, just detected under different
> > > name.
> > > So we also need to get this part right before enabling.
>
> It Sounds like instead of "UBSAN: Undefined behaviour in $file", UBSAN
> should report something like "UBSAN: $behavior in $file"?
>
> e.g.
> 40: UBSAN: bad shift in drivers/usb/core/devio.c:1517:25"
> 41: UBSAN: signed integer overflow in ./arch/x86/include/asm/atomic.h:156:2
>
> I'll add one for the bounds checker.
>
> How are these reports used? (And is there a way to check a live kernel
> crash? i.e. to tell syzkaller "echo ARRAY_BOUNDS >/.../lkdtm..." and
> generate a report?

I've collected the sample and added to syzkaller test base:
https://github.com/google/syzkaller/commit/76357d6f894431c00cc09cfc9e7474701a4b822a

I also filed https://github.com/google/syzkaller/issues/1523 for
enabling UBSAN on syzbot, let's move syzbot-related discussion there.
