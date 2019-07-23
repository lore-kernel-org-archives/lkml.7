Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAE1C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744E620665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733114AbfGWPSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:18:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:20197 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfGWPSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:18:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2019 08:18:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,299,1559545200"; 
   d="scan'208";a="368405049"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jul 2019 08:18:01 -0700
Received: from xiliu-mobl1.amr.corp.intel.com (unknown [10.252.200.163])
        by linux.intel.com (Postfix) with ESMTP id 3C0A4580144;
        Tue, 23 Jul 2019 08:18:00 -0700 (PDT)
Subject: Re: [Sound-open-firmware] [PATCH v2 3/5] ASoC: SOF: Add DT DSP device
 support
To:     Daniel Baluta <daniel.baluta@nxp.com>, m.felsch@pengutronix.de,
        shawnguo@kernel.org
Cc:     mark.rutland@arm.com, aisheng.dong@nxp.com, peng.fan@nxp.com,
        anson.huang@nxp.com, devicetree@vger.kernel.org,
        shengjiu.wang@nxp.com, linux-kernel@vger.kernel.org,
        paul.olaru@nxp.com, robh+dt@kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, leonard.crestez@nxp.com, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        sound-open-firmware@alsa-project.org
References: <20190723084104.12639-1-daniel.baluta@nxp.com>
 <20190723084104.12639-4-daniel.baluta@nxp.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d85909d6-c7cb-c64b-dfa9-6cee6c0da2cb@linux.intel.com>
Date:   Tue, 23 Jul 2019 10:11:56 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723084104.12639-4-daniel.baluta@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> diff --git a/sound/soc/sof/Kconfig b/sound/soc/sof/Kconfig
> index 61b97fc55bb2..2aa3a1cdf60c 100644
> --- a/sound/soc/sof/Kconfig
> +++ b/sound/soc/sof/Kconfig
> @@ -36,6 +36,15 @@ config SND_SOC_SOF_ACPI
>   	  Say Y if you need this option
>   	  If unsure select "N".
>   
> +config SND_SOC_SOF_DT
> +	tristate "SOF DT enumeration support"
> +	select SND_SOC_SOF
> +	select SND_SOC_SOF_OPTIONS
> +	help
> +	  This adds support for Device Tree enumeration. This option is
> +	  required to enable i.MX8 devices.
> +	  Say Y if you need this option. If unsure select "N".
> +

[snip]

> diff --git a/sound/soc/sof/imx/Kconfig b/sound/soc/sof/imx/Kconfig
> index fff64a9970f0..fa35994a79c4 100644
> --- a/sound/soc/sof/imx/Kconfig
> +++ b/sound/soc/sof/imx/Kconfig
> @@ -12,6 +12,7 @@ if SND_SOC_SOF_IMX_TOPLEVEL
>   
>   config SND_SOC_SOF_IMX8
>   	tristate "SOF support for i.MX8"
> +	select SND_SOC_SOF_DT

This looks upside down. You should select SOF_DT first then include the 
NXP stuff.

