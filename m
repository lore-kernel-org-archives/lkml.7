Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7D9C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 12:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B022F217AB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 12:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="YzG0xK1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfK1MTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 07:19:43 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51856 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfK1MTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 07:19:43 -0500
Received: by mail-wm1-f65.google.com with SMTP id g206so10753072wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 04:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BWz2ZM0iVkn7qtCeMiE174FhJ8PK/VMK9gzTnGG8u34=;
        b=YzG0xK1cKVK0hRKr296mjhXq3h8XQSUQKI5keNetAFIDb8hoezeSSEFPnNE5IV+A7m
         RBFb0B7Tng9VBLTJcyuHVUqJnAh7m9xoizXG0oWmAq8DBVMQdTcjETujufx3UgORCz8U
         WGfJgux0RsiSO7Vs2/OStvDKq8/e5g+mAp6ronVbf73uC27PqSi3zyCZp8VEkjIAhG/i
         F615tmRYUGu0ZGOOAjMZy/41RNKFscivewTrlhN8Hs4JC1z1Pny+ze+vYCMnSeUrVTRs
         ajP+71np3xSzsR2V4SSNl4ofM4K4+4LfAzwqAb54ANQgsejLFZUF3Xo9Ru4C3FsBya/x
         VFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BWz2ZM0iVkn7qtCeMiE174FhJ8PK/VMK9gzTnGG8u34=;
        b=J25KRxdsM1Hloc8ZDpo7ZAuEAjPvHgZ9rBqvVfNFE0V5BvmTCyH8o8gRRksVd1R3Uk
         lCGoR7560wur8872L0eZxAllNaSbz+bPD5el2ywND9uVf8Q8+7ReLXvZ+pz2PiX/iRT1
         ZhVHysxeCVPQXvJ4USk5XmzA0R3XB+FlxuNu48ruu1ZGsk1ArOFS6eYB0wKmG2IVfwY/
         m2pQ27QlrzHWgrWdw9OIIrixP9cusc52ANZ9WoIO9tiDFqV3dPQ/C/nIJ2ZXWFk5n6pg
         Wwchdpd8O5XvApH2+MIPJ5N5CfGl3ZdjpeO24GHeY4dLKdKt0/m1ej8lgSgWPMCKOfyF
         s04w==
X-Gm-Message-State: APjAAAWMf+AujKy5csHZOuRVQaFb6qBL6QygMMadpay+WSpjWhRR/l+o
        AhdLr6UpqPplQSdiBqtJuP/OgA==
X-Google-Smtp-Source: APXvYqy5pUWFqDnj3jL4S55vfeNSWZl7DWu+0uoeX4F5VGvWes7K5XEgYiLYwb8lGGbOKk8/hYYMyw==
X-Received: by 2002:a7b:c4c8:: with SMTP id g8mr8771198wmk.36.1574943581198;
        Thu, 28 Nov 2019 04:19:41 -0800 (PST)
Received: from [192.168.112.17] (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id c10sm10150754wml.37.2019.11.28.04.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 04:19:40 -0800 (PST)
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Add HP output driver pop reduction
 controls
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "Andrew F. Davis" <afd@ti.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>
References: <20191128093955.29567-1-nikita.yoush@cogentembedded.com>
 <20191128121128.GA4210@sirena.org.uk>
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <ecfa48d3-284b-5234-02b9-adc0c6892b6f@cogentembedded.com>
Date:   Thu, 28 Nov 2019 15:19:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191128121128.GA4210@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +static const char * const hp_poweron_time_text[] = {
>> +	"0us", "15.3us", "153us", "1.53ms", "15.3ms", "76.2ms",
>> +	"153ms", "304ms", "610ms", "1.22s", "3.04s", "6.1s" };
>> +
>> +static SOC_ENUM_SINGLE_DECL(hp_poweron_time_enum, AIC31XX_HPPOP, 3,
>> +	hp_poweron_time_text);
>> +
>> +static const char * const hp_rampup_step_text[] = {
>> +	"0ms", "0.98ms", "1.95ms", "3.9ms" };
>> +
>> +static SOC_ENUM_SINGLE_DECL(hp_rampup_step_enum, AIC31XX_HPPOP, 1,
>> +	hp_rampup_step_text);
> 
> I'm not seeing any integration with DAPM here, I'd expect to see that so
> we don't cut off the start of audio especially with the longer times
> available (which I'm frankly not sure are seriously usable).

I believe driver already has that integration, there is aic31xx_dapm_power_event() that is called on 
DAPM events, and polls state in register bits waiting for operation to complete.

Btw, the default setting for register fields in question is "304ms" / "3.9ms" thus some delay is already 
there. This patch just makes it explicitly controllable by those who wait it.
