Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CB3C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44192073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Zjne1NAd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731025AbfDQA0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 20:26:08 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:12436 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbfDQA0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 20:26:07 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190417002604epoutp03dc1244ffb86774919be38e6832ad8b05~WG1LlWcvS1411514115epoutp03H
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 00:26:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190417002604epoutp03dc1244ffb86774919be38e6832ad8b05~WG1LlWcvS1411514115epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555460764;
        bh=XO5VWJmkvP1vsu9EoRY1pEQACHsZ5JgKXI4p2JA84VA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Zjne1NAdAOWl27Hz8iJ9FnwTvDed4hj8d63N8BRqPFohe+phI1IRnwMZQ7BOt1ck6
         TJzMhUWMeR+W4oQjJWHvdzpC3V57POMUZY8MKCSd5+Sv1Qkwuf0PWN/p6iO0JHgtg2
         GKeSN4ABk2Qbu6MjIC5a8b3me7C69D++Bw92klMI=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.155]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190417002559epcas1p1e3dd28d3aa454edfbe81008fb040d5bc~WG1G6mo-D1949019490epcas1p1i;
        Wed, 17 Apr 2019 00:25:59 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.4A.04143.49276BC5; Wed, 17 Apr 2019 09:25:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190417002555epcas1p2533244bcd3b38b801878dd8cc6049b82~WG1D3dSLC0571705717epcas1p2X;
        Wed, 17 Apr 2019 00:25:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190417002555epsmtrp199d230f0ed50dba6bc68821bcce6e363~WG1D2vHTw1180511805epsmtrp1g;
        Wed, 17 Apr 2019 00:25:55 +0000 (GMT)
