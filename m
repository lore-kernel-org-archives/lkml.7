Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F455CA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 17:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2156E21734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 17:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfKARwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 13:52:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:30772 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfKARwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 13:52:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 10:52:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,256,1569308400"; 
   d="scan'208";a="199876576"
Received: from ggarreto-mobl1.amr.corp.intel.com (HELO [10.255.92.243]) ([10.255.92.243])
  by fmsmga007.fm.intel.com with ESMTP; 01 Nov 2019 10:52:41 -0700
Subject: Re: [alsa-devel] [PATCH v4 2/2] soundwire: qcom: add support for
 SoundWire controller
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        robh@kernel.org, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org
References: <20191030153150.18303-1-srinivas.kandagatla@linaro.org>
 <20191030153150.18303-3-srinivas.kandagatla@linaro.org>
 <af29ec6e-d89e-7fa4-a8cd-29ab944ecd5c@linux.intel.com>
 <926bd15f-e230-8f5e-378d-355bfeeecf27@linaro.org>
 <3d17a2a2-3033-e740-a466-e6cf7919adb2@linux.intel.com>
 <7ea278b4-ecd4-bd17-4550-3f6f9136260e@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3aa6695d-c9b6-b517-ff2f-8eb5a269f020@linux.intel.com>
Date:   Fri, 1 Nov 2019 12:52:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <7ea278b4-ecd4-bd17-4550-3f6f9136260e@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/1/19 12:22 PM, Srinivas Kandagatla wrote:
> 
> 
> On 01/11/2019 16:39, Pierre-Louis Bossart wrote:
>>
>>>>> +static int qcom_swrm_prepare(struct snd_pcm_substream *substream,
>>>>> +                 struct snd_soc_dai *dai)
>>>>> +{
>>>>> +    struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dai->dev);
>>>>> +
>>>>> +    if (!ctrl->sruntime[dai->id])
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    return sdw_enable_stream(ctrl->sruntime[dai->id]);
>>>>
>>>> So in hw_params you call sdw_prepare_stream() and in _prepare you 
>>>> call sdw_enable_stream()?
>>>>
>>>> Shouldn't this be handled in a .trigger operation as per the 
>>>> documentation "From ASoC DPCM framework, this stream state is linked to
>>>> .trigger() start operation."
>>>
>>> If I move sdw_enable/disable_stream() to trigger I get a big click 
>>> noise on my speakers at start and end of every playback. Tried 
>>> different things but nothing helped so far!. Enabling Speaker DACs 
>>> only after SoundWire ports are enabled is working for me!
>>> There is nothing complicated on WSA881x codec side all the DACs are 
>>> enabled/disabled as part of DAPM.
>>
>> that looks like a work-around to me? If you do a bank switch without 
>> anything triggered, you are most likely sending a bunch of zeroes to 
>> your amplifier and enabling click/pop removals somehow.
>>
>> It'd be worth looking into this, maybe there's a missing digital 
>> mute/unmute that's not done in the right order?
> 
> Digital mute does not help too, as they get unmuted before 
> sdw_enable_stream() call in trigger, I hit same click sound.
> 
> Same in the disable path too!
> 
> Also I noticed that there are more than 20+ register read/writes in the 
> sdw_enable_stream() path which took atleast 30 to 40 milliseconds.

wow, that's a very slow command bandwith, is this because of a low frame 
rate or the SLIMbus transport in the middle?

At any rate, we've got to improve the bank switch. The intent of the 
alternate banks is that software mirrors the register settings in the 
background and only updates what needs to be changed during the 
enable/disable part. when you operate with a fixed clock frequency 
usually it's only the channel enable that changes so it could be very 
fast (1 write deferred to the SSP point).

On the intel side our command bandwidth is comparable with the usual 
I2C/HDaudio codecs, but still things complicated and slower than they 
should be. I have been chasing a bug happening on bank switches in 
multi-stream configurations for 10+ days and it's quite hard to debug at 
the moment.

One possibility is to use regmap for the banked registers, and a manual 
mirroring after each bank switch. Or maybe we could even have an 
extension of regmap to do this for us.

> I will try my luck checking the docs to see if I can find something 
> which talks about this.


