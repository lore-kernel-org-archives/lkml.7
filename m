Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F83C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9228E2166E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732319AbfKFQw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:52:59 -0500
Received: from mga03.intel.com ([134.134.136.65]:52065 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727824AbfKFQw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:52:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 08:52:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="353532510"
Received: from pdblomfi-mobl.gar.corp.intel.com (HELO [10.254.107.145]) ([10.254.107.145])
  by orsmga004.jf.intel.com with ESMTP; 06 Nov 2019 08:52:56 -0800
Subject: Re: [alsa-devel] [PATCH v2 6/7] ASoC: amd: ACP powergating to be done
 by controller
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
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <1573137364-5592-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1573137364-5592-7-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <832e9ef3-7c5f-eaaf-5740-2f0b0472d69c@linux.intel.com>
Date:   Wed, 6 Nov 2019 10:40:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1573137364-5592-7-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/19 8:36 AM, Ravulapati Vishnu vardhan rao wrote:
> ACP power gating should be done by ACP-PCI.previous it was
> handled in DMA driver which is not authorised to do.Moving
> it to ACP-PCI.

Missing spaces

> 
> Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
> ---
>   sound/soc/amd/raven/acp3x-pcm-dma.c | 141 +-----------------------------------
>   sound/soc/amd/raven/acp3x.h         |   7 ++
>   sound/soc/amd/raven/pci-acp3x.c     | 130 ++++++++++++++++++++++++++++++++-
>   3 files changed, 138 insertions(+), 140 deletions(-)
> 
> diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
> index 689e234..f77f5bc 100644
> --- a/sound/soc/amd/raven/acp3x-pcm-dma.c
> +++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
> @@ -58,106 +58,6 @@ static const struct snd_pcm_hardware acp3x_pcm_hardware_capture = {
>   	.periods_max = CAPTURE_MAX_NUM_PERIODS,
>   };
>   
> -static int acp3x_power_on(void __iomem *acp3x_base, bool on)
> -{
> -	u16 val, mask;
> -	u32 timeout;
> -
> -	if (on == true) {
> -		val = 1;
> -		mask = ACP3x_POWER_ON;
> -	} else {
> -		val = 0;
> -		mask = ACP3x_POWER_OFF;
> -	}
> -
> -	rv_writel(val, acp3x_base + mmACP_PGFSM_CONTROL);
> -	timeout = 0;
> -	while (true) {
> -		val = rv_readl(acp3x_base + mmACP_PGFSM_STATUS);
> -		if ((val & ACP3x_POWER_OFF_IN_PROGRESS) == mask)
> -			break;
> -		if (timeout > 100) {
> -			pr_err("ACP3x power state change failure\n");
> -			return -ENODEV;
> -		}
> -		timeout++;
> -		cpu_relax();
> -	}
> -	return 0;
> -}
> -
> -static int acp3x_reset(void __iomem *acp3x_base)
> -{
> -	u32 val, timeout;
> -
> -	rv_writel(1, acp3x_base + mmACP_SOFT_RESET);
> -	timeout = 0;
> -	while (true) {
> -		val = rv_readl(acp3x_base + mmACP_SOFT_RESET);
> -		if ((val & ACP3x_SOFT_RESET__SoftResetAudDone_MASK) ||
> -		     timeout > 100) {
> -			if (val & ACP3x_SOFT_RESET__SoftResetAudDone_MASK)
> -				break;
> -			return -ENODEV;
> -		}
> -		timeout++;
> -		cpu_relax();
> -	}
> -
> -	rv_writel(0, acp3x_base + mmACP_SOFT_RESET);
> -	timeout = 0;
> -	while (true) {
> -		val = rv_readl(acp3x_base + mmACP_SOFT_RESET);
> -		if (!val || timeout > 100) {
> -			if (!val)
> -				break;
> -			return -ENODEV;
> -		}
> -		timeout++;
> -		cpu_relax();
> -	}
> -	return 0;
> -}
> -
> -static int acp3x_init(void __iomem *acp3x_base)
> -{
> -	int ret;
> -
> -	/* power on */
> -	ret = acp3x_power_on(acp3x_base, true);
> -	if (ret) {
> -		pr_err("ACP3x power on failed\n");
> -		return ret;
> -	}
> -	/* Reset */
> -	ret = acp3x_reset(acp3x_base);
> -	if (ret) {
> -		pr_err("ACP3x reset failed\n");
> -		return ret;
> -	}
> -	return 0;
> -}
> -
> -static int acp3x_deinit(void __iomem *acp3x_base)
> -{
> -	int ret;
> -
> -	/* Reset */
> -	ret = acp3x_reset(acp3x_base);
> -	if (ret) {
> -		pr_err("ACP3x reset failed\n");
> -		return ret;
> -	}
> -	/* power off */
> -	ret = acp3x_power_on(acp3x_base, false);
> -	if (ret) {
> -		pr_err("ACP3x power off failed\n");
> -		return ret;
> -	}
> -	return 0;
> -}
> -
>   static irqreturn_t i2s_irq_handler(int irq, void *dev_id)
>   {
>   	u16 play_flag, cap_flag;
> @@ -555,63 +455,37 @@ static int acp3x_audio_probe(struct platform_device *pdev)
>   	adata->i2ssp_capture_stream = NULL;
>   
>   	dev_set_drvdata(&pdev->dev, adata);
> -	/* Initialize ACP */
> -	status = acp3x_init(adata->acp3x_base);
> -	if (status)
> -		return -ENODEV;
>   	status = devm_snd_soc_register_component(&pdev->dev,
>   						 &acp3x_i2s_component,
>   						 NULL, 0);
>   	if (status) {
>   		dev_err(&pdev->dev, "Fail to register acp i2s component\n");
> -		goto dev_err;
> +		return -ENODEV;
>   	}
>   	status = devm_request_irq(&pdev->dev, adata->i2s_irq, i2s_irq_handler,
>   				  irqflags, "ACP3x_I2S_IRQ", adata);
>   	if (status) {
>   		dev_err(&pdev->dev, "ACP3x I2S IRQ request failed\n");
> -		goto dev_err;
> +		return -ENODEV;
>   	}
>   
>   	pm_runtime_set_autosuspend_delay(&pdev->dev, 10000);
>   	pm_runtime_use_autosuspend(&pdev->dev);
>   	pm_runtime_enable(&pdev->dev);
>   	return 0;
> -dev_err:
> -	status = acp3x_deinit(adata->acp3x_base);
> -	if (status)
> -		dev_err(&pdev->dev, "ACP de-init failed\n");
> -	else
> -		dev_info(&pdev->dev, "ACP de-initialized\n");
> -	/*ignore device status and return driver probe error*/
> -	return -ENODEV;
>   }
>   
>   static int acp3x_audio_remove(struct platform_device *pdev)
>   {
> -	int ret;
> -	struct i2s_dev_data *adata = dev_get_drvdata(&pdev->dev);
> -
> -	ret = acp3x_deinit(adata->acp3x_base);
> -	if (ret)
> -		dev_err(&pdev->dev, "ACP de-init failed\n");
> -	else
> -		dev_info(&pdev->dev, "ACP de-initialized\n");
> -
>   	pm_runtime_disable(&pdev->dev);
>   	return 0;
>   }
>   
>   static int acp3x_resume(struct device *dev)
>   {
> -	int status;
>   	u32 val;
>   	struct i2s_dev_data *adata = dev_get_drvdata(dev);
>   
> -	status = acp3x_init(adata->acp3x_base);
> -	if (status)
> -		return -ENODEV;
> -

So how is the init handled on resume?

>   	if (adata->play_stream && adata->play_stream->runtime) {
>   		struct i2s_stream_instance *rtd =
>   			adata->play_stream->runtime->private_data;
> @@ -656,15 +530,8 @@ static int acp3x_resume(struct device *dev)
>   
>   static int acp3x_pcm_runtime_suspend(struct device *dev)
>   {
> -	int status;
>   	struct i2s_dev_data *adata = dev_get_drvdata(dev);
>   
> -	status = acp3x_deinit(adata->acp3x_base);
> -	if (status)
> -		dev_err(dev, "ACP de-init failed\n");
> -	else
> -		dev_info(dev, "ACP de-initialized\n");
> -

same, this was removed and not applied below, so how is the deinit() 
handled on pm_runtime_suspend?

>   	rv_writel(0, adata->acp3x_base + mmACP_EXTERNAL_INTR_ENB);
>   
>   	return 0;
> @@ -672,12 +539,8 @@ static int acp3x_pcm_runtime_suspend(struct device *dev)
>   
>   static int acp3x_pcm_runtime_resume(struct device *dev)
>   {
> -	int status;
>   	struct i2s_dev_data *adata = dev_get_drvdata(dev);
>   
> -	status = acp3x_init(adata->acp3x_base);
> -	if (status)
> -		return -ENODEV;
>   	rv_writel(1, adata->acp3x_base + mmACP_EXTERNAL_INTR_ENB);
>   	return 0;
>   }
> diff --git a/sound/soc/amd/raven/acp3x.h b/sound/soc/amd/raven/acp3x.h
> index 01b283a..cf16ceb 100644
> --- a/sound/soc/amd/raven/acp3x.h
> +++ b/sound/soc/amd/raven/acp3x.h
> @@ -65,6 +65,13 @@
>   #define SLOT_WIDTH_16 0x10
>   #define SLOT_WIDTH_24 0x18
>   #define SLOT_WIDTH_32 0x20
> +#define ACP_PGFSM_CNTL_POWER_ON_MASK	0x01
> +#define ACP_PGFSM_CNTL_POWER_OFF_MASK	0x00
> +#define ACP_PGFSM_STATUS_MASK		0x03
> +#define ACP_POWERED_ON			0x00
> +#define ACP_POWER_ON_IN_PROGRESS	0x01
> +#define ACP_POWERED_OFF			0x02
> +#define ACP_POWER_OFF_IN_PROGRESS	0x03
>   
>   struct acp3x_platform_info {
>   	u16 play_i2s_instance;
> diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
> index ec3ef625..7727c9d 100644
> --- a/sound/soc/amd/raven/pci-acp3x.c
> +++ b/sound/soc/amd/raven/pci-acp3x.c
> @@ -19,6 +19,120 @@ struct acp3x_dev_data {
>   	struct platform_device *pdev[ACP3x_DEVS];
>   };
>   
> +static int acp3x_power_on(void __iomem *acp3x_base)
> +{
> +	u32 val;
> +	u32 timeout = 0;
> +	int ret = 0;
> +
> +	val = rv_readl(acp3x_base + mmACP_PGFSM_STATUS);
> +
> +	if (val == 0)
> +		return val;
> +
> +	if (!((val & ACP_PGFSM_STATUS_MASK) ==
> +				ACP_POWER_ON_IN_PROGRESS))
> +		rv_writel(ACP_PGFSM_CNTL_POWER_ON_MASK,
> +			acp3x_base + mmACP_PGFSM_CONTROL);
> +	while (++timeout < 500) {
> +		val  = rv_readl(acp3x_base + mmACP_PGFSM_STATUS);
> +		if (!val)
> +			break;
> +		udelay(1);
> +		if (timeout > 500) {
> +			pr_err("ACP is Not Powered ON\n");
> +			return -ETIMEDOUT;
> +		}
> +	}
> +}
> +
> +static int acp3x_power_off(void __iomem *acp3x_base)
> +{
> +	u32 val;
> +	u32 timeout = 0;
> +
> +	rv_writel(ACP_PGFSM_CNTL_POWER_OFF_MASK,
> +			acp3x_base + mmACP_PGFSM_CONTROL);
> +	while (++timeout < 500) {
> +		val  = rv_readl(acp3x_base + mmACP_PGFSM_STATUS);
> +		if ((val & ACP_PGFSM_STATUS_MASK) == ACP_POWERED_OFF)
> +			return 0;
> +		udelay(1);
> +		if (timeout > 500) {
> +			pr_err("ACP is Not Powered OFF\n");
> +			return -ETIMEDOUT;
> +		}
> +	}
> +}
> +
> +
> +static int acp3x_reset(void __iomem *acp3x_base)
> +{
> +	u32 val, timeout;
> +
> +	rv_writel(1, acp3x_base + mmACP_SOFT_RESET);
> +	timeout = 0;
> +	while (++timeout < 100) {
> +		val = rv_readl(acp3x_base + mmACP_SOFT_RESET);
> +		if ((val & ACP3x_SOFT_RESET__SoftResetAudDone_MASK) ||
> +							timeout > 100) {
> +			if (val & ACP3x_SOFT_RESET__SoftResetAudDone_MASK)
> +				break;
> +			return -ENODEV;
> +		}
> +		cpu_relax();
> +	}
> +	rv_writel(0, acp3x_base + mmACP_SOFT_RESET);
> +	timeout = 0;
> +	while (++timeout < 100) {
> +		val = rv_readl(acp3x_base + mmACP_SOFT_RESET);
> +		if (!val)
> +			break;
> +		if (timeout > 100)
> +			return -ENODEV;
> +		cpu_relax();
> +	}
> +	return 0;
> +}
> +
> +static int acp3x_init(void __iomem *acp3x_base)
> +{
> +	int ret;
> +
> +	/* power on */
> +	ret = acp3x_power_on(acp3x_base);
> +	if (ret) {
> +		pr_err("ACP3x power on failed\n");
> +		return ret;
> +	}
> +	/* Reset */
> +	ret = acp3x_reset(acp3x_base);
> +	if (ret) {
> +		pr_err("ACP3x reset failed\n");
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static int acp3x_deinit(void __iomem *acp3x_base)
> +{
> +	int ret;
> +
> +	/* Reset */
> +	ret = acp3x_reset(acp3x_base);
> +	if (ret) {
> +		pr_err("ACP3x reset failed\n");
> +		return ret;
> +	}
> +	/* power off */
> +	ret = acp3x_power_off(acp3x_base);
> +	if (ret) {
> +		pr_err("ACP3x power off failed\n");
> +		return ret;
> +	}
> +	return 0;
> +}
> +
>   static int snd_acp3x_probe(struct pci_dev *pci,
>   			   const struct pci_device_id *pci_id)
>   {
> @@ -63,6 +177,10 @@ static int snd_acp3x_probe(struct pci_dev *pci,
>   	}
>   	pci_set_master(pci);
>   	pci_set_drvdata(pci, adata);
> +	ret = acp3x_init(adata->acp3x_base);
> +	if (ret)
> +		return -ENODEV;
> +
>   
>   	val = rv_readl(adata->acp3x_base + mmACP_I2S_PIN_CONFIG);
>   	switch (val) {
> @@ -132,6 +250,11 @@ static int snd_acp3x_probe(struct pci_dev *pci,
>   	return 0;
>   
>   unmap_mmio:
> +	ret = acp3x_deinit(adata->acp3x_base);
> +	if (ret)
> +		dev_err(&pci->dev, "ACP de-init failed\n");
> +	else
> +		dev_info(&pci->dev, "ACP de-initialized\n");
>   	pci_disable_msi(pci);
>   	for (i = 0 ; i < ACP3x_DEVS ; i++)
>   		platform_device_unregister(adata->pdev[i]);
> @@ -147,13 +270,18 @@ static int snd_acp3x_probe(struct pci_dev *pci,
>   
>   static void snd_acp3x_remove(struct pci_dev *pci)
>   {
> -	int i;
> +	int i, ret;
>   	struct acp3x_dev_data *adata = pci_get_drvdata(pci);
>   
>   	if (adata->acp3x_audio_mode == ACP3x_I2S_MODE) {
>   		for (i = 0 ; i <  ACP3x_DEVS ; i++)
>   			platform_device_unregister(adata->pdev[i]);
>   	}
> +	ret = acp3x_deinit(adata->acp3x_base);
> +	if (ret)
> +		dev_err(&pci->dev, "ACP de-init failed\n");
> +	else
> +		dev_info(&pci->dev, "ACP de-initialized\n");
>   	iounmap(adata->acp3x_base);
>   
>   	pci_disable_msi(pci);
> 
