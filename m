Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C14C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F416F206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfDZVDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 17:03:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:10143 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbfDZVDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 17:03:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Apr 2019 14:03:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,398,1549958400"; 
   d="scan'208";a="137799602"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 26 Apr 2019 14:03:49 -0700
Received: from ctrainor-mobl.amr.corp.intel.com (unknown [10.251.135.25])
        by linux.intel.com (Postfix) with ESMTP id 4B9F85803C2;
        Fri, 26 Apr 2019 14:03:48 -0700 (PDT)
Subject: Re: [PATCH] ASoC: Intel: avoid Oops if DMA setup fails
To:     Ross Zwisler <zwisler@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, stable@vger.kernel.org
References: <20190426164740.211139-1-zwisler@google.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <0b030b85-00c8-2e35-3064-bb764aaff0f6@linux.intel.com>
Date:   Fri, 26 Apr 2019 16:03:47 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190426164740.211139-1-zwisler@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/19 11:47 AM, Ross Zwisler wrote:
> Currently in sst_dsp_new() if we get an error return from sst_dma_new()
> we just print an error message and then still complete the function
> successfully.  This means that we are trying to run without sst->dma
> properly set up, which will result in NULL pointer dereference when
> sst->dma is later used.  This was happening for me in
> sst_dsp_dma_get_channel():
> 
>          struct sst_dma *dma = dsp->dma;
> 	...
>          dma->ch = dma_request_channel(mask, dma_chan_filter, dsp);
> 
> This resulted in:
> 
>     BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
>     IP: sst_dsp_dma_get_channel+0x4f/0x125 [snd_soc_sst_firmware]
> 
> Fix this by adding proper error handling for the case where we fail to
> set up DMA.
> 
> Signed-off-by: Ross Zwisler <zwisler@google.com>
> Cc: stable@vger.kernel.org
> ---
>   sound/soc/intel/common/sst-firmware.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/common/sst-firmware.c b/sound/soc/intel/common/sst-firmware.c
> index 1e067504b6043..9be3a793a55e3 100644
> --- a/sound/soc/intel/common/sst-firmware.c
> +++ b/sound/soc/intel/common/sst-firmware.c
> @@ -1251,11 +1251,15 @@ struct sst_dsp *sst_dsp_new(struct device *dev,
>   		goto irq_err;
>   
>   	err = sst_dma_new(sst);
> -	if (err)
> +	if (err)  {
>   		dev_warn(dev, "sst_dma_new failed %d\n", err);
> +		goto dma_err;
> +	}

Thanks for the patch.
The fix looks correct, but does it make sense to keep a dev_warn() here? 
Should it be changed to dev_err() instead since as you mentioned it's 
fatal to keep going.
Also you may want to mention in the commit message that this should only 
impact Broadwell and maybe the legacy Baytrail driver. IIRC we don't use 
the DMAs in other cases.

>   
>   	return sst;
>   
> +dma_err:
> +	free_irq(sst->irq, sst);
>   irq_err:
>   	if (sst->ops->free)
>   		sst->ops->free(sst);
> 

