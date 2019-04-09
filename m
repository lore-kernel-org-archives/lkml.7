Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C06BC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7DE20833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qow7hBpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfDIJ15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:27:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46449 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfDIJ14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:27:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id 9so9340011pfj.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 02:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yQ6cGU9e1HcpfNnOWrggaDgBCo6QSjXldC+bP+sxWas=;
        b=Qow7hBpJKXoR9VKRYOUbsOmFzT1Re0sZHz0gN7+SiHcFeeIWfby5kbsmfh5AHO/sH7
         8KI/cW1C2egEGJ8IZ2bZPbRib2I59hARuFHbL+a3yq9O7l+R8jK7LJzkuv+7wt2Bx8kn
         x2zqvp0YCYWwDFzdpsMWwd5TilP2tZ29zFekqRw40dzy0ylhD7c+vt7uPNWRPih/DOXD
         up58Y47qnrWrt05KAANNXEpDKjw6HHwequyoJKYOEW+cgDeGMR4rVMbhu6/EiufBdo5R
         Th6ZqIv31MIt1NQ31JnULHrmWqHhVbv3iYovcl07r6ndsEzWXVRzeSDHoWPz5C78esot
         94EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yQ6cGU9e1HcpfNnOWrggaDgBCo6QSjXldC+bP+sxWas=;
        b=O8E0qoDhQbGpufiTJk0LMQVDymH69yo0IbkalHwOwfSSjPHtjt7Gxvb3ZQKHy/kFH4
         NX8tbin6Q4MrdwYX4TNEm/DWVWwIVMrhxQcJFp6AGmOBXuQpNgIA5omAouHxDK96sXt2
         3w+p1IHfXVJkVY9EyDfbiFgKXzdnwL0mGWbEK6ye0+XVeOB7C9pTFYwB8AOG1tU3LhMx
         NcSQ5raAzJaokiUPkFHrwkGtmXm+0Zb1SKU5woiNum7zO6UeilV/e/yNB77itvKC5iIg
         k8AbKoDgjM4u5Ljfv9uRYylEMehvsAdHSALQBvoD9SmwvSg055aM4O0X37l2CpufOPCg
         J/ag==
X-Gm-Message-State: APjAAAXoKyEiAniQcLRm7JCChYx+y/aaEZUYvSR/7214rMfsSKkO7iYZ
        Dg3GOoHnSG4iS3xJbj1Q8sv3SQ==
X-Google-Smtp-Source: APXvYqwc59ErLm3IIJBSj8tQ7h3CyOPh4s3LoAQDGB/G2f8eTz+bYSkq8XEUd0DfddCX34hv/OJFbA==
X-Received: by 2002:a62:388d:: with SMTP id f135mr35358281pfa.103.1554802075765;
        Tue, 09 Apr 2019 02:27:55 -0700 (PDT)
Received: from localhost ([122.172.162.162])
        by smtp.gmail.com with ESMTPSA id v7sm44193904pgh.53.2019.04.09.02.27.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 02:27:55 -0700 (PDT)
Date:   Tue, 9 Apr 2019 14:57:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Kyle Lin <linkyle0915@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: stats: Use lock by stat to replace global
 spin lock
Message-ID: <20190409092752.kvaiq2gqjqjmy3pr@vireshk-i7>
References: <20190409084304.35855-1-linkyle0915@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409084304.35855-1-linkyle0915@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-04-19, 16:43, Kyle Lin wrote:
> Stats is updated by each policy, using the lock by stat can
> reduce the contention.
> 
> Signed-off-by: Kyle Lin <linkyle0915@gmail.com>
> ---
> Changes in v2:
>   - Drop the comment of the lock.
> 
>  drivers/cpufreq/cpufreq_stats.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index e2db5581489a..08b192eb22c6 100644
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
> +	spinlock_t lock;
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

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
