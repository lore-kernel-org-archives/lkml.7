Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EE8C31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04C32082C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560860704;
	bh=yW82F4gqXy0ZcUKc18bcDth8ibokWF51gkEBKCld8/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OgVvx+nJTWGmoBoCahJ0HFg2n5YmTRtQuaYp+oSgA1FuF9D+lPR0hYAcM2+s8cPWK
	 CLDEdbQUwZgajyIruiu/X6XsETEhnZF30gFywWZJgKbzVUa6KljdSQJKcgReh3BsWL
	 wJ9QSIBEeR8CJdc/HIJNI8oIpNkzapRU4Betae3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfFRMZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 08:25:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:58380 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725934AbfFRMZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 08:25:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4181EAF49;
        Tue, 18 Jun 2019 12:25:01 +0000 (UTC)
Date:   Tue, 18 Jun 2019 14:24:57 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm, oom: refactor dump_tasks for memcg OOMs
Message-ID: <20190618122457.GD3318@dhcp22.suse.cz>
References: <20190617231207.160865-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617231207.160865-1-shakeelb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17-06-19 16:12:06, Shakeel Butt wrote:
> dump_tasks() currently goes through all the processes present on the
> system even for memcg OOMs. Change dump_tasks() similar to
> select_bad_process() and use mem_cgroup_scan_tasks() to selectively
> traverse the processes of the memcgs during memcg OOM.

The changelog is quite modest to be honest. I would go with

"
dump_tasks() traverses all the existing processes even for the memcg OOM
context which is not only unnecessary but also wasteful. This imposes
a long RCU critical section even from a contained context which can be
quite disruptive.

Change dump_tasks() to be aligned with select_bad_process and use
mem_cgroup_scan_tasks to selectively traverse only processes of the
target memcg hierarchy during memcg OOM.
"

> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
> Changelog since v1:
> - Divide the patch into two patches.
> 
>  mm/oom_kill.c | 68 ++++++++++++++++++++++++++++++---------------------
>  1 file changed, 40 insertions(+), 28 deletions(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 05aaa1a5920b..bd80997e0969 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -385,10 +385,38 @@ static void select_bad_process(struct oom_control *oc)
>  	oc->chosen_points = oc->chosen_points * 1000 / oc->totalpages;
>  }
>  
> +static int dump_task(struct task_struct *p, void *arg)
> +{
> +	struct oom_control *oc = arg;
> +	struct task_struct *task;
> +
> +	if (oom_unkillable_task(p, NULL, oc->nodemask))
> +		return 0;
> +
> +	task = find_lock_task_mm(p);
> +	if (!task) {
> +		/*
> +		 * This is a kthread or all of p's threads have already
> +		 * detached their mm's.  There's no need to report
> +		 * them; they can't be oom killed anyway.
> +		 */
> +		return 0;
> +	}
> +
> +	pr_info("[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %s\n",
> +		task->pid, from_kuid(&init_user_ns, task_uid(task)),
> +		task->tgid, task->mm->total_vm, get_mm_rss(task->mm),
> +		mm_pgtables_bytes(task->mm),
> +		get_mm_counter(task->mm, MM_SWAPENTS),
> +		task->signal->oom_score_adj, task->comm);
> +	task_unlock(task);
> +
> +	return 0;
> +}
> +
>  /**
>   * dump_tasks - dump current memory state of all system tasks
> - * @memcg: current's memory controller, if constrained
> - * @nodemask: nodemask passed to page allocator for mempolicy ooms
> + * @oc: pointer to struct oom_control
>   *
>   * Dumps the current memory state of all eligible tasks.  Tasks not in the same
>   * memcg, not in the same cpuset, or bound to a disjoint set of mempolicy nodes
> @@ -396,37 +424,21 @@ static void select_bad_process(struct oom_control *oc)
>   * State information includes task's pid, uid, tgid, vm size, rss,
>   * pgtables_bytes, swapents, oom_score_adj value, and name.
>   */
> -static void dump_tasks(struct mem_cgroup *memcg, const nodemask_t *nodemask)
> +static void dump_tasks(struct oom_control *oc)
>  {
> -	struct task_struct *p;
> -	struct task_struct *task;
> -
>  	pr_info("Tasks state (memory values in pages):\n");
>  	pr_info("[  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name\n");
> -	rcu_read_lock();
> -	for_each_process(p) {
> -		if (oom_unkillable_task(p, memcg, nodemask))
> -			continue;
>  
> -		task = find_lock_task_mm(p);
> -		if (!task) {
> -			/*
> -			 * This is a kthread or all of p's threads have already
> -			 * detached their mm's.  There's no need to report
> -			 * them; they can't be oom killed anyway.
> -			 */
> -			continue;
> -		}
> +	if (is_memcg_oom(oc))
> +		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
> +	else {
> +		struct task_struct *p;
>  
> -		pr_info("[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %s\n",
> -			task->pid, from_kuid(&init_user_ns, task_uid(task)),
> -			task->tgid, task->mm->total_vm, get_mm_rss(task->mm),
> -			mm_pgtables_bytes(task->mm),
> -			get_mm_counter(task->mm, MM_SWAPENTS),
> -			task->signal->oom_score_adj, task->comm);
> -		task_unlock(task);
> +		rcu_read_lock();
> +		for_each_process(p)
> +			dump_task(p, oc);
> +		rcu_read_unlock();
>  	}
> -	rcu_read_unlock();
>  }
>  
>  static void dump_oom_summary(struct oom_control *oc, struct task_struct *victim)
> @@ -458,7 +470,7 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
>  			dump_unreclaimable_slab();
>  	}
>  	if (sysctl_oom_dump_tasks)
> -		dump_tasks(oc->memcg, oc->nodemask);
> +		dump_tasks(oc);
>  	if (p)
>  		dump_oom_summary(oc, p);
>  }
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Michal Hocko
SUSE Labs
