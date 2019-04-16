Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D02DC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16573205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLZbUuRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbfDPQM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:12:56 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35171 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfDPQMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:12:55 -0400
Received: by mail-lf1-f68.google.com with SMTP id j20so3602938lfh.2;
        Tue, 16 Apr 2019 09:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=08g+wh6zEZL99frzxV0dcZGKHFIrOZbLXpZbcGsnTZA=;
        b=nLZbUuRPrTCvDLg6iyFTUfUVXq4V21SClJ/O7xJetsLA86qQoVj12qCnHigYQSBi1T
         GjknQoo5KdfXiC69rDDi7oBAbVrf0DRHiLW1mJDL6svEGGzKwqTQbUR6OGSlOVQP7DhA
         vo3ucvqHPvRXre6DnZiLGtseaaeZG7PQ+cL5GgUmpyV8aPqONH2/qjlWliivdxDl3VOf
         yt7ApElBmiSFOoAiZ2JWYPWKwlu01AIzFSakUUPPMNOMzdjCCVN4zpD3rfloYu2GcZNt
         Hn/HB7za3LMPZdgZAjpZ8/XoEtySdVJCK12JJL41Pw3KPEDR7XXE2IqDbPrwFwXg6UN6
         Cy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=08g+wh6zEZL99frzxV0dcZGKHFIrOZbLXpZbcGsnTZA=;
        b=GGN3D0FbFX6480R35VFjHkY0J1JdNOCwR8zE/pkeQ6Xt0wNln5N9swdUH1E+R8zYrW
         5IsWbvLI+GSktdw1742pjxc+cSObeIAfWbhJbXyGI4iHFVnENUnpVDgT5wHZ8owZhv2b
         pY14d+d4HgFNU9DsA/EcuufldRNQau4qouF28BT/DaL+sPQPEi08THHMyYOxduFvZC/k
         ysoGEwdftoVRqp2JZNbyhLIRZ+JoAJ7I2U8nGfNypGdzv3IaRRdPQtj8qAEMHxV8TdLr
         g531a/Vds6adUGhGcq1LbxNEkpf8BEq+w5e/dFZ7BKSyspOfPmTY+j0Xl9Y90GcDw5qj
         570g==
X-Gm-Message-State: APjAAAW2t8EnGUtRzCmsJ2RY7ekBWJW81nRFGnJFKQc3+ExqeE7tLZFD
        HLOyYMjGFdROMNiy7z73EqnT9SgR
X-Google-Smtp-Source: APXvYqz2ngdJtW7bBPM2v/jch4kP1y5rRGg/dwU70a/lecdVTkzMSXLfUdgUMhFBjwOZW5drUSso1A==
X-Received: by 2002:ac2:4439:: with SMTP id w25mr2687016lfl.101.1555431171782;
        Tue, 16 Apr 2019 09:12:51 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id r1sm10648399lfm.7.2019.04.16.09.12.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 09:12:50 -0700 (PDT)
Subject: Re: [PATCH v2 19/19] PM / devfreq: Introduce driver for NVIDIA
 Tegra20
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20190415145505.18397-1-digetx@gmail.com>
 <CGME20190415145604epcas3p4cc17d51a92889d6d9e33f7d94bd1ec2e@epcas3p4.samsung.com>
 <20190415145505.18397-20-digetx@gmail.com>
 <e97eb3f7-fdd2-5de1-d3ff-bb5246143002@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <197f47e5-3698-185f-ab1d-3e46d001ddba@gmail.com>
