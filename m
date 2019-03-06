Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2244C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 12:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C8920652
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 12:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClA7e0UX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbfCFMyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 07:54:36 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38565 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728986AbfCFMyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 07:54:35 -0500
Received: by mail-io1-f68.google.com with SMTP id p18so10088281ioh.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 04:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IyJh6+NbO/gcGr5lokyCKtzY9eDue915BtY+OpEWauo=;
        b=ClA7e0UXx7p5qAfq7O+xWb3tw1hISjAUrlfXXwpQbpG7TxqAV8PRSnpNo1O6yxsi9p
         P9b6Wn2T4PXLCjDZCQVyJKrMJ+Fm5V7p9wqMKCNrzhwSTmaGyv5/4HYZkgid7kPpsiXG
         CW/LWl9JCm47V651MlMIQyYpNUKHqYsf+/2ms0UerMSYO4pFjIMeQ/yQHOvUU5Nh+TDm
         sXe7cQpIIySL6sK8RRLJRHXVEw79aBDDJHkovt9O7VN+/ofLs0Pt/174jtk6X+zgjS3l
         FOQPyIR+p/h6ZlyiRK3evoPSSbNX5qt5BlyFqvKx4xmlr3b0e+6bxSfCxe6vUNCqEZWD
         hYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IyJh6+NbO/gcGr5lokyCKtzY9eDue915BtY+OpEWauo=;
        b=gbkzIeE6j3uVwBfyo2liWrcPLD/iulOrYK63tRAzv2t8gVsfyFv84md+OEOCFsyLsp
         2Gjs4mqiX1qtNU1Vk9sG0ZloGrk2M5JtUsUzrxJKscntFV7E2cerxv9aCotUirct+eFD
         ZdOfQSX2wx+xguRe2d34adIiPoJQVDs+i2CB7y9kZNeTq38ChRlM2E3QDLMA6Ra6ukHm
         KvFO4bVVe1FBUhDE/I2k1an0x92LYRi+tlDXQ43gOYW3wSss1XkcWSS9fO1o2EypJiKk
         c59mSp7ePHsbTeFLgss7xyhte3B+dK4tQGOQGXYlRWdC8RWbKX2CEMQ572FM2hq0/rqJ
         Q7dQ==
X-Gm-Message-State: APjAAAVbYj28tDeTxy9pOFm2LTrlILXCYD4JcEHH2ySTM3N7MvjPSpJ/
        Lk54IUZ4bSkj4y2A/ZzJD2e18R3ZIcyX2D1VUFE=
X-Google-Smtp-Source: APXvYqxb6anBL5KHdtZlgfPi4eiqQvXBwKi+6vju056Og+aQze5j2lgkTDrDEhUjATbLXIm/HJSeHLNtIPv8TYO9k3E=
X-Received: by 2002:a6b:5802:: with SMTP id m2mr2769147iob.142.1551876875016;
 Wed, 06 Mar 2019 04:54:35 -0800 (PST)
MIME-Version: 1.0
References: <1551861826-12592-1-git-send-email-laoar.shao@gmail.com>
 <20190306100907.GT32477@hirez.programming.kicks-ass.net> <CALOAHbC1zqzU8-ikcLOUMKY5cbyuW_B6MK5rz7G6rTK-SoyMTQ@mail.gmail.com>
 <20190306112707.GU32477@hirez.programming.kicks-ass.net> <CALOAHbB7EZ83R3gHcGa9oZWq=7CEgBkL2cXav_7N13u4U44+uA@mail.gmail.com>
 <20190306123834.GW32494@hirez.programming.kicks-ass.net>
In-Reply-To: <20190306123834.GW32494@hirez.programming.kicks-ass.net>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 6 Mar 2019 20:53:59 +0800
Message-ID: <CALOAHbBDArxamap+TsWXy227N-UOsKVDA-HkGVF1M0O2Fk8qEg@mail.gmail.com>
Subject: Re: [PATCH] sched: fair: fix missed CONFIG_SCHEDSTATS
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        shaoyafang@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 8:38 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Mar 06, 2019 at 07:49:36PM +0800, Yafang Shao wrote:
>
>
> $ grep SCHEDSTAT defconfig-build/.config
> # CONFIG_SCHEDSTATS is not set
> $ obbjdump -dr defconfig-build/kernel/sched/fair.o | awk '/>:$/ { F=$2 } /sched_stat/ { print F " " $0 }'
> <update_curr>:                  24cd: R_X86_64_32S      __tracepoint_sched_stat_runtime+0x28
> <update_curr>:                  24d9: R_X86_64_PC32     __tracepoint_sched_stat_runtime+0x24
> $ patch -p1 < foo
> patching file kernel/sched/fair.c
> $ make O=defconfig-build kernel/sched/
> make[1]: Entering directory '/usr/src/linux-2.6/defconfig-build'
> Using .. as source for kernel
> GEN     Makefile
> CALL    ../scripts/checksyscalls.sh
> CALL    ../scripts/atomic/check-atomics.sh
> DESCEND  objtool
> CC      kernel/sched/fair.o
> AR      kernel/sched/built-in.a
> make[1]: Leaving directory '/usr/src/linux-2.6/defconfig-build'
> $ objdump -dr defconfig-build/kernel/sched/fair.o | awk '/>:$/ { F=$2 } /sched_stat/ { print F " " $0 }'
> $ cat foo
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8213ff6e365d..6e5ceec3b662 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -839,7 +839,8 @@ static void update_curr(struct cfs_rq *cfs_rq)
>         if (entity_is_task(curr)) {
>                 struct task_struct *curtask = task_of(curr);
>
> -               trace_sched_stat_runtime(curtask, delta_exec, curr->vruntime);
> +               if (schedstat_enabled())
> +                       trace_sched_stat_runtime(curtask, delta_exec, curr->vruntime);
>                 cgroup_account_cputime(curtask, delta_exec);
>                 account_group_exec_runtime(curtask, delta_exec);
>         }
>
>
> _1_ line, where you wanted to add _6_ ugly #ifdefs

I get your point now.

Yes, these codes can be removed from the callsites in kernel/sched/fair.c,
but the definitions of these tracepoints are still there,
and then they will be exposed in /sys/kernel/debug/tracing/events/sched/.

You can try objdump the vmlinux.
$ objdump -dr kernel/sched/fair.o | awk '/>:$/ { F=$2 } /sched_stat/ {
print F " " $0 }'    // nothing

$ objdump -dr vmlinux  | awk '/>:$/ { F=$2 } /sched_stat/ { print F " " $0 }'
<perf_trace_sched_stat_runtime>: ffffffff810b3c30
<perf_trace_sched_stat_runtime>:  // it is still defined


My guess is they will be used by perf or bpf,
so they won't be optimized out by the compiler.

Thanks
Yafang
