Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6DEC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41774218DA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kh0xldl4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbfDWXZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:25:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45054 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbfDWXZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:25:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id h16so2500265ljg.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PhexGAvqE0ly7Dqo3/rabTlhsaLEBk654TSvCPJQEQU=;
        b=Kh0xldl4L52IHmTzoR5sDGLk6o5bpSvoMvEVh4Y0xeuvnWyK0eFlNE5Eh0eofUsUxm
         EuKQuyH7gbtC3tq1YJn535hYrl4kmURPxtU+HUUFfQ4hKqto+ih2gRxFC2sg22A3AjKj
         m6V19/d43FtHCeaZO+2lngjkU5l4x+Mhx8OTl/hiZAEnBAc/ZGZJ3u9Jhw85sZooIx/Q
         0WR3aPPxKKFKW3qGYzF4R4iaOdFuK+i3MliJd5J+oVAYmWkiBc7Fp2bz7fEPS2lHNOCR
         cVa7P4FlIAA9sQ7TfpZNVnewgM2PSakpQJma4G6HS2FUNfwOJrWhse7/cG+Syg/ag9UF
         9IFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PhexGAvqE0ly7Dqo3/rabTlhsaLEBk654TSvCPJQEQU=;
        b=DmpyiW8B2vu4nNaNzwJMrRU6FJXdFip4EYQJbqN287PFyUhl3W500ufT+KzFvz+4lD
         6G6xsdyJqHO4+9ogdP8fpzTZxbIYMiCF95fyfxDF6/MgADKU4aOfLa0CL73OaK9xQ4aW
         44HKqy8LxoA89kGDE7Rt+fw7L2GtTZD5/Hjrl1kAG8MYIOYlACnuaHkbLw+aoLTKZb97
         CYwwgIt9yDGCQoAvUrrl9qcQEWTKN6pTpo6iqRuy9OkQ3nqs+9UknbT0i/SgJUpQItH/
         OZRQtY6yeZaYHWZcJz6Lz9LZrKQXfd3HbVImBb9g1UEOANuSawa+wAb+Ml3n3ZK5gjw2
         /FjQ==
X-Gm-Message-State: APjAAAXTiXN1LKdRNJbIB+foYFQeTyedfZaseYISDpLgu5ecUL3CvsIe
        CzhTvpWZddiU0lzm1KY9UAWcjahwwrOn4eLciNE=
X-Google-Smtp-Source: APXvYqw6/3ksff5/M+jWgwj/CYjEzwVh6lUkJk4G/lDTG6TXgs8tXVbkux1soFwKAmxgh4DHSn5zicq0wxmJgHn9MJI=
X-Received: by 2002:a2e:7c02:: with SMTP id x2mr14750658ljc.176.1556061952517;
 Tue, 23 Apr 2019 16:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556025155.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1556025155.git.vpillai@digitalocean.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Wed, 24 Apr 2019 07:25:41 +0800
Message-ID: <CAERHkrtcW8L0duMTzkt-eDnesiG6sEO=zfswZcoM+n3TMxrG_w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 12:18 AM Vineeth Remanan Pillai
<vpillai@digitalocean.com> wrote:
>
> Second iteration of the core-scheduling feature.
>
> This version fixes apparent bugs and performance issues in v1. This
> doesn't fully address the issue of core sharing between processes
> with different tags. Core sharing still happens 1% to 5% of the time
> based on the nature of workload and timing of the runnable processes.
>
> Changes in v2
> -------------
> - rebased on mainline commit: 6d906f99817951e2257d577656899da02bb33105
> - Fixes for couple of NULL pointer dereference crashes
>   - Subhra Mazumdar
>   - Tim Chen

Is this one missed? Or fixed with a better impl?

The boot up CPUs don't match the possible cpu map, so the not onlined
CPU rq->core are not initialized, which causes NULL pointer dereference
panic in online_fair_sched_group():

Thanks,
-Aubrey

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 85c728d..bdabf20 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10492,6 +10492,10 @@ void online_fair_sched_group(struct task_group *tg)
                rq = cpu_rq(i);
                se = tg->se[i];

+#ifdef CONFIG_SCHED_CORE
+               if (!rq->core)
+                       continue;
+#endif
                raw_spin_lock_irq(rq_lockp(rq));
                update_rq_clock(rq);
                attach_entity_cfs_rq(se);

> - Improves priority comparison logic for process in different cpus
>   - Peter Zijlstra
>   - Aaron Lu
> - Fixes a hard lockup in rq locking
>   - Vineeth Pillai
>   - Julien Desfossez
> - Fixes a performance issue seen on IO heavy workloads
>   - Vineeth Pillai
>   - Julien Desfossez
> - Fix for 32bit build
>   - Aubrey Li
>
> Issues
> ------
> - Processes with different tags can still share the core
> - A crash when disabling cpus with core-scheduling on
>    - https://paste.debian.net/plainh/fa6bcfa8
>
> ---
>
> Peter Zijlstra (16):
>   stop_machine: Fix stop_cpus_in_progress ordering
>   sched: Fix kerneldoc comment for ia64_set_curr_task
>   sched: Wrap rq::lock access
>   sched/{rt,deadline}: Fix set_next_task vs pick_next_task
>   sched: Add task_struct pointer to sched_class::set_curr_task
>   sched/fair: Export newidle_balance()
>   sched: Allow put_prev_task() to drop rq->lock
>   sched: Rework pick_next_task() slow-path
>   sched: Introduce sched_class::pick_task()
>   sched: Core-wide rq->lock
>   sched: Basic tracking of matching tasks
>   sched: A quick and dirty cgroup tagging interface
>   sched: Add core wide task selection and scheduling.
>   sched/fair: Add a few assertions
>   sched: Trivial forced-newidle balancer
>   sched: Debug bits...
>
> Vineeth Remanan Pillai (1):
>   sched: Wake up sibling if it has something to run
>
>  include/linux/sched.h    |   9 +-
>  kernel/Kconfig.preempt   |   7 +-
>  kernel/sched/core.c      | 800 +++++++++++++++++++++++++++++++++++++--
>  kernel/sched/cpuacct.c   |  12 +-
>  kernel/sched/deadline.c  |  99 +++--
>  kernel/sched/debug.c     |   4 +-
>  kernel/sched/fair.c      | 137 +++++--
>  kernel/sched/idle.c      |  42 +-
>  kernel/sched/pelt.h      |   2 +-
>  kernel/sched/rt.c        |  96 +++--
>  kernel/sched/sched.h     | 185 ++++++---
>  kernel/sched/stop_task.c |  35 +-
>  kernel/sched/topology.c  |   4 +-
>  kernel/stop_machine.c    |   2 +
>  14 files changed, 1145 insertions(+), 289 deletions(-)
>
> --
> 2.17.1
>
