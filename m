Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013A6C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 10:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FCC21882
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 10:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406254AbfHIKwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 06:52:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4654 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726152AbfHIKwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 06:52:46 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 727189FF0BB6B176E4EA;
        Fri,  9 Aug 2019 18:52:44 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Fri, 9 Aug 2019
 18:52:39 +0800
Subject: Re: [PATCH] ASoC: SOF: Intel: Add missing include file hdac_hda.h
To:     Takashi Iwai <tiwai@suse.de>
References: <20190809095550.71040-1-yuehaibing@huawei.com>
 <s5hh86qhcyg.wl-tiwai@suse.de>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <pierre-louis.bossart@linux.intel.com>, <yang.jie@linux.intel.com>,
        <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <da80a1fb-e897-e5a4-0809-2349a92279bb@huawei.com>
Date:   Fri, 9 Aug 2019 18:52:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <s5hh86qhcyg.wl-tiwai@suse.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/8/9 18:04, Takashi Iwai wrote:
> On Fri, 09 Aug 2019 11:55:50 +0200,
> YueHaibing wrote:
>>
>> Building with SND_SOC_SOF_HDA_AUDIO_CODEC fails:
>>
>> sound/soc/sof/intel/hda-bus.c: In function sof_hda_bus_init:
>> sound/soc/sof/intel/hda-bus.c:16:25: error: implicit declaration of function
>>  snd_soc_hdac_hda_get_ops; did you mean snd_soc_jack_add_gpiods? [-Werror=implicit-function-declaration]
>>  #define sof_hda_ext_ops snd_soc_hdac_hda_get_ops()
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Fixes: d4ff1b3917a5 ('ASoC: SOF: Intel: Initialize hdaudio bus properly")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Damn, it seems another oversight.
> 
> And now the inclusion in sound/soc/sof/intel/hda.c is superfluous,
> too, so we should just move like
> 
> diff --git a/sound/soc/sof/intel/hda-bus.c b/sound/soc/sof/intel/hda-bus.c
> index 0caec3a070d3..2b384134a3db 100644
> --- a/sound/soc/sof/intel/hda-bus.c
> +++ b/sound/soc/sof/intel/hda-bus.c
> @@ -11,6 +11,9 @@
>  #include <sound/hdaudio.h>
>  #include "../sof-priv.h"
>  #include "hda.h"
> +#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
> +#include "../../codecs/hdac_hda.h"
> +#endif
>  
>  #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
>  #define sof_hda_ext_ops	snd_soc_hdac_hda_get_ops()
> diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
> index 7ca27000c34d..dd6c8ad62b3e 100644
> --- a/sound/soc/sof/intel/hda.c
> +++ b/sound/soc/sof/intel/hda.c
> @@ -23,9 +23,6 @@
>  #include <sound/sof/xtensa.h>
>  #include "../ops.h"
>  #include "hda.h"
> -#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
> -#include "../../codecs/hdac_hda.h"
> -#endif
>  
>  #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
>  #include <sound/soc-acpi-intel-match.h>
> 
> 
> Could you check whether this works instead?

It works well, I can send v2 using this, Thanks!

> 
> 
> BTW, the inclusion of "../../codecs/hdac_hdac.h" is very ugly...
> In general if a header file is referred from another driver, it should
> be in a more public place under include/sound.  If any, we can create
> a subdirectory like include/sound/codecs.
> 

Yes, this can be done in another patch.

> 
> thanks,
> 
> Takashi
> 
> .
> 

