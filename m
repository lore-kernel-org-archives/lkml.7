Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5709C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845F22063F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJHkKfyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfCGHug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 02:50:36 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55103 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfCGHuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 02:50:35 -0500
Received: by mail-it1-f195.google.com with SMTP id w18so13803736itj.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 23:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cJp2eLJMr18ddMbX5NPKvZMB/Q3r4SoGsDE/1Fx/CHM=;
        b=tJHkKfyV8sCdn7Bjy3Ib3UYkvsxEdmQNFPetefvcVozo5PZe5aBjWCmg1RCWPgBdJZ
         SvHPnuKi4mVeaMxqzpaOjOyx+wYfR6YggngzRpJWFcTOklp1hfbcNhWGhsH32bxtvHW9
         0r4CwPNj9xfzfTQMuARnlqI38sT0a6w0FJRZLQanSgqeQI7NYnfThmCRKbtyXkEaYiF+
         qf7P2QqYJUgEE+ynUddv7ExP6F6Zhwyzjj/rWeqew33YBv0PxKicPaib/ZgkN1KehSRc
         OZD+JePNX5dIOoL9f3BS7bsKC/w1LNN5mwDeHE3Lils7T37UyGO8qvVmIiZBJ8+j8Jii
         EK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cJp2eLJMr18ddMbX5NPKvZMB/Q3r4SoGsDE/1Fx/CHM=;
        b=ftV817EunAzGYiqC3tSAmiRjUJ+kUEL11FrKgfuSJPvDADpfv0EG+FabkM88VxU4XS
         OGzd0CM3SAmJv+e0fxHeVyiXh9cZYt5QM1iLqYNsxH/f0DrdNgQuB00k5e/uJf5nS69z
         P4Hd35YVtAEmTTQHwiuWDaRY7tnh+t8mdHeXlItOWpFwHC5f1ErVIA/wpUNR1h5d3uEy
         bDgClgsdnRgYVy+biVJOx3Jm1lPCnY+PTpC30FnIMYr+zEJ2u+5IffbDSpGdRw5MJQSd
         +lhPIy2Rw0bMx8RX1PHh81DHlMNWOJdUTsDyjck7UqkOlAe58r4qbb7GGT7zXJ0e8cKA
         w0Xw==
X-Gm-Message-State: APjAAAUW8g1FoRNRGlKeQuGUV2aVpN/raUdsQ83XQOQTZ1xbtbZ1PR+p
        OFQzAR1FslitlYx5O/WaDWFCc8qhgBe+KFraIsN6rtIg
X-Google-Smtp-Source: APXvYqwDOkNZB6TKyRRnSpxKJACeeUzCIn8ERbyzpQFcbbRIrzu/JmjbXaIWGOmFYFjydUByikVBfC/nRbXM3IDfE7o=
X-Received: by 2002:a02:393:: with SMTP id e19mr7014397jae.95.1551945034323;
 Wed, 06 Mar 2019 23:50:34 -0800 (PST)
MIME-Version: 1.0
References: <1551861826-12592-1-git-send-email-laoar.shao@gmail.com>
 <20190306100907.GT32477@hirez.programming.kicks-ass.net> <CALOAHbC1zqzU8-ikcLOUMKY5cbyuW_B6MK5rz7G6rTK-SoyMTQ@mail.gmail.com>
 <20190306112707.GU32477@hirez.programming.kicks-ass.net> <CALOAHbB7EZ83R3gHcGa9oZWq=7CEgBkL2cXav_7N13u4U44+uA@mail.gmail.com>
 <20190306123834.GW32494@hirez.programming.kicks-ass.net> <CALOAHbBDArxamap+TsWXy227N-UOsKVDA-HkGVF1M0O2Fk8qEg@mail.gmail.com>
