Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E3EC606D1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602EA21537
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEqVYpqj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbfGHWt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 18:49:59 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44804 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfGHWts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 18:49:48 -0400
Received: by mail-lf1-f65.google.com with SMTP id r15so12020040lfm.11;
        Mon, 08 Jul 2019 15:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XmrTaZHs1ZyCmACajXt2dKReVOHzkg6ke3uUVhyxo4M=;
        b=aEqVYpqjDZcGuLK2ahuFzS+p2IEBZfuD4zCnmcDMu75SAR3MX00Y8tNziZQWqVxzmR
         jhIpgWzjXdsKpwRjXKd0z2Css+YwUfm3Nr2Xdqwzl8b4imYwNX21uICFBeMON75NQ3O7
         EqF2oKFFRAnpC+h+BqXRfnBWijVkOJk9CnvvKpWO4h4FYl3sNSZGrG/UBCFvcP/+b2oB
         g2jfMuN4Kh5Ix2Qroi85YMPJCQ9UMneE0ksyoYpvsFHnYQLzfyMBpp1zt7qTVKAE/7mZ
         QV/AS+pw6X24acX9feE/Tk5wOeqeJ8pC3iLvqaRGnGIQ+MiriwAfTy/rfqIVA2jVbhOH
         1E9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XmrTaZHs1ZyCmACajXt2dKReVOHzkg6ke3uUVhyxo4M=;
        b=o+plOB3xFtYLT0NCSTUfI3cs08U3z8p8yLbbF/g4ZHb4lzbP6Xzy8o5nK1ujER9zyz
         RwxxxS+1kYzx/uj0BCWhq02K0Sio0VoCnBPDnr15MSFj1JDynx3GGLBwPcdtiHzVrvnk
         qJTzQd/gbA0BxKdzrXqfduQPNCa3acLnszSpwHi/c0EfXlYajMw9Yart3CdNt1TBwEEW
         auc7QCzjiE/6BHZQMWrGoeKRo4isrAlgaEkDKhFpbBMmYi6YFGmy7kpNL1uByScjyQQY
         qg8K/H7txXfqZ+JUeePr4cbluL82f5CoSBUf3Ad62v3Y7ICb6lwGcUjMcBfsjg9zstRR
         ffQQ==
X-Gm-Message-State: APjAAAXrgg9+1AiSDSRwQmRoXPSGTM1d7r7fjxjF5jB3+Os0WNMb4EdF
        G/boBpNT1Ov+GnqU54TQUOd23utP1VhMocJlFEM=
X-Google-Smtp-Source: APXvYqy4kqghwIdIQp/CAfc3t7rFXhI48koEdHw+Y84L5nOOyLEsRjP++eYeupExwtuxO98BWa0FYtb84R9lNNyV5VM=
X-Received: by 2002:ac2:5bc7:: with SMTP id u7mr10110824lfn.167.1562626185210;
 Mon, 08 Jul 2019 15:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <881939122b88f32be4c374d248c09d7527a87e35.1561685471.git.jpoimboe@redhat.com>
 <tip-b22cf36c189f31883ad0238a69ccf82aa1f3b16b@git.kernel.org>
 <20190706202942.GA123403@gmail.com> <20190707013206.don22x3tfldec4zm@treble>
 <20190707055209.xqyopsnxfurhrkxw@treble> <CAADnVQJqT8o=_6P6xHjwxrXqX9ToSb0cTfoOcm2Xcha3KRNNSw@mail.gmail.com>
 <20190708223834.zx7u45a4uuu2yyol@treble>
In-Reply-To: <20190708223834.zx7u45a4uuu2yyol@treble>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 8 Jul 2019 15:49:33 -0700
Message-ID: <CAADnVQKWDvzsvyjGoFvSQV7VGr2hF2zzCsC9vnpncWMxOJWYdw@mail.gmail.com>
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

On Mon, Jul 8, 2019 at 3:38 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Mon, Jul 08, 2019 at 03:15:37PM -0700, Alexei Starovoitov wrote:
> > > 2)
> > >
> > >   After doing the first optimization, GCC then does another one which is
> > >   a little trickier.  It replaces:
> > >
> > >         select_insn:
> > >                 jmp *jumptable(, %rax, 8)
> > >                 ...
> > >         ALU64_ADD_X:
> > >                 ...
> > >                 jmp *jumptable(, %rax, 8)
> > >         ALU_ADD_X:
> > >                 ...
> > >                 jmp *jumptable(, %rax, 8)
> > >
> > >   with
> > >
> > >         select_insn:
> > >                 mov jumptable, %r12
> > >                 jmp *(%r12, %rax, 8)
> > >                 ...
> > >         ALU64_ADD_X:
> > >                 ...
> > >                 jmp *(%r12, %rax, 8)
> > >         ALU_ADD_X:
> > >                 ...
> > >                 jmp *(%r12, %rax, 8)
> > >
> > >   The problem is that it only moves the jumptable address into %r12
> > >   once, for the entire function, then it goes through multiple recursive
> > >   indirect jumps which rely on that %r12 value.  But objtool isn't yet
> > >   smart enough to be able to track the value across multiple recursive
> > >   indirect jumps through the jump table.
> > >
> > >   After some digging I found that the quick and easy fix is to disable
> > >   -fgcse.  In fact, this seems to be recommended by the GCC manual, for
> > >   code like this:
> > >
> > >     -fgcse
> > >         Perform a global common subexpression elimination pass.  This
> > >         pass also performs global constant and copy propagation.
> > >
> > >         Note: When compiling a program using computed gotos, a GCC
> > >         extension, you may get better run-time performance if you
> > >         disable the global common subexpression elimination pass by
> > >         adding -fno-gcse to the command line.
> > >
> > >         Enabled at levels -O2, -O3, -Os.
> > >
> > >   This code indeed relies extensively on computed gotos.  I don't know
> > >   *why* disabling this optimization would improve performance.  In fact
> > >   I really don't see how it could make much of a difference either way.
> > >
> > >   Anyway, using -fno-gcse makes optimization #2 go away and makes
> > >   objtool happy, with only a fix for #1 needed.
> > >
> > >   If -fno-gcse isn't an option, we might be able to fix objtool by using
> > >   the "first_jump_src" thing which Peter added, improving it such that
> > >   it also takes table jumps into account.
> >
> > Sorry for delay. I'm mostly offgrid until next week.
> > As far as -fno-gcse.. I don't mind as long as it doesn't hurt performance.
> > Which I suspect it will :(
> > All these indirect gotos are there for performance.
> > Single indirect goto and a bunch of jmp select_insn
> > are way slower, since there is only one instruction
> > for cpu branch predictor to work with.
> > When every insn is followed by "jmp *jumptable"
> > there is more room for cpu to speculate.
> > It's been long time, but when I wrote it the difference
> > between all indirect goto vs single indirect goto was almost 2x.
>
> Just to clarify, -fno-gcse doesn't get rid of any of the indirect jumps.
> It still has 166 indirect jumps.  It just gets rid of the second
> optimization, where the jumptable address is placed in a register.

what about other functions in core.c ?
May be it's easier to teach objtool to recognize that pattern?

> If you have a benchmark which is relatively easy to use, I could try to
> run some tests.

modprobe test_bpf
selftests/bpf/test_progs
both print runtime.
Some of test_progs have high run-to-run variations though.
