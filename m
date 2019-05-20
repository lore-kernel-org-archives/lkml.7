Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBC8C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 04:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EB9204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 04:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fSKOdMcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbfETEj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 00:39:58 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42852 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbfETEj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 00:39:58 -0400
Received: by mail-pl1-f195.google.com with SMTP id x15so6083377pln.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 21:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6kLQS1F3wuaAKNzg7vhydNFCxmz6B8BC90U2/spM1FQ=;
        b=fSKOdMcYitED5vQB9z2lLQZzixgZJPjE55iq07B6vr8Ej2UsgG6MWktZCgkSIwSCsI
         aohOXRN9tt1F7VgFsnlcygQ7jqTbvUgw6N76+vl6RtfNAdC3G4mduge0EeP5fPDEK4ir
         wU/F+17NKlSNGzFgpAlEmXY3l1oiBbt1vWu0oWzpMlAkDiDmpiADM+IPJ6D9TPJWj442
         SN2oowpO8va4CfRwrxDy9oOOpjqYLzFKql3ekqUzEZrzBHQbwiNHBe7Sg6f1Xtuz0ONw
         5i7EFPbWB0o08yFmOp/Szdm3eGDWPS1zSOUygHorOQwitj+oZJ+5FXTq8pMQJfuhyjp7
         v6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6kLQS1F3wuaAKNzg7vhydNFCxmz6B8BC90U2/spM1FQ=;
        b=bF+4wQ39NCdcYvj8kDULPpHguJXbZiT4TZdkhlEhuIUG3laZRxhamzUHXqvu7Y1/XH
         QrYW7OJSceOB9aeevj8/j3vmL8FGml+KMFNzwuSmLFwx4c66AmHypgPCt0v2mh3Ha9Df
         olb5TgNzkk/4iXiF3cJwsHNeIUUT4UZcQOuSJIMCPqeOYEJ4GMwIxQrXh46xTx7z73K4
         Tgqk4sENcVurjXNL2QN3E6O4QkU8S2lNV4RdemI4dKh0mIjvrA/gt/2UZlzyPZ4z51Ar
         9AGqKVdKFcRn+E9CfO/cx+nb1BfhlMrWNBsQwI63W3MMGjwvnbdALMi6mhXYi9mcrFrO
         n5gA==
X-Gm-Message-State: APjAAAUVrTW5lb3nBmIPYmpKqiJ/TjyHowat27bD33nJZ9OvmSGdlz4t
        S01u7WhM4q2O84LGMi7NvZ1pnw==
X-Google-Smtp-Source: APXvYqyXXC8k4W+c885rLWWP0fBPIxR3BpaGuJalf+p3A4fKVt/ZLy575wTVOvd0xsFl16aHF4pYzA==
X-Received: by 2002:a17:902:ab98:: with SMTP id f24mr72325766plr.223.1558327197415;
        Sun, 19 May 2019 21:39:57 -0700 (PDT)
Received: from localhost ([122.172.118.99])
        by smtp.gmail.com with ESMTPSA id p6sm7867707pfn.151.2019.05.19.21.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2019 21:39:55 -0700 (PDT)
Date:   Mon, 20 May 2019 10:09:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     stefan.wahren@i2se.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        mbrugger@suse.de, sboyd@kernel.org, eric@anholt.net,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        ptesarik@suse.com, linux-rpi-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [RFC 5/5] cpufreq: add driver for Raspbery Pi
Message-ID: <20190520043953.dsmxnxpggkzq4fnm@vireshk-i7>
References: <20190517153508.18314-1-nsaenzjulienne@suse.de>
 <20190517153508.18314-6-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517153508.18314-6-nsaenzjulienne@suse.de>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-05-19, 17:35, Nicolas Saenz Julienne wrote:
> Raspberry Pi's firmware offers and interface though which update it's
> performance requirements. It allows us to request for specific runtime
> frequencies, which the firmware might or might not respect, depending on
> the firmware configuration and thermals.
> 
> As the maximum and minimum frequencies are configurable in the firmware
> there is no way to know in advance their values. So the Raspberry Pi
> cpufreq driver queries them, builds an opp frequency table to then
> launch cpufreq-dt.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/cpufreq/Kconfig.arm           |  8 +++
>  drivers/cpufreq/Makefile              |  1 +
>  drivers/cpufreq/raspberrypi-cpufreq.c | 79 +++++++++++++++++++++++++++
>  3 files changed, 88 insertions(+)
>  create mode 100644 drivers/cpufreq/raspberrypi-cpufreq.c
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 179a1d302f48..70e5f13f7632 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -308,3 +308,11 @@ config ARM_PXA2xx_CPUFREQ
>  	  This add the CPUFreq driver support for Intel PXA2xx SOCs.
>  
>  	  If in doubt, say N.
> +
> +config ARM_RASPBERRYPI_CPUFREQ
> +	tristate "Raspberry Pi cpufreq support"
> +	depends on RASPBERRYPI_FIRMWARE || (RASPBERRYPI_FIRMWARE=n && COMPILE_TEST)

