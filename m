Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D72CC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381F320B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561531102;
	bh=Dsngz75U/MQ1823N2+4bzZfpbttg8K8rqhFxayKYhQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zupOdypULpZnZVwKJKLXAHVrWrqXEyJCJjw8xssTX6cm4/Qbn9w5hqcUkGdhPr5EB
	 oLPiV9Sgcj86Wu658OphhO0ESaculqEEOKW7ydc3VUfSfKs53rUYEkJr+9nVVy/Pc1
	 3HhkYL3O5XUkC7ngEzPU2uzy1skfCpFsT2to4TCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfFZGiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 02:38:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:34166 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725876AbfFZGiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:38:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 47437AEC6;
        Wed, 26 Jun 2019 06:38:17 +0000 (UTC)
Date:   Wed, 26 Jun 2019 08:38:16 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        David Rientjes <rientjes@google.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Paul Jackson <pj@sgi.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] mm, oom: remove redundant task_in_mem_cgroup()
 check
Message-ID: <20190626063755.GI17798@dhcp22.suse.cz>
References: <20190624212631.87212-1-shakeelb@google.com>
 <20190624212631.87212-2-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624212631.87212-2-shakeelb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 24-06-19 14:26:30, Shakeel Butt wrote:
> oom_unkillable_task() can be called from three different contexts i.e.
> global OOM, memcg OOM and oom_score procfs interface. At the moment
> oom_unkillable_task() does a task_in_mem_cgroup() check on the given
> process. Since there is no reason to perform task_in_mem_cgroup()
> check for global OOM and oom_score procfs interface, those contexts
> provide NULL memcg and skips the task_in_mem_cgroup() check. However for
> memcg OOM context, the oom_unkillable_task() is always called from
> mem_cgroup_scan_tasks() and thus task_in_mem_cgroup() check becomes
> redundant. So, just remove the task_in_mem_cgroup() check altogether.

Just a nit. Not only it is redundant but it is effectively a dead code
after your previous patch.
 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
