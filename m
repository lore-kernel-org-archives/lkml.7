Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A20C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 04:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92FE72133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 04:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sb5GcEqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfDKEDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 00:03:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44673 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfDKEDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 00:03:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id y13so2739603pfm.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 21:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tyPo+eypD7ifmZxReIGAv7rRFZ97A9DyXKzxd+NB8Hg=;
        b=sb5GcEqV5YZbKdVx/ixJiZ6B9a8ZUnEeVBe2LuJ9eGXzlxjDmgGwGZLo0adTtqDD00
         72mqdGMplelsZvrRV7M4Fzg1q0XL3/69jEB3fTxBFum6Ajt+1ojMt9MUuYE/pUjfm9F6
         DNTm2Vyms7ALLMJMLpmbLusQnMSvn851brpx+RUdRpL9wHcPfQrXJ1xFXCJAOqOKYIWw
         OOLAjZoPpdC+UFRAVZV+gpCbzyup+bem+YdfIeEwC5abRkR5QKifc1y5Xrv/DOj+L8kP
         fsmh8x9e6RUMVNxyFMRyt7rWjHi4B6VE6MvIWbrTDdVXPUeCCrqJh3xw+Vlmv3iApZ63
         YGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tyPo+eypD7ifmZxReIGAv7rRFZ97A9DyXKzxd+NB8Hg=;
        b=YeFLJ0AihLklWZ30XH0KjOY0MLlcR0PsNQrbXkAzzw9LsUcvu0cC2gQPmXsMYnMDh6
         Js3Vz06lrPR1plBXksJkZmiWWebpjVRxFO+01Rq9l+EAR9f5Lyb2fiT71hvjxvuQIJA/
         21Lrt+Bd0bIw5tRz1fEBc8GuLzqeO0XjTWmpx7xUlZz+2DshhKo01vlPGksuWAKQ8r8d
         I8WZUTShxtFu68PJswW7JRl6TSnvetEhwrnoeKl5RZFS6WpylMJtkqqgIRZ053zRFxP3
         TQzzM/xLQNSUhNPRuHkxhHNoVV5AV35P+UhsP23P2Ptj663KVQP/LrrhefB4UG8TUhAS
         ojYQ==
X-Gm-Message-State: APjAAAUOfNs9MILSZyQdHfomCCspbK7X87PEWsRiGkcwB8PpJFi0Pd8E
        C7PwuFG7ouCp++Ms3tWapQMV/A==
X-Google-Smtp-Source: APXvYqyc4yDMw6yuUPbdqmBYWAKQVnR3Dz60nzDixHH44v8YUGFkM6FlH3gia/pyCSbeBP7b+LVTCg==
X-Received: by 2002:a65:5189:: with SMTP id h9mr44454317pgq.304.1554955420041;
        Wed, 10 Apr 2019 21:03:40 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id p2sm46353613pfb.80.2019.04.10.21.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 21:03:38 -0700 (PDT)
Date:   Thu, 11 Apr 2019 09:33:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, rjw@rjwysocki.net,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] cpufreq: Add sunxi nvmem based CPU scaling driver
Message-ID: <20190411040335.qckm7zyiqwbanykx@vireshk-i7>
References: <20190410174139.20012-1-tiny.windzz@gmail.com>
 <20190410174139.20012-2-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410174139.20012-2-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-04-19, 13:41, Yangtao Li wrote:
