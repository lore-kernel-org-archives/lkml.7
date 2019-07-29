Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447C3C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE5420693
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WnPAv7gR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbfG2U2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:28:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40371 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfG2U2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:28:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so28822464pgj.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 13:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y1z+oU927gvd6PfHaT54CHvo6q52oyAkltdUcawl8mU=;
        b=WnPAv7gRPtDL76TM5c0SqbPMMEL+GfKfPvQ4IfjgrjbM2uXrxPcX+FBEzofjw0jvqw
         folsVZaLHYUkjinGCTkKOSsqnGkxGKvxbfJhWF+xxb1IGXeI182GocYI6Bzc/bWcNbsn
         66FPrtohuU6YJpCX2xNwtz/Q544FE6qUGu84BDpz8/C5lA851svaRuR6GlORaVm02BTq
         hwcEJ2yZRo/qya3saCqwrA8wBEtnybvt1zJfIOXM8TI5IlHGnIBz8lkxIHsWeBiguZRs
         YED7/nL9bqMTvzJTkOU8zkqcCqPk/tS6xOj3p5FRQzmHbpYJlNb0r/uaM+dFXpeXfefm
         11AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y1z+oU927gvd6PfHaT54CHvo6q52oyAkltdUcawl8mU=;
        b=l3xlo5RfaysNpoNEs/cHVpUZH47oSrnvHlxgpP/nXFKeXspe0pdduLzoHS8RrypPkZ
         ih7OXgtkU2vK0lIwPpZ6YiH33MKOKWZ/9HNYKFbgh52d0P2hAIdlvNQdYgRuri8X137Z
         6qnWk2sp04DJt6eaG+jTHuHRBqL2qb15NOpeiHBERqqAPAww0DHd4xs1cEG29PLvPMLB
         3+qTqLlBD6hWb+WMXqHf5agV1uz1wjN7ZtLtKQaHjx2b42YcN77KUveoNinM19JJ2SR2
         imalrYr1wWTrCgcqOdAcxUPDPROST92unD93Sz1SLf7Kdk+Le4wlQg6uqsUWGhqVYGCU
         haoQ==
X-Gm-Message-State: APjAAAWEciDUEeioMDj2EVEoM5FsJMgFHSIViAPgXnGRJQkfFpQ/Pgnj
        RcHP1Cs5z5BAABS6tjwRh9IXbjtS+ddE/3gTp4D5dA==
X-Google-Smtp-Source: APXvYqzhY7YM+Zcd9blUrsUH+Zigw4npoWn8JZV5Zq0OXVz6ZApe9qgI2GCTQdM/h22L7S8H6Dc+QuMq4q+mNlh+lR4=
X-Received: by 2002:a62:2c8e:: with SMTP id s136mr38828948pfs.3.1564432097105;
 Mon, 29 Jul 2019 13:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <a5864549-40c3-badd-8c41-d5b7bf3c4f3c@c-s.fr> <20190709064952.GA40851@archlinux-threadripper>
 <20190719032456.GA14108@archlinux-threadripper> <20190719152303.GA20882@gate.crashing.org>
 <20190719160455.GA12420@archlinux-threadripper> <20190721075846.GA97701@archlinux-threadripper>
 <20190721180150.GN20882@gate.crashing.org> <20190722024140.GA55142@archlinux-threadripper>
 <20190722061940.GZ20882@gate.crashing.org> <CAKwvOd=KRVsFkT8dLFoitky9OF8tKmbn00-OPi6kBygyx4QwHg@mail.gmail.com>
 <20190722175817.GE20882@gate.crashing.org> <CAKwvOdkzBt=tTk+26dp+QsCStMUJ0_v5Mpjy2TOXPw1mu71itg@mail.gmail.com>
In-Reply-To: <CAKwvOdkzBt=tTk+26dp+QsCStMUJ0_v5Mpjy2TOXPw1mu71itg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 29 Jul 2019 13:28:04 -0700
Message-ID: <CAKwvOd=knc1i+RBzJ2YTVKn3W3EzCeEnCfy3983WE6L5-V4x8A@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc: slightly improve cache helpers
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        James Y Knight <jyknight@google.com>,
        Joel Stanley <joel@jms.id.au>, dja@axtens.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 2:30 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Jul 22, 2019 at 10:58 AM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> >
> > On Mon, Jul 22, 2019 at 10:21:07AM -0700, Nick Desaulniers wrote:
> > > On Sun, Jul 21, 2019 at 11:19 PM Segher Boessenkool
> > > <segher@kernel.crashing.org> wrote:
> > > > On Sun, Jul 21, 2019 at 07:41:40PM -0700, Nathan Chancellor wrote:
> > > > > On Sun, Jul 21, 2019 at 01:01:50PM -0500, Segher Boessenkool wrote:
> > > > > > On Sun, Jul 21, 2019 at 12:58:46AM -0700, Nathan Chancellor wrote:
> > > > > > > 0000017c clear_user_page:
> > > > > > >      17c: 94 21 ff f0                     stwu 1, -16(1)
> > > > > > >      180: 38 80 00 80                     li 4, 128
> > > > > > >      184: 38 63 ff e0                     addi 3, 3, -32
> > > > > > >      188: 7c 89 03 a6                     mtctr 4
> > > > > > >      18c: 38 81 00 0f                     addi 4, 1, 15
> > > > > > >      190: 8c c3 00 20                     lbzu 6, 32(3)
> > > > > > >      194: 98 c1 00 0f                     stb 6, 15(1)
> > > > > > >      198: 7c 00 27 ec                     dcbz 0, 4
> > > > > > >      19c: 42 00 ff f4                     bdnz .+65524
> > > > > >
> > > > > > Uh, yeah, well, I have no idea what clang tried here, but that won't
> > > > > > work.  It's copying a byte from each target cache line to the stack,
> > > > > > and then does clears the cache line containing that byte on the stack.
> > > > > >
> > > > > > I *guess* this is about "Z" and not about "%y", but you'll have to ask
> > > > > > the clang people.
> > > > > >
> > > > > > Or it may be that they do not treat inline asm operands as lvalues
> > > > > > properly?  That rings some bells.  Yeah that looks like it.
> > > >
> > > > The code is
> > > >   __asm__ __volatile__ ("dcbz %y0" : : "Z"(*(u8 *)addr) : "memory");
> > > >
> > > > so yeah it looks like clang took that  *(u8 *)addr  as rvalue, and
> > > > stored that in stack, and then used *that* as memory.
> > >
> > > What's the %y modifier supposed to mean here?
> >
> > It prints a memory address for an indexed operand.
> >
> > If you write just "%0" it prints addresses that are a single register
> > as "0(r3)" instead of "0,r3".  Some instructions do not allow offset
> > form.
> >
> > > addr is in the list of
> > > inputs, so what's wrong with using it as an rvalue?
> >
> > It seems to use *(u8 *)addr as rvalue.  Asm operands are lvalues.  It
> > matters a lot for memory operands.
>
> Hmm...not sure that's specified behavior.  Anyways, I've filed:
> https://bugs.llvm.org/show_bug.cgi?id=42762
> to see if folks more familiar with LLVM's ppc backend have some more thoughts.
>
> I recommend considering reverting commit 6c5875843b87 ("powerpc:
> slightly improve cache helpers") until the issue is resolved in clang,
> otherwise I'll probably just turn off our CI builds of PPC32 for the
> time being.

Started a new thread: https://lkml.org/lkml/2019/7/29/1483
-- 
Thanks,
~Nick Desaulniers
