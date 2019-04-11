Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFD7C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287BB20693
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SoNczOUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfDKQk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:40:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33250 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfDKQkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:40:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id h5so3732977pfo.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 09:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kRgyn84oa29XmD7BiIgkjrSoRGcUByl/xukvkl6TYAI=;
        b=SoNczOUvZP35dy1JqqbI48ANljHHieaupBksGGPCN9782NN4FNvPZAMOeymTzYuYJl
         KiHd8ACn2sggNQkz4cP9Y0UlLatijbbSrAMLoUQOyy7ZC740Yt1HM9hRU7VK+riBtyWt
         SpCvuvoxNhHY6NYST5pv7zkv5F6hTtUq5hBXFpQgntYKCUYQ1oGyMotbJ50fPfaHyJp9
         4guhGuIJTEMB6yJ9EnbQqZmUChheWvHCl+MSGrHIRNeXz3E65krd7ZXz0Jx3mawxlStn
         iLNK8lGgq1HcHDIXEwJ65fH//h8oODA1f+R97yN1b91gq/KkfVLVEa0rOgeJHpJA4l8O
         mwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kRgyn84oa29XmD7BiIgkjrSoRGcUByl/xukvkl6TYAI=;
        b=RnZMy7cJpNd4m/xFBXgbLO6YIsVLWuNHvTYUoDuqMaqFKK4D311qkyJZXEhlvm4JV3
         3A9gkUJ9mc58ZntwWoGDt7DW+6mnZCmqYmN0gj2tK1vkBmTvOCt3nji7yLAET9K0lo0x
         mqRf741QZVv2sulGRAxg0/Io84lk9uK4OnfjXYaeoZsJXNbERLaN/Q4ZloBsBdE0HtTv
         ZSMjQHHH/tzl/KJdBrWHrQDAxnXFYIvjnYNQ/wLTsVr++ypi1/EX4Re8NmAdcjeFE7YC
         qsul8yRIqpHmcLjDrh23x+G2NSVCPi/7npM1v50h4+IknVsNFclQq30M8XYQXf1pQcEO
         5Y7A==
X-Gm-Message-State: APjAAAVVzmHbr8+EpodBAq9LATy4abYhvnsXh58U7Yi14uMhAWR0o4HC
        CDfz9mUAva/wODcr0/rBsqxXKR070pn3SX3T6szS5w==
X-Google-Smtp-Source: APXvYqwealWxNqfe0UwP6cRYXZUxVOaGNLqMHlBL7SnCGa5or89aJ7/sNi4RivH+ohBpurt1TGx6k8oqHitkrhMhtoM=
X-Received: by 2002:a63:cf0d:: with SMTP id j13mr47949382pgg.34.1555000824096;
 Thu, 11 Apr 2019 09:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553093420.git.andreyknvl@google.com> <44ad2d0c55dbad449edac23ae46d151a04102a1d.1553093421.git.andreyknvl@google.com>
 <20190322114357.GC13384@arrakis.emea.arm.com> <CAAeHK+xE-ywfpVHRhBJVGiqOe0+BYW9awUa10ZP4P6Ggc8nxMg@mail.gmail.com>
 <20190328141934.38960af0@gandalf.local.home> <20190329103039.GA44339@arrakis.emea.arm.com>
 <CAAeHK+xe-zWn8WpCxUxBB2tXL8oiLkshkPi1J3Ly87mACaA4-A@mail.gmail.com>
In-Reply-To: <CAAeHK+xe-zWn8WpCxUxBB2tXL8oiLkshkPi1J3Ly87mACaA4-A@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 11 Apr 2019 18:40:12 +0200
Message-ID: <CAAeHK+zzMukPL3SXJOqZkCfdT4UaVi=7sxrRfuktZt4DodgO7g@mail.gmail.com>
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

On Tue, Apr 2, 2019 at 2:47 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Fri, Mar 29, 2019 at 11:30 AM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> >
> > (I trimmed down the cc list a bit since it's always bouncing)
> >
> > On Thu, Mar 28, 2019 at 02:19:34PM -0400, Steven Rostedt wrote:
> > > On Thu, 28 Mar 2019 19:10:07 +0100
> > > Andrey Konovalov <andreyknvl@google.com> wrote:
> > >
> > > > > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > > > > ---
> > > > > >  ipc/shm.c      | 2 ++
> > > > > >  mm/madvise.c   | 2 ++
> > > > > >  mm/mempolicy.c | 5 +++++
> > > > > >  mm/migrate.c   | 1 +
> > > > > >  mm/mincore.c   | 2 ++
> > > > > >  mm/mlock.c     | 5 +++++
> > > > > >  mm/mmap.c      | 7 +++++++
> > > > > >  mm/mprotect.c  | 1 +
> > > > > >  mm/mremap.c    | 2 ++
> > > > > >  mm/msync.c     | 2 ++
> > > > > >  10 files changed, 29 insertions(+)
> > > > >
> > > > > I wonder whether it's better to keep these as wrappers in the arm64
> > > > > code.
> > > >
> > > > I don't think I understand what you propose, could you elaborate?
> > >
> > > I believe Catalin is saying that instead of placing things like:
> > >
> > > @@ -1593,6 +1593,7 @@ SYSCALL_DEFINE3(shmat, int, shmid, char __user *, shmaddr, int, shmflg)
> > >       unsigned long ret;
> > >       long err;
> > >
> > > +     shmaddr = untagged_addr(shmaddr);
> > >
> > > To instead have the shmaddr set to the untagged_addr() before calling
> > > the system call, and passing the untagged addr to the system call, as
> > > that goes through the arm64 architecture specific code first.
> >
> > Indeed. For example, we already have a SYSCALL_DEFINE6(mmap, ...) in
> > arch/arm64/kernel/sys.c, just add the untagging there. We could do
> > something similar for the other syscalls. I don't mind doing this in the
> > generic code but if it's only needed for arm64, I'd rather keep the
> > generic changes to a minimum.
>
> Do I understand correctly, that I'll need to add ksys_ wrappers for
> each of the memory syscalls, and then redefine them in
> arch/arm64/kernel/sys.c with arm64_ prefix, like it is done for the
> personality syscall right now? This will require generic changes as
> well.

ping

>
> >
> > (I had a hack overriding __SC_CAST to do this automatically for pointer
> > arguments but this wouldn't work on mmap() and friends as the argument
> > is unsigned long)
> >
> > --
> > Catalin
