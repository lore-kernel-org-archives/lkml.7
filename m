Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50209C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 20:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9C2207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 20:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NUpuMbLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfI0Unb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 16:43:31 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:45684 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfI0Unb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 16:43:31 -0400
Received: by mail-pf1-f172.google.com with SMTP id y72so2191587pfb.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 13:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZWso/5VsI7l7vmizuPZXNooRiN6pJrn5CZG207krIcU=;
        b=NUpuMbLclSZiWRBffmG3OLzCOkD2xfh6OpA0fNGZJyijr5He1k5YEB9kr6zCp5A1G3
         CbAk79Ww2gZZFrTRrMBVJCLuPrNaP4+KNEBsEKi2p9FdKIgS2AxzmyPn/3igX517LvnN
         iHdMJui/KJvM4gVx6VfvBOvP4IfhJgRqTEyobW2VcJZ8C0RYItwU4/krRm1BdWRL770z
         gy4GNzHX3hgLCib/PL85e0SiEm4/L8iZD3NbcQ7We02HCz05TUt34VmEhsWCBcjM4Tov
         pcuZJgBB8D7MOVv2WUf0U0VEl98OypzEjAFZbiGqFw5I8ixjORmHkB3pMA/8/eU0qqoh
         HK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZWso/5VsI7l7vmizuPZXNooRiN6pJrn5CZG207krIcU=;
        b=k2P6+jFy99Ojuuah3N4sxm6pFhnqX3DJqMUY4Jc8FFFxzNgkG0heD1NQ+59RidKeiF
         4mzc5cd+IgCEJSGUjehk6E7WV+14o2slorawxDEpYUyP9j4Cvp39ByPfq2Yyd++2CfUb
         sZ/wE1xwhSkHfO+HHiNTu4lHuzUXLvsjkXgCLkPzf8Jc3fBwTpUXvAZtKNbtqws7Ckh6
         8PEovJIj5KQtKUxykofKDLNK5ylV3MZ+yg8thqwpAxSCYzA4rvLbsM1S9RcNPqjOPFHI
         LwiHPFQEpwy/4cdrLHDkSCgXw/OEPnZwWMQVdfZSohe64I5O7tk6tkVPS6yjV4mjzgCj
         r8yw==
X-Gm-Message-State: APjAAAU1Rv2r4DZV0op+S/VpJR42LA7fMXzJzXq/idrj4CyECBqZznyj
        9DZmqRArK9IwQimwp8XG1fDOWiFmx6CuLUfsAz0fvA==
X-Google-Smtp-Source: APXvYqzjd+Dj9oR22MHjl1lXQzd6kve9AfYuffJkedcYpkfEsUhMw9i3CZ1KZ6IgmxCy9iWc+3QIqAP385RhKXV/s6o=
X-Received: by 2002:a62:5fc1:: with SMTP id t184mr6661461pfb.84.1569617009310;
 Fri, 27 Sep 2019 13:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wj85tOp8WjcUp6gwstp4Cg2WT=p209S=fOzpWAgqqQPKg@mail.gmail.com>
 <20190915145905.hd5xkc7uzulqhtzr@willie-the-truck> <25289.1568379639@warthog.procyon.org.uk>
 <28447.1568728295@warthog.procyon.org.uk> <20190917170716.ud457wladfhhjd6h@willie-the-truck>
 <15228.1568821380@warthog.procyon.org.uk> <5385.1568901546@warthog.procyon.org.uk>
 <20190923144931.GC2369@hirez.programming.kicks-ass.net> <20190927095107.GA13098@andrea>
 <20190927124929.GB4643@worktop.programming.kicks-ass.net>
