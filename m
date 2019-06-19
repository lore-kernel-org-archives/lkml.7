Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16696C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54D52182B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="jkKAK39E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbfFSOgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 10:36:46 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37913 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfFSOgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 10:36:46 -0400
Received: by mail-qt1-f194.google.com with SMTP id n11so20121988qtl.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 07:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=suKEWGpyThEbvGliWJnXxkDrkW3hdt2fMxDOmH0W/iQ=;
        b=jkKAK39Ehd81ENyUYLvizcjlCygJT8hLwTNcBKcN7q7HacnXs4oYeWKDDF6J7EAkJF
         V2ie5M7c3uFvOBHyowsSs3LkXs2FGoUJnrd2BWVOzH5xueTZ7d9rq+wb9r3pyHJhQM5X
         QrJwOAFnfx2i2BGH5TM+OT2Q3RIGqbSImlwqVVEXZu7grimljON/ISeE5bf8EG5MdSr5
         Fn2sR7J7J/yDZWKBW1hpb+GJq57NLnLRkd5TKMbTcSdSXj83jQ3GdhHoejVMiRb8lhCx
         i44l5hNhxYG9m9av7yXr1+Bysb5/Bs3adomTzt3Gj0Z0jW+g2opCzfypuAILnoOcBxSI
         D8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=suKEWGpyThEbvGliWJnXxkDrkW3hdt2fMxDOmH0W/iQ=;
        b=WU82FZm0dvN+bKHyG8lH0Mnf3g+D88Upf8DBD6tM6sUKxmgGogdCGITBIus8ksa+oP
         aTxane5N+zaL6ywTopmjxtSRRY07AYjSODu6wLHbH5Trt2JHU3LDBDBYVmZ9hbZL1Wc9
         zZpYLKFyHjMB+YNUxRyettadi9Ass+Xn1qGr/I/kTVOQIvnb1MfuF1CFe7c43zGdM5PX
         MDI1E6QtUd9boXfcmCQpJRifNrr5ChI0rIPiWPImET+okdne2qiKv+EqRJBLfqFhjj6F
         dVLqcwZpX/5hQ+gn4OZbqN+JRDalGclAoiSmRod7L436AbiBVIMcZMFredcor2zRNHFT
         hijQ==
X-Gm-Message-State: APjAAAUF7Qbsfn78rmBVlyDq52C48fINskf/xN27uTI6i5wSO3mSuWeQ
        5VCKLm7eLTivd2RlTTAVy3/Zvw==
X-Google-Smtp-Source: APXvYqzEPNZt97retGqRkXI1H6z6RGleWxl4Elkmkni5j/Sxdyn3dRzuMBcD/QDrHAF7HnaE+pHm2A==
X-Received: by 2002:a0c:9305:: with SMTP id d5mr34124353qvd.83.1560955004537;
        Wed, 19 Jun 2019 07:36:44 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o5sm6372200qkf.10.2019.06.19.07.36.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 07:36:44 -0700 (PDT)
Message-ID: <1560955002.5154.30.camel@lca.pw>
Subject: Re: [PATCH v2] sched/core: clean up sched_init() a bit
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     mingo@kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Date:   Wed, 19 Jun 2019 10:36:42 -0400
In-Reply-To: <1559681162-5385-1-git-send-email-cai@lca.pw>
References: <1559681162-5385-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping.

