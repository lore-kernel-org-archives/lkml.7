Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D4CC004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 10:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E8621670
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 10:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfEAKoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 06:44:18 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52866 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfEAKoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 06:44:17 -0400
Received: from 79.184.254.69.ipv4.supernova.orange.pl (79.184.254.69) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 5fa0b5174c139008; Wed, 1 May 2019 12:44:15 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, tobin@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Fix kobject memleak
Date:   Wed, 01 May 2019 12:44:15 +0200
Message-ID: <1632168.ncxJcclsFx@kreacher>
In-Reply-To: <815f7c7cea02e05c90d5bf678ea8717f01cc9f63.1556604312.git.viresh.kumar@linaro.org>
References: <815f7c7cea02e05c90d5bf678ea8717f01cc9f63.1556604312.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 30, 2019 8:05:52 AM CEST Viresh Kumar wrote:
> Currently the error return path from kobject_init_and_add() is not
> followed by a call to kobject_put() - which means we are leaking the
> kobject.
> 
> Fix it by adding a call to kobject_put() in the error path of
> kobject_init_and_add().
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Tobin fixed this for schedutil already.
> 
>  drivers/cpufreq/cpufreq.c          | 1 +
>  drivers/cpufreq/cpufreq_governor.c | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e10922709d13..bbf79544d0ad 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1098,6 +1098,7 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>  				   cpufreq_global_kobject, "policy%u", cpu);
>  	if (ret) {
>  		pr_err("%s: failed to init policy->kobj: %d\n", __func__, ret);
> +		kobject_put(&policy->kobj);
>  		goto err_free_real_cpus;
>  	}
>  
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index ffa9adeaba31..9d1d9bf02710 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -459,6 +459,8 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
>  	/* Failure, so roll back. */
>  	pr_err("initialization failed (dbs_data kobject init error %d)\n", ret);
>  
> +	kobject_put(&dbs_data->attr_set.kobj);
> +
>  	policy->governor_data = NULL;
>  
>  	if (!have_governor_per_policy())
> 

Applied, thanks!




