Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04BFC606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A2621707
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBjL0ytY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405357AbfGHWPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 18:15:52 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:41055 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732782AbfGHWPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 18:15:51 -0400
Received: by mail-lf1-f44.google.com with SMTP id 62so11988222lfa.8;
        Mon, 08 Jul 2019 15:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bqu4OOG1U9yg+uZBPqnsvY5viByjOp0IKzDegiLwXbA=;
        b=aBjL0ytYIv/HhFUOC86GB1cWhIa+J2o6BD7OBDrXlkNjnNtvPusFwQ3ZarJ9Urb7/s
         WlRWYacdp+Xds5h1WYGLzV96erM3/Buuu3xQYANGrflXgZuSP7flD+ykdfOOTIyvDONt
         RMLyXyUyGjrXIUd9lMyM2jce67wVc0VUBl+1/zaJcqIRsqgIEQo0KxhN+mo0JuroWmWn
         3AUOyPusm0kgDrsi1RJ4PYvLhP6A2uEsTwW/W1NJU1w3iZPkCOaV3iMgOAEY/lqCbalh
         OmT1gz1/gUypeNd/Xixdzos9XMHmJ2xkxTGqR00MYGC1+suVHel9+ZHZnqfmAuTLf8nS
         mq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bqu4OOG1U9yg+uZBPqnsvY5viByjOp0IKzDegiLwXbA=;
        b=VSaqj54rFYyaFu4eYMm665Syg6qiRS8eaRm228RZZPeovqkDj8ce+r7VKd2+NSt0HD
         6k/X4l5uX29uiwG5VCsaRh53FDI8itDvBUZl11VcXr5HXnOLb0hcdz+MEc9f/+JdkRhr
         i0FhvivLP/xQSxJ7QMjEuC0XcxjP7nrU7MwSq208KmRWhXK/RydHUgo7WMk7o6qemW0B
         83KcE3UNr5Bqd9fPztIriyzMUHMVGT5wWJHwtZWuok9c3gSEVK9M8JBbMysq8MWI5LM4
         42xSWyFLeHscnfZzfDL3ETGEG3KmWBcaAgsMzSJW6inf+ukNgXg4GI4jNQR7mMGRINM7
         9oXw==
X-Gm-Message-State: APjAAAWWPBxUrUloB+wuiOu7YwzKv4BoR+98yKAUPPrrE8qdKUC0+tnc
        x7lafKBZSovrLOcfMgzrl0hGlc4EBA8LVPbnyXg=
X-Google-Smtp-Source: APXvYqzN0Zm6ZNDlDK5ejea+Ln6l3x/anRQFgagfgPpsW8mrekimLFPe/51uctS4vEvh/7+AwSTja1rIwIFmYp84dkM=
X-Received: by 2002:ac2:5337:: with SMTP id f23mr9951017lfh.15.1562624149427;
 Mon, 08 Jul 2019 15:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <881939122b88f32be4c374d248c09d7527a87e35.1561685471.git.jpoimboe@redhat.com>
 <tip-b22cf36c189f31883ad0238a69ccf82aa1f3b16b@git.kernel.org>
 <20190706202942.GA123403@gmail.com> <20190707013206.don22x3tfldec4zm@treble> <20190707055209.xqyopsnxfurhrkxw@treble>
