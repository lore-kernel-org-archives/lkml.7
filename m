Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F27C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E26206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gww6filz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732647AbfCZSnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:43:49 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33727 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732561AbfCZSns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:43:48 -0400
Received: by mail-pl1-f193.google.com with SMTP id bg8so2038104plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vGHxDRbS/6yolL/adNeLRruWuHT6NB7eWlWIx8+XjvU=;
        b=gww6filzbPExhR6qzMRQnTCop6Av5na2TthQoV/QeGa67VXI9i/Z1BCgbLkvNzdrNU
         cP0Qyb606jhzgHXzKqPbY7fUXgbRDXbU/+dryjm8G8tYa0hPhNG5nDSKir3zMw6/Pl1H
         70gsFon/xaML4byBDCpQfTkwbPtaef5dPGwTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vGHxDRbS/6yolL/adNeLRruWuHT6NB7eWlWIx8+XjvU=;
        b=BXoEwQve58TzdN5hIRP+lEAZncnWvsAz2UbW71b7/AR5SSwQP/qaOK9ZK2U2aMCVnH
         Mqzlp3pAOuFv7KL/eSSJRwrMcZ1g0EqgxHmGQQ+o1Qk6rLHFbGZDNuYdzrIYQdESRzYD
         IrMyfB2xVqmkyHi7xPKz3U/h3pA2pB1kBy6eOj0sincnV0TbQJsfpVnElynyvGX7KHhd
         qaX3kimUL1J8pyHIbdgbLc1qqT3kENNo/tKHOA1+TnPrZw7PY5wQR9xoXG1mzt+FuNY4
         DvRTW+CAcVAtx3kgg6mWOSWwduNRGgca3FhGjZXoHvFu3it7/LSJncc+mnHZFg+FFdni
         FVTg==
X-Gm-Message-State: APjAAAWp4vMa0XEax/263t0Uz6sLUv5Kif4HUuYOkQKc5cSX9xfNOD7v
        5mAPbtryMBlS7JO5BCOkkKIm1sMPu+E=
X-Google-Smtp-Source: APXvYqwE/E/Y7PUn3zcnGNBoOmjUnCDapV/wnSH53R1Qfb98x2zAnU56RgSLxkiLSYyEB+kLQtqe7A==
X-Received: by 2002:a17:902:8609:: with SMTP id f9mr33006813plo.85.1553625828180;
        Tue, 26 Mar 2019 11:43:48 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id r86sm30619660pfa.82.2019.03.26.11.43.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 11:43:47 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:43:46 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Kyle Lin <linkyle0915@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: stats: Use lock by stat to replace global spin
 lock
Message-ID: <20190326184346.GY112750@google.com>
References: <20190325072933.215946-1-linkyle0915@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190325072933.215946-1-linkyle0915@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 03:29:33PM +0800, Kyle Lin wrote:
> Stats is updated by each policy, using the lock by stat can
> reduce the contention.
> 
> Signed-off-by: Kyle Lin <linkyle0915@gmail.com>
> ---
>  drivers/cpufreq/cpufreq_stats.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index e2db5581489a..17beb1bc7e16 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -14,7 +14,6 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  
> -static DEFINE_SPINLOCK(cpufreq_stats_lock);
>  
>  struct cpufreq_stats {
>  	unsigned int total_trans;
> @@ -23,6 +22,7 @@ struct cpufreq_stats {
>  	unsigned int state_num;
>  	unsigned int last_index;
>  	u64 *time_in_state;
> +	spinlock_t lock;        /*spinlock for stats update*/

nit: not sure if the comment adds much value. If it stay there it
needs a blank after '/*' and another before '*/'

>  	unsigned int *freq_table;
>  	unsigned int *trans_table;
>  };
> @@ -39,12 +39,12 @@ static void cpufreq_stats_clear_table(struct cpufreq_stats *stats)
>  {
>  	unsigned int count = stats->max_state;
>  
> -	spin_lock(&cpufreq_stats_lock);
> +	spin_lock(&stats->lock);
>  	memset(stats->time_in_state, 0, count * sizeof(u64));
>  	memset(stats->trans_table, 0, count * count * sizeof(int));
>  	stats->last_time = get_jiffies_64();
>  	stats->total_trans = 0;
> -	spin_unlock(&cpufreq_stats_lock);
> +	spin_unlock(&stats->lock);
>  }
>  
>  static ssize_t show_total_trans(struct cpufreq_policy *policy, char *buf)
> @@ -62,9 +62,9 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
>  	if (policy->fast_switch_enabled)
>  		return 0;
>  
> -	spin_lock(&cpufreq_stats_lock);
> +	spin_lock(&stats->lock);
>  	cpufreq_stats_update(stats);
> -	spin_unlock(&cpufreq_stats_lock);
> +	spin_unlock(&stats->lock);
>  
>  	for (i = 0; i < stats->state_num; i++) {
>  		len += sprintf(buf + len, "%u %llu\n", stats->freq_table[i],
> @@ -211,6 +211,7 @@ void cpufreq_stats_create_table(struct cpufreq_policy *policy)
>  	stats->state_num = i;
>  	stats->last_time = get_jiffies_64();
>  	stats->last_index = freq_table_get_index(stats, policy->cur);
> +	spin_lock_init(&stats->lock);
>  
>  	policy->stats = stats;
>  	ret = sysfs_create_group(&policy->kobj, &stats_attr_group);
> @@ -242,11 +243,11 @@ void cpufreq_stats_record_transition(struct cpufreq_policy *policy,
>  	if (old_index == -1 || new_index == -1 || old_index == new_index)
>  		return;
>  
> -	spin_lock(&cpufreq_stats_lock);
> +	spin_lock(&stats->lock);
>  	cpufreq_stats_update(stats);
>  
>  	stats->last_index = new_index;
>  	stats->trans_table[old_index * stats->max_state + new_index]++;
>  	stats->total_trans++;
> -	spin_unlock(&cpufreq_stats_lock);
> +	spin_unlock(&stats->lock);
>  }

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
