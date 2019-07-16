Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73FBC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 23:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E2C217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 23:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388715AbfGPXDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 19:03:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbfGPXDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 19:03:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7CC4D3084242;
        Tue, 16 Jul 2019 23:03:00 +0000 (UTC)
Received: from treble (ovpn-123-204.rdu2.redhat.com [10.10.123.204])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA68F600C7;
        Tue, 16 Jul 2019 23:02:57 +0000 (UTC)
Date:   Tue, 16 Jul 2019 18:02:55 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH 10/22] bpf: Disable GCC -fgcse optimization for
 ___bpf_prog_run()
Message-ID: <20190716230255.2o6w3kj6hk33vpiw@treble>
References: <cover.1563150885.git.jpoimboe@redhat.com>
 <1044b4ced755cc3d1d32030cfcf2064f06a9e639.1563150885.git.jpoimboe@redhat.com>
 <CAKwvOdmUfAg9cP4tHV7tXC8PtcumehZ99+wqdcmkTR5a6LORrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdmUfAg9cP4tHV7tXC8PtcumehZ99+wqdcmkTR5a6LORrw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 16 Jul 2019 23:03:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 11:15:54AM -0700, Nick Desaulniers wrote:
> On Sun, Jul 14, 2019 at 5:37 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On x86-64, with CONFIG_RETPOLINE=n, GCC's "global common subexpression
> > elimination" optimization results in ___bpf_prog_run()'s jumptable code
> > changing from this:
> >
> >         select_insn:
> >                 jmp *jumptable(, %rax, 8)
> >                 ...
> >         ALU64_ADD_X:
> >                 ...
> >                 jmp *jumptable(, %rax, 8)
> >         ALU_ADD_X:
> >                 ...
> >                 jmp *jumptable(, %rax, 8)
> >
> > to this:
> >
> >         select_insn:
> >                 mov jumptable, %r12
> >                 jmp *(%r12, %rax, 8)
> >                 ...
> >         ALU64_ADD_X:
> >                 ...
> >                 jmp *(%r12, %rax, 8)
> >         ALU_ADD_X:
> >                 ...
> >                 jmp *(%r12, %rax, 8)
> >
> > The jumptable address is placed in a register once, at the beginning of
> > the function.  The function execution can then go through multiple
> > indirect jumps which rely on that same register value.  This has a few
> > issues:
> >
> > 1) Objtool isn't smart enough to be able to track such a register value
> >    across multiple recursive indirect jumps through the jump table.
> >
> > 2) With CONFIG_RETPOLINE enabled, this optimization actually results in
> >    a small slowdown.  I measured a ~4.7% slowdown in the test_bpf
> >    "tcpdump port 22" selftest.
> >
> >    This slowdown is actually predicted by the GCC manual:
> >
> >      Note: When compiling a program using computed gotos, a GCC
> >      extension, you may get better run-time performance if you
> >      disable the global common subexpression elimination pass by
> >      adding -fno-gcse to the command line.
> >
> > So just disable the optimization for this function.
> >
> > Fixes: e55a73251da3 ("bpf: Fix ORC unwinding in non-JIT BPF code")
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > Acked-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > ---
> >  include/linux/compiler-gcc.h   | 2 ++
> >  include/linux/compiler_types.h | 4 ++++
> >  kernel/bpf/core.c              | 2 +-
> >  3 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> > index e8579412ad21..d7ee4c6bad48 100644
> > --- a/include/linux/compiler-gcc.h
> > +++ b/include/linux/compiler-gcc.h
> > @@ -170,3 +170,5 @@
> >  #else
> >  #define __diag_GCC_8(s)
> >  #endif
> > +
> > +#define __no_fgcse __attribute__((optimize("-fno-gcse")))
> 
> + Miguel, maintainer of compiler_attributes.h
> I wonder if the optimize attributes can be feature detected?
> Is -fno-gcse supported all the way back to GCC 4.6?

Yeah, from snooping in the GCC tree it looks like it's been around
for 18+ years.

-- 
Josh
