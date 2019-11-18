Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EA0C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 15:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA7520857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 15:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfKRPpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 10:45:25 -0500
Received: from mga09.intel.com ([134.134.136.24]:37583 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbfKRPpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 10:45:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 07:45:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,320,1569308400"; 
   d="scan'208";a="289292868"
Received: from nmdeliwa-mobl1.amr.corp.intel.com (HELO [10.251.155.92]) ([10.251.155.92])
  by orsmga001.jf.intel.com with ESMTP; 18 Nov 2019 07:45:22 -0800
Subject: Re: [alsa-devel] [PATCH v7 1/6] ASoC: amd:Create multiple I2S
 platform device endpoint
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Akshu.Agrawal@amd.com,
        Mark Brown <broonie@kernel.org>, djkurtz@google.com,
        Alexander.Deucher@amd.com, Dan Carpenter <dan.carpenter@oracle.com>
References: <1574085861-22818-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1574085861-22818-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6c389fa0-a0a0-a79e-f63e-10e3616962be@linux.intel.com>
Date:   Mon, 18 Nov 2019 09:40:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1574085861-22818-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>   static int snd_acp3x_probe(struct pci_dev *pci,
>   			   const struct pci_device_id *pci_id)
>   {
> -	int ret;
> -	u32 addr, val;
>   	struct acp3x_dev_data *adata;
> -	struct platform_device_info pdevinfo;
> +	struct platform_device_info pdevinfo[ACP3x_DEVS];
>   	unsigned int irqflags;
> +	int ret, val, i;
> +	u32 addr;
>   
>   	if (pci_enable_device(pci)) {

if you are using devm_ across the board then you could also use 
pcim_enable_device() here?

>   		dev_err(&pci->dev, "pci_enable_device failed\n");
> @@ -40,10 +40,10 @@ static int snd_acp3x_probe(struct pci_dev *pci,
>   	}
>   
>   	adata = devm_kzalloc(&pci->dev, sizeof(struct acp3x_dev_data),
> -			     GFP_KERNEL);
> +							     GFP_KERNEL);
>   	if (!adata) {
>   		ret = -ENOMEM;
> -		goto release_regions;
> +		goto adata_free;
>   	}
>   
>   	/* check for msi interrupt support */
> @@ -56,7 +56,8 @@ static int snd_acp3x_probe(struct pci_dev *pci,
>   		irqflags = 0;
>   
>   	addr = pci_resource_start(pci, 0);
> -	adata->acp3x_base = ioremap(addr, pci_resource_len(pci, 0));
> +	adata->acp3x_base = devm_ioremap(&pci->dev, addr,
> +					pci_resource_len(pci, 0));
>   	if (!adata->acp3x_base) {
>   		ret = -ENOMEM;
>   		goto release_regions;
> @@ -68,11 +69,11 @@ static int snd_acp3x_probe(struct pci_dev *pci,
>   	switch (val) {
>   	case I2S_MODE:
>   		adata->res = devm_kzalloc(&pci->dev,
> -					  sizeof(struct resource) * 2,
> +					  sizeof(struct resource) * 4,
>   					  GFP_KERNEL);
>   		if (!adata->res) {
>   			ret = -ENOMEM;
> -			goto unmap_mmio;
> +			goto release_regions;
>   		}
>   
>   		adata->res[0].name = "acp3x_i2s_iomem";
> @@ -80,28 +81,52 @@ static int snd_acp3x_probe(struct pci_dev *pci,
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
> +			if (IS_ERR(adata->pdev[i])) {
> +				dev_err(&pci->dev, "cannot register %s device\n",
> +					pdevinfo[i].name);
> +				ret = PTR_ERR(adata->pdev[i]);
> +				goto unmap_mmio;
> +			}
>   		}
>   		break;
>   	default:
> @@ -112,10 +137,22 @@ static int snd_acp3x_probe(struct pci_dev *pci,
>   	return 0;
>   
>   unmap_mmio:
> +	if (val == I2S_MODE)
> +		for (i = 0 ; i < ACP3x_DEVS ; i++)
> +			platform_device_unregister(adata->pdev[i]);
> +	devm_kfree(&pci->dev, adata->res);
> +	devm_kfree(&pci->dev, adata);
>   	pci_disable_msi(pci);
> -	iounmap(adata->acp3x_base);
> +	pci_release_regions(pci);
> +	pci_disable_device(pci);
>   release_regions:
> +	devm_kfree(&pci->dev, adata);
> +	pci_disable_msi(pci);
>   	pci_release_regions(pci);
> +	pci_disable_device(pci);
> +adata_free:
> +	pci_release_regions(pci);
> +	pci_disable_device(pci);
>   disable_pci:
>   	pci_disable_device(pci);

this error flow is probably wrong, you should not repeat the same 
sequences when going from one label to the other.

it should be something like (not verified, example only)

	devm_kfree(&pci->dev, adata->res);
release_regions:
	devm_kfree(&pci->dev, adata);
    	pci_disable_msi(pci);
adata_free:
	pci_release_regions(pci);
disable_pci:
	pci_disable_device(pci);

Stopping the review here.

