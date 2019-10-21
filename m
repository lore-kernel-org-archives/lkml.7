Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A98CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86D8205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p59UqSQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfJUMON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:14:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40161 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728322AbfJUMON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:14:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id o28so13699068wro.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 05:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7jxHvlIH/GHF2NGpOLWHwkTRpolnPbX/bJ9AbQhHZ50=;
        b=p59UqSQ7ok5T84ox4VFBup57p/nWydONjxf/yNkt7WFcO4wBEmH+YWZ+pQ6Xd9sjdE
         gSUIbcE9ffJQyI/0jl2S6ISp+GqiCmZ4CwtinHAkZf3ssil2Cwd6xHNN922f8P6xmbJM
         1A7w4V4M4aiTNuhFnQdbTE7z3a0w/dAevMvbtl1SHXmxhWzi6KF9O2CXkLIuoQfkfoVZ
         3UyWrMyNdhTb3JGhDiNqUStJdxz5TF+KqxiY1i2V32UCm4MEszjBdPKhce7iMZSsKThJ
         n3wht5xCgM8UzqK/jPTh998UCkiYDCDp3nlKnmBkv+6TTkmV/t5UKE5TBBS9ixIRcHNr
         xDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7jxHvlIH/GHF2NGpOLWHwkTRpolnPbX/bJ9AbQhHZ50=;
        b=cPkOgQIt4aOg8jR0QR5j3FYjrmoAjVUdHNKQM91YiNIAYGRgOyzozTnePb4cVSqCmR
         Y7p0YI9ADgA8Wq53G+SdyIZwqVrgrBe6axF3wfgDxJp8x9pAA+LvVLR1EcRbthKQojxY
         kutR74i2wy5VR5PQm7EJJO8GKT/Kj6HPoUEUaMhPmAvnTzNc3oaqo0H9GRJO7njlQJu4
         F31uD6uYsinBjnaz0SyJxpvpehDFM5o2UUAkWRzGduccFuB/rv3cV8SEr+md9vSfyeQk
         bNjHQzACqXlOjetgdRrwAId61KZv9zYnSUD5fSxECUeCkSYCfn+ymGuZxLwahYlQCBWk
         xjJw==
X-Gm-Message-State: APjAAAV3ogsnJxq5pM3G7BsrFcQ5WCedZYTZI8WKyxl5gwn3JOuIkIY+
        SGe9kQfxpbBVnpx0HVtUunLFWcU/Rc0=
X-Google-Smtp-Source: APXvYqwTt8mxKUqo1qn5DUbfyQDPqC2LuHol4HuaS/wKQN/yN5gkLQelG0gG10cVmYyY/ZB7AYYyLw==
X-Received: by 2002:adf:ea86:: with SMTP id s6mr18677166wrm.397.1571660051249;
        Mon, 21 Oct 2019 05:14:11 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id l18sm18941821wrn.48.2019.10.21.05.14.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 05:14:10 -0700 (PDT)
Subject: Re: [PATCH v2 02/11] mfd: wcd934x: add support to wcd9340/wcd9341
 codec
To:     Lee Jones <lee.jones@linaro.org>
Cc:     robh@kernel.org, broonie@kernel.org, linus.walleij@linaro.org,
        vinod.koul@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org, bgoswami@codeaurora.org,
        linux-gpio@vger.kernel.org
References: <20191018001849.27205-1-srinivas.kandagatla@linaro.org>
 <20191018001849.27205-3-srinivas.kandagatla@linaro.org>
 <20191021104611.GZ4365@dell>
 <1af8a875-8f55-6b7e-4204-ecedc1608889@linaro.org>
 <20191021114520.GD4365@dell>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <38dde3d9-8d7e-7dc0-7cba-137b43cea9d1@linaro.org>
Date:   Mon, 21 Oct 2019 13:14:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191021114520.GD4365@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/10/2019 12:45, Lee Jones wrote:
> On Mon, 21 Oct 2019, Srinivas Kandagatla wrote:
> 
>> Thanks Lee for taking time to review.
>>
>> I agree with most of the style related comments, will fix them in next
>> version. For others I have replied it inline.
> 
> [...]
> 
>>>> +static int wcd934x_slim_status(struct slim_device *sdev,
>>>> +			       enum slim_device_status status)
>>>> +{
>>>> +	struct device *dev = &sdev->dev;
>>>> +	struct wcd934x_data *wcd;
>>>> +	int ret;
>>>
>>> This is semantically odd!  Why are you doing most of the
>>> initialisation and bring-up in 'status' and not 'probe'.  Seems
>>> broken to me.
>>
>> SLIMBus device will not be in a state to communicate before enumeration (at
>> probe), so all the device initialization is done in status callback where it
>> is ready for communication.
> 
> Why do we need the device to be up *before* calling probe?
> 

To Initialize the device.
And SLIMbus device registers access can not be done before enumeration.


>> This is same with SoundWire Bus as well!
> 
> [...]
> 
>>>> +	struct device *dev;
>>>> +	struct clk *extclk;
>>>> +	struct regmap *regmap;
>>>> +	struct slim_device *sdev;
>>>
>>> You don't need 'sdev' and 'dev'.
>>
>> slim_device instance (sdev) is required by audio codec driver to allocate
>> stream runtime.
> 
> You can extrapolate one from the other.
That is possible to do! I can give that a try and see in next version!

> 
