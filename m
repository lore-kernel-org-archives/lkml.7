Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D84C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFA1206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOAZ66X1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfL3ThJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 14:37:09 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43122 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfL3ThI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 14:37:08 -0500
Received: by mail-lf1-f66.google.com with SMTP id 9so25768751lfq.10;
        Mon, 30 Dec 2019 11:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qOOSKaKHeFnod5RsK2x90NOSdkdcsmV7T1nxZJUbNFM=;
        b=TOAZ66X1HMUwmsDMiHpQaMSWjWbrMckRdF29Qmkw7WUdjCLexTFaLygZn8cL9rW5i9
         u2nmP4MGXAdzM0V0vWb85sv0RkLb+sc2jJhz7mF9tJVpf5W5VR9tqxPD4Ee0550aYaaB
         3wA9OdqVgQ6eN3NMBX/IPlw8gPc4WmGEmxVt2+Ze6lJB7g8edNyM7l7ObYvqwMgvkyRp
         LpVqziMyB7SbH3CCkTDL9J0gfxSHQPbZN0W3lQk3cwNHRflk4wNHe3EBHN4D/JU5Vawv
         /M21K4hjE5XCMVwZVwQCvzBA/zESjM0aS9G1mluJAS1TxItdyZPOM+DYk9yniyZHx3aE
         bLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qOOSKaKHeFnod5RsK2x90NOSdkdcsmV7T1nxZJUbNFM=;
        b=WDyPpa9tLMC1ctYbrXpwDKOw0jFVFDZv4coynqAbT9dAEnisAAs8Aqu6tMbgiT1K+H
         dxHDw0HwVF2/K+l2jeWDGwZpk55uXgbF9nv0M1dfM9Gc4/laoP0RomKLAzguYBSdmLzg
         SW9cWqhvbG6ZyW2dLrQQaH4XXIT4fu8kse1LJ7T+5x9NKhcDEP/NZJutd9HSgs7Zi1pB
         wEoRXCMl7dP9s7dwlAmfWBbosAybBqjuJH1oIt0hXTpl8tD+JCHbwWLHnWfPPw/p4DzJ
         o+G7y/U64FkYYtcpuQrt4XG4YaPtaTitXwrsrji83lZiQ/9FxFuvOXe7afPJ96ZELO3s
         TuLw==
X-Gm-Message-State: APjAAAUreLJpmKhwaGMyCFAzsavaXdmTOVvhU/Yldci1AKfA3DJSpbwU
        tP/hYqfp88eeFJOUAnSFTwog6Mmm
X-Google-Smtp-Source: APXvYqxazqU9rDtT0rPVHMMgwW7B4Kv0P8Jgclqa/eU938P2WNSQlrWfofGwQnG/j+Id1P8xPxj4ag==
X-Received: by 2002:ac2:41c8:: with SMTP id d8mr38454027lfi.65.1577734626358;
        Mon, 30 Dec 2019 11:37:06 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id m15sm18353822ljg.4.2019.12.30.11.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2019 11:37:04 -0800 (PST)
Subject: Re: [PATCH v1] ASoC: rt5640: Fix NULL dereference on module unload
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, linux-tegra@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20191229150454.2127-1-digetx@gmail.com>
 <s5hh81i47a5.wl-tiwai@suse.de>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <68754394-fb34-b109-264a-98f36d05ff2a@gmail.com>
Date:   Mon, 30 Dec 2019 22:37:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <s5hh81i47a5.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

