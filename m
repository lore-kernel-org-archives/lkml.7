Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CC3C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823B020882
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfEJQYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 12:24:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:12612 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727812AbfEJQYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 12:24:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 09:24:20 -0700
X-ExtLoop1: 1
Received: from bgtruong-mobl1.amr.corp.intel.com (HELO [10.252.205.232]) ([10.252.205.232])
  by fmsmga007.fm.intel.com with ESMTP; 10 May 2019 09:24:19 -0700
Subject: Re: [PATCH V2] ASoC: SOF: Fix build error with
 CONFIG_SND_SOC_SOF_NOCODEC=m
To:     YueHaibing <yuehaibing@huawei.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20190510023657.8960-1-yuehaibing@huawei.com>
 <20190510132940.28184-1-yuehaibing@huawei.com>
 <9284cd65-98e3-5f7e-1427-8245dd84edcd@linux.intel.com>
 <34a5afbc-c165-78aa-0269-7362b523195a@huawei.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <fc8fa6ea-b32c-0866-cc96-1cee2e2baae1@linux.intel.com>
Date:   Fri, 10 May 2019 11:24:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <34a5afbc-c165-78aa-0269-7362b523195a@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/19 8:50 AM, YueHaibing wrote:
> On 2019/5/10 21:36, Pierre-Louis Bossart wrote:
>> On 5/10/19 8:29 AM, YueHaibing wrote:
>>> Fix gcc build error while CONFIG_SND_SOC_SOF_NOCODEC=m
>>>
>>> sound/soc/sof/core.o: In function `snd_sof_device_probe':
>>> core.c:(.text+0x4af): undefined reference to `sof_nocodec_setup'
>>>
>>> Change IS_ENABLED to IS_REACHABLE to fix this.
>>
>> this just hides the issue instead of fixing it.
>> please send the config+sha1 so that we can check.
> 
> Sure,  config sha1 5fdc79b550c1d850eee604aa58bad4d6da9223f0

Indeed there is an issue. will send a patch shortly to alsa-devel.
Thanks for spotting this.

> 
>>
>>>
>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>> Suggested-by: Takashi Iwai <tiwai@suse.de>
>>> Fixes: c16211d6226d ("ASoC: SOF: Add Sound Open Firmware driver core")
>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>> ---
>>> V2: use IS_REACHABLE
>>> ---
>>>    sound/soc/sof/core.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
>>> index 32105e0..38e22f4 100644
>>> --- a/sound/soc/sof/core.c
>>> +++ b/sound/soc/sof/core.c
>>> @@ -259,7 +259,7 @@ int snd_sof_create_page_table(struct snd_sof_dev *sdev,
>>>    static int sof_machine_check(struct snd_sof_dev *sdev)
>>>    {
>>>        struct snd_sof_pdata *plat_data = sdev->pdata;
>>> -#if IS_ENABLED(CONFIG_SND_SOC_SOF_NOCODEC)
>>> +#if IS_REACHABLE(CONFIG_SND_SOC_SOF_NOCODEC)
>>>        struct snd_soc_acpi_mach *machine;
>>>        int ret;
>>>    #endif
>>> @@ -267,7 +267,7 @@ static int sof_machine_check(struct snd_sof_dev *sdev)
>>>        if (plat_data->machine)
>>>            return 0;
>>>    -#if !IS_ENABLED(CONFIG_SND_SOC_SOF_NOCODEC)
>>> +#if !IS_REACHABLE(CONFIG_SND_SOC_SOF_NOCODEC)
>>>        dev_err(sdev->dev, "error: no matching ASoC machine driver found - aborting probe\n");
>>>        return -ENODEV;
>>>    #else
>>>
>>
>>
>> .
>>
