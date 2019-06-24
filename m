Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD4AC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 06:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911962089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 06:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bWNNEk+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfFXGE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 02:04:29 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38269 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbfFXGE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 02:04:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id z75so3902188pgz.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 23:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mX2mC8vR4MVGCj0f3KlHUzitC7aHIxcPUHbsxDHUB/U=;
        b=bWNNEk+FN730bhGq/W/Z0iCR4lL/ehzz7iw7Y2dr/25mYU8VD/anjnPEkwtbGAuqC6
         lhmjHKrm662EDaBuIqodnTtVM7HJmY0oeN8/mrPSj/yTypFKXAqMP2W3fRGx6CsTn7zG
         Ux5P+1wCagAhIoyBMSDFxlpHbodIAST292ZQ09vZxDhZiqrCr8N0+wgqmaiwqEz+oVw3
         dtxNHnfO4tTFLQn9Is3uEUUApElevC1IABF1BIPheTDRswGJAISBBvrKrWjINd9wVHJq
         kEb97/qc11xcyEtBM9ZnNWB5GIPbSLrpQ/SJ1jqmZAipyVcL+BFlWRL56IYbUQFqyy9u
         nWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mX2mC8vR4MVGCj0f3KlHUzitC7aHIxcPUHbsxDHUB/U=;
        b=lodYrgz3m55CnROxlfgcMPdV9zQ7QYwTIH1u4fD4cyT2AssWGadGP3y9rbpVxp5aVq
         pLcj+l20WgiQR0HWo4orWRMuCl6608g8g6IuN47iomgg/x4NM++nVTs8YW1dLgAoEPH2
         BJzGMrIwLXRk9q72lGAf7tKd3YkS8EaB/c7bFWpQXZo+Rvk8bFdqKheBlC5y+zRAZPWL
         rrmgvT61B8izwSQqksROWzEZFb/Gh1/QcPHQKYRtZyGPApq2pOzGG9GfaVbeHEzMxCGl
         4CtR/YAQw4T3piIE+6cPVtZdJeTN23A0hkwz+fm6cJf6KASraHQL06jzIzJtiRfjwNvx
         8HIQ==
X-Gm-Message-State: APjAAAWp5t/hT7uMDJrYgOCznFJLSH6Lz17vo8CpWng1DOj1A4px5/v4
        8BM6VdceZCppM1ohr7dp/zYBkg==
X-Google-Smtp-Source: APXvYqyByWj1QSvQ1y/tGUOCTlOb+AV8V6tBWWXP/lvL+SrvuP3dFmcApefIFQbWdDWQbDF5gZf+Bg==
X-Received: by 2002:a65:460b:: with SMTP id v11mr1364683pgq.304.1561356267170;
        Sun, 23 Jun 2019 23:04:27 -0700 (PDT)
Received: from localhost ([122.172.211.128])
        by smtp.gmail.com with ESMTPSA id f14sm11169671pfn.53.2019.06.23.23.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 23:04:26 -0700 (PDT)
Date:   Mon, 24 Jun 2019 11:34:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     edubezval@gmail.com, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:CPU FREQUENCY DRIVERS - ARM BIG LITTLE" 
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 3/6] cpufreq/drivers/arm_big_little: Remove cooling
 device usage
Message-ID: <20190624060424.t44zxjyopioewgga@vireshk-i7>
References: <20190621132302.30414-1-daniel.lezcano@linaro.org>
 <20190621132302.30414-3-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621132302.30414-3-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-06-19, 15:22, Daniel Lezcano wrote:
> The cpufreq_cooling_unregister() function uses now the policy to
> unregister itself. The only purpose of the cooling device pointer is
> to unregister the cpu cooling device.
> 
> As there is no more need of this pointer, remove it.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpufreq/arm_big_little.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
> index 6b243202caa9..718c63231e66 100644
> --- a/drivers/cpufreq/arm_big_little.c
> +++ b/drivers/cpufreq/arm_big_little.c
> @@ -56,7 +56,6 @@ static bool bL_switching_enabled;
>  #define ACTUAL_FREQ(cluster, freq)  ((cluster == A7_CLUSTER) ? freq << 1 : freq)
>  #define VIRT_FREQ(cluster, freq)    ((cluster == A7_CLUSTER) ? freq >> 1 : freq)
>  
> -static struct thermal_cooling_device *cdev[MAX_CLUSTERS];
>  static const struct cpufreq_arm_bL_ops *arm_bL_ops;
>  static struct clk *clk[MAX_CLUSTERS];
>  static struct cpufreq_frequency_table *freq_table[MAX_CLUSTERS + 1];
> @@ -501,10 +500,8 @@ static int bL_cpufreq_exit(struct cpufreq_policy *policy)
>  	struct device *cpu_dev;
>  	int cur_cluster = cpu_to_cluster(policy->cpu);
>  
> -	if (cur_cluster < MAX_CLUSTERS) {
> +	if (cur_cluster < MAX_CLUSTERS)
>  		cpufreq_cooling_unregister(policy);
> -		cdev[cur_cluster] = NULL;
> -	}
>  
>  	cpu_dev = get_cpu_device(policy->cpu);
>  	if (!cpu_dev) {
> @@ -527,7 +524,7 @@ static void bL_cpufreq_ready(struct cpufreq_policy *policy)
>  	if (cur_cluster >= MAX_CLUSTERS)
>  		return;
>  
> -	cdev[cur_cluster] = of_cpufreq_cooling_register(policy);
> +	of_cpufreq_cooling_register(policy);
>  }
>  
>  static struct cpufreq_driver bL_cpufreq_driver = {

I will merge it with the previous commit if I were you.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
