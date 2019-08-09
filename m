Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA13FC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FCEB2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k31HPisK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405854AbfHIIZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 04:25:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33784 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405713AbfHIIZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 04:25:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id p77so5684428wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 01:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Yi51TwivV5MGEpDQ4mr9gOZ4jMyu3GWtUO7Aw8f23Cg=;
        b=k31HPisK11a8kdaMYCVnBq9a23l36+ZiSRXZYFd8rhpmKaN19iKyV2V8FpC9WyOo49
         xbCvbeXm0iZSwkXRFsChD+2SKvpOANVY+0EnL7YMQ/1zPwATASIZNlI78Itx3+HNQKeF
         N56Te+9xFz538p5Z0MJv619MbNDjsPZxz2mFWyG0scevzGLJML2+97SGQIZhNk9woLiC
         GSjwMfx7Ep8kkdiCSl9HYok3FchGsWGhHenE0HuIfuK4xrBgkbXMGn7AQ5HfTi019+rg
         2e52LOMCjYjO6GVQxYmp3PSsGLAeCeIyn690a2wRLZRdh2b1/lny+ISvnNsLEyZ4dzxJ
         vPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yi51TwivV5MGEpDQ4mr9gOZ4jMyu3GWtUO7Aw8f23Cg=;
        b=ZSfurLcPlq2Q7lcxH0eUpXg8J12mDnF1OVNMKizzgUMyB4kJFWPoqHwQWFIaLzUhwb
         rq9obYDEmjG1qTmV45m8JlDzw0pUCq8TgKy727u1GHWAJ6rTXQLucOkRbFec8ZTKFwJ7
         wQlvkY+LpGBox0uJYCJxD4e0I6X/ZBtOQnggRN3PX/MI5cGMGewxRz4whHQzjSPoyTka
         2LYM2HomFMejXnBeFZxYXK8DORmnzdLbJEeI0KyYw/CFfwDIPg52rgYOyQuOut8p+0K+
         jeyNWgNkjDMS+PKgBBDI4XUCgdL0xmqEFQdrjfxOVCIsdhXI5sfoqa6AjmLtlqSq5A+b
         bwlA==
X-Gm-Message-State: APjAAAW/s1YxwKtGWAUVeJ19jhRfRvhwF6nqT1JhlqOagtUZf0h9PE8a
        ZjTqrbQDyrdXB9gAmaxJ/V8lare8d4g=
X-Google-Smtp-Source: APXvYqxmshOw7dTQDg6nbnPuSCdUFhK3cdBxHTZCHyDyesCDw8lBQVlcoBBFYsEYjAjRewuVrK0BJg==
X-Received: by 2002:a1c:d10c:: with SMTP id i12mr9410070wmg.152.1565339102184;
        Fri, 09 Aug 2019 01:25:02 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id m7sm81060799wrx.65.2019.08.09.01.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 01:25:01 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] dt-bindings: soundwire: add slave bindings
To:     Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        bgoswami@codeaurora.org, plai@codeaurora.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20190808144504.24823-1-srinivas.kandagatla@linaro.org>
 <20190808144504.24823-2-srinivas.kandagatla@linaro.org>
 <d346b2af-f285-4c53-b706-46a129ab7951@linux.intel.com>
 <cdd2bded-551c-65f5-ca29-d2bb825bdaba@linaro.org>
 <20190808195216.GM3795@sirena.co.uk>
 <20190809045459.GG12733@vkoul-mobl.Dlink>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <144f1ed7-c654-eaeb-066e-bf29d6e12d65@linaro.org>
Date:   Fri, 9 Aug 2019 09:25:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190809045459.GG12733@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/08/2019 05:54, Vinod Koul wrote:
> On 08-08-19, 20:52, Mark Brown wrote:
>> On Thu, Aug 08, 2019 at 05:48:56PM +0100, Srinivas Kandagatla wrote:
>>> On 08/08/2019 16:58, Pierre-Louis Bossart wrote:
>>
>>>>> +- sdw-instance-id: Should be ('Instance ID') from SoundWire
>>>>> +          Enumeration Address. Instance ID is for the cases
>>>>> +          where multiple Devices of the same type or Class
>>>>> +          are attached to the bus.
>>
>>>> so it is actually required if you have a single Slave device? Or is it
>>>> only required when you have more than 1 device of the same type?
>>
>>> This is mandatory for any slave device!
>>
>> If it's mandatory the wording is a bit unclear.  How about something
>> like:
>>
>> 	Should be ('Instance ID') from the SoundWire Enumeration
>> 	Address.  This must always be provided, if multiple devices
>> 	with the same type or class or attached to the bus each
>> 	instance must have a distinct value.
> 
> That helps to make it clear.
> 
> Also the section of properties starts with Mandatory property, it should
> be made Mandatory Properties instead, like in other binding docs to make
> it clear that properties mentioned in the section are mandatory

Will update as suggested!

thanks,
srini
> 
