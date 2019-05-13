Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21BFC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E22E20879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b7IGWbRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbfEMLF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:05:26 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44329 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbfEMLFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:05:25 -0400
Received: by mail-lf1-f65.google.com with SMTP id n134so8691950lfn.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 04:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0/jBgtMV/tlTsioM68qarUez9AIguA6hQlucrFtVYl0=;
        b=b7IGWbRp2w2CsqU2FZ0Gfl0Rra+yWTtZYhZC49qsb3LGxXRbR94bp/I9N3mjjsVS8/
         0ZbtmdR3g0MPZMHZP3ivdQbF+CkE1kre3Votyql1iU1tCzm3EVnRIe59AD7rKhBr/9to
         8dmKhAdmsOV59ZPj/H4JFoxu7BbjJXP7n4lQuwKTtw6LiHAIel5/KzzPPXv9DvwP+Uxb
         ptMTqAjtk7dqIdvfrezlIT4cRVh1WghrZa4Osger1vyTXGnnjtqZeB5YCuDpSYsidbcv
         ET22ni4c58mrw1XVLcJ0fJpBgSLFI/6EFQGOubWLT1D8wfUYHckXMq38DfPj10VzMDuU
         omPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0/jBgtMV/tlTsioM68qarUez9AIguA6hQlucrFtVYl0=;
        b=O1yyb+wAzqOT7krqN01PXYnY5oJa1cIZFYtf/d010B4brKRN+OqmPguotYqu0jHz5l
         t48j3h6psqz4UxwNFgOJZn8X2VUeT+d6W6tHyp1EJtvoRJEMXb7RXQMbgvXIZpJeAUqs
         UlOsUssvQct9iocVcrFYD3Fwt1DT+zUwWXDcHPfWu6fjAcBF4g3HI1qC9bKPc41LVFVT
         MD0Ml3QyLmp0t0JKW6zuiBotIS0GVQ/U99Kx4NnkXrEQOn6FTOWyWbo2AeGxmaoBmCRQ
         SL/rcLMHRw4LqfGVujgipY+RoWG0/2b3TAqzJ0Q6gHI++9oGCNuFQfiiHnzX2HIlM8Z1
         aDug==
X-Gm-Message-State: APjAAAUUkvSjSN4elgLoyiBFyTyBlpexz9oCyk+DQ2byTYpHdhr6yCg+
        I9RbjIW80JUSlitmLJsnQyloUw==
X-Google-Smtp-Source: APXvYqwMF43Y2VjnHQq/VvtWIKocNgbn/0WQzn0Rh3laCyS/TkhxHtGXyPXu4+tRcrMsebWKWglEUQ==
X-Received: by 2002:a19:ccca:: with SMTP id c193mr12868300lfg.36.1557745522792;
        Mon, 13 May 2019 04:05:22 -0700 (PDT)
Received: from centauri (h-158-174-22-72.NA.cust.bahnhof.se. [158.174.22.72])
        by smtp.gmail.com with ESMTPSA id n18sm114282lji.63.2019.05.13.04.05.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 13 May 2019 04:05:22 -0700 (PDT)
Date:   Mon, 13 May 2019 13:05:20 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] opp: Allocate genpd_virt_devs from
 dev_pm_opp_attach_genpd()
Message-ID: <20190513110520.GB30513@centauri>
References: <1bc9053f5c41a10832b58a2a81decbad7f1aded9.1557742920.git.viresh.kumar@linaro.org>
 <9f22d5954319fc315bc98e347e69839931648ecc.1557742920.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f22d5954319fc315bc98e347e69839931648ecc.1557742920.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 03:54:11PM +0530, Viresh Kumar wrote:
