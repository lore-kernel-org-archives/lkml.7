Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4A4C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9131F20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Obzq0+ku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfDHRW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:22:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35081 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfDHRWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 13:22:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id t21so5692516pfh.2;
        Mon, 08 Apr 2019 10:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ltb6BY1n6C3HRpSxDD5KDZf9T+SfvtbMwxSW0nzuuPU=;
        b=Obzq0+ku06TnfxE6i7pIUdhm0AZLr9wgaJ6oPnQKSE2G/XahLkWHA96fC79AzM4TvU
         qBTaCsfoCiJflr6cNzFALULIIPHp3WZ8RONAKpKj8+AEuzhBvEe1Gl7AIvVfb0OY/yPz
         zxxrgFt0SmGS532s4GVS/X3E3/10ydAJfWVoZXsZzEjZ214X/NjQe2J+iiOTUbHSKAnb
         YnK543vEFtnqJysYc96pjWQhQBgI9qx81Ukdcpk0cD/Y3tjiYrBc8h+NHuqB55PA5R52
         DmLw2aZSsoqQQ8RMDkpbZPNxqo5AWcwgrzOyL929GfAAI6ACKjMAP4RkHD2pFlPZxMSl
         306Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ltb6BY1n6C3HRpSxDD5KDZf9T+SfvtbMwxSW0nzuuPU=;
        b=Py6s4X7Z86E92KGsH9mvfr+k0WRbzdcAgQqRx+jbnI8tgSwAYHk0c8LB364ssSncU2
         BhpqoCT3Q35ZtziFjOmfFXiWPaL2oIm9wTt1D2lp5waalM/4bPwnfhoPWikU7bUzG5Bf
         jy91pLlrCHOK9zD38ze3m09JYzm8xrCB8peinEYTbRHfZmL47Xc3ZMED7oMDA6pR6ycI
         7feewzZkJ56v2Ay2WownqJSoM1d9LlQoTWMu78qWIB3Wb/eC+CAjk39/shUhjsjAGL18
         OiA572BXsDzv9uoczWahYwDJVZRwpNgX18EJzuzbMFg6LfgSkLHFXSvO+WkAErrJ2Xk8
         KUFA==
X-Gm-Message-State: APjAAAW/5HZDsTdRo1C90RQPceDKTnUbIteYCTQzDJX/0wDoHbXKBrwi
        9A/qvdKaRE1GZDTi+/7AOuQ=
X-Google-Smtp-Source: APXvYqy0NGGIwvwmCC1hvpl4eNA9GlfqRHbJYfUgFiIbgrcew6fesLP9MHIEVVzKW+08Bon0/HyIJA==
X-Received: by 2002:a63:744b:: with SMTP id e11mr29339319pgn.327.1554744144157;
        Mon, 08 Apr 2019 10:22:24 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x66sm18009037pfb.78.2019.04.08.10.22.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 10:22:22 -0700 (PDT)
Date:   Mon, 8 Apr 2019 10:22:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        fan.chen@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [v2,4/4] devfreq: add mediatek cci devfreq
Message-ID: <20190408172220.GA28972@roeck-us.net>
References: <1553841972-19737-5-git-send-email-andrew-sh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553841972-19737-5-git-send-email-andrew-sh.cheng@mediatek.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 02:46:12PM +0800, Andrew-sh Cheng wrote:
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
> +			mutex_unlock(&cci_df->devfreq->lock);
> +		}
> +	}
> +
> +	if ((val & REGULATOR_EVENT_ABORT_VOLTAGE_CHANGE) &&
> +	    ((unsigned long)data > cci_df->proc_reg_uV)) {
> +		cci_df->proc_reg_uV = (unsigned long)data;
> +		mutex_lock(&cci_df->devfreq->lock);
> +		update_devfreq(cci_df->devfreq);
> +		mutex_unlock(&cci_df->devfreq->lock);
> +	}
> +
> +	/* deal with increase frequency */
> +	if ((val & REGULATOR_EVENT_VOLTAGE_CHANGE) &&
> +	    (cci_df->proc_reg_uV < (unsigned long)data)) {
> +		cci_df->proc_reg_uV = (unsigned long)data;
> +		mutex_lock(&cci_df->devfreq->lock);
> +		update_devfreq(cci_df->devfreq);
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
> +		break;
> +
> +	case DEVFREQ_GOV_STOP:
> +	case DEVFREQ_GOV_SUSPEND:
> +		regulator_unregister_notifier(cci_df->proc_reg,
> +					    nb);
> +
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
> +	.get_target_freq = mtk_cci_governor_get_target,
> +	.event_handler = mtk_cci_governor_event_handler,
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
> +
> +	return 0;
> +}
> +
> +static struct devfreq_dev_profile cci_devfreq_profile = {
> +	.target		= mtk_cci_devfreq_target,
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

Should use devm_clk_get().

> +	ret = PTR_ERR_OR_ZERO(cci_df->cci_clk);
> +	if (ret) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(cci_dev, "failed to get clock for CCI: %d\n",
> +				ret);
> +
> +		return ret;
> +	}
> +
> +	cci_df->proc_reg = regulator_get_optional(cci_dev, "proc");

Should use devm_regulator_get_optional().

> +	ret = PTR_ERR_OR_ZERO(cci_df->proc_reg);
> +	if (ret) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(cci_dev, "failed to get regulator for CCI: %d\n",
> +				ret);
> +
> +		goto err_put_clk;
> +	}
> +
> +	ret = dev_pm_opp_of_add_table(&pdev->dev);
> +	if (ret) {
> +		dev_err(cci_dev, "Fail to init CCI OPP table\n");

No error code display here ? Not that it really matters, but it is
inconsistent with the other error messages.

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

		ret = PTR_ERR(cci_df->devfreq);

> +		dev_err(cci_dev, "cannot create cci devfreq device\n", ret);

		dev_err(cci_dev, "cannot create cci devfreq device: %d\n", ret);

Something like
		dev_pm_opp_of_remove_table(...);
seems to be missing here.

> +		goto err_put_reg;
> +	}
> +
> +	return 0;
> +
> +err_put_reg:
> +	regulator_put(cci_df->proc_reg);
> +err_put_clk:
> +	clk_put(cci_df->cci_clk);

Can be dropped when using devm_ functions above.

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

If the driver depends on OF, that should be stated in the Kconfig file.
Otherwise, of_match_ptr() should be used, and mediatek_cci_devfreq_of_match
should be tagged with __maybe_unused (or made conditional with #ifdef).

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