X-AuditID: b6c32a37-f19ff7000000102f-88-5cb67294193a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.19.03692.39276BC5; Wed, 17 Apr 2019 09:25:55 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190417002555epsmtip290f66852b9d425a1e37ee058d1509cd9~WG1DtVVzO2248722487epsmtip2M;
        Wed, 17 Apr 2019 00:25:55 +0000 (GMT)
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
Message-ID: <64324c9c-b5db-86ac-f97e-6c76049dcdc8@samsung.com>
Date:   Wed, 17 Apr 2019 09:26:52 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <197f47e5-3698-185f-ab1d-3e46d001ddba@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+e3eXa/V6ue0PBmZ3opIsO221m7RoofVqCAjiB6rdXEXNffi
        3im96J2lPcyKHkvKXmSLSERNR7VawwhKShEikQLtiSlqRlZYu95F/vc5v/M9v3O+v9+hCe0d
        KonOdXkF0cU7GGoEWftkui79jFhr1VdVTeVu97Qj7qDvKsm92N8ZwzUHyiiu73gYcUXffBTX
        uq+C4gYCl0juxJ0makGspa7tOrLU+9piLMcPdFGWE9V+ZOmrSs5Ub8iblyPwdkFMEVxZbnuu
        K9vMrFhjW2wzztaz6ewczsSkuHinYGYyVmamL811RAZiUgp4R37kKJOXJEY3f57ozvcKKTlu
        yWtmBI/d4ZnjmSHxTinflT0jy+2cy+r1M40R4Za8nKaKQcLze822c/UlMXtRe0YxiqUBz4J9
        9/2qYjSC1uI6BIfqC6NBL4Ky7lakBN8RdP4KxfwrKQncpJTEAwTPHzZES7oR9PSE1LIqHq+G
        J4OlpJxIwIMIegPnhxIEXg/9j28QMlM4DYKfXlMyj8Gp0PKjPdKPpjV4Ptws3i0jiadCuHWR
        rBiL18HbhsqhWzQ4Dp5d6CBlSSw2Q0vjJuXyRHjTcVml8CQ4UHORUGb+Q0EoPEXhDHj3/pFa
        4Xj48rQ66isJPpcURnkn3HoWHvII+AiC6uDLaIEBgjdOq+S+BJ4OdwM6pddo6Oo/ppaPAWvg
        SKFWUU+G5ndtKoXHw7XDRZTCFnhV3IROolTfMDO+YQ58wxz4/jcrR6QfjRM8kjNbkFiPYfhf
        V6GhVU0z1aHKxpUhhGnEjNJUDNRYtWq+QNruDCGgCSZBs9BebdVq7Pz2HYLoton5DkEKIWPk
        qUuJpLFZ7sjiu7w21jjTYDBws9jZRpZlEjV3Fyy2anE27xXyBMEjiP/qVHRs0l60zbyp7N4H
        8exmEzNhydYxDQ2l8T9Nzsrl3POXHtHfb0wO9S09Zl7/kfw6qsj2dvP4S0HD/sa1aJexvKRl
        95U9Zx0hfydsDCaIneaRvZ/1y15fnHZu4pajD2zegUm6Ujprbrc1rqC237fk1FbuvdS1StUh
        1Ew2eXUfE79NaW5ODjOklMOzaYQo8X8BeJvkK8ADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSvO7kom0xBn9XGVqs/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZ/Nw1j8Wib+0lNgdOjx13lzB67Jx1l92jt/kd
        m0ffllWMHp83yQWwRnHZpKTmZJalFunbJXBlXFrxj7ngT3DF9J397A2Mj126GDk5JARMJPp3
        LWfrYuTiEBLYzShx63kzC0RCUmLaxaPMXYwcQLawxOHDxRA1bxklGn7vZQSpERYIlDj8byIL
        SEJEoIlJ4vPDFiaQBLNApET/o25WiI55TBKTm/+xgyTYBLQk9r+4wQZi8wsoSlz98ZgRZAOv
        gJ3E8q46EJNFQFXiyG0nkApRgQiJM+9XgN3DKyAocXLmExaQEk4BW4mr52IhNqlL/Jl3iRnC
        Fpe49WQ+1AXyEs1bZzNPYBSehaR7FpKWWUhaZiFpWcDIsopRMrWgODc9t9iwwDAvtVyvODG3
        uDQvXS85P3cTIzi+tDR3MF5eEn+IUYCDUYmHd8XPrTFCrIllxZW5hxglOJiVRHgdU7bECPGm
        JFZWpRblxxeV5qQWH2KU5mBREud9mncsUkggPbEkNTs1tSC1CCbLxMEp1cAYl6ATKP9k/kvZ
        PXMU06Ndfko/uvPOOrU+LzPuwMTY+skFa2y/rpt72+LJt5tVV556Scszidj3RyTfCnL0YewL
        PtSUPDXSYG5mp+PktfbvT52KKfPoKf2v1mmy5vxEXXONtIsqjt4GmoJsXyqX6MoX+eU9s7sc
        tcHNSNj+f/5PNhvhxQwVC5VYijMSDbWYi4oTAVMBgKKrAgAA
X-CMS-MailID: 20190417002555epcas1p2533244bcd3b38b801878dd8cc6049b82
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190415145604epcas3p4cc17d51a92889d6d9e33f7d94bd1ec2e
References: <20190415145505.18397-1-digetx@gmail.com>
        <CGME20190415145604epcas3p4cc17d51a92889d6d9e33f7d94bd1ec2e@epcas3p4.samsung.com>
        <20190415145505.18397-20-digetx@gmail.com>
        <e97eb3f7-fdd2-5de1-d3ff-bb5246143002@samsung.com>
        <197f47e5-3698-185f-ab1d-3e46d001ddba@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 4. 17. 오전 1:11, Dmitry Osipenko wrote:
> 16.04.2019 11:31, Chanwoo Choi пишет:
>> Hi,
>>
>> On 19. 4. 15. 오후 11:55, Dmitry Osipenko wrote:
>>> Add devfreq driver for NVIDIA Tegra20 SoC's. The driver periodically
>>> reads out Memory Controller counters and adjusts memory frequency based
>>> on the memory clients activity.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  MAINTAINERS                       |   8 ++
>>>  drivers/devfreq/Kconfig           |  10 ++
>>>  drivers/devfreq/Makefile          |   1 +
>>>  drivers/devfreq/tegra20-devfreq.c | 177 ++++++++++++++++++++++++++++++
>>>  4 files changed, 196 insertions(+)
>>>  create mode 100644 drivers/devfreq/tegra20-devfreq.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 80b59db1b6e4..91f475ec4545 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -10056,6 +10056,14 @@ F:	include/linux/memblock.h
>>>  F:	mm/memblock.c
>>>  F:	Documentation/core-api/boot-time-mm.rst
>>>  
>>> +MEMORY FREQUENCY SCALING DRIVER FOR NVIDIA TEGRA20
>>> +M:	Dmitry Osipenko <digetx@gmail.com>
>>> +L:	linux-pm@vger.kernel.org
>>> +L:	linux-tegra@vger.kernel.org
>>> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
>>> +S:	Maintained
>>> +F:	drivers/devfreq/tegra20-devfreq.c
>>> +
>>>  MEMORY MANAGEMENT
>>>  L:	linux-mm@kvack.org
>>>  W:	http://www.linux-mm.org
>>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>>> index bd6652863e7d..af4c86c4e0f6 100644
>>> --- a/drivers/devfreq/Kconfig
>>> +++ b/drivers/devfreq/Kconfig
>>> @@ -100,6 +100,16 @@ config ARM_TEGRA_DEVFREQ
>>>  	  It reads ACTMON counters of memory controllers and adjusts the
>>>  	  operating frequencies and voltages with OPP support.
>>>  
>>> +config ARM_TEGRA20_DEVFREQ
>>> +	tristate "NVIDIA Tegra20 DEVFREQ Driver"
>>> +	depends on (TEGRA_MC && TEGRA20_EMC) || COMPILE_TEST
>>> +	select DEVFREQ_GOV_SIMPLE_ONDEMAND
>>> +	select PM_OPP
>>> +	help
>>> +	  This adds the DEVFREQ driver for the Tegra20 family of SoCs.
>>> +	  It reads Memory Controller counters and adjusts the operating
>>> +	  frequencies and voltages with OPP support.
>>> +
>>>  config ARM_RK3399_DMC_DEVFREQ
>>>  	tristate "ARM RK3399 DMC DEVFREQ Driver"
>>>  	depends on ARCH_ROCKCHIP
>>> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
>>> index 32b8d4d3f12c..6fcc5596b8b7 100644
>>> --- a/drivers/devfreq/Makefile
>>> +++ b/drivers/devfreq/Makefile
>>> @@ -11,6 +11,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
>>>  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
>>>  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
>>>  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra-devfreq.o
>>> +obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+= tegra20-devfreq.o
>>>  
>>>  # DEVFREQ Event Drivers
>>>  obj-$(CONFIG_PM_DEVFREQ_EVENT)		+= event/
>>> diff --git a/drivers/devfreq/tegra20-devfreq.c b/drivers/devfreq/tegra20-devfreq.c
>>> new file mode 100644
>>> index 000000000000..18c9aad7a9d7
>>> --- /dev/null
>>> +++ b/drivers/devfreq/tegra20-devfreq.c
>>> @@ -0,0 +1,177 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * NVIDIA Tegra20 devfreq driver
>>> + *
>>> + * Author: Dmitry Osipenko <digetx@gmail.com>
>>> + */
>>
>> It doesn't any "Copyright (c) 2019 ..." sentence.
> 
> I'll add one in v3.
> 
>>> +
>>> +#include <linux/clk.h>
>>> +#include <linux/devfreq.h>
>>> +#include <linux/io.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/pm_opp.h>
>>> +#include <linux/slab.h>
>>> +
>>> +#include <soc/tegra/mc.h>
>>
>> I can find the '<soc/tegra/mc.h>' header file
>> on mainline branch. But mc.h is included in linux-next.git. 
>>
>> If you don't share the patch related to mc.h,
>> the kernel build will be failed when apply it the devfreq.git
>> on final step. Actually, it should make the immutable branch
>> between two related maintainers in order to remove the build fail.
> 
> The '<soc/tegra/mc.h>' header file exists since v3.18 [0], seems you just missed something.
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/soc/tegra/mc.h?h=v3.18&id=8918465163171322c77a19d5258a95f56d89d2e4