In-Reply-To: <CALOAHbBDArxamap+TsWXy227N-UOsKVDA-HkGVF1M0O2Fk8qEg@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 7 Mar 2019 15:49:58 +0800
Message-ID: <CALOAHbAC-aev3s_n+byWMyeoBo8knFdbKUcXUjsbM3D8iFRWOQ@mail.gmail.com>
Subject: Re: [PATCH] sched: fair: fix missed CONFIG_SCHEDSTATS
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        shaoyafang@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 8:53 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> On Wed, Mar 6, 2019 at 8:38 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Mar 06, 2019 at 07:49:36PM +0800, Yafang Shao wrote:
> >
> >
> > $ grep SCHEDSTAT defconfig-build/.config
> > # CONFIG_SCHEDSTATS is not set
> > $ obbjdump -dr defconfig-build/kernel/sched/fair.o | awk '/>:$/ { F=$2 } /sched_stat/ { print F " " $0 }'
> > <update_curr>:                  24cd: R_X86_64_32S      __tracepoint_sched_stat_runtime+0x28
> > <update_curr>:                  24d9: R_X86_64_PC32     __tracepoint_sched_stat_runtime+0x24
> > $ patch -p1 < foo
> > patching file kernel/sched/fair.c
> > $ make O=defconfig-build kernel/sched/
> > make[1]: Entering directory '/usr/src/linux-2.6/defconfig-build'
> > Using .. as source for kernel
> > GEN     Makefile
> > CALL    ../scripts/checksyscalls.sh
> > CALL    ../scripts/atomic/check-atomics.sh
> > DESCEND  objtool
> > CC      kernel/sched/fair.o
> > AR      kernel/sched/built-in.a
> > make[1]: Leaving directory '/usr/src/linux-2.6/defconfig-build'
> > $ objdump -dr defconfig-build/kernel/sched/fair.o | awk '/>:$/ { F=$2 } /sched_stat/ { print F " " $0 }'
> > $ cat foo
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 8213ff6e365d..6e5ceec3b662 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -839,7 +839,8 @@ static void update_curr(struct cfs_rq *cfs_rq)
> >         if (entity_is_task(curr)) {
> >                 struct task_struct *curtask = task_of(curr);
> >
> > -               trace_sched_stat_runtime(curtask, delta_exec, curr->vruntime);
> > +               if (schedstat_enabled())
> > +                       trace_sched_stat_runtime(curtask, delta_exec, curr->vruntime);
> >                 cgroup_account_cputime(curtask, delta_exec);
> >                 account_group_exec_runtime(curtask, delta_exec);
> >         }
> >
> >
> > _1_ line, where you wanted to add _6_ ugly #ifdefs
>
> I get your point now.
>
> Yes, these codes can be removed from the callsites in kernel/sched/fair.c,
> but the definitions of these tracepoints are still there,
> and then they will be exposed in /sys/kernel/debug/tracing/events/sched/.
>
> You can try objdump the vmlinux.
> $ objdump -dr kernel/sched/fair.o | awk '/>:$/ { F=$2 } /sched_stat/ {
> print F " " $0 }'    // nothing
>
> $ objdump -dr vmlinux  | awk '/>:$/ { F=$2 } /sched_stat/ { print F " " $0 }'
> <perf_trace_sched_stat_runtime>: ffffffff810b3c30
> <perf_trace_sched_stat_runtime>:  // it is still defined
>
>
> My guess is they will be used by perf or bpf,
> so they won't be optimized out by the compiler.
>

Hi Peter,

If you do not like sprinkle #ifdef, we can use something like bellow
to resovle this issue.
I don't like bellow code really, but it can avoid exposing these
tracepoints to the userspace.

What about your opinon ?


diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 9a4bdfa..a0291f2 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -336,6 +336,7 @@ static inline long __trace_sched_switch_state(bool
preempt, struct task_struct *
                  __entry->pid, __entry->old_pid)
 );

+#ifdef CONFIG_SCHEDSTATS
 /*
  * XXX the below sched_stat tracepoints only apply to SCHED_OTHER/BATCH/IDLE
  *     adding sched_stat support to SCHED_FIFO/RR would be welcome.
@@ -394,6 +395,14 @@ static inline long
__trace_sched_switch_state(bool preempt, struct task_struct *
 DEFINE_EVENT(sched_stat_template, sched_stat_blocked,
             TP_PROTO(struct task_struct *tsk, u64 delay),
             TP_ARGS(tsk, delay));
+#else
+
+#define trace_sched_stat_wait(...) do {} while (0)
+#define trace_sched_stat_sleep(...) do {} while (0)
+#define trace_sched_stat_iowait(...) do {} while (0)
+#define trace_sched_stat_blocked(...) do {} while (0)
+
+#endif

 /*
  * Tracepoint for accounting runtime (time the task is executing


Thanks
Yafang
