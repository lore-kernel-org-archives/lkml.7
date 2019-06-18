Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51083C31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A144208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560861291;
	bh=JkOBXbTwTxFiJgkV+khp3o5rzReMI//+FtduWLEOSGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o4gzu2INqyBiA1C3eGxW8v/MHA5V9trMgzF7zSQ0/G+lMird0AhiJ7kAZulAO9BJ2
	 XFnwUWzLOZrS5UjPqJ1tKA2CM6GEp2j6lhFtKg2ezpr2DgFzJVdpjwm/hFZ6VL4su8
	 eaq+1K3SnMecn9PsqFCI8vRJmiHTLBGDlZWo1F1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfFRMet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 08:34:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:33352 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbfFRMet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 08:34:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6B67BAE51;
        Tue, 18 Jun 2019 12:34:47 +0000 (UTC)
Date:   Tue, 18 Jun 2019 14:34:46 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm, oom: fix oom_unkillable_task for memcg OOMs
Message-ID: <20190618123446.GE3318@dhcp22.suse.cz>
References: <20190617231207.160865-1-shakeelb@google.com>
 <20190617231207.160865-2-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617231207.160865-2-shakeelb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17-06-19 16:12:07, Shakeel Butt wrote:
> Currently oom_unkillable_task() checks mems_allowed even for memcg OOMs
> which does not make sense as memcg OOMs can not be triggered due to
> numa constraints. Fixing that.

"Fixing that" is a poor description of the fix. Also it is quite useful
to note that it is not only bogus to check mems_allowed. It is also
harmful as per the syzbot test IIRC. Pasting the report here would
be helpful as well.

> This commit also removed the bogus usage of oom_unkillable_task() from
> oom_badness(). Currently reading /proc/[pid]/oom_score will do a bogus
> cpuset_mems_allowed_intersects() check. Removing that.

Again, there shouldn't be any real reason to squash the two things into
a single patch. This is a subtle bug/behavior on its own because the
result of oom_badness depends on the calling process context. This
should be called out in the changelog explicitly.

> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Other than that it looks good to me. I will ack after the split out and
the changelog improvements.

Thanks!

> ---
> Changelog since v1:
> - Divide the patch into two patches.
> 
>  fs/proc/base.c      |  3 +--
>  include/linux/oom.h |  1 -
>  mm/oom_kill.c       | 28 +++++++++++++++-------------
>  3 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index b8d5d100ed4a..57b7a0d75ef5 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -532,8 +532,7 @@ static int proc_oom_score(struct seq_file *m, struct pid_namespace *ns,
>  	unsigned long totalpages = totalram_pages() + total_swap_pages;
>  	unsigned long points = 0;
>  
> -	points = oom_badness(task, NULL, NULL, totalpages) *
> -					1000 / totalpages;
> +	points = oom_badness(task, totalpages) * 1000 / totalpages;
>  	seq_printf(m, "%lu\n", points);
>  
>  	return 0;
> diff --git a/include/linux/oom.h b/include/linux/oom.h
> index d07992009265..c696c265f019 100644
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -108,7 +108,6 @@ static inline vm_fault_t check_stable_address_space(struct mm_struct *mm)
>  bool __oom_reap_task_mm(struct mm_struct *mm);
>  
>  extern unsigned long oom_badness(struct task_struct *p,
> -		struct mem_cgroup *memcg, const nodemask_t *nodemask,
>  		unsigned long totalpages);
>  
>  extern bool out_of_memory(struct oom_control *oc);
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index bd80997e0969..d779d9da1069 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -152,20 +152,23 @@ static inline bool is_memcg_oom(struct oom_control *oc)
>  }
>  
>  /* return true if the task is not adequate as candidate victim task. */
> -static bool oom_unkillable_task(struct task_struct *p,
> -		struct mem_cgroup *memcg, const nodemask_t *nodemask)
> +static bool oom_unkillable_task(struct task_struct *p, struct oom_control *oc)
>  {
>  	if (is_global_init(p))
>  		return true;
>  	if (p->flags & PF_KTHREAD)
>  		return true;
>  
> -	/* When mem_cgroup_out_of_memory() and p is not member of the group */
> -	if (memcg && !task_in_mem_cgroup(p, memcg))
> -		return true;
> +	/*
> +	 * For memcg OOM, we reach here through mem_cgroup_scan_tasks(), no
> +	 * need to check p's memcg membership and the checks after this
> +	 * are irrelevant for memcg OOMs.
> +	 */
> +	if (is_memcg_oom(oc))
> +		return false;
>  
>  	/* p may not have freeable memory in nodemask */
> -	if (!has_intersects_mems_allowed(p, nodemask))
> +	if (!has_intersects_mems_allowed(p, oc->nodemask))
>  		return true;
>  
>  	return false;
> @@ -201,13 +204,12 @@ static bool is_dump_unreclaim_slabs(void)
>   * predictable as possible.  The goal is to return the highest value for the
>   * task consuming the most memory to avoid subsequent oom failures.
>   */
> -unsigned long oom_badness(struct task_struct *p, struct mem_cgroup *memcg,
> -			  const nodemask_t *nodemask, unsigned long totalpages)
> +unsigned long oom_badness(struct task_struct *p, unsigned long totalpages)
>  {
>  	long points;
>  	long adj;
>  
> -	if (oom_unkillable_task(p, memcg, nodemask))
> +	if (is_global_init(p) || p->flags & PF_KTHREAD)
>  		return 0;
>  
>  	p = find_lock_task_mm(p);
> @@ -318,7 +320,7 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
>  	struct oom_control *oc = arg;
>  	unsigned long points;
>  
> -	if (oom_unkillable_task(task, NULL, oc->nodemask))
> +	if (oom_unkillable_task(task, oc))
>  		goto next;
>  
>  	/*
> @@ -342,7 +344,7 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
>  		goto select;
>  	}
>  
> -	points = oom_badness(task, NULL, oc->nodemask, oc->totalpages);
> +	points = oom_badness(task, oc->totalpages);
>  	if (!points || points < oc->chosen_points)
>  		goto next;
>  
> @@ -390,7 +392,7 @@ static int dump_task(struct task_struct *p, void *arg)
>  	struct oom_control *oc = arg;
>  	struct task_struct *task;
>  
> -	if (oom_unkillable_task(p, NULL, oc->nodemask))
> +	if (oom_unkillable_task(p, oc))
>  		return 0;
>  
>  	task = find_lock_task_mm(p);
> @@ -1090,7 +1092,7 @@ bool out_of_memory(struct oom_control *oc)
>  	check_panic_on_oom(oc, constraint);
>  
>  	if (!is_memcg_oom(oc) && sysctl_oom_kill_allocating_task &&
> -	    current->mm && !oom_unkillable_task(current, NULL, oc->nodemask) &&
> +	    current->mm && !oom_unkillable_task(current, oc) &&
>  	    current->signal->oom_score_adj != OOM_SCORE_ADJ_MIN) {
>  		get_task_struct(current);
>  		oc->chosen = current;
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Michal Hocko
SUSE Labs
