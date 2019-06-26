Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75768C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8B92183F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fIMR7D57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfFZQb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 12:31:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37220 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfFZQbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 12:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K6GM20Sjlcpa53T5ol2yNh7EWFpyKggKBswitXSEOg4=; b=fIMR7D57/qq7CZ0w47lXiEAtp
        HW7ySd5Ansu8NUsr6aQNqXdPSCWfyAPOpMDHPZYWku9omzeBDHETeqZanh1mvwOF5nbQlIwd+QNJ4
        v717E9r6Olyo2bKQkbmiwGkqYucSLFgZo6v9T0QMa9Unw/216EXNdAsG1hG9FkSYW3AJJZkWS2eHR
        ribaReaj6lI+jwMQDGlmNzc2PIo5R2Sr+emQKjvs/w+D1RrTGHG263RmYYYyYWTDE247hu/8PhOgo
        85VYpbp+rAGmxs0BaPG9NPwr6jqdzpiqQJjpdbXncoelsMnTzCuMMhHGQMALn7V4K7REU9I7l32tw
        PWAqQ839Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgAp1-0004Qp-BK; Wed, 26 Jun 2019 16:30:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 67A96209CEDB5; Wed, 26 Jun 2019 18:30:57 +0200 (CEST)
Date:   Wed, 26 Jun 2019 18:30:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Joe Perches <joe@perches.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Landden <shawn@git.icu>,
        clang-built-linux@googlegroups.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
Message-ID: <20190626163057.GN3419@hirez.programming.kicks-ass.net>
References: <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com>
 <20190624203737.GL3436@hirez.programming.kicks-ass.net>
 <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
 <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
 <20190625071846.GN3436@hirez.programming.kicks-ass.net>
 <201906251009.BCB7438@keescook>
 <20190625180525.GA119831@archlinux-epyc>
 <alpine.DEB.2.21.1906252127290.32342@nanos.tec.linutronix.de>
 <20190625202746.GA83499@archlinux-epyc>
 <alpine.DEB.2.21.1906252255440.32342@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906252255440.32342@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 11:47:06PM +0200, Thomas Gleixner wrote:
> > On Tue, Jun 25, 2019 at 09:53:09PM +0200, Thomas Gleixner wrote:

> > > but it also makes objtool unhappy:

> > >  arch/x86/kernel/cpu/mtrr/generic.o: warning: objtool: get_fixed_ranges()+0x9b: unreachable instruction

> I just checked two of them in the disassembly. In both cases it's jump
> label related. Here is one:
> 
>       asm volatile("1: rdmsr\n"
>  410:   b9 59 02 00 00          mov    $0x259,%ecx
>  415:   0f 32                   rdmsr
>  417:   49 89 c6                mov    %rax,%r14
>  41a:   48 89 d3                mov    %rdx,%rbx
>       return EAX_EDX_VAL(val, low, high);
>  41d:   48 c1 e3 20             shl    $0x20,%rbx
>  421:   48 09 c3                or     %rax,%rbx
>  424:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>  429:   eb 0f                   jmp    43a <get_fixed_ranges+0xaa>
>       do_trace_read_msr(msr, val, 0);
>  42b:   bf 59 02 00 00          mov    $0x259,%edi   <------- "unreachable"
>  430:   48 89 de                mov    %rbx,%rsi
>  433:   31 d2                   xor    %edx,%edx
>  435:   e8 00 00 00 00          callq  43a <get_fixed_ranges+0xaa>
>  43a:   44 89 35 00 00 00 00    mov    %r14d,0x0(%rip)        # 441 <get_fixed_ranges+0xb1>

Thomas provided the actual .o file, and from that we find that the
.rela__jump_table entries look like:

000000000010  000100000002 R_X86_64_PC32     0000000000000000 .text + 3e9
000000000014  000100000002 R_X86_64_PC32     0000000000000000 .text + 3f0
000000000018  006100000018 R_X86_64_PC64     0000000000000000 __tracepoint_read_msr + 8
000000000020  000100000002 R_X86_64_PC32     0000000000000000 .text + 424
000000000024  000100000002 R_X86_64_PC32     0000000000000000 .text + 3f0
000000000028  006100000018 R_X86_64_PC64     0000000000000000 __tracepoint_read_msr + 8

From this we find that the jump target that goes with the NOP at +424 is
+3f0, not +42b as one would expect.

And as Josh noted, it is also 'weird' that this +3f0 is the very same as
the target for the previous entry.

When we compare the code at both sites, we find:

3f0:       bf 58 02 00 00          mov    $0x258,%edi
3f5:       48 89 de                mov    %rbx,%rsi
3f8:       31 d2                   xor    %edx,%edx
3fa:       e8 00 00 00 00          callq  3ff <get_fixed_ranges+0x6f>
		3fb: R_X86_64_PC32      do_trace_read_msr-0x4

vs

42b:       bf 59 02 00 00          mov    $0x259,%edi
430:       48 89 de                mov    %rbx,%rsi
433:       31 d2                   xor    %edx,%edx
435:       e8 00 00 00 00          callq  43a <get_fixed_ranges+0xaa>
		436: R_X86_64_PC32      do_trace_read_msr-0x4

Which is not in fact the same code.

So for some reason the .rela__jump_table are buggy on this clang build.

