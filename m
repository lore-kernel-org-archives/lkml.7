Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263C3C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F120821848
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387682AbfJNPot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 11:44:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:63197 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731441AbfJNPos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:44:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 08:44:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,296,1566889200"; 
   d="scan'208";a="225112710"
Received: from rtnitta-mobl1.amr.corp.intel.com (HELO [10.251.134.135]) ([10.251.134.135])
  by fmsmga002.fm.intel.com with ESMTP; 14 Oct 2019 08:44:47 -0700
Subject: Re: [alsa-devel] [PATCH -next] ASoC: SOF: Fix randbuild error
To:     YueHaibing <yuehaibing@huawei.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        jaska.uimonen@linux.intel.com, yang.jie@linux.intel.com,
        yung-chuan.liao@linux.intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20191014091308.23688-1-yuehaibing@huawei.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3222f3a0-f3cf-b1b9-df23-ec392f7dae4f@linux.intel.com>
Date:   Mon, 14 Oct 2019 10:36:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014091308.23688-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/14/19 4:13 AM, YueHaibing wrote:
> When LEDS_TRIGGER_AUDIO is m and SND_SOC_SOF is y,
> 
> sound/soc/sof/control.o: In function `snd_sof_switch_put':
> control.c:(.text+0x587): undefined reference to `ledtrig_audio_set'
> control.c:(.text+0x593): undefined reference to `ledtrig_audio_set'
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 5d43001ae436 ("ASoC: SOF: acpi led support for switch controls")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks for the fix.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/sof/control.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/sof/control.c b/sound/soc/sof/control.c
> index 41551e8..2c4abd4 100644
> --- a/sound/soc/sof/control.c
> +++ b/sound/soc/sof/control.c
> @@ -36,10 +36,12 @@ static void update_mute_led(struct snd_sof_control *scontrol,
>   
>   	scontrol->led_ctl.led_value = temp;
>   
> +#if IS_REACHABLE(CONFIG_LEDS_TRIGGER_AUDIO)
>   	if (!scontrol->led_ctl.direction)
>   		ledtrig_audio_set(LED_AUDIO_MUTE, temp ? LED_OFF : LED_ON);
>   	else
>   		ledtrig_audio_set(LED_AUDIO_MICMUTE, temp ? LED_OFF : LED_ON);
> +#endif
>   }
>   
>   static inline u32 mixer_to_ipc(unsigned int value, u32 *volume_map, int size)
> 
