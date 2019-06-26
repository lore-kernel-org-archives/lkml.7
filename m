Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAB1C48BD5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 02:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505A220883
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 02:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nNuuMJEm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfFZC6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 22:58:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34100 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfFZC6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 22:58:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id p10so449646pgn.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 19:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iE5E8LuKhxvkEDw3P1iJQOCpfQy9qpPvGHyY1TwKNYY=;
        b=nNuuMJEmG8kqx0DkmPSnnmOLaPWKOLFPLCuf2f/uw4KfeLKX9wuhGqRx3F1Ndp41R+
         CbIHCoAQN60J5GUFl5sGUOwsdy8Y72zMjIe5Ny4Se9mv+6F64j+vd8ljLArcd83HOh4+
         M4lR+3p7LXz4xj+gtndziZnewMsmVoeuGKoOLDJvVvivbMekB0GBOcF3efc4cXS2kf57
         eEKimW71scnBP78A1RUIiDktAqcy4BNCvfBNtUemBUBHUf4LAx7Yzp5RjucHd/QjkBCP
         cH1aoWqlY+Y4RgBK39kRrYV0tI34NwTwtV949J6OpbBZNHapYv/tgCSNhM53nUl1SCR6
         JnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iE5E8LuKhxvkEDw3P1iJQOCpfQy9qpPvGHyY1TwKNYY=;
        b=AWI/X6RcW2Iy9OYglfFkZ6taXPekhKNrqGUSmfq8baPpsh7qdss3B/EwyJOU8M+kDR
         TWk/FTE4sw3YddkmGrA5qihe7eN4WTeHNjob4eAegoB/zWjIKhlQ6ssZG5g0iv2q589U
         y8SQNA6YLS00GXf6LnjgnxtnzFYqNY1P6170CMsDZ+Mfrm9Y7HYoIjMXGmd1LRAIDbGq
         1Mqe7BGNgZb3DJG0u/RgSN9faWABut78Zk3jEPEhbOIDPa4fL+V5xd997fqlQg2BXmJ/
         duJYAcocXz8nGjKkYO8BBOd77eFFgN0Vf2ueE0QYroM4RBDeH30haFLra4ysXK/fQoIS
         HJNA==
X-Gm-Message-State: APjAAAVn2cSYEyVE2U/++iRrmpNasBtLLnfCSs5vIIr0aD/JkM+jZjIE
        aNBRmTftCo7tdVbzX1nYe8MViJOK778=
X-Google-Smtp-Source: APXvYqwWoHr/bHFfBnxLciHjZ534PCBqC5KE1O2QfaL/LNcnUP/XKsvF2YfkTu0Q4FAYHqngh5Q2YA==
X-Received: by 2002:a17:90a:5d0a:: with SMTP id s10mr1507799pji.94.1561517916775;
        Tue, 25 Jun 2019 19:58:36 -0700 (PDT)
Received: from localhost ([122.172.211.128])
        by smtp.gmail.com with ESMTPSA id c98sm377953pje.1.2019.06.25.19.58.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 19:58:35 -0700 (PDT)
Date:   Wed, 26 Jun 2019 08:28:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, edubezval@gmail.com,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Keerthy <j-keerthy@ti.com>,
        "open list:CPU FREQUENCY DRIVERS - ARM BIG LITTLE" 
        <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:TI BANDGAP AND THERMAL DRIVER" 
        <linux-omap@vger.kernel.org>
Subject: Re: [PATCH V3 2/3] thermal/drivers/cpu_cooling: Unregister with the
 policy
Message-ID: <20190626025831.jmyzyypxr6ezpbtu@vireshk-i7>
References: <20190625113244.18146-1-daniel.lezcano@linaro.org>
 <20190625113244.18146-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625113244.18146-2-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-06-19, 13:32, Daniel Lezcano wrote:
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index aee024e42618..f07454249fbc 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1379,8 +1379,8 @@ static int cpufreq_online(unsigned int cpu)
>  		cpufreq_driver->ready(policy);
>  
>  	if (cpufreq_thermal_control_enabled(cpufreq_driver))
> -		policy->cdev = of_cpufreq_cooling_register(policy);
> -
> +		of_cpufreq_cooling_register(policy);
> +	

We don't need any error checking here anymore ?

>  	pr_debug("initialization complete\n");
>  
>  	return 0;
> @@ -1468,10 +1468,8 @@ static int cpufreq_offline(unsigned int cpu)
>  		goto unlock;
>  	}
>  
> -	if (cpufreq_thermal_control_enabled(cpufreq_driver)) {
> -		cpufreq_cooling_unregister(policy->cdev);
> -		policy->cdev = NULL;
> -	}
> +	if (cpufreq_thermal_control_enabled(cpufreq_driver))
> +		cpufreq_cooling_unregister(policy);

And we unregister unconditionally, even if we failed ? What if this
routine prints error messages for such an case ?

>  
>  	if (cpufreq_driver->stop_cpu)
>  		cpufreq_driver->stop_cpu(policy);
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 83486775e593..007c7c6bf845 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -78,6 +78,7 @@ struct cpufreq_cooling_device {
>  	struct cpufreq_policy *policy;
>  	struct list_head node;
>  	struct time_in_idle *idle_time;
> +	struct thermal_cooling_device *cdev;
>  };
>  
>  static DEFINE_IDA(cpufreq_ida);
> @@ -606,6 +607,7 @@ __cpufreq_cooling_register(struct device_node *np,
>  		goto remove_ida;
>  
>  	cpufreq_cdev->clipped_freq = get_state_freq(cpufreq_cdev, 0);
> +	cpufreq_cdev->cdev = cdev;
>  
>  	mutex_lock(&cooling_list_lock);
>  	/* Register the notifier for first cpufreq cooling device */
> @@ -699,18 +701,18 @@ EXPORT_SYMBOL_GPL(of_cpufreq_cooling_register);
>   *
>   * This interface function unregisters the "thermal-cpufreq-%x" cooling device.
>   */
> -void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
> +void cpufreq_cooling_unregister(struct cpufreq_policy *policy)
>  {
>  	struct cpufreq_cooling_device *cpufreq_cdev;
>  	bool last;
>  
> -	if (!cdev)
> -		return;
> -
> -	cpufreq_cdev = cdev->devdata;
> -
>  	mutex_lock(&cooling_list_lock);
> -	list_del(&cpufreq_cdev->node);
> +	list_for_each_entry(cpufreq_cdev, &cpufreq_cdev_list, node) {
> +		if (cpufreq_cdev->policy == policy) {
> +			list_del(&cpufreq_cdev->node);
> +			break;
> +		}
> +	}

What if we reach here without a match for the policy ? We shouldn't
continue and error out, right ? Print an error message as well ?

-- 
viresh
