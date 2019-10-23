Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993B0CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603C82173B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZDHJdHlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405272AbfJWNU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:20:58 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38817 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405084AbfJWNU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:20:57 -0400
Received: by mail-qk1-f195.google.com with SMTP id p4so19705526qkf.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 06:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YwwNpmL2qofOV8Q5k6r574f7T2+vRZXIkcIV7+Y6rBI=;
        b=ZDHJdHlL5AdijBqcdxZsoO9L4x7ScTRmOv8LUuZQbn7FrCQWwG1H0Wz9V/IwI4EQHQ
         McJUW7C8oblxaGBX6LVHOcvt4JetIFSiSRE8gcTvqfHk6zdL57YSeXrRZw0gWglqy/ww
         CzSVjcUdtIvAMTcyppi/1O9Ir2gJdBK1FS/E1v2NMjLVTl/3nXrOQYLFncWEdVSLceL2
         LaUW7pUJ6Q5CI51RvzHExHmD9Cs76brOPn2XG6cUXnU2fNnGy/oyv70avZBEeqfCr+7y
         kGgUfKkD68Es5/rkogjFcO4C4PoDfNmbyKV8v3ZL3f2ioE6XYtd5NvzgBaH9GLdwziZN
         4Rjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YwwNpmL2qofOV8Q5k6r574f7T2+vRZXIkcIV7+Y6rBI=;
        b=X02qrAG57gLauTCMLony03OZ9u6AygFOcIHN/rTv7TQo6ZHM8DOcXfqq7mKgLxbSIf
         eNoW4nnyUGAYCuB4F3X4mTRqoCO1zeh3Bg0SZ4OXg7r8+c16GSH6qGyE/GwVQgxxM2LF
         SW7YlZrcppB32IQbBAXmtHQWE327oCG1JwZVzIU4IyIpJuhYFVG/lrNckYFcd1C2HSRv
         NBCiaL74TY7otD8KpCnUEma+EGFq/QJOgjW7///kZMz66Q+r5Ygb4vz0MCjAWExv+xAg
         Wp6LDt73nreyffpcqILvkhK7iaLGzfix+FHK7gxcz4S95EHEpgu9ZTgB91UhmmatufyO
         a2cA==
X-Gm-Message-State: APjAAAXvyF3sjAH3nb/4N9758r+3hy7BSGVORAhYHq37Qo+7krcnIRjo
        14zlr4ThQ9/fu1aZ9b998Oxf5avc7UdZenYyNm0E6g==
X-Google-Smtp-Source: APXvYqwm8FLLm/Dz/favs/ArMRNPU0mJU/x4AHqcbIg3zqTnGH6NmjNQEyBE8uKYPGV2+Qnm+JUJIzlbAhW8lIyWEUc=
X-Received: by 2002:a37:4a87:: with SMTP id x129mr8200691qka.43.1571836856063;
 Wed, 23 Oct 2019 06:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191009114809.8643-1-christian.brauner@ubuntu.com>
 <20191021113327.22365-1-christian.brauner@ubuntu.com> <20191023121603.GA16344@andrea.guest.corp.microsoft.com>
 <CACT4Y+Y86HFnQGHyxv+f32tKDJXnRxmL7jQ3tGxVcksvtK3L7Q@mail.gmail.com> <20191023131151.ajgnbcvnec3ouc6y@wittgenstein>
In-Reply-To: <20191023131151.ajgnbcvnec3ouc6y@wittgenstein>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 23 Oct 2019 15:20:44 +0200
Message-ID: <CACT4Y+bud1J5jdCvxjs92s+m9PB3vqsi0MXOJ_nR0-2uy_uUrw@mail.gmail.com>
Subject: Re: [PATCH v6] taskstats: fix data-race
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Will Deacon <will@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, bsingharora@gmail.com,
        Marco Elver <elver@google.com>,
        stable <stable@vger.kernel.org>,
        syzbot <syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 3:11 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Wed, Oct 23, 2019 at 02:39:55PM +0200, Dmitry Vyukov wrote:
> > On Wed, Oct 23, 2019 at 2:16 PM Andrea Parri <parri.andrea@gmail.com> wrote:
> > >
> > > On Mon, Oct 21, 2019 at 01:33:27PM +0200, Christian Brauner wrote:
> > > > When assiging and testing taskstats in taskstats_exit() there's a race
> > > > when writing and reading sig->stats when a thread-group with more than
> > > > one thread exits:
> > > >
> > > > cpu0:
> > > > thread catches fatal signal and whole thread-group gets taken down
> > > >  do_exit()
> > > >  do_group_exit()
> > > >  taskstats_exit()
> > > >  taskstats_tgid_alloc()
> > > > The tasks reads sig->stats without holding sighand lock.
> > > >
> > > > cpu1:
> > > > task calls exit_group()
> > > >  do_exit()
> > > >  do_group_exit()
> > > >  taskstats_exit()
> > > >  taskstats_tgid_alloc()
> > > > The task takes sighand lock and assigns new stats to sig->stats.
> > > >
> > > > The first approach used smp_load_acquire() and smp_store_release().
> > > > However, after having discussed this it seems that the data dependency
> > > > for kmem_cache_alloc() would be fixed by WRITE_ONCE().
> > > > Furthermore, the smp_load_acquire() would only manage to order the stats
> > > > check before the thread_group_empty() check. So it seems just using
> > > > READ_ONCE() and WRITE_ONCE() will do the job and I wanted to bring this
> > > > up for discussion at least.
> > >
> > > Mmh, the RELEASE was intended to order the memory initialization in
> > > kmem_cache_zalloc() with the later ->stats pointer assignment; AFAICT,
> > > there is no data dependency between such memory accesses.
> >
> > I agree. This needs smp_store_release. The latest version that I
> > looked at contained:
> > smp_store_release(&sig->stats, stats_new);
>
> This is what really makes me wonder. Can the compiler really re-order
> the kmem_cache_zalloc() call with the assignment.

Yes.
Not sure about compiler, but hardware definitely can. And generally
one does not care if it's compiler or hardware.

> If that's really the
> case then shouldn't all allocation functions have compiler barriers in
> them? This then seems like a very generic problem.

No.
One puts memory barriers into synchronization primitives.
This equally affects memset's, memcpy's and in fact all normal stores.
Adding a memory barrier to every normal store is not the solution to
this. The memory barrier is done before publication of the memory. And
we already have smp_store_release for this. So if one doesn't publish
objects with a plain store (which breaks all possible rules anyways)
and uses a proper primitive, there is no problem.

> > > Correspondingly, the ACQUIRE was intended to order the ->stats pointer
> > > load with later, _independent dereferences of the same pointer; the
> > > latter are, e.g., in taskstats_exit() (but not thread_group_empty()).
> >
> > How these later loads can be completely independent of the pointer
> > value? They need to obtain the pointer value from somewhere. And this
> > can only be done by loaded it. And if a thread loads a pointer and
> > then dereferences that pointer, that's a data/address dependency and
> > we assume this is now covered by READ_ONCE.
> > Or these later loads of the pointer can also race with the store? If
>
> To clarify, later loads as in taskstats_exit() and thread_group_empty(),
> not the later load in the double-checked locking case.
>
> > so, I think they also need to use READ_ONCE (rather than turn this earlier
> > pointer load into acquire).
>
> Using READ_ONCE() in the alloc, taskstat_exit(), and
> thread_group_empty() case.
>
> Christian
