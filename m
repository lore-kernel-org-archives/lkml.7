Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B02CC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626892084F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tJLGbDrE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfDYJkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:40:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36602 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbfDYJki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:40:38 -0400
Received: by mail-pl1-f195.google.com with SMTP id ck15so10823394plb.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 02:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wKN+DSEjOzdx3neTxvVmXxRXToXVrkvSnOS48uhEmAE=;
        b=tJLGbDrEZ9kIEJwggqjsPY8xFkUx9F4+Kpbc8c1zuLr/3/DiOuKNCtyx7X72lGhvhL
         1a0eKU+8XYlDjeUa/BhyJB4n8jeZ2uvUmnPM6c5RhXY+l2etbLVYihRu7sHBDkeXo7IQ
         qdGusHRLpc8ZtDm+iIqKEy6miTJXzZ07ubbyqTF6neqsHNR9n5a1XVCcRwAeLTH7sP7K
         HYWsrqTr3D7qePlm+D9TpzsUykZGf6im6ORRXm0dHz5rqFm1VI+gjJLdd9AjnhgIC+Au
         SPJtAS5smG0MZHHHVruTfPR2YfzkL4ymNZ0Tm82uaV4IKahdmI71Ls5U6xJLDLthiLK4
         xO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wKN+DSEjOzdx3neTxvVmXxRXToXVrkvSnOS48uhEmAE=;
        b=ARqWHzeNPk34JX13l1SN2XxjnzY0CHycGS0cbDEV2XGzK3pB9fErSuhgt+1ZpLOrgj
         CogDwPRyhUBVnFdizQztauBkqpYJrtR01UWmvpGsQTrdb1X7oIupXPE0PIY2Lp1TTKjZ
         K0jFkBxSVqO99RQRnlIDOasMo0U2o5IDzTkbUgu+E1wmLqPRevBLYHezgcYuCDxuNgx2
         hC9ZLbVPapGil7jNsyaPYoBJAuVLRKb7qNJln5Or+QrkrlpPE01VdKJg3be5qsOhv4sB
         E2fIrJE5o6MRmwCLH+PL2wXP0bDOgpSbYp08WjIndUexd0Cx80RSkDdtU1z4pMTQ8Doq
         j9RQ==
X-Gm-Message-State: APjAAAXF1RUCU9j0x5VM5+Uh4YTxqtGPNIFfTnlX1m1N5kehgYAkCbqX
        bi9da8kdZGSsSfDQT1D+uP2SDg==
X-Google-Smtp-Source: APXvYqw1q9MAaFDsWoKwUDxxRjs65028Cq7Sesl/xutD20PkM86wBt7YJKAH7vYlFwEgELqV1czekQ==
X-Received: by 2002:a17:902:a704:: with SMTP id w4mr29209791plq.51.1556185237535;
        Thu, 25 Apr 2019 02:40:37 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id 19sm28155667pga.88.2019.04.25.02.40.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 02:40:36 -0700 (PDT)
Date:   Thu, 25 Apr 2019 15:10:35 +0530
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
Subject: Re: [PATCH 2/4] PM / Domains: Drop unused in-parameter to some genpd
 functions
Message-ID: <20190425094035.c7tn2efkxhbl25re@vireshk-i7>
References: <20190425090413.10700-1-ulf.hansson@linaro.org>
 <20190425090413.10700-3-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425090413.10700-3-ulf.hansson@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-04-19, 11:04, Ulf Hansson wrote:
> Both genpd_alloc_dev_data() and genpd_add_device(), whom are internal genpd
> functions, allows a struct gpd_timing_data *td to be passed as an
> in-parameter. However, as NULL is always passed, let's just drop the
> in-parameter altogether.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 8aca1c9b4406..93298b7db408 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1396,8 +1396,7 @@ EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweron);
>  
>  #endif /* CONFIG_PM_SLEEP */
>  
> -static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
> -					struct gpd_timing_data *td)
> +static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev)
>  {
>  	struct generic_pm_domain_data *gpd_data;
>  	int ret;
> @@ -1412,9 +1411,6 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
>  		goto err_put;
>  	}
>  
> -	if (td)
> -		gpd_data->td = *td;
> -
>  	gpd_data->base.dev = dev;
>  	gpd_data->td.constraint_changed = true;
>  	gpd_data->td.effective_constraint_ns = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
> @@ -1504,8 +1500,7 @@ static void genpd_clear_cpumask(struct generic_pm_domain *genpd,
>  	genpd_update_cpumask(genpd, dev, false);
>  }
>  
> -static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
> -			    struct gpd_timing_data *td)
> +static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev)
>  {
>  	struct generic_pm_domain_data *gpd_data;
>  	int ret;
> @@ -1515,7 +1510,7 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
>  	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
>  		return -EINVAL;
>  
> -	gpd_data = genpd_alloc_dev_data(dev, td);
> +	gpd_data = genpd_alloc_dev_data(dev);
>  	if (IS_ERR(gpd_data))
>  		return PTR_ERR(gpd_data);
>  
> @@ -1553,7 +1548,7 @@ int pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev)
>  	int ret;
>  
>  	mutex_lock(&gpd_list_lock);
> -	ret = genpd_add_device(genpd, dev, NULL);
> +	ret = genpd_add_device(genpd, dev);
>  	mutex_unlock(&gpd_list_lock);
>  
>  	return ret;
> @@ -2259,7 +2254,7 @@ int of_genpd_add_device(struct of_phandle_args *genpdspec, struct device *dev)
>  		goto out;
>  	}
>  
> -	ret = genpd_add_device(genpd, dev, NULL);
> +	ret = genpd_add_device(genpd, dev);
>  
>  out:
>  	mutex_unlock(&gpd_list_lock);
> @@ -2429,7 +2424,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>  
>  	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
>  
> -	ret = genpd_add_device(pd, dev, NULL);
> +	ret = genpd_add_device(pd, dev);
>  	mutex_unlock(&gpd_list_lock);
>  
>  	if (ret < 0) {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
