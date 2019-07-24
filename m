Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD581C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A9121841
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BTPWbmn2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfGXQze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:55:34 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46742 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfGXQzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:55:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id k189so2478882pgk.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 09:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qtRJ8Les6/fJJOzs6Q1HmSL5jEWwx9CtarW4mGfG+uo=;
        b=BTPWbmn22eLQsf31HdTrv2TJjHIDmoOaHSZBJA7dyaIQbt5PSQyqp5JI2d0hsZNtna
         lZA3mIcRHBU5/IXzk4g3fogGWm3kFZYYsb0oiOADuzmiAhIGFeF7jpO79LypwxjjZzT2
         x0inbJo35MBl+nOoYn9AV9iowaK/wMdnsPQU2gdUsm/9Qr09F+8PTAKbL+qi9G4VkMDc
         0y2yoU9eQfWcdiICcsp6AVWE4bOZa9REJbEEfxTD6aAXU9x+cLt8mdptvVAqRvjqvbJn
         lu3IbrnLImCxCmX8uUJ7X+7CMUlxSz3TokLPq1GApgNIXzPGmRg4rE2Cy7rnfjtfvvjH
         2WDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qtRJ8Les6/fJJOzs6Q1HmSL5jEWwx9CtarW4mGfG+uo=;
        b=ns74xfcaLlqHJCJbrkM0v9FAd/GRYiLx3TJc7MmQgcT/HECL+mzgT1BNZOMYzgmiKO
         BiVe4qg+gRTJty+e6IcO5witM51b6Kf18Zj9VEbrli2NRFSJKFY7nCh5zxF5Gs7Ngzqh
         G+nyFsjiLUhY8rRSlVjcUD/2rkcDYHEeQU7Z3T7J2tQicsNL7v6q4Jr+s2mA50GNJ/X0
         iPIPifVED1xLtvqMJavIJY7Tit0+aRnRxZsGXpjLbX4z3ZoPBTsgagkgpmM8hZ7thicn
         Ndi+hPQT/b3W+x0kHqV+Olz/TM49OiCLrrvOg2h1BjMRJ47KDpGqz/eTbTHQb7hg6Jnk
         MLOw==
X-Gm-Message-State: APjAAAW6llB4xW5qT3w5Q2UCL87GswVsPLB8SiDW/ea+B7iDcwWAf+VB
        lMQ/eN+uvYFiUS00vI4BC3gvYh/zG/++jhnFThwfaQ==
X-Google-Smtp-Source: APXvYqyHceoOKYg0KqQem3avJL09umJctFC8dyr4daJC/ttUQhHRfbz+TLbdwzUCRT5ZsKScHEvokIMzKyBHr15vvXQ=
X-Received: by 2002:a62:2c8e:: with SMTP id s136mr12419121pfs.3.1563987332380;
 Wed, 24 Jul 2019 09:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1907182223560.1785@nanos.tec.linutronix.de>
 <20190724023946.yxsz5im22fz4zxrn@treble> <20190724074732.GJ3402@hirez.programming.kicks-ass.net>
 <20190724125525.kgybu3nnpvwlcz2c@treble> <20190724133516.GB31381@hirez.programming.kicks-ass.net>
 <20190724141040.GA31425@hirez.programming.kicks-ass.net> <20190724164821.GB31425@hirez.programming.kicks-ass.net>
In-Reply-To: <20190724164821.GB31425@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 24 Jul 2019 09:55:21 -0700
Message-ID: <CAKwvOdnvqX4YtOaHL+B+1FOjdq-4tLZGKbs7LYQA4_SPTbdSqg@mail.gmail.com>
Subject: Re: [PATCH] objtool: Improve UACCESS coverage
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 9:48 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jul 24, 2019 at 04:10:40PM +0200, Peter Zijlstra wrote:
> > And that most certainly should trigger...
> >
> > Let me gdb that objtool thing.
>
> ---
> Subject: objtool: Improve UACCESS coverage
>
> A clang build reported an (obvious) double CLAC while a GCC build did
> not; it turns out we only re-visit instructions if the first visit was
> with AC=0. If OTOH the first visit was with AC=1, we completely ignore
> any subsequent visit, even when it has AC=0.
>
> Fix this by using a visited mask, instead of boolean and (explicitly)
> mark the AC state.
>
> $ ./objtool check -b --no-fp --retpoline --uaccess ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o
> ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x22: redundant UACCESS disable
> ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   eb_copy_relocations.isra.34()+0xea: (alt)
> ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   .altinstr_replacement+0xffffffffffffffff: (branch)
> ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   eb_copy_relocations.isra.34()+0xd9: (alt)
> ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   eb_copy_relocations.isra.34()+0xb2: (branch)
> ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   eb_copy_relocations.isra.34()+0x39: (branch)
> ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   eb_copy_relocations.isra.34()+0x0: <=== (func)
>
> Reported-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Tested-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  tools/objtool/check.c | 7 ++++---
>  tools/objtool/check.h | 3 ++-
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 5f26620f13f5..176f2f084060 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -1946,6 +1946,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>         struct alternative *alt;
>         struct instruction *insn, *next_insn;
>         struct section *sec;
> +       u8 visited;
>         int ret;
>
>         insn = first;
> @@ -1972,12 +1973,12 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>                         return 1;
>                 }
>
> +               visited = 1 << state.uaccess;
>                 if (insn->visited) {
>                         if (!insn->hint && !insn_state_match(insn, &state))
>                                 return 1;
>
> -                       /* If we were here with AC=0, but now have AC=1, go again */
> -                       if (insn->state.uaccess || !state.uaccess)
> +                       if (insn->visited & visited)
>                                 return 0;
>                 }
>
> @@ -2024,7 +2025,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>                 } else
>                         insn->state = state;
>
> -               insn->visited = true;
> +               insn->visited |= visited;
>
>                 if (!insn->ignore_alts) {
>                         bool skip_orig = false;
> diff --git a/tools/objtool/check.h b/tools/objtool/check.h
> index b881fafcf55d..6d875ca6fce0 100644
> --- a/tools/objtool/check.h
> +++ b/tools/objtool/check.h
> @@ -33,8 +33,9 @@ struct instruction {
>         unsigned int len;
>         enum insn_type type;
>         unsigned long immediate;
> -       bool alt_group, visited, dead_end, ignore, hint, save, restore, ignore_alts;
> +       bool alt_group, dead_end, ignore, hint, save, restore, ignore_alts;
>         bool retpoline_safe;
> +       u8 visited;
>         struct symbol *call_dest;
>         struct instruction *jump_dest;
>         struct instruction *first_jump_src;



-- 
Thanks,
~Nick Desaulniers