> For some SoCs, the CPU frequency subset and voltage value of each OPP
> varies based on the silicon variant in use. The sunxi-cpufreq-nvmem
> driver reads the efuse value from the SoC to provide the OPP framework
> with required information.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  MAINTAINERS                           |   7 +
>  drivers/cpufreq/Kconfig.arm           |  10 ++
>  drivers/cpufreq/Makefile              |   1 +
>  drivers/cpufreq/cpufreq-dt-platdev.c  |   2 +
>  drivers/cpufreq/sunxi-cpufreq-nvmem.c | 232 ++++++++++++++++++++++++++
>  5 files changed, 252 insertions(+)
>  create mode 100644 drivers/cpufreq/sunxi-cpufreq-nvmem.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 391405091c6b..bfd18ba6aa1a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -667,6 +667,13 @@ S:	Maintained
>  F:	Documentation/i2c/busses/i2c-ali1563
>  F:	drivers/i2c/busses/i2c-ali1563.c
>  
> +ALLWINNER CPUFREQ DRIVER
> +M:	Yangtao Li <tiny.windzz@gmail.com>
> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
> +F:	drivers/cpufreq/sunxi-cpufreq-nvmem.c
> +
>  ALLWINNER SECURITY SYSTEM
>  M:	Corentin Labbe <clabbe.montjoie@gmail.com>
>  L:	linux-crypto@vger.kernel.org
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 179a1d302f48..25933c4321a7 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -18,6 +18,16 @@ config ACPI_CPPC_CPUFREQ
>  
>  	  If in doubt, say N.
>  
> +config ARM_ALLWINNER_CPUFREQ_NVMEM
> +	tristate "Allwinner nvmem based CPUFreq"
> +	depends on ARCH_SUNXI
> +	depends on NVMEM_SUNXI_SID
> +	select PM_OPP
> +	help
> +	  This adds the CPUFreq driver for Allwinner nvmem based SoC.
> +
> +	  If in doubt, say N.
> +
>  config ARM_ARMADA_37XX_CPUFREQ
>  	tristate "Armada 37xx CPUFreq support"
>  	depends on ARCH_MVEBU && CPUFREQ_DT
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 689b26c6f949..da28de67613c 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -78,6 +78,7 @@ obj-$(CONFIG_ARM_SCMI_CPUFREQ)		+= scmi-cpufreq.o
>  obj-$(CONFIG_ARM_SCPI_CPUFREQ)		+= scpi-cpufreq.o
>  obj-$(CONFIG_ARM_SPEAR_CPUFREQ)		+= spear-cpufreq.o
>  obj-$(CONFIG_ARM_STI_CPUFREQ)		+= sti-cpufreq.o
> +obj-$(CONFIG_ARM_ALLWINNER_CPUFREQ_NVMEM) += sunxi-cpufreq-nvmem.o
>  obj-$(CONFIG_ARM_TANGO_CPUFREQ)		+= tango-cpufreq.o
>  obj-$(CONFIG_ARM_TEGRA20_CPUFREQ)	+= tegra20-cpufreq.o
>  obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 47729a22c159..50e7810f3a28 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -105,6 +105,8 @@ static const struct of_device_id whitelist[] __initconst = {
>   * platforms using "operating-points-v2" property.
>   */
>  static const struct of_device_id blacklist[] __initconst = {
> +	{ .compatible = "allwinner,sun50i-h6", },
> +
>  	{ .compatible = "calxeda,highbank", },
>  	{ .compatible = "calxeda,ecx-2000", },
>  
> diff --git a/drivers/cpufreq/sunxi-cpufreq-nvmem.c b/drivers/cpufreq/sunxi-cpufreq-nvmem.c
> new file mode 100644
> index 000000000000..6bf4755d00d9
> --- /dev/null
> +++ b/drivers/cpufreq/sunxi-cpufreq-nvmem.c
> @@ -0,0 +1,232 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Allwinner CPUFreq nvmem based driver
> + *
> + * The sunxi-cpufreq-nvmem driver reads the efuse value from the SoC to
> + * provide the OPP framework with required information.
> + *
> + * Copyright (C) 2019 Yangtao Li <tiny.windzz@gmail.com>
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
> +#include <linux/slab.h>
> +
> +#define MAX_NAME_LEN      7
> +
> +struct sunxi_cpufreq_soc_data {
> +	u32 (*efuse_xlate)(const struct sunxi_cpufreq_soc_data *soc_data,
> +			   u32 efuse);
> +	u32 nvmem_mask;
> +	u32 nvmem_shift;
> +};
> +
> +static struct platform_device *cpufreq_dt_pdev, *sunxi_cpufreq_pdev;
> +
> +static u32 sun50i_efuse_xlate(const struct sunxi_cpufreq_soc_data *soc_data,
> +			      u32 efuse)
> +{
> +	return (efuse >> soc_data->nvmem_shift) & soc_data->nvmem_mask;
> +}
> +
> +/**
> + * sunxi_cpufreq_get_efuse() - Parse and return efuse value present on SoC
> + * @soc_data: Pointer to sunxi_cpufreq_soc_data context
> + * @versions: Set to the value parsed from efuse
> + *
> + * Returns 0 if success.
> + */
> +static int sunxi_cpufreq_get_efuse(const struct sunxi_cpufreq_soc_data *soc_data,
> +				   u32 *versions)
> +{
> +	struct nvmem_cell *speedbin_nvmem;
> +	struct device_node *np;
> +	struct device *cpu_dev;
> +	u32 *speedbin;
> +	size_t len;
> +	int ret;
> +
> +	cpu_dev = get_cpu_device(0);
> +	if (!cpu_dev)
> +		return -ENODEV;
> +
> +	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
> +	if (!np)
> +		return -ENOENT;
> +
> +	ret = of_device_is_compatible(np, "allwinner,cpu-operating-points-v2");
> +	if (!ret) {
> +		of_node_put(np);
> +		return -ENOENT;
> +	}
> +
> +	speedbin_nvmem = of_nvmem_cell_get(np, NULL);
> +	of_node_put(np);
> +	if (IS_ERR(speedbin_nvmem)) {
> +		if (PTR_ERR(speedbin_nvmem) != -EPROBE_DEFER)
> +			pr_err("Could not get nvmem cell: %ld\n",
> +			PTR_ERR(speedbin_nvmem));
> +		return PTR_ERR(speedbin_nvmem);
> +	}
> +
> +	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
> +	nvmem_cell_put(speedbin_nvmem);
> +	if (IS_ERR(speedbin))
> +		return PTR_ERR(speedbin);
> +
> +	*versions = soc_data->efuse_xlate(soc_data, *speedbin);
> +
> +	kfree(speedbin);
> +	return 0;
> +};
> +
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

As I said in the previous version, this should have been moved to somewhere
below. i.e. right above the routine that needs it.

> +static int sunxi_cpufreq_nvmem_probe(struct platform_device *pdev)
> +{
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
> +	match = dev_get_platdata(&pdev->dev);

Also, you should have just passed match->data instead of match here.

> +	if (!match)
> +		return -EINVAL;
> +
> +	ret = sunxi_cpufreq_get_efuse(match->data, &speed);
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
> +	sunxi_cpufreq_pdev = platform_device_register_data(NULL,
> +		"sunxi-cpufreq-nvmem", -1, match, sizeof(*match));
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
