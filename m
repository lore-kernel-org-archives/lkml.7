Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639EEC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE92214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbfFYJu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 05:50:27 -0400
Received: from foss.arm.com ([217.140.110.172]:37266 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfFYJu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:50:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CC61360;
        Tue, 25 Jun 2019 02:50:26 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B62A43F71E;
        Tue, 25 Jun 2019 02:50:24 -0700 (PDT)
Subject: Re: [PATCH 8/8] sched,fair: flatten hierarchical runqueues
To:     Rik van Riel <riel@surriel.com>, peterz@infradead.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, kernel-team@fb.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        dietmar.eggeman@arm.com, mgorman@techsingularity.com,
        vincent.guittot@linaro.org
References: <20190612193227.993-1-riel@surriel.com>
 <20190612193227.993-9-riel@surriel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <960c2571-7a32-f7aa-08ca-07f1136e835d@arm.com>
Date:   Tue, 25 Jun 2019 11:50:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612193227.993-9-riel@surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/19 9:32 PM, Rik van Riel wrote:

[...]

> @@ -410,6 +412,11 @@ static inline struct sched_entity *parent_entity(struct sched_entity *se)
>  	return se->parent;
>  }
>  
> +static inline bool task_se_in_cgroup(struct sched_entity *se)
> +{
> +	return parent_entity(se);
> +}

IMHO, s/in_cgroup/not_in_root_tg/ reads easier. "/", i.e. the root tg is
still a cgroup, I guess. But you could use existing parent_entity(se) as
well.

[...]

> @@ -679,22 +710,16 @@ static inline u64 calc_delta_fair(u64 delta, struct sched_entity *se)
>  static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
>  	u64 slice = sysctl_sched_latency;
> +	struct load_weight *load = &cfs_rq->load;
> +	struct load_weight lw;
>  
> -	for_each_sched_entity(se) {
> -		struct load_weight *load;
> -		struct load_weight lw;
> +	if (unlikely(!se->on_rq)) {
> +		lw = cfs_rq->load;
>  
> -		cfs_rq = cfs_rq_of(se);
> -		load = &cfs_rq->load;
> -
> -		if (unlikely(!se->on_rq)) {
> -			lw = cfs_rq->load;
> -
> -			update_load_add(&lw, se->load.weight);
> -			load = &lw;
> -		}
> -		slice = __calc_delta(slice, se->load.weight, load);
> +		update_load_add(&lw, task_se_h_load(se));
> +		load = &lw;
>  	}
> +	slice = __calc_delta(slice, task_se_h_load(se), load);

task_se_h_load(se) and se->load.weight are off my factor of >= 1024 on
64bit.

...
    bash pid=3250: task_se_h_load(se)=1023 se->load.weight=1048576
    sysctl_sched_latency=18000000 slice=0 old_slice=17999995
...

[...]
