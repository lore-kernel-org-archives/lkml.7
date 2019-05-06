Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210DEC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1D42087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbfEFPsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:48:21 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39104 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfEFPsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:48:21 -0400
Received: by mail-ed1-f68.google.com with SMTP id e24so15801932edq.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 08:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D044CB3ldsnFTWWR9zn1mDGutl9EAIqq+47R4uBZa5I=;
        b=Xp+0Ed9C0A7HqbVMMXrSKEYiw3hJAMcopn1YjFbIecBDllDaNA3ShU4t5Gwc3S1GBK
         ITIxZ5OtMnvbTghhuiKS1pve1QArZC56HbevIabr3y8GdMaceXByYST9NcRnVET79kFy
         6hB4WR9sgXqv8mtyE9VbEhTszB20Gu+eycsMoS3KS7TLmKawJ7oYR6bgKfoj09zHACIj
         kubaPyagZjbOVBb+GG9LwhbaoeCc51PPB1ahziOfeoYXdkbi2DlMY0X1NnZG7sP2MkGf
         CilRlnNa13kTtv9/vb8ZUh5Rc68Y7Rm/1kijlVkDzWCbAlvGKrL2nv3sr5mB/xEnv+kS
         pR4Q==
X-Gm-Message-State: APjAAAUwrjK62bGDQ6/P4T7qhe4Naq2RA9BGljAybDAQfshOiSAghqRB
        hEEQ6aWOrpx5GItVjcobTw3Vtg==
X-Google-Smtp-Source: APXvYqxWEiBhc6aafxXJje+l0pisjs6TLIXAHJXClDrdeNfqakh2QoSYDgVEmIvv5JQ63g5Zxw3lTg==
X-Received: by 2002:a50:be03:: with SMTP id a3mr24558576edi.5.1557157699428;
        Mon, 06 May 2019 08:48:19 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id i9sm3184135edk.56.2019.05.06.08.48.18
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 08:48:18 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: cht_bsw_rt5645.c: Remove buffer
 and snprintf calls
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Nariman <narimantos@gmail.com>, linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, tiwai@suse.com,
        yang.jie@linux.intel.com, liam.r.girdwood@linux.intel.com,
        broonie@kernel.org, Damian van Soelen <dj.vsoelen@gmail.com>
References: <20190504151652.5213-1-user@elitebook-localhost>
 <20190504151652.5213-2-user@elitebook-localhost>
 <92f39b95-aabe-0a92-714e-15d2ea123f49@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <93914256-4fbd-a17b-c283-7dbad37649d0@redhat.com>
Date:   Mon, 6 May 2019 17:48:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <92f39b95-aabe-0a92-714e-15d2ea123f49@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06-05-19 17:24, Pierre-Louis Bossart wrote:
> On 5/4/19 10:16 AM, Nariman wrote:
>> From: Damian van Soelen <dj.vsoelen@gmail.com>
>>
>> The snprintf calls filling cht_rt5645_cpu_dai_name / cht_rt5645_codec_aif_name
>> always fill them with the same string ("ssp0-port" resp "rt5645-aif2") so
>> instead of keeping these buffers around and making the cpu_dai_name /
>> codec_aif_name point to this, simply update the foo_dai_name and foo_aif_name pointers to
>> directly point to a string constant containing the desired string.
>>
>> Signed-off-by: Damian van Soelen <dj.vsoelen@gmail.com>
> 
> Need Nariman's Signoff-of-by tag here.

Yes, Nariman can you resend with your S-o-b added once the other part
of this discussion is resolved?

Note you need to pass

--subject-prefix="PATCH v2"

To git send-email when sending out the new version with your S-o-b added
to the 3 patches which you are not the author of.




>> ---
>>   sound/soc/intel/boards/cht_bsw_rt5645.c | 26 ++++---------------------
>>   1 file changed, 4 insertions(+), 22 deletions(-)
>>
>> diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
>> index cbc2d458483f..b15459e56665 100644
>> --- a/sound/soc/intel/boards/cht_bsw_rt5645.c
>> +++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
>> @@ -506,8 +506,6 @@ static struct cht_acpi_card snd_soc_cards[] = {
>>   };
>>   static char cht_rt5645_codec_name[SND_ACPI_I2C_ID_LEN];
>> -static char cht_rt5645_codec_aif_name[12]; /*  = "rt5645-aif[1|2]" */
>> -static char cht_rt5645_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
>>   static bool is_valleyview(void)
>>   {
>> @@ -641,28 +639,12 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
>>       log_quirks(&pdev->dev);
>>       if ((cht_rt5645_quirk & CHT_RT5645_SSP2_AIF2) ||
>> -        (cht_rt5645_quirk & CHT_RT5645_SSP0_AIF2)) {
>> -
>> -        /* fixup codec aif name */
>> -        snprintf(cht_rt5645_codec_aif_name,
>> -            sizeof(cht_rt5645_codec_aif_name),
>> -            "%s", "rt5645-aif2");
>> -
>> -        cht_dailink[dai_index].codec_dai_name =
>> -            cht_rt5645_codec_aif_name;
>> -    }
>> +        (cht_rt5645_quirk & CHT_RT5645_SSP0_AIF2))
>> +            cht_dailink[dai_index].codec_dai_name = "rt5645-aif2";
> 
> same, not equivalent. SSP2_AIF2 is not handled.

Same remark from me, and also the same for the 3th patch you've
responded to.

Regards,

Hans


> 
>>       if ((cht_rt5645_quirk & CHT_RT5645_SSP0_AIF1) ||
>> -        (cht_rt5645_quirk & CHT_RT5645_SSP0_AIF2)) {
>> -
>> -        /* fixup cpu dai name name */
>> -        snprintf(cht_rt5645_cpu_dai_name,
>> -            sizeof(cht_rt5645_cpu_dai_name),
>> -            "%s", "ssp0-port");
>> -
>> -        cht_dailink[dai_index].cpu_dai_name =
>> -            cht_rt5645_cpu_dai_name;
>> -    }
>> +        (cht_rt5645_quirk & CHT_RT5645_SSP0_AIF2))
>> +            cht_dailink[dai_index].cpu_dai_name = "ssp0-port";
> 
> and same here, SSP0_AIF1 will no longer work.
> 
>>       /* override plaform name, if required */
>>       platform_name = mach->mach_params.platform;
>>
> 
