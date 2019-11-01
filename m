Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C1BCA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194E221734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbfKAQjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 12:39:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:32461 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbfKAQjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 12:39:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 09:39:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,256,1569308400"; 
   d="scan'208";a="199860587"
Received: from ggarreto-mobl1.amr.corp.intel.com (HELO [10.255.92.243]) ([10.255.92.243])
  by fmsmga007.fm.intel.com with ESMTP; 01 Nov 2019 09:39:38 -0700
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
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3d17a2a2-3033-e740-a466-e6cf7919adb2@linux.intel.com>
Date:   Fri, 1 Nov 2019 11:39:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <926bd15f-e230-8f5e-378d-355bfeeecf27@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> +static int qcom_swrm_prepare(struct snd_pcm_substream *substream,
>>> +                 struct snd_soc_dai *dai)
>>> +{
>>> +    struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dai->dev);
>>> +
>>> +    if (!ctrl->sruntime[dai->id])
>>> +        return -EINVAL;
>>> +
>>> +    return sdw_enable_stream(ctrl->sruntime[dai->id]);
>>
>> So in hw_params you call sdw_prepare_stream() and in _prepare you call 
>> sdw_enable_stream()?
>>
>> Shouldn't this be handled in a .trigger operation as per the 
>> documentation "From ASoC DPCM framework, this stream state is linked to
>> .trigger() start operation."
> 
> If I move sdw_enable/disable_stream() to trigger I get a big click noise 
> on my speakers at start and end of every playback. Tried different 
> things but nothing helped so far!. Enabling Speaker DACs only after 
> SoundWire ports are enabled is working for me!
> There is nothing complicated on WSA881x codec side all the DACs are 
> enabled/disabled as part of DAPM.

that looks like a work-around to me? If you do a bank switch without 
anything triggered, you are most likely sending a bunch of zeroes to 
your amplifier and enabling click/pop removals somehow.

It'd be worth looking into this, maybe there's a missing digital 
mute/unmute that's not done in the right order?

> 
>>
>> It's also my understanding that .prepare will be called multiples times, 
> 
> I agree, need to add some extra checks in the prepare to deal with this!
> 
>> including for underflows and resume if you don't support INFO_RESUME.
> 
>>
>> the sdw_disable_stream() is in .hw_free, which is not necessarily 
>> called by the core, so you may have a risk of not being able to recover?
> 
> Hmm, I thought hw_free is always called to release resources allocated 
> in hw_params.
> 
> In what cases does the core not call this?

yes, but prepare can be called without hw_free called first. that's why 
we updated the state machine to allow for DISABLED|DEPREPARED -> 
PREPARED transitions.

>>> +static const struct dev_pm_ops qcom_swrm_dev_pm_ops = {
>>> +    SET_RUNTIME_PM_OPS(qcom_swrm_runtime_suspend,
>>> +               qcom_swrm_runtime_resume,
>>> +               NULL
>>> +    )
>>> +};
>>
>> Maybe define pm_runtime at a later time then? We've had a lot of race 
>> conditions to deal with, and it's odd that you don't support plain 
>> vanilla suspend first?
>>
> Trying to keep things simple for the first patchset! added this dummies 
> to keep the soundwire core happy!

If you are referring to the errors when pm_runtime is not enabled, we 
fixed this is the series that's been out for review for 10 days now...

see '[PATCH 03/18] soundwire: bus: add PM/no-PM versions of read/write 
functions', that should remove the need for dummy functions.

