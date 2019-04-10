Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97607C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 03:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6497A2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 03:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ij5G/oNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfDJDYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 23:24:10 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45056 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfDJDYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 23:24:10 -0400
Received: by mail-pl1-f194.google.com with SMTP id bf11so460126plb.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 20:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fDaB7AQBQgFAqrLsrjcQE4bi+tzImk9oc4UlfpH5iRQ=;
        b=ij5G/oNb95eXSsD1S1NKcpDLAzxltRjzkS2vNxx91dTvZMCLJ8UGUYbYp8D/QOEzlt
         mFEM1HjvQcEddXUwos41AXju6J7szB6Q2piB/JoLbGyI149Mw7NIz838E/2kj4QPSJpK
         e8C7+1jFHlYUcsjVLZyLH5fWMyaImWWIMPmgigXgBah+v64bM5LkksDsEVolBoeQTc78
         ckVyp/McmqDVAFuwEZkXRyRw/kpmnBkF90UDcZVCY+TiZ++PiRDJ1iCifzIF4hIIly6l
         aSdwrk8xITYyrySxD13fcKVdzufZ+5IhNQzXwZhwchRJ4Fzfmn25RtN62g4iG9Oz7izY
         7xXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fDaB7AQBQgFAqrLsrjcQE4bi+tzImk9oc4UlfpH5iRQ=;
        b=U/vzc1ic8KYCR5ZrP8Y8mc34Qt4lxBBU2/Yv1gJbyZgjl3KjB7r6ek5ArZDPk6z1M+
         QgfDo/OlvVylUDbm6DM5794JwTInBm5jIi5unxKxuvNZnrg/4hDloDRLj8S0orYA0M2R
         UdtLLWQp1YvYifZzjHxczgDOdwPIrslDDl6lh186FPP7PjdLR+w/IRfkqv+UDnGPgxSs
         riAyJQ5CX+A5vn521QF6UyDPtH9OO2x2pT2zOvcAd4Y2NzRQbpSWtcWd0GdHhyRbdezK
         iJZhXnJ4VoGKdeSFT6co2mtoG6vqCsCwoMy2QteywxsBch7whqcS8/4K5gfZzCQ2Z+wL
         3RqA==
X-Gm-Message-State: APjAAAUH7zj4rpLKW7PGSRa13O90BedJWcwNZAXEXoMyrVYwkNl09/1h
        MIBu0b6D2KQ37pjTN2NLigWO6Q==
X-Google-Smtp-Source: APXvYqy4WqxmeDHzZvbtNMMhHMZKHov4Nr0cvDcxQD92LS5by/92IhrsIw9zJiVxeD3QvXTnFVK+uQ==
X-Received: by 2002:a17:902:184:: with SMTP id b4mr20220942plb.26.1554866649145;
        Tue, 09 Apr 2019 20:24:09 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id l10sm25158503pfc.46.2019.04.09.20.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 20:24:06 -0700 (PDT)
Date:   Wed, 10 Apr 2019 08:54:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, rjw@rjwysocki.net,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cpufreq: Add sunxi nvmem based CPU scaling driver
Message-ID: <20190410032404.eskk4qxbsws6fbec@vireshk-i7>
References: <20190409172558.18778-1-tiny.windzz@gmail.com>
 <20190409172558.18778-2-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409172558.18778-2-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-04-19, 13:25, Yangtao Li wrote:
> +static const struct sunxi_cpufreq_soc_data sun50i_h6_data = {
> +	.efuse_xlate = sun50i_efuse_xlate,
> +	.nvmem_mask = 0x7,
> +	.nvmem_shift = 5,
> +};
> +
> +static const struct of_device_id sunxi_cpufreq_match_list[] = {
> +	{ .compatible = "allwinner,sun50i-h6", .data = &sun50i_h6_data },
> +	{}
> +};
> +
> +static const struct of_device_id *sunxi_cpufreq_match_node(void)
> +{
> +	struct device_node *np;
> +	const struct of_device_id *match;
> +
> +	np = of_find_node_by_path("/");
> +	match = of_match_node(sunxi_cpufreq_match_list, np);
> +	of_node_put(np);
> +
> +	return match;
> +}
> +

Above code can be placed just above sunxi_cpufreq_init(), if you ...

