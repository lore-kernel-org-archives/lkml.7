Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA75C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC172253D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYuEXW5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732547AbfGWUWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 16:22:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37794 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbfGWUWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 16:22:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id f17so39575620wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 13:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rCsfgRk4Gb3dHRK/7OJQSsVifCQtFvi6RkLR5FcNfMA=;
        b=BYuEXW5qEIEncGakWB5ey5U6QXpFCobmnswdZKuPlLJQYWX197mjl4y+bnWB8WvmPH
         n9w/PIDZQw5RVXtWHk0uImOl+jCC60vI/uuvNpylCIOw9EtupLkqVVrDtphr3Fi9AWN3
         toPTUIri1yNdvOFxHxyD86JKLUJiT4XSRmvRzJ+BHRlMwrTe1mOwu4ZFMd/NA7/QVg6Y
         HLz3EOCSYGUVb3aS3rGwsLG5lO7sdxVkOB3P1rh5/h1ifKMu4UHdC87dsVKjQCH6j+BE
         xZ8QE5OprPV/8serwDjBeAOMmEFfrFHiXwbBzjgxPIrSb0VGQ+fVNA29XtXN4DzXP5al
         fIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rCsfgRk4Gb3dHRK/7OJQSsVifCQtFvi6RkLR5FcNfMA=;
        b=WLRdHZHi8uny2mnShbNEQ9Pf2WE60aRHUqTF7v3GRBsHwQgFJ1gIGHza+CtlzLkp8q
         ypZazGJZUcO+1XX3A7XMnyRdhI1UKhDnwdyDj88vRiyxdBwNSo2SFpeK6CejKS7QLOYx
         oPAdKo6Z54e1tI9dQZYviHXMEK6TqhyQp7/SRu31aprvvnai6uzZHyly2v7US/liImlV
         tVcsarZgKnfEhLMQQjtH0MA3WWLbC7aqwQL/C00XnQD7S2IVa9sqS9UY2qta0SpwU7CN
         aluNzsnmw53Ob/PgDAojGExB6U0dUyYgEjnFo+QTQxH5QDM1gTCkb2wWyMynLMrXtvvW
         GPbw==
X-Gm-Message-State: APjAAAUWpM/pL+BxicaR2cq/f6fdKqb0obVoSXelxwjkpCP1YFw4wFDb
        /9UK6aEUtkbmymdc4ijKv/b1AwUmEOw=
X-Google-Smtp-Source: APXvYqzTrdQFInj4OnnsUooZFNatTy1ah08LjCv1PGwgPPHfdZYkN7Y/Kd7t/jOijZNHAr7BWfQg5g==
X-Received: by 2002:a1c:a1c1:: with SMTP id k184mr72604693wme.81.1563913322259;
        Tue, 23 Jul 2019 13:22:02 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id u2sm38916407wmc.3.2019.07.23.13.22.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 13:22:01 -0700 (PDT)
Date:   Tue, 23 Jul 2019 13:21:59 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] [v2] waitqueue: shut up clang -Wuninitialized warnings
Message-ID: <20190723202159.GA79273@archlinux-threadripper>
References: <20190719113638.4189771-1-arnd@arndb.de>
 <20190723105046.GD3402@hirez.programming.kicks-ass.net>
 <CAK8P3a3_sRmHVsEh=+83zR_Q3+Bh9fd+-iiCxt4PU4gkx0HZ7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3_sRmHVsEh=+83zR_Q3+Bh9fd+-iiCxt4PU4gkx0HZ7Q@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 01:03:05PM +0200, Arnd Bergmann wrote:
> On Tue, Jul 23, 2019 at 12:50 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > On Fri, Jul 19, 2019 at 01:36:00PM +0200, Arnd Bergmann wrote:
> > > --- a/include/linux/wait.h
> > > +++ b/include/linux/wait.h
> > > @@ -70,8 +70,17 @@ extern void __init_waitqueue_head(struct wait_queue_head *wq_head, const char *n
> > >  #ifdef CONFIG_LOCKDEP
> > >  # define __WAIT_QUEUE_HEAD_INIT_ONSTACK(name) \
> > >       ({ init_waitqueue_head(&name); name; })
> > > -# define DECLARE_WAIT_QUEUE_HEAD_ONSTACK(name) \
> > > +# if defined(__clang__) && __clang_major__ <= 9
> > > +/* work around https://bugs.llvm.org/show_bug.cgi?id=42604 */
> > > +#  define DECLARE_WAIT_QUEUE_HEAD_ONSTACK(name)                                      \
> > > +     _Pragma("clang diagnostic push")                                        \
> > > +     _Pragma("clang diagnostic ignored \"-Wuninitialized\"")                 \
> > > +     struct wait_queue_head name = __WAIT_QUEUE_HEAD_INIT_ONSTACK(name)      \
> > > +     _Pragma("clang diagnostic pop")
> > > +# else
> > > +#  define DECLARE_WAIT_QUEUE_HEAD_ONSTACK(name) \
> > >       struct wait_queue_head name = __WAIT_QUEUE_HEAD_INIT_ONSTACK(name)
> > > +# endif
> >
> > While this is indeed much better than before; do we really want to do
> > this? That is, since clang-9 release will not need this, we're basically
> > doing the above for pre-release compilers only.
> 
> Kernelci currently builds arch/arm and arch/arm64 kernels with clang-8,
> and probably won't change to clang-9 until after that is released,
> presumably in September.
> 
> Anyone doing x86 builds would use a clang-9 snapshot today
> because of the asm-goto support, but so far the fix has not
> been merged there either. I think the chances of it getting
> fixed before the release are fairly good, but I don't know how
> long it will actually take.
> 
>        Arnd

Furthermore, while x86 will only be supported by clang-9 and up, there
are other architectures/configurations that work with earlier versions
that will never see that fix. There are a few people that still use
clang-7 for example.

In an ideal world, everyone should be using the latest version of clang
because of all of the fixes and improvements that are going into that
latest version but the same can be said of any piece of software. I am
not sure that it is fair to force someone to upgrade when it works for
them. Not everyone runs Ubuntu/Debian to get access to apt.llvm.org
builds or wants to add random repositories to their list or wants to
build clang from source.

I suppose it comes down to policy: if we don't want to support versions
of LLVM before 9.x then we should just break the build when it is
detected but Nick has spoken out against that and I think that he has a
fair point.

https://lore.kernel.org/lkml/CAKwvOdnzrMOCo4RRsfcR=K5ELWU8obgMqtOGZnx_avLrArjpRQ@mail.gmail.com/

Cheers,
Nathan
