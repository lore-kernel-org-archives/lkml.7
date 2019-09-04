Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97A9C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE63F2341E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567581762;
	bh=x6bRQXtE+JuINtFNse5ZrkGOp3vWHxjVq//MaaJDsH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HNgjTxZU7z3j/Pzu/1Z3eqt35Dy5n5b+MRn86HP7YkjseVsl8DDrHZfLcOSguZgJR
	 V93xOum+RTPM9xi0x0w6QhF3SLHGyIaDnJK3iidgmMs59VduI6+O4pOjfB+97738pV
	 0DdGXSiWACmzFOPZJESJWdDhC95IVb3zDOyYxldQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfIDHWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 03:22:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfIDHWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:22:41 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89E3E23402;
        Wed,  4 Sep 2019 07:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567581760;
        bh=x6bRQXtE+JuINtFNse5ZrkGOp3vWHxjVq//MaaJDsH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y0KAzybOASAf9aiT777mX8X2qRWKoYVns4JaOMKfOQ6yz2uD5WDOz/S8r3Rt4QWbN
         ivIguFUliKCQmQHzd+JsEUtCGAeeWVpx8ZBs7rPLspzJO5uyWMeffVR4qDtHE3AV7A
         CW5RI/OV7L0J6wQ44dO2//RR542gdkKHyJbck8J8=
Date:   Wed, 4 Sep 2019 12:51:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Pan Xiuli <xiuli.pan@linux.intel.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [RFC PATCH 3/5] ASoC: SOF: Intel: hda: add SoundWire IP support
Message-ID: <20190904072131.GK2672@vkoul-mobl>
References: <20190821201720.17768-1-pierre-louis.bossart@linux.intel.com>
 <20190821201720.17768-4-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821201720.17768-4-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-08-19, 15:17, Pierre-Louis Bossart wrote:
> The Core0 needs to be powered before the SoundWire IP is initialized.
> 
> Call sdw_intel_init/exit and store the context. We only have one
> context, but depending on the hardware capabilities and BIOS settings
> may enable multiple SoundWire links.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  sound/soc/sof/intel/hda.c | 40 +++++++++++++++++++++++++++++++++------
>  sound/soc/sof/intel/hda.h |  5 +++++
>  2 files changed, 39 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
> index a968890d0754..e754058e3679 100644
> --- a/sound/soc/sof/intel/hda.c
> +++ b/sound/soc/sof/intel/hda.c
> @@ -57,6 +57,8 @@ static int hda_sdw_init(struct snd_sof_dev *sdev)
>  {
>  	acpi_handle handle;
>  	struct sdw_intel_res res;
> +	struct sof_intel_hda_dev *hdev;
> +	void *sdw;
>  
>  	handle = ACPI_HANDLE(sdev->dev);
>  
> @@ -66,23 +68,32 @@ static int hda_sdw_init(struct snd_sof_dev *sdev)
>  	res.irq = sdev->ipc_irq;
>  	res.parent = sdev->dev;
>  
> -	hda_sdw_int_enable(sdev, true);
> -
> -	sdev->sdw = sdw_intel_init(handle, &res);
> -	if (!sdev->sdw) {
> +	sdw = sdw_intel_init(handle, &res);

should this be called for platforms without sdw, I was hoping that some
checks would be performed.. For example how would skl deal with this?

> +	if (!sdw) {
>  		dev_err(sdev->dev, "SDW Init failed\n");
>  		return -EIO;
>  	}
>  
> +	hda_sdw_int_enable(sdev, true);
> +
> +	/* save context */
> +	hdev = sdev->pdata->hw_pdata;
> +	hdev->sdw = sdw;
> +
>  	return 0;
>  }
>  
>  static int hda_sdw_exit(struct snd_sof_dev *sdev)
>  {
> +	struct sof_intel_hda_dev *hdev;
> +
> +	hdev = sdev->pdata->hw_pdata;
> +
>  	hda_sdw_int_enable(sdev, false);
>  
> -	if (sdev->sdw)
> -		sdw_intel_exit(sdev->sdw);

this looks suspect, you are adding sdw calls here so how is this getting
removed? Did I miss something...

> +	if (hdev->sdw)
> +		sdw_intel_exit(hdev->sdw);
> +	hdev->sdw = NULL;
>  
>  	return 0;
>  }
> @@ -713,6 +724,21 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
>  	/* set default mailbox offset for FW ready message */
>  	sdev->dsp_box.offset = HDA_DSP_MBOX_UPLINK_OFFSET;
>  
> +	/* need to power-up core before setting-up capabilities */
> +	ret = hda_dsp_core_power_up(sdev, HDA_DSP_CORE_MASK(0));
> +	if (ret < 0) {
> +		dev_err(sdev->dev, "error: could not power-up DSP subsystem\n");
> +		goto free_ipc_irq;
> +	}
> +
> +	/* initialize SoundWire capabilities */
> +	ret = hda_sdw_init(sdev);
> +	if (ret < 0) {
> +		dev_err(sdev->dev, "error: SoundWire get caps error\n");
> +		hda_dsp_core_power_down(sdev, HDA_DSP_CORE_MASK(0));
> +		goto free_ipc_irq;
> +	}
> +
>  	return 0;
>  
>  free_ipc_irq:
> @@ -744,6 +770,8 @@ int hda_dsp_remove(struct snd_sof_dev *sdev)
>  	snd_hdac_ext_bus_device_remove(bus);
>  #endif
>  
> +	hda_sdw_exit(sdev);
> +
>  	if (!IS_ERR_OR_NULL(hda->dmic_dev))
>  		platform_device_unregister(hda->dmic_dev);
>  
> diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
> index c8f93317aeb4..48e09b7daf0a 100644
> --- a/sound/soc/sof/intel/hda.h
> +++ b/sound/soc/sof/intel/hda.h
> @@ -399,6 +399,11 @@ struct sof_intel_hda_dev {
>  
>  	/* DMIC device */
>  	struct platform_device *dmic_dev;
> +
> +#if IS_ENABLED(CONFIG_SOUNDWIRE_INTEL)

is this really required, context is a void pointer

> +	/* sdw context */
> +	void *sdw;

> +#endif
>  };
>  
>  static inline struct hdac_bus *sof_to_bus(struct snd_sof_dev *s)
> -- 
> 2.20.1

-- 
~Vinod
