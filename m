Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56637CA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 23:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6942086D
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 23:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgvmVjDr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389948AbfJVXt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 19:49:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46005 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389861AbfJVXt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 19:49:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id b4so2738297pfr.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 16:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jy9PGt/JUHpqCjsUhqnEfKaQDEpFjLPDpvn+6DlfB7s=;
        b=cgvmVjDrPJ345Wr7smrxVEa9O3ft7r0SWLnAusfoV/SzNtw9nPEQVJDpNPaLfYdM0G
         yMNc5jvG22vT+gDtYmIc/lFTWnAdoElOXRax1gO/lboPqGXAmprKW4w7vULyarOUS6js
         c4yNVsTZmP2F1Ewr6f35gLNkCLaIBGoCBnRF9HPxZgC4Pj8RvLo/iTPCjT+V39rX7hE+
         CgInbjWOCkETixOykJxv4Leol9zOiAa8lGYldfODoXIx6wlI7JplpjxpA7OZsmbypvkP
         QvRvpxMk+l+nWo9k0YB20p9RjOPKRn+tYmJqlFQKP/pOEW11zP0WvuzzRIZWlZt0QhAR
         TVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jy9PGt/JUHpqCjsUhqnEfKaQDEpFjLPDpvn+6DlfB7s=;
        b=qkUu+s9ru15NYZS52Ekw25mJPDhgnkdsq5tbclC6dUUt543YviYk5PJmk4EVvM0PK2
         8Hq8O2gSx54bJReznyBiZmItYrFzVmZjDy1ZYFiES+dw8U9/1kAbOBPZUP+yoDV6Vru4
         a42fmmSNUP7jP+vnzNv1/qT9EQNZwNRa+gCsfu/gpynMNmtm6gCk000Lgi3hbHOazHLN
         /BjDhTU6qDtNi4/5pjEKnirHCZe3rpPE6cxPIjM0yVfUHd03K4kMBdh+mQK4hORajBza
         oQ5fHJtaxyhm8T1lrSdd/vqRSIymJ62aEv5dbg/e1AEfdqti10mQd6j36Tmyri/B9IPl
         Z9nw==
X-Gm-Message-State: APjAAAVvPPPbwzJTRb8agC9F3Wz6048Pk5QMZXP9Bs3Xv3UwoAC1SP4K
        2FinTpG/awZ9dVcwbDsLASU=
X-Google-Smtp-Source: APXvYqydM8hZGzOc0Cn8BCHDzqTYCzCLqeT48fLgD1D3OjpyS4Nzp6jjX2rsyNlEnsrmx29k7KqgOg==
X-Received: by 2002:a63:65c6:: with SMTP id z189mr6437316pgb.433.1571788165838;
        Tue, 22 Oct 2019 16:49:25 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1833])
        by smtp.gmail.com with ESMTPSA id r18sm24624538pgm.31.2019.10.22.16.49.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 16:49:25 -0700 (PDT)
Date:   Tue, 22 Oct 2019 16:49:22 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
Message-ID: <20191022234921.n5nplxlyq25mksxg@ast-mbp.dhcp.thefacebook.com>
References: <20191022215841.2qsmhd6vxi4mwade@ast-mbp.dhcp.thefacebook.com>
 <7364B113-DD65-423D-BED3-FF90C4DF8334@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7364B113-DD65-423D-BED3-FF90C4DF8334@amacapital.net>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 03:45:26PM -0700, Andy Lutomirski wrote:
> 
> 
> >> On Oct 22, 2019, at 2:58 PM, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >> 
> >> ﻿On Tue, Oct 22, 2019 at 05:04:30PM -0400, Steven Rostedt wrote:
> >> I gave a solution for this. And that is to add another flag to allow
> >> for just the minimum to change the ip. And we can even add another flag
> >> to allow for changing the stack if needed (to emulate a call with the
> >> same parameters).
> > 
> > your solution is to reduce the overhead.
> > my solution is to remove it competely. See the difference?
> > 
> >> By doing this work, live kernel patching will also benefit. Because it
> >> is also dealing with the unnecessary overhead of saving regs.
> >> And we could possibly even have kprobes benefit from this if a kprobe
> >> doesn't need full regs.
> > 
> > Neither of two statements are true. The per-function generated trampoline
> > I'm talking about is bpf specific. For a function with two arguments it's just:
> > push rbp 
> > mov rbp, rsp
> > push rdi
> > push rsi
> > lea  rdi,[rbp-0x10]
> > call jited_bpf_prog
> > pop rsi
> > pop rdi
> > leave
> > ret
> 
> Why are you saving rsi?  You said upthread that you’re saving the args, but rsi is already available in rsi.

because rsi is caller saved. The above example is for probing something
like tcp_set_state(struct sock *sk, int state) that everyone used to
kprobe until we got a tracepoint there.
The main bpf prog has only one argument R1 == rdi on x86,
but it's allowed to clobber all caller saved regs.
Just like x86 function that accepts one argument in rdi can clobber rsi and others.
So it's essential to save 'sk' and 'state' for tcp_set_state()
to continue as nothing happened.

>  But I’m wondering whether the bpf jitted code could just directly access the frame instead of indirecting through a register.

That's an excellent question!
We've debated a ton whether to extend main prog from R1 to all R1-R5
like bpf subprograms allow. The problem is a lot of existing infra
assume single R1==ctx. Passing 6th argument is not defined either.
But it's nice to see all arguments of the kernel function.
Also bpf is 64-bit ISA. Even when it's running on 32-bit arch.
Just taking values from registers doesn't work there.
Whereas when args are indirectly passed as a bunch of u64s in the stack
the bpf prog becomes portable across architectures
(not 100% of course, but close).

> Is it entirely specific to the probed function? 

yes. It is specific to the probed function. The verifier makes sure
that only first two arguments are accessed as read-only
via *(u64*)(r1 + 0) and *(u64*)(r1 + 8)
But the program is allowed to use r2-r5 without saving them.
r6-r10 are saved in implicit program prologue.

> In any event, I think you can’t *just* use text_poke.  Something needs to coordinate to ensure that, if you bpf trace an already-kprobed function, the right thing happens.

Right. Not _just_. I'm looking at Peter's patches and as a minimum I need to grab
text_mutex and make sure it's nop being replaced.

> FWIW, if you are going to use a trampoline like this, consider using r11 for the caller frame instead of rsi.

r11 can be used by jited code that doing divide and multiply.
It's possible to refactor that code and free it up.
I prefer to save such micro-optimization for later.
Dealing with interpreter is also a pain to the point I'm considering
to avoid supporting it for these new things.
Folks should be using CONFIG_BPF_JIT_ALWAYS_ON anyway.

