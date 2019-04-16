Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AACAC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB8020645
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aI39jw3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfDPJEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:04:40 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:41832 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbfDPJEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 05:04:39 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190416090435epoutp0173d422ff1cdb8812c8578aa4243d857e~V6QoQZ12k0099100991epoutp015
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:04:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190416090435epoutp0173d422ff1cdb8812c8578aa4243d857e~V6QoQZ12k0099100991epoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555405475;
        bh=CgtUr+o3MhaT+NC/iPo8yHdYcpArJoSK74fKojXvHQQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=aI39jw3HbBnFDadSoAhr4q2e5YCx8ttPj+xdJmNxIFeTMmFCqx4ePeQa6dW2HKe6/
         m0zMeyMe4aewpfJaOG+yA9S53cHUrb3S3r+IdR7+n4NBq4RQIdHDGb7RnWmf9BWo4J
         BNyzhDP0ZQqt63CK0k8HjiDcrKSNMmg0s7Ft2Ku8=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.154]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190416090431epcas1p2054b278298c2c4a7fa8a0a6ad6ab4f37~V6QkjIvHX2754727547epcas1p23;
        Tue, 16 Apr 2019 09:04:31 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.66.04108.F9A95BC5; Tue, 16 Apr 2019 18:04:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190416090431epcas1p1379a692b918a12b5171ae3439d71cc3c~V6Qj5Sba50167201672epcas1p1k;
        Tue, 16 Apr 2019 09:04:31 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190416090431epsmtrp2077ac0ce51ef84288e38bd2e67142e08~V6Qj4aE8Y1355013550epsmtrp2k;
        Tue, 16 Apr 2019 09:04:31 +0000 (GMT)
X-AuditID: b6c32a39-89fff7000000100c-85-5cb59a9fb87e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        71.74.03662.E9A95BC5; Tue, 16 Apr 2019 18:04:30 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190416090430epsmtip148db3229be5c64e3b2bbb82c2d722826~V6Qjquoar2600126001epsmtip1X;
        Tue, 16 Apr 2019 09:04:30 +0000 (GMT)
