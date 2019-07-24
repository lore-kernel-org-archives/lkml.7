Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02801C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98FB229F3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563949999;
	bh=uuUj1L9dL9D3cktkhV+mfLukeQKsB2g+c44WfO7BNjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Mxzg/MMSLeXEvZ8FJ7F2TsTT9uSLqSNFXEaU2hLp9blRnYVwxcDPyxeWJ6he19OHq
	 D2YR4F4B/2E36d8lyolGi8uCh1YYUiarI2xVKpDxSlKhOhXfBNOX9VQrlUvIsw9yru
	 v0BIBqfA+aLG52R/lB8Gn/KNdsv52ALZmXBAmYlc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfGXGdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 02:33:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:40712 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725919AbfGXGdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 02:33:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0E84EAF84;
        Wed, 24 Jul 2019 06:33:16 +0000 (UTC)
Date:   Wed, 24 Jul 2019 08:33:14 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     mm-commits@vger.kernel.org, shakeelb@google.com,
        rientjes@google.com, mhocko@suse.com, guro@fb.com,
        penguin-kernel@I-love.SAKURA.ne.jp
Subject: Re: + mm-oom-avoid-printk-iteration-under-rcu.patch added to -mm tree
Message-ID: <20190724063314.GB10882@dhcp22.suse.cz>
References: <20190723231429.b0bmJ%akpm@linux-foundation.org>
 <20190724062727.GA10882@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724062727.GA10882@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ups, I've cut the Cc list somehow, sorry about that]

