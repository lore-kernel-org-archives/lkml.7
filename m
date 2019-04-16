Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49B8C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A3820693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="no2mkbIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbfDPM6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:58:38 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42304 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729245AbfDPM6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 08:58:35 -0400
Received: by mail-pl1-f195.google.com with SMTP id cv12so10330341plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 05:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hGsK6YV7IXHB4c8lI2Da0gdlOYYwotiHlsdUG3YCLQQ=;
        b=no2mkbIwr/26h0ne0fwVsE3g77WHrGsS8dZtFzFhkv7+Vek9NYgmdAFXgl3rFZ3IIm
         7VolCYGvyX8glfWZ/RJaG3ELvKYY0UXwnoO+RKOX8ADmV2Q3TIfP6WdOI/wz0bpaMle4
         io4dz4yIvpdOL8SImyVvNL9Mft/miNLgQspL9kOn8ZzVwlZdv56LZLUqqh565f3/7TyW
         9QId/XjSfyj/HjDz9MUGbJfKKfG7Y18gXuYtl6yifQU2cwoJTEBomT+yO3D0QS1ryEIm
         URs6bVW2K9g+crZqO/UOk+eKX6kvuB9cMD5Q6E52AcIMLqmHHrV1AcS7HexJVC1Hqz9k
         bo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hGsK6YV7IXHB4c8lI2Da0gdlOYYwotiHlsdUG3YCLQQ=;
        b=Sew2w6+frN4TxdJfNjQNl8XptsAroG3oxdpctFhnTswFppQhcWCdaK9SfnbEkBnrwM
         flrBEGXKIosHKsG0wH2+JPpcjM3gzbUMyZ//APPT5i45r4cxz9o9FKBwqLHc3D6DVQ0E
         xh32WqUPApXhdOa8St2IdbLASFqHEi+Zhpuqflg/yvb593b/rG8fH7J+FW77YjBvx01W
         S2vaulLQiMiOvmz58gipTC2GHLQRJjFgCgaKKU3kkO5tmsrqy/M4LzANv4EcXzd6wae1
         OtPeQhMiWbfgu3Q1lgd4x4LvoNdDfMkq99kzIpHGwr5ik3/TtTYezY4adFcmhR4haMiw
         UTSQ==
X-Gm-Message-State: APjAAAXYCopNSuveH6UkDkDB7fahVAXfSDZ1EkxtDS8wg2PuCwW+IliV
        yiF19DAPYaqiRzrMGr2rpoB9fQ==
X-Google-Smtp-Source: APXvYqzJEKysFP2FA956JpTHNnV54f0EIGeFHV7vqQIzbffjB+78ZdznyOnnbiV1KMS7ZdUukBsXmg==
X-Received: by 2002:a17:902:e4:: with SMTP id a91mr63753671pla.2.1555419515080;
        Tue, 16 Apr 2019 05:58:35 -0700 (PDT)
Received: from localhost ([43.229.100.82])
        by smtp.gmail.com with ESMTPSA id f63sm106613082pfc.180.2019.04.16.05.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 05:58:30 -0700 (PDT)
Date:   Tue, 16 Apr 2019 18:28:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mohan Kumar <mohankumar718@gmail.com>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND] drivers/cpufreq/acpi-cpufreq.c: This fixes the
 following  checkpatch warning
Message-ID: <20190416125825.vkjjujxdls7rwnem@vireshk-mac-ubuntu>
References: <1555326238-3612-1-git-send-email-mohankumar718@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555326238-3612-1-git-send-email-mohankumar718@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-04-19, 14:03, Mohan Kumar wrote:
> WARNING: Prefer using '"%s...", __func__' to using function's name, in a
> string
> 
> Switch hardcoded function name with a reference to __func__ making the
> code more maintainable
> 
> Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index c72258a..73bb2aa 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -366,7 +366,7 @@ static u32 get_cur_val(const struct cpumask *mask, struct acpi_cpufreq_data *dat
>  
>  	val = drv_read(data, mask);
>  
> -	pr_debug("get_cur_val = %u\n", val);
> +	pr_debug("%s = %u\n", __func__, val);
>  
>  	return val;
>  }
> @@ -378,7 +378,7 @@ static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
>  	unsigned int freq;
>  	unsigned int cached_freq;
>  
> -	pr_debug("get_cur_freq_on_cpu (%d)\n", cpu);
> +	pr_debug("%s (%d)\n", __func__, cpu);
>  
>  	policy = cpufreq_cpu_get_raw(cpu);
>  	if (unlikely(!policy))
> @@ -458,8 +458,7 @@ static int acpi_cpufreq_target(struct cpufreq_policy *policy,
>  	if (acpi_pstate_strict) {
>  		if (!check_freqs(policy, mask,
>  				 policy->freq_table[index].frequency)) {
> -			pr_debug("acpi_cpufreq_target failed (%d)\n",
> -				policy->cpu);
> +			pr_debug("%s (%d)\n", __func__, policy->cpu);
>  			result = -EAGAIN;
>  		}
>  	}
> @@ -573,7 +572,7 @@ static int cpufreq_boost_down_prep(unsigned int cpu)
>  static int __init acpi_cpufreq_early_init(void)
>  {
>  	unsigned int i;
> -	pr_debug("acpi_cpufreq_early_init\n");
> +	pr_debug("%s\n", __func__);
>  
>  	acpi_perf_data = alloc_percpu(struct acpi_processor_performance);
>  	if (!acpi_perf_data) {
> @@ -657,7 +656,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	static int blacklisted;
>  #endif
>  
> -	pr_debug("acpi_cpufreq_cpu_init\n");
> +	pr_debug("%s\n", __func__);
>  
>  #ifdef CONFIG_SMP
>  	if (blacklisted)
> @@ -856,7 +855,7 @@ static int acpi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>  {
>  	struct acpi_cpufreq_data *data = policy->driver_data;
>  
> -	pr_debug("acpi_cpufreq_cpu_exit\n");
> +	pr_debug("%s\n", __func__);
>  
>  	policy->fast_switch_possible = false;
>  	policy->driver_data = NULL;
> @@ -881,7 +880,7 @@ static int acpi_cpufreq_resume(struct cpufreq_policy *policy)
>  {
>  	struct acpi_cpufreq_data *data = policy->driver_data;
>  
> -	pr_debug("acpi_cpufreq_resume\n");
> +	pr_debug("%s\n", __func__);
>  
>  	data->resume = 1;
>  
> @@ -954,7 +953,7 @@ static int __init acpi_cpufreq_init(void)
>  	if (cpufreq_get_current_driver())
>  		return -EEXIST;
>  
> -	pr_debug("acpi_cpufreq_init\n");
> +	pr_debug("%s\n", __func__);
>  
>  	ret = acpi_cpufreq_early_init();
>  	if (ret)
> @@ -991,7 +990,7 @@ static int __init acpi_cpufreq_init(void)
>  
>  static void __exit acpi_cpufreq_exit(void)
>  {
> -	pr_debug("acpi_cpufreq_exit\n");
> +	pr_debug("%s\n", __func__);
>  
>  	acpi_cpufreq_boost_exit();
>  

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
