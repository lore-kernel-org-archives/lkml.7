Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34780C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B3A2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NbXyTVK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbfFNROy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:14:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37824 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfFNROy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:14:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so1842370pfa.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 10:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r5tXhiANsxn6YQdl37418WiLHhdChm3AD299PfiCsoU=;
        b=NbXyTVK3WaxmIeOt1OopzS29eKK5sL0zVVNJL08beb9YGBPHrdMbO43tYK1Gb99EyA
         S9hkqIewhwbzU0RvY8QzoINoWW3/iA5SsDzApt/AWknhXmBJHBWWa0UksTvw7a3OpCOz
         /eZiD50teroJQ2NCRVjKhypUDil5wslWZEWsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r5tXhiANsxn6YQdl37418WiLHhdChm3AD299PfiCsoU=;
        b=UR42JLWaz3hLboPzgVJ/8qGJ9thcbmzLzVY7IqPMtn/yFLfOfaa9+/Y2exVFHUWqL/
         liXRx3/JbkkMVZLmiWRhzqC8vX/BNpaUIxp2ZjO/Ol3mksS6kf6NWLduavc2J7JoTQBt
         uPlzmnMp1ONA4tspYY/k8Yd1jDPtLNTSaxd+lWQuJzXdXGSSaxIFKQMQZhfWTwzjcIrE
         D49A5l+HTRNq9o4rN18USXd/4iVJExJCfOLvDdF7o4Ed9EzNNIjk5UtBr2/Q2P4NrgDZ
         jxGwdzJ3ewMx7YQhmsx/coU6x+CGflzIZ5Ty/pnPh1F+w2DskANbklD8Wb6sOcMvY6Lc
         izLg==
X-Gm-Message-State: APjAAAWKCvlcUCBr5G7uIKfA1cY3opBkUaaNHvIuH+8yv45LL2had4hu
        +Mymf+vLVZmSpRpB1uxT3mCI3w==
X-Google-Smtp-Source: APXvYqxsi04hmYAh6uAF7MpkalRo5RRTNCaD8ZvmYUW26pTiZVJfnw21mkvJkIZ5A+XCCpS6vgQHlQ==
X-Received: by 2002:a17:90a:1b48:: with SMTP id q66mr11665697pjq.83.1560532493642;
        Fri, 14 Jun 2019 10:14:53 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id l44sm3870729pje.29.2019.06.14.10.14.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 10:14:52 -0700 (PDT)
Date:   Fri, 14 Jun 2019 10:14:50 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 5/5] cpufreq: Add QoS requests for userspace
 constraints
Message-ID: <20190614171450.GQ137143@google.com>
References: <cover.1560163748.git.viresh.kumar@linaro.org>
 <d1a7585539ad2ced2bfcc9e232cf859b1ec9c71a.1560163748.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d1a7585539ad2ced2bfcc9e232cf859b1ec9c71a.1560163748.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On Mon, Jun 10, 2019 at 04:21:36PM +0530, Viresh Kumar wrote:
> This implements QoS requests to manage userspace configuration of min
> and max frequency.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 92 +++++++++++++++++++--------------------
>  include/linux/cpufreq.h   |  8 +---
>  2 files changed, 47 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 547d221b2ff2..ff754981fcb4 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -720,23 +720,15 @@ static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
>  static ssize_t store_##file_name					\
>  (struct cpufreq_policy *policy, const char *buf, size_t count)		\
>  {									\
> -	int ret, temp;							\
> -	struct cpufreq_policy new_policy;				\
> +	unsigned long val;						\
> +	int ret;							\
>  									\
> -	memcpy(&new_policy, policy, sizeof(*policy));			\
> -	new_policy.min = policy->user_policy.min;			\
> -	new_policy.max = policy->user_policy.max;			\
> -									\
> -	ret = sscanf(buf, "%u", &new_policy.object);			\
> +	ret = sscanf(buf, "%lu", &val);					\
>  	if (ret != 1)							\
>  		return -EINVAL;						\
>  									\
> -	temp = new_policy.object;					\
> -	ret = cpufreq_set_policy(policy, &new_policy);		\
> -	if (!ret)							\
> -		policy->user_policy.object = temp;			\
> -									\
> -	return ret ? ret : count;					\
> +	ret = dev_pm_qos_update_request(policy->object##_freq_req, val);\
> +	return ret && ret != 1 ? ret : count;				\

nit: I wonder if

  return (ret >= 0) ? count : ret;

would be clearer.

Other than that:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