Subject: Re: [PATCH v2 4/4] devfreq: add mediatek cci devfreq
To:     "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, fan.chen@mediatek.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <e9eaa131-5791-c844-a02f-1bdd46719768@samsung.com>
Date:   Tue, 16 Apr 2019 18:05:25 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1553841972-19737-5-git-send-email-andrew-sh.cheng@mediatek.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLJsWRmVeSWpSXmKPExsWy7bCmge78WVtjDHbP1bTYvv4Fq8X8I+dY
        Lb7d+c1kcbbpDbvFpsfXWC0u75rDZnG5+SKjxefeI4wWS69fZLJoajG2uN24gs3izOlLrBat
        e4+wW0y/K2Sx8auHA7/HmnlrGD12zrrL7rFpVSebx51re9g8Ni+p92g5uZ/FY8vVdhaPvi2r
        GD0+b5IL4IzKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1
        y8wBOl9JoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BZoFecmFtcmpeul5yfa2Vo
        YGBkClSYkJ3xf08PY8G1oIrL7QYNjE1OXYycHBICJhKz/p9m6WLk4hAS2MEo8WVVMzNIQkjg
        E6PE1ZPREIlvjBK3r5xggen4unMHK0RiL6PExIYfbBDOe0aJ6ee2grULC9hKzHz+gBEkISJw
        mUniyvbzbCAJZoFbjBKv94PZbAJaEvtf3ACz+QUUJa7+eMwIYvMK2Enc6v3ICmKzCKhKtM+Z
        AGaLCkRI3D+2gRWiRlDi5MwnYCdxCvhKbJ/1hQlivrjErSfzoWx5ieats5lBjpAQOMYu8ebn
        HVaIH1wk3hy/xgxhC0u8Or6FHcKWkvj8bi8bhF0tsfLkETaI5g5GiS37L0A1G0vsXzoZaAMH
        0AZNifW79CGW8Um8+9rDChKWEOCV6GgTgqhWlrj84C4ThC0psbi9E2q8h8TybxsZJzAqzkLy
        ziwkL8xC8sIshGULGFlWMYqlFhTnpqcWGxaYIsf2JkZw0tay3MF47JzPIUYBDkYlHl6Oni0x
        QqyJZcWVuYcYJTiYlUR4HVOAQrwpiZVVqUX58UWlOanFhxhNgaE9kVlKNDkfmFHySuINTY2M
        jY0tTAzNTA0NlcR51zs4xwgJpCeWpGanphakFsH0MXFwSjUwHt1fkPO3XtAlqv1Qnc3Jbdc5
        fVRXruu2PXrmwinG+MdR5Szsz/6mdK3tu5N7+fiMCVNXGO5WOOCp+uvftCpfnpUdj8SWuBh+
        bp+099TfDdJB/ns27eVbfVqkVjlqhansNKd3z4z7l6wJfTVXIdbc1+LaDlm2jmcTbzOwtu+M
        rr28wv+t6xIOfSWW4oxEQy3mouJEACev1jrwAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsWy7bCSnO68WVtjDE6etLHYvv4Fq8X8I+dY
        Lb7d+c1kcbbpDbvFpsfXWC0u75rDZnG5+SKjxefeI4wWS69fZLJoajG2uN24gs3izOlLrBat
        e4+wW0y/K2Sx8auHA7/HmnlrGD12zrrL7rFpVSebx51re9g8Ni+p92g5uZ/FY8vVdhaPvi2r
        GD0+b5IL4IzisklJzcksSy3St0vgyvi/p4ex4FpQxeV2gwbGJqcuRk4OCQETia87d7B2MXJx
        CAnsZpRYtucEK0RCUmLaxaPMXYwcQLawxOHDxRA1bxkl2nd8ZQSpERawlZj5/AEjSEJE4DqT
        xKu7R1lAHGaBW4wSm5qPsINUCQk8ZpTY/cYVxGYT0JLY/+IGG4jNL6AocfXHY7BJvAJ2Erd6
        P4JtZhFQlWifMwHMFhWIkDjzfgULRI2gxMmZT8BsTgFfie2zvjCB2MwC6hJ/5l1ihrDFJW49
        mQ8Vl5do3jqbeQKj8Cwk7bOQtMxC0jILScsCRpZVjJKpBcW56bnFhgVGeanlesWJucWleel6
        yfm5mxjB8aultYPxxIn4Q4wCHIxKPLwJfVtihFgTy4orcw8xSnAwK4nwOqYAhXhTEiurUovy
        44tKc1KLDzFKc7AoifPK5x+LFBJITyxJzU5NLUgtgskycXBKNTCK/zLu82GQFj/huynV/e7S
        Xe++H38guODZwtgvs5hlXSbOesnSl7Coff7WdSpi3f/STBfPPi18X2Kt5bmDX4w+X/Pb21fV
        dEld+k++B5/TJC2pSQr7qrmaJp9dwPI4NCDIzMdKe39wgJR7kEruROaFS1Va6yI6mS8ueeYg
        uePf7tfmRz+onpZWYinOSDTUYi4qTgQAoRwpUNsCAAA=
X-CMS-MailID: 20190416090431epcas1p1379a692b918a12b5171ae3439d71cc3c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190329064635epcas2p4e6120f002d4e535bb5b551224fccd83f
References: <1553841972-19737-1-git-send-email-andrew-sh.cheng@mediatek.com>
        <CGME20190329064635epcas2p4e6120f002d4e535bb5b551224fccd83f@epcas2p4.samsung.com>
        <1553841972-19737-5-git-send-email-andrew-sh.cheng@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew-sh.Cheng,

Please add the dt-binding documentation.

