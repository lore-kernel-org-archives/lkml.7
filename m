Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625B4C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 21:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2714121883
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 21:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567546415;
	bh=866F0EIIWA+0xbFlY0SUcwqfsugpfCY52EDAr1/yqf0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zSSE9UfDCZxSlzViAem6pWieRpRyCJlBzaZefP8A1gTMPoTjGLtizl9j0rNT45Rgb
	 1qQTvbyjz8oo3mDZgTIJ4l0CLG614WcfhgOKz3hPolwKCt9GNVg196E1ioiYfJAW+g
	 Q8sMKmjTIEKBG1zu7nEuvfQQMkVfoxBll/ylJ85k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfICVde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 17:33:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbfICVde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 17:33:34 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9501B233A1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2019 21:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567546412;
        bh=866F0EIIWA+0xbFlY0SUcwqfsugpfCY52EDAr1/yqf0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jX3YkGsdW4NQNXFONUBy4VTeeXygdaAWepK6WojGJPssUn5kzzTB7OJHjlgQCmmg1
         8krZStByn6xbZ5idk6qyDpXsnvG0MBDkQmzvSHr+GHToLXKsIuG9lF5nfvqvqTvsbm
         2TnSBXYHkVL43ipOBnq+ZOyH2QskXHLizMbhFgNY=
Received: by mail-wr1-f51.google.com with SMTP id z11so18993085wrt.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 14:33:32 -0700 (PDT)
X-Gm-Message-State: APjAAAXi1u4hfV18LzqAUTWcoVDXfDi7Fc5yi8Hk7OD1be9bie89+OnD
        H6HX30HjSE6jyszlaqZSy5wjVmVGM28rVputRYRgQQ==
X-Google-Smtp-Source: APXvYqxRJgr1UIkn3S7R3QSYvOHheZCVIg7tSyqRoD36f91gbs8fmjjo0NXnSznxYXN8NxyQNhP6xQmD+2dZKd/hwjc=
X-Received: by 2002:adf:fe0f:: with SMTP id n15mr25278270wrr.343.1567546411009;
 Tue, 03 Sep 2019 14:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190823224635.15387-1-namit@vmware.com> <CALCETrX+h7FeyY290kvYRHAjMVDrmHivc55g+o0hnXrmm-wZRw@mail.gmail.com>
 <3989CBFF-F1C1-4F64-B8C4-DBFF80997857@vmware.com> <CALCETrWsbay9YRuTXuAW9HD+GjXr7jVN367afG2VKRCZ-TtJ+Q@mail.gmail.com>
 <A960DD27-C10F-4332-971B-2339A27728C3@vmware.com>
In-Reply-To: <A960DD27-C10F-4332-971B-2339A27728C3@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 3 Sep 2019 14:33:18 -0700
X-Gmail-Original-Message-ID: <CALCETrXX7YJRPuj8RgFZ_TLgGodvtQsL_045PJMM+DMb0eFmkw@mail.gmail.com>
Message-ID: <CALCETrXX7YJRPuj8RgFZ_TLgGodvtQsL_045PJMM+DMb0eFmkw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] x86/mm/tlb: Defer TLB flushes with PTI
To:     Nadav Amit <namit@vmware.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 10:24 AM Nadav Amit <namit@vmware.com> wrote:
>
> > On Aug 27, 2019, at 5:30 PM, Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Tue, Aug 27, 2019 at 4:52 PM Nadav Amit <namit@vmware.com> wrote:
> >>> On Aug 27, 2019, at 4:18 PM, Andy Lutomirski <luto@kernel.org> wrote:
> >>>
> >>> On Fri, Aug 23, 2019 at 11:07 PM Nadav Amit <namit@vmware.com> wrote:
> >>>> INVPCID is considerably slower than INVLPG of a single PTE, but it i=
s
> >>>> currently used to flush PTEs in the user page-table when PTI is used=
.
> >>>>
> >>>> Instead, it is possible to defer TLB flushes until after the user
> >>>> page-tables are loaded. Preventing speculation over the TLB flushes
> >>>> should keep the whole thing safe. In some cases, deferring TLB flush=
es
> >>>> in such a way can result in more full TLB flushes, but arguably this
> >>>> behavior is oftentimes beneficial.
> >>>
> >>> I have a somewhat horrible suggestion.
> >>>
> >>> Would it make sense to refactor this so that it works for user *and*
> >>> kernel tables?  In particular, if we flush a *kernel* mapping (vfree,
> >>> vunmap, set_memory_ro, etc), we shouldn't need to send an IPI to a
> >>> task that is running user code to flush most kernel mappings or even
> >>> to free kernel pagetables.  The same trick could be done if we treat
> >>> idle like user mode for this purpose.
> >>>
> >>> In code, this could mostly consist of changing all the "user" data
> >>> structures involved to something like struct deferred_flush_info and
> >>> having one for user and one for kernel.
> >>>
> >>> I think this is horrible because it will enable certain workloads to
> >>> work considerably faster with PTI on than with PTI off, and that woul=
d
> >>> be a barely excusable moral failing. :-p
> >>>
> >>> For what it's worth, other than register clobber issues, the whole
> >>> "switch CR3 for PTI" logic ought to be doable in C.  I don't know a
> >>> priori whether that would end up being an improvement.
> >>
> >> I implemented (and have not yet sent) another TLB deferring mechanism.=
 It is