Date:   Tue, 16 Apr 2019 19:11:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e97eb3f7-fdd2-5de1-d3ff-bb5246143002@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.04.2019 11:31, Chanwoo Choi пишет:
> Hi,
> 
> On 19. 4. 15. 오후 11:55, Dmitry Osipenko wrote:
>> Add devfreq driver for NVIDIA Tegra20 SoC's. The driver periodically
>> reads out Memory Controller counters and adjusts memory frequency based
>> on the memory clients activity.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  MAINTAINERS                       |   8 ++
>>  drivers/devfreq/Kconfig           |  10 ++
>>  drivers/devfreq/Makefile          |   1 +
>>  drivers/devfreq/tegra20-devfreq.c | 177 ++++++++++++++++++++++++++++++
>>  4 files changed, 196 insertions(+)
>>  create mode 100644 drivers/devfreq/tegra20-devfreq.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 80b59db1b6e4..91f475ec4545 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -10056,6 +10056,14 @@ F:	include/linux/memblock.h
>>  F:	mm/memblock.c
>>  F:	Documentation/core-api/boot-time-mm.rst
>>  
>> +MEMORY FREQUENCY SCALING DRIVER FOR NVIDIA TEGRA20
>> +M:	Dmitry Osipenko <digetx@gmail.com>
>> +L:	linux-pm@vger.kernel.org
>> +L:	linux-tegra@vger.kernel.org
>> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
>> +S:	Maintained
>> +F:	drivers/devfreq/tegra20-devfreq.c
>> +
>>  MEMORY MANAGEMENT
>>  L:	linux-mm@kvack.org
>>  W:	http://www.linux-mm.org
>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>> index bd6652863e7d..af4c86c4e0f6 100644
>> --- a/drivers/devfreq/Kconfig
>> +++ b/drivers/devfreq/Kconfig
>> @@ -100,6 +100,16 @@ config ARM_TEGRA_DEVFREQ
>>  	  It reads ACTMON counters of memory controllers and adjusts the
>>  	  operating frequencies and voltages with OPP support.
>>  
>> +config ARM_TEGRA20_DEVFREQ
>> +	tristate "NVIDIA Tegra20 DEVFREQ Driver"
>> +	depends on (TEGRA_MC && TEGRA20_EMC) || COMPILE_TEST
>> +	select DEVFREQ_GOV_SIMPLE_ONDEMAND
>> +	select PM_OPP
>> +	help
>> +	  This adds the DEVFREQ driver for the Tegra20 family of SoCs.
>> +	  It reads Memory Controller counters and adjusts the operating
>> +	  frequencies and voltages with OPP support.
>> +
>>  config ARM_RK3399_DMC_DEVFREQ
>>  	tristate "ARM RK3399 DMC DEVFREQ Driver"
>>  	depends on ARCH_ROCKCHIP
>> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
>> index 32b8d4d3f12c..6fcc5596b8b7 100644
>> --- a/drivers/devfreq/Makefile
>> +++ b/drivers/devfreq/Makefile
>> @@ -11,6 +11,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
>>  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
>>  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
>>  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra-devfreq.o
>> +obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+= tegra20-devfreq.o
>>  
>>  # DEVFREQ Event Drivers
>>  obj-$(CONFIG_PM_DEVFREQ_EVENT)		+= event/
>> diff --git a/drivers/devfreq/tegra20-devfreq.c b/drivers/devfreq/tegra20-devfreq.c
>> new file mode 100644
>> index 000000000000..18c9aad7a9d7
>> --- /dev/null
>> +++ b/drivers/devfreq/tegra20-devfreq.c
>> @@ -0,0 +1,177 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * NVIDIA Tegra20 devfreq driver
>> + *
>> + * Author: Dmitry Osipenko <digetx@gmail.com>
>> + */
> 
> It doesn't any "Copyright (c) 2019 ..." sentence.

I'll add one in v3.

>> +
>> +#include <linux/clk.h>
>> +#include <linux/devfreq.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_opp.h>
>> +#include <linux/slab.h>
>> +
>> +#include <soc/tegra/mc.h>
> 
> I can find the '<soc/tegra/mc.h>' header file
> on mainline branch. But mc.h is included in linux-next.git. 
> 
> If you don't share the patch related to mc.h,
> the kernel build will be failed when apply it the devfreq.git
> on final step. Actually, it should make the immutable branch
> between two related maintainers in order to remove the build fail.

The '<soc/tegra/mc.h>' header file exists since v3.18 [0], seems you just missed something.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/soc/tegra/mc.h?h=v3.18&id=8918465163171322c77a19d5258a95f56d89d2e4

