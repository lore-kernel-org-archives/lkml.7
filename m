Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BECC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A07820830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OujTAQQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbfDJKdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:33:21 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41484 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbfDJKdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:33:20 -0400
Received: by mail-pl1-f194.google.com with SMTP id d1so1172355plj.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 03:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o6MP4MD2XvqRqDBpI14/SbmM5jumQB8YX4MXAiMxcgg=;
        b=OujTAQQPHwq+Rr4uTnK74C/W70fLAhCmbeQzs7wLTUnxJN8i+7ARsbfJ8C2uFQK2VW
         EWKctw7l0crAZJc430ajsnAkdBEKVrS0lAcIyeAJE41I1QqRZQhaGTavEHn8az8FxP9w
         xIlDRhyb0pB3LwN8fqXS3Efiiv/cG1GIUFwHbgcCikgJtorgUi8miWSIxpTkVb1YB2HQ
         Enc6wk+PYVv0VSXhA/B80gD5yfT+qNeoxUdIQbXxMdCW026nx27ebhaHYxBkf3HAtcTK
         CQGessLwHtGH0qRAcf2vjXGHHG5Irfgyq0gQIeoes6n7/B2H7KTTF/MrECqqayMgyTSB
         lXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o6MP4MD2XvqRqDBpI14/SbmM5jumQB8YX4MXAiMxcgg=;
        b=ntnZAvUw6UNrY+rNqzn5zGK2OVutXb+DT//hvcb36QeYkRqvNQRVz22f3bq5Ui0F0l
         3TV6cus4eNSq9ZVmVg1JJFW2O3OkDc0N6pUZ1WgqNxeTuMYooMz4kLpBIbKOnyiR+zSf
         bfHQDUd8T+BNXi0jglnYvuAgtFhPfWX64Q+jERL+zxmqMpErw7vfOilpAewBvHwDFM+B
         W+OT9Zy/05e+COwzHAjXZTVgIZKQiscKW4Psh6dchxtDMUf5eI2K8z6jgESdawBkaJmJ
         SQ/ncasnlHU+guavH++YUrfl51K52lFcG4KAiPplaAs8CH4R1/JLrt7meepTRREAdu17
         52NQ==
X-Gm-Message-State: APjAAAXQbKo+bv4UEo569OvrpW+/3Ja0jwFBJYmixcjo+kNCLeTprkHN
        8ucOiANZJR5AMs2TH4KuNWoblOF9sZM=
X-Google-Smtp-Source: APXvYqw+Nx1Y+7H23kBikUygsyauL9xa46UprB/ftsk+YWYHtSqDL/XDQtgzY94OU/Wa7WZrRXj7kQ==
X-Received: by 2002:a17:902:2d01:: with SMTP id o1mr43337462plb.155.1554892399613;
        Wed, 10 Apr 2019 03:33:19 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id d68sm50349990pfg.16.2019.04.10.03.33.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 03:33:18 -0700 (PDT)
Date:   Wed, 10 Apr 2019 16:03:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     robh+dt@kernel.org, andy.gross@linaro.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        rjw@rjwysocki.net, nm@ti.com, sboyd@kernel.org,
        georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        david.brown@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        cw00.choi@samsung.com, linux-pm@vger.kernel.org,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        dianders@chromium.org
Subject: Re: [PATCH RFC 7/9] cpufreq: qcom: Add support to update cpu node's
 OPP tables
Message-ID: <20190410103316.sxev2f54klemq2p6@vireshk-i7>
References: <20190328152822.532-1-sibis@codeaurora.org>
 <20190328152822.532-8-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328152822.532-8-sibis@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-03-19, 20:58, Sibi Sankar wrote:
> Add support to parse and update OPP tables attached to the cpu nodes.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 4b0b50403901..5c268dd2346c 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -73,6 +73,25 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
>  	return policy->freq_table[index].frequency;
>  }
>  
> +static int qcom_find_update_opp(struct device *cpu_dev, unsigned long freq,
> +				unsigned long volt)
> +{
> +	int ret;
> +	struct dev_pm_opp *opp;
> +
> +	opp = dev_pm_opp_find_freq_exact(cpu_dev, freq, true);
> +	if (IS_ERR(opp)) {
> +		ret = dev_pm_opp_add(cpu_dev, freq, volt);

With my comment on the other patch, you can just call
dev_pm_opp_update_voltage() and if that fails then call dev_pm_opp_add().

> +	} else {
> +		dev_pm_opp_disable(cpu_dev, freq);
> +		ret = dev_pm_opp_update_voltage(cpu_dev, freq, volt);
> +		dev_pm_opp_enable(cpu_dev, freq);

Perhaps no one else should be using the CPU OPP table at this point of time and
so we can get away with disable and enable stuff ? Just add a comment on why
that works.

> +		dev_pm_opp_put(opp);
> +	}
> +
> +	return ret;
> +}
> +
>  static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>  				    struct cpufreq_policy *policy,
>  				    void __iomem *base)
> @@ -81,11 +100,16 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>  	u32 volt;
>  	unsigned int max_cores = cpumask_weight(policy->cpus);
>  	struct cpufreq_frequency_table	*table;
> +	int ret;
>  
>  	table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
>  	if (!table)
>  		return -ENOMEM;
>  
> +	ret = dev_pm_opp_of_add_table(cpu_dev);
> +	if (ret)
> +		dev_dbg(cpu_dev, "Couldn't add OPP table\n");
> +
>  	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
>  		data = readl_relaxed(base + REG_FREQ_LUT +
>  				      i * LUT_ROW_SIZE);
> @@ -104,7 +128,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>  
>  		if (freq != prev_freq && core_count == max_cores) {
>  			table[i].frequency = freq;
> -			dev_pm_opp_add(cpu_dev, freq * 1000, volt);
> +			qcom_find_update_opp(cpu_dev, freq * 1000, volt);
>  			dev_dbg(cpu_dev, "index=%d freq=%d, core_count %d\n", i,
>  				freq, core_count);
>  		} else {
> @@ -125,7 +149,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>  			if (prev_cc != max_cores) {
>  				prev->frequency = prev_freq;
>  				prev->flags = CPUFREQ_BOOST_FREQ;
> -				dev_pm_opp_add(cpu_dev,	prev_freq * 1000, volt);
> +				qcom_find_update_opp(cpu_dev, prev_freq * 1000,
> +						     volt);
>  			}
>  
>  			break;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project

-- 
viresh
