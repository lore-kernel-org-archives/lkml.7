Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA34AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1152218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qBOk5ieW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfCUHrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 03:47:42 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55903 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbfCUHrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 03:47:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id o25so1249208wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 00:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RjBN56vlxPNlHGf5pYA5eJmMoSrFv2U0V43LKsadGUU=;
        b=qBOk5ieWo+itUvulj3M5dJgsiRq2x5SStPvyTOcrgCO2QONvT3Fnjo5uDLlMqqQl9m
         /1WdZ2L4I2BJGNtsl95JGTXtRaKYBChRZMR+Lm9d5ILhtIQzxK0Nn+2XjeKs9Rg4oJZA
         Y9XrPf6W//ovFAe/tRzbCI8F3PRyOezY6eHaizCifonTARQijBDcBrheWvxf58K+X5/g
         nhvuhLDZ08OYZjFQei7PlKUe47y6TVraT8SPLg7omue5znq+ZKDqZsbS+3j1obdQ/t5W
         lSU1Asc6offYWYF8OmqhxhYY8nu4Oq8PYU6fD+zx3dayhe/9xJcseoJ8ha0gXR2Vckjy
         s9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RjBN56vlxPNlHGf5pYA5eJmMoSrFv2U0V43LKsadGUU=;
        b=coFtMaKx9Uo+AS2r/U8ypQVo9tdxoBM7zmSoznv5WRT7hjg989sH8lUstuNIFO0UYn
         3g68/5u61bw0BQbgd40Xw5n3X3eymySq04sCxGOaUCDiKOmPvFjDIJD0XYMR8Iqsopcn
         rDkZiHVmUHo4FdT4gWIMArrSgA70WG9MA4KM6ha7jfjrwWVPYBtJPpD+2P+oGqpRngj/
         Dhr1EIGrm7r2/P4fFmLcvmdz8EFyCYoIM9n+DUAAWM2UeYznxZbrMYrAB8TDbdnMoUET
         +JRQxlPyHbijsVoamsT1uvdRBu6qipbEHU72qURITnLDpM1AYWRVL/XuCPhijj/fNPpz
         qt1A==
X-Gm-Message-State: APjAAAXlpytFkzYs9lo96FWB/R4jp7y2fOLJ13uuimf0JeHW1E6Yu/Py
        buwFTlq8HmHwO3geW08JnALi7SIeXbQ=
X-Google-Smtp-Source: APXvYqzq1gX8/QblnrJDiVJvEYkjUyy4PbuNMqibq9uZXamfuq+rYN9r5Fqjeh38ANFGHBCY9wWqfg==
X-Received: by 2002:a1c:21c1:: with SMTP id h184mr1516516wmh.128.1553154459387;
        Thu, 21 Mar 2019 00:47:39 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id n189sm7989840wmb.28.2019.03.21.00.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 00:47:38 -0700 (PDT)
Subject: Re: [PATCH v12 1/4] PM / Domains: Add a generic data pointer to the
 genpd_power_state struct
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190227195836.24739-1-ulf.hansson@linaro.org>
 <20190227195836.24739-2-ulf.hansson@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <11aa2536-9f9c-059d-a4d6-3f683be7caeb@linaro.org>
Date:   Thu, 21 Mar 2019 08:47:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190227195836.24739-2-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2019 20:58, Ulf Hansson wrote:
> Let's add a data pointer to the genpd_power_state struct, to allow a genpd
> backend driver to store per state specific data. To introduce the pointer,
> we need to change the way genpd deals with freeing of the corresponding
> allocated data.
> 
> More precisely, let's clarify the responsibility of whom that shall free
> the data, by adding a ->free_states() callback to the struct
> generic_pm_domain. The one allocating the data shall assign the callback,
> to allow genpd to invoke it from genpd_remove().
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v12:
> 	- None.
> 
> ---
>  drivers/base/power/domain.c | 12 ++++++++++--
>  include/linux/pm_domain.h   |  4 +++-
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 2c334c01fc43..03885c003c6a 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1685,6 +1685,12 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>  }
>  EXPORT_SYMBOL_GPL(pm_genpd_remove_subdomain);
>  
> +static void genpd_free_default_power_state(struct genpd_power_state *states,
> +					   unsigned int state_count)
> +{
> +	kfree(states);
> +}
> +
>  static int genpd_set_default_power_state(struct generic_pm_domain *genpd)
>  {
>  	struct genpd_power_state *state;
> @@ -1695,7 +1701,7 @@ static int genpd_set_default_power_state(struct generic_pm_domain *genpd)
>  
>  	genpd->states = state;
>  	genpd->state_count = 1;
> -	genpd->free = state;
> +	genpd->free_states = genpd_free_default_power_state;
>  
>  	return 0;
>  }
> @@ -1811,7 +1817,9 @@ static int genpd_remove(struct generic_pm_domain *genpd)
>  	list_del(&genpd->gpd_list_node);
>  	genpd_unlock(genpd);
>  	cancel_work_sync(&genpd->power_off_work);
> -	kfree(genpd->free);
> +	if (genpd->free_states)

Is this test necessary as the free_states function is initialized with
the genpd_set_default_power_state() in any case?

> +		genpd->free_states(genpd->states, genpd->state_count);
> +
>  	pr_debug("%s: removed %s\n", __func__, genpd->name);
>  
>  	return 0;
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 1ed5874bcee0..8e1399231753 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -69,6 +69,7 @@ struct genpd_power_state {
>  	s64 residency_ns;
>  	struct fwnode_handle *fwnode;
>  	ktime_t idle_time;
> +	void *data;
>  };
>  
>  struct genpd_lock_ops;
> @@ -110,9 +111,10 @@ struct generic_pm_domain {
>  			   struct device *dev);
>  	unsigned int flags;		/* Bit field of configs for genpd */
>  	struct genpd_power_state *states;
> +	void (*free_states)(struct genpd_power_state *states,
> +			    unsigned int state_count);
>  	unsigned int state_count; /* number of states */
>  	unsigned int state_idx; /* state that genpd will go to when off */
> -	void *free; /* Free the state that was allocated for default */
>  	ktime_t on_time;
>  	ktime_t accounting_time;
>  	const struct genpd_lock_ops *lock_ops;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