> Changelog since v2:
> - Further divided the patch into two patches.
> - Incorporated the task_in_mem_cgroup() from Tetsuo.
> 
> Changelog since v1:
> - Divide the patch into two patches.
> 
>  fs/proc/base.c             |  2 +-
>  include/linux/memcontrol.h |  7 -------
>  include/linux/oom.h        |  2 +-
>  mm/memcontrol.c            | 26 --------------------------
>  mm/oom_kill.c              | 19 +++++++------------
>  5 files changed, 9 insertions(+), 47 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index b8d5d100ed4a..5eacce5e924a 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -532,7 +532,7 @@ static int proc_oom_score(struct seq_file *m, struct pid_namespace *ns,
>  	unsigned long totalpages = totalram_pages() + total_swap_pages;
>  	unsigned long points = 0;
>  
> -	points = oom_badness(task, NULL, NULL, totalpages) *
> +	points = oom_badness(task, NULL, totalpages) *
>  					1000 / totalpages;
>  	seq_printf(m, "%lu\n", points);
>  
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 9abf31bbe53a..2cbce1fe7780 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -407,7 +407,6 @@ static inline struct lruvec *mem_cgroup_lruvec(struct pglist_data *pgdat,
>  
>  struct lruvec *mem_cgroup_page_lruvec(struct page *, struct pglist_data *);
>  
> -bool task_in_mem_cgroup(struct task_struct *task, struct mem_cgroup *memcg);
>  struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
>  
>  struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
> @@ -896,12 +895,6 @@ static inline bool mm_match_cgroup(struct mm_struct *mm,
>  	return true;
>  }
>  
> -static inline bool task_in_mem_cgroup(struct task_struct *task,
> -				      const struct mem_cgroup *memcg)
> -{
> -	return true;
> -}
> -
>  static inline struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
>  {
>  	return NULL;
> diff --git a/include/linux/oom.h b/include/linux/oom.h
> index d07992009265..b75104690311 100644
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -108,7 +108,7 @@ static inline vm_fault_t check_stable_address_space(struct mm_struct *mm)
>  bool __oom_reap_task_mm(struct mm_struct *mm);
>  
>  extern unsigned long oom_badness(struct task_struct *p,
> -		struct mem_cgroup *memcg, const nodemask_t *nodemask,
> +		const nodemask_t *nodemask,
>  		unsigned long totalpages);
>  
>  extern bool out_of_memory(struct oom_control *oc);
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index db46a9dc37ab..27c92c2b99be 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1259,32 +1259,6 @@ void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
>  		*lru_size += nr_pages;
>  }
>  
> -bool task_in_mem_cgroup(struct task_struct *task, struct mem_cgroup *memcg)
> -{
> -	struct mem_cgroup *task_memcg;
> -	struct task_struct *p;
> -	bool ret;
> -
> -	p = find_lock_task_mm(task);
> -	if (p) {
> -		task_memcg = get_mem_cgroup_from_mm(p->mm);
> -		task_unlock(p);
> -	} else {
> -		/*
> -		 * All threads may have already detached their mm's, but the oom
> -		 * killer still needs to detect if they have already been oom
> -		 * killed to prevent needlessly killing additional tasks.
> -		 */
> -		rcu_read_lock();
> -		task_memcg = mem_cgroup_from_task(task);
> -		css_get(&task_memcg->css);
> -		rcu_read_unlock();
> -	}
> -	ret = mem_cgroup_is_descendant(task_memcg, memcg);
> -	css_put(&task_memcg->css);
> -	return ret;
> -}
> -
>  /**
>   * mem_cgroup_margin - calculate chargeable space of a memory cgroup
>   * @memcg: the memory cgroup
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index bd80997e0969..e0cdcbd58b0b 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -153,17 +153,13 @@ static inline bool is_memcg_oom(struct oom_control *oc)
>  
>  /* return true if the task is not adequate as candidate victim task. */
>  static bool oom_unkillable_task(struct task_struct *p,
> -		struct mem_cgroup *memcg, const nodemask_t *nodemask)
> +				const nodemask_t *nodemask)
>  {
>  	if (is_global_init(p))
>  		return true;
>  	if (p->flags & PF_KTHREAD)
>  		return true;
>  
> -	/* When mem_cgroup_out_of_memory() and p is not member of the group */
> -	if (memcg && !task_in_mem_cgroup(p, memcg))
> -		return true;
> -
>  	/* p may not have freeable memory in nodemask */
>  	if (!has_intersects_mems_allowed(p, nodemask))
>  		return true;
> @@ -194,20 +190,19 @@ static bool is_dump_unreclaim_slabs(void)
>   * oom_badness - heuristic function to determine which candidate task to kill
>   * @p: task struct of which task we should calculate
>   * @totalpages: total present RAM allowed for page allocation
> - * @memcg: task's memory controller, if constrained
>   * @nodemask: nodemask passed to page allocator for mempolicy ooms
>   *
>   * The heuristic for determining which task to kill is made to be as simple and
>   * predictable as possible.  The goal is to return the highest value for the
>   * task consuming the most memory to avoid subsequent oom failures.
>   */
> -unsigned long oom_badness(struct task_struct *p, struct mem_cgroup *memcg,
> +unsigned long oom_badness(struct task_struct *p,
>  			  const nodemask_t *nodemask, unsigned long totalpages)
>  {
>  	long points;
>  	long adj;
>  
> -	if (oom_unkillable_task(p, memcg, nodemask))
> +	if (oom_unkillable_task(p, nodemask))
>  		return 0;
>  
>  	p = find_lock_task_mm(p);
> @@ -318,7 +313,7 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
>  	struct oom_control *oc = arg;
>  	unsigned long points;
>  
> -	if (oom_unkillable_task(task, NULL, oc->nodemask))
> +	if (oom_unkillable_task(task, oc->nodemask))
>  		goto next;
>  
>  	/*
> @@ -342,7 +337,7 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
>  		goto select;
>  	}
>  
> -	points = oom_badness(task, NULL, oc->nodemask, oc->totalpages);
> +	points = oom_badness(task, oc->nodemask, oc->totalpages);
>  	if (!points || points < oc->chosen_points)
>  		goto next;
>  
> @@ -390,7 +385,7 @@ static int dump_task(struct task_struct *p, void *arg)
>  	struct oom_control *oc = arg;
>  	struct task_struct *task;
>  
> -	if (oom_unkillable_task(p, NULL, oc->nodemask))
> +	if (oom_unkillable_task(p, oc->nodemask))
>  		return 0;
>  
>  	task = find_lock_task_mm(p);
> @@ -1090,7 +1085,7 @@ bool out_of_memory(struct oom_control *oc)
>  	check_panic_on_oom(oc, constraint);
>  
>  	if (!is_memcg_oom(oc) && sysctl_oom_kill_allocating_task &&
> -	    current->mm && !oom_unkillable_task(current, NULL, oc->nodemask) &&
> +	    current->mm && !oom_unkillable_task(current, oc->nodemask) &&
>  	    current->signal->oom_score_adj != OOM_SCORE_ADJ_MIN) {
>  		get_task_struct(current);
>  		oc->chosen = current;
> -- 
> 2.22.0.410.gd8fdbe21b5-goog

-- 
Michal Hocko
SUSE Labs