> +static int sunxi_cpufreq_nvmem_probe(struct platform_device *pdev)
> +{
> +	const struct sunxi_cpufreq_soc_data *soc_data;
> +	struct opp_table **opp_tables;
> +	const struct of_device_id *match;
> +	char name[MAX_NAME_LEN];
> +	unsigned int cpu;
> +	u32 speed = 0;
> +	int ret;
> +
> +	opp_tables = kcalloc(num_possible_cpus(), sizeof(*opp_tables),
> +			     GFP_KERNEL);
> +	if (!opp_tables)
> +		return -ENOMEM;
> +
> +	match = sunxi_cpufreq_match_node();

... avoid this and ...

> +	soc_data = match->data;
> +	if (!soc_data)
> +		return -EINVAL;
> +
> +	ret = sunxi_cpufreq_get_efuse(soc_data, &speed);
> +	if (ret)
> +		return ret;
> +
> +	snprintf(name, MAX_NAME_LEN, "speed%d", speed);
> +
> +	for_each_possible_cpu(cpu) {
> +		struct device *cpu_dev = get_cpu_device(cpu);
> +
> +		if (NULL == cpu_dev) {
> +			ret = -ENODEV;
> +			goto free_opp;
> +		}
> +
> +		opp_tables[cpu] = dev_pm_opp_set_prop_name(cpu_dev, name);
> +		if (IS_ERR(opp_tables[cpu])) {
> +			ret = PTR_ERR(opp_tables[cpu]);
> +			pr_err("Failed to set prop name\n");
> +			goto free_opp;
> +		}
> +	}
> +
> +	cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,
> +							  NULL, 0);
> +	if (!IS_ERR(cpufreq_dt_pdev)) {
> +		platform_set_drvdata(pdev, opp_tables);
> +		return 0;
> +	}
> +
> +	ret = PTR_ERR(cpufreq_dt_pdev);
> +	pr_err("Failed to register platform device\n");
> +
> +free_opp:
> +	for_each_possible_cpu(cpu) {
> +		if (IS_ERR_OR_NULL(opp_tables[cpu]))
> +			break;
> +		dev_pm_opp_put_prop_name(opp_tables[cpu]);
> +	}
> +	kfree(opp_tables);
> +
> +	return ret;
> +}
> +
> +static int sunxi_cpufreq_nvmem_remove(struct platform_device *pdev)
> +{
> +	struct opp_table **opp_tables = platform_get_drvdata(pdev);
> +	unsigned int cpu;
> +
> +	platform_device_unregister(cpufreq_dt_pdev);
> +
> +	for_each_possible_cpu(cpu)
> +		dev_pm_opp_put_prop_name(opp_tables[cpu]);
> +
> +	kfree(opp_tables);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver sunxi_cpufreq_driver = {
> +	.probe = sunxi_cpufreq_nvmem_probe,
> +	.remove = sunxi_cpufreq_nvmem_remove,
> +	.driver = {
> +		.name = "sunxi-cpufreq-nvmem",
> +	},
> +};
> +
> +/*
> + * Since the driver depends on nvmem drivers, which may return EPROBE_DEFER,
> + * all the real activity is done in the probe, which may be defered as well.
> + * The init here is only registering the driver and the platform device.
> + */
> +static int __init sunxi_cpufreq_init(void)
> +{
> +	const struct of_device_id *match;
> +	int ret;
> +
> +	match = sunxi_cpufreq_match_node();
> +	if (!match)
> +		return -ENODEV;
> +
> +	ret = platform_driver_register(&sunxi_cpufreq_driver);
> +	if (unlikely(ret < 0))
> +		return ret;
> +
> +	sunxi_cpufreq_pdev = platform_device_register_simple(
> +		"sunxi-cpufreq-nvmem", -1, NULL, 0);

... pass match->data as platform device's data here..

> +	ret = PTR_ERR_OR_ZERO(sunxi_cpufreq_pdev);
> +	if (0 == ret)
> +		return 0;
> +
> +	platform_driver_unregister(&sunxi_cpufreq_driver);
> +	return ret;
> +}
> +module_init(sunxi_cpufreq_init);
> +
> +static void __exit sunxi_cpufreq_exit(void)
> +{
> +	platform_device_unregister(sunxi_cpufreq_pdev);
> +	platform_driver_unregister(&sunxi_cpufreq_driver);
> +}
> +module_exit(sunxi_cpufreq_exit);
> +
> +MODULE_DESCRIPTION("Sunxi cpufreq driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.17.0

-- 
viresh
