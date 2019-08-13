Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A842BC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CCE20842
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bKMLUItM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfHMQuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 12:50:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36046 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfHMQub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 12:50:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id r3so14657585wrt.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 09:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aKvLEBrboAAMmqe7EmfIffBPlfVah4vs5sU/D2WtTTk=;
        b=bKMLUItM7LDgUcobeGYy8P3icWVnNx8Klnu3auuhG8PD1xqwrb760Ne3pEwFYP6sxu
         Y7tgimXS45klNXWRHUvIl3yZC9iNEV6N1cqTOQMWjM2sjJw12lba8BWIYKGqxVtH3uik
         7C5q1+BTh+uqzDCkkumcg2eDUiWVvB9F8RvB0cfeEqqcB5BRiuA6wRPkAR0erwtcl+c5
         11YfDR/PNQqZEPkspAGURLcl40rl55DhpUM95vc/3GQSdBHwVEuSLN5C1w9jfTrVKOGR
         04uQ+7WpUlDmaOMhVSi0+9qk0U3bXnO+1stLVtAjQRxNEnwnASBEic0xR/ZOu9XxkouW
         PaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aKvLEBrboAAMmqe7EmfIffBPlfVah4vs5sU/D2WtTTk=;
        b=QBYxM5rnZw0enlVTG6AI9c9voXCXeJObGVaXnAzhf9Nn5W2VZ5MjZ6Krt168jqx2qT
         rHBNT4AYQwhVrc6DTpO/nAgm93QjDT6zKsEiRr/azDd3uyQQAWVZ4dY9urmCJJnavlRh
         lLqWrzSkJ9FxoIFnEUDsi7osw+3jxNVPNblVxXZpnzfo3X3grfFeNlRm3U2X37jw2KGo
         nFIL1iJXO59aLcV4kIm8IJ4FNczdzWjup0TJqiUOPbqN+IxWLwQIaxhvkBya/u6PPeFZ
         WE0ZdQnsRV85mv+h8rKP7gmZ2XZNF9Sfu2cgHgHt5x8Zkpp44jQoMgQhg8rsZ+30wC8h
         3bHg==
X-Gm-Message-State: APjAAAWZFpuFgtkWJ1mz1a0UKGo1SKBHbTDX1D64horBuavnJVfkWLNu
        oq8ZQNCaC7kdAyHt0yIHWe04HA==
X-Google-Smtp-Source: APXvYqyJ2a2crFUAczycMXxjsyULBrI0V7zj0hw5av3nQ6bDKMWetw+A+Y/KwO1urJjvcDDsOyXRyA==
X-Received: by 2002:adf:dbcc:: with SMTP id e12mr38340576wrj.205.1565715030029;
        Tue, 13 Aug 2019 09:50:30 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id a11sm11294262wrx.59.2019.08.13.09.50.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 09:50:29 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH v2 3/5] ASoC: core: add support to
 snd_soc_dai_get_sdw_stream()
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org, broonie@kernel.org
Cc:     bgoswami@codeaurora.org, plai@codeaurora.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org
References: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
 <20190813083550.5877-4-srinivas.kandagatla@linaro.org>
 <ba88e0f9-ae7d-c26e-d2dc-83bf910c2c01@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <c2eecd44-f06a-7287-2862-0382bf697f8d@linaro.org>
Date:   Tue, 13 Aug 2019 17:50:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ba88e0f9-ae7d-c26e-d2dc-83bf910c2c01@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review,

On 13/08/2019 15:44, Pierre-Louis Bossart wrote:
> On 8/13/19 3:35 AM, Srinivas Kandagatla wrote:
>> On platforms which have smart speaker amplifiers connected via
>> soundwire and modeled as aux devices in ASoC, in such usecases machine
>> driver should be able to get sdw master stream from dai so that it can
>> use the runtime stream to setup slave streams.
> 
> using the _set_sdw_stream? I don't fully get the sequence with the 
> wording above.

Yes, using set_sdw_stream().

> 
>>
>> soundwire already as a set function, get function would provide more
>> flexibility to above configurations.
> 
> I am not clear if you are asking for both to be used, or get only or set 
> only?

It depends on the usecase, in db845c usecase  [1] as Aux device is dai 
less, machine driver is using get function to get hold of master stream 
so that it can setup slave port config.


Looks like there is a typo in above like

This was supposed to be "soundwire already has a set function, get 
function would provide more flexibility to above configurations"

[1] 
https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/tree/sound/soc/qcom/db845c.c?h=integration-linux-qcomlt

thanks,
srini

> 
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   include/sound/soc-dai.h | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
>> index dc48fe081a20..1e01f4a302e0 100644
>> --- a/include/sound/soc-dai.h
>> +++ b/include/sound/soc-dai.h
>> @@ -202,6 +202,7 @@ struct snd_soc_dai_ops {
>>       int (*set_sdw_stream)(struct snd_soc_dai *dai,
>>               void *stream, int direction);
>> +    void *(*get_sdw_stream)(struct snd_soc_dai *dai, int direction);
>>       /*
>>        * DAI digital mute - optional.
>>        * Called by soc-core to minimise any pops.
>> @@ -410,4 +411,13 @@ static inline int 
>> snd_soc_dai_set_sdw_stream(struct snd_soc_dai *dai,
>>           return -ENOTSUPP;
>>   }
>> +static inline void *snd_soc_dai_get_sdw_stream(struct snd_soc_dai *dai,
>> +                           int direction)
>> +{
>> +    if (dai->driver->ops->get_sdw_stream)
>> +        return dai->driver->ops->get_sdw_stream(dai, direction);
>> +    else
>> +        return ERR_PTR(-ENOTSUPP);
>> +}
>> +
>>   #endif
>>
> 
