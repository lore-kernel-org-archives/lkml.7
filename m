Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61412C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 02:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218C3217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 02:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388393AbfEXCVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 22:21:05 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:32963 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388221AbfEXCVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 22:21:04 -0400
Received: by mail-io1-f67.google.com with SMTP id z4so6594242iol.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 19:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TU9aYcgfNn+o19/ZAhWzQtbz6o/09lUEz74yQbsbrOs=;
        b=IYmFlcrCbLJvf+DMaU0f07icE+57EErMva7k0BG1s06+uLm5pg5EzoyKFoqhRbzPw/
         PtfRMIxkIzTAWwbbO3qKnPbSzeeCOQV+wdisuoA6PWCk8bCvZcu0afoe1tz8XJU6GPMW
         zPmRb0iYbJjwq+3MfeoLd+jsDZEo9kmXyG4QZ9XzXJyGOTJPoBR4rVyt1XYhURjQh6eK
         9XzBhuFumtDdyv22Auuk+5OehhamWrkd/VnQoZRXMPKHA3cGpY/9tkF5BovrPwuOOdrQ
         fkSPvxymrrErfg35AllMx/QSVUnpX6NbZuiwocN3NJchrUcKbDZrca16tAXReG9gDS2p
         r6Bg==
X-Gm-Message-State: APjAAAUnkjP7v1Hgxh5yQmpTjHyVebEVLauBxC2XpJeF5dDaMYdunEf0
        qTq4359oflruaARtbYI/U+uJo7012cHrQO88PsvgrA==
X-Google-Smtp-Source: APXvYqxbzwmKP5zCOrF9d/b6xGv/Y8vObXzFIyCgXMb5NFMNIrNQb6s8fIjcHFafIn6tV0z6EJRKgM+nov7KtbhNUjM=
X-Received: by 2002:a05:6602:211a:: with SMTP id x26mr5453533iox.202.1558664464183;
 Thu, 23 May 2019 19:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <CACPcB9cpNp5CBqoRs+XMCwufzAFa8Pj-gbmj9fb+g5wVdue=ig@mail.gmail.com>
 <20190522140233.GC16275@worktop.programming.kicks-ass.net>
 <ab047883-69f6-1175-153f-5ad9462c6389@fb.com> <20190522174517.pbdopvookggen3d7@treble>
 <20190522234635.a47bettklcf5gt7c@treble> <CACPcB9dRJ89YAMDQdKoDMU=vFfpb5AaY0mWC_Xzw1ZMTFBf6ng@mail.gmail.com>
 <20190523133253.tad6ywzzexks6hrp@treble> <CACPcB9fQKg7xhzhCZaF4UGi=EQs1HLTFgg-C_xJQaUfho3yMyA@mail.gmail.com>
 <20190523152413.m2pbnamihu3s2c5s@treble> <CACPcB9e0mL6jdNWfH-2K-rkvmQiz=G6mtLiZ+AEmp3-V0x+Z8A@mail.gmail.com>
 <20190523172714.6fkzknfsuv2t44se@treble>
In-Reply-To: <20190523172714.6fkzknfsuv2t44se@treble>
From:   Kairui Song <kasong@redhat.com>
Date:   Fri, 24 May 2019 10:20:52 +0800
Message-ID: <CACPcB9dHzht9v9G9_z6oe5AAwgxCTuswRLxTB29vhWphqBO5Ng@mail.gmail.com>
Subject: Re: Getting empty callchain from perf_callchain_kernel()
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Alexei Starovoitov <ast@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 1:27 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Fri, May 24, 2019 at 12:41:59AM +0800, Kairui Song wrote:
> >  On Thu, May 23, 2019 at 11:24 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > On Thu, May 23, 2019 at 10:50:24PM +0800, Kairui Song wrote:
> > > > > > Hi Josh, this still won't fix the problem.
> > > > > >
> > > > > > Problem is not (or not only) with ___bpf_prog_run, what actually went
> > > > > > wrong is with the JITed bpf code.
> > > > >
> > > > > There seem to be a bunch of issues.  My patch at least fixes the failing
> > > > > selftest reported by Alexei for ORC.
> > > > >
> > > > > How can I recreate your issue?
> > > >
> > > > Hmm, I used bcc's example to attach bpf to trace point, and with that
> > > > fix stack trace is still invalid.
> > > >
> > > > CMD I used with bcc:
> > > > python3 ./tools/stackcount.py t:sched:sched_fork
> > >
> > > I've had problems in the past getting bcc to build, so I was hoping it
> > > was reproducible with a standalone selftest.
> > >
> > > > And I just had another try applying your patch, self test is also failing.
> > >
> > > Is it the same selftest reported by Alexei?
> > >
> > >   test_stacktrace_map:FAIL:compare_map_keys stackid_hmap vs. stackmap err -1 errno 2
> > >
> > > > I'm applying on my local master branch, a few days older than
> > > > upstream, I can update and try again, am I missing anything?
> > >
> > > The above patch had some issues, so with some configs you might see an
> > > objtool warning for ___bpf_prog_run(), in which case the patch doesn't
> > > fix the test_stacktrace_map selftest.
> > >
> > > Here's the latest version which should fix it in all cases (based on
> > > tip/master):
> > >
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/commit/?h=bpf-orc-fix
> >
> > Hmm, I still get the failure:
> > test_stacktrace_map:FAIL:compare_map_keys stackid_hmap vs. stackmap
> > err -1 errno 2
> >
> > And I didn't see how this will fix the issue. As long as ORC need to
> > unwind through the JITed code it will fail. And that will happen
> > before reaching ___bpf_prog_run.
>
> Ok, I was able to recreate by doing
>
>   echo 1 > /proc/sys/net/core/bpf_jit_enable
>
> first.  I'm guessing you have CONFIG_BPF_JIT_ALWAYS_ON.
>

Yes, with JIT off it will be fixed. I can confirm that.

--
Best Regards,
Kairui Song
