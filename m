Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58917C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 00:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C772085A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 00:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rtzlD+QI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732830AbfCAAyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 19:54:33 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42000 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfCAAyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 19:54:33 -0500
Received: by mail-oi1-f195.google.com with SMTP id s16so18138442oih.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 16:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8mgdYbmYAMxrxPxkrDEDYUV9PcZHWAxATjOJ8ZwA2PY=;
        b=rtzlD+QIneyB0PN0/wgylHtsOTlKgeP3E3qAfQguv23CnsMgcECXL4G0Hp7A22axRA
         oyKxrcV04W/FJ9UBx6qSMDHArEwGtBfnfMloqqdXKB9LBug439hCANVLXzLZo7b1I8Ic
         +NRtDNaAWwHg1IZbnnMIZz38amNeU2ZrJMyHR73AKgAu98R41bDTMkfZFrxuvOq5xXN5
         +pEHxDgNvuVcPCkqwQZ9VKnWnR9SemLGg2aHUPg3HtIO2NqFxj1azIf5KXhcg9Rwp4Cd
         CVYwjpt2y28NiFsC9I8RBIueBYv+KdeI5CYJtmjsBi4QMjqxqTT2JtPJM1ExEZ/+DGbA
         rGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8mgdYbmYAMxrxPxkrDEDYUV9PcZHWAxATjOJ8ZwA2PY=;
        b=OYlj63CmGJh0KUDreJLyYn+thzmycgOrna2RDNj9SygRBwb1QGllA6Bdlv+KsoZGBI
         L8/UcF0KO6At1EkWfFj+wfAsHqzbr+U/77ihBl2Z81AALMoPITYooHoF0M+Bw8FcYNaN
         vsw0f63WklbTqO5po1FI3JjYeRdPcy+F9rUlKijv+AYI8sydDe2+o864JcStoZfW9uvO
         p0acJ4iGBoxg2oVpij6bcHldz2LF9Cfs3lDeOVflMcnRmVwjiebBmhfYIYzbqP7pTaf8
         uGFPFQvO/xbBnL0DOwyV/u7qrRN2rF1NuhogyQokrUKsxfk+AJk5UqkUPT+mjPxOsXgx
         P9Bg==
X-Gm-Message-State: AHQUAubQeMFR92QrIw2YPxalzIK4SEC1cKEACqCi31En/t3dkAMa6729
        Ea74nBKV3vENN3oJ7+g+C8TNYxRXBAkmzMr7WPew8w==
X-Google-Smtp-Source: AHgI3IbqmUIfqsBaoYBqvf3sGrxahpjE8Ht9DkwYj1SzEI7fYaiAtXazN0U6LPuX6kQ/WbrLUNQ/Fefg91mnRKoD4EI=
X-Received: by 2002:aca:cc4d:: with SMTP id c74mr1689814oig.157.1551401671766;
 Thu, 28 Feb 2019 16:54:31 -0800 (PST)
MIME-Version: 1.0
References: <0000000000001aab8b0582689e11@google.com> <20190221113624.284fe267e73752639186a563@linux-foundation.org>
 <CAG48ez14jBF3uJH8qP+JrXtiQnQ2S+y9wHVpQ0mEXbmAVqKgWg@mail.gmail.com>
 <alpine.DEB.2.21.1902281248400.1821@nanos.tec.linutronix.de> <CAG48ez2huzOwKvH5qVGaGeWOKRDX8qr_9keHBcZCyBaw85ed-g@mail.gmail.com>
In-Reply-To: <CAG48ez2huzOwKvH5qVGaGeWOKRDX8qr_9keHBcZCyBaw85ed-g@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 1 Mar 2019 01:54:05 +0100
Message-ID: <CAG48ez3UdLSikuCqEUnVJH3wVRjj95fzO-3HUO7=5bkaftd3jw@mail.gmail.com>
Subject: Re: missing stack trace entry on NULL pointer call [was: Re: BUG:
 unable to handle kernel NULL pointer dereference in __generic_file_write_iter]
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        syzbot <syzbot+ca95b2b7aef9e7cbd6ab@syzkaller.appspotmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>, hannes@cmpxchg.org,
        Hugh Dickins <hughd@google.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 5:34 PM Jann Horn <jannh@google.com> wrote:
>
> On Thu, Feb 28, 2019 at 1:57 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Thu, 28 Feb 2019, Jann Horn wrote:
> > > +Josh for unwinding, +x86 folks
> > > On Wed, Feb 27, 2019 at 11:43 PM Andrew Morton
> > > <akpm@linux-foundation.org> wrote:
> > > > On Thu, 21 Feb 2019 06:52:04 -0800 syzbot <syzbot+ca95b2b7aef9e7cbd6ab@syzkaller.appspotmail.com> wrote:
> > > >
> > > > > Hello,
> > > > >
> > > > > syzbot found the following crash on:
> > > > >
> > > > > HEAD commit:    4aa9fc2a435a Revert "mm, memory_hotplug: initialize struct..
> > > > > git tree:       upstream
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1101382f400000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=4fceea9e2d99ac20
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=ca95b2b7aef9e7cbd6ab
> > > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > >
> > > > > Unfortunately, I don't have any reproducer for this crash yet.
> > > >
> > > > Not understanding.  That seems to be saying that we got a NULL pointer
> > > > deref in __generic_file_write_iter() at
> > > >
> > > >                 written = generic_perform_write(file, from, iocb->ki_pos);
> > > >
> > > > which isn't possible.
> > > >
> > > > I'm not seeing recent changes in there which could have caused this.  Help.
> > >
> > > +
> > >
> > > Maybe the problem is that the frame pointer unwinder isn't designed to
> > > cope with NULL function pointers - or more generally, with an
> > > unwinding operation that starts before the function's frame pointer
> > > has been set up?
> > >
> > > Unwinding starts at show_trace_log_lvl(). That begins with
> > > unwind_start(), which calls __unwind_start(), which uses
> > > get_frame_pointer(), which just returns regs->bp. But that frame
> > > pointer points to the part of the stack that's storing the address of
> > > the caller of the function that called NULL; the caller of NULL is
> > > skipped, as far as I can tell.
> > >
> > > What's kind of annoying here is that we don't have a proper frame set
> > > up yet, we only have half a stack frame (saved RIP but no saved RBP).
> >
> > That wreckage is related to the fact that the indirect calls are going
> > through __x86_indirect_thunk_$REG. I just verified on a VM with some other
> > callback NULL'ed that the resulting backtrace is not really helpful.
> >
> > So in that case generic_perform_write() has two indirect calls:
> >
> >   mapping->a_ops->write_begin() and ->write_end()
>
> Does the indirect thunk thing really make any difference? When you
> arrive at RIP=NULL, RSP points to a saved instruction pointer, just
> like when indirect calls are compiled normally.
>
> I just compiled kernels with artificial calls to a NULL function
> pointer (in prctl_set_seccomp()), with retpoline disabled, with both
> unwinders. The ORC unwinder shows a call trace with "?" everywhere
> that doesn't show the caller:
[...]
> So I think this doesn't really have anything to do with
> __x86_indirect_thunk_$REG, and the best possible fix might be to teach
> the unwinders that RIP==NULL means "pretend that RIP is *real_RSP and
> that RSP is real_RSP+8, and report *real_RSP as the first element of
> the backtrace".

Cooking up some patches now...
