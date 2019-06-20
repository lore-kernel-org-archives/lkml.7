Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1A9C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 06:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B962147A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 06:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbfFTGRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 02:17:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:18366 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbfFTGRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 02:17:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 23:17:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,395,1557212400"; 
   d="scan'208";a="168426635"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jun 2019 23:17:36 -0700
Received: from xyang32-mobl.amr.corp.intel.com (unknown [10.252.27.214])
        by linux.intel.com (Postfix) with ESMTP id 6C453580418;
        Wed, 19 Jun 2019 23:17:34 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH v2 09/11] ASoC: Intel: hdac_hdmi: Set ops to
 NULL on remove
To:     Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Jie Yang <yang.jie@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
References: <20190617113644.25621-1-amadeuszx.slawinski@linux.intel.com>
 <20190617113644.25621-10-amadeuszx.slawinski@linux.intel.com>
 <75be86354032f4886cbaf7d430de2aa89eaab573.camel@linux.intel.com>
 <20190618130015.0fc388b4@xxx>
 <bd8855a7ab7a9958113631b76706120fd4427631.camel@linux.intel.com>
 <20190619103859.15bf51c5@xxx>
 <0c939329d17c50c353acacf164583ba259a775c0.camel@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <26946ff4-1c91-a7e0-4354-132cbd06235a@linux.intel.com>
Date:   Thu, 20 Jun 2019 08:17:33 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <0c939329d17c50c353acacf164583ba259a775c0.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>> Could you please give a bit more context on what error you see
>>>>> when this happens?
>>>>
>>>> Hi,
>>>>
>>>> I get Oops. This is what happens with all other patches in this
>>>> series and only this one reverted:
>>>>
>>>> root@APL:~# rmmod snd_soc_sst_bxt_rt298
>>>> root@APL:~# rmmod snd_soc_hdac_hdmi
>>>> root@APL:~# rmmod snd_soc_skl
>>>
>>> Thanks, Amadeusz. I think the order in which the drivers are
>>> removed
>>> is what's causing the oops in your case. With SOF, the order we
>>> remove is
>>>
>>> 1. rmmod sof_pci_dev
>>> 2. rmmod snd_soc_sst_bxt_rt298
>>> 3. rmmod snd_soc_hdac_hdmi
>>>
>>
>> Well, there is nothing enforcing the order in which modules can be
>> unloaded (and I see no reason to force it), as you can see from
>> following excerpt, you can either start unloading from
>> snd_soc_sst_bxt_rt298 or snd_soc_skl, and yes if you start from
>> snd_soc_skl, there is no problem.

there is a fundamental dependency that you are ignoring: the module 
snd_soc_sst_bxt_rt298 is a machine driver which will be probed when 
snd_soc_skl creates a platform_device.
Sure you can remove modules in a different order, but that's a bit of an 
artificial/academic exercise isn't it?

>>
> I am good with this patch. I just wanted to understand why we werent
> seeing this error with SOF. Sure, there's nothing enforcing the order
> in which modules are unloaded  but there must be a logical order for
> testing purposes.
> 
> Pierre, can you please comment on it. I vaguely remember discussing
> this with you last year.

Our tests remove the modules by taking care of dependencies and it's 
already unveiled dozens of issues.
We could add a sequence similar to Amadeusz and unbind the modules which 
are loaded with the creation of a platform_device (machine driver, 
dmic), I am just not sure how of useful this would be.
