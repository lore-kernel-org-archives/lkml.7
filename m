Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EF3C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 03:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A2F214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 03:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tVDkPgAf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbfDRDxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 23:53:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34505 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387763AbfDRDx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 23:53:29 -0400
Received: by mail-pg1-f196.google.com with SMTP id v12so543428pgq.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 20:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=18rgLRX6g0Y1/lOFEoiyIdXM2XzwSH57sglGtKBWBsA=;
        b=tVDkPgAfdyxBwXsEAsBKhrOoI+UrR1Ge9hX658hzBfD/DzVcDXrDZaKYkNgAC/Z7Z3
         7Us/Li3DfY4zinWhWLPyZWcbDu9rnR9YiP3Z2ICwCoH5uBFZXSbP1+efN5PjJgTWqxwW
         B5dUBw1DE4JhP1Dx9ApLZJcx1nMMQymWZBrFZ7Fmp/TaFuMmqDjYa4qxZMjNCva7L72j
         l2wWMp0uqfxffIq4+i/ZYVe4KlO/MpIc50sKnMXjZyzVksN0u0MgtC4FqxKIuSDWixjE
         hdpUnmXUWsKvyu7s4Wf1l+fheMo81BNFQwodZXqzUHjbVfXUXbY8BWRDKYOleMdrxjuO
         MIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=18rgLRX6g0Y1/lOFEoiyIdXM2XzwSH57sglGtKBWBsA=;
        b=S5D87XPFEGpeli4AsCqH0MnUlyyyXKmzeQfok9iaJc2lHFMLfyO+iwXXWOWmR5mos7
         k2bEBRZ97vcRempBpxzfXWtm8EvEK+SVUq5DMeeEQflUjc0jIiIgbt1Ay0ALvZUv6q79
         uBygcCnKzuTAvMOYf/v2ny+UKfJg+SKSfMrmOFEFrXhJglbPUbkmXsj1N4QWH/wDFPKQ
         xcr2+W2v0JAJ/oGKQs/xKQ3r+LaJhQj9aYPf9EV2Bt6DePYQo9M0BpH5AWT4oJ1NMEax
         89evAeO7pZ+pIePguP8VolGWtxJWT6LEhaSlUMf3UerZWGGAdvgrkvRZ9Vemz3syVG7j
         LiJA==
X-Gm-Message-State: APjAAAWvIwGpeYw+gRsIstG3yWz5gfBOdCBFuSaJkuPY7qjFJpUpYdVh
        FIPauXvcN9WbqXYdDp6cSs79yg==
X-Google-Smtp-Source: APXvYqw1AgjVO/oO3DC5jV6LNvvf65Qt/UOl3ffCrVLj7XsNlTtMjSejwgzA0TathK2MiOfM1rOndQ==
X-Received: by 2002:a63:25c4:: with SMTP id l187mr88041249pgl.202.1555559608619;
        Wed, 17 Apr 2019 20:53:28 -0700 (PDT)
Received: from localhost ([103.48.124.5])
        by smtp.gmail.com with ESMTPSA id 4sm844684pfn.159.2019.04.17.20.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 20:53:26 -0700 (PDT)
Date:   Thu, 18 Apr 2019 09:23:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com,
        catalin.marinas@arm.com, daniel.lezcano@linaro.org,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mka@chromium.org
Subject: Re: [PATCH v2 3/3] thermal: cpu_cooling: Migrate to using the EM
 framework
Message-ID: <20190418035323.onyfxo4kprwqz2wl@vireshk-mac-ubuntu>
References: <20190417094301.17622-1-quentin.perret@arm.com>
 <20190417094301.17622-4-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417094301.17622-4-quentin.perret@arm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-04-19, 10:43, Quentin Perret wrote:
>  static struct thermal_cooling_device *
>  __cpufreq_cooling_register(struct device_node *np,
> -			struct cpufreq_policy *policy, u32 capacitance)
> +			struct cpufreq_policy *policy,
> +			struct em_perf_domain *em)
>  {

> +	if (em_is_sane(cpufreq_cdev, em)) {
> +		cpufreq_cdev->em = em;
>  		cooling_ops = &cpufreq_power_cooling_ops;
> -	} else {
> +	} else if (policy->freq_table_sorted != CPUFREQ_TABLE_UNSORTED) {
>  		cooling_ops = &cpufreq_cooling_ops;
> +	} else {
> +		WARN(1, "cpu_cooling: no valid frequency table found\n");

Well the frequency table is valid, isn't it ? Maybe something like: "cpu_cooling
doesn't support unsorted frequency tables" ?

> +		cdev = ERR_PTR(-EINVAL);
> +		goto remove_ida;
>  	}
>  
>  	cdev = thermal_of_cooling_device_register(np, dev_name, cpufreq_cdev,
> @@ -691,7 +619,7 @@ __cpufreq_cooling_register(struct device_node *np,
>  	if (IS_ERR(cdev))
>  		goto remove_ida;
>  
> -	cpufreq_cdev->clipped_freq = cpufreq_cdev->freq_table[0].frequency;
> +	cpufreq_cdev->clipped_freq = get_state_freq(cpufreq_cdev, 0);
>  	cpufreq_cdev->cdev = cdev;
>  
>  	mutex_lock(&cooling_list_lock);
> @@ -708,8 +636,6 @@ __cpufreq_cooling_register(struct device_node *np,
>  
>  remove_ida:
>  	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
> -free_table:
> -	kfree(cpufreq_cdev->freq_table);
>  free_idle_time:
>  	kfree(cpufreq_cdev->idle_time);
>  free_cdev:
> @@ -731,7 +657,7 @@ __cpufreq_cooling_register(struct device_node *np,
>  struct thermal_cooling_device *
>  cpufreq_cooling_register(struct cpufreq_policy *policy)
>  {
> -	return __cpufreq_cooling_register(NULL, policy, 0);
> +	return __cpufreq_cooling_register(NULL, policy, NULL);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_cooling_register);
>  
> @@ -759,7 +685,6 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
>  {
>  	struct device_node *np = of_get_cpu_node(policy->cpu, NULL);
>  	struct thermal_cooling_device *cdev = NULL;
> -	u32 capacitance = 0;
>  
>  	if (!np) {
>  		pr_err("cpu_cooling: OF node not available for cpu%d\n",
> @@ -768,10 +693,9 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
>  	}
>  
>  	if (of_find_property(np, "#cooling-cells", NULL)) {
> -		of_property_read_u32(np, "dynamic-power-coefficient",
> -				     &capacitance);
> +		struct em_perf_domain *em = em_cpu_get(policy->cpu);
>  
> -		cdev = __cpufreq_cooling_register(np, policy, capacitance);
> +		cdev = __cpufreq_cooling_register(np, policy, em);
>  		if (IS_ERR(cdev)) {
>  			pr_err("cpu_cooling: cpu%d failed to register as cooling device: %ld\n",
>  			       policy->cpu, PTR_ERR(cdev));
> @@ -813,7 +737,6 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
>  	thermal_cooling_device_unregister(cpufreq_cdev->cdev);
>  	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
>  	kfree(cpufreq_cdev->idle_time);
> -	kfree(cpufreq_cdev->freq_table);
>  	kfree(cpufreq_cdev);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_cooling_unregister);
> -- 
> 2.21.0

-- 
viresh