>   	help
>             This adds support for Sound Open Firmware for NXP i.MX8 platforms
>             Say Y if you have such a device.
> diff --git a/sound/soc/sof/sof-dt-dev.c b/sound/soc/sof/sof-dt-dev.c
> new file mode 100644
> index 000000000000..31429bbb5c7e
> --- /dev/null
> +++ b/sound/soc/sof/sof-dt-dev.c
> @@ -0,0 +1,159 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> +//
> +// Copyright 2019 NXP
> +//
> +// Author: Daniel Baluta <daniel.baluta@nxp.com>
> +//
> +
> +#include <linux/firmware.h>
> +#include <linux/module.h>
> +#include <linux/pm_runtime.h>
> +#include <sound/sof.h>
> +
> +#include "ops.h"
> +
> +extern struct snd_sof_dsp_ops sof_imx8_ops;
> +
> +static char *fw_path;
> +module_param(fw_path, charp, 0444);
> +MODULE_PARM_DESC(fw_path, "alternate path for SOF firmware.");
> +
> +static char *tplg_path;
> +module_param(tplg_path, charp, 0444);
> +MODULE_PARM_DESC(tplg_path, "alternate path for SOF topology.");
> +
> +/* platform specific devices */
> +#if IS_ENABLED(CONFIG_SND_SOC_SOF_IMX8)
> +static struct sof_dev_desc sof_dt_imx8qxp_desc = {
> +	.default_fw_path = "imx/sof",
> +	.default_tplg_path = "imx/sof-tplg",
> +	.nocodec_fw_filename = "sof-imx8.ri",
> +	.nocodec_tplg_filename = "sof-imx8-nocodec.tplg",
> +	.ops = &sof_imx8_ops,
> +};
> +#endif
> +
> +static const struct dev_pm_ops sof_dt_pm = {
> +	SET_SYSTEM_SLEEP_PM_OPS(snd_sof_suspend, snd_sof_resume)
> +	SET_RUNTIME_PM_OPS(snd_sof_runtime_suspend, snd_sof_runtime_resume,
> +			   NULL)
> +};
> +
> +static void sof_dt_probe_complete(struct device *dev)
> +{
> +	/* allow runtime_pm */
> +	pm_runtime_set_autosuspend_delay(dev, SND_SOF_SUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_enable(dev);
> +}
> +
> +static int sof_dt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	const struct sof_dev_desc *desc;
> +	/*TODO: create a generic snd_soc_xxx_mach */
> +	struct snd_soc_acpi_mach *mach;

I wonder if you really need to use the same structures. For Intel we get 
absolutely zero info from the firmware so rely on an ACPI codec ID as a 
key to find information on which firmware and topology to use, and which 
machine driver to load. You could have all this information in a DT blob?

> +	struct snd_sof_pdata *sof_pdata;
> +	const struct snd_sof_dsp_ops *ops;
> +	int ret;
> +
> +	dev_info(&pdev->dev, "DT DSP detected");
> +
> +	sof_pdata = devm_kzalloc(dev, sizeof(*sof_pdata), GFP_KERNEL);
> +	if (!sof_pdata)
> +		return -ENOMEM;
> +
> +	desc = device_get_match_data(dev);
> +	if (!desc)
> +		return -ENODEV;
> +
> +	/* get ops for platform */
> +	ops = desc->ops;
> +	if (!ops) {
> +		dev_err(dev, "error: no matching DT descriptor ops\n");
> +		return -ENODEV;
> +	}
> +
> +#if IS_ENABLED(CONFIG_SND_SOC_SOF_FORCE_NOCODEC_MODE)
> +	/* force nocodec mode */
> +	dev_warn(dev, "Force to use nocodec mode\n");
> +	mach = devm_kzalloc(dev, sizeof(*mach), GFP_KERNEL);
> +	if (!mach)
> +		return -ENOMEM;
> +	ret = sof_nocodec_setup(dev, sof_pdata, mach, desc, ops);
> +	if (ret < 0)
> +		return ret;
> +#else
> +	/* TODO: implement case where we actually have a codec */
> +	return -ENODEV;
> +#endif
> +
> +	if (mach)
> +		mach->mach_params.platform = dev_name(dev);
> +
> +	sof_pdata->machine = mach;
> +	sof_pdata->desc = desc;
> +	sof_pdata->dev = &pdev->dev;
> +	sof_pdata->platform = dev_name(dev);
> +
> +	/* alternate fw and tplg filenames */
> +	if (fw_path)
> +		sof_pdata->fw_filename_prefix = fw_path;
> +	else
> +		sof_pdata->fw_filename_prefix =
> +			sof_pdata->desc->default_fw_path;
> +	if (tplg_path)
> +		sof_pdata->tplg_filename_prefix = tplg_path;
> +	else
> +		sof_pdata->tplg_filename_prefix =
> +			sof_pdata->desc->default_tplg_path;
> +
> +#if IS_ENABLED(CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE)
> +	/* set callback to enable runtime_pm */
> +	sof_pdata->sof_probe_complete = sof_dt_probe_complete;
> +#endif
> +	 /* call sof helper for DSP hardware probe */
> +	ret = snd_sof_device_probe(dev, sof_pdata);
> +	if (ret) {
> +		dev_err(dev, "error: failed to probe DSP hardware\n");
> +		return ret;
> +	}
> +
> +#if !IS_ENABLED(CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE)
> +	sof_dt_probe_complete(dev);
> +#endif
> +
> +	return ret;
> +}
> +
> +static int sof_dt_remove(struct platform_device *pdev)
> +{
> +	pm_runtime_disable(&pdev->dev);
> +
> +	/* call sof helper for DSP hardware remove */
> +	snd_sof_device_remove(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sof_dt_ids[] = {
> +#if IS_ENABLED(CONFIG_SND_SOC_SOF_IMX8)
> +	{ .compatible = "fsl,imx8qxp-dsp", .data = &sof_dt_imx8qxp_desc},
> +#endif
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sof_dt_ids);
> +
> +/* DT driver definition */
> +static struct platform_driver snd_sof_dt_driver = {
> +	.probe = sof_dt_probe,
> +	.remove = sof_dt_remove,
> +	.driver = {
> +		.name = "sof-audio-dt",
> +		.pm = &sof_dt_pm,
> +		.of_match_table = sof_dt_ids
> +	},
> +};
> +module_platform_driver(snd_sof_dt_driver);
> +
> +MODULE_LICENSE("Dual BSD/GPL");
> 

