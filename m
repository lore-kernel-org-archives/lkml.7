Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023A1C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B0324684
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ry6bmtLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfLTMSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 07:18:14 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35636 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbfLTMSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 07:18:14 -0500
Received: by mail-io1-f65.google.com with SMTP id v18so9199385iol.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 04:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+fpn5MBrUsO68vwFWveOAH2qULu+Kd/H5CmwM9v3iQ8=;
        b=ry6bmtLZkIP/fUiJw7N0x7wl432V1h8rQGXiC73T1m3xeoYjUa+VwnKva5Wtp/PkUf
         WFJZrRAGuDZTkPCN2KriGUTeasYUB3zrwp6b/Fk7AIa4iQ2yv7AnJ70oXsu0gFmrTlmU
         4wUmqzuI1hTMhZoPkdsq6rI0iA3QKZ4MaWtS8v3Xyy18gdMzg0kysnXPVaShQXOtV4vV
         UH2lwHEole8gh+m3DG0asxBPLXijl/MOJ7q4XwnCMpoUI49TvlW2np6Ow6ZACemDp7Oc
         Ufb/QobWEisK+g65YqwofVZTEB4Dnrlq5ZyqsAzSamKIA0oHXa6DAgBiYEGoVAZRj+zH
         7EKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+fpn5MBrUsO68vwFWveOAH2qULu+Kd/H5CmwM9v3iQ8=;
        b=PNJ0niRIknjZg1mwplmIEq0+OqczMKj8mtx9LH7/Bi3Z8+qJ6Yb0VCfFSXMaygBR0s
         81xnQvAX+O2qObD/j2/FZ0f4OtNlQ02yT1eUP0puQa943uo2/Agf+li2UNewQnmeuk5+
         bA13TqVhWxjrzVJL6N8/7ijj7penoEFGsSohTRay5lExzsuVkVmfcwfa4/PHR1lyH/WJ
         9Q33idrAC3MLsTkkNqZBy7RAGPoQD+gdjKgILjBbwsVFQzjRVQFwNq6Shy6QUn9VwdnS
         PXuH1CcHF35bWW88+xuG3embz9VcRcjAnlhVOQoWzkyz+Q52gxFZf/xOtPUacfaFieKQ
         sSnQ==
X-Gm-Message-State: APjAAAW/G58GrSYmfnbs3SSDuY2cA/uJmUHG+jVwg5C3zUhjDnV/nGxD
        xlwbqAtW2q3n7kIstrMo73ar5G+MNaMCcG9fdQ==
X-Google-Smtp-Source: APXvYqwoXFpvJgEZdjM7NQES6jn5HwmN8ah4g6rQdgJS5l43sIBIJBKGiyWEdnBrhbk2vHVzGcC3uMS6RXak3U+Yelg=
X-Received: by 2002:a5e:8344:: with SMTP id y4mr9243560iom.27.1576844293749;
 Fri, 20 Dec 2019 04:18:13 -0800 (PST)
MIME-Version: 1.0
References: <20191219115812.102620-1-brgerst@gmail.com> <CALCETrW1zE0Uufrg_UG4JNQKMy3UFxnd+XmZye2gdTV36C-yTw@mail.gmail.com>
 <CAMzpN2if2m4McWpL49U4QAEM1MJ+qgTe-emN8vKcjVc1H+84vA@mail.gmail.com> <431a146f6461402da61d09fff155f35b@AcuMS.aculab.com>
In-Reply-To: <431a146f6461402da61d09fff155f35b@AcuMS.aculab.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Fri, 20 Dec 2019 07:18:02 -0500
Message-ID: <CAMzpN2i+DrKkzDyiS6Cj61LmCu+--e5puQpKrNxYVMDRPMvvBw@mail.gmail.com>
Subject: Re: [PATCH] x86: Remove force_iret()
To:     David Laight <David.Laight@aculab.com>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 5:10 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Brian Gerst
> > Sent: 20 December 2019 03:48
> > On Thu, Dec 19, 2019 at 8:50 PM Andy Lutomirski <luto@kernel.org> wrote:
> > >
> > > On Thu, Dec 19, 2019 at 3:58 AM Brian Gerst <brgerst@gmail.com> wrote:
> > > >
> > > > force_iret() was originally intended to prevent the return to user mode with
> > > > the SYSRET or SYSEXIT instructions, in cases where the register state could
> > > > have been changed to be incompatible with those instructions.
> > >
> > > It's more than that.  Before the big syscall rework, we didn't restore
> > > the caller-saved regs.  See:
> > >
> > > commit 21d375b6b34ff511a507de27bf316b3dde6938d9
> > > Author: Andy Lutomirski <luto@kernel.org>
> > > Date:   Sun Jan 28 10:38:49 2018 -0800
> > >
> > >     x86/entry/64: Remove the SYSCALL64 fast path
> > >
> > > So if you changed r12, for example, the change would get lost.
> >
> > force_iret() specifically dealt with changes to CS, SS and EFLAGS.
> > Saving and restoring the extra registers was a different problem
> > although it affected the same functions like ptrace, signals, and
> > exec.
>
> Is it ever possible for any of the segment registers to refer to the LDT
> and for another thread to invalidate the entries 'very late' ?
> So even though the values were valid when changed, they are
> invalid during the 'return to user' sequence.

Not in the SYSRET case, where the kernel requires that CS and SS are
static segments in the GDT.  Any userspace context that uses LDT
segments for CS/SS must return with IRET.  There is fault handling for
IRET (fixup_bad_iret()) for this case.

> I remember writing a signal handler that 'corrupted' all the
> segment registers (etc) and fixing the NetBSD kernel to handle
> all the faults restoring the segment registers and IRET faulting
> in kernel (IIRC invalid user %SS or %CS).
> (IRET can also fault in user space, but that is a normal fault.)
>
> Is it actually cheaper to properly validate the segment registers,
> or take the 'hit' of the slightly slower IRET path and get the cpu
> to do it for you?

SYSRET is faster because it avoids segment table lookups and
permission checks for CS and SS.  It simply sets the selectors to
values set in an MSR and the attributes (base, limit, etc.) to fixed
values.  It is up to the OS to make sure the actual segment
descriptors in memory match those default attributes.

--
Brian Gerst
