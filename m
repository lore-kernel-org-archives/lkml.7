Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B80C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 18:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2819521874
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 18:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405171AbfHWSNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 14:13:55 -0400
Received: from foss.arm.com ([217.140.110.172]:37918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404488AbfHWSNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 14:13:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D373337;
        Fri, 23 Aug 2019 11:13:54 -0700 (PDT)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C4B23F246;
        Fri, 23 Aug 2019 11:13:52 -0700 (PDT)
Subject: Re: [PATCH 01/15] sched: introduce task_se_h_load helper
To:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, peterz@infradead.org,
        mingo@redhat.com, morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org,
        Josef Bacik <josef@toxicpanda.com>
References: <20190822021740.15554-1-riel@surriel.com>
 <20190822021740.15554-2-riel@surriel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <c5c07c34-b46a-6956-2341-138a83c8c800@arm.com>
Date:   Fri, 23 Aug 2019 20:13:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822021740.15554-2-riel@surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/08/2019 04:17, Rik van Riel wrote:
> Sometimes the hierarchical load of a sched_entity needs to be calculated.
> Rename task_h_load to task_se_h_load, and directly pass a sched_entity to
> that function.
> 
> Move the function declaration up above where it will be used later.
> 
> No functional changes.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---

[...]

> @@ -1668,7 +1668,7 @@ static void task_numa_compare(struct task_numa_env *env,
>  	/*
>  	 * In the overloaded case, try and keep the load balanced.
>  	 */
> -	load = task_h_load(env->p) - task_h_load(cur);
> +	load = task_se_h_load(env->p->se) - task_se_h_load(cur->se);

Shouldn't this be:

load = task_se_h_load(&env->p->se) - task_se_h_load(&cur->se);

>  	if (!load)
>  		goto assign;
>  
> @@ -1706,7 +1706,7 @@ static void task_numa_find_cpu(struct task_numa_env *env,
>  	bool maymove = false;
>  	int cpu;
>  
> -	load = task_h_load(env->p);
> +	load = task_se_h_load(env->p->se);

load = task_se_h_load(&env->p->se);

Only visible with CONFIG_NUMA_BALANCING though.

[...]
