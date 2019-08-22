Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D195C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605FD2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R8OJYPLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388777AbfHVM4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 08:56:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37330 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387779AbfHVM4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 08:56:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id d16so5674891wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 05:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rpeKMI/tE6EFW9ANRr1XQ8WE1RGHTA5DL7LclXp1bOU=;
        b=R8OJYPLbiX6PDGAA9Foc4n9BE7hvuMj/LM+laL12+iN3ynxmIPecnk/ZitUnc4yJf3
         x3yeNl4JORj5UUgHXKdgISraJTxl7BWjt7qbqq56euafptc6q109RcFVVow+/WV/JGBb
         vl35AkKxY6R67atF/v4/srrrPrl+H8+oRxfw5grLYXqeGWq467d8+zPk5VMoOzjrwvT8
         doeHMm1kiNrQ0RhCgFTuTbPYwJUOnxnxUCgWv5xoA6lpt74ZG+CYavhEg/iUSqPPcKqE
         vkNtC6asp5ZSmnB9oh+ftJS977O0MXa1MXoCVMt/sv/xu5t3l7D4zcIJfpGPZXBsJntW
         IeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rpeKMI/tE6EFW9ANRr1XQ8WE1RGHTA5DL7LclXp1bOU=;
        b=NxfEsvFBDbWowi80LewjaLz8e8E6uTHhoSDRhh+tvF0Zlq1D3PmvNSRZSs8Ccx9kNu
         vyybYwqgp28p83g6GMqgOqHK07WL4dTWsAoIFqrkXvvC3inQrC5zEY1GFedK/h78YYKb
         SGjU6DyNseXzcbyrfQnIa2Rh4/vE50Z2zOE7U27W5GByEd4dnf+0LXjG77KZ1xrej1Q5
         cDqzGM/1NpJnbTsKAIUaKOPJfJgLkcDJ819l9MJosYu3J7qNSDO15JZr+JN5qAFimO2w
         fQPkTK3jJDPnwiUAzu77POdmbcJx4WKwaGfHkqYmoBWF18Q77cf2/t6an6BsGu/D4TRL
         K9gw==
X-Gm-Message-State: APjAAAWGGeBFOmprb/PiLNNR5L7GpV1NOxdKHdigys5D8CEr3IP6x9cg
        fSIpHihNv+5yt+8wfRy3KH8mrtKXAt4=
X-Google-Smtp-Source: APXvYqyO6aZlnWxHGBHK5szK1yStlylHBnKn6CHrS70h7pgw6i72AhORzAUhgOXoWe69T5EmcC2/uw==
X-Received: by 2002:a1c:a481:: with SMTP id n123mr5795028wme.123.1566478567074;
        Thu, 22 Aug 2019 05:56:07 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id t19sm5419487wmi.29.2019.08.22.05.56.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 05:56:06 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] dt-bindings: soundwire: add slave bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Vinod <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Patrick Lai <plai@codeaurora.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190809133407.25918-1-srinivas.kandagatla@linaro.org>
 <20190809133407.25918-2-srinivas.kandagatla@linaro.org>
 <20190821214436.GA13936@bogus>
 <0272eafd-0aa5-f695-64e4-f6ad7157a3a6@linaro.org>
 <CAL_JsqJJCJB9obR_Jn3hmn4gq+RQjY-8M+xkdYA185Uaw0MHcw@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <90b9fa33-3a49-c414-4352-66e26673a05d@linaro.org>
Date:   Thu, 22 Aug 2019 13:56:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJJCJB9obR_Jn3hmn4gq+RQjY-8M+xkdYA185Uaw0MHcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/08/2019 13:36, Rob Herring wrote:
>>>> +soundwire@c2d0000 {
>>>> +    compatible = "qcom,soundwire-v1.5.0"
>>>> +    reg = <0x0c2d0000 0x2000>;
>>>> +
>>>> +    spkr_left:wsa8810-left{
>>>> +            compatible = "sdw0110217201000";
>>>> +            ...
>>>> +    };
>>>> +
>>>> +    spkr_right:wsa8810-right{
>>>> +            compatible = "sdw0120217201000";
>>> The normal way to distinguish instances is with 'reg'. So I think you
>>> need 'reg' with Instance ID moved there at least. Just guessing, but
>>> perhaps Link ID, too? And for 2 different classes of device is that
>>> enough?
>> In previous bindings (https://lists.gt.net/linux/kernel/3403276  ) we
>> did have instance-id as different property, however Pierre had some good
>> suggestion to make it align with _ADR encoding as per MIPI DisCo spec.
>>
>> Do you still think that we should split the instance id to reg property?
> Assuming you could have more than 1 of the same device on the bus,
> then you need some way to distinguish them and the way that's done for
> DT is unit-address/reg. And compatible strings should be constant for
> each instance.
That is a good point!
Okay that makes more sense keep compatible string constant.
Class ID would be constant for given functionality that the driver will 
provide.

So we will end up with some thing like this:

soundwire@c2d0000 {
	compatible = "qcom,soundwire-v1.5.0"
	reg = <0x0c2d0000 0x2000>;	
         #address-cells = <1>;
         #size-cells = <0>;

	spkr_left:skpr@1{
		compatible = "sdw10217201000";
		reg = <0x1>
		sdw-link-id = <0>;
		...
	};

	spkr_right:spkr@2{
		compatible = "sdw10217201000";
		reg = <0x2>
		sdw-link-id = <0>;
	};
};

I will spin this in next version!

Thanks,
srini

> 
> Rob
