Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30211C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E0A206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbfKMRSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:18:08 -0500
Received: from mga02.intel.com ([134.134.136.20]:62542 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727343AbfKMRSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:18:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2019 09:18:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,301,1569308400"; 
   d="scan'208";a="229813213"
Received: from dmsnyder-mobl1.amr.corp.intel.com (HELO [10.252.193.15]) ([10.252.193.15])
  by fmsmga004.fm.intel.com with ESMTP; 13 Nov 2019 09:18:04 -0800
Subject: Re: [alsa-devel] [RESEND PATCH v5 2/6] ASoC: amd: Refactoring of DAI
 from DMA driver
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Akshu.Agrawal@amd.com,
        Sanju R Mehta <sanju.mehta@amd.com>,
        Mark Brown <broonie@kernel.org>, djkurtz@google.com,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Colin Ian King <colin.king@canonical.com>
References: <1573629249-13272-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1573629249-13272-3-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <40d1690c-175c-c6ee-ee44-390c30cccc05@linux.intel.com>
Date:   Wed, 13 Nov 2019 10:22:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1573629249-13272-3-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +	val = rv_readl(adata->acp3x_base + mmACP_BTTDM_ITER);
> +	rv_writel((val | 0x2), adata->acp3x_base + mmACP_BTTDM_ITER);
> +	val = rv_readl(adata->acp3x_base + mmACP_BTTDM_IRER);
> +	rv_writel((val | 0x2), adata->acp3x_base + mmACP_BTTDM_IRER);
> +
> +	val = (FRM_LEN | (slots << 15) | (slot_len << 18));

nit-pick: you have extra parentheses that are not needed for (val | 
0x02) and the outer ones on the previous line


> +static int acp3x_i2s_trigger(struct snd_pcm_substream *substream,
> +		int cmd, struct snd_soc_dai *dai)
> +{
> +	int ret = 0;

nit-pick: move last, xmas-style

> +	struct i2s_stream_instance *rtd = substream->runtime->private_data;
> +	u32 val, period_bytes;

> +static int acp3x_dai_probe(struct platform_device *pdev)
> +{
> +	int status;
> +	struct resource *res;
> +	struct i2s_dev_data *adata;
> +
> +	adata = devm_kzalloc(&pdev->dev, sizeof(struct i2s_dev_data),
> +			GFP_KERNEL);
> +	if (!adata)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
> +		goto err;
> +	}
> +
> +	adata->acp3x_base = devm_ioremap(&pdev->dev, res->start,
> +			resource_size(res));
> +	if (IS_ERR(adata->acp3x_base))
> +		return PTR_ERR(adata->acp3x_base);
> +
> +	adata->i2s_irq = res->start;
> +	dev_set_drvdata(&pdev->dev, adata);
> +	status = devm_snd_soc_register_component(&pdev->dev,
> +			&acp3x_dai_component,
> +			&acp3x_i2s_dai, 1);
> +	if (status) {
> +		dev_err(&pdev->dev, "Fail to register acp i2s dai\n");
> +		goto dev_err;
> +	}
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, 10000);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +	return 0;
> +err:
> +	kfree(adata);
> +	return -ENOMEM;
> +dev_err:
> +	kfree(adata->acp3x_base);
> +	kfree(adata);
> +	kfree(res);
> +	return -ENODEV;

this can be improved a bit by using ret = -ENOMEM/-ENODEV before the 
goto, and organizing the labels and the kfree calls in the reverse order 
of the initialization/allocation steps.


> @@ -666,7 +461,24 @@ static int acp3x_audio_probe(struct platform_device *pdev)
>   	pm_runtime_use_autosuspend(&pdev->dev);
>   	pm_runtime_enable(&pdev->dev);
>   	return 0;
> +
> +err:
> +	kfree(res);
> +	return -ENOMEM;
> +base_err:
> +	kfree(res);
> +	kfree(adata);
> +	return -ENOMEM;
> +io_irq:
> +	kfree(res);
> +	kfree(adata->acp3x_base);
> +	kfree(adata);
> +	return -ENOMEM;
> +
>   dev_err:
> +	kfree(res);
> +	kfree(adata->acp3x_base);
> +	kfree(adata);
>   	status = acp3x_deinit(adata->acp3x_base);
>   	if (status)
>   		dev_err(&pdev->dev, "ACP de-init failed\n");
same here, you should have all the kfrees in the reverse order of the 
kzalloc, and labels pointing straight at the sequence that needs to be 
executed. Duplicating the error flow makes it hard to maintain the code 
and check for memory leaks.
