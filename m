Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E1DECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679292067B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nwHTtgBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbfJOKkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 06:40:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55959 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730857AbfJOKkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 06:40:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id a6so20261812wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 03:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HrnoeVNslwR6lG8sahw49jWvv99yrTs7Gkvp5r1I1Ig=;
        b=nwHTtgBgxD5BbNMb2oS/YdUtYvrpLGmimm+pnZqERwzKtX1ysuTm9XF4x+Gs9SGIFq
         puREMS6c3JJCE73NCWJ+kiTAaBHv45bHiVPg5rag31heSvIUsQLetQ7fMW04/ADfDxL5
         7JtPtkN4umPOMRlCiPWjAO+gQAeFAKwBe6CQJephFv1k3MMmcU9QJOJpHGoNcBoIdxp9
         F3TrewDbQOY2LWHxKtZtrqoggvr6CcdajD9M6PfyXeKwCjZO2jKu4Hxowu1jEUhJ3lzY
         adpj6wbdMThEp0GzipjkNaFbJrnd3PE1lfXZx/y4CBugKL2JL7HKNW7laCrRWagQlabz
         37WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HrnoeVNslwR6lG8sahw49jWvv99yrTs7Gkvp5r1I1Ig=;
        b=mnRyBYn86qFywr9TAt7frfxiZE0ociSG+uBiQLp1tNR4BS93wUbDqUGXYHH9iQv0e4
         uvJCRWMZtl+1kx0CoayNSAIoFU+8mRNjR10x7aXUqvBfz9zW+uA++H0RDh1BvOjl7Brc
         QMXOU6297DNogOhjNPBiKJO+mvmTuWlh0IHU7bt56ej4dwIxyDwhzHjS8ehAE/HlBiHE
         S/tPQDPDSdRkAOf2z8Md2sSVshqyPzY7blK/oCF6G5UB8POsyFEZW8mjAGyG3M7ALQpw
         ueU0OiPV4FM6LWT0wPqzGY94LmVnECWK6Dnt4AZmh5xA/k/1xQ8tJiWy6GqreNqHLAUL
         TyoQ==
X-Gm-Message-State: APjAAAWUzfbfymyijwiMBAPaGa1C8RyaYaBufcDeI/xSFKl+3pIL+P8m
        nbz1gfPJ6vdobMBYOjq32CJtYg==
X-Google-Smtp-Source: APXvYqxEVOWSN5i939RuKdXOBKtldyqEU+iIrvEiCoAgfnmfyGg4RVxDbSyxU5reH2bBjACogG2WBQ==
X-Received: by 2002:a7b:cc01:: with SMTP id f1mr19930049wmh.113.1571136014621;
        Tue, 15 Oct 2019 03:40:14 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:7687:11a4:4657:121d])
        by smtp.gmail.com with ESMTPSA id p12sm10465077wrm.62.2019.10.15.03.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 03:40:13 -0700 (PDT)
Date:   Tue, 15 Oct 2019 11:40:10 +0100
From:   Quentin Perret <qperret@google.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        Dietmar.Eggemann@arm.com, morten.rasmussen@arm.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] sched/topology: Allow sched_asym_cpucapacity to be
 disabled
Message-ID: <20191015104010.GA242992@google.com>
References: <20191015102956.20133-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015102956.20133-1-valentin.schneider@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 Oct 2019 at 11:29:56 (+0100), Valentin Schneider wrote:
> While the static key is correctly initialized as being disabled, it will
> remain forever enabled once turned on. This means that if we start with an
> asymmetric system and hotplug out enough CPUs to end up with an SMP system,
> the static key will remain set - which is obviously wrong. We should detect
> this and turn off things like misfit migration and capacity aware wakeups.
> 
> As Quentin pointed out, having separate root domains makes this slightly
> trickier. We could have exclusive cpusets that create an SMP island - IOW,
> the domains within this root domain will not see any asymmetry. This means
> we need to count how many asymmetric root domains we have.
> 
> Change the simple key enablement to an increment, and decrement the key
> counter when destroying domains that cover asymmetric CPUs.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: df054e8445a4 ("sched/topology: Add static_key for asymmetric CPU capacity optimizations")
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
> Changes since v1:
> 
> Use static_branch_{inc,dec} rather than enable/disable
> ---
>  kernel/sched/topology.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index b5667a273bf6..79944e969bcf 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2026,7 +2026,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>  	rcu_read_unlock();
>  
>  	if (has_asym)
> -		static_branch_enable_cpuslocked(&sched_asym_cpucapacity);
> +		static_branch_inc_cpuslocked(&sched_asym_cpucapacity);
>  
>  	if (rq && sched_debug_enabled) {
>  		pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
> @@ -2124,8 +2124,17 @@ static void detach_destroy_domains(const struct cpumask *cpu_map)
>  	int i;
>  
>  	rcu_read_lock();
> +
> +	if (static_key_enabled(&sched_asym_cpucapacity)) {
> +		unsigned int cpu = cpumask_any(cpu_map);
> +
> +		if (rcu_dereference(per_cpu(sd_asym_cpucapacity, cpu)))
> +			static_branch_dec_cpuslocked(&sched_asym_cpucapacity);

Lockdep should scream for this :)
> +	}
> +
>  	for_each_cpu(i, cpu_map)
>  		cpu_attach_domain(NULL, &def_root_domain, i);
> +
>  	rcu_read_unlock();
>  }
>  
> -- 
> 2.22.0
> 
