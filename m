Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E1EC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D47206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfJJOBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 10:01:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:46873 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfJJOBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 10:01:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 07:01:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,280,1566889200"; 
   d="scan'208";a="197257569"
Received: from unknown (HELO [10.254.187.20]) ([10.254.187.20])
  by orsmga003.jf.intel.com with ESMTP; 10 Oct 2019 07:01:43 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2 3/5] ASoC: core: add support to
 snd_soc_dai_get_sdw_stream()
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, linux-kernel@vger.kernel.org,
        plai@codeaurora.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        spapothi@codeaurora.org
References: <20190813191827.GI5093@sirena.co.uk>
 <cc360858-571a-6a46-1789-1020bcbe4bca@linux.intel.com>
 <20190813195804.GL5093@sirena.co.uk>
 <20190814041142.GU12733@vkoul-mobl.Dlink>
 <99d35a9d-cbd8-f0da-4701-92ef650afe5a@linux.intel.com>
 <5e08f822-3507-6c69-5d83-4ce2a9f5c04f@linaro.org>
 <53bb3105-8e85-a972-fce8-a7911ae4d461@linux.intel.com>
 <95870089-25da-11ea-19fd-0504daa98994@linaro.org>
 <2326a155-332e-fda0-b7a2-b48f348e1911@linux.intel.com>
 <34e4cde8-f2e5-0943-115a-651d86f87c1a@linaro.org>
 <20191010120337.GB31391@ediswmail.ad.cirrus.com>
Message-ID: <22eff3aa-dfd6-1ee5-8f22-2af492286053@linux.intel.com>
Date:   Thu, 10 Oct 2019 09:01:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191010120337.GB31391@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> It's been a while since this thread started, and I still don't
>>> quite get the concepts or logic.
>>>
>>> First, I don't understand what the problem with "aux" devices is.
>>> All the SoundWire stuff is based on the concept of DAI, so I guess
>>> I am
>>
>> That is the actual problem! Some aux devices does not have dais.
>>
> 
> Usually aux devices are used for things like analog amplifiers that
> clearly don't have a digital interface, thus it really makes no sense
> to have a DAI link connecting them. So I guess my question here
> would be what is the thinking on making the "smart amplifier" dailess?
> It feels like having a CODEC to CODEC DAI between the CODEC and
> the AMP would be a more obvious way to connect the two devices
> and would presumably avoid the issues being discussed around the
> patch.

Ah, now I get it, I missed the point about not having DAIs for the 
amplifier.

I will second Charles' point, the code you have in the machine driver at 
[1] gets a SoundWire stream context from the SLIMbus codec dai. It's a 
bit odd to mix layers this way.


And if I look at the code below, taken from [1], if you have more than 
one codec, then your code looks problematic: data->sruntime would be 
overriden and you'd use the info from the last codec dai on the dailink...

case SLIMBUS_0_RX...SLIMBUS_6_TX:
   for (i = 0 ; i < dai_link->num_codecs; i++) {
     [snip]
     data->sruntime[cpu_dai->id] =
	snd_soc_dai_get_sdw_stream(rtd->codec_dais[i], 0); << same destination 
for multiple codec_dais...

If you keep the amp dai-less, then the stream concept should be somehow 
allocated on the master (or machine) side and passed to the codec dais 
that are associated to the same 'stream'.
	

[1] 
https://git.linaro.org/people/srinivas.kandagatla/linux.git/tree/sound/soc/qcom/db845c.c?h=release/db845c/qcomlt-5.2 