> >> intended for user mappings and not kernel one, but I think your sugges=
tion
> >> shares some similar underlying rationale, and therefore challenges and
> >> solutions. Let me rephrase what you say to ensure we are on the same p=
age.
> >>
> >> The basic idea is context-tracking to check whether each CPU is in ker=
nel or
> >> user mode. Accordingly, TLB flushes can be deferred, but I don=E2=80=
=99t see that
> >> this solution is limited to PTI. There are 2 possible reasons, accordi=
ng to
> >> my understanding, that you limit the discussion to PTI:
> >>
> >> 1. PTI provides clear boundaries when user and kernel mappings are use=
d. I
> >> am not sure that privilege-levels (and SMAP) do not do the same.
> >>
> >> 2. CR3 switching already imposes a memory barrier, which eliminates mo=
st of
> >> the cost of implementing such scheme which requires something which is
> >> similar to:
> >>
> >>        write new context (kernel/user)
> >>        mb();
> >>        if (need_flush) flush;
> >>
> >> I do agree that PTI addresses (2), but there is another problem. A
> >> reasonable implementation would store in a per-cpu state whether each =
CPU is
> >> in user/kernel, and the TLB shootdown initiator CPU would check the st=
ate to
> >> decide whether an IPI is needed. This means that pretty much every TLB
> >> shutdown would incur a cache-miss per-target CPU. This might cause
> >> performance regressions, at least in some cases.
> >
> > We already more or less do this: we have mm_cpumask(), which is
> > particularly awful since it writes to a falsely-shared line for each
> > context switch.
>
> > For what it's worth, in some sense, your patch series is reinventing
> > the tracking that is already in cpu_tlbstate -- when we do a flush on
> > one mm and some cpu is running another mm, we don't do an IPI
> > shootdown -- instead we set flags so that it will be flushed the next
> > time it's used.  Maybe we could actually refactor this so we only have
> > one copy of this code that handles all the various deferred flush
> > variants.  Perhaps each tracked mm context could have a user
> > tlb_gen_id and a kernel tlb_gen_id.  I guess one thing that makes this
> > nasty is that we need to flush the kernel PCID for kernel *and* user
> > invalidations.  Sigh.
>
> Sorry for the late response - I was feeling under the weather.
>
> There is a tradeoff between how often the state changes and how often it =
is
> being checked. So actually, with this patch-set, we have three indication=
s
> of deferred TLB flushes:
>
> 1. mm_cpumask(), since mm changes infrequently
>
> 2. =E2=80=9Cis_lazy", which changes frequently, making per-cpu cacheline =
checks more
> efficient than (1).
>
> 3. Deferred-PTI, which is only updated locally.
>
> This patch-set only introduces (3). Your suggestion, IIUC, is to somehow
> combine (1) and (2), which I suspect might introduce some performance
> regressions. Changing a cpumask, or even writing to a cacheline on *every=
*
> kernel entry/exit can induce overheads (in the latter case, when the
> shootdown initiator checks whether the flush can be deferred).

Hmm.  It's entirely possible that my idea wasn't so good.  Although
mm_cpumask() writes really are a problem in some workloads.  Rik has
benchmarked this.

My thought is that, *maybe*, writing to a percpu cacheline on kernel
entry and exit is cheap enough that it will make up for itself in the
ability to avoid some IPIs.  Writing to mm_cpumask() on each entry
would be horrible.
