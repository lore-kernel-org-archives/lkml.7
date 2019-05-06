Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1339AC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26E2205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfEFPu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:50:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:65409 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbfEFPu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:50:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 08:50:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; 
   d="scan'208";a="322036050"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 06 May 2019 08:50:26 -0700
Received: from slaugust-mobl.amr.corp.intel.com (unknown [10.254.21.102])
        by linux.intel.com (Postfix) with ESMTP id 16A5B580238;
        Mon,  6 May 2019 08:50:26 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: bytcr_5640.c:Refactored if
 statement and removed buffer
To:     Hans de Goede <hdegoede@redhat.com>,
        Nariman <narimantos@gmail.com>, linux-kernel@vger.kernel.org
Cc:     liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, yang.jie@linux.intel.com, tiwai@suse.com
References: <20190504151652.5213-1-user@elitebook-localhost>
 <423c7b83-abd6-4f75-ad3a-7c650b76e8bb@linux.intel.com>
 <6b7111b1-2387-5366-3536-f369a9b0982a@redhat.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d9cb3ce3-d97b-a8ce-252f-c7d8455f5ae1@linux.intel.com>
Date:   Mon, 6 May 2019 10:50:25 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6b7111b1-2387-5366-3536-f369a9b0982a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/19 10:43 AM, Hans de Goede wrote:
> Hi Pierre-Louis,
> 
> Nariman and the author authors of these patches are a group of students 
> doing
> some kernel work for me and this is a warm-up assignment for them to get 
> used
> to the kernel development process.
> 
> On 06-05-19 17:21, Pierre-Louis Bossart wrote:
>>
>>>   static int byt_rt5640_suspend(struct snd_soc_card *card)
>>> @@ -1268,28 +1266,12 @@ static int snd_byt_rt5640_mc_probe(struct 
>>> platform_device *pdev)
>>>       log_quirks(&pdev->dev);
>>>       if ((byt_rt5640_quirk & BYT_RT5640_SSP2_AIF2) ||
>>> -        (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2)) {
>>> -
>>> -        /* fixup codec aif name */
>>> -        snprintf(byt_rt5640_codec_aif_name,
>>> -            sizeof(byt_rt5640_codec_aif_name),
>>> -            "%s", "rt5640-aif2");
>>> -
>>> -        byt_rt5640_dais[dai_index].codec_dai_name =
>>> -            byt_rt5640_codec_aif_name;
>>> -    }
>>> +        (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2))
>>> +        byt_rt5640_dais[dai_index].codec_dai_name = "rt5640-aif2";
>>
>> This is not equivalent, you don't deal with the (byt_rt5640_quirk & 
>> BYT_RT5640_SSP2_AIF2) case. The default is SSP_AIF1
> 
> I might be mistaken here, but look closer, the original:
>      if ((byt_rt5640_quirk & BYT_RT5640_SSP2_AIF2) ||
> 
> Line is kept, so the new code block is:
> 
>      if ((byt_rt5640_quirk & BYT_RT5640_SSP2_AIF2) ||
>          (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2))
>          byt_rt5640_dais[dai_index].codec_dai_name = "rt5640-aif2";
> 
> Which does take the BYT_RT5640_SSP2_AIF2 into account.

Ah yes, my mistake. Looks good then.

> 
>>>       if ((byt_rt5640_quirk & BYT_RT5640_SSP0_AIF1) ||
>>> -        (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2)) {
>>> -
>>> -        /* fixup cpu dai name name */
>>> -        snprintf(byt_rt5640_cpu_dai_name,
>>> -            sizeof(byt_rt5640_cpu_dai_name),
>>> -            "%s", "ssp0-port");
>>> -
>>> -        byt_rt5640_dais[dai_index].cpu_dai_name =
>>> -            byt_rt5640_cpu_dai_name;
>>> -    }
>>> +        (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2))
>>> +        byt_rt5640_dais[dai_index].cpu_dai_name = "ssp0-port";
>>
>> Same here, this is not equivalent. the SSP0_AIF1 case is not handled.
>> it's fine to remove the intermediate buffers, but you can't remove 
>> support for 2 out of the 4 combinations supported.
> 
> Same remark here from me too :)
> 
> Regards,
> 
> Hans
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

