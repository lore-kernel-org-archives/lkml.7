Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B672FC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DEA2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yskyOhwY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbfDYJpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:45:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34375 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbfDYJpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:45:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id v12so10935052pgq.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 02:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=llxQyQwHivDo7k3PIg8TjZj9hZcvczSzmtN5bIWKJs0=;
        b=yskyOhwYvXKsEg1Im6kthA4PK46d9Q6z7/ilSZAQqGqFp9iIlZoKUbzaSEFRYRDnSr
         FzWzxLTA/2e65XaK3R9yKpY4YlcL4EhB4ykfB+PBrONgOooKS3rhX+O1weWe2uH56+di
         YKWNXDGqX6RkWIkcsDrP+8GzWuZXEZhYtMK4r7srhFB9YRdue4L/BQwJGJ9H0efBMQkR
         xhYIFxFxLmfXULYJugne0G0hmVkbJa/zq2akuMYJo5anrcLOR89Z0Qyq4GJ1e5mghVQs
         o3vUXfOQWKIoMhQvuyZbRGHPvk38VkoGRJy17G6nq21lXDY7imDk+C6fLBpzMJMYjxnQ
         RtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=llxQyQwHivDo7k3PIg8TjZj9hZcvczSzmtN5bIWKJs0=;
        b=op236FWdNYgQpzf+ul/4vHzeDWY/b7Pin5yVvGBHN6Q4AY/uzp5jJFeuvbw0a+jiOZ
         WT7mPm83mtm6wmmLeGALbEGgJZ0DOWMl/DHosXqttruqFJ/4ZCLuZruKOVuF9EUnbnLf
         pBy9lhf2xqDvdR93wTtg99MGJfy1OsfoF5gE5WEOzxdOnffu+UMQngnhHXXRiaikog33
         1VGmAPBg2Uvz7/NnHwWhNlsBKjAonw3Ll1XW21AN2Ha5f9lMnj+ZIGMCzORRMvue5/MF
         D56RQtA5FdUQmfEe4vo6tZuXHDhw2dNKg1XiVzgaCCt5P/1GJMA9X+rhFO7nAVO1wKoD
         8MuA==
X-Gm-Message-State: APjAAAUZtxeQ/va345BEuR6a+ArkA75srvmpIFl0akuSDaUfd+i7D0y+
        7W6TGd+YwXgV8s/X5lMsHeINkA==
X-Google-Smtp-Source: APXvYqylsvuDAGjQSpc812T3gcK6/pR3ljIQASXNFDJ6IdMVY0hC8MMXG09N/UUfwuWpUX1CWplEBQ==
X-Received: by 2002:a63:6fcf:: with SMTP id k198mr35558294pgc.158.1556185505000;
        Thu, 25 Apr 2019 02:45:05 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id a18sm8375318pfg.177.2019.04.25.02.45.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 02:45:04 -0700 (PDT)
Date:   Thu, 25 Apr 2019 15:15:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] PM / Domains: Search for the CPU device outside the
 genpd lock
Message-ID: <20190425094502.6wprvxdz44e5g63q@vireshk-i7>
References: <20190425090413.10700-1-ulf.hansson@linaro.org>
 <20190425090413.10700-4-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425090413.10700-4-ulf.hansson@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-04-19, 11:04, Ulf Hansson wrote:
> While attaching/detaching a device to a PM domain (genpd) that has the
> GENPD_FLAG_CPU_DOMAIN set, genpd iterates the cpu_possible_mask to check
> whether the device corresponds to a CPU. This iteration is done while
> holding the genpd's lock, which is unnecessary. Let's avoid the locking,
> by restructuring the corresponding code a bit.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 52 +++++++++++++++++++------------------
>  1 file changed, 27 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 93298b7db408..da1c99178943 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1450,8 +1450,8 @@ static void genpd_free_dev_data(struct device *dev,
>  	dev_pm_put_subsys_data(dev);
>  }
>  
> -static void __genpd_update_cpumask(struct generic_pm_domain *genpd,
> -				   int cpu, bool set, unsigned int depth)
> +static void genpd_update_cpumask(struct generic_pm_domain *genpd,
> +				 int cpu, bool set, unsigned int depth)
>  {
>  	struct gpd_link *link;
>  
> @@ -1462,7 +1462,7 @@ static void __genpd_update_cpumask(struct generic_pm_domain *genpd,
>  		struct generic_pm_domain *master = link->master;
>  
>  		genpd_lock_nested(master, depth + 1);
> -		__genpd_update_cpumask(master, cpu, set, depth + 1);
> +		genpd_update_cpumask(master, cpu, set, depth + 1);
>  		genpd_unlock(master);
>  	}
>  
> @@ -1472,38 +1472,37 @@ static void __genpd_update_cpumask(struct generic_pm_domain *genpd,
>  		cpumask_clear_cpu(cpu, genpd->cpus);
>  }
>  
> -static void genpd_update_cpumask(struct generic_pm_domain *genpd,
> -				 struct device *dev, bool set)
> +static void genpd_set_cpumask(struct generic_pm_domain *genpd, int cpu)
> +{
> +	if (cpu >= 0)
> +		genpd_update_cpumask(genpd, cpu, true, 0);
> +}
> +
> +static void genpd_clear_cpumask(struct generic_pm_domain *genpd, int cpu)
> +{
> +	if (cpu >= 0)
> +		genpd_update_cpumask(genpd, cpu, false, 0);
> +}
> +
> +static int genpd_get_cpu(struct generic_pm_domain *genpd, struct device *dev)
>  {
>  	int cpu;
>  
>  	if (!genpd_is_cpu_domain(genpd))
> -		return;
> +		return -1;
>  
>  	for_each_possible_cpu(cpu) {
> -		if (get_cpu_device(cpu) == dev) {
> -			__genpd_update_cpumask(genpd, cpu, set, 0);
> -			return;
> -		}
> +		if (get_cpu_device(cpu) == dev)
> +			return cpu;
>  	}
> -}
>  
> -static void genpd_set_cpumask(struct generic_pm_domain *genpd,
> -			      struct device *dev)
> -{
> -	genpd_update_cpumask(genpd, dev, true);
> -}
> -
> -static void genpd_clear_cpumask(struct generic_pm_domain *genpd,
> -				struct device *dev)
> -{
> -	genpd_update_cpumask(genpd, dev, false);
> +	return -1;
>  }
>  
>  static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev)
>  {
>  	struct generic_pm_domain_data *gpd_data;
> -	int ret;
> +	int ret, cpu;
>  
>  	dev_dbg(dev, "%s()\n", __func__);
>  
> @@ -1514,13 +1513,15 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev)
>  	if (IS_ERR(gpd_data))
>  		return PTR_ERR(gpd_data);
>  
> +	cpu = genpd_get_cpu(genpd, dev);
> +
>  	ret = genpd->attach_dev ? genpd->attach_dev(genpd, dev) : 0;
>  	if (ret)
>  		goto out;
>  
>  	genpd_lock(genpd);
>  
> -	genpd_set_cpumask(genpd, dev);
> +	genpd_set_cpumask(genpd, cpu);

Should we check if "cpu" is valid here ? As that was done earlier.

>  	dev_pm_domain_set(dev, &genpd->domain);
>  
>  	genpd->device_count++;
> @@ -1560,13 +1561,14 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
>  {
>  	struct generic_pm_domain_data *gpd_data;
>  	struct pm_domain_data *pdd;
> -	int ret = 0;
> +	int cpu, ret = 0;
>  
>  	dev_dbg(dev, "%s()\n", __func__);
>  
>  	pdd = dev->power.subsys_data->domain_data;
>  	gpd_data = to_gpd_data(pdd);
>  	dev_pm_qos_remove_notifier(dev, &gpd_data->nb);
> +	cpu = genpd_get_cpu(genpd, dev);
>  
>  	genpd_lock(genpd);
>  
> @@ -1578,7 +1580,7 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
>  	genpd->device_count--;
>  	genpd->max_off_time_changed = true;
>  
> -	genpd_clear_cpumask(genpd, dev);
> +	genpd_clear_cpumask(genpd, cpu);

Same here.

>  	dev_pm_domain_set(dev, NULL);
>  
>  	list_del_init(&pdd->list_node);
> -- 
> 2.17.1

-- 
viresh
