Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017C2CA9ECB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF14120820
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fbpBVFrm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442107AbfJRFzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:55:22 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39330 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfJRFzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:55:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id s17so2303958plp.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jhj5acs+PXmeUfMBtdKuhdyHu1t+D+63FNBd/hhDsrM=;
        b=fbpBVFrmr2MAyINF88xCyejkHjJcMROZSJOe964rSwXEPe91/Uimo/j061eyhnaCTR
         Zmxz0BFwIFdqDSqJ8zl6VjV+xZMy1Qfw/MQNf33/ORqHwjS+/6WVx4xhg8Y3HhE3bf/w
         Njkpiw8XM3FD8uiVSen6lhdcc3XrcfM/yY4Zr/RnYy4cXBswWKKgBr98b969jQ0xW7rY
         GEmy8+BJFlOad8z7o3M186HH5sMmRav6HsU0pjzAHLqgvLOMv/fI/fP0wVmqEGJwGwdg
         Rx4BcQiOVVi3SkmEaQMpOIeS4mi1dYLxr5mQrCCsgI8A8fmn60a4X4Pvw0Qukn6MzGqn
         1xBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jhj5acs+PXmeUfMBtdKuhdyHu1t+D+63FNBd/hhDsrM=;
        b=ZTubYcIEQu1wgXNNaDtBhJhsz+0oRyFcARK6PxVRMLjZJ/Y5C2YeVJZybJ/VxKwWt2
         PNP1r/Lexi1h2MMt+vfA4HMzeOWd3nYxqP8zyeKqG3wlj/BFk9eBKFLFfN1O/EfBBwYK
         /30c4zXsQjKgIuqEnloGJ6Ao+WXLHp74uyDvF9cL8XruORX8Mz92bKrmWfjOpDG0cChg
         1wm/ML9ffAgsE1dSw1C2F9bSogLd1WoOq1WIQ+C4E+RsalKuiuNB9BOc4fW3SwBh7pqh
         vRR3PnPfyuL6PJLx10w5+e5mAEhds/v00Ht5V3o/UC5jqFkKICKyTMOAatdGryqykrhs
         1crQ==
X-Gm-Message-State: APjAAAVWXnZjbHToa/AQti44Shc3ESORJoro3ifi3Y2j1HjvaOlf4lZs
        xBZgXa3oer3klls+QgmJVYrlsJiBd7A=
X-Google-Smtp-Source: APXvYqxt1xXRiOY/leyZfSqe0nDCdfAxLTEhPPzyU5fvFugPpuONO1CmLVpro/ICFyy1qUsLGHYwpg==
X-Received: by 2002:a17:902:8b83:: with SMTP id ay3mr7942817plb.269.1571378119684;
        Thu, 17 Oct 2019 22:55:19 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id y4sm6533255pfr.118.2019.10.17.22.55.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 22:55:18 -0700 (PDT)
Date:   Fri, 18 Oct 2019 11:25:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, nico@fluxnic.net
Subject: Re: [PATCH v2 5/5] cpufreq: vexpress-spc: fix some coding style
 issues
Message-ID: <20191018055517.dxyx4ara7hdmzw5j@vireshk-i7>
References: <20191017123508.26130-1-sudeep.holla@arm.com>
 <20191017123508.26130-6-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017123508.26130-6-sudeep.holla@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-10-19, 13:35, Sudeep Holla wrote:
