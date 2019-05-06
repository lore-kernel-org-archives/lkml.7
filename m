Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D2CC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6EA1205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfEFPnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:43:20 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45862 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfEFPnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:43:19 -0400
Received: by mail-ed1-f65.google.com with SMTP id g57so15751494edc.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 08:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vhfg5FTHcJXptS1Kd8NC0qr6EcLPankfuQ5lBm93OT4=;
        b=umfqxMz/IBaRwkSZy4EL9me4vSjsr7yu/I1LMaLAKYhLu2w+AwV3gRmU1a3kp505/R
         oJR0oJZNtw2e08UDciZOVUZ1yzppX2sEvE5f2cUTJBQ68Hi9hJGoeBJ5zGy+GbsIlZvE
         0rT0Yw3RtT7cEEi+h8wtUiJD9h/le4OAihwMl7PG3QqOqP1yV83cP7NAj6Eyi21dPdeU
         kp6BUxlYHci7+SEGbOzxKFbG4yMPJPkcLpffS5Afd3nhP2Pgeigz5zxcunyxXzpFQLiY
         VGDMckV6WYkjHQKbYmoYR+bNNByGOSucuBpYcaoiupdp4MOpnFRy37O8lApDhGx+NtKv
         2h+A==
X-Gm-Message-State: APjAAAXKRuETFDXa5/5JFyoZj/pgdkC6PhfWeOCA1nArGljDaC/z5Dwl
        OTU0K3pQQGGX4j1MDOgd0KO03w==
X-Google-Smtp-Source: APXvYqwXCBhoco5TfV/LKqKF2GjuaDlY1Zrwaobpd214BL73BryIc/p9LIhnXqfmRbeA61sMkjvUXQ==
X-Received: by 2002:a50:be01:: with SMTP id a1mr21259711edi.12.1557157398110;
        Mon, 06 May 2019 08:43:18 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id m27sm1667360eje.67.2019.05.06.08.43.17
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 08:43:17 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: bytcr_5640.c:Refactored if
 statement and removed buffer
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Nariman <narimantos@gmail.com>, linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, tiwai@suse.com,
        yang.jie@linux.intel.com, liam.r.girdwood@linux.intel.com,
        broonie@kernel.org
References: <20190504151652.5213-1-user@elitebook-localhost>
 <423c7b83-abd6-4f75-ad3a-7c650b76e8bb@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <6b7111b1-2387-5366-3536-f369a9b0982a@redhat.com>
Date:   Mon, 6 May 2019 17:43:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <423c7b83-abd6-4f75-ad3a-7c650b76e8bb@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre-Louis,

Nariman and the author authors of these patches are a group of students doing
some kernel work for me and this is a warm-up assignment for them to get used
to the kernel development process.

On 06-05-19 17:21, Pierre-Louis Bossart wrote:
> 
>>   static int byt_rt5640_suspend(struct snd_soc_card *card)
>> @@ -1268,28 +1266,12 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
>>       log_quirks(&pdev->dev);
>>       if ((byt_rt5640_quirk & BYT_RT5640_SSP2_AIF2) ||
>> -        (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2)) {
>> -
>> -        /* fixup codec aif name */
>> -        snprintf(byt_rt5640_codec_aif_name,
>> -            sizeof(byt_rt5640_codec_aif_name),
>> -            "%s", "rt5640-aif2");
>> -
>> -        byt_rt5640_dais[dai_index].codec_dai_name =
>> -            byt_rt5640_codec_aif_name;
>> -    }
>> +        (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2))
>> +        byt_rt5640_dais[dai_index].codec_dai_name = "rt5640-aif2";
> 
> This is not equivalent, you don't deal with the (byt_rt5640_quirk & BYT_RT5640_SSP2_AIF2) case. The default is SSP_AIF1

I might be mistaken here, but look closer, the original:
	if ((byt_rt5640_quirk & BYT_RT5640_SSP2_AIF2) ||

Line is kept, so the new code block is:

	if ((byt_rt5640_quirk & BYT_RT5640_SSP2_AIF2) ||
	    (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2))
		byt_rt5640_dais[dai_index].codec_dai_name = "rt5640-aif2";

Which does take the BYT_RT5640_SSP2_AIF2 into account.

>>       if ((byt_rt5640_quirk & BYT_RT5640_SSP0_AIF1) ||
>> -        (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2)) {
>> -
>> -        /* fixup cpu dai name name */
>> -        snprintf(byt_rt5640_cpu_dai_name,
>> -            sizeof(byt_rt5640_cpu_dai_name),
>> -            "%s", "ssp0-port");
>> -
>> -        byt_rt5640_dais[dai_index].cpu_dai_name =
>> -            byt_rt5640_cpu_dai_name;
>> -    }
>> +        (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2))
>> +        byt_rt5640_dais[dai_index].cpu_dai_name = "ssp0-port";
> 
> Same here, this is not equivalent. the SSP0_AIF1 case is not handled.
> it's fine to remove the intermediate buffers, but you can't remove support for 2 out of the 4 combinations supported.

Same remark here from me too :)

Regards,

Hans