30.12.2019 10:11, Takashi Iwai пишет:
> On Sun, 29 Dec 2019 16:04:54 +0100,
> Dmitry Osipenko wrote:
>>
>> The rt5640->jack is NULL if jack is already disabled at the time of
>> driver's module unloading.
>>
>>  Unable to handle kernel NULL pointer dereference at virtual address 00000024
>>  ...
>>  (rt5640_set_jack [snd_soc_rt5640]) from [<bf86f7ed>] (snd_soc_component_set_jack+0x11/0x1c [snd_soc_core])
>>  (snd_soc_component_set_jack [snd_soc_core]) from [<bf8675cf>] (soc_remove_component+0x1b/0x54 [snd_soc_core])
>>  (soc_remove_component [snd_soc_core]) from [<bf868859>] (soc_cleanup_card_resources+0xad/0x1cc [snd_soc_core])
>>  (soc_cleanup_card_resources [snd_soc_core]) from [<bf86945f>] (snd_soc_unregister_card+0x47/0x78 [snd_soc_core])
>>  (snd_soc_unregister_card [snd_soc_core]) from [<bf8b4013>] (tegra_rt5640_remove+0x13/0x1c [snd_soc_tegra_rt5640])
>>  (tegra_rt5640_remove [snd_soc_tegra_rt5640]) from [<c0516d2f>] (platform_drv_remove+0x17/0x24)
>>  (platform_drv_remove) from [<c0515aed>] (device_release_driver_internal+0x95/0x114)
>>  (device_release_driver_internal) from [<c0515bd9>] (driver_detach+0x4d/0x90)
>>  (driver_detach) from [<c0514d59>] (bus_remove_driver+0x31/0x70)
>>  (bus_remove_driver) from [<bf8b4215>] (tegra_rt5640_driver_exit+0x9/0xdf4 [snd_soc_tegra_rt5640])
>>  (tegra_rt5640_driver_exit [snd_soc_tegra_rt5640]) from [<c019336f>] (sys_delete_module+0xe7/0x184)
>>  (sys_delete_module) from [<c0101001>] (ret_fast_syscall+0x1/0x28)
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  sound/soc/codecs/rt5640.c | 22 ++++++++++++++--------
>>  1 file changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
>> index adbae1f36a8a..b245c44cafbc 100644
>> --- a/sound/soc/codecs/rt5640.c
>> +++ b/sound/soc/codecs/rt5640.c
>> @@ -2432,16 +2432,22 @@ static void rt5640_disable_jack_detect(struct snd_soc_component *component)
>>  {
>>  	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
>>  
>> -	disable_irq(rt5640->irq);
>> -	rt5640_cancel_work(rt5640);
>> +	/*
>> +	 * soc_remove_component() force-disables jack and thus rt5640->jack
>> +	 * could be NULL at the time of driver's module unloading.
>> +	 */
>> +	if (rt5640->jack) {
>> +		disable_irq(rt5640->irq);
>> +		rt5640_cancel_work(rt5640);
>>  
>> -	if (rt5640->jack->status & SND_JACK_MICROPHONE) {
>> -		rt5640_disable_micbias1_ovcd_irq(component);
>> -		rt5640_disable_micbias1_for_ovcd(component);
>> -		snd_soc_jack_report(rt5640->jack, 0, SND_JACK_BTN_0);
>> -	}
>> +		if (rt5640->jack->status & SND_JACK_MICROPHONE) {
>> +			rt5640_disable_micbias1_ovcd_irq(component);
>> +			rt5640_disable_micbias1_for_ovcd(component);
>> +			snd_soc_jack_report(rt5640->jack, 0, SND_JACK_BTN_0);
>> +		}
>>  
>> -	rt5640->jack = NULL;
>> +		rt5640->jack = NULL;
>> +	}
>>  }
> 
> I guess it's simpler just returning if rt5640->jack is already NULL.
> 
> --- a/sound/soc/codecs/rt5640.c
> +++ b/sound/soc/codecs/rt5640.c
> @@ -2432,6 +2432,10 @@ static void rt5640_disable_jack_detect(struct snd_soc_component *component)
>  {
>  	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
>  
> +	/* already disabled? */
> +	if (!rt5640->jack)
> +		return;
> +
>  	disable_irq(rt5640->irq);
>  	rt5640_cancel_work(rt5640);
>  
> 
> thanks,
> 
> Takashi
> 

Okay, I'll make v2.
