Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0D3C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A105220685
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfDWSCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 14:02:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50926 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727737AbfDWSCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 14:02:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C26E2811A9;
        Tue, 23 Apr 2019 18:02:43 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BC8C5C1B5;
        Tue, 23 Apr 2019 18:02:40 +0000 (UTC)
Date:   Tue, 23 Apr 2019 14:02:38 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
Message-ID: <20190423180238.GG22260@pauld.bos.csb>
References: <cover.1556025155.git.vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556025155.git.vpillai@digitalocean.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 23 Apr 2019 18:02:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 23, 2019 at 04:18:05PM +0000 Vineeth Remanan Pillai wrote:
> Second iteration of the core-scheduling feature.

Thanks for spinning V2 of this.

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

I may have missed something... Could you explain this statement?

This, to me, is the whole point of the patch series. If it's not
doing this then ... what?



Thanks,
Phil



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

-- 
