Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512D1C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BABD2166E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732335AbfKFQxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:53:01 -0500
Received: from mga03.intel.com ([134.134.136.65]:52065 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727824AbfKFQw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:52:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 08:52:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="353532513"
Received: from pdblomfi-mobl.gar.corp.intel.com (HELO [10.254.107.145]) ([10.254.107.145])
  by orsmga004.jf.intel.com with ESMTP; 06 Nov 2019 08:52:58 -0800
Subject: Re: [alsa-devel] [RESEND PATCH v2 7/7] ASoC: amd: Added ACP3x system
 resume and runtime pm ops
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Akshu.Agrawal@amd.com,
        Mark Brown <broonie@kernel.org>, djkurtz@google.com,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <1573137364-5592-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1573137364-5592-8-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c30bea61-8db4-fb7a-bead-c665f88b3091@linux.intel.com>
Date:   Wed, 6 Nov 2019 10:43:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1573137364-5592-8-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/19 8:36 AM, Ravulapati Vishnu vardhan rao wrote:
> When system wide suspend happens, ACP will be powered off
> and when system resumes,for audio usecase to continue,
> all the runtime configuration data needs to be programmed again.
> Added resume pm call back to ACP pm ops and
> also Added runtime PM operations for ACP3x PCM platform device.
> Device will enter into D3 state when there is no activity
> on audio I2S lines.

spaces after punctuation and use of capital letters at the start of a 
sentence?

> 
> Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
> ---
>   sound/soc/amd/raven/pci-acp3x.c | 47 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
> index 7727c9d..d567585 100644
> --- a/sound/soc/amd/raven/pci-acp3x.c
> +++ b/sound/soc/amd/raven/pci-acp3x.c
> @@ -9,6 +9,9 @@
>   #include <linux/io.h>
>   #include <linux/platform_device.h>
>   #include <linux/interrupt.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/delay.h>
> +#include <sound/pcm.h>
>   
>   #include "acp3x.h"
>   
> @@ -247,6 +250,11 @@ static int snd_acp3x_probe(struct pci_dev *pci,
>   		}
>   		break;
>   	}
> +	pm_runtime_set_autosuspend_delay(&pci->dev, 10000);
> +	pm_runtime_use_autosuspend(&pci->dev);
> +	pm_runtime_set_active(&pci->dev);
> +	pm_runtime_put_noidle(&pci->dev);
> +	pm_runtime_enable(&pci->dev);
>   	return 0;
>   
>   unmap_mmio:
> @@ -268,6 +276,39 @@ static int snd_acp3x_probe(struct pci_dev *pci,
>   	return ret;
>   }
>   
> +static int  snd_acp3x_suspend(struct device *dev)
> +{
> +	int status;
> +	struct acp3x_dev_data *adata = dev_get_drvdata(dev);
> +
> +	status = acp3x_deinit(adata->acp3x_base);
> +	if (status)
> +		dev_err(dev, "ACP de-init failed\n");
> +	else
> +		dev_info(dev, "ACP de-initialized\n");
> +
> +	return 0;
> +}
> +static int  snd_acp3x_resume(struct device *dev)
> +{
> +	int status;
> +	struct acp3x_dev_data *adata = dev_get_drvdata(dev);
> +
> +	status = acp3x_init(adata->acp3x_base);
> +	if (status) {
> +		dev_err(dev, "ACP init failed\n");
> +		return status;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops acp3x_pm = {
> +	.runtime_suspend = snd_acp3x_suspend,
> +	.runtime_resume =  snd_acp3x_resume,
> +	.resume =       snd_acp3x_resume,
> +};

that should have been combined with the previous patch, you resume inits 
in the platform device resume and only add it to the PCI level here.

> +
>   static void snd_acp3x_remove(struct pci_dev *pci)
>   {
>   	int i, ret;
> @@ -283,7 +324,8 @@ static void snd_acp3x_remove(struct pci_dev *pci)
>   	else
>   		dev_info(&pci->dev, "ACP de-initialized\n");
>   	iounmap(adata->acp3x_base);
> -
> +	pm_runtime_disable(&pci->dev);
> +	pm_runtime_get_noresume(&pci->dev);
>   	pci_disable_msi(pci);
>   	pci_release_regions(pci);
>   	pci_disable_device(pci);
> @@ -302,6 +344,9 @@ static struct pci_driver acp3x_driver  = {
>   	.id_table = snd_acp3x_ids,
>   	.probe = snd_acp3x_probe,
>   	.remove = snd_acp3x_remove,
> +	.driver = {
> +		.pm = &acp3x_pm,
> +	}
>   };
>   
>   module_pci_driver(acp3x_driver);
> 
