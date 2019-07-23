Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBA7C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8DB22CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iuLvEGih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391932AbfGWUyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 16:54:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39176 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388867AbfGWUyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 16:54:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so20002032pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 13:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DKCUv/Cx+CQnHVa5KxeusznvKIlpXN7+WLMqjunL/oE=;
        b=iuLvEGihchhFbxRFRaHaMyHH86x4jCGBJtZAgUQPydbKo2RL8PhAFhIiztBHniu0qF
         KVPSVYAByf3547zKlV4OnDwBYPsjvB6Iy4b7gVWwvl8OsBeazuZIYwRlFt04fTVj6ZJ0
         Xa/nT6RyvMPmJZ6K7lZL3mpAacf8w6Tqgg2o3AGhAYWvKKElOcSke0gJ+s6tS8dPSEP8
         4XtBgp1W4Mj9A/AbbNr1DqWblFi68ORF8Wb33yYwS0Z+ftszlW4r/CaI29OIB4ekmKvu
         9dYiZIJEqjVaDZupuh+I4M/+2brSkx0AXsWcnD5zT5PBGy6xAFlHYmnvKd+TL9whGVLF
         W1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DKCUv/Cx+CQnHVa5KxeusznvKIlpXN7+WLMqjunL/oE=;
        b=E9lfvlVGR2tJ5ZaEpYl4Sxn9+F4PQgPU+vdlyEFcen3yET4glErUj0ERa+ge+kCC4q
         PXSP+E9eW9gwhNLvIGAz93sf+gNuP1v0OxXSp2LConSaAoe33pBRUNr/5Z2TcJ98H+4o
         1STnP5Kubzqhb6FCGujw9wpT2+An9sJah9far1F0G8Ers7rr35XDBmtDnrJ7GEdwqKdr
         bXOX+jXul3MfjhWlsqkBmBD9S3xiqGifyH+d+9MNWtfbWhjJI9jPr5c8b/udFeCTDs8i
         X6n29Sdf83NDtqLMdMfPN9WSChcEAeccVNQQkGKupdCXykx9ycDwiqZ3UP3UBZDyPQ/6
         4SVA==
X-Gm-Message-State: APjAAAX9a6priU/V5QVtr/MqOtSBGZejuvX0rRJS1Yk2WZPSvex0XFOE
        GluiPyXyLn/J8UdtcqMV+XYaz2JXtSMC1G84C4/gBA==
X-Google-Smtp-Source: APXvYqwxNKsPwdXUi1DRq4IcjAwd9Xm749JVTLGAUTmK1WK84E4NuTkw34QIiAt2a6OQ85mMCcw9GLIdEH7StB/ArdU=
X-Received: by 2002:a65:5687:: with SMTP id v7mr79613610pgs.263.1563915254944;
 Tue, 23 Jul 2019 13:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190719113638.4189771-1-arnd@arndb.de> <20190723105046.GD3402@hirez.programming.kicks-ass.net>
 <CAK8P3a3_sRmHVsEh=+83zR_Q3+Bh9fd+-iiCxt4PU4gkx0HZ7Q@mail.gmail.com> <20190723202159.GA79273@archlinux-threadripper>
In-Reply-To: <20190723202159.GA79273@archlinux-threadripper>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 23 Jul 2019 13:54:03 -0700
Message-ID: <CAKwvOdnbDFkDhCz3VMM_A8D7VZQH5FubJpS0OTHBJJdS-WKPww@mail.gmail.com>
Subject: Re: [PATCH] [v2] waitqueue: shut up clang -Wuninitialized warnings
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 1:22 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Tue, Jul 23, 2019 at 01:03:05PM +0200, Arnd Bergmann wrote:
> > On Tue, Jul 23, 2019 at 12:50 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Fri, Jul 19, 2019 at 01:36:00PM +0200, Arnd Bergmann wrote:
> > > > --- a/include/linux/wait.h
> > > > +++ b/include/linux/wait.h
> > > > @@ -70,8 +70,17 @@ extern void __init_waitqueue_head(struct wait_queue_head *wq_head, const char *n
> > > >  #ifdef CONFIG_LOCKDEP
> > > >  # define __WAIT_QUEUE_HEAD_INIT_ONSTACK(name) \
> > > >       ({ init_waitqueue_head(&name); name; })
> > > > -# define DECLARE_WAIT_QUEUE_HEAD_ONSTACK(name) \
> > > > +# if defined(__clang__) && __clang_major__ <= 9
> > > > +/* work around https://bugs.llvm.org/show_bug.cgi?id=42604 */
> > > > +#  define DECLARE_WAIT_QUEUE_HEAD_ONSTACK(name)                                      \
> > > > +     _Pragma("clang diagnostic push")                                        \
> > > > +     _Pragma("clang diagnostic ignored \"-Wuninitialized\"")                 \
> > > > +     struct wait_queue_head name = __WAIT_QUEUE_HEAD_INIT_ONSTACK(name)      \
> > > > +     _Pragma("clang diagnostic pop")
> > > > +# else
> > > > +#  define DECLARE_WAIT_QUEUE_HEAD_ONSTACK(name) \
> > > >       struct wait_queue_head name = __WAIT_QUEUE_HEAD_INIT_ONSTACK(name)
> > > > +# endif
> > >
> > > While this is indeed much better than before; do we really want to do
> > > this? That is, since clang-9 release will not need this, we're basically
> > > doing the above for pre-release compilers only.
> >
> > Kernelci currently builds arch/arm and arch/arm64 kernels with clang-8,
> > and probably won't change to clang-9 until after that is released,
> > presumably in September.
> >
> > Anyone doing x86 builds would use a clang-9 snapshot today
> > because of the asm-goto support, but so far the fix has not
> > been merged there either. I think the chances of it getting
> > fixed before the release are fairly good, but I don't know how
> > long it will actually take.
> >
> >        Arnd
>
> Furthermore, while x86 will only be supported by clang-9 and up, there
> are other architectures/configurations that work with earlier versions
> that will never see that fix. There are a few people that still use
> clang-7 for example.
>
> In an ideal world, everyone should be using the latest version of clang
> because of all of the fixes and improvements that are going into that
> latest version but the same can be said of any piece of software. I am
> not sure that it is fair to force someone to upgrade when it works for
> them. Not everyone runs Ubuntu/Debian to get access to apt.llvm.org
> builds or wants to add random repositories to their list or wants to
> build clang from source.
>
> I suppose it comes down to policy: if we don't want to support versions
> of LLVM before 9.x then we should just break the build when it is
> detected but Nick has spoken out against that and I think that he has a
> fair point.
>
> https://lore.kernel.org/lkml/CAKwvOdnzrMOCo4RRsfcR=K5ELWU8obgMqtOGZnx_avLrArjpRQ@mail.gmail.com/

Note that pre-clang-9 can be used for LTS x86_64; I don't think
CONFIG_JUMP_LABEL was made mandatory for x86 until 4.20 release, IIRC.
There's only a small window of non LTS kernels and only for x86 where
clang-9+ is really necessary.

Thanks,
~Nick Desaulniers