What about:
        depends on RASPBERRYPI_FIRMWARE || COMPILE_TEST

> +	help
> +	  This adds the CPUFreq driver for Raspberry Pi
> +
> +	  If in doubt, say N.
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 689b26c6f949..02678e9b2ff5 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -84,6 +84,7 @@ obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
>  obj-$(CONFIG_ARM_TEGRA186_CPUFREQ)	+= tegra186-cpufreq.o
>  obj-$(CONFIG_ARM_TI_CPUFREQ)		+= ti-cpufreq.o
>  obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
> +obj-$(CONFIG_ARM_RASPBERRYPI_CPUFREQ) 	+= raspberrypi-cpufreq.o
>  
>  
>  ##################################################################################
> diff --git a/drivers/cpufreq/raspberrypi-cpufreq.c b/drivers/cpufreq/raspberrypi-cpufreq.c
> new file mode 100644
> index 000000000000..53cb3e5a8457
> --- /dev/null
> +++ b/drivers/cpufreq/raspberrypi-cpufreq.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Raspberry Pi cpufreq driver
> + *
> + * Copyright (C) 2019, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> + */
> +
> +#include <linux/of.h>
> +#include <linux/clk.h>
> +#include <linux/cpu.h>
> +#include <linux/module.h>
> +#include <linux/pm_opp.h>
> +#include <linux/cpufreq.h>
> +#include <linux/platform_device.h>
> +
> +static const struct of_device_id machines[] __initconst = {
> +	{ .compatible = "raspberrypi,3-model-b-plus" },
> +	{ .compatible = "raspberrypi,3-model-b" },
> +	{ /* sentinel */ }
> +};
> +
> +static int __init raspberrypi_cpufreq_driver_init(void)
> +{
> +	struct platform_device *pdev;
> +	struct cpumask shared_cpus;
> +	struct device *cpu_dev;
> +	struct clk *clk;
> +	long min, max;
> +	long rate;
> +	int ret;
> +
> +	if (!of_match_node(machines, of_root))
> +		return -ENODEV;
> +
> +	cpu_dev = get_cpu_device(0);
> +	if (!cpu_dev) {
> +		pr_err("Cannot get CPU for cpufreq driver\n");
> +		return -ENODEV;
> +	}
> +
> +	clk = clk_get(cpu_dev, 0);
> +	if (IS_ERR(clk)) {
> +		dev_err(cpu_dev, "Cannot get clock for CPU0\n");
> +		return PTR_ERR(clk);
> +	}

You want to do a clk_put() somewhere ?

> +
> +	/*
> +	 * The max and min frequencies are configurable in the Raspberry Pi
> +	 * firmware, so we query them at runtime
> +	 */
> +	min = clk_round_rate(clk, 0);
> +	max = clk_round_rate(clk, ULONG_MAX);
> +
> +	for (rate = min; rate < max; rate += 100000000) {
> +		ret = dev_pm_opp_add(cpu_dev, rate, 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = dev_pm_opp_add(cpu_dev, max, 0);
> +	if (ret)
> +		return ret;

On errors, you should remove all previously added OPPs.

> +
> +	cpumask_setall(&shared_cpus);
> +	dev_pm_opp_set_sharing_cpus(cpu_dev, &shared_cpus);

Why are these required? This must be done by the cpufreq-dt driver anyway ?

> +
> +	pdev = platform_device_register_data(NULL, "cpufreq-dt", -1, NULL, 0);
> +	ret = PTR_ERR_OR_ZERO(pdev);
> +	if (ret)
> +		dev_err(cpu_dev, "Failed to create platform device, %d\n", ret);
> +
> +	return ret;
> +}
> +
> +late_initcall(raspberrypi_cpufreq_driver_init);
> +
> +MODULE_AUTHOR("Nicolas Saenz Julienne <nsaenzjulienne@suse.de");
> +MODULE_DESCRIPTION("Raspberry Pi cpufreq driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.21.0

-- 
viresh