In-Reply-To: <20190927124929.GB4643@worktop.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 27 Sep 2019 13:43:18 -0700
Message-ID: <CAKwvOd=pZYiozmGv+DVpzJ1u9_0k4CXb3M1EAcu22DQF+bW0fA@mail.gmail.com>
Subject: Re: Do we need to correct barriering in circular-buffers.rst?
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        jose.marchesi@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 5:49 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Sep 27, 2019 at 11:51:07AM +0200, Andrea Parri wrote:
>
> > For the record, the LKMM doesn't currently model "order" derived from
> > control dependencies to a _plain_ access (even if the plain access is
> > a write): in particular, the following is racy (as far as the current
> > LKMM is concerned):
> >
> > C rb
> >
> > { }
> >
> > P0(int *tail, int *data, int *head)
> > {
> >       if (READ_ONCE(*tail)) {
> >               *data = 1;
> >               smp_wmb();
> >               WRITE_ONCE(*head, 1);
> >       }
> > }
> >
> > P1(int *tail, int *data, int *head)
> > {
> >       int r0;
> >       int r1;
> >
> >       r0 = READ_ONCE(*head);
> >       smp_rmb();
> >       r1 = *data;
> >       smp_mb();
> >       WRITE_ONCE(*tail, 1);
> > }
> >
> > Replacing the plain "*data = 1" with "WRITE_ONCE(*data, 1)" (or doing
> > s/READ_ONCE(*tail)/smp_load_acquire(tail)) suffices to avoid the race.
> > Maybe I'm short of imagination this morning...  but I can't currently
> > see how the compiler could "break" the above scenario.
>
> The compiler; if sufficiently smart; is 'allowed' to change P0 into
> something terrible like:
>
>         *data = 1;
>         if (*tail) {
>                 smp_wmb();
>                 *head = 1;
>         } else
>                 *data = 0;

I don't think so.  This snippet has different side effects than P0.
P0 never assigned *data to zero, this snippet does.  P0 *may* assign
*data to 1.  This snippet will unconditionally assign to *data,
conditionally 1 or 0.  I think the REVERSE transform (from your
snippet to P0) would actually be legal, but IANALL (I am not a
language lawyer; haven't yet passed the BAR).

>
>
> (assuming it knows *data was 0 from a prior store or something)

Oh, in that case I'm less sure (I still don't think so, but I would
love to be proven wrong, preferably with a godbolt link).  I think the
best would be to share a godbolt.org link to a case that's clearly
broken, or cite the relevant part of the ISO C standard (which itself
leaves room for interpretation), otherwise the discussion is too
hypothetical.  Those two things are single-handedly the best way to
communicate with compiler folks.

>
> Using WRITE_ONCE() defeats this because volatile indicates external
> visibility.

Could data be declared as a pointer to volatile qualified int?

>
> > I also didn't spend much time thinking about it.  memory-barriers.txt
> > has a section "CONTROL DEPENDENCIES" dedicated to "alerting developers
> > using control dependencies for ordering".  That's quite a long section
> > (and probably still incomplete); the last paragraph summarizes:  ;-)
>
> Barring LTO the above works for perf because of inter-translation-unit
> function calls, which imply a compiler barrier.
>
> Now, when the compiler inlines, it looses that sync point (and thereby
> subtlely changes semantics from the non-inline variant). I suspect LTO
> does the same and can cause subtle breakage through this transformation.

Do you have a bug report or godbolt link for the above?  I trust that
you're familiar enough with the issue to be able to quickly reproduce
it?  These descriptions of problems are difficult for me to picture in
code or generated code, and when I try to read through
memory-barriers.txt my eyes start to glaze over (then something else
catches fire and I have to go put that out).  Having a concise test
case I think would better illustrate potential issues with LTO that
we'd then be able to focus on trying to fix/support.

We definitely have heavy hitting language lawyers and our LTO folks
are super sharp; I just don't have the necessary compiler experience
just yet to be as helpful in these discussions as we need but I'm
happy to bring them cases that don't work for the kernel and drive
their resolution.

>
> > (*) Compilers do not understand control dependencies.  It is therefore
> >     your job to ensure that they do not break your code.
>
> It is one the list of things I want to talk about when I finally get
> relevant GCC and LLVM people in the same room ;-)
>
> Ideally the compiler can be taught to recognise conditionals dependent
> on 'volatile' loads and disallow problematic transformations around
> them.
>
> I've added Nick (clang) and Jose (GCC) on Cc, hopefully they can help
> find the right people for us.
-- 
Thanks,
~Nick Desaulniers