Sorry. It is my missing point. When I tried to find it,
it is included in the mainline kernel.

> 
>>> +
>>> +#include "governor.h"
>>> +
>>> +#define MC_STAT_CONTROL				0x90
>>> +#define MC_STAT_EMC_CLOCK_LIMIT			0xa0
>>> +#define MC_STAT_EMC_CLOCKS			0xa4
>>> +#define MC_STAT_EMC_CONTROL			0xa8
>>> +#define MC_STAT_EMC_COUNT			0xb8
>>> +
>>> +#define EMC_GATHER_CLEAR			(1 << 8)
>>> +#define EMC_GATHER_ENABLE			(3 << 8)
>>> +
>>> +struct tegra_devfreq {
>>> +	struct devfreq *devfreq;
>>> +	struct clk *clk;
>>> +	void __iomem *regs;
>>> +};
>>> +
>>> +static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>>> +				u32 flags)
>>> +{
>>> +	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
>>> +	struct dev_pm_opp *opp;
>>> +	unsigned long rate;
>>> +	int err;
>>> +
>>> +	opp = devfreq_recommended_opp(dev, freq, flags);
>>> +	if (IS_ERR(opp))
>>> +		return PTR_ERR(opp);
>>> +
>>> +	rate = dev_pm_opp_get_freq(opp);
>>> +	dev_pm_opp_put(opp);
>>> +
>>> +	err = clk_set_min_rate(tegra->clk, rate);
>>> +	if (err)
>>> +		return err;
>>> +
>>> +	err = clk_set_rate(tegra->clk, 0);
>>> +	if (err)
>>
>> When fail happen, I think that you have to control
>> the restoring sequence for previous operation like clk_set_min_rate().
> 
> Okay, thanks.
> 
>>> +		return err;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int tegra_devfreq_get_dev_status(struct device *dev,
>>> +					struct devfreq_dev_status *stat)
>>> +{
>>> +	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
>>> +
>>> +	stat->busy_time = readl_relaxed(tegra->regs + MC_STAT_EMC_COUNT);
>>> +	stat->total_time = readl_relaxed(tegra->regs + MC_STAT_EMC_CLOCKS) / 8;
>>> +	stat->current_frequency = clk_get_rate(tegra->clk);
>>> +
>>> +	writel_relaxed(EMC_GATHER_CLEAR, tegra->regs + MC_STAT_CONTROL);
>>> +	writel_relaxed(EMC_GATHER_ENABLE, tegra->regs + MC_STAT_CONTROL);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static struct devfreq_dev_profile tegra_devfreq_profile = {
>>> +	.polling_ms	= 500,
>>> +	.target		= tegra_devfreq_target,
>>> +	.get_dev_status	= tegra_devfreq_get_dev_status,
>>> +};
>>> +
>>> +static struct tegra_mc *tegra_get_memory_controller(void)
>>> +{
>>> +	struct platform_device *pdev;
>>> +	struct device_node *np;
>>> +	struct tegra_mc *mc;
>>> +
>>> +	np = of_find_compatible_node(NULL, NULL, "nvidia,tegra20-mc-gart");
>>> +	if (!np)
>>> +		return ERR_PTR(-ENOENT);
>>> +
>>> +	pdev = of_find_device_by_node(np);
>>> +	of_node_put(np);
>>> +	if (!pdev)
>>> +		return ERR_PTR(-ENODEV);
>>> +
>>> +	mc = platform_get_drvdata(pdev);
>>> +	if (!mc)
>>> +		return ERR_PTR(-EPROBE_DEFER);
>>> +
>>> +	return mc;
>>> +}
>>> +
>>> +static int tegra_devfeq_probe(struct platform_device *pdev)
>>> +{
>>> +	struct tegra_devfreq *tegra;
>>> +	struct tegra_mc *mc;
>>> +	unsigned long max_rate;
>>> +	unsigned long rate;
>>> +	int err;
>>> +
>>> +	mc = tegra_get_memory_controller();
>>> +	if (IS_ERR(mc)) {
>>> +		err = PTR_ERR(mc);
>>> +		dev_err(&pdev->dev, "failed to get mc: %d\n", err);
>>
>> How about using 'memory controller' instead of 'mc'?
>> Because 'mc' is not standard expression.
> 
> Sounds good, thanks.
> 
>>> +		return err;
>>> +	}
>>> +
>>> +	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
>>> +	if (!tegra)
>>> +		return -ENOMEM;
>>> +
>>> +	tegra->clk = devm_clk_get(&pdev->dev, "emc");
>>> +	if (IS_ERR(tegra->clk)) {
>>> +		err = PTR_ERR(tegra->clk);
>>> +		dev_err(&pdev->dev, "failed to get emc clock: %d\n", err);
>>> +		return err;
>>> +	}
>>
>> Don't you need to enable the 'emc' clock'?
>> Because this patch doesn't enable this clock.
> 
> EMC is a system critical clock (marked as critical by the clock driver), it is guaranteed to be always enabled. I think it is fine to omit clock-enabling in this case.

If you think don't need to enable it due to the critical clock,
instead, please add the comment about that emc clock is critical.
In my case, it looks like the strange use-case because this driver
doesn't contain the any enable code for clock.

> 
>>> +
>>> +	tegra->regs = mc->regs;
>>> +
>>> +	max_rate = clk_round_rate(tegra->clk, ULONG_MAX);
>>> +
>>> +	for (rate = 0; rate <= max_rate; rate++) {
>>> +		rate = clk_round_rate(tegra->clk, rate);
>>> +		dev_pm_opp_add(&pdev->dev, rate, 0);
>>> +	}
>>> +
>>> +	writel_relaxed(0x00000000, tegra->regs + MC_STAT_CONTROL);
>>> +	writel_relaxed(0x00000000, tegra->regs + MC_STAT_EMC_CONTROL);
>>> +	writel_relaxed(0xffffffff, tegra->regs + MC_STAT_EMC_CLOCK_LIMIT);
>>
>> You better to add the comments of what are the meaning
>> of 0x00000000/0xffffffff. Without the detailed comments,
>> it is difficult to understand of meaning.
> 
> Okay. Although the complete registers description is available in public and someone really curious could just google for the full details. 
> 
>>> +
>>> +	platform_set_drvdata(pdev, tegra);
>>> +
>>> +	tegra->devfreq = devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
>>> +					    DEVFREQ_GOV_SIMPLE_ONDEMAND, NULL);
>>> +	if (IS_ERR(tegra->devfreq))
>>> +		return PTR_ERR(tegra->devfreq);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int tegra_devfreq_remove(struct platform_device *pdev)
>>> +{
>>> +	struct tegra_devfreq *tegra = platform_get_drvdata(pdev);
>>> +
>>> +	devfreq_remove_device(tegra->devfreq);
>>> +	dev_pm_opp_remove_all_dynamic(&pdev->dev);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static struct platform_driver tegra_devfeq_driver = {
>>> +	.probe		= tegra_devfeq_probe,
>>> +	.remove		= tegra_devfreq_remove,
>>> +	.driver		= {
>>> +		.name	= "tegra20-devfreq",
>>
>> How can you bind this driver without compatible name for Devicetree?
>> And I tried to find the name ("tegra20-devfreq") in
>> the MFD drivers.
> 
> As I wrote in the cover-letter, the device for the driver will be created by the EMC driver. I'll 
send out the patch that creates the device later on because of EMC driver patch-series interdependence, for now I have that patch here [1] if you're curious how it looks like.

OK. I understand. Thanks.

> 
> [1] https://github.com/grate-driver/linux/commit/c34440402bb4fb365647bf43166e85562c124273
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
