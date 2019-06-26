Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77A2C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD86821738
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hD/qi+Fg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfFZWdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 18:33:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39223 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfFZWdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 18:33:49 -0400
Received: by mail-pf1-f196.google.com with SMTP id j2so163570pfe.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 15:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=98AIeuf64pS4NOIpGvl5Gpir53W1mq1U+DjL1WP4pkE=;
        b=hD/qi+FgQTzTbKOKOdeQVPptB16EeAt0ImXWrRv4NmT6ssAA9mc1zXlzuYkW/e0hrh
         G+rCJYx5W/nZzHFdwlhO9S+aacDUruHI9BDERDGt/TxuGQGpNjG0+vAg7hER9C1DXz93
         Z7UVlQkN03qSg0GRxV3b7O+UjMulH8Hw7jeiEBiWNeVPGZx+xPrQkbKUkrH1VfqNGRc4
         UNdR5wTVAEbw573qOjw++ntekOiN5RAL70KNgdBknr52uT732o9FRcyZ2prSvtcN+L8+
         FX7g5b86BC/T80hpz9G02U6ljs/RiDjBAV2rDX3uhO0kfn5z1IE45YBPZhzyVYzMtG/Z
         imJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=98AIeuf64pS4NOIpGvl5Gpir53W1mq1U+DjL1WP4pkE=;
        b=htiNPIOgy/oP3iVwI6aW5wLGL5UqKxIL+DXWvLcA6KbQHjtF1Lg4wYwnW3I1UbuMV/
         LPV0aKpoAGWJTYXBIp0qoUaF4dcNmnm55mqvg4+P6BSCV9OfVbTuxI1Q7lf6HR6ot8oP
         LYMVHZj9+ExuQdQN5gcoIUnL5jkWRrcUy1bP5k1rUy4HxvyY3skiPMXiTK8zz2hMbRk5
         Mp3GeMOTlLlPswck0dEUP9tmJ4dtlfaQpCGrZLUkfaEDNnyFAbsEuA3WiCxyl6/BE3o3
         ub+9iNqDzhDPYfdynJe5gNSAcEVKAR/+0+B0/80wIxDXV0Ox/wiHN2zZHO7jx22QQSpr
         lE6g==
X-Gm-Message-State: APjAAAUohdQp7PlFbz70MmW2vzNpgLeRAKz6VKloZjVfqGIR/yEQdNfG
        NROPnRw8zudfd9ekm0hRQQ5ULJD0zW9OJv880Eiltg==
X-Google-Smtp-Source: APXvYqzR++RNAV4JIZfSHIpOdZPw2IfN9cCZIjNxjRT+xt6oBwPTjeyxQXO3eZL+OI0iSegMFcjKzxoSLDNCs737nuE=
X-Received: by 2002:a17:90a:2488:: with SMTP id i8mr1679268pje.123.1561588427372;
 Wed, 26 Jun 2019 15:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com>
 <20190624203737.GL3436@hirez.programming.kicks-ass.net> <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
 <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
 <20190625071846.GN3436@hirez.programming.kicks-ass.net> <201906251009.BCB7438@keescook>
 <20190625180525.GA119831@archlinux-epyc> <alpine.DEB.2.21.1906252127290.32342@nanos.tec.linutronix.de>
 <20190625202746.GA83499@archlinux-epyc> <alpine.DEB.2.21.1906252255440.32342@nanos.tec.linutronix.de>
 <20190626163057.GN3419@hirez.programming.kicks-ass.net>
In-Reply-To: <20190626163057.GN3419@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 26 Jun 2019 15:33:36 -0700
Message-ID: <CAKwvOdnvKLs1oF0-G8iq2T4wqcVkBGRKiZjPbb+K0gDRh3Liww@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
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
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Craig Topper <craig.topper@intel.com>,
        Chandler Carruth <chandlerc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 9:31 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jun 25, 2019 at 11:47:06PM +0200, Thomas Gleixner wrote:
> > > On Tue, Jun 25, 2019 at 09:53:09PM +0200, Thomas Gleixner wrote:
>
> > > > but it also makes objtool unhappy:
>
> > > >  arch/x86/kernel/cpu/mtrr/generic.o: warning: objtool: get_fixed_ranges()+0x9b: unreachable instruction
>
> > I just checked two of them in the disassembly. In both cases it's jump
> > label related. Here is one:
> >
> >       asm volatile("1: rdmsr\n"
> >  410:   b9 59 02 00 00          mov    $0x259,%ecx
> >  415:   0f 32                   rdmsr
> >  417:   49 89 c6                mov    %rax,%r14
> >  41a:   48 89 d3                mov    %rdx,%rbx
> >       return EAX_EDX_VAL(val, low, high);
> >  41d:   48 c1 e3 20             shl    $0x20,%rbx
> >  421:   48 09 c3                or     %rax,%rbx
> >  424:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> >  429:   eb 0f                   jmp    43a <get_fixed_ranges+0xaa>
> >       do_trace_read_msr(msr, val, 0);
> >  42b:   bf 59 02 00 00          mov    $0x259,%edi   <------- "unreachable"

I assume if 0x42b is unreachable, that's bad as $0x259 is never stored
in %edi before the call to get_fixed_ranges+0xaa...

> >  430:   48 89 de                mov    %rbx,%rsi
> >  433:   31 d2                   xor    %edx,%edx
> >  435:   e8 00 00 00 00          callq  43a <get_fixed_ranges+0xaa>
> >  43a:   44 89 35 00 00 00 00    mov    %r14d,0x0(%rip)        # 441 <get_fixed_ranges+0xb1>
>
> Thomas provided the actual .o file, and from that we find that the
> .rela__jump_table entries look like:
>
> 000000000010  000100000002 R_X86_64_PC32     0000000000000000 .text + 3e9
> 000000000014  000100000002 R_X86_64_PC32     0000000000000000 .text + 3f0
> 000000000018  006100000018 R_X86_64_PC64     0000000000000000 __tracepoint_read_msr + 8

I assume these relocations come from arch_static_branch() (and thus
appear in triples?)

 21 static __always_inline bool arch_static_branch(struct static_key
*key, bool branch)
 22 {
 23   asm_volatile_goto("1:"
 24     ".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
 25     ".pushsection __jump_table,  \"aw\" \n\t"
 26     _ASM_ALIGN "\n\t"
 27     ".long 1b - ., %l[l_yes] - . \n\t" // 1, 2
 28     _ASM_PTR "%c0 + %c1 - .\n\t" // 3
 29     ".popsection \n\t"
 30     : :  "i" (key), "i" (branch) : : l_yes);

> 000000000020  000100000002 R_X86_64_PC32     0000000000000000 .text + 424
> 000000000024  000100000002 R_X86_64_PC32     0000000000000000 .text + 3f0
> 000000000028  006100000018 R_X86_64_PC64     0000000000000000 __tracepoint_read_msr + 8
>
> From this we find that the jump target that goes with the NOP at +424 is
> +3f0, not +42b as one would expect.
>
> And as Josh noted, it is also 'weird' that this +3f0 is the very same as
> the target for the previous entry.

(Ok, I think I did talk to Josh about this, and I think he did mention
something about the jump targets, but I didn't really understand the
issue well at the time).

>
> When we compare the code at both sites, we find:
>
> 3f0:       bf 58 02 00 00          mov    $0x258,%edi
> 3f5:       48 89 de                mov    %rbx,%rsi
> 3f8:       31 d2                   xor    %edx,%edx
> 3fa:       e8 00 00 00 00          callq  3ff <get_fixed_ranges+0x6f>
>                 3fb: R_X86_64_PC32      do_trace_read_msr-0x4
>
> vs
>
> 42b:       bf 59 02 00 00          mov    $0x259,%edi
> 430:       48 89 de                mov    %rbx,%rsi
> 433:       31 d2                   xor    %edx,%edx
> 435:       e8 00 00 00 00          callq  43a <get_fixed_ranges+0xaa>
>                 436: R_X86_64_PC32      do_trace_read_msr-0x4
>
> Which is not in fact the same code.
>
> So for some reason the .rela__jump_table are buggy on this clang build.

So that sounds like a correctness bug then. (I'd been doing testing
with the STATIC_KEYS_SELFTEST, which I guess doesn't expose this).
I'm kind of surprised we can boot and pass STATIC_KEYS_SELFTEST.  Any
way you can help us pare down a test case?
-- 
Thanks,
~Nick Desaulniers
