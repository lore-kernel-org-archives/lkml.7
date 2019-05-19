Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CAEC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 18:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA29D20578
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 18:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbfESSHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 14:07:30 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:40252 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729552AbfESSH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 14:07:29 -0400
Received: by mail-it1-f196.google.com with SMTP id g71so19615342ita.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 11:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7S1JiY5XMndUySOPpCBhO3vugzf338c54HkvkOEdUI=;
        b=Lj5W4lPyxHETuoM6XjTL2ZdKowHojfbzwCsVBvZMh9MqsV+oal3A8yDMlxLUqw5msL
         +6JEFnLOyRK3zH3ytEn3c11iMaJn/RlOI7lUvRrIWRpnWBh14Pxklmw2Q5m3Y2DmPDhW
         SK2ZDQum94izdLXpaF76VDeqQDMS12L7h5fmv2nLEPGi5PlTSqabX55kDrHT54vB+T3u
         xCfAYzISmdv7QZAwvkE4kwScOVQBjzNAnRECbqrjut9q5cTW5v/oI63I3Vr1J/WrgLtW
         77Cpp5DsmpDeHlBEf9tvLF888jw/myWZq9CTpfGhf5JhrOEYzucOQnRvOmy+lrRZhbRe
         DOgA==
X-Gm-Message-State: APjAAAWgzOAXtkadVwtWTEu19BAy1Uer7DpoFpmD/ltxJEJvJKNZkixJ
        7Gm8FCTTXThVvHeNPdH/bPqytfQwXcTMQIXpmsvk6w==
X-Google-Smtp-Source: APXvYqzP5hoR7AStmML42U8uNCorWch+uTjHRCykkRZbdO5pXKwP6oCjkjO5vOQkA/sKjCaQPRa48D4ntAa22XdygUI=
X-Received: by 2002:a24:7a90:: with SMTP id a138mr25523149itc.95.1558289248398;
 Sun, 19 May 2019 11:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <3CD3EE63-0CD2-404A-A403-E11DCF2DF8D9@fb.com> <20190517074600.GJ2623@hirez.programming.kicks-ass.net>
 <20190517081057.GQ2650@hirez.programming.kicks-ass.net> <CACPcB9cB5n1HOmZcVpusJq8rAV5+KfmZ-Lxv3tgsSoy7vNrk7w@mail.gmail.com>
 <20190517091044.GM2606@hirez.programming.kicks-ass.net> <8C814E68-B0B6-47E4-BDD6-917B01EC62D0@fb.com>
 <c881767d-b6f3-c53e-5c70-556d09ea8d89@fb.com> <8449BBF3-E754-4ABC-BFEF-A8F264297F2D@fb.com>
In-Reply-To: <8449BBF3-E754-4ABC-BFEF-A8F264297F2D@fb.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Mon, 20 May 2019 02:07:19 +0800
Message-ID: <CACPcB9emh9T23sixx-91mg2wL6kgrYF4MVfmuTCE0SsD=8efcQ@mail.gmail.com>
Subject: Re: Getting empty callchain from perf_callchain_kernel()
To:     Song Liu <songliubraving@fb.com>
Cc:     Alexei Starovoitov <ast@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 18, 2019 at 5:48 AM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On May 17, 2019, at 2:06 PM, Alexei Starovoitov <ast@fb.com> wrote:
> >
> > On 5/17/19 11:40 AM, Song Liu wrote:
> >> +Alexei, Daniel, and bpf
> >>
> >>> On May 17, 2019, at 2:10 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> >>>
> >>> On Fri, May 17, 2019 at 04:15:39PM +0800, Kairui Song wrote:
> >>>> Hi, I think the actual problem is that bpf_get_stackid_tp (and maybe
> >>>> some other bfp functions) is now broken, or, strating an unwind
> >>>> directly inside a bpf program will end up strangely. It have following
> >>>> kernel message:
> >>>
> >>> Urgh, what is that bpf_get_stackid_tp() doing to get the regs? I can't
> >>> follow.
> >>
> >> I guess we need something like the following? (we should be able to
> >> optimize the PER_CPU stuff).
> >>
> >> Thanks,
> >> Song
> >>
> >>
> >> diff --git i/kernel/trace/bpf_trace.c w/kernel/trace/bpf_trace.c
> >> index f92d6ad5e080..c525149028a7 100644
> >> --- i/kernel/trace/bpf_trace.c
> >> +++ w/kernel/trace/bpf_trace.c
> >> @@ -696,11 +696,13 @@ static const struct bpf_func_proto bpf_perf_event_output_proto_tp = {
> >>         .arg5_type      = ARG_CONST_SIZE_OR_ZERO,
> >>  };
> >>
> >> +static DEFINE_PER_CPU(struct pt_regs, bpf_stackid_tp_regs);
> >>  BPF_CALL_3(bpf_get_stackid_tp, void *, tp_buff, struct bpf_map *, map,
> >>            u64, flags)
> >>  {
> >> -       struct pt_regs *regs = *(struct pt_regs **)tp_buff;
> >> +       struct pt_regs *regs = this_cpu_ptr(&bpf_stackid_tp_regs);
> >>
> >> +       perf_fetch_caller_regs(regs);
> >
> > No. pt_regs is already passed in. It's the first argument.
> > If we call perf_fetch_caller_regs() again the stack trace will be wrong.
> > bpf prog should not see itself, interpreter or all the frames in between.
>
> Thanks Alexei! I get it now.
>
> In bpf_get_stackid_tp(), the pt_regs is get by dereferencing the first field
> of tp_buff:
>
>         struct pt_regs *regs = *(struct pt_regs **)tp_buff;
>
> tp_buff points to something like
>
>         struct sched_switch_args {
>                 unsigned long long pad;
>                 char prev_comm[16];
>                 int prev_pid;
>                 int prev_prio;
>                 long long prev_state;
>                 char next_comm[16];
>                 int next_pid;
>                 int next_prio;
>         };
>
> where the first field "pad" is a pointer to pt_regs.
>
> @Kairui, I think you confirmed that current code will give empty call trace
> with ORC unwinder? If that's the case, can we add regs->ip back? (as in the
> first email of this thread.
>
> Thanks,
> Song
>

Hi thanks for the suggestion, yes we can add it should be good an idea
to always have IP when stack trace is not available.
But stack trace is actually still broken, it will always give only one
level of stacktrace (the IP).

-- 
Best Regards,
Kairui Song
