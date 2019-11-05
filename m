Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C166EC17460
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4592190F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389149AbfKENha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 08:37:30 -0500
Received: from mga09.intel.com ([134.134.136.24]:19235 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387880AbfKENha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 08:37:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 05:37:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,271,1569308400"; 
   d="scan'208";a="403353670"
Received: from nvavanes-mobl.amr.corp.intel.com (HELO [10.254.182.110]) ([10.254.182.110])
  by fmsmga006.fm.intel.com with ESMTP; 05 Nov 2019 05:37:28 -0800
Subject: Re: [alsa-devel] [PATCH] ASoC: bdw-rt5677: enable runtime channel
 merge
To:     "Lu, Brent" <brent.lu@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jie Yang <yang.jie@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        "Zavras, Alexios" <alexios.zavras@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1570007072-23049-1-git-send-email-brent.lu@intel.com>
 <CF33C36214C39B4496568E5578BE70C74031B9FD@PGSMSX108.gar.corp.intel.com>
 <63da3995-b807-f9e6-6f09-a90e6b8e8e53@linux.intel.com>
 <CF33C36214C39B4496568E5578BE70C74032F8BA@PGSMSX108.gar.corp.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9abda4e6-7a85-50e3-ca09-7029fe5a0d7a@linux.intel.com>
Date:   Tue, 5 Nov 2019 06:48:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CF33C36214C39B4496568E5578BE70C74032F8BA@PGSMSX108.gar.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/5/19 12:03 AM, Lu, Brent wrote:
>>>> In the DAI link "Capture PCM", the FE DAI "Capture Pin" supports
>>>> 4-channel capture but the BE DAI supports only 2-channel capture. To
>>>> fix the channel mismatch, we need to enable the runtime channel merge
>> for this DAI link.
>>>>
>>>
>>> Hi Pierre,
>>>
>>> This patch is for the same issue discussed in the following thread:
>>> https://patchwork.kernel.org/patch/11134167/
>>>
>>> We enable the runtime channel merge for the DMIC DAI instead of adding
>>> a machine driver constraint. It's working good on chrome's 3.14 branch
>>> (which requires some backport for the runtime channel merge feature).
>>> Please let me know if this implementation is correct for the FE/BE mismatch
>> problem.
>>
>> Sorry, I don't fully understand your points, and it's the first time I see anyone
>> use this .dpcm_merged_chan field for an Intel platform.
>>
>> If I look at the code I see that the core would limit the number of channels to
>> two. But that code needs the CPU_DAI to use 2 channels, which I don't see.
>> So is this patch self-contained or do we need an additional constraint on the
>> FE?
>>
>> Thanks
>> -Pierre
> 
> Hi Pierre,
> 
> We don't need constraint on FE because dpcm_runtime_merge_chan() modifies
> the channel number of snd_pcm_hardware structure directly. The structure will
> be used to initialize the snd_pcm_hw_constraints structure later in the
> snd_pcm_hw_constraints_complete() function. Since the channel number is already
> modified, we don't need a constraint to install an extra rule for it.
> 
> The result of using dpcm_merged_chan flag and machine driver constraint should
> be the same when user space programs calling HW_REFINE ioctl call but I think the
> flag is more elegant for machine driver code.

I could use the opposite argument: by using a capability that no one 
else uses, you make the solution more obscure and less intuitive. All 
other machine drivers use constraints, so if the two solutions are 
equivalent let's follow the more common solution.