On 19. 3. 29. 오후 3:46, Andrew-sh.Cheng wrote:
> This adds a devfreq driver for the Cache Coherent Interconnect (CCI)
> of the Mediatek MT8183.
> 
> On the MT8183 the CCI is supplied by the same regulator as the LITTLE
> cores. The driver is notified when the regulator voltage changes
> (driven by cpufreq) and adjusts the CCI frequency to the maximum
> possible value.
> 
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  drivers/devfreq/Kconfig              |  10 ++
>  drivers/devfreq/Makefile             |   1 +
>  drivers/devfreq/mt8183-cci-devfreq.c | 235 +++++++++++++++++++++++++++++++++++
>  3 files changed, 246 insertions(+)
>  create mode 100644 drivers/devfreq/mt8183-cci-devfreq.c
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 6a172d3..da2f8ec 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -91,6 +91,16 @@ config ARM_EXYNOS_BUS_DEVFREQ
>  	  and adjusts the operating frequencies and voltages with OPP support.
>  	  This does not yet operate with optimal voltages.
>  
> +config ARM_MT8183_CCI_DEVFREQ
> +	tristate "MT8183 CCI DEVFREQ Driver"
> +	depends on ARM_MEDIATEK_CPUFREQ
> +	help
> +		This adds a devfreq driver for Cache Coherent Interconnect
> +		of Mediatek MT8183, which is shared the same regulator
> +		with cpu cluster.
> +		It can track buck voltage and update a proper cci frequency.
> +		Use notification to get regulator status.
> +
>  config ARM_TEGRA_DEVFREQ
>  	tristate "Tegra DEVFREQ Driver"
>  	depends on ARCH_TEGRA_124_SOC
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> index 32b8d4d..817dde7 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
>  
>  # DEVFREQ Drivers
>  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
> +obj-$(CONFIG_ARM_MT8183_CCI_DEVFREQ)    += mt8183-cci-devfreq.o
>  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
>  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra-devfreq.o
>  
> diff --git a/drivers/devfreq/mt8183-cci-devfreq.c b/drivers/devfreq/mt8183-cci-devfreq.c
> new file mode 100644
> index 0000000..af82d2e
> --- /dev/null
> +++ b/drivers/devfreq/mt8183-cci-devfreq.c
> @@ -0,0 +1,235 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 MediaTek Inc.

You can add the author information under copyright information.

