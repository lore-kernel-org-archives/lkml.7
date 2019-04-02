Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73996C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3062920883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RvtPBpLv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbfDBMrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:47:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38312 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbfDBMrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:47:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so6343271pfo.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 05:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u3PSOHs4we7+LgIG6ZQZir4Fy57VqCCMcbhzYXQWknQ=;
        b=RvtPBpLvPglDtwnPF4yXUeK5oDlzVoAw9Ac/QiLLKSGbikn9e6229p73Q0tOoviq2D
         BavSCer7Dzqe0/C31mrVK/886gbUDYWuPnxHOlht2sOu/e62noERB05hR+v+Bbj+JICn
         Lb7g/8TOjfYKi5cKqi9tDj/4Gjl0w7oFGi+cz1GXwEAzmc5l0cphMO74o+wu5S8JjZik
         7AqeS2RJ0S+0J5+xNSxMiTjPOKYRkB2DaefRCT/WCl4ZMTNyy1aYXf9qwji/GQQh7uA6
         a4SkVWVDmZ28lLA5h47JmaNF3G6jNLy7QP3Ylvcw6DiwtS/xNNeagblhaZ/cgn7jvFfX
         OA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u3PSOHs4we7+LgIG6ZQZir4Fy57VqCCMcbhzYXQWknQ=;
        b=ShlM67LGfjqp5N9CFgaT5mTBdcCdYEsFUeo+zQ8iqOUiaU5eRXDZLZXU2onsQbVvR5
         Qn3OdwcHXKBNLFaMb1SZfnRwWfdVlrfTpFQIP7RXejMufEWaasht0iV8qq7i8AkMCmz6
         wCTGQHP8pmF03o7KP/Df3r6vFw+94fSXkoTsUbwItIxXkL0zY7SwQrzUW15PZP75NGhz
         z88TfABfzSbDW8Cxc7A6h5TLicyn6c87kXbNbUk0lySJOm2/imc7hL/sW9JG/u7qdpHS
         ZPA3Xn9uNVD+PhrOCKkbLZ02COeaGjADHTE7FYzy0k8sloE+m2WbSzQxMjb+tKAtJEVp
         RcTA==
X-Gm-Message-State: APjAAAW6dngLLW3aba95kJgyo/bLG4mKhP4vp/unfdbGYKIXJ0HrqDcd
        yK4nRKTw9FT6jr/p+iZfMSFDhmHwrOJ0Py+YlVNOvA==
X-Google-Smtp-Source: APXvYqwSO12tw5fRix4o6PstoDzeaM5ZQf6IJ2XlmsbVCqK/ZDPoD7HrCoDXID/J7Vmm+PM48eFxdwxASU4WIrz1GI4=
X-Received: by 2002:a65:6496:: with SMTP id e22mr52163844pgv.249.1554209265963;
 Tue, 02 Apr 2019 05:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553093420.git.andreyknvl@google.com> <44ad2d0c55dbad449edac23ae46d151a04102a1d.1553093421.git.andreyknvl@google.com>
 <20190322114357.GC13384@arrakis.emea.arm.com> <CAAeHK+xE-ywfpVHRhBJVGiqOe0+BYW9awUa10ZP4P6Ggc8nxMg@mail.gmail.com>
 <20190328141934.38960af0@gandalf.local.home> <20190329103039.GA44339@arrakis.emea.arm.com>
In-Reply-To: <20190329103039.GA44339@arrakis.emea.arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 2 Apr 2019 14:47:34 +0200
Message-ID: <CAAeHK+xe-zWn8WpCxUxBB2tXL8oiLkshkPi1J3Ly87mACaA4-A@mail.gmail.com>
Subject: Re: [PATCH v13 04/20] mm, arm64: untag user pointers passed to memory syscalls
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 11:30 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> (I trimmed down the cc list a bit since it's always bouncing)
>
> On Thu, Mar 28, 2019 at 02:19:34PM -0400, Steven Rostedt wrote:
> > On Thu, 28 Mar 2019 19:10:07 +0100
> > Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > > > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > > > ---
> > > > >  ipc/shm.c      | 2 ++
> > > > >  mm/madvise.c   | 2 ++
> > > > >  mm/mempolicy.c | 5 +++++
> > > > >  mm/migrate.c   | 1 +
> > > > >  mm/mincore.c   | 2 ++
> > > > >  mm/mlock.c     | 5 +++++
> > > > >  mm/mmap.c      | 7 +++++++
> > > > >  mm/mprotect.c  | 1 +
> > > > >  mm/mremap.c    | 2 ++
> > > > >  mm/msync.c     | 2 ++
> > > > >  10 files changed, 29 insertions(+)
> > > >
> > > > I wonder whether it's better to keep these as wrappers in the arm64
> > > > code.
> > >
> > > I don't think I understand what you propose, could you elaborate?
> >
> > I believe Catalin is saying that instead of placing things like:
> >
> > @@ -1593,6 +1593,7 @@ SYSCALL_DEFINE3(shmat, int, shmid, char __user *, shmaddr, int, shmflg)
> >       unsigned long ret;
> >       long err;
> >
> > +     shmaddr = untagged_addr(shmaddr);
> >
> > To instead have the shmaddr set to the untagged_addr() before calling
> > the system call, and passing the untagged addr to the system call, as
> > that goes through the arm64 architecture specific code first.
>
> Indeed. For example, we already have a SYSCALL_DEFINE6(mmap, ...) in
> arch/arm64/kernel/sys.c, just add the untagging there. We could do
> something similar for the other syscalls. I don't mind doing this in the
> generic code but if it's only needed for arm64, I'd rather keep the
> generic changes to a minimum.

Do I understand correctly, that I'll need to add ksys_ wrappers for
each of the memory syscalls, and then redefine them in
arch/arm64/kernel/sys.c with arm64_ prefix, like it is done for the
personality syscall right now? This will require generic changes as
well.

>
> (I had a hack overriding __SC_CAST to do this automatically for pointer
> arguments but this wouldn't work on mmap() and friends as the argument
> is unsigned long)
>
> --
> Catalin
