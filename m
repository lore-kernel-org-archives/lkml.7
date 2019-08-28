Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4ECDC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A90622DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QVkB+vGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfH1WNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 18:13:35 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:38446 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfH1WNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 18:13:35 -0400
Received: by mail-pl1-f175.google.com with SMTP id w11so596841plp.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 15:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L46ONnOW0M6iW1Vp+WUrD6Jyzw4pGNakADqoU3eqTEQ=;
        b=QVkB+vGs7ZPqhNeLypaISg2FgoUZvTzDsGkDzM3Q4dxt1d+lQS0icwsdmx/+L2tzvT
         JcpIWn2yI3R2eiOg+z/pm0uPY5r4L+tW3gsgl1oEYb6Lov+xNdnq16KAr8UBcoSt6kJq
         z/PLmYn+FL9Bi++DchRfTJm7vpCdrhsPjPSr2d4hKadR0P/vuO3BamuUMiF3ZeD0C8Eq
         4x+AqadcjtLVJlGP1YmGCyMnIZxZKnNssBLeCNZ6oCUh1SYEX7vCnMxSEGwQ5tCa2GI9
         Pxvb4FfkeO0n3ozeA2hDt5kEzkKoAAi/0/uHIEkmNPcu97BgsfY55f64LXWQ64Xe+TSj
         NoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L46ONnOW0M6iW1Vp+WUrD6Jyzw4pGNakADqoU3eqTEQ=;
        b=bvsGmdIQ3yOXaAASJ8uGXc03ApuN5xCHZnXC/5KbSCiADtwzov22jJb2iV3T6MiCfy
         HGCZEGKzZVmqLeetND4fKCQltEzxtispU4efECOl1EJUCGUbkS8eDsiD59L5a5BkErYA
         986qw63m06AklowKXEvZlfWwTP8NH+LbwmtbUyiQcQN14MzjN6uerMPnUQhNIwgxYPmS
         CyGk4NC3WepYFQ8c2fp/nNm0l1Mkt5bsLo8+70Hq6lNEJskzz4NkZ4XyLEV3172jbWXi
         f0n65B9jWwjhoK7+t7+T+hKwd0NUf/I4P7rwb/lwegh6jj/Sh4mHw2URi7170mZAalcZ
         thvg==
X-Gm-Message-State: APjAAAUMBXvFhNX8VlGver1QbN9D0n6ReTSVA6gjbyNCw0xYlJpf+LZs
        Sc3D+++IiAEF/0hoV+VeNWY2pjy2e3GSB2W+0vYSFg==
X-Google-Smtp-Source: APXvYqyjEXG8XXDQXpYhl8xEUXuWMAM6B3z1FvFP/Sf98kYWklfI9KWZ8mpEhqiMU2jh89GBpt1aV3aYfFvdaeddt0E=
X-Received: by 2002:a17:902:a9c3:: with SMTP id b3mr6518760plr.179.1567030413776;
 Wed, 28 Aug 2019 15:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3G=GCpLtNztuoLR4BuugAB=zpa_Jrz5BSft6Yj-nok1g@mail.gmail.com>
 <20190827145102.p7lmkpytf3mngxbj@treble> <CAHFW8PRsmmCR6TWoXpQ9gyTA7azX9YOerPErCMggcQX-=fAqng@mail.gmail.com>
 <CAK8P3a2TeaMc_tWzzjuqO-eQjZwJdpbR1yH8yzSQbbVKdWCwSg@mail.gmail.com> <20190827192255.wbyn732llzckmqmq@treble>
In-Reply-To: <20190827192255.wbyn732llzckmqmq@treble>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 28 Aug 2019 15:13:21 -0700
Message-ID: <CAKwvOdkyvZf-oM6aXuCD6Aa4zDqZU-fKu5uUF6E05V6rWnxpKA@mail.gmail.com>
Subject: Re: objtool warning "uses BP as a scratch register" with clang-9
To:     Josh Poimboeuf <jpoimboe@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Ilie Halip <ilie.halip@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Eli Friedman <efriedma@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 12:22 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Tue, Aug 27, 2019 at 09:00:52PM +0200, Arnd Bergmann wrote:
> > On Tue, Aug 27, 2019 at 5:00 PM Ilie Halip <ilie.halip@gmail.com> wrote:
> > >
> > > > > $ clang-9 -c  crc32.i  -O2   ; objtool check  crc32.o
> > > > > crc32.o: warning: objtool: fn1 uses BP as a scratch register
> > >
> > > Yes, I see it too. https://godbolt.org/z/N56HW1
> > >
> > > > Do you still see this warning with -fno-omit-frame-pointer (assuming
> > > > clang has that option)?
> > >
> > > Using this makes the warning go away. Running objtool with --no-fp
> > > also gets rid of it.
> >
> > I still see the warning after adding back the -fno-omit-frame-pointer
> > in my reduced test case:
> >
> > $ clang-9 -c  crc32.i -Werror -Wno-address-of-packed-member -Wall
> > -Wno-pointer-sign -Wno-unused-value -Wno-constant-logical-operand -O2
> > -Wno-unused -fno-omit-frame-pointer
> > $ objtool check  crc32.o
> > crc32.o: warning: objtool: fn1 uses BP as a scratch register
>
> This warning most likely means that clang is clobbering RBP in leaf
> functions.  With -fno-omit-frame-pointer, leaf functions don't need to
> set up the frame pointer, but they at least need to leave RBP untouched,
> so that an interrupts/exceptions can unwind through the function.

It sounds like clang has `-mno-omit-leaf-frame-pointer` (via
https://bugs.llvm.org/show_bug.cgi?id=43128#c6).  Arnd, can you give
that a shot?
-- 
Thanks,
~Nick Desaulniers
