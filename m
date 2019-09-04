Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45C8C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839062168B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbfIDNZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 09:25:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:3279 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727900AbfIDNZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 09:25:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 06:25:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="212390886"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 04 Sep 2019 06:25:51 -0700
Received: from ravisha1-mobl1.amr.corp.intel.com (unknown [10.255.36.89])
        by linux.intel.com (Postfix) with ESMTP id 4EF17580105;
        Wed,  4 Sep 2019 06:25:48 -0700 (PDT)
Subject: Re: [alsa-devel] [RFC PATCH 3/5] ASoC: SOF: Intel: hda: add SoundWire
 IP support
To:     Vinod Koul <vkoul@kernel.org>
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
References: <20190821201720.17768-1-pierre-louis.bossart@linux.intel.com>
 <20190821201720.17768-4-pierre-louis.bossart@linux.intel.com>
 <20190904072131.GK2672@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <1897e21f-b086-8233-e96e-6024e75a2153@linux.intel.com>
Date:   Wed, 4 Sep 2019 08:25:47 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904072131.GK2672@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/19 2:21 AM, Vinod Koul wrote:
> On 21-08-19, 15:17, Pierre-Louis Bossart wrote:
>> The Core0 needs to be powered before the SoundWire IP is initialized.
>>
>> Call sdw_intel_init/exit and store the context. We only have one
>> context, but depending on the hardware capabilities and BIOS settings
>> may enable multiple SoundWire links.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   sound/soc/sof/intel/hda.c | 40 +++++++++++++++++++++++++++++++++------
>>   sound/soc/sof/intel/hda.h |  5 +++++
>>   2 files changed, 39 insertions(+), 6 deletions(-)
>>
>> diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
>> index a968890d0754..e754058e3679 100644
>> --- a/sound/soc/sof/intel/hda.c
>> +++ b/sound/soc/sof/intel/hda.c
>> @@ -57,6 +57,8 @@ static int hda_sdw_init(struct snd_sof_dev *sdev)
>>   {
>>   	acpi_handle handle;
>>   	struct sdw_intel_res res;
>> +	struct sof_intel_hda_dev *hdev;
>> +	void *sdw;
>>   
>>   	handle = ACPI_HANDLE(sdev->dev);
>>   
>> @@ -66,23 +68,32 @@ static int hda_sdw_init(struct snd_sof_dev *sdev)
>>   	res.irq = sdev->ipc_irq;
>>   	res.parent = sdev->dev;
>>   
>> -	hda_sdw_int_enable(sdev, true);
>> -
>> -	sdev->sdw = sdw_intel_init(handle, &res);
>> -	if (!sdev->sdw) {
>> +	sdw = sdw_intel_init(handle, &res);
> 
> should this be called for platforms without sdw, I was hoping that some
> checks would be performed.. For example how would skl deal with this?

Good point. For now we rely on CONFIG_SOUNDWIRE_INTEL to use a fallback, 
but if the kernel defines this config and we run on an older platform 
the only safety would be the hardware capabilities and BIOS 
dependencies, I need to test if it works.
Thanks for the feedback.

> 
>> +	if (!sdw) {
>>   		dev_err(sdev->dev, "SDW Init failed\n");
>>   		return -EIO;
>>   	}
>>   
>> +	hda_sdw_int_enable(sdev, true);
>> +
>> +	/* save context */
>> +	hdev = sdev->pdata->hw_pdata;
>> +	hdev->sdw = sdw;
>> +
>>   	return 0;
>>   }
>>   
>>   static int hda_sdw_exit(struct snd_sof_dev *sdev)
>>   {
>> +	struct sof_intel_hda_dev *hdev;
>> +
>> +	hdev = sdev->pdata->hw_pdata;
>> +
>>   	hda_sdw_int_enable(sdev, false);
>>   
>> -	if (sdev->sdw)
>> -		sdw_intel_exit(sdev->sdw);
> 
> this looks suspect, you are adding sdw calls here so how is this getting
> removed? Did I miss something...

That must be a squash/tick-tock error, we moved the 'sdw' field from the 
top-level 'sdev' structure to an intel-specific one. In the latest code 
I have a single patch to add the helper and all dependencies in one shot.

> 
>> +	if (hdev->sdw)
>> +		sdw_intel_exit(hdev->sdw);
>> +	hdev->sdw = NULL;
>>   
>>   	return 0;
>>   }
>> @@ -713,6 +724,21 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
>>   	/* set default mailbox offset for FW ready message */
>>   	sdev->dsp_box.offset = HDA_DSP_MBOX_UPLINK_OFFSET;
>>   
>> +	/* need to power-up core before setting-up capabilities */
>> +	ret = hda_dsp_core_power_up(sdev, HDA_DSP_CORE_MASK(0));
>> +	if (ret < 0) {
>> +		dev_err(sdev->dev, "error: could not power-up DSP subsystem\n");
>> +		goto free_ipc_irq;
>> +	}
>> +
>> +	/* initialize SoundWire capabilities */
>> +	ret = hda_sdw_init(sdev);
>> +	if (ret < 0) {
>> +		dev_err(sdev->dev, "error: SoundWire get caps error\n");
>> +		hda_dsp_core_power_down(sdev, HDA_DSP_CORE_MASK(0));
>> +		goto free_ipc_irq;
>> +	}
>> +
>>   	return 0;
>>   
>>   free_ipc_irq:
>> @@ -744,6 +770,8 @@ int hda_dsp_remove(struct snd_sof_dev *sdev)
>>   	snd_hdac_ext_bus_device_remove(bus);
>>   #endif
>>   
>> +	hda_sdw_exit(sdev);
>> +
>>   	if (!IS_ERR_OR_NULL(hda->dmic_dev))
>>   		platform_device_unregister(hda->dmic_dev);
>>   
>> diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
>> index c8f93317aeb4..48e09b7daf0a 100644
>> --- a/sound/soc/sof/intel/hda.h
>> +++ b/sound/soc/sof/intel/hda.h
>> @@ -399,6 +399,11 @@ struct sof_intel_hda_dev {
>>   
>>   	/* DMIC device */
>>   	struct platform_device *dmic_dev;
>> +
>> +#if IS_ENABLED(CONFIG_SOUNDWIRE_INTEL)
> 
> is this really required, context is a void pointer
> 
>> +	/* sdw context */
>> +	void *sdw;
> 
>> +#endif
>>   };
>>   
>>   static inline struct hdac_bus *sof_to_bus(struct snd_sof_dev *s)
>> -- 
>> 2.20.1
> 

