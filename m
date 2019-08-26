Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FB3C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDF2217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfHZU7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 16:59:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:48543 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbfHZU7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:59:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 13:59:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="182563708"
Received: from mgross-mobl.amr.corp.intel.com (HELO localhost) ([10.7.198.58])
  by orsmga003.jf.intel.com with ESMTP; 26 Aug 2019 13:59:03 -0700
Date:   Mon, 26 Aug 2019 13:59:03 -0700
From:   mark gross <mgross@linux.intel.com>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v3 11/16] sched: Basic tracking of matching tasks
Message-ID: <20190826205903.GH2680@u1904>
Reply-To: mgross@linux.intel.com
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <d74f10401c5d220265a5918de0de13a8986d59a2.1559129225.git.vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d74f10401c5d220265a5918de0de13a8986d59a2.1559129225.git.vpillai@digitalocean.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 08:36:47PM +0000, Vineeth Remanan Pillai wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Introduce task_struct::core_cookie as an opaque identifier for core
> scheduling. When enabled; core scheduling will only allow matching
> task to be on the core; where idle matches everything.
> 
> When task_struct::core_cookie is set (and core scheduling is enabled)
> these tasks are indexed in a second RB-tree, first on cookie value
> then on scheduling function, such that matching task selection always
> finds the most elegible match.
> 
> NOTE: *shudder* at the overhead...
> 
> NOTE: *sigh*, a 3rd copy of the scheduling function; the alternative
> is per class tracking of cookies and that just duplicates a lot of
> stuff for no raisin (the 2nd copy lives in the rt-mutex PI code).
 s/raisen/reason

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
> Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
> ---
> 
> Changes in v3
> -------------
> - Refactored priority comparison code
> - Fixed a comparison logic issue in sched_core_find
>   - Aaron Lu
> 
> Changes in v2
> -------------
> - Improves the priority comparison logic between processes in
>   different cpus.
>   - Peter Zijlstra
>   - Aaron Lu
> 
> ---
>  include/linux/sched.h |   8 ++-
>  kernel/sched/core.c   | 146 ++++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/fair.c   |  46 -------------
>  kernel/sched/sched.h  |  55 ++++++++++++++++
>  4 files changed, 208 insertions(+), 47 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 1549584a1538..a4b39a28236f 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -636,10 +636,16 @@ struct task_struct {
>  	const struct sched_class	*sched_class;
>  	struct sched_entity		se;
>  	struct sched_rt_entity		rt;
> +	struct sched_dl_entity		dl;
> +
> +#ifdef CONFIG_SCHED_CORE
> +	struct rb_node			core_node;
> +	unsigned long			core_cookie;
> +#endif
> +
>  #ifdef CONFIG_CGROUP_SCHED
>  	struct task_group		*sched_task_group;
>  #endif
> -	struct sched_dl_entity		dl;
>  
>  #ifdef CONFIG_PREEMPT_NOTIFIERS
>  	/* List of struct preempt_notifier: */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b1ce33f9b106..112d70f2b1e5 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -64,6 +64,141 @@ int sysctl_sched_rt_runtime = 950000;
>  
>  DEFINE_STATIC_KEY_FALSE(__sched_core_enabled);
>  
> +/* kernel prio, less is more */
> +static inline int __task_prio(struct task_struct *p)
> +{
> +	if (p->sched_class == &stop_sched_class) /* trumps deadline */
> +		return -2;
> +
> +	if (rt_prio(p->prio)) /* includes deadline */
> +		return p->prio; /* [-1, 99] */
> +
> +	if (p->sched_class == &idle_sched_class)
> +		return MAX_RT_PRIO + NICE_WIDTH; /* 140 */
> +
> +	return MAX_RT_PRIO + MAX_NICE; /* 120, squash fair */
> +}
> +
> +/*
> + * l(a,b)
> + * le(a,b) := !l(b,a)
> + * g(a,b)  := l(b,a)
> + * ge(a,b) := !l(a,b)
why does this truth table comment exist?
maybe inline comments at the confusing inequalities would be better.
--mark


