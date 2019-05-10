Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA7CC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 13:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C576B21479
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 13:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfEJNKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 09:10:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46748 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727174AbfEJNKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 09:10:07 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5964817C1004EFD50784;
        Fri, 10 May 2019 21:10:05 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Fri, 10 May 2019
 21:10:00 +0800
Subject: Re: [PATCH] ASoC: SOF: Fix build error with
 CONFIG_SND_SOC_SOF_NOCODEC=m
To:     Takashi Iwai <tiwai@suse.de>
References: <20190510023657.8960-1-yuehaibing@huawei.com>
 <s5h7eayn5or.wl-tiwai@suse.de>
CC:     <lgirdwood@gmail.com>, <rdunlap@infradead.org>,
        <broonie@kernel.org>, <pierre-louis.bossart@linux.intel.com>,
        <perex@perex.cz>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <07c6a947-aa4f-2195-d4bf-3a757528352e@huawei.com>
Date:   Fri, 10 May 2019 21:09:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <s5h7eayn5or.wl-tiwai@suse.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/5/10 15:12, Takashi Iwai wrote:
> On Fri, 10 May 2019 04:36:57 +0200,
> YueHaibing wrote:
>>
>> Fix gcc build error while CONFIG_SND_SOC_SOF_NOCODEC=m
>>
>> sound/soc/sof/core.o: In function `snd_sof_device_probe':
>> core.c:(.text+0x4af): undefined reference to `sof_nocodec_setup'
>>
>> Change SND_SOC_SOF_NOCODEC to bool to fix this.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Fixes: c16211d6226d ("ASoC: SOF: Add Sound Open Firmware driver core")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> This change would break things severely.  This won't allow to build it
> as a module any longer.
> 
> A better fix would be to somehow restrict the SND_SOC_SOF_NOCODEC to
> align with SND_SOC_SOF, i.e. disallow SND_SOC_SOF=y &&
> SND_SOC_SOF_NOCODEC=m.  Because of the complex mix of select and
> depends-on in SOF, I'm afraid that it's not that trivial, though.
> There might be something I overlooked, hopefully...
> 
> An easier alternative would be to replace
> IS_ENABLED(CONFIG_SND_SOC_SOF_NOCODEC) with
> IS_REACHABLE(CONFIG_SND_SOC_SOF_NOCODEC).  This assures the condition
> at the build time, although the error at probe might be a surprising
> to some users that don't know this hidden dependency.
> 

Yes, I prefer to use IS_REACHABLE, thanks!

> 
> thanks,
> 
> Takashi
> 
> 
>> ---
>>  sound/soc/sof/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/sof/Kconfig b/sound/soc/sof/Kconfig
>> index b204c65..9c280c9 100644
>> --- a/sound/soc/sof/Kconfig
>> +++ b/sound/soc/sof/Kconfig
>> @@ -44,7 +44,7 @@ config SND_SOC_SOF_OPTIONS
>>  if SND_SOC_SOF_OPTIONS
>>  
>>  config SND_SOC_SOF_NOCODEC
>> -	tristate "SOF nocodec mode Support"
>> +	bool "SOF nocodec mode Support"
>>  	help
>>  	  This adds support for a dummy/nocodec machine driver fallback
>>  	  option if no known codec is detected. This is typically only
>> -- 
>> 2.7.4
>>
>>
>>
> 
> .
> 

