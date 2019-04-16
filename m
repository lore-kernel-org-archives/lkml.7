Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D52C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDE02086A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Y9r/cPeO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbfDPIbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:31:14 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:48448 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbfDPIbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:31:12 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190416083108epoutp02cc947c9e0773027c8269e3f835482250~V5zbFL9DM1619816198epoutp02V
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 08:31:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190416083108epoutp02cc947c9e0773027c8269e3f835482250~V5zbFL9DM1619816198epoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555403468;
        bh=7PjKTFY16hm+2dqk1vKkSS7LSdcSj0d7mCNTcvTKbNc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Y9r/cPeOWvj6dYRBoaWUscJqxD9AZIrzJGVTOxPgPKT8HhY3Us8gAtvPY0XzPWsBP
         TswToQF1PxSDzOGRO7BkHPPdgDtv3UmhXjDeKKlb8UHJutVUwZZpUceqB/GI+85Id4
         /e2p+OASpnbbG+q/B59Fu7BqmnsTbz6NN38bvNgw=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190416083105epcas1p23715f7261d2e4311260c5ec609b5ff01~V5zYD0E-U0537005370epcas1p2b;
        Tue, 16 Apr 2019 08:31:05 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        65.66.04257.7C295BC5; Tue, 16 Apr 2019 17:31:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190416083103epcas1p3ef7abf2379a7031e90e11c4b6654245b~V5zWCbEq90503405034epcas1p3D;
        Tue, 16 Apr 2019 08:31:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190416083103epsmtrp14e988e7ad3f4da26a345bcb37053f97b~V5zWBdt3-0830008300epsmtrp17;
        Tue, 16 Apr 2019 08:31:03 +0000 (GMT)
X-AuditID: b6c32a38-5e3ff700000010a1-41-5cb592c7e4d8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.65.03692.7C295BC5; Tue, 16 Apr 2019 17:31:03 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190416083103epsmtip1fc27a1f94b534e0f0ebe404e035bc398~V5zVwbZa-0994609946epsmtip1M;
        Tue, 16 Apr 2019 08:31:03 +0000 (GMT)
