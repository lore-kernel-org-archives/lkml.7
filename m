Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464FAC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A261206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbfEWOui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 10:50:38 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38453 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730709AbfEWOuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 10:50:37 -0400
Received: by mail-io1-f65.google.com with SMTP id x24so5062061ion.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 07:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HMbKP8ol8uS26+YktTCfpu4N0fIbBCyB3gtFH0FLV6k=;
        b=EsM5gx8vZ1ntnJ8k9dIf4Iz+Y/Ef8KNBso467M1zIF9d//1N0mTs7BBGQR/gj4GXmo
         G0JmUGUbl2rvumNuoejrazg4MiZKSyU4Vy9Ex0z8ZnEXLCGPuRI105jxMD0eVjN0QU7t
         r1FcqYCNa9dGTNwum7UQAwJXon+KP9Tg1xRdbdWT7zw01mXuZAgoH2XkTpfTNOkRFIqo
         nAuFxZxGrDPK5PMalnfKBE+SyRRoncnroIV1FTNP8LACzgtSGejAsT0YXKzIyLO8Ft74
         FYKs6HhE/osaIS8SM9WDzBzWf34Cd2JnKLdiTLcFHOl7sKoEUU13twCfXNj8EbYxM+C9
         sA9Q==
X-Gm-Message-State: APjAAAXbGpqof6EJcEVZ0r848xzeGest5cq+/fKc9l2D1m8oU57QZUPq
        h7uzQug8VISnaYxWQnAW8rtdVOPu1NxG6PHulXQZYg==
X-Google-Smtp-Source: APXvYqzEuGMFvzF0nHEDHc1fFCLq49ou/KfTZjKOivp3GV7q9ttzWr1E/qEdb+uxM9tuyVBgHFL7/zsd1neA/aOgt8E=
X-Received: by 2002:a05:6602:211a:: with SMTP id x26mr3328966iox.202.1558623036527;
 Thu, 23 May 2019 07:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190517074600.GJ2623@hirez.programming.kicks-ass.net>
 <20190517081057.GQ2650@hirez.programming.kicks-ass.net> <CACPcB9cB5n1HOmZcVpusJq8rAV5+KfmZ-Lxv3tgsSoy7vNrk7w@mail.gmail.com>
 <20190517091044.GM2606@hirez.programming.kicks-ass.net> <CACPcB9cpNp5CBqoRs+XMCwufzAFa8Pj-gbmj9fb+g5wVdue=ig@mail.gmail.com>
 <20190522140233.GC16275@worktop.programming.kicks-ass.net>
 <ab047883-69f6-1175-153f-5ad9462c6389@fb.com> <20190522174517.pbdopvookggen3d7@treble>
 <20190522234635.a47bettklcf5gt7c@treble> <CACPcB9dRJ89YAMDQdKoDMU=vFfpb5AaY0mWC_Xzw1ZMTFBf6ng@mail.gmail.com>
 <20190523133253.tad6ywzzexks6hrp@treble>
In-Reply-To: <20190523133253.tad6ywzzexks6hrp@treble>
From:   Kairui Song <kasong@redhat.com>
Date:   Thu, 23 May 2019 22:50:24 +0800
Message-ID: <CACPcB9fQKg7xhzhCZaF4UGi=EQs1HLTFgg-C_xJQaUfho3yMyA@mail.gmail.com>
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