>> +
>> +#include "governor.h"
>> +
>> +#define MC_STAT_CONTROL				0x90
>> +#define MC_STAT_EMC_CLOCK_LIMIT			0xa0
>> +#define MC_STAT_EMC_CLOCKS			0xa4
>> +#define MC_STAT_EMC_CONTROL			0xa8
>> +#define MC_STAT_EMC_COUNT			0xb8
>> +
>> +#define EMC_GATHER_CLEAR			(1 << 8)
>> +#define EMC_GATHER_ENABLE			(3 << 8)
>> +
>> +struct tegra_devfreq {
>> +	struct devfreq *devfreq;
>> +	struct clk *clk;
>> +	void __iomem *regs;
>> +};
>> +
>> +static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>> +				u32 flags)
>> +{
>> +	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
>> +	struct dev_pm_opp *opp;
>> +	unsigned long rate;
>> +	int err;
>> +
>> +	opp = devfreq_recommended_opp(dev, freq, flags);
>> +	if (IS_ERR(opp))
>> +		return PTR_ERR(opp);
>> +
>> +	rate = dev_pm_opp_get_freq(opp);
>> +	dev_pm_opp_put(opp);
>> +
>> +	err = clk_set_min_rate(tegra->clk, rate);
>> +	if (err)
>> +		return err;
>> +
>> +	err = clk_set_rate(tegra->clk, 0);
>> +	if (err)
> 
> When fail happen, I think that you have to control
> the restoring sequence for previous operation like clk_set_min_rate().

Okay, thanks.

>> +		return err;
>> +
>> +	return 0;
>> +}
>> +
>> +static int tegra_devfreq_get_dev_status(struct device *dev,
>> +					struct devfreq_dev_status *stat)
>> +{
>> +	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
>> +
>> +	stat->busy_time = readl_relaxed(tegra->regs + MC_STAT_EMC_COUNT);
>> +	stat->total_time = readl_relaxed(tegra->regs + MC_STAT_EMC_CLOCKS) / 8;
>> +	stat->current_frequency = clk_get_rate(tegra->clk);
>> +
>> +	writel_relaxed(EMC_GATHER_CLEAR, tegra->regs + MC_STAT_CONTROL);
>> +	writel_relaxed(EMC_GATHER_ENABLE, tegra->regs + MC_STAT_CONTROL);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct devfreq_dev_profile tegra_devfreq_profile = {
>> +	.polling_ms	= 500,
>> +	.target		= tegra_devfreq_target,
>> +	.get_dev_status	= tegra_devfreq_get_dev_status,
>> +};
>> +
>> +static struct tegra_mc *tegra_get_memory_controller(void)
>> +{
>> +	struct platform_device *pdev;
>> +	struct device_node *np;
>> +	struct tegra_mc *mc;
>> +
>> +	np = of_find_compatible_node(NULL, NULL, "nvidia,tegra20-mc-gart");
>> +	if (!np)
>> +		return ERR_PTR(-ENOENT);
>> +
>> +	pdev = of_find_device_by_node(np);
>> +	of_node_put(np);
>> +	if (!pdev)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	mc = platform_get_drvdata(pdev);
>> +	if (!mc)
>> +		return ERR_PTR(-EPROBE_DEFER);
>> +
>> +	return mc;
>> +}
>> +
>> +static int tegra_devfeq_probe(struct platform_device *pdev)
>> +{
>> +	struct tegra_devfreq *tegra;
>> +	struct tegra_mc *mc;
>> +	unsigned long max_rate;
>> +	unsigned long rate;
>> +	int err;
>> +
>> +	mc = tegra_get_memory_controller();
>> +	if (IS_ERR(mc)) {
>> +		err = PTR_ERR(mc);
>> +		dev_err(&pdev->dev, "failed to get mc: %d\n", err);
> 
> How about using 'memory controller' instead of 'mc'?
> Because 'mc' is not standard expression.

Sounds good, thanks.

>> +		return err;
>> +	}
>> +
>> +	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
>> +	if (!tegra)
>> +		return -ENOMEM;
>> +
>> +	tegra->clk = devm_clk_get(&pdev->dev, "emc");
>> +	if (IS_ERR(tegra->clk)) {
>> +		err = PTR_ERR(tegra->clk);
>> +		dev_err(&pdev->dev, "failed to get emc clock: %d\n", err);
>> +		return err;
>> +	}
> 
> Don't you need to enable the 'emc' clock'?
> Because this patch doesn't enable this clock.

EMC is a system critical clock (marked as critical by the clock driver), it is guaranteed to be always enabled. I think it is fine to omit clock-enabling in this case.

>> +
>> +	tegra->regs = mc->regs;
>> +
>> +	max_rate = clk_round_rate(tegra->clk, ULONG_MAX);
>> +
>> +	for (rate = 0; rate <= max_rate; rate++) {
>> +		rate = clk_round_rate(tegra->clk, rate);
>> +		dev_pm_opp_add(&pdev->dev, rate, 0);
>> +	}
>> +
>> +	writel_relaxed(0x00000000, tegra->regs + MC_STAT_CONTROL);
>> +	writel_relaxed(0x00000000, tegra->regs + MC_STAT_EMC_CONTROL);
>> +	writel_relaxed(0xffffffff, tegra->regs + MC_STAT_EMC_CLOCK_LIMIT);
> 
> You better to add the comments of what are the meaning
> of 0x00000000/0xffffffff. Without the detailed comments,
> it is difficult to understand of meaning.

Okay. Although the complete registers description is available in public and someone really curious could just google for the full details. 

>> +
>> +	platform_set_drvdata(pdev, tegra);
>> +
>> +	tegra->devfreq = devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
>> +					    DEVFREQ_GOV_SIMPLE_ONDEMAND, NULL);
>> +	if (IS_ERR(tegra->devfreq))
>> +		return PTR_ERR(tegra->devfreq);
>> +
>> +	return 0;
>> +}
>> +
>> +static int tegra_devfreq_remove(struct platform_device *pdev)
>> +{
>> +	struct tegra_devfreq *tegra = platform_get_drvdata(pdev);
>> +
>> +	devfreq_remove_device(tegra->devfreq);
>> +	dev_pm_opp_remove_all_dynamic(&pdev->dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver tegra_devfeq_driver = {
>> +	.probe		= tegra_devfeq_probe,
>> +	.remove		= tegra_devfreq_remove,
>> +	.driver		= {
>> +		.name	= "tegra20-devfreq",
> 
> How can you bind this driver without compatible name for Devicetree?
> And I tried to find the name ("tegra20-devfreq") in
> the MFD drivers.

As I wrote in the cover-letter, the device for the driver will be created by the EMC driver. I'll send out the patch that creates the device later on because of EMC driver patch-series interdependence, for now I have that patch here [1] if you're curious how it looks like.

[1] https://github.com/grate-driver/linux/commit/c34440402bb4fb365647bf43166e85562c124273
