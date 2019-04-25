Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E15DC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562A920878
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JDJ7+lSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbfDYJrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:47:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40679 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfDYJrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:47:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so10923873pgl.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 02:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s3l3cVrQwl7ZNkcM7Wkeeg4kELX/OYTlGqUmeDa4cYE=;
        b=JDJ7+lSlivPIfUj8RAlsHWcfYkCKEoxKan2snzgr/hM4/KxoGEYcpHyj2BrFxZY5HD
         2Q+uINLBhCLAqhTuY2Lk8jQfKI3Ks261qPOWGVrbMQf1lJpip94chczrbPGorJIbxMYm
         eh0oa6HzRsbPPdgm30xINC+SYrIoBP5mFUtteQwvOOHJEmrcoIsTrM5Wp7zVeAFm1ogF
         Zjy/skrCZ2JhPXUUpnnBQ8Z5kK6TZveZO8MhkSxm0Vj0ayB/ZVWz6AcBka7+m6pr5a4K
         8vScqTzQioCNcXUHakRpkDApdSRQ7ad/whnTSWlT6USsQ9YLeyw1f1CZzVIkrbfUi3yO
         Zp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s3l3cVrQwl7ZNkcM7Wkeeg4kELX/OYTlGqUmeDa4cYE=;
        b=t+qL0jlSYc6rMx/+YXT2xpyHZ/m8Nxg9cDnB2Dyecdmu/LClh/6MTl4liXTm/B+inS
         K/c2aBwjtCX6OAdQB7kpc9zLf18ZIejbh+aXKI6vUjXp+q9drzvkIFs+Lq56kZXHxowP
         5faujdP7v9DqDQGvTknyt9iL74qizzhhBwRK1l5dttwxzJew4zhZAYjV34O0zPiokVu9
         U+ZCvmfllCiWYMqGLwIMF6Qmd23nhJSTMX0WMMsO0ydUc1afHnEo4WxIGBm+6OgyexUT
         n2jh0PwHa39aqlxp7q5GmkWkOZhg44ySbTuqhC8oaavvIT/ZPGI1vVklF5QlSCVANlel
         4tWg==
X-Gm-Message-State: APjAAAUO8qM3rgqZVBa3eCASbj+GXtH2sGWfsdYBeAqQ4My4LpcBB//0
        nqTyYONQE3i4B4vk5KZpbXufWw==
X-Google-Smtp-Source: APXvYqyLZ1oTxfIA69iYSjRzKeULOjSjVshEAWomqIvVWA58yyeBnwH62ZNCQxQLdXvnsyqiZ8rEDQ==
X-Received: by 2002:a62:ab14:: with SMTP id p20mr40280309pff.23.1556185664309;
        Thu, 25 Apr 2019 02:47:44 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id a6sm44855004pgd.67.2019.04.25.02.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 02:47:42 -0700 (PDT)
Date:   Thu, 25 Apr 2019 15:17:41 +0530
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
Subject: Re: [PATCH 4/4] PM / Domains: Allow to attach a CPU via
 genpd_dev_pm_attach_by_id|name()
Message-ID: <20190425094741.olaw3zgfox3yc7bc@vireshk-i7>
References: <20190425090413.10700-1-ulf.hansson@linaro.org>
 <20190425090413.10700-5-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425090413.10700-5-ulf.hansson@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-04-19, 11:04, Ulf Hansson wrote:
> Attaching a device via genpd_dev_pm_attach_by_id|name() makes genpd to
> allocate a virtual device that it attaches instead. This leads to a problem
> in case the base device belongs to a CPU. More precisely, it means
> genpd_get_cpu() compares against the virtual device, thus it fails to find
> a matching CPU device.
> 
> Address this limitation, by passing the base device to genpd_get_cpu()
> rather than the virtual device. Moreover, to deal with detach correctly
> from genpd_remove_device(), let's store the CPU number in the struct
> generic_pm_domain_data, as to be able to clear the corresponding bit in the
> cpumask for the genpd.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 20 ++++++++++----------
>  include/linux/pm_domain.h   |  1 +
>  2 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index da1c99178943..3d899e8abd58 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1499,10 +1499,11 @@ static int genpd_get_cpu(struct generic_pm_domain *genpd, struct device *dev)
>  	return -1;
>  }
>  
> -static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev)
> +static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
> +			    struct device *base_dev)
>  {
>  	struct generic_pm_domain_data *gpd_data;
> -	int ret, cpu;
> +	int ret;
>  
>  	dev_dbg(dev, "%s()\n", __func__);
>  
> @@ -1513,7 +1514,7 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev)
>  	if (IS_ERR(gpd_data))
>  		return PTR_ERR(gpd_data);
>  
> -	cpu = genpd_get_cpu(genpd, dev);
> +	gpd_data->cpu = genpd_get_cpu(genpd, base_dev);
>  
>  	ret = genpd->attach_dev ? genpd->attach_dev(genpd, dev) : 0;
>  	if (ret)
> @@ -1521,7 +1522,7 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev)
>  
>  	genpd_lock(genpd);
>  
> -	genpd_set_cpumask(genpd, cpu);
> +	genpd_set_cpumask(genpd, gpd_data->cpu);
>  	dev_pm_domain_set(dev, &genpd->domain);
>  
>  	genpd->device_count++;
> @@ -1549,7 +1550,7 @@ int pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev)
>  	int ret;
>  
>  	mutex_lock(&gpd_list_lock);
> -	ret = genpd_add_device(genpd, dev);
> +	ret = genpd_add_device(genpd, dev, dev);
>  	mutex_unlock(&gpd_list_lock);
>  
>  	return ret;
> @@ -1561,14 +1562,13 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
>  {
>  	struct generic_pm_domain_data *gpd_data;
>  	struct pm_domain_data *pdd;
> -	int cpu, ret = 0;
> +	int ret = 0;
>  
>  	dev_dbg(dev, "%s()\n", __func__);
>  
>  	pdd = dev->power.subsys_data->domain_data;
>  	gpd_data = to_gpd_data(pdd);
>  	dev_pm_qos_remove_notifier(dev, &gpd_data->nb);
> -	cpu = genpd_get_cpu(genpd, dev);
>  
>  	genpd_lock(genpd);
>  
> @@ -1580,7 +1580,7 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
>  	genpd->device_count--;
>  	genpd->max_off_time_changed = true;
>  
> -	genpd_clear_cpumask(genpd, cpu);
> +	genpd_clear_cpumask(genpd, gpd_data->cpu);
>  	dev_pm_domain_set(dev, NULL);
>  
>  	list_del_init(&pdd->list_node);
> @@ -2256,7 +2256,7 @@ int of_genpd_add_device(struct of_phandle_args *genpdspec, struct device *dev)
>  		goto out;
>  	}
>  
> -	ret = genpd_add_device(genpd, dev);
> +	ret = genpd_add_device(genpd, dev, dev);
>  
>  out:
>  	mutex_unlock(&gpd_list_lock);
> @@ -2426,7 +2426,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>  
>  	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
>  
> -	ret = genpd_add_device(pd, dev);
> +	ret = genpd_add_device(pd, dev, base_dev);
>  	mutex_unlock(&gpd_list_lock);
>  
>  	if (ret < 0) {
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index bc82e74560ee..0e8e356bed6a 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -175,6 +175,7 @@ struct generic_pm_domain_data {
>  	struct pm_domain_data base;
>  	struct gpd_timing_data td;
>  	struct notifier_block nb;
> +	int cpu;
>  	unsigned int performance_state;
>  	void *data;
>  };

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
