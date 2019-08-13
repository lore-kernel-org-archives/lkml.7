Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0411C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37EE2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mW5YUm5w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfHMQwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 12:52:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56167 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfHMQwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 12:52:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id f72so2142047wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 09:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qLtqPAsEGfnUp7CDjhn/8fwHbe2P4gxMdN6KrPmONdo=;
        b=mW5YUm5wvdISB+s0lKeJ43zd9eGbsQWF9DRWounfZBtWcu4JLOB8EQRlfB/rDhjSgr
         DKFYgTyZvuGRIpRyo7qQJiookhVDTq8mKof/6PoFQpMuAM+rvAYNuvYwnDTgRkzkbdyU
         l8Ig2cdjFoG1SQZcfNSo37LhmGznPEbjJ1q+DnJbjMlS87365uyRdL1U7wa/OvK5KjYT
         Bfd5R1xpzaiOA8rPWtkmfraEvd+7lDXCVRvYHzjyC4ajwXRgI/RSEA6IZGu/HhYzuW99
         TK+Gqiy54WUYpU20s7CUL6nkjGvhth9kyeBHhMX+SUBxOI6HHqyzPJ6B0TrpYWy7HA6K
         0B5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qLtqPAsEGfnUp7CDjhn/8fwHbe2P4gxMdN6KrPmONdo=;
        b=kpd0XPBbzxf6TmEFiJtQnvikuBnyJ3OIempIL3EMQ0shbzZ6666L6hGgHnlqxT7TRP
         l2BqEAmT7az23Q8F6J+XK+ZJMiW5RxpAayAjkDQbkv+bitNhpFAJqyFEBye/722njPtA
         5kiFSfcWpCmhrZ+Zu2hzDPAaAHefK4HfHEJhW4oAtAWcShHqJbKBuOrhkH961rEc/QlC
         usFyqa/Wq/1r5WTQaZdVX6+mEqypfqr4D6vi8PhXkXqOMaNdUT7wt3attXIZC7c0eT8r
         2Mja9kqIbXsfaQtTkol7ufWKcFPsTOxXrl8OxyWUbEBB8wf3OT8mJRFXizYc4xB+uwei
         p2FA==
X-Gm-Message-State: APjAAAX4LtS/M9cYiYgmLQAaaQQ0L29yXyQk0i4eQekiWAdPPwnlwhye
        Ab1jWk0ur9L6aQVbMF4meZP7TA==
X-Google-Smtp-Source: APXvYqyDTslYtT+nos0C9th5ic6vn8MyRNZrZ/a7bFDyc53Tg0MzTNOzv1OYn9FBo/c6bVTFIpy9QQ==
X-Received: by 2002:a7b:c947:: with SMTP id i7mr4274787wml.77.1565715142658;
        Tue, 13 Aug 2019 09:52:22 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id z8sm25678055wru.13.2019.08.13.09.52.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 09:52:22 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] ASoC: core: add support to
 snd_soc_dai_get_sdw_stream()
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     vkoul@kernel.org, broonie@kernel.org, bgoswami@codeaurora.org,
        plai@codeaurora.org, pierre-louis.bossart@linux.intel.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, spapothi@codeaurora.org
References: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
 <20190813083550.5877-4-srinivas.kandagatla@linaro.org>
 <95c517ab-7c63-5d13-a03a-1db01812bb69@intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <71fb21d0-3083-e590-db83-dbe489a4357e@linaro.org>
Date:   Tue, 13 Aug 2019 17:52:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <95c517ab-7c63-5d13-a03a-1db01812bb69@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review,

On 13/08/2019 17:03, Cezary Rojewski wrote:
> On 2019-08-13 10:35, Srinivas Kandagatla wrote:
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
> 
> Drop redundant else.
Not all the dai drivers would implement this function, I guess else is 
not redundant here!

--srini
> 
