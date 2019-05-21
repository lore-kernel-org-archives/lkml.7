Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B93C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04300217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BIsbOTpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbfEUQUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 12:20:44 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33083 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfEUQUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 12:20:43 -0400
Received: by mail-ot1-f68.google.com with SMTP id 66so16926558otq.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 09:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BW3bQNoDviAamFC+RcRIIS02hInnMbbXec0nwAshfyk=;
        b=BIsbOTpu8o1r4oR1eExX7HB2wuf7SF+K+1MHv2XnAvbhBJK94bjaX5xD3Wz00KmoNf
         O34+uTz4vJ6ALRoh77myvTmXrWYWdqo+HxwNwrLbQCMBmPdAin6qfsGIqtkCARvPA2N6
         YOltAYKFOJqAnUMjA+r4baJ5pwlRpjQxbG27SvDbEShhPUNuPwMTC6ttd6WH1js0k1VQ
         sWsDtK5uUOPUUxD18R5Ixsq3x+A5W3nSQ/xZrxdVfvLlKfdbl6oBBgOrdBipX5gL0o7T
         +QQjXpZXtRhp7swD84820UmczIkTD/SPRl8g02G3iC6olxH7wcg/yWVEkGkWfYpnUig5
         K7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BW3bQNoDviAamFC+RcRIIS02hInnMbbXec0nwAshfyk=;
        b=r3dFSIZHSCC1y3P3Jk+mbXcYHfupp5sb6GQmmDunz2eKpxSORYzSD21W54Xg6bTBu4
         W7orA8KgDHDKyWPJSOImOFGK5yRjyjfPe7x/NEpHf89WjTJ+3px7V+Js8FgnusZPW2Af
         3iI9nyJV+rQi3dOnUCVnUU0XrtuPooV1y877tuimXUfK9wQ8ErxnyTLSK8sdvhWP/ILA
         AEN+4Nkwv4c16AB+itQnRnd/qfE0K7mdu6QyRc6AZpwJRdkzR9umqoZIULKasRvirI/G
         qSwDOPiDxWOIe7AYN26++tvWWJx/aS9yBBtqfosVARL5OktW6QeN/L0S1O4upa+JEiwC
         86zw==
X-Gm-Message-State: APjAAAVPs/7fkriGyBSWyVcLYMF3m9Mq9XCPFqFkHF37V5hgBhkN4WpY
        FJCAWZAVtW2ESGq/CaG/yw7NwglYk+/zA22/Q5UeGw==
X-Google-Smtp-Source: APXvYqxHnjO0O+EyjFF0Z4zORdD2l9Rk3gkQ77tzlptApyPkz1WpeDUvMdq02nYzFbXQN+tda0ZsRLQKk/6mLvObkI8=
X-Received: by 2002:a9d:7f8b:: with SMTP id t11mr38337otp.110.1558455642667;
 Tue, 21 May 2019 09:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <155836064844.2441.10911127801797083064.stgit@localhost.localdomain>
 <CALCETrU221N6uPmdaj4bRDDsf+Oc5tEfPERuyV24wsYKHn+spA@mail.gmail.com> <9638a51c-4295-924f-1852-1783c7f3e82d@virtuozzo.com>
In-Reply-To: <9638a51c-4295-924f-1852-1783c7f3e82d@virtuozzo.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 21 May 2019 18:20:16 +0200
Message-ID: <CAG48ez2BcVCwYGmAo4MwZ2crZ9f7=qKrORcN=fYz=K5xP2xfgQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] mm: process_vm_mmap() -- syscall for duplication a
 process mapping
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Weiny Ira <ira.weiny@intel.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        arunks@codeaurora.org, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Rik van Riel <riel@surriel.com>,
        Kees Cook <keescook@chromium.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        daniel.m.jordan@oracle.com, Adam Borowski <kilobyte@angband.pl>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 5:52 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> On 21.05.2019 17:43, Andy Lutomirski wrote:
> > On Mon, May 20, 2019 at 7:01 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >> New syscall, which allows to clone a remote process VMA
> >> into local process VM. The remote process's page table
> >> entries related to the VMA are cloned into local process's
> >> page table (in any desired address, which makes this different
> >> from that happens during fork()). Huge pages are handled
> >> appropriately.
[...]
> >> There are several problems with process_vm_writev() in this example:
> >>
> >> 1)it causes pagefault on remote process memory, and it forces
> >>   allocation of a new page (if was not preallocated);
> >
> > I don't see how your new syscall helps.  You're writing to remote
> > memory.  If that memory wasn't allocated, it's going to get allocated
> > regardless of whether you use a write-like interface or an mmap-like
> > interface.
>
> No, the talk is not about just another interface for copying memory.
> The talk is about borrowing of remote task's VMA and corresponding
> page table's content. Syscall allows to copy part of page table
> with preallocated pages from remote to local process. See here:
>
> [task1]                                                        [task2]
>
> buf = mmap(NULL, n * PAGE_SIZE, PROT_READ|PROT_WRITE,
>            MAP_PRIVATE|MAP_ANONYMOUS, ...);
>
> <task1 populates buf>
>
>                                                                buf = process_vm_mmap(pid_of_task1, addr, n * PAGE_SIZE, ...);
> munmap(buf);
>
>
> process_vm_mmap() copies PTEs related to memory of buf in task1 to task2
> just like in the way we do during fork syscall.
>
> There is no copying of buf memory content, unless COW happens. This is
> the principal difference to process_vm_writev(), which just allocates
> pages in remote VM.
>
> > Keep in mind that, on x86, just the hardware part of a
> > page fault is very slow -- populating the memory with a syscall
> > instead of a fault may well be faster.
>
> It is not as slow, as disk IO has. Just compare, what happens in case of anonymous
> pages related to buf of task1 are swapped:
>
> 1)process_vm_writev() reads them back into memory;
>
> 2)process_vm_mmap() just copies swap PTEs from task1 page table
>   to task2 page table.
>
> Also, for faster page faults one may use huge pages for the mappings.
> But really, it's funny to think about page faults, when there are
> disk IO problems I shown.
[...]
> > That only doubles the amount of memory if you let n
> > scale linearly with p, which seems unlikely.
> >
> >>
> >> 3)received data has no a chance to be properly swapped for
> >>   a long time.
> >
> > ...
> >
> >> a)kernel moves @buf pages into swap right after recv();
> >> b)process_vm_writev() reads the data back from swap to pages;
> >
> > If you're under that much memory pressure and thrashing that badly,
> > your performance is going to be awful no matter what you're doing.  If
> > you indeed observe this behavior under normal loads, then this seems
> > like a VM issue that should be addressed in its own right.
>
> I don't think so. Imagine: a container migrates from one node to another.
> The nodes are the same, say, every of them has 4GB of RAM.
>
> Before the migration, the container's tasks used 4GB of RAM and 8GB of swap.
> After the page server on the second node received the pages, we want these
> pages become swapped as soon as possible, and we don't want to read them from
> swap to pass a read consumer.

But you don't have to copy that memory into the container's tasks all
at once, right? Can't you, every time you've received a few dozen
kilobytes of data or whatever, shove them into the target task? That
way you don't have problems with swap because the time before the data
has arrived in its final VMA is tiny.
