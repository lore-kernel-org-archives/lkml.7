Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881BDC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E50D206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfDYO06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:26:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfDYO05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:26:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1EBE49D0C1;
        Thu, 25 Apr 2019 14:26:57 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 16C115D71A;
        Thu, 25 Apr 2019 14:26:55 +0000 (UTC)
Date:   Thu, 25 Apr 2019 10:26:53 -0400
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
Subject: Re: [RFC PATCH v2 12/17] sched: A quick and dirty cgroup tagging
 interface
Message-ID: <20190425142652.GA979@pauld.bos.csb>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <b058b74f303fe40e5822925c90a5b0161c4a0a2d.1556025155.git.vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b058b74f303fe40e5822925c90a5b0161c4a0a2d.1556025155.git.vpillai@digitalocean.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 25 Apr 2019 14:26:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 04:18:17PM +0000 Vineeth Remanan Pillai wrote:
> From: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Marks all tasks in a cgroup as matching for core-scheduling.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/core.c  | 62 ++++++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/sched.h |  4 +++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5066a1493acf..e5bdc1c4d8d7 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6658,6 +6658,15 @@ static void sched_change_group(struct task_struct *tsk, int type)
>  	tg = container_of(task_css_check(tsk, cpu_cgrp_id, true),
>  			  struct task_group, css);
>  	tg = autogroup_task_group(tsk, tg);
> +
> +#ifdef CONFIG_SCHED_CORE
> +	if ((unsigned long)tsk->sched_task_group == tsk->core_cookie)
> +		tsk->core_cookie = 0UL;
> +
> +	if (tg->tagged /* && !tsk->core_cookie ? */)
> +		tsk->core_cookie = (unsigned long)tg;
> +#endif
> +
>  	tsk->sched_task_group = tg;
>  
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> @@ -7117,6 +7126,43 @@ static u64 cpu_rt_period_read_uint(struct cgroup_subsys_state *css,
>  }
>  #endif /* CONFIG_RT_GROUP_SCHED */
>  
> +#ifdef CONFIG_SCHED_CORE
> +static u64 cpu_core_tag_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
> +{
> +	struct task_group *tg = css_tg(css);
> +
> +	return !!tg->tagged;
> +}
> +
> +static int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype *cft, u64 val)
> +{
> +	struct task_group *tg = css_tg(css);
> +	struct css_task_iter it;
> +	struct task_struct *p;
> +
> +	if (val > 1)
> +		return -ERANGE;
> +
> +	if (tg->tagged == !!val)
> +		return 0;
> +
> +	tg->tagged = !!val;
> +
> +	if (!!val)
> +		sched_core_get();
> +
> +	css_task_iter_start(css, 0, &it);
> +	while ((p = css_task_iter_next(&it)))
> +		p->core_cookie = !!val ? (unsigned long)tg : 0UL;
> +	css_task_iter_end(&it);
> +
> +	if (!val)
> +		sched_core_put();
> +
> +	return 0;
> +}
> +#endif
> +
>  static struct cftype cpu_legacy_files[] = {
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  	{
> @@ -7152,6 +7198,14 @@ static struct cftype cpu_legacy_files[] = {
>  		.read_u64 = cpu_rt_period_read_uint,
>  		.write_u64 = cpu_rt_period_write_uint,
>  	},
> +#endif
> +#ifdef CONFIG_SCHED_CORE
> +	{
> +		.name = "tag",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.read_u64 = cpu_core_tag_read_u64,
> +		.write_u64 = cpu_core_tag_write_u64,
> +	},
>  #endif
>  	{ }	/* Terminate */
>  };
> @@ -7319,6 +7373,14 @@ static struct cftype cpu_files[] = {
>  		.seq_show = cpu_max_show,
>  		.write = cpu_max_write,
>  	},
> +#endif
> +#ifdef CONFIG_SCHED_CORE
> +	{
> +		.name = "tag",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.read_u64 = cpu_core_tag_read_u64,
> +		.write_u64 = cpu_core_tag_write_u64,
> +	},
>  #endif
>  	{ }	/* terminate */
>  };
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 42dd620797d7..16fb236eab7b 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -363,6 +363,10 @@ struct cfs_bandwidth {
>  struct task_group {
>  	struct cgroup_subsys_state css;
>  
> +#ifdef CONFIG_SCHED_CORE
> +	int			tagged;
> +#endif
> +
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  	/* schedulable entities of this group on each CPU */
>  	struct sched_entity	**se;
> -- 
> 2.17.1
> 

Since CPU0 never goes through the cpu add code it will never get initialized if
it's the only cpu and then enabling core scheduling and adding a task crashes.

Since there is no point in using core sched in this case maybe just disallow it 
with something the below?


Cheers,
Phil

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e8e5f26db052..b312ea1e28a4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7541,6 +7541,9 @@ static int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype
        if (val > 1)
                return -ERANGE;
 
+       if (num_online_cpus() <= 1) 
+               return -EINVAL;
+
        if (tg->tagged == !!val)
                return 0;
 



-- 