Subject: Re: [PATCH v2 19/19] PM / devfreq: Introduce driver for NVIDIA
 Tegra20
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <e97eb3f7-fdd2-5de1-d3ff-bb5246143002@samsung.com>
Date:   Tue, 16 Apr 2019 17:31:57 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415145505.18397-20-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLJsWRmVeSWpSXmKPExsWy7bCmnu7JSVtjDHb/kbZY/fExo0XLrEUs
        Fmeb3rBbXN41h83ic+8RRovOL7PYLG43rmCz+LlrHotF39pLbA6cHjvuLmH02DnrLrtHb/M7
        No++LasYPT5vkgtgjcq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVV
        cvEJ0HXLzAE6SEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFmgV5yYW1yal66X
        nJ9rZWhgYGQKVJiQnfHuyT2mgjOuFZ0XuxkbGE9ZdDFyckgImEjM73nGCmILCexglPjy0aCL
        kQvI/sQoMbn1BAtE4hujRONi1y5GDrCGV7cDIWr2MkpcfTqJCcJ5zyjRNvMFWIOwQKDE4X8T
        WUASIgL/GCU+7ZoBtoJZIFLi68GlzCA2m4CWxP4XN9hAbH4BRYmrPx4zgti8AnYSLds/gdWz
        CKhKzHi1A6xGVCBC4v6xDawQNYISJ2c+YQG5iFPAXGLVKiOI8eISt57MZ4Kw5SWat85mBrlB
        QuA/m8Tsp7NZIF52kVg96TI7hC0s8er4FihbSuJlfxuUXS2x8uQRNojmDkaJLfsvsEIkjCX2
        L53MBLKYWUBTYv0ufYhlfBLvvvawQkKIV6KjTQiiWlni8oO7TBC2pMTi9k42CNtD4mLXJcYJ
        jIqzkHwzC8kLs5C8MAth2QJGllWMYqkFxbnpqcWGBSbIcb2JEZxUtSx2MO4553OIUYCDUYmH
        N6FvS4wQa2JZcWXuIUYJDmYlEV7HFKAQb0piZVVqUX58UWlOavEhRlNgYE9klhJNzgcm/LyS
        eENTI2NjYwsTQzNTQ0Mlcd71Ds4xQgLpiSWp2ampBalFMH1MHJxSDYzBM0v67VdWsc1dX3CN
        Z6LAqVPPv7OlLe4qXa/xuP7hC3c5078VuWLFawr7yiPaC7avCLtndELkWIrN5/k8e7gLfHwE
        dPIEY/lkzmznrVo+S2pp9I2GM0szFOwN8qXWvNtqax8qU/vx9KRjHyqso1iC+uekTbRgsjBh
        f2kVGjI9at78zT+iLZRYijMSDbWYi4oTAX405S3AAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSnO7xSVtjDI7u4LVY/fExo0XLrEUs
        Fmeb3rBbXN41h83ic+8RRovOL7PYLG43rmCz+LlrHotF39pLbA6cHjvuLmH02DnrLrtHb/M7
        No++LasYPT5vkgtgjeKySUnNySxLLdK3S+DKePfkHlPBGdeKzovdjA2Mpyy6GDk4JARMJF7d
        Duxi5OIQEtjNKHHh9lKmLkZOoLikxLSLR5khaoQlDh8uBgkLCbxllNh13QDEFhYIlDj8byIL
        SK+IQBOTxOeHLWC9zAKREv2Pulkhhm5jlOhedIcZJMEmoCWx/8UNNhCbX0BR4uqPx4wgNq+A
        nUTL9k+sIDaLgKrEjFc7wGpEBSIkzrxfwQJRIyhxcuYTFpCDOAXMJVatMoLYpS7xZ94lZghb
        XOLWk/lQN8hLNG+dzTyBUXgWku5ZSFpmIWmZhaRlASPLKkbJ1ILi3PTcYsMCw7zUcr3ixNzi
        0rx0veT83E2M4PjS0tzBeHlJ/CFGAQ5GJR7ehL4tMUKsiWXFlbmHGCU4mJVEeB1TgEK8KYmV
        ValF+fFFpTmpxYcYpTlYlMR5n+YdixQSSE8sSc1OTS1ILYLJMnFwSjUwrvX2eD7lyH2nJA4D
        34kbMrL7z91jK6/n+RinaX761n2Onx/1k03ezMpK26sr5PFMI1z47ZWNDf9+L4zam1y3Njl0
        63zxzMalu9Ne7bJ1L/ZcXVv1Pq+p8T8XW9eJmnwlkw+KLN8LbZmM8wTNDNdE/erV2iirYFj/
        +pZ1z5qFbN/+7J6ne1VAiaU4I9FQi7moOBEAyNHPOqsCAAA=
X-CMS-MailID: 20190416083103epcas1p3ef7abf2379a7031e90e11c4b6654245b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190415145604epcas3p4cc17d51a92889d6d9e33f7d94bd1ec2e
References: <20190415145505.18397-1-digetx@gmail.com>
        <CGME20190415145604epcas3p4cc17d51a92889d6d9e33f7d94bd1ec2e@epcas3p4.samsung.com>
        <20190415145505.18397-20-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 4. 15. 오후 11:55, Dmitry Osipenko wrote:
> Add devfreq driver for NVIDIA Tegra20 SoC's. The driver periodically
> reads out Memory Controller counters and adjusts memory frequency based
> on the memory clients activity.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  MAINTAINERS                       |   8 ++
>  drivers/devfreq/Kconfig           |  10 ++
>  drivers/devfreq/Makefile          |   1 +
>  drivers/devfreq/tegra20-devfreq.c | 177 ++++++++++++++++++++++++++++++
>  4 files changed, 196 insertions(+)
>  create mode 100644 drivers/devfreq/tegra20-devfreq.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 80b59db1b6e4..91f475ec4545 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10056,6 +10056,14 @@ F:	include/linux/memblock.h
>  F:	mm/memblock.c
>  F:	Documentation/core-api/boot-time-mm.rst
>  
> +MEMORY FREQUENCY SCALING DRIVER FOR NVIDIA TEGRA20
> +M:	Dmitry Osipenko <digetx@gmail.com>
> +L:	linux-pm@vger.kernel.org
> +L:	linux-tegra@vger.kernel.org
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
> +S:	Maintained
> +F:	drivers/devfreq/tegra20-devfreq.c
> +
>  MEMORY MANAGEMENT
>  L:	linux-mm@kvack.org
>  W:	http://www.linux-mm.org
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index bd6652863e7d..af4c86c4e0f6 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -100,6 +100,16 @@ config ARM_TEGRA_DEVFREQ
>  	  It reads ACTMON counters of memory controllers and adjusts the
>  	  operating frequencies and voltages with OPP support.
>  
> +config ARM_TEGRA20_DEVFREQ
> +	tristate "NVIDIA Tegra20 DEVFREQ Driver"
> +	depends on (TEGRA_MC && TEGRA20_EMC) || COMPILE_TEST
> +	select DEVFREQ_GOV_SIMPLE_ONDEMAND
> +	select PM_OPP
> +	help
> +	  This adds the DEVFREQ driver for the Tegra20 family of SoCs.
> +	  It reads Memory Controller counters and adjusts the operating
> +	  frequencies and voltages with OPP support.
> +
>  config ARM_RK3399_DMC_DEVFREQ
>  	tristate "ARM RK3399 DMC DEVFREQ Driver"
>  	depends on ARCH_ROCKCHIP
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> index 32b8d4d3f12c..6fcc5596b8b7 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
>  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
>  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
>  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra-devfreq.o
> +obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+= tegra20-devfreq.o
>  
>  # DEVFREQ Event Drivers
>  obj-$(CONFIG_PM_DEVFREQ_EVENT)		+= event/
> diff --git a/drivers/devfreq/tegra20-devfreq.c b/drivers/devfreq/tegra20-devfreq.c
> new file mode 100644
> index 000000000000..18c9aad7a9d7
> --- /dev/null
> +++ b/drivers/devfreq/tegra20-devfreq.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * NVIDIA Tegra20 devfreq driver
> + *
> + * Author: Dmitry Osipenko <digetx@gmail.com>
> + */

It doesn't any "Copyright (c) 2019 ..." sentence.

> +
> +#include <linux/clk.h>
> +#include <linux/devfreq.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
> +#include <linux/slab.h>
> +
> +#include <soc/tegra/mc.h>

I can find the '<soc/tegra/mc.h>' header file
on mainline branch. But mc.h is included in linux-next.git. 

If you don't share the patch related to mc.h,
the kernel build will be failed when apply it the devfreq.git
on final step. Actually, it should make the immutable branch
between two related maintainers in order to remove the build fail.

