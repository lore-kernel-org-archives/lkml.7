Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06575C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A4D218D4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389135AbfGWLDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 07:03:23 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45559 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbfGWLDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:03:23 -0400
Received: by mail-qt1-f194.google.com with SMTP id x22so36515267qtp.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 04:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5gRVq4mioQ1Lvj1oyc3VAOJ7VbnTpBvpRXYz+4yO8Nc=;
        b=I8SwtphlJZxFmjXL7x8EqC+XIeUVx80ygx1bG9h3PjWtMpApZQTFQVJJMC13zD5JTy
         ZazinW7tU+9nMTCVaNMlVKP0zSbdBp7zpT3zfXxaJcB1Egh5tLwuKwngevEKcm/qvBvK
         pNzutLJ9777kUJXkSkOmgoV1up0u4TPthGqd2dRG0Q06ZiRTSBhjANhcKw+1sdVEuAfd
         MzhYR9sJt2kU1BY9C7f2pQxlip3D++CAWnEOT9qwZlNNhQ0m1BlxzLC4g066m+a3aF2A
         Y1raoJhIzDH6WRbV8KF1/7iy63yXibNjdNhnpXOACwyIc6OKaOK25Tl2MaysWM7zFTf1
         CmuQ==
X-Gm-Message-State: APjAAAVjOxbku+Ckt8Woc3W+I/9LTSULurLJGrWZDg5Pu+AT4/8KyPag
        S5JahKKGj2wsM+tS5YWnRMne10PvHd/9rP5aZUc=
X-Google-Smtp-Source: APXvYqymwmOaskE8rbh7ovV9rgwtK6VxQ1bYhj3/rCq07wk9U9KOYskMFb43QKYAif1XY/b5+WcMEz8efuseBdkPQKI=
X-Received: by 2002:a0c:dd86:: with SMTP id v6mr54513824qvk.176.1563879801936;
 Tue, 23 Jul 2019 04:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190719113638.4189771-1-arnd@arndb.de> <20190723105046.GD3402@hirez.programming.kicks-ass.net>
In-Reply-To: <20190723105046.GD3402@hirez.programming.kicks-ass.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 23 Jul 2019 13:03:05 +0200
Message-ID: <CAK8P3a3_sRmHVsEh=+83zR_Q3+Bh9fd+-iiCxt4PU4gkx0HZ7Q@mail.gmail.com>
Subject: Re: [PATCH] [v2] waitqueue: shut up clang -Wuninitialized warnings
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 12:50 PM Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Jul 19, 2019 at 01:36:00PM +0200, Arnd Bergmann wrote:
> > --- a/include/linux/wait.h
> > +++ b/include/linux/wait.h
> > @@ -70,8 +70,17 @@ extern void __init_waitqueue_head(struct wait_queue_head *wq_head, const char *n
> >  #ifdef CONFIG_LOCKDEP
> >  # define __WAIT_QUEUE_HEAD_INIT_ONSTACK(name) \
> >       ({ init_waitqueue_head(&name); name; })
> > -# define DECLARE_WAIT_QUEUE_HEAD_ONSTACK(name) \
> > +# if defined(__clang__) && __clang_major__ <= 9
> > +/* work around https://bugs.llvm.org/show_bug.cgi?id=42604 */
> > +#  define DECLARE_WAIT_QUEUE_HEAD_ONSTACK(name)                                      \
> > +     _Pragma("clang diagnostic push")                                        \
> > +     _Pragma("clang diagnostic ignored \"-Wuninitialized\"")                 \
> > +     struct wait_queue_head name = __WAIT_QUEUE_HEAD_INIT_ONSTACK(name)      \
> > +     _Pragma("clang diagnostic pop")
> > +# else
> > +#  define DECLARE_WAIT_QUEUE_HEAD_ONSTACK(name) \
> >       struct wait_queue_head name = __WAIT_QUEUE_HEAD_INIT_ONSTACK(name)
> > +# endif
>
> While this is indeed much better than before; do we really want to do
> this? That is, since clang-9 release will not need this, we're basically
> doing the above for pre-release compilers only.

Kernelci currently builds arch/arm and arch/arm64 kernels with clang-8,
and probably won't change to clang-9 until after that is released,
presumably in September.

Anyone doing x86 builds would use a clang-9 snapshot today
because of the asm-goto support, but so far the fix has not
been merged there either. I think the chances of it getting
fixed before the release are fairly good, but I don't know how
long it will actually take.

       Arnd
