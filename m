Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C3EC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EEA920857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c1DoJwQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfDIFmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 01:42:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41737 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfDIFmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 01:42:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id 188so9006908pfd.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 22:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jQR2Et4xyaw7aCJ9ETZupXJGTkXAZENkN09YLjG4cx4=;
        b=c1DoJwQuupsLpVxr/pqtD8l80W0DJ20KrhRgVQKFtZo7rLA4RkUgDcO2jGYua8FENg
         ePOGu/Uei8qSDJ8JXWTJFAgplQ9EPiH2WpUUMhPCweK/OK5YKNHjtL9aTuBy36evA44h
         rs7TWl+ZCfjR1/bHlob0D0cOkvNBnve+R1/4FKdrcS5VOJvDTqVSG7LyUeGg7HUzNkSf
         mZehA28btpNaFbHd5PdEgc0qDeXRd7Rudd/rZ6Et8apBA8htocQ9pi1/ZlipcfzBwpfY
         tQsu/PJuKTVsM39GXQUfNMIcX+xS2Cb6J0Iab6rDl10Jk/VduW8iIeEGsaZbEMB4OMr+
         dT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jQR2Et4xyaw7aCJ9ETZupXJGTkXAZENkN09YLjG4cx4=;
        b=fUErxBA2emPrdy9y4EjhcyT4GKx8tEbM9/XMPto0xgMZ1k6N+QDeGRAUgQlyyY2mc+
         PbWRWKlgcIZZ30TDrwF8x1eYXygEp6fcM68K9xhmMV7cI/y1K5jZnAFKK5Nwtb7kxIOx
         b7oQxKTpRTruKQx1WUpInmw2QX+JmBjoWDdExsxZ9ULQPV4e9L1/ga+GvIc5mPIgIe/7
         8mVVPYp38yUpMkRg6j610FmNxys1q+yR46HJUJ+UIFPjTyUrrwLeQlK2Sfy/tK6kxsJA
         8miuWk8FDZZi1U7es5HKE04jpExQB6DnhXJN2uRCr7hzcC80NVQ1UlhrR1p+QCBda3uq
         eh8Q==
X-Gm-Message-State: APjAAAWLkpBvlKUCkpS9Oz5UiX5DRcJyC97IS6WwXHWMNZNz8I+UJQdf
        VdKlmFr6dCQoXxqlYtbj2Di84Q==
X-Google-Smtp-Source: APXvYqxPw8ruI0dT54eJUNcaMgCOdyzwigsrAqRoYDQofD6eBeq9V6Ms2GbFUN/wqkrwq5HdbJuX9Q==
X-Received: by 2002:a63:330e:: with SMTP id z14mr31890765pgz.4.1554788555155;
        Mon, 08 Apr 2019 22:42:35 -0700 (PDT)
Received: from localhost ([122.172.162.162])
        by smtp.gmail.com with ESMTPSA id 13sm39149660pfi.172.2019.04.08.22.42.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 22:42:34 -0700 (PDT)
Date:   Tue, 9 Apr 2019 11:12:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/9] cpufreq: qcom: create a driver struct
Message-ID: <20190409054232.76ies442zgfhh7vf@vireshk-i7>
References: <20190404050931.9812-1-niklas.cassel@linaro.org>
 <20190404050931.9812-4-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404050931.9812-4-niklas.cassel@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-04-19, 07:09, Niklas Cassel wrote:
> create a driver struct to make it easier to free up all common
> resources, and only call dev_pm_opp_set_supported_hw() if the
> implementation has dynamically allocated versions.
> 
> Co-developed-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 69 ++++++++++++++++++----------
>  1 file changed, 46 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index 652a1de2a5d4..366c65a7132a 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -43,6 +43,11 @@ enum _msm8996_version {
>  	NUM_OF_MSM8996_VERSIONS,
>  };
>  
> +struct qcom_cpufreq_drv {

I would suggest renaming it a bit, around the purpose of this thing. Maybe like
struct supported_hw {} ? Or something else that you would like.

> +	struct opp_table **opp_tables;
> +	u32 *versions;

Maybe this can be just "u32 versions" instead and you won't need a separate
kzalloc.

> +};
> +
>  static struct platform_device *cpufreq_dt_pdev, *cpufreq_pdev;
>  
>  static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
> @@ -76,12 +81,16 @@ static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
>  
>  static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
>  					  struct nvmem_cell *speedbin_nvmem,
> -					  u32 *versions)
> +					  struct qcom_cpufreq_drv *drv)
>  {
>  	size_t len;
>  	u8 *speedbin;
>  	enum _msm8996_version msm8996_version;
>  
> +	drv->versions = kzalloc(sizeof(*drv->versions), GFP_KERNEL);
> +	if (!drv->versions)
> +		return -ENOMEM;
> +
>  	msm8996_version = qcom_cpufreq_get_msm_id();
>  	if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
>  		dev_err(cpu_dev, "Not Snapdragon 820/821!");
> @@ -94,10 +103,10 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
>  
>  	switch (msm8996_version) {
>  	case MSM8996_V3:
> -		*versions = 1 << (unsigned int)(*speedbin);
> +		*drv->versions = 1 << (unsigned int)(*speedbin);
>  		break;
>  	case MSM8996_SG:
> -		*versions = 1 << ((unsigned int)(*speedbin) + 4);
> +		*drv->versions = 1 << ((unsigned int)(*speedbin) + 4);
>  		break;

I see that versions will surely have a non-zero value here ? In that case you
can use it ... (see later)

>  	default:
>  		BUG();
> @@ -110,15 +119,14 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
>  
>  static int qcom_cpufreq_probe(struct platform_device *pdev)
>  {
> -	struct opp_table **opp_tables;
> +	struct qcom_cpufreq_drv *drv;
>  	int (*get_version)(struct device *cpu_dev,
>  			   struct nvmem_cell *speedbin_nvmem,
> -			   u32 *versions);
> +			   struct qcom_cpufreq_drv *drv);
>  	struct nvmem_cell *speedbin_nvmem;
>  	struct device_node *np;
>  	struct device *cpu_dev;
>  	unsigned cpu;
> -	u32 versions;
>  	const struct of_device_id *match;
>  	int ret;
>  
> @@ -141,23 +149,31 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>  		return -ENOENT;
>  	}
>  
> +	drv = kzalloc(sizeof(*drv), GFP_KERNEL);
> +	if (!drv)
> +		return -ENOMEM;
> +
>  	speedbin_nvmem = of_nvmem_cell_get(np, NULL);
>  	of_node_put(np);
>  	if (IS_ERR(speedbin_nvmem)) {
>  		if (PTR_ERR(speedbin_nvmem) != -EPROBE_DEFER)
>  			dev_err(cpu_dev, "Could not get nvmem cell: %ld\n",
>  				PTR_ERR(speedbin_nvmem));
> -		return PTR_ERR(speedbin_nvmem);
> +		ret = PTR_ERR(speedbin_nvmem);
> +		goto free_drv;
>  	}
>  
> -	ret = get_version(cpu_dev, speedbin_nvmem, &versions);
> +	ret = get_version(cpu_dev, speedbin_nvmem, drv);
>  	nvmem_cell_put(speedbin_nvmem);
>  	if (ret)
> -		return ret;
> +		goto free_drv;
>  
> -	opp_tables = kcalloc(num_possible_cpus(), sizeof(*opp_tables), GFP_KERNEL);
> -	if (!opp_tables)
> -		return -ENOMEM;
> +	drv->opp_tables = kcalloc(num_possible_cpus(), sizeof(*drv->opp_tables),
> +				  GFP_KERNEL);
> +	if (!drv->opp_tables) {
> +		ret = -ENOMEM;
> +		goto free_drv;
> +	}
>  
>  	for_each_possible_cpu(cpu) {
>  		cpu_dev = get_cpu_device(cpu);
> @@ -166,10 +182,12 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>  			goto free_opp;
>  		}
>  
> -		opp_tables[cpu] = dev_pm_opp_set_supported_hw(cpu_dev,
> -							      &versions, 1);
> -		if (IS_ERR(opp_tables[cpu])) {
> -			ret = PTR_ERR(opp_tables[cpu]);
> +		if (drv->versions)

... here like "if (*drv->versions)" instead and get rid of kzalloc ?

> +			drv->opp_tables[cpu] =
> +				dev_pm_opp_set_supported_hw(cpu_dev,
> +							    drv->versions, 1);
> +		if (IS_ERR(drv->opp_tables[cpu])) {

This should be part of the above if() block as we shouldn't check it if
*versions == 0.

> +			ret = PTR_ERR(drv->opp_tables[cpu]);
>  			dev_err(cpu_dev, "Failed to set supported hardware\n");
>  			goto free_opp;
>  		}
> @@ -178,7 +196,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>  	cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,
>  							  NULL, 0);
>  	if (!IS_ERR(cpufreq_dt_pdev)) {
> -		platform_set_drvdata(pdev, opp_tables);
> +		platform_set_drvdata(pdev, drv);
>  		return 0;
>  	}
>  
> @@ -187,26 +205,31 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>  
>  free_opp:
>  	for_each_possible_cpu(cpu) {
> -		if (IS_ERR_OR_NULL(opp_tables[cpu]))
> +		if (IS_ERR_OR_NULL(drv->opp_tables[cpu]))
>  			break;
> -		dev_pm_opp_put_supported_hw(opp_tables[cpu]);
> +		dev_pm_opp_put_supported_hw(drv->opp_tables[cpu]);
>  	}
> -	kfree(opp_tables);
> +	kfree(drv->opp_tables);
> +free_drv:
> +	kfree(drv->versions);
> +	kfree(drv);
>  
>  	return ret;
>  }
>  
>  static int qcom_cpufreq_remove(struct platform_device *pdev)
>  {
> -	struct opp_table **opp_tables = platform_get_drvdata(pdev);
> +	struct qcom_cpufreq_drv *drv = platform_get_drvdata(pdev);
>  	unsigned int cpu;
>  
>  	platform_device_unregister(cpufreq_dt_pdev);
>  
>  	for_each_possible_cpu(cpu)
> -		dev_pm_opp_put_supported_hw(opp_tables[cpu]);
> +		dev_pm_opp_put_supported_hw(drv->opp_tables[cpu]);
>  
> -	kfree(opp_tables);
> +	kfree(drv->opp_tables);
> +	kfree(drv->versions);
> +	kfree(drv);
>  
>  	return 0;
>  }
> -- 
> 2.20.1

-- 
viresh