On Tue, 2019-06-04 at 16:46 -0400, Qian Cai wrote:
> Compiling a kernel with both FAIR_GROUP_SCHED=n and RT_GROUP_SCHED=n
> will generate a warning using W=1:
> 
>   kernel/sched/core.c: In function 'sched_init':
>   kernel/sched/core.c:5906:32: warning: variable 'ptr' set but not used
> 
> Use this opportunity to tidy up a code a bit by removing unnecssary
> indentations, #endif comments and lines.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
> 
> v2: Fix an oversight when both FAIR_GROUP_SCHED and RT_GROUP_SCHED
>     selected which was found by the 0day kernel testing robot.
> 
>  kernel/sched/core.c | 50 +++++++++++++++++++++++---------------------------
>  1 file changed, 23 insertions(+), 27 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 874c427742a9..edebd5e97542 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5903,36 +5903,31 @@ int in_sched_functions(unsigned long addr)
>  void __init sched_init(void)
>  {
>  	int i, j;
> -	unsigned long alloc_size = 0, ptr;
> -
> -	wait_bit_init();
> -
> -#ifdef CONFIG_FAIR_GROUP_SCHED
> -	alloc_size += 2 * nr_cpu_ids * sizeof(void **);
> +#if defined(CONFIG_FAIR_GROUP_SCHED) && defined(CONFIG_RT_GROUP_SCHED)
> +	unsigned long alloc_size = 4 * nr_cpu_ids * sizeof(void **);
> +	unsigned long ptr = (unsigned long)kzalloc(alloc_size, GFP_NOWAIT);
> +#elif defined(CONFIG_FAIR_GROUP_SCHED) || defined(CONFIG_RT_GROUP_SCHED)
> +	unsigned long alloc_size = 2 * nr_cpu_ids * sizeof(void **);
> +	unsigned long ptr = (unsigned long)kzalloc(alloc_size, GFP_NOWAIT);
>  #endif
> -#ifdef CONFIG_RT_GROUP_SCHED
> -	alloc_size += 2 * nr_cpu_ids * sizeof(void **);
> -#endif
> -	if (alloc_size) {
> -		ptr = (unsigned long)kzalloc(alloc_size, GFP_NOWAIT);
> +	wait_bit_init();
>  
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> -		root_task_group.se = (struct sched_entity **)ptr;
> -		ptr += nr_cpu_ids * sizeof(void **);
> +	root_task_group.se = (struct sched_entity **)ptr;
> +	ptr += nr_cpu_ids * sizeof(void **);
>  
> -		root_task_group.cfs_rq = (struct cfs_rq **)ptr;
> -		ptr += nr_cpu_ids * sizeof(void **);
> +	root_task_group.cfs_rq = (struct cfs_rq **)ptr;
> +	ptr += nr_cpu_ids * sizeof(void **);
>  
> -#endif /* CONFIG_FAIR_GROUP_SCHED */
> +#endif
>  #ifdef CONFIG_RT_GROUP_SCHED
> -		root_task_group.rt_se = (struct sched_rt_entity **)ptr;
> -		ptr += nr_cpu_ids * sizeof(void **);
> +	root_task_group.rt_se = (struct sched_rt_entity **)ptr;
> +	ptr += nr_cpu_ids * sizeof(void **);
>  
> -		root_task_group.rt_rq = (struct rt_rq **)ptr;
> -		ptr += nr_cpu_ids * sizeof(void **);
> +	root_task_group.rt_rq = (struct rt_rq **)ptr;
> +	ptr += nr_cpu_ids * sizeof(void **);
>  
> -#endif /* CONFIG_RT_GROUP_SCHED */
> -	}
> +#endif
>  #ifdef CONFIG_CPUMASK_OFFSTACK
>  	for_each_possible_cpu(i) {
>  		per_cpu(load_balance_mask, i) = (cpumask_var_t)kzalloc_node(
> @@ -5940,7 +5935,7 @@ void __init sched_init(void)
>  		per_cpu(select_idle_mask, i) = (cpumask_var_t)kzalloc_node(
>  			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
>  	}
> -#endif /* CONFIG_CPUMASK_OFFSTACK */
> +#endif
>  
>  	init_rt_bandwidth(&def_rt_bandwidth, global_rt_period(),
> global_rt_runtime());
>  	init_dl_bandwidth(&def_dl_bandwidth, global_rt_period(),
> global_rt_runtime());
> @@ -5950,9 +5945,9 @@ void __init sched_init(void)
>  #endif
>  
>  #ifdef CONFIG_RT_GROUP_SCHED
> -	init_rt_bandwidth(&root_task_group.rt_bandwidth,
> -			global_rt_period(), global_rt_runtime());
> -#endif /* CONFIG_RT_GROUP_SCHED */
> +	init_rt_bandwidth(&root_task_group.rt_bandwidth, global_rt_period(),
> +			  global_rt_runtime());
> +#endif
>  
>  #ifdef CONFIG_CGROUP_SCHED
>  	task_group_cache = KMEM_CACHE(task_group, 0);
> @@ -5961,7 +5956,7 @@ void __init sched_init(void)
>  	INIT_LIST_HEAD(&root_task_group.children);
>  	INIT_LIST_HEAD(&root_task_group.siblings);
>  	autogroup_init(&init_task);
> -#endif /* CONFIG_CGROUP_SCHED */
> +#endif
>  
>  	for_each_possible_cpu(i) {
>  		struct rq *rq;
> @@ -6031,6 +6026,7 @@ void __init sched_init(void)
>  		rq->last_blocked_load_update_tick = jiffies;
>  		atomic_set(&rq->nohz_flags, 0);
>  #endif
> +
>  #endif /* CONFIG_SMP */
>  		hrtick_rq_init(rq);
>  		atomic_set(&rq->nr_iowait, 0);
