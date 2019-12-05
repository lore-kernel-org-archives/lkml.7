Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDBBC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 04:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A3320674
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 04:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfLEEKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 23:10:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:21273 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbfLEEKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 23:10:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 20:10:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,279,1571727600"; 
   d="scan'208";a="219099125"
Received: from bcmarin-mobl.amr.corp.intel.com (HELO [10.255.230.27]) ([10.255.230.27])
  by fmsmga001.fm.intel.com with ESMTP; 04 Dec 2019 20:10:30 -0800
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-core: Set dpcm_playback /
 dpcm_capture
To:     "Sridharan, Ranjani" <ranjani.sridharan@intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Pierre-louis Bossart <pierre-louis.bossart@intel.com>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        Mark Brown <broonie@kernel.org>, tiwai@suse.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20191204151333.26625-1-daniel.baluta@nxp.com>
 <CAFQqKeXG3ihj67L+KgKZW=Cp6ipJC18wUVci3hGTMutBv4boZw@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <82095ea8-fa9a-5c67-e0e6-1a886dfc4b0e@linux.intel.com>
Date:   Wed, 4 Dec 2019 22:01:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAFQqKeXG3ihj67L+KgKZW=Cp6ipJC18wUVci3hGTMutBv4boZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/4/19 5:29 PM, Sridharan, Ranjani wrote:
> On Wed, Dec 4, 2019 at 7:16 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:
> 
>> When converting a normal link to a DPCM link we need
>> to set dpcm_playback / dpcm_capture otherwise playback/capture
>> streams will not be created resulting in errors like this:
>>
>> [   36.039111]  sai1-wm8960-hifi: ASoC: no backend playback stream
>>
>> Fixes: a655de808cbde ("ASoC: core: Allow topology to override machine
>> driver FE DAI link config")
>> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
>> ---
>>   sound/soc/soc-core.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
>> index 977a7bfad519..f89cf9d0860c 100644
>> --- a/sound/soc/soc-core.c
>> +++ b/sound/soc/soc-core.c
>> @@ -1872,6 +1872,8 @@ static void soc_check_tplg_fes(struct snd_soc_card
>> *card)
>>
>>                          /* convert non BE into BE */
>>                          dai_link->no_pcm = 1;
>> +                       dai_link->dpcm_playback = 1;
>> +                       dai_link->dpcm_capture = 1;
>>
> Hi Daniel,
> 
> Typically, for Intel platforms, this information comes from the machine
> driver and there are some DAI links that have either playback or capture
> set. But this change would set both for all DAI links.
> Not sure if this is the right thing to do.

I am with Ranjani, I don't get why we'd set the full-duplex mode by 
default. but to be honest I never quite understood what this code is 
supposed to do...
