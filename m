Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F191C282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 06:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3696C20879
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 06:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfEWGsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 02:48:24 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34629 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfEWGsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 02:48:23 -0400
Received: by mail-io1-f65.google.com with SMTP id g84so3993714ioa.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 23:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4uQOlqrYqfub5rCDYjNxrdl9e2pbaXo8ryrZOfrvSAQ=;
        b=ewhI6BqWDi7RHeJtsMHtO/HHLdB04CQ/DVW6wQnvOyFQdFUq21A0TbOQ+xfOM4fEyF
         s9ndptTx/p7u0QGbl4tO/DKCxbSP+zIbnw5ESmCv7vIvI9mSNEj5Hls+RWaigCY+Lp1u
         mQgfjjWjWRWlHeDvMWR9qWn7urwPEXp5isuNDjq8h6j31URE7G4cIK7SS8LxJ/hS5vzT
         gvcXRB3sM4DTDy2en8CF1eI/n5o2lOAalvFg1OqYIT7xSf2XNYnP+qaWXZdp8AyKr7Gi
         QIVFFCoLhD8y1HtHGuoEeLiEZ3oEJ4fx0/kLx9fEXaBYMsOY5aU/aIOZkNSLX7Sr7EDj
         woGg==
X-Gm-Message-State: APjAAAUgEV4zw2gXLJg056pRAqTttRNffVP6PJmEx9H7zB/O1RqOUQL2
        jjXlmVG0wJFN+WEJYR38zAC3a3gWJaYDL6MtcI6Aew==
X-Google-Smtp-Source: APXvYqymIyKP5K9N6DXsop7uthlqjpC73NDwkxxh/ZvGp95fTygap7sT94AttSaauXURiOydXLtlzH9E6RTJ2WzNH80=
X-Received: by 2002:a5d:9c85:: with SMTP id p5mr33369424iop.13.1558594103032;
 Wed, 22 May 2019 23:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <3CD3EE63-0CD2-404A-A403-E11DCF2DF8D9@fb.com> <20190517074600.GJ2623@hirez.programming.kicks-ass.net>
 <20190517081057.GQ2650@hirez.programming.kicks-ass.net> <CACPcB9cB5n1HOmZcVpusJq8rAV5+KfmZ-Lxv3tgsSoy7vNrk7w@mail.gmail.com>
 <20190517091044.GM2606@hirez.programming.kicks-ass.net> <CACPcB9cpNp5CBqoRs+XMCwufzAFa8Pj-gbmj9fb+g5wVdue=ig@mail.gmail.com>
 <20190522140233.GC16275@worktop.programming.kicks-ass.net>
 <ab047883-69f6-1175-153f-5ad9462c6389@fb.com> <20190522174517.pbdopvookggen3d7@treble>
 <20190522234635.a47bettklcf5gt7c@treble>
In-Reply-To: <20190522234635.a47bettklcf5gt7c@treble>
From:   Kairui Song <kasong@redhat.com>
Date:   Thu, 23 May 2019 14:48:11 +0800
Message-ID: <CACPcB9dRJ89YAMDQdKoDMU=vFfpb5AaY0mWC_Xzw1ZMTFBf6ng@mail.gmail.com>
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

On Thu, May 23, 2019 at 7:46 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Wed, May 22, 2019 at 12:45:17PM -0500, Josh Poimboeuf wrote:
> > On Wed, May 22, 2019 at 02:49:07PM +0000, Alexei Starovoitov wrote:
> > > The one that is broken is prog_tests/stacktrace_map.c
> > > There we attach bpf to standard tracepoint where
> > > kernel suppose to collect pt_regs before calling into bpf.
> > > And that's what bpf_get_stackid_tp() is doing.
> > > It passes pt_regs (that was collected before any bpf)
> > > into bpf_get_stackid() which calls get_perf_callchain().
> > > Same thing with kprobes, uprobes.
> >
> > Is it trying to unwind through ___bpf_prog_run()?
> >
> > If so, that would at least explain why ORC isn't working.  Objtool
> > currently ignores that function because it can't follow the jump table.
>
> Here's a tentative fix (for ORC, at least).  I'll need to make sure this
> doesn't break anything else.
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 242a643af82f..1d9a7cc4b836 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1562,7 +1562,6 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
>                 BUG_ON(1);
>                 return 0;
>  }
> -STACK_FRAME_NON_STANDARD(___bpf_prog_run); /* jump table */
>
>  #define PROG_NAME(stack_size) __bpf_prog_run##stack_size
>  #define DEFINE_BPF_PROG_RUN(stack_size) \
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 172f99195726..2567027fce95 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -1033,13 +1033,6 @@ static struct rela *find_switch_table(struct objtool_file *file,
>                 if (text_rela->type == R_X86_64_PC32)
>                         table_offset += 4;
>
> -               /*
> -                * Make sure the .rodata address isn't associated with a
> -                * symbol.  gcc jump tables are anonymous data.
> -                */
> -               if (find_symbol_containing(rodata_sec, table_offset))
> -                       continue;
> -
>                 rodata_rela = find_rela_by_dest(rodata_sec, table_offset);
>                 if (rodata_rela) {
>                         /*

Hi Josh, this still won't fix the problem.

Problem is not (or not only) with ___bpf_prog_run, what actually went
wrong is with the JITed bpf code.

For frame pointer unwinder, it seems the JITed bpf code will have a
shifted "BP" register? (arch/x86/net/bpf_jit_comp.c:217), so if we can
unshift it properly then it will work.

I tried below code, and problem is fixed (only for frame pointer
unwinder though). Need to find a better way to detect and do any
similar trick for bpf part, if this is a feasible way to fix it:

diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_frame.c
index 9b9fd4826e7a..2c0fa2aaa7e4 100644
--- a/arch/x86/kernel/unwind_frame.c
+++ b/arch/x86/kernel/unwind_frame.c
@@ -330,8 +330,17 @@ bool unwind_next_frame(struct unwind_state *state)
        }

        /* Move to the next frame if it's safe: */
-       if (!update_stack_state(state, next_bp))
-               goto bad_address;
+       if (!update_stack_state(state, next_bp)) {
+               // Try again with shifted BP
+               state->bp += 5; // see AUX_STACK_SPACE
+               next_bp = (unsigned long
*)READ_ONCE_TASK_STACK(state->task, *state->bp);
+               // Clean and refetch stack info, it's marked as error outed
+               state->stack_mask = 0;
+               get_stack_info(next_bp, state->task,
&state->stack_info, &state->stack_mask);
+               if (!update_stack_state(state, next_bp)) {
+                       goto bad_address;
+               }
+       }

        return true;

For ORC unwinder, I think the unwinder can't find any info about the
JITed part. Maybe if can let it just skip the JITed part and go to
kernel context, then should be good enough.





--
Best Regards,
Kairui Song