In-Reply-To: <20190707055209.xqyopsnxfurhrkxw@treble>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 8 Jul 2019 15:15:37 -0700
Message-ID: <CAADnVQJqT8o=_6P6xHjwxrXqX9ToSb0cTfoOcm2Xcha3KRNNSw@mail.gmail.com>
Subject: Re: [tip:x86/urgent] bpf: Fix ORC unwinding in non-JIT BPF code
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Song Liu <songliubraving@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kairui Song <kasong@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 6, 2019 at 10:52 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Sat, Jul 06, 2019 at 08:32:06PM -0500, Josh Poimboeuf wrote:
> > On Sat, Jul 06, 2019 at 10:29:42PM +0200, Ingo Molnar wrote:
> > > Hm, I get this new build warning on x86-64 defconfig-ish kernels plus
> > > these enabled:
> > >
> > >  CONFIG_BPF=y
> > >  CONFIG_BPF_JIT=y
> > >
> > > kernel/bpf/core.o: warning: objtool: ___bpf_prog_run()+0x8da: sibling call from callable instruction with modified stack frame
> >
> > I assume you have CONFIG_RETPOLINE disabled?  For some reason that
> > causes GCC to add 166 indirect jumps to that function, which is giving
> > objtool trouble.  Looking into it.
>
> Alexei, do you have any objections to setting -fno-gcse for
> ___bpf_prog_run()?  Either for the function or the file?  Doing so seems
> to be recommended by the GCC manual for computed gotos.  It would also
> "fix" one of the issues.  More details below.
>
> Details:
>
> With CONFIG_RETPOLINE=n, there are a couple of GCC optimizations in
> ___bpf_prog_run() which objtool is having trouble with.
>
> 1)
>
>   The function has:
>
>         select_insn:
>                 goto *jumptable[insn->code];
>
>   And then a bunch of "goto select_insn" statements.
>
>   GCC is basically replacing
>
>         select_insn:
>                 jmp *jumptable(,%rax,8)
>                 ...
>         ALU64_ADD_X:
>                 ...
>                 jmp select_insn
>         ALU_ADD_X:
>                 ...
>                 jmp select_insn
>
>   with
>
>         select_insn:
>                 jmp *jumptable(, %rax, 8)
>                 ...
>         ALU64_ADD_X:
>                 ...
>                 jmp *jumptable(, %rax, 8)
>         ALU_ADD_X:
>                 ...
>                 jmp *jumptable(, %rax, 8)
>
>
>   It does that 166 times.
>
>   For some reason, it doesn't do the optimization with retpolines
>   enabled.
>
>   Objtool has never seen multiple indirect jump sites which use the same
>   jump table.  This is relatively trivial to fix (I already have a
>   working patch).
>
> 2)
>
>   After doing the first optimization, GCC then does another one which is
>   a little trickier.  It replaces:
>
>         select_insn:
>                 jmp *jumptable(, %rax, 8)
>                 ...
>         ALU64_ADD_X:
>                 ...
>                 jmp *jumptable(, %rax, 8)
>         ALU_ADD_X:
>                 ...
>                 jmp *jumptable(, %rax, 8)
>
>   with
>
>         select_insn:
>                 mov jumptable, %r12
>                 jmp *(%r12, %rax, 8)
>                 ...
>         ALU64_ADD_X:
>                 ...
>                 jmp *(%r12, %rax, 8)
>         ALU_ADD_X:
>                 ...
>                 jmp *(%r12, %rax, 8)
>
>   The problem is that it only moves the jumptable address into %r12
>   once, for the entire function, then it goes through multiple recursive
>   indirect jumps which rely on that %r12 value.  But objtool isn't yet
>   smart enough to be able to track the value across multiple recursive
>   indirect jumps through the jump table.
>
>   After some digging I found that the quick and easy fix is to disable
>   -fgcse.  In fact, this seems to be recommended by the GCC manual, for
>   code like this:
>
>     -fgcse
>         Perform a global common subexpression elimination pass.  This
>         pass also performs global constant and copy propagation.
>
>         Note: When compiling a program using computed gotos, a GCC
>         extension, you may get better run-time performance if you
>         disable the global common subexpression elimination pass by
>         adding -fno-gcse to the command line.
>
>         Enabled at levels -O2, -O3, -Os.
>
>   This code indeed relies extensively on computed gotos.  I don't know
>   *why* disabling this optimization would improve performance.  In fact
>   I really don't see how it could make much of a difference either way.
>
>   Anyway, using -fno-gcse makes optimization #2 go away and makes
>   objtool happy, with only a fix for #1 needed.
>
>   If -fno-gcse isn't an option, we might be able to fix objtool by using
>   the "first_jump_src" thing which Peter added, improving it such that
>   it also takes table jumps into account.

Sorry for delay. I'm mostly offgrid until next week.
As far as -fno-gcse.. I don't mind as long as it doesn't hurt performance.
Which I suspect it will :(
All these indirect gotos are there for performance.
Single indirect goto and a bunch of jmp select_insn
are way slower, since there is only one instruction
for cpu branch predictor to work with.
When every insn is followed by "jmp *jumptable"
there is more room for cpu to speculate.
It's been long time, but when I wrote it the difference
between all indirect goto vs single indirect goto was almost 2x.