On Wed 24-07-19 08:27:27, Michal Hocko wrote:
> Andrew,
> I've had some concerns wrt. this patch - especially the additional
> complexity - and I have to say I am not convinced that this is really
> needed. Our past experience in this area suggests that more tricky code
> leads to different corner cases. So I am really reluctant to add more
> complexity without any real world reports.
> 
> On Tue 23-07-19 16:14:29, Andrew Morton wrote:
> > From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Subject: mm, oom: avoid printk() iteration under RCU
> > 
> > Currently dump_tasks() might call printk() for many thousands times under
> > RCU, which might take many minutes for slow consoles.  Therefore, split
> > dump_tasks() into three stages; take a snapshot of possible OOM victim
> > candidates under RCU, dump the snapshot from reschedulable context, and
> > destroy the snapshot.
> > 
> > In a future patch, the first stage would be moved to select_bad_process()
> > and the third stage would be moved to after oom_kill_process(), and will
> > simplify refcount handling.
> > 
> > Link: http://lkml.kernel.org/r/1563360901-8277-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Cc: Shakeel Butt <shakeelb@google.com>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Roman Gushchin <guro@fb.com>
> > Cc: David Rientjes <rientjes@google.com>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> > 
> >  include/linux/sched.h |    1 
> >  mm/oom_kill.c         |   67 +++++++++++++++++++---------------------
> >  2 files changed, 34 insertions(+), 34 deletions(-)
> > 
> > --- a/include/linux/sched.h~mm-oom-avoid-printk-iteration-under-rcu
> > +++ a/include/linux/sched.h
> > @@ -1246,6 +1246,7 @@ struct task_struct {
> >  #ifdef CONFIG_MMU
> >  	struct task_struct		*oom_reaper_list;
> >  #endif
> > +	struct list_head		oom_victim_list;
> >  #ifdef CONFIG_VMAP_STACK
> >  	struct vm_struct		*stack_vm_area;
> >  #endif
> > --- a/mm/oom_kill.c~mm-oom-avoid-printk-iteration-under-rcu
> > +++ a/mm/oom_kill.c
> > @@ -377,36 +377,13 @@ static void select_bad_process(struct oo
> >  	}
> >  }
> >  
> > -static int dump_task(struct task_struct *p, void *arg)
> > -{
> > -	struct oom_control *oc = arg;
> > -	struct task_struct *task;
> > -
> > -	if (oom_unkillable_task(p))
> > -		return 0;
> >  
> > -	/* p may not have freeable memory in nodemask */
> > -	if (!is_memcg_oom(oc) && !oom_cpuset_eligible(p, oc))
> > -		return 0;
> > -
> > -	task = find_lock_task_mm(p);
> > -	if (!task) {
> > -		/*
> > -		 * This is a kthread or all of p's threads have already
> > -		 * detached their mm's.  There's no need to report
> > -		 * them; they can't be oom killed anyway.
> > -		 */
> > -		return 0;
> > +static int add_candidate_task(struct task_struct *p, void *arg)
> > +{
> > +	if (!oom_unkillable_task(p)) {
> > +		get_task_struct(p);
> > +		list_add_tail(&p->oom_victim_list, (struct list_head *) arg);
> >  	}
> > -
> > -	pr_info("[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %s\n",
> > -		task->pid, from_kuid(&init_user_ns, task_uid(task)),
> > -		task->tgid, task->mm->total_vm, get_mm_rss(task->mm),
> > -		mm_pgtables_bytes(task->mm),
> > -		get_mm_counter(task->mm, MM_SWAPENTS),
> > -		task->signal->oom_score_adj, task->comm);
> > -	task_unlock(task);
> > -
> >  	return 0;
> >  }
> >  
> > @@ -422,19 +399,41 @@ static int dump_task(struct task_struct
> >   */
> >  static void dump_tasks(struct oom_control *oc)
> >  {
> > -	pr_info("Tasks state (memory values in pages):\n");
> > -	pr_info("[  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name\n");
> > +	static LIST_HEAD(list);
> > +	struct task_struct *p;
> > +	struct task_struct *t;
> >  
> >  	if (is_memcg_oom(oc))
> > -		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
> > +		mem_cgroup_scan_tasks(oc->memcg, add_candidate_task, &list);
> >  	else {
> > -		struct task_struct *p;
> > -
> >  		rcu_read_lock();
> >  		for_each_process(p)
> > -			dump_task(p, oc);
> > +			add_candidate_task(p, &list);
> >  		rcu_read_unlock();
> >  	}
> > +	pr_info("Tasks state (memory values in pages):\n");
> > +	pr_info("[  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name\n");
> > +	list_for_each_entry(p, &list, oom_victim_list) {
> > +		cond_resched();
> > +		/* p may not have freeable memory in nodemask */
> > +		if (!is_memcg_oom(oc) && !oom_cpuset_eligible(p, oc))
> > +			continue;
> > +		/* All of p's threads might have already detached their mm's. */
> > +		t = find_lock_task_mm(p);
> > +		if (!t)
> > +			continue;
> > +		pr_info("[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %s\n",
> > +			t->pid, from_kuid(&init_user_ns, task_uid(t)),
> > +			t->tgid, t->mm->total_vm, get_mm_rss(t->mm),
> > +			mm_pgtables_bytes(t->mm),
> > +			get_mm_counter(t->mm, MM_SWAPENTS),
> > +			t->signal->oom_score_adj, t->comm);
> > +		task_unlock(t);
> > +	}
> > +	list_for_each_entry_safe(p, t, &list, oom_victim_list) {
> > +		list_del(&p->oom_victim_list);
> > +		put_task_struct(p);
> > +	}
> >  }
> >  
> >  static void dump_oom_summary(struct oom_control *oc, struct task_struct *victim)
> > _
> > 
> > Patches currently in -mm which might be from penguin-kernel@I-love.SAKURA.ne.jp are
> > 
> > mm-oom-avoid-printk-iteration-under-rcu.patch
> > info-task-hung-in-generic_file_write_iter.patch
> > info-task-hung-in-generic_file_write-fix.patch
> > kexec-bail-out-upon-sigkill-when-allocating-memory.patch
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Michal Hocko
SUSE Labs
