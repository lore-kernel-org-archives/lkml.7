Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DFDC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6E32070B
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FYLVfUtK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfFIMQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 08:16:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36326 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbfFIMQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 08:16:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id u8so5713912wmm.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 05:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LpQBsLxOpX37xTANohRbpLZWsHdkz9zKfiLJ8/LUdwA=;
        b=FYLVfUtKWyeWJSTHK/1+iRBkE/d4V2jWSZ9c2lLXRAsfbgdl8xTBokfr+yFBwU3evv
         otb4miQ9PfF92NNm3rgFTkfQP2s8sgCNfPDW9UceQvrUGMTKudjrdLH4To9umrIrVIoS
         3Pwg94HQ75Ec42mt+5CrbnOvIDPH321+eYILQucaMjnSvtpYD1n5u8qVaIsgzIeAxAhH
         rvEBIBK0DofGd+yPHdkI9JgUD38Yx++IptYksvylyOPOFgynBvhhQzVyeN8XyIDJuzkI
         F5Kz/wFM/f0y1iB8XOOLuuvhTL9Cey6q2hRQHjh+X9cM+x+vY7UO4NTYb6AXNnuCmheu
         bN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LpQBsLxOpX37xTANohRbpLZWsHdkz9zKfiLJ8/LUdwA=;
        b=p2kudk3f2UVGMrRxbrbcXcaDAyRWOtNlEwUHrVvhUYfCgeEgZJ5zTCqqpq+6846kQg
         3Rw3eyHQARTWNZJuTuuyWEJ/5rmZy/Fh1IK0qtX549Qn1viFxXM0+/IhGSRS/6H/MYj4
         LOX312f8JOmMcfFE2J2MgTP0+JtHWcJ2PLoI5HhEvsQyWKYGdos5jgymg2OYWgAVsfgL
         PlzZXCMtHoiiwpV2ep8qcHOJVAAxj1I7kNGsOhnwNiAKk57Ezua+8bmdLFGv+pPPTYCu
         4soaIj3Zv7KM0JU9uYx4WukfJWxC4QcYkcT6fHznfkr0UZsbILFIqPkLqwW4QIjzYS2L
         Tx4A==
X-Gm-Message-State: APjAAAWSl4vve1S+PgN1Ntf3NK4QVFFFllxe/B9gdFwDucu2RhOEGqKg
        aFMXi6IPMy2iNdaFjAR+oK7iW974waRiNg==
X-Google-Smtp-Source: APXvYqwt339mnQf4UEVUi8OBWtoZ3i25kVNHP5JRQNlY2ULQwvZj2wG0lbSvdmMSv9woVd8aqmRntw==
X-Received: by 2002:a7b:c842:: with SMTP id c2mr9970774wml.28.1560082584755;
        Sun, 09 Jun 2019 05:16:24 -0700 (PDT)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id 32sm18825130wra.35.2019.06.09.05.16.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 05:16:24 -0700 (PDT)
Subject: Re: [RFC PATCH 1/6] ASoC: core: add support to
 snd_soc_dai_get_sdw_stream()
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     broonie@kernel.org, vkoul@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
 <20190607085643.932-2-srinivas.kandagatla@linaro.org>
 <13bfb632-f743-c416-2224-c7acb5b28604@intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <eef7ecf8-330f-c7e8-7d5e-f21d9771f037@linaro.org>
Date:   Sun, 9 Jun 2019 13:16:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <13bfb632-f743-c416-2224-c7acb5b28604@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking time to review,

On 08/06/2019 20:22, Cezary Rojewski wrote:
> On 2019-06-07 10:56, Srinivas Kandagatla wrote:
>> On platforms which have smart speaker amplifiers connected via
>> soundwire and modeled as aux devices in ASoC, in such usecases machine
>> driver should be able to get sdw master stream from dai so that it can
>> use the runtime stream to setup slave streams.
>>
>> soundwire already as a set function, get function would provide more
>> flexibility to above configurations.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   include/sound/soc-dai.h | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
>> index f5d70041108f..9f90b936fd9a 100644
>> --- a/include/sound/soc-dai.h
>> +++ b/include/sound/soc-dai.h
>> @@ -177,6 +177,7 @@ struct snd_soc_dai_ops {
>>       int (*set_sdw_stream)(struct snd_soc_dai *dai,
>>               void *stream, int direction);
>> +    void *(*get_sdw_stream)(struct snd_soc_dai *dai, int direction);
>>       /*
>>        * DAI digital mute - optional.
>>        * Called by soc-core to minimise any pops.
>> @@ -385,4 +386,13 @@ static inline int 
>> snd_soc_dai_set_sdw_stream(struct snd_soc_dai *dai,
>>           return -ENOTSUPP;
>>   }
>> +static inline void *snd_soc_dai_get_sdw_stream(struct snd_soc_dai 
>> *dai, int direction)
> 
> Exceeds character limit?
> 
>> +{
>> +    if (dai->driver->ops->get_sdw_stream)
>> +        return dai->driver->ops->get_sdw_stream(dai, direction);
>> +    else
>> +        return NULL;
> 
> set_ equivalent returns -ENOTSUPP instead.
> ERR_PTR seems to make more sense here.
> 
>> +
> 
> Unnecessary newline.

I agree with all the comment, will fix this in next version.

thanks,
srini
> 
>> +}
>> +
>>   #endif
>>