> Fix the following checkpatch checks/warnings:
> 
> CHECK: Unnecessary parentheses around the code
> CHECK: Alignment should match open parenthesis
> CHECK: Prefer kernel type 'u32' over 'uint32_t'
> WARNING: Missing a blank line after declarations
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpufreq/vexpress-spc-cpufreq.c | 43 ++++++++++++--------------
>  1 file changed, 20 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
> index 81064430317f..8ecb2961be86 100644
> --- a/drivers/cpufreq/vexpress-spc-cpufreq.c
> +++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
> @@ -79,8 +79,8 @@ static unsigned int find_cluster_maxfreq(int cluster)
>  	for_each_online_cpu(j) {
>  		cpu_freq = per_cpu(cpu_last_req_freq, j);
>  
> -		if ((cluster == per_cpu(physical_cluster, j)) &&
> -				(max_freq < cpu_freq))
> +		if (cluster == per_cpu(physical_cluster, j) &&
> +		    max_freq < cpu_freq)
>  			max_freq = cpu_freq;
>  	}
>  
> @@ -188,22 +188,19 @@ static int ve_spc_cpufreq_set_target(struct cpufreq_policy *policy,
>  	freqs_new = freq_table[cur_cluster][index].frequency;
>  
>  	if (is_bL_switching_enabled()) {
> -		if ((actual_cluster == A15_CLUSTER) &&
> -				(freqs_new < clk_big_min)) {
> +		if (actual_cluster == A15_CLUSTER && freqs_new < clk_big_min)
>  			new_cluster = A7_CLUSTER;
> -		} else if ((actual_cluster == A7_CLUSTER) &&
> -				(freqs_new > clk_little_max)) {
> +		else if (actual_cluster == A7_CLUSTER &&
> +			 freqs_new > clk_little_max)
>  			new_cluster = A15_CLUSTER;
> -		}
>  	}
>  
>  	ret = ve_spc_cpufreq_set_rate(cpu, actual_cluster, new_cluster,
>  				      freqs_new);
>  
> -	if (!ret) {
> +	if (!ret)

That's not the standard way in Linux I believe. We do use {} even when
the body is single line but broken into two, like below.

>  		arch_set_freq_scale(policy->related_cpus, freqs_new,
>  				    policy->cpuinfo.max_freq);
> -	}
>  
>  	return ret;
>  }
> @@ -222,7 +219,8 @@ static inline u32 get_table_count(struct cpufreq_frequency_table *table)
>  static inline u32 get_table_min(struct cpufreq_frequency_table *table)
>  {
>  	struct cpufreq_frequency_table *pos;
> -	uint32_t min_freq = ~0;
> +	u32 min_freq = ~0;
> +
>  	cpufreq_for_each_entry(pos, table)
>  		if (pos->frequency < min_freq)
>  			min_freq = pos->frequency;
> @@ -233,7 +231,8 @@ static inline u32 get_table_min(struct cpufreq_frequency_table *table)
>  static inline u32 get_table_max(struct cpufreq_frequency_table *table)
>  {
>  	struct cpufreq_frequency_table *pos;
> -	uint32_t max_freq = 0;
> +	u32 max_freq = 0;
> +
>  	cpufreq_for_each_entry(pos, table)
>  		if (pos->frequency > max_freq)
>  			max_freq = pos->frequency;
> @@ -255,14 +254,11 @@ static int merge_cluster_tables(void)
>  	freq_table[MAX_CLUSTERS] = table;
>  
>  	/* Add in reverse order to get freqs in increasing order */
> -	for (i = MAX_CLUSTERS - 1; i >= 0; i--) {
> +	for (i = MAX_CLUSTERS - 1; i >= 0; i--)
>  		for (j = 0; freq_table[i][j].frequency != CPUFREQ_TABLE_END;
> -				j++) {
> -			table[k].frequency = VIRT_FREQ(i,
> -					freq_table[i][j].frequency);
> -			k++;
> -		}
> -	}
> +		     j++, k++)

same here, please keep {}.

> +			table[k].frequency =
> +				VIRT_FREQ(i, freq_table[i][j].frequency);
>  
>  	table[k].driver_data = k;
>  	table[k].frequency = CPUFREQ_TABLE_END;
> @@ -332,13 +328,13 @@ static int _get_cluster_clk_and_freq_table(struct device *cpu_dev,
>  		return 0;
>  
>  	dev_err(cpu_dev, "%s: Failed to get clk for cpu: %d, cluster: %d\n",
> -			__func__, cpu_dev->id, cluster);
> +		__func__, cpu_dev->id, cluster);
>  	ret = PTR_ERR(clk[cluster]);
>  	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table[cluster]);
>  
>  out:
>  	dev_err(cpu_dev, "%s: Failed to get data for cluster: %d\n", __func__,
> -			cluster);
> +		cluster);
>  	return ret;
>  }
>  
> @@ -406,7 +402,7 @@ static int ve_spc_cpufreq_init(struct cpufreq_policy *policy)
>  	cpu_dev = get_cpu_device(policy->cpu);
>  	if (!cpu_dev) {
>  		pr_err("%s: failed to get cpu%d device\n", __func__,
> -				policy->cpu);
> +		       policy->cpu);
>  		return -ENODEV;
>  	}
>  
> @@ -432,7 +428,8 @@ static int ve_spc_cpufreq_init(struct cpufreq_policy *policy)
>  	dev_pm_opp_of_register_em(policy->cpus);
>  
>  	if (is_bL_switching_enabled())
> -		per_cpu(cpu_last_req_freq, policy->cpu) = clk_get_cpu_rate(policy->cpu);
> +		per_cpu(cpu_last_req_freq, policy->cpu) =
> +						clk_get_cpu_rate(policy->cpu);
>  
>  	dev_info(cpu_dev, "%s: CPU %d initialized\n", __func__, policy->cpu);
>  	return 0;
> @@ -451,7 +448,7 @@ static int ve_spc_cpufreq_exit(struct cpufreq_policy *policy)
>  	cpu_dev = get_cpu_device(policy->cpu);
>  	if (!cpu_dev) {
>  		pr_err("%s: failed to get cpu%d device\n", __func__,
> -				policy->cpu);
> +		       policy->cpu);
>  		return -ENODEV;
>  	}
>  
> -- 
> 2.17.1

-- 
viresh