> + */
> +
> +#include <linux/clk.h>
> +#include <linux/devfreq.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include "governor.h"
> +
> +struct cci_devfreq {
> +	struct devfreq		*devfreq;
> +	struct regulator	*proc_reg;
> +	unsigned long           proc_reg_uV;
> +	struct clk		*cci_clk;
> +	struct notifier_block	nb;

Just use the space instead of tab as following:

	struct devfreq *devfreq;
	struct regulator *proc_reg;
	unsigned long proc_reg_uV;
	struct clk *cci_clk;
	struct notifier_block nb;

> +};
> +
> +static int cci_devfreq_regulator_notifier(struct notifier_block *nb,
> +					  unsigned long val, void *data)
> +{
> +	struct cci_devfreq *cci_df =
> +		container_of(nb, struct cci_devfreq, nb);
> +
> +	/* deal with reduce frequency */
> +	if (val & REGULATOR_EVENT_PRE_VOLTAGE_CHANGE) {
> +		struct pre_voltage_change_data *pvc_data = data;
> +
> +		if (pvc_data->min_uV < pvc_data->old_uV) {
> +			cci_df->proc_reg_uV =
> +				(unsigned long)(pvc_data->min_uV);
> +			mutex_lock(&cci_df->devfreq->lock);
> +			update_devfreq(cci_df->devfreq);

Please handle the return value of update_devfreq() for exception handling.

> +			mutex_unlock(&cci_df->devfreq->lock);
> +		}
> +	}
> +
> +	if ((val & REGULATOR_EVENT_ABORT_VOLTAGE_CHANGE) &&

if -> else if

At the same time, receives only one notification.
It is not necessary to check the two if statement always, .


> +	    ((unsigned long)data > cci_df->proc_reg_uV)) {
> +		cci_df->proc_reg_uV = (unsigned long)data;
> +		mutex_lock(&cci_df->devfreq->lock);
> +		update_devfreq(cci_df->devfreq);

ditto. Please check the return value of update_devfreq.

> +		mutex_unlock(&cci_df->devfreq->lock);
> +	}
> +
> +	/* deal with increase frequency */
> +	if ((val & REGULATOR_EVENT_VOLTAGE_CHANGE) &&

ditto.
if -> else if

At the same time, receives only one notification.
It is not necessary to check the two if statement always, .


> +	    (cci_df->proc_reg_uV < (unsigned long)data)) {
> +		cci_df->proc_reg_uV = (unsigned long)data;
> +		mutex_lock(&cci_df->devfreq->lock);
> +		update_devfreq(cci_df->devfreq);

ditto. Please check the return value of update_devfreq.

> +		mutex_unlock(&cci_df->devfreq->lock);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_cci_governor_get_target(struct devfreq *devfreq,
> +				       unsigned long *freq)
> +{
> +	struct cci_devfreq *cci_df;
> +	struct dev_pm_opp *opp;
> +
> +	cci_df = dev_get_drvdata(devfreq->dev.parent);
> +
> +	/* find available frequency */
> +	opp = dev_pm_opp_find_max_freq_by_volt(devfreq->dev.parent,
> +						 cci_df->proc_reg_uV);
> +	*freq = dev_pm_opp_get_freq(opp);
> +
> +	return 0;
> +}
> +
> +static int mtk_cci_governor_event_handler(struct devfreq *devfreq,
> +					  unsigned int event, void *data)
> +{
> +	struct cci_devfreq *cci_df;
> +	struct notifier_block *nb;
> +
> +	cci_df = dev_get_drvdata(devfreq->dev.parent);
> +	nb = &cci_df->nb;
> +
> +	switch (event) {
> +	case DEVFREQ_GOV_START:
> +	case DEVFREQ_GOV_RESUME:
> +		nb->notifier_call = cci_devfreq_regulator_notifier;
> +		regulator_register_notifier(cci_df->proc_reg,
> +					    nb);

Please check the return value of regulator_register_notifier
in order to handle the exception handling.


> +		break;
> +
> +	case DEVFREQ_GOV_STOP:
> +	case DEVFREQ_GOV_SUSPEND:
> +		regulator_unregister_notifier(cci_df->proc_reg,
> +					    nb);

ditto.

> +

Remove unneeded blank line.

> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct devfreq_governor mtk_cci_devfreq_governor = {
> +	.name = "mtk_cci_vmon",

How about editing the name from mtk_cci_vmon to mediatek_cci_voltage_monitor
for the readability? Actually, 'mtk' and 'vmon' are not standard expression.

> +	.get_target_freq = mtk_cci_governor_get_target,
> +	.event_handler = mtk_cci_governor_event_handler,

Please add following code to make it as the immutable
because the governor for this driver will not be changed
through sysfs interface.

	.immutable = true

> +};
> +
> +static int mtk_cci_devfreq_target(struct device *dev, unsigned long *freq,
> +				  u32 flags)
> +{
> +	struct cci_devfreq *cci_df = dev_get_drvdata(dev);
> +
> +	if (!cci_df)
> +		return -EINVAL;
> +
> +	clk_set_rate(cci_df->cci_clk, *freq);

Please check the return value of clk_set_rate().

> +
> +	return 0;
> +}
> +
> +static struct devfreq_dev_profile cci_devfreq_profile = {
> +	.target		= mtk_cci_devfreq_target,

Just use the space instead of tab because cci_devfreq_profile
only has one record.

	.target = mtk_cci_devfreq_target,

> +};
> +
> +static int mtk_cci_devfreq_probe(struct platform_device *pdev)
> +{
> +	struct device *cci_dev = &pdev->dev;
> +	struct cci_devfreq *cci_df;
> +	int ret;
> +
> +	cci_df = devm_kzalloc(cci_dev, sizeof(*cci_df), GFP_KERNEL);
> +	if (!cci_df)
> +		return -ENOMEM;
> +
> +	cci_df->cci_clk = clk_get(cci_dev, "cci_clock");

clk_get -> devm_clk_get()

> +	ret = PTR_ERR_OR_ZERO(cci_df->cci_clk);
> +	if (ret) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(cci_dev, "failed to get clock for CCI: %d\n",
> +				ret);
> +

Remove unneeded blank line.

> +		return ret;
> +	}> +
> +	cci_df->proc_reg = regulator_get_optional(cci_dev, "proc");


regulator_get_optional -> devm_regulator_get_optional

> +	ret = PTR_ERR_OR_ZERO(cci_df->proc_reg);
> +	if (ret) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(cci_dev, "failed to get regulator for CCI: %d\n",
> +				ret);
> +

Remove unneeded blank line.

> +		goto err_put_clk;

If you use devm_clk_get(), just return instead of goto.

> +	}
> +
> +	ret = dev_pm_opp_of_add_table(&pdev->dev);
> +	if (ret) {
> +		dev_err(cci_dev, "Fail to init CCI OPP table\n");
> +		goto err_put_reg;
> +	}
> +
> +	platform_set_drvdata(pdev, cci_df);
> +
> +	cci_df->devfreq = devm_devfreq_add_device(cci_dev,
> +						       &cci_devfreq_profile,
> +						       "mtk_cci_vmon",
> +						       NULL);
> +	if (IS_ERR(cci_df->devfreq)) {
> +		dev_err(cci_dev, "cannot create cci devfreq device\n", ret);
> +		goto err_put_reg;
> +	}
> +
> +	return 0;
> +
> +err_put_reg:
> +	regulator_put(cci_df->proc_reg);
> +err_put_clk:
> +	clk_put(cci_df->cci_clk);

If you use devm_clk_get()/devm_regulator_get(),
'err_put_reg' and 'err_put_clk' are unneeded.

> +
> +	return ret;
> +}
> +
> +static const struct of_device_id mediatek_cci_devfreq_of_match[] = {
> +	{ .compatible = "mediatek,mt8183-cci" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, mediatek_cci_devfreq_of_match);
> +
> +static struct platform_driver cci_devfreq_driver = {
> +	.probe	= mtk_cci_devfreq_probe,
> +	.driver = {
> +		.name = "mediatek-cci-devfreq",
> +		.of_match_table = mediatek_cci_devfreq_of_match,
> +	},
> +};
> +
> +static int __init mtk_cci_devfreq_init(void)
> +{
> +	int ret;
> +
> +	ret = devfreq_add_governor(&mtk_cci_devfreq_governor);
> +	if (ret) {
> +		pr_err("%s: failed to add governor: %d\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	ret = platform_driver_register(&cci_devfreq_driver);
> +	if (ret)
> +		devfreq_remove_governor(&mtk_cci_devfreq_governor);
> +
> +	return ret;
> +}
> +module_init(mtk_cci_devfreq_init)
> +
> +static void __exit mtk_cci_devfreq_exit(void)
> +{
> +	int ret;
> +
> +	ret = devfreq_remove_governor(&mtk_cci_devfreq_governor);
> +	if (ret)
> +		pr_err("%s: failed to remove governor: %d\n", __func__, ret);
> +
> +	platform_driver_unregister(&cci_devfreq_driver);
> +}
> +module_exit(mtk_cci_devfreq_exit)
> +
> +MODULE_DESCRIPTION("Mediatek CCI devfreq driver");
> +MODULE_AUTHOR("Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>");
> +MODULE_LICENSE("GPL v2");
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
