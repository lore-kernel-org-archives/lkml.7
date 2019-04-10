Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B107C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8252082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mrYaruR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733015AbfDJPBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:01:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55002 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbfDJPBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 11:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AqRZMVs+2bwTDhFsWbR44IzGyey3GE9vM+pHxlG8i8Q=; b=mrYaruR0BS9NVnqEw7wAt7BOSq
        VATv95jmdVeompS+ZnxplO0xzISqw6240cTK/Q3+5YYdgKL93LzXb2wWvc2am8N/MucRZJ9sR4dnJ
        8EPToJkHZtJQpzwFEpQM0Ug4aAp9qqiFXoxHjQJs20fB+DxQ0Euq3T467BZ+t/3F9JmF4ewsuKZ5k
        v774W6nqx66eKHqKNDMnlbvxfWrOkcTHwbzWRDJt1qfKDWXrmok1HSpw1vRHN7xYbIvf6kepL0xdB
        LXHrxC+BiONuZVdY7hwCJ8NIwaWeFNEUD7QCj0YBcjcAU/2N9dRHHlT2xaHG8DpjbDOzA8wmWWtHv
        bklmatgw==;
Received: from [89.200.33.100] (helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEEj0-0000uH-J2; Wed, 10 Apr 2019 15:01:18 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2DBDF984F06; Wed, 10 Apr 2019 17:01:16 +0200 (CEST)
Date:   Wed, 10 Apr 2019 17:01:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julien Desfossez <jdesfossez@digitalocean.com>
Cc:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Vineeth Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>
Subject: Re: [RFC][PATCH 13/16] sched: Add core wide task selection and
 scheduling.
Message-ID: <20190410150116.GI2490@worktop.programming.kicks-ass.net>
References: <20190218173514.667598558@infradead.org>
 <1554835135-11814-1-git-send-email-jdesfossez@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1554835135-11814-1-git-send-email-jdesfossez@digitalocean.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 02:38:55PM -0400, Julien Desfossez wrote:
> We found the source of the major performance regression we discussed
> previously. It turns out there was a pattern where a task (a kworker in this
> case) could be woken up, but the core could still end up idle before that
> task had a chance to run.
> 
> Example sequence, cpu0 and cpu1 and siblings on the same core, task1 and
> task2 are in the same cgroup with the tag enabled (each following line
> happens in the increasing order of time):
> - task1 running on cpu0, task2 running on cpu1
> - sched_waking(kworker/0, target_cpu=cpu0)
> - task1 scheduled out of cpu0
> - kworker/0 cannot run on cpu0 because of task2 is still running on cpu1
>   cpu0 is idle
> - task2 scheduled out of cpu1

But at this point core_cookie is still set; we don't clear it when the
last task goes away.

> - cpu1 doesn’t select kworker/0 for cpu0, because the optimization path ends
>   the task selection if core_cookie is NULL for currently selected process
>   and the cpu1’s runqueue.

But at this point core_cookie is still set, we only (re)set it later to
p->core_cookie.

What I suspect happens is that you hit the 'again' clause due to a
higher prio @max on the second sibling. And at that point we've
destroyed core_cookie.

> - cpu1 is idle
> --> both siblings are idle but kworker/0 is still in the run queue of cpu0.
>     Cpu0 may stay idle for longer if it goes deep idle.
> 
> With the fix below, we ensure to send an IPI to the sibling if it is idle
> and has tasks waiting in its runqueue.
> This fixes the performance issue we were seeing.
> 
> Now here is what we can measure with a disk write-intensive benchmark:
> - no performance impact with enabling core scheduling without any tagged
>   task,
> - 5% overhead if one tagged task is competing with an untagged task,
> - 10% overhead if 2 tasks tagged with a different tag are competing
>   against each other.
> 
> We are starting more scaling tests, but this is very encouraging !
> 
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e1fa10561279..02c862a5e973 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3779,7 +3779,22 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  
>  				trace_printk("unconstrained pick: %s/%d %lx\n",
>  						next->comm, next->pid, next->core_cookie);
> +				rq->core_pick = NULL;
>  
> +				/*
> +				 * If the sibling is idling, we might want to wake it
> +				 * so that it can check for any runnable but blocked tasks 
> +				 * due to previous task matching.
> +				 */
> +				for_each_cpu(j, smt_mask) {
> +					struct rq *rq_j = cpu_rq(j);
> +					rq_j->core_pick = NULL;
> +					if (j != cpu && is_idle_task(rq_j->curr) && rq_j->nr_running) {
> +						resched_curr(rq_j);
> +						trace_printk("IPI(%d->%d[%d]) idle preempt\n",
> +							     cpu, j, rq_j->nr_running);
> +					}
> +				}
>  				goto done;
>  			}

I'm thinking there is a more elegant solution hiding in there; possibly
saving/restoring that core_cookie on the again loop should do, but I've
always had the nagging suspicion that whole selection loop could be done
better.
