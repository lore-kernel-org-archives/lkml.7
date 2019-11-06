Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77F1C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4EC2166E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732321AbfKFQts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:49:48 -0500
Received: from mga07.intel.com ([134.134.136.100]:59016 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732216AbfKFQts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:49:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 08:49:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="285713476"
Received: from pdblomfi-mobl.gar.corp.intel.com (HELO [10.254.107.145]) ([10.254.107.145])
  by orsmga001.jf.intel.com with ESMTP; 06 Nov 2019 08:49:46 -0800
Subject: Re: [alsa-devel] [RESEND PATCH v2 1/7] ASoC: amd: Create multiple I2S
 platform device endpoints
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Akshu.Agrawal@amd.com,
        Sanju R Mehta <sanju.mehta@amd.com>,
        Mark Brown <broonie@kernel.org>, djkurtz@google.com,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <1573137364-5592-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1573137364-5592-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <64ac2908-1091-16ec-b25a-5ac2abc9c9a9@linux.intel.com>
Date:   Wed, 6 Nov 2019 10:24:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1573137364-5592-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/19 8:35 AM, Ravulapati Vishnu vardhan rao wrote:
> Creates Platform Device endpoints for multiple
> I2S instances: SP and  BT endpoints device.
> Pass PCI resources like MMIO, irq to the platform devices.
> 
> Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
> ---
>   sound/soc/amd/raven/acp3x.h     |  5 +++
>   sound/soc/amd/raven/pci-acp3x.c | 82 +++++++++++++++++++++++++++--------------
>   2 files changed, 60 insertions(+), 27 deletions(-)
> 
> diff --git a/sound/soc/amd/raven/acp3x.h b/sound/soc/amd/raven/acp3x.h
> index 4f2cadd..2f15fe1 100644
> --- a/sound/soc/amd/raven/acp3x.h
> +++ b/sound/soc/amd/raven/acp3x.h
> @@ -7,10 +7,15 @@
>   
>   #include "chip_offset_byte.h"
>   
> +#define ACP3x_DEVS		3
>   #define ACP3x_PHY_BASE_ADDRESS 0x1240000
>   #define	ACP3x_I2S_MODE	0
>   #define	ACP3x_REG_START	0x1240000
>   #define	ACP3x_REG_END	0x1250200
> +#define ACP3x_I2STDM_REG_START	0x1242400
> +#define ACP3x_I2STDM_REG_END	0x1242410
> +#define ACP3x_BT_TDM_REG_START	0x1242800
> +#define ACP3x_BT_TDM_REG_END	0x1242810
>   #define I2S_MODE	0x04
>   #define	BT_TX_THRESHOLD 26
>   #define	BT_RX_THRESHOLD 25
> diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
> index facec24..ec3ef625 100644
> --- a/sound/soc/amd/raven/pci-acp3x.c
> +++ b/sound/soc/amd/raven/pci-acp3x.c
> @@ -16,16 +16,16 @@ struct acp3x_dev_data {
>   	void __iomem *acp3x_base;
>   	bool acp3x_audio_mode;
>   	struct resource *res;
> -	struct platform_device *pdev;
> +	struct platform_device *pdev[ACP3x_DEVS];
>   };
>   
>   static int snd_acp3x_probe(struct pci_dev *pci,
>   			   const struct pci_device_id *pci_id)
>   {
>   	int ret;
> -	u32 addr, val;
> +	u32 addr, val, i;
>   	struct acp3x_dev_data *adata;
> -	struct platform_device_info pdevinfo;
> +	struct platform_device_info pdevinfo[ACP3x_DEVS];
>   	unsigned int irqflags;
>   
>   	if (pci_enable_device(pci)) {
> @@ -68,7 +68,7 @@ static int snd_acp3x_probe(struct pci_dev *pci,
>   	switch (val) {
>   	case I2S_MODE:
>   		adata->res = devm_kzalloc(&pci->dev,
> -					  sizeof(struct resource) * 2,
> +					  sizeof(struct resource) * 4,
>   					  GFP_KERNEL);
>   		if (!adata->res) {
>   			ret = -ENOMEM;
> @@ -80,39 +80,62 @@ static int snd_acp3x_probe(struct pci_dev *pci,
>   		adata->res[0].start = addr;
>   		adata->res[0].end = addr + (ACP3x_REG_END - ACP3x_REG_START);
>   
> -		adata->res[1].name = "acp3x_i2s_irq";
> -		adata->res[1].flags = IORESOURCE_IRQ;
> -		adata->res[1].start = pci->irq;
> -		adata->res[1].end = pci->irq;
> +		adata->res[1].name = "acp3x_i2s_sp";
> +		adata->res[1].flags = IORESOURCE_MEM;
> +		adata->res[1].start = addr + ACP3x_I2STDM_REG_START;
> +		adata->res[1].end = addr + ACP3x_I2STDM_REG_END;
> +
> +		adata->res[2].name = "acp3x_i2s_bt";
> +		adata->res[2].flags = IORESOURCE_MEM;
> +		adata->res[2].start = addr + ACP3x_BT_TDM_REG_START;
> +		adata->res[2].end = addr + ACP3x_BT_TDM_REG_END;
> +
> +		adata->res[3].name = "acp3x_i2s_irq";
> +		adata->res[3].flags = IORESOURCE_IRQ;
> +		adata->res[3].start = pci->irq;
> +		adata->res[3].end = adata->res[3].start;
>   
>   		adata->acp3x_audio_mode = ACP3x_I2S_MODE;
>   
>   		memset(&pdevinfo, 0, sizeof(pdevinfo));
> -		pdevinfo.name = "acp3x_rv_i2s";
> -		pdevinfo.id = 0;
> -		pdevinfo.parent = &pci->dev;
> -		pdevinfo.num_res = 2;
> -		pdevinfo.res = adata->res;
> -		pdevinfo.data = &irqflags;
> -		pdevinfo.size_data = sizeof(irqflags);
> -
> -		adata->pdev = platform_device_register_full(&pdevinfo);
> -		if (IS_ERR(adata->pdev)) {
> -			dev_err(&pci->dev, "cannot register %s device\n",
> -				pdevinfo.name);
> -			ret = PTR_ERR(adata->pdev);
> -			goto unmap_mmio;
> +		pdevinfo[0].name = "acp3x_rv_i2s_dma";
> +		pdevinfo[0].id = 0;
> +		pdevinfo[0].parent = &pci->dev;
> +		pdevinfo[0].num_res = 4;
> +		pdevinfo[0].res = &adata->res[0];
> +		pdevinfo[0].data = &irqflags;
> +		pdevinfo[0].size_data = sizeof(irqflags);
> +
> +		pdevinfo[1].name = "acp3x_i2s_playcap";
> +		pdevinfo[1].id = 0;
> +		pdevinfo[1].parent = &pci->dev;
> +		pdevinfo[1].num_res = 1;
> +		pdevinfo[1].res = &adata->res[1];
> +
> +		pdevinfo[2].name = "acp3x_i2s_playcap";
> +		pdevinfo[2].id = 1;
> +		pdevinfo[2].parent = &pci->dev;
> +		pdevinfo[2].num_res = 1;
> +		pdevinfo[2].res = &adata->res[2];
> +		for (i = 0; i < ACP3x_DEVS ; i++) {
> +			adata->pdev[i] =
> +				platform_device_register_full(&pdevinfo[i]);
> +			if (adata->pdev[i] == NULL) {

should be IS_ERR(adata->pdev[i])

> +				dev_err(&pci->dev, "cannot register %s device\n",
> +					pdevinfo[i].name);
> +				ret = -ENODEV;
> +				goto unmap_mmio;
> +			}
>   		}
>   		break;
> -	default:
> -		dev_err(&pci->dev, "Invalid ACP audio mode : %d\n", val);
> -		ret = -ENODEV;
> -		goto unmap_mmio;
>   	}
>   	return 0;
>   
>   unmap_mmio:
>   	pci_disable_msi(pci);
> +	for (i = 0 ; i < ACP3x_DEVS ; i++)
> +		platform_device_unregister(adata->pdev[i]);
> +	kfree(adata->res);

You should revisit the labels, in the default case you haven't allocated 
any memory

>   	iounmap(adata->acp3x_base);
>   release_regions:
>   	pci_release_regions(pci);
> @@ -124,9 +147,13 @@ static int snd_acp3x_probe(struct pci_dev *pci,
>   
>   static void snd_acp3x_remove(struct pci_dev *pci)
>   {
> +	int i;
>   	struct acp3x_dev_data *adata = pci_get_drvdata(pci);
>   
> -	platform_device_unregister(adata->pdev);
> +	if (adata->acp3x_audio_mode == ACP3x_I2S_MODE) {
> +		for (i = 0 ; i <  ACP3x_DEVS ; i++)
> +			platform_device_unregister(adata->pdev[i]);
> +	}
>   	iounmap(adata->acp3x_base);
>   
>   	pci_disable_msi(pci);
> @@ -151,6 +178,7 @@ static struct pci_driver acp3x_driver  = {
>   
>   module_pci_driver(acp3x_driver);
>   
> +MODULE_AUTHOR("Vishnuvardhanrao.Ravulapati@amd.com");
>   MODULE_AUTHOR("Maruthi.Bayyavarapu@amd.com");
>   MODULE_DESCRIPTION("AMD ACP3x PCI driver");
>   MODULE_LICENSE("GPL v2");
> 
