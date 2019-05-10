Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0228C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 13:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97112175B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 13:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfEJNeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 09:34:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:63004 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727258AbfEJNeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 09:34:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 06:34:24 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 10 May 2019 06:34:24 -0700
Received: from khbyers-mobl2.amr.corp.intel.com (unknown [10.251.29.37])
        by linux.intel.com (Postfix) with ESMTP id CAB16580482;
        Fri, 10 May 2019 06:34:23 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH] ASoC: SOF: Fix build error with
 CONFIG_SND_SOC_SOF_NOCODEC=m
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, YueHaibing <yuehaibing@huawei.com>,
        lgirdwood@gmail.com, broonie@kernel.org
References: <20190510023657.8960-1-yuehaibing@huawei.com>
 <s5h7eayn5or.wl-tiwai@suse.de>
 <73c6dd27-895a-adba-a4ef-2992266fcc48@linux.intel.com>
 <s5hlfzempf0.wl-tiwai@suse.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <1e7e1908-a813-6c9b-5b88-122864d3a372@linux.intel.com>
Date:   Fri, 10 May 2019 08:34:03 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <s5hlfzempf0.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/19 8:04 AM, Takashi Iwai wrote:
> On Fri, 10 May 2019 14:56:29 +0200,
> Pierre-Louis Bossart wrote:
>>
>> On 5/10/19 2:12 AM, Takashi Iwai wrote:
>>> On Fri, 10 May 2019 04:36:57 +0200,
>>> YueHaibing wrote:
>>>>
>>>> Fix gcc build error while CONFIG_SND_SOC_SOF_NOCODEC=m
>>>>
>>>> sound/soc/sof/core.o: In function `snd_sof_device_probe':
>>>> core.c:(.text+0x4af): undefined reference to `sof_nocodec_setup'
>>>>
>>>> Change SND_SOC_SOF_NOCODEC to bool to fix this.
>>>>
>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>> Fixes: c16211d6226d ("ASoC: SOF: Add Sound Open Firmware driver core")
>>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>>
>>> This change would break things severely.  This won't allow to build it
>>> as a module any longer.
>>
>> Isn't this fixed already?
>> See the patch  'ASoC: SOF: core: fix undefined nocodec reference' and
>> Takashi's follow-up to fix the unused variable warning.
> 
> Possibly the problem still persists although I haven't seen through my
> local build tests with randconfig.  You can set SND_SOC_SOF=y and
> SND_SOC_NOCODEC=m, i.e. built-in sof-core while nocodec is a module.

YueHiabing, can you share the config and SHA1 so that we can double check?

If the problem persists, we can do something like

config SND_SOF_NOCODEC_SUPPORT
	bool "SOF nocodec mode support"

config SND_SOF_NOCODEC
	tristate

confir SND_SOC_SOF
	tristate
	select SND_SOF_NOCODEC if SND_SOF_NOCODEC_SUPPORT

that way you propagate the required dependencies

> 
> Takashi
> 
>>>
>>> A better fix would be to somehow restrict the SND_SOC_SOF_NOCODEC to
>>> align with SND_SOC_SOF, i.e. disallow SND_SOC_SOF=y &&
>>> SND_SOC_SOF_NOCODEC=m.  Because of the complex mix of select and
>>> depends-on in SOF, I'm afraid that it's not that trivial, though.
>>> There might be something I overlooked, hopefully...
>>>
>>> An easier alternative would be to replace
>>> IS_ENABLED(CONFIG_SND_SOC_SOF_NOCODEC) with
>>> IS_REACHABLE(CONFIG_SND_SOC_SOF_NOCODEC).  This assures the condition
>>> at the build time, although the error at probe might be a surprising
>>> to some users that don't know this hidden dependency.
>>>
>>>
>>> thanks,
>>>
>>> Takashi
>>>
>>>
>>>> ---
>>>>    sound/soc/sof/Kconfig | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/sound/soc/sof/Kconfig b/sound/soc/sof/Kconfig
>>>> index b204c65..9c280c9 100644
>>>> --- a/sound/soc/sof/Kconfig
>>>> +++ b/sound/soc/sof/Kconfig
>>>> @@ -44,7 +44,7 @@ config SND_SOC_SOF_OPTIONS
>>>>    if SND_SOC_SOF_OPTIONS
>>>>      config SND_SOC_SOF_NOCODEC
>>>> -	tristate "SOF nocodec mode Support"
>>>> +	bool "SOF nocodec mode Support"
>>>>    	help
>>>>    	  This adds support for a dummy/nocodec machine driver fallback
>>>>    	  option if no known codec is detected. This is typically only
>>>> -- 
>>>> 2.7.4
>>>>
>>>>
>>>>
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