> Currently the space for the array of virtual devices is allocated along
> with the OPP table, but that isn't going to work well from now onwards.
> For single power domain case, a driver can either use the original
> device structure for setting the performance state (if genpd attached
> with dev_pm_domain_attach()) or use the virtual device structure (if
> genpd attached with dev_pm_domain_attach_by_name(), which returns the
> virtual device) and so we can't know in advance if we are going to need
> genpd_virt_devs array or not.
> 
> Lets delay the allocation a bit and do it along with
> dev_pm_opp_attach_genpd() rather. The deallocation is done from
> dev_pm_opp_detach_genpd().
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/opp/core.c | 10 ++++++++++
>  drivers/opp/of.c   | 30 ++----------------------------
>  2 files changed, 12 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 67d6b0caeab1..764e05a2fa66 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1755,6 +1755,9 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
>  		dev_pm_domain_detach(opp_table->genpd_virt_devs[index], false);
>  		opp_table->genpd_virt_devs[index] = NULL;
>  	}
> +
> +	kfree(opp_table->genpd_virt_devs);
> +	opp_table->genpd_virt_devs = NULL;
>  }
>  
>  /**
> @@ -1798,6 +1801,12 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names
>  
>  	mutex_lock(&opp_table->genpd_virt_dev_lock);
>  
> +	opp_table->genpd_virt_devs = kcalloc(opp_table->required_opp_count,
> +					     sizeof(*opp_table->genpd_virt_devs),
> +					     GFP_KERNEL);
> +	if (!opp_table->genpd_virt_devs)
> +		goto unlock;
> +
>  	while (*name) {
>  		index = of_property_match_string(dev->of_node,
>  						 "power-domain-names", *name);
> @@ -1836,6 +1845,7 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names
>  
>  err:
>  	_opp_detach_genpd(opp_table);
> +unlock:
>  	mutex_unlock(&opp_table->genpd_virt_dev_lock);
>  
>  put_table:
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index c10c782d15aa..a637f30552a3 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -141,7 +141,6 @@ static struct opp_table *_find_table_of_opp_np(struct device_node *opp_np)
>  static void _opp_table_free_required_tables(struct opp_table *opp_table)
>  {
>  	struct opp_table **required_opp_tables = opp_table->required_opp_tables;
> -	struct device **genpd_virt_devs = opp_table->genpd_virt_devs;
>  	int i;
>  
>  	if (!required_opp_tables)
> @@ -155,10 +154,8 @@ static void _opp_table_free_required_tables(struct opp_table *opp_table)
>  	}
>  
>  	kfree(required_opp_tables);
> -	kfree(genpd_virt_devs);
>  
>  	opp_table->required_opp_count = 0;
> -	opp_table->genpd_virt_devs = NULL;
>  	opp_table->required_opp_tables = NULL;
>  }
>  
> @@ -171,9 +168,8 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>  					     struct device_node *opp_np)
>  {
>  	struct opp_table **required_opp_tables;
> -	struct device **genpd_virt_devs = NULL;
>  	struct device_node *required_np, *np;
> -	int count, count_pd, i;
> +	int count, i;
>  
>  	/* Traversing the first OPP node is all we need */
>  	np = of_get_next_available_child(opp_np, NULL);
> @@ -186,33 +182,11 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>  	if (!count)
>  		goto put_np;
>  
> -	/*
> -	 * Check the number of power-domains to know if we need to deal
> -	 * with virtual devices. In some cases we have devices with multiple
> -	 * power domains but with only one of them being scalable, hence
> -	 * 'count' could be 1, but we still have to deal with multiple genpds
> -	 * and virtual devices.
> -	 */
> -	count_pd = of_count_phandle_with_args(dev->of_node, "power-domains",
> -					      "#power-domain-cells");
> -	if (!count_pd)
> -		goto put_np;
> -
> -	if (count_pd > 1) {
> -		genpd_virt_devs = kcalloc(count, sizeof(*genpd_virt_devs),
> -					GFP_KERNEL);
> -		if (!genpd_virt_devs)
> -			goto put_np;
> -	}
> -
>  	required_opp_tables = kcalloc(count, sizeof(*required_opp_tables),
>  				      GFP_KERNEL);
> -	if (!required_opp_tables) {
> -		kfree(genpd_virt_devs);
> +	if (!required_opp_tables)
>  		goto put_np;
> -	}
>  
> -	opp_table->genpd_virt_devs = genpd_virt_devs;
>  	opp_table->required_opp_tables = required_opp_tables;
>  	opp_table->required_opp_count = count;
>  
> -- 
> 2.21.0.rc0.269.g1a574e7a288b
> 

Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
