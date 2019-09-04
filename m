Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEDFC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29DB721670
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731866AbfIDRrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:47:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:21092 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfIDRrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:47:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 10:47:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="194814201"
Received: from enagase-mobl1.amr.corp.intel.com (HELO [10.251.133.230]) ([10.251.133.230])
  by orsmga002.jf.intel.com with ESMTP; 04 Sep 2019 10:47:44 -0700
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
 <1897e21f-b086-8233-e96e-6024e75a2153@linux.intel.com>
 <20190904165129.GB2672@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <785cce2e-febe-3bbd-7590-32943fe7ac99@linux.intel.com>
Date:   Wed, 4 Sep 2019 12:47:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904165129.GB2672@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/19 11:51 AM, Vinod Koul wrote:
> On 04-09-19, 08:25, Pierre-Louis Bossart wrote:
>> On 9/4/19 2:21 AM, Vinod Koul wrote:
>>> On 21-08-19, 15:17, Pierre-Louis Bossart wrote:
>>>> The Core0 needs to be powered before the SoundWire IP is initialized.
>>>>
>>>> Call sdw_intel_init/exit and store the context. We only have one
>>>> context, but depending on the hardware capabilities and BIOS settings
>>>> may enable multiple SoundWire links.
>>>>
>>>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>>> ---
>>>>    sound/soc/sof/intel/hda.c | 40 +++++++++++++++++++++++++++++++++------
>>>>    sound/soc/sof/intel/hda.h |  5 +++++
>>>>    2 files changed, 39 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
>>>> index a968890d0754..e754058e3679 100644
>>>> --- a/sound/soc/sof/intel/hda.c
>>>> +++ b/sound/soc/sof/intel/hda.c
>>>> @@ -57,6 +57,8 @@ static int hda_sdw_init(struct snd_sof_dev *sdev)
>>>>    {
>>>>    	acpi_handle handle;
>>>>    	struct sdw_intel_res res;
>>>> +	struct sof_intel_hda_dev *hdev;
>>>> +	void *sdw;
>>>>    	handle = ACPI_HANDLE(sdev->dev);
>>>> @@ -66,23 +68,32 @@ static int hda_sdw_init(struct snd_sof_dev *sdev)
>>>>    	res.irq = sdev->ipc_irq;
>>>>    	res.parent = sdev->dev;
>>>> -	hda_sdw_int_enable(sdev, true);
>>>> -
>>>> -	sdev->sdw = sdw_intel_init(handle, &res);
>>>> -	if (!sdev->sdw) {
>>>> +	sdw = sdw_intel_init(handle, &res);
>>>
>>> should this be called for platforms without sdw, I was hoping that some
>>> checks would be performed.. For example how would skl deal with this?
>>
>> Good point. For now we rely on CONFIG_SOUNDWIRE_INTEL to use a fallback, but
>> if the kernel defines this config and we run on an older platform the only
>> safety would be the hardware capabilities and BIOS dependencies, I need to
>> test if it works.
> 
> Yes I am not sure given the experience with BIOS relying on that is a
> great idea ! But if that works, that would be better.

I don't think it's going to be that bad, first we need to find the ACPI 
description for the controller, then see which links are active, and 
even with all links disabled nothing bad will happen.

What I am more worried about are inconsistencies where e.g we have both 
I2C/I2S and SoundWire devices exposed at the same time. The BIOS deals 
with this with dynamic changes depending on user changes, and we are 
likely to see reports of problems due to BIOS configuration selection, 
not the BIOS itself.