On Thu, May 23, 2019 at 9:32 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Thu, May 23, 2019 at 02:48:11PM +0800, Kairui Song wrote:
> > On Thu, May 23, 2019 at 7:46 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > On Wed, May 22, 2019 at 12:45:17PM -0500, Josh Poimboeuf wrote:
> > > > On Wed, May 22, 2019 at 02:49:07PM +0000, Alexei Starovoitov wrote:
> > > > > The one that is broken is prog_tests/stacktrace_map.c
> > > > > There we attach bpf to standard tracepoint where
> > > > > kernel suppose to collect pt_regs before calling into bpf.
> > > > > And that's what bpf_get_stackid_tp() is doing.
> > > > > It passes pt_regs (that was collected before any bpf)
> > > > > into bpf_get_stackid() which calls get_perf_callchain().
> > > > > Same thing with kprobes, uprobes.
> > > >
> > > > Is it trying to unwind through ___bpf_prog_run()?
> > > >
> > > > If so, that would at least explain why ORC isn't working.  Objtool
> > > > currently ignores that function because it can't follow the jump table.
> > >
> > > Here's a tentative fix (for ORC, at least).  I'll need to make sure this
> > > doesn't break anything else.
> > >
> > > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > > index 242a643af82f..1d9a7cc4b836 100644
> > > --- a/kernel/bpf/core.c
> > > +++ b/kernel/bpf/core.c
> > > @@ -1562,7 +1562,6 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
> > >                 BUG_ON(1);
> > >                 return 0;
> > >  }
> > > -STACK_FRAME_NON_STANDARD(___bpf_prog_run); /* jump table */
> > >
> > >  #define PROG_NAME(stack_size) __bpf_prog_run##stack_size
> > >  #define DEFINE_BPF_PROG_RUN(stack_size) \
> > > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > > index 172f99195726..2567027fce95 100644
> > > --- a/tools/objtool/check.c
> > > +++ b/tools/objtool/check.c
> > > @@ -1033,13 +1033,6 @@ static struct rela *find_switch_table(struct objtool_file *file,
> > >                 if (text_rela->type == R_X86_64_PC32)
> > >                         table_offset += 4;
> > >
> > > -               /*
> > > -                * Make sure the .rodata address isn't associated with a
> > > -                * symbol.  gcc jump tables are anonymous data.
> > > -                */
> > > -               if (find_symbol_containing(rodata_sec, table_offset))
> > > -                       continue;
> > > -
> > >                 rodata_rela = find_rela_by_dest(rodata_sec, table_offset);
> > >                 if (rodata_rela) {
> > >                         /*
> >
> > Hi Josh, this still won't fix the problem.
> >
> > Problem is not (or not only) with ___bpf_prog_run, what actually went
> > wrong is with the JITed bpf code.
>
> There seem to be a bunch of issues.  My patch at least fixes the failing
> selftest reported by Alexei for ORC.
>
> How can I recreate your issue?

Hmm, I used bcc's example to attach bpf to trace point, and with that
fix stack trace is still invalid.

CMD I used with bcc:
python3 ./tools/stackcount.py t:sched:sched_fork

And I just had another try applying your patch, self test is also failing.

I'm applying on my local master branch, a few days older than
upstream, I can update and try again, am I missing anything?

>
> > For frame pointer unwinder, it seems the JITed bpf code will have a
> > shifted "BP" register? (arch/x86/net/bpf_jit_comp.c:217), so if we can
> > unshift it properly then it will work.
>
> Yeah, that looks like a frame pointer bug in emit_prologue().
>
> > I tried below code, and problem is fixed (only for frame pointer
> > unwinder though). Need to find a better way to detect and do any
> > similar trick for bpf part, if this is a feasible way to fix it:
> >
> > diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_frame.c
> > index 9b9fd4826e7a..2c0fa2aaa7e4 100644
> > --- a/arch/x86/kernel/unwind_frame.c
> > +++ b/arch/x86/kernel/unwind_frame.c
> > @@ -330,8 +330,17 @@ bool unwind_next_frame(struct unwind_state *state)
> >         }
> >
> >         /* Move to the next frame if it's safe: */
> > -       if (!update_stack_state(state, next_bp))
> > -               goto bad_address;
> > +       if (!update_stack_state(state, next_bp)) {
> > +               // Try again with shifted BP
> > +               state->bp += 5; // see AUX_STACK_SPACE
> > +               next_bp = (unsigned long
> > *)READ_ONCE_TASK_STACK(state->task, *state->bp);
> > +               // Clean and refetch stack info, it's marked as error outed
> > +               state->stack_mask = 0;
> > +               get_stack_info(next_bp, state->task,
> > &state->stack_info, &state->stack_mask);
> > +               if (!update_stack_state(state, next_bp)) {
> > +                       goto bad_address;
> > +               }
> > +       }
> >
> >         return true;
>
> Nack.
>
> > For ORC unwinder, I think the unwinder can't find any info about the
> > JITed part. Maybe if can let it just skip the JITed part and go to
> > kernel context, then should be good enough.
>
> If it's starting from a fake pt_regs then that's going to be a
> challenge.
>
> Will the JIT code always have the same stack layout?  If so then we
> could hard code that knowledge in ORC.  Or even better, create a generic
> interface for ORC to query the creator of the generated code about the
> stack layout.

I think yes.

Not sure why we have the BP shift yet, if the prolog code could be
tweaked to work with frame pointer unwinder it will be good to have.
But still not for ORC.

Will it be a good idea to have a region reserved for the JITed code?
Currently it shares the region with "module mapping space". If let it
have a separate region, when the unwinder meet any code in that region
it will know it's JITed code and then can do something special about
it.

This should make it much easier for both frame pointer and ORC unwinder to work.

-- 
Best Regards,
Kairui Song
