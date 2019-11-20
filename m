Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A25EC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195F2206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732688AbfKTQKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 11:10:38 -0500
Received: from mga03.intel.com ([134.134.136.65]:54270 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728017AbfKTQKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:10:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 08:10:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,222,1571727600"; 
   d="scan'208";a="204862318"
Received: from ngoel1-mobl1.amr.corp.intel.com (HELO [10.255.66.61]) ([10.255.66.61])
  by fmsmga007.fm.intel.com with ESMTP; 20 Nov 2019 08:10:35 -0800
Subject: Re: [alsa-devel] [PATCH v8 2/6] ASoC: amd: Refactoring of DAI from
 DMA driver
To:     vishnu <vravulap@amd.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, djkurtz@google.com,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Alexander.Deucher@amd.com, Akshu.Agrawal@amd.com
References: <1574155967-1315-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1574155967-1315-3-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <0c3d3545-b0ee-4bb3-558a-045633a30e46@linux.intel.com>
 <991a1c7a-6f34-caab-132d-5687b1f1bfa0@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9005946f-69b6-1cc6-5a1a-b894d826b960@linux.intel.com>
Date:   Wed, 20 Nov 2019 08:48:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <991a1c7a-6f34-caab-132d-5687b1f1bfa0@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> +    pm_runtime_set_autosuspend_delay(&pdev->dev, 5000);
>>> +    pm_runtime_use_autosuspend(&pdev->dev);
>>> +    pm_runtime_enable(&pdev->dev);
>>
>> question: here you want to use pm_runtime for this platform device...
>>
>>> +    return 0;
>>> +}
>>> +
>>> +static int acp3x_dai_remove(struct platform_device *pdev)
>>> +{
>>> +    pm_runtime_disable(&pdev->dev);
>>> +    return 0;
>>> +}
>>> +static struct platform_driver acp3x_dai_driver = {
>>> +    .probe = acp3x_dai_probe,
>>> +    .remove = acp3x_dai_remove,
>>> +    .driver = {
>>> +        .name = "acp3x_i2s_playcap",
>>
>> ... but here there is no .pm structure and I don't see any 
>> suspend/resume routines for this driver...
>>
>>> +    },
>>> +};
>>
>>> @@ -774,13 +586,14 @@ static struct platform_driver acp3x_dma_driver = {
>>>       .probe = acp3x_audio_probe,
>>>       .remove = acp3x_audio_remove,
>>>       .driver = {
>>> -        .name = "acp3x_rv_i2s",
>>> +        .name = "acp3x_rv_i2s_dma",
>>>           .pm = &acp3x_pm_ops,
>>>       },
>>
>> ... but for this other platform_driver you do have a .pm structure and 
>> suspend-resume implementations.
>>
>> Wondering if this is a miss or a feature?
>>
> 
> As per our design, ACP IP specific changes like ACP power on/off will be 
> handled in ACP pci driver(parent device for DMA device and I2S 
> controller(nothing but CPU DAI))
> 
> Where as In DMA driver during runtime suspend/resume interrupts will be 
> disabled and enabled.
> 
> But in DAI driver there is nothing to be done in suspend and resume just 
> returning zero so we have not added PM suspend/resume here in DAI.
> 
> So is it expected to add the suspend resumes with returning zero.Or if 
> pm runtime is not needed in CPU DAI shall we remove the existing PM 
> related calls in DAI.
> 
> Please suggest us.

I am far from a pm_runtime expert but I'd remove the calls to

+    pm_runtime_set_autosuspend_delay(&pdev->dev, 5000);
+    pm_runtime_use_autosuspend(&pdev->dev);
+    pm_runtime_enable(&pdev->dev);

if you platform device does not provide any suspend/resume functions and 
the parent takes care of everything?

IIRC the status for the platform device would be 'unsupported' but that 
shouldn't prevent the parent from suspending/resuming.

A second opinion would be desirable here...