> +
> +#include "governor.h"
> +
> +#define MC_STAT_CONTROL				0x90
> +#define MC_STAT_EMC_CLOCK_LIMIT			0xa0
> +#define MC_STAT_EMC_CLOCKS			0xa4
> +#define MC_STAT_EMC_CONTROL			0xa8
> +#define MC_STAT_EMC_COUNT			0xb8
> +
> +#define EMC_GATHER_CLEAR			(1 << 8)
> +#define EMC_GATHER_ENABLE			(3 << 8)
> +
> +struct tegra_devfreq {
> +	struct devfreq *devfreq;
> +	struct clk *clk;
> +	void __iomem *regs;
> +};
> +
> +static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
> +				u32 flags)
> +{
> +	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
> +	struct dev_pm_opp *opp;
> +	unsigned long rate;
> +	int err;
> +
> +	opp = devfreq_recommended_opp(dev, freq, flags);
> +	if (IS_ERR(opp))
> +		return PTR_ERR(opp);
> +
> +	rate = dev_pm_opp_get_freq(opp);
> +	dev_pm_opp_put(opp);
> +
> +	err = clk_set_min_rate(tegra->clk, rate);
> +	if (err)
> +		return err;
> +
> +	err = clk_set_rate(tegra->clk, 0);
> +	if (err)

When fail happen, I think that you have to control
the restoring sequence for previous operation like clk_set_min_rate().

> +		return err;
> +
> +	return 0;
> +}
> +
> +static int tegra_devfreq_get_dev_status(struct device *dev,
> +					struct devfreq_dev_status *stat)
> +{
> +	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
> +
> +	stat->busy_time = readl_relaxed(tegra->regs + MC_STAT_EMC_COUNT);
> +	stat->total_time = readl_relaxed(tegra->regs + MC_STAT_EMC_CLOCKS) / 8;
> +	stat->current_frequency = clk_get_rate(tegra->clk);
> +
> +	writel_relaxed(EMC_GATHER_CLEAR, tegra->regs + MC_STAT_CONTROL);
> +	writel_relaxed(EMC_GATHER_ENABLE, tegra->regs + MC_STAT_CONTROL);
> +
> +	return 0;
> +}
> +
> +static struct devfreq_dev_profile tegra_devfreq_profile = {
> +	.polling_ms	= 500,
> +	.target		= tegra_devfreq_target,
> +	.get_dev_status	= tegra_devfreq_get_dev_status,
> +};
> +
> +static struct tegra_mc *tegra_get_memory_controller(void)
> +{
> +	struct platform_device *pdev;
> +	struct device_node *np;
> +	struct tegra_mc *mc;
> +
> +	np = of_find_compatible_node(NULL, NULL, "nvidia,tegra20-mc-gart");
> +	if (!np)
> +		return ERR_PTR(-ENOENT);
> +
> +	pdev = of_find_device_by_node(np);
> +	of_node_put(np);
> +	if (!pdev)
> +		return ERR_PTR(-ENODEV);
> +
> +	mc = platform_get_drvdata(pdev);
> +	if (!mc)
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	return mc;
> +}
> +
> +static int tegra_devfeq_probe(struct platform_device *pdev)
> +{
> +	struct tegra_devfreq *tegra;
> +	struct tegra_mc *mc;
> +	unsigned long max_rate;
> +	unsigned long rate;
> +	int err;
> +
> +	mc = tegra_get_memory_controller();
> +	if (IS_ERR(mc)) {
> +		err = PTR_ERR(mc);
> +		dev_err(&pdev->dev, "failed to get mc: %d\n", err);

How about using 'memory controller' instead of 'mc'?
Because 'mc' is not standard expression.

> +		return err;
> +	}
> +
> +	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
> +	if (!tegra)
> +		return -ENOMEM;
> +
> +	tegra->clk = devm_clk_get(&pdev->dev, "emc");
> +	if (IS_ERR(tegra->clk)) {
> +		err = PTR_ERR(tegra->clk);
> +		dev_err(&pdev->dev, "failed to get emc clock: %d\n", err);
> +		return err;
> +	}

Don't you need to enable the 'emc' clock'?
Because this patch doesn't enable this clock.

> +
> +	tegra->regs = mc->regs;
> +
> +	max_rate = clk_round_rate(tegra->clk, ULONG_MAX);
> +
> +	for (rate = 0; rate <= max_rate; rate++) {
> +		rate = clk_round_rate(tegra->clk, rate);
> +		dev_pm_opp_add(&pdev->dev, rate, 0);
> +	}
> +
> +	writel_relaxed(0x00000000, tegra->regs + MC_STAT_CONTROL);
> +	writel_relaxed(0x00000000, tegra->regs + MC_STAT_EMC_CONTROL);
> +	writel_relaxed(0xffffffff, tegra->regs + MC_STAT_EMC_CLOCK_LIMIT);

You better to add the comments of what are the meaning
of 0x00000000/0xffffffff. Without the detailed comments,
it is difficult to understand of meaning.

> +
> +	platform_set_drvdata(pdev, tegra);
> +
> +	tegra->devfreq = devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
> +					    DEVFREQ_GOV_SIMPLE_ONDEMAND, NULL);
> +	if (IS_ERR(tegra->devfreq))
> +		return PTR_ERR(tegra->devfreq);
> +
> +	return 0;
> +}
> +
> +static int tegra_devfreq_remove(struct platform_device *pdev)
> +{
> +	struct tegra_devfreq *tegra = platform_get_drvdata(pdev);
> +
> +	devfreq_remove_device(tegra->devfreq);
> +	dev_pm_opp_remove_all_dynamic(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver tegra_devfeq_driver = {
> +	.probe		= tegra_devfeq_probe,
> +	.remove		= tegra_devfreq_remove,
> +	.driver		= {
> +		.name	= "tegra20-devfreq",

How can you bind this driver without compatible name for Devicetree?
And I tried to find the name ("tegra20-devfreq") in
the MFD drivers.

> +	},
> +};
> +module_platform_driver(tegra_devfeq_driver);
> +
> +MODULE_ALIAS("platform:tegra20-devfreq");
> +MODULE_AUTHOR("Dmitry Osipenko <digetx@gmail.com>");
> +MODULE_DESCRIPTION("NVIDIA Tegra20 devfreq driver");
> +MODULE_LICENSE("GPL v2");
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
