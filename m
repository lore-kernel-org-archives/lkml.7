Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6310C32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 05:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A5F2465E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 05:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PCgb8Zzs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgAFFsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 00:48:14 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:33182 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgAFFsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 00:48:14 -0500
Received: by mail-pj1-f65.google.com with SMTP id u63so4055004pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 21:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ittmWLzoiwbYfzA04b4FRh3oV8Mt00ekdOIO1DGBia4=;
        b=PCgb8ZzsvivfjE9d60WEMDMyQbNBzEHv5fBK7m3g+KRKmJWigbH5K1vjI2ggSi7juH
         HZhxqwZvLlxCGMbISviW9+xituKp0g0kxYOff5eS7vH2ZjXUOm2g1g6i/UDEiUaB6ga4
         HWKRqfxhjX6jwLoDoTY5NRJpWervYA1ksV0EESrmsJX8eZUly31FDgtdL4x2rv3y+QjF
         ppQA3qywUSgo6nlLkTaBFRp48rA1AtwpypHyQsb/2ggxnfe/mPfSEx5qOxc/aYYW6APm
         aMzObXB6sDp7jt7vOWa2wDlO2JX8yi1QnBLwF4ZSGVkbXA3X5GxaNKC4XB6LuqQ9w8R3
         Upvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ittmWLzoiwbYfzA04b4FRh3oV8Mt00ekdOIO1DGBia4=;
        b=VAzs6mPUVrHddp1qqlgBSiY3217HvkHaDGw8b7Pab6mOLqCTpVxoet0a8j4+lznX60
         Nm8PLlagEfJ+8CT+xE0nuyExOHZxOcOBpH7locy/hYkxFQcSYW13x94VsCKkK0ZaNjhv
         SXQoYLq0O4viRIs5FLn49YoTFB5uOGODvJfLom8wCas3gsHdmhXpyQHq3BsshRp8dlqP
         0ogbxvPsLPe6YXDoX6JwqUNs77r67XM8ddtGNnTvf5TSdfJ78/HAIf/k9EpcAWA/emSQ
         +rkmTtEarlYpHxT+si4TFc3AaaTvDsKUCKHt4kQhlxVDUgqXy9/YHOi90RAUeJ/YhU3C
         zEog==
X-Gm-Message-State: APjAAAUj3i7p+KYRiU9c89zj4lf3VcZZvptDi7yUhEQAVkGOGIxZulEM
        lL9LGuF76DqJb5DFGjV+sI7+UQ==
X-Google-Smtp-Source: APXvYqzY7Y/N3u1EIAlYonSqEdQqQr5D/DGlIXfcIAtx/yQ+I9zoC0IR+vPRp+fuNusv/Ptc8RdGSA==
X-Received: by 2002:a17:90a:5806:: with SMTP id h6mr41233347pji.63.1578289693795;
        Sun, 05 Jan 2020 21:48:13 -0800 (PST)
Received: from localhost ([122.172.26.121])
        by smtp.gmail.com with ESMTPSA id 64sm73939461pfd.48.2020.01.05.21.48.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Jan 2020 21:48:13 -0800 (PST)
Date:   Mon, 6 Jan 2020 11:18:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     qiwuchen55@gmail.com
Cc:     kgene@kernel.org, krzk@kernel.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH] cpufreq: s3c: avoid use after free issue in
 xxx_cpufreq_reboot_notifier_evt()
Message-ID: <20200106054811.uduf2qdn5ecvbwrc@vireshk-i7>
References: <1577515439-14477-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577515439-14477-1-git-send-email-qiwuchen55@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-12-19, 14:43, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> There is a potential UAF issue in xxx_cpufreq_reboot_notifier_evt() that
> the cpufreq policy of cpu0 has been released before using it. So we should
> make a judgement to avoid it.

There is no UAF problem here, but that we do cpufreq_cpu_get() with a
corresponding cpufreq_cpu_put().

> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> ---
>  drivers/cpufreq/s3c2416-cpufreq.c | 11 ++++++++++-
>  drivers/cpufreq/s5pv210-cpufreq.c | 10 +++++++++-
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/s3c2416-cpufreq.c b/drivers/cpufreq/s3c2416-cpufreq.c
> index 1069103..0f576ba 100644
> --- a/drivers/cpufreq/s3c2416-cpufreq.c
> +++ b/drivers/cpufreq/s3c2416-cpufreq.c
> @@ -304,6 +304,7 @@ static int s3c2416_cpufreq_reboot_notifier_evt(struct notifier_block *this,
>  {
>  	struct s3c2416_data *s3c_freq = &s3c2416_cpufreq;
>  	int ret;
> +	struct cpufreq_policy policy;
>  
>  	mutex_lock(&cpufreq_lock);
>  
> @@ -318,7 +319,15 @@ static int s3c2416_cpufreq_reboot_notifier_evt(struct notifier_block *this,
>  	 */
>  	if (s3c_freq->is_dvs) {
>  		pr_debug("cpufreq: leave dvs on reboot\n");
> -		ret = cpufreq_driver_target(cpufreq_cpu_get(0), FREQ_SLEEP, 0);
> +
> +		memset(&policy, 0, sizeof(policy));
> +		ret = cpufreq_get_policy(&policy, 0);
> +		if (ret < 0) {
> +			pr_debug("cpufreq: get no policy for cpu0\n");
> +			return NOTIFY_BAD;
> +		}
> +

This doesn't make sense to me, why don't you do cpufreq_cpu_get() and
put() instead ?

> +		ret = cpufreq_driver_target(&policy, FREQ_SLEEP, 0);
>  		if (ret < 0)
>  			return NOTIFY_BAD;
>  	}
> diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> index 5d10030..d99b4b1 100644
> --- a/drivers/cpufreq/s5pv210-cpufreq.c
> +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> @@ -555,8 +555,16 @@ static int s5pv210_cpufreq_reboot_notifier_event(struct notifier_block *this,
>  						 unsigned long event, void *ptr)
>  {
>  	int ret;
> +	struct cpufreq_policy *policy;
>  
> -	ret = cpufreq_driver_target(cpufreq_cpu_get(0), SLEEP_FREQ, 0);
> +	policy = cpufreq_cpu_get(0);
> +	if (!policy) {
> +		pr_debug("cpufreq: get no policy for cpu0\n");
> +		return NOTIFY_BAD;
> +	}
> +
> +	ret = cpufreq_driver_target(policy, SLEEP_FREQ, 0);
> +	cpufreq_cpu_put(policy);

Like what is done here.

Also add a blank line here.

>  	if (ret < 0)
>  		return NOTIFY_BAD;
>  
> -- 
> 1.9.1

-- 
viresh
