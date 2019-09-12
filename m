Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F843C47404
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D56D20CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731869AbfILNG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 09:06:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:24304 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731732AbfILNG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 09:06:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2019 06:06:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="189988369"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 12 Sep 2019 06:06:56 -0700
Received: from vjyoung-mobl.amr.corp.intel.com (unknown [10.251.12.73])
        by linux.intel.com (Postfix) with ESMTP id E1E3C580862;
        Thu, 12 Sep 2019 06:06:54 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH] ASoC: bdw-rt5677: channel constraint support
To:     "Lu, Brent" <brent.lu@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yang.jie@linux.intel.com" <yang.jie@linux.intel.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
References: <1567733058-9561-1-git-send-email-brent.lu@intel.com>
 <391e8f6c-7e35-deb4-4f4d-c39396b778ba@linux.intel.com>
 <CF33C36214C39B4496568E5578BE70C7402C9EA2@PGSMSX108.gar.corp.intel.com>
 <29b9fd4e-3d78-b4a3-e61a-c066bf24995a@linux.intel.com>
 <CF33C36214C39B4496568E5578BE70C7402CB9AC@PGSMSX108.gar.corp.intel.com>
 <99769525-779a-59aa-96da-da96f8f09a8a@linux.intel.com>
 <CF33C36214C39B4496568E5578BE70C7402DBB9B@PGSMSX108.gar.corp.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <34604b9a-f479-3f92-7917-84f295a82fd8@linux.intel.com>
Date:   Thu, 12 Sep 2019 08:06:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CF33C36214C39B4496568E5578BE70C7402DBB9B@PGSMSX108.gar.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/19 1:00 AM, Lu, Brent wrote:
>>>
>>> The story is Chrome has a tool called alsa_conformance_test which runs
>>> capture or playback against a PCM port with all possible
>>> configurations (channel, format, rate) then measure if the sample rate
>>> is correct. Since the channel max number reported is 4, it tests the
>>> 4-channel 48K capture and reports the actual sample rate is 24000
>>> instead of 48000. That's the reason we want to add a constraint in
>>> machine driver to avoid user space programs trying to do 4 channel
>> recording since this machine does not support it in the beginning.
>>
>> ok, that helps get context, thanks for the details.
>>
>> I would have expected some error to be returned if there's a front-end
>> opened with 4 channels and the back-end only supports two. Adding the
>> constraint seems like a work-around to avoid dealing with the mismatch
>> between FE and BE. I don't understand DPCM enough to suggest an
>> alternative though. Ranjani, can you help on this one?
>>
>> And even if we agree with this solution, it'd be nice to apply it for the
>> Broadwell machine driver for consistency.
> 
> It's not only the mismatch but also the design limitation. According to the
> information from google, the board (samus) only uses two microphone so
> 3 or 4 channel recording are not supported. That's the reason we leverage
> the constraint from other machine driver (like kbl_da7219_max98357a.c)
> to remove the 3 and 4 channel recording option.

The design limitation is already handled by the fact that the SSP 
operates in 2ch mode, so it's a different case from KBL where indeed the 
DMIC-based back-end can support 4 channels.

> 
> The difference after the constraint is implemented is that the
> snd_pcm_hw_params_set_channels() function will return error (Invalid
> argument) when channel number is 3 or 4 so the application knows the
> configuration is not supported.

I get the error, I am just wondering if the fix is at the right 
location. I'll look into it, give me until tomorrow.

