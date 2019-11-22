Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60013C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405D52068F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfKVRin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 12:38:43 -0500
Received: from mga03.intel.com ([134.134.136.65]:28062 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfKVRin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 12:38:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2019 09:38:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,230,1571727600"; 
   d="scan'208";a="238682978"
Received: from sygreen1-mobl4.amr.corp.intel.com (HELO [10.252.195.68]) ([10.252.195.68])
  by fmsmga002.fm.intel.com with ESMTP; 22 Nov 2019 09:38:40 -0800
Subject: Re: [alsa-devel] [PATCH v12 2/6] ASoC: amd: Refactoring of DAI from
 DMA driver
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Alexander.Deucher@amd.com, djkurtz@google.com,
        Akshu.Agrawal@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>
References: <1574415866-29715-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1574415866-29715-3-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7f4ccc51-7bdd-d1c6-605a-0b432485de73@linux.intel.com>
Date:   Fri, 22 Nov 2019 09:33:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1574415866-29715-3-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>   static int acp3x_audio_probe(struct platform_device *pdev)
>   {
> -	int status;
>   	struct resource *res;
>   	struct i2s_dev_data *adata;
>   	unsigned int irqflags;
> +	int status, ret;
>   
>   	if (!pdev->dev.platform_data) {
>   		dev_err(&pdev->dev, "platform_data not retrieved\n");
> @@ -622,7 +426,7 @@ static int acp3x_audio_probe(struct platform_device *pdev)
>   
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	if (!res) {
> -		dev_err(&pdev->dev, "IORESOURCE_IRQ FAILED\n");
> +		dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
>   		return -ENODEV;
>   	}
>   
> @@ -632,60 +436,64 @@ static int acp3x_audio_probe(struct platform_device *pdev)
>   
>   	adata->acp3x_base = devm_ioremap(&pdev->dev, res->start,
>   					 resource_size(res));
> +	if (!adata->acp3x_base)
> +		return -ENOMEM;
>   
>   	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>   	if (!res) {
>   		dev_err(&pdev->dev, "IORESOURCE_IRQ FAILED\n");
> -		return -ENODEV;
> +		return -ENOMEM;

it's odd for a -ENOMEM code to returned for IRQs?

>   	}
>   
>   	adata->i2s_irq = res->start;
> -	adata->play_stream = NULL;
> -	adata->capture_stream = NULL;
>   
>   	dev_set_drvdata(&pdev->dev, adata);
>   	/* Initialize ACP */
>   	status = acp3x_init(adata->acp3x_base);
>   	if (status)
>   		return -ENODEV;
> +
>   	status = devm_snd_soc_register_component(&pdev->dev,
>   						 &acp3x_i2s_component,
> -						 &acp3x_i2s_dai_driver, 1);
> +						 NULL, 0);
>   	if (status) {
> -		dev_err(&pdev->dev, "Fail to register acp i2s dai\n");
> +		dev_err(&pdev->dev, "Fail to register acp i2s component\n");
> +		ret = -ENODEV;
>   		goto dev_err;
>   	}
>   	status = devm_request_irq(&pdev->dev, adata->i2s_irq, i2s_irq_handler,
>   				  irqflags, "ACP3x_I2S_IRQ", adata);
>   	if (status) {
>   		dev_err(&pdev->dev, "ACP3x I2S IRQ request failed\n");
> +		ret = -ENODEV;
>   		goto dev_err;
>   	}
>   
> -	pm_runtime_set_autosuspend_delay(&pdev->dev, 10000);
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, 5000);
>   	pm_runtime_use_autosuspend(&pdev->dev);
>   	pm_runtime_enable(&pdev->dev);
>   	return 0;
> +
>   dev_err:
>   	status = acp3x_deinit(adata->acp3x_base);
>   	if (status)
>   		dev_err(&pdev->dev, "ACP de-init failed\n");
>   	else
> -		dev_info(&pdev->dev, "ACP de-initialized\n");
> -	/*ignore device status and return driver probe error*/
> -	return -ENODEV;
> +		dev_dbg(&pdev->dev, "ACP de-initialized\n");
> +	return ret;
>   }

