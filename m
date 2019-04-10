Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C57C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0C52082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfDJTIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:08:14 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44606 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfDJTIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:08:13 -0400
Received: by mail-qk1-f193.google.com with SMTP id y5so1915536qkc.11;
        Wed, 10 Apr 2019 12:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qnbLwH6iGLNRvl8vt0nxZoX+YWDkW7NPpWgoHprpoZE=;
        b=nbg6cD295rAqKq3caEgXuNBtl3cjzOeVWQ5eX8azWIkPPa3Ojl7WZktP80FPqVNU9I
         z3Ik1OL2aIHajgy39QTxYrqBO5WVVN1tp6HvtQrSi9vlxMjZX+K+FUlXJKy66Zr7kaa9
         8zVJib7i43KZiboVZuuVnykaljnx+QEMdbjwUpX9gcriDtoIBlCrniNz0vWDUk4WYi6n
         Ff9j4fgtifXKp9Iessk4chPG8ChMy/oBtIxXtm6acvkzn0eB+Uy/HyGrUaWllESueBRO
         M88/MW2v/DVI0G8RcPhCujSSUuZBdRTWihCflgVgJmRA0XUr1IuLJTRnl9i+OqNfqGFd
         YQXw==
X-Gm-Message-State: APjAAAWFEZrOu/aDjP2y7hCpuWrQ2Phk2TYihHNzJgJyu1CxckpRf+rc
        Nc8nSJ6zAumJ6HpxU5Gl3jliHFDOfoL8KuFf2tX6DGz2
X-Google-Smtp-Source: APXvYqwiQi6U1diI4xJ8WJoABWo9ZNP0w49+tGL0zMWpy1t6XpPvSC+4i9QBF2GxE4f18i7I+UEs0xiYdTzjEcsfiag=
X-Received: by 2002:a05:620a:148d:: with SMTP id w13mr36134612qkj.6.1554923292709;
 Wed, 10 Apr 2019 12:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190408212648.2407234-1-arnd@arndb.de> <20190408212648.2407234-10-arnd@arndb.de>
 <20190410180357.3290d24f@mschwideX1> <20190410121421.1414e179@gandalf.local.home>
In-Reply-To: <20190410121421.1414e179@gandalf.local.home>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 10 Apr 2019 21:07:56 +0200
Message-ID: <CAK8P3a2n+nEcaNrATQVO8NSGzfrMP5n+SrvjpTYcH4ikCN5LGg@mail.gmail.com>
Subject: Re: [PATCH 10/12] s390: avoid __builtin_return_address(n) on clang
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 6:14 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 10 Apr 2019 18:03:57 +0200 Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
>
> > > --- a/arch/s390/include/asm/ftrace.h
> > > +++ b/arch/s390/include/asm/ftrace.h
> > > @@ -13,7 +13,12 @@
> > >
> > >  #ifndef __ASSEMBLY__
> > >
> > > +#ifdef CONFIG_CC_IS_CLANG
> > > +/* https://bugs.llvm.org/show_bug.cgi?id=41424 */
> > > +#define ftrace_return_address(n) __builtin_return_address(0)
> > > +#else
> > >  #define ftrace_return_address(n) __builtin_return_address(n)
> > > +#endif
> > >
> > >  void _mcount(void);
> > >  void ftrace_caller(void);
> >
> > I can say I like this one. If the compiler can not do __builtin_return_address(n)
> > it feels wrong to just use __builtin_return_address(0).
>
> I agree. The proper return value is 0UL, see include/linux/ftrace.h
>
> /* Archs may use other ways for ADDR1 and beyond */
> #ifndef ftrace_return_address
> # ifdef CONFIG_FRAME_POINTER
> #  define ftrace_return_address(n) __builtin_return_address(n)
> # else
> #  define ftrace_return_address(n) 0UL
> # endif
> #endif
>
> This is why we treat zero differently:
>
> #define CALLER_ADDR0 ((unsigned long)ftrace_return_address0)
> #define CALLER_ADDR1 ((unsigned long)ftrace_return_address(1))
> #define CALLER_ADDR2 ((unsigned long)ftrace_return_address(2))
> #define CALLER_ADDR3 ((unsigned long)ftrace_return_address(3))
> #define CALLER_ADDR4 ((unsigned long)ftrace_return_address(4))
> #define CALLER_ADDR5 ((unsigned long)ftrace_return_address(5))
> #define CALLER_ADDR6 ((unsigned long)ftrace_return_address(6))

Right, got it.

Martin, do you want me to send a replacement patch, or can you
commit the patch with

#ifdef CONFIG_CC_IS_CLANG
/* https://bugs.llvm.org/show_bug.cgi?id=41424 */
#define ftrace_return_address(n) 0UL
#else
#define ftrace_return_address(n) __builtin_return_address(n)
#endif

instead?

    Arnd
