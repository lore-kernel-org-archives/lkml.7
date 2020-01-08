Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4829FC33C9B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9C220705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b9NjNWMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgAHIbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:31:11 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41430 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbgAHIbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:31:10 -0500
Received: by mail-ed1-f65.google.com with SMTP id c26so1855077eds.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 00:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nDs1T93B8v5O40q4fibGGoHo0SYxTJ1NHmqT2ydaTtQ=;
        b=b9NjNWMouhdpSZtVq012+7zvznVTp6QoZw51rmP4BNezumhjhJquZYaI6v/glUqFFc
         D9A4WNgMg18sR1bYHIAYMamQSAr+wbCD7vS4JxSqtjLGsQahp9fjoLWJgSAbiN4WTo4O
         Tmf9quFCyhzeh4Qs15QxtY1pnKC96mV0T6W5ESv/IlqMHhYm7SZkYLjz87po6wHuXMip
         35vnLTT4gwexuJRzIbJearbTuSjvYO3tzzCv7zRRV77JK/VHOPdORCSRvCpxA+kxWuNi
         /15egs5vLzmfJA8llCr/BnDfHwPZ/DDKAYAGSn4R+JDWCXW+7Hl7WcQMBE3n5z+yghjb
         O9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nDs1T93B8v5O40q4fibGGoHo0SYxTJ1NHmqT2ydaTtQ=;
        b=pRlvdZk8NdYM0YEI3EaIua6wubPjJXhRDAozrLqZ5ILHPvIBPn7kRk3KAddK4JFBvl
         6blfdB+gmr266WchDZiHDchpB/l4E6aNnvAdrGK1Tm4nUDCiqErqTNR1yJRpGNoQL2oP
         7txb5aMseIksjFIf9FpdS7B3eEa6p2gDURnTR/GFUVGSeEB1CW4xAb2PRrkIc4EDo4BC
         1Q4PTW4TYMo8dOEnBJoi0Ydj1uumz9qxOehllWkfB2IHdbAMDevyTO+3Oj7SN21swuuv
         /TBM1plidr8pkieurl0lV5C59GUm1hDs7JQBc/K+6sl3hJUcNVwD8Pm3K063uDBje1Zt
         FSIg==
X-Gm-Message-State: APjAAAXOQOo6575vo97KodpB/YWcjoDUFX5mLvr5598sS52eHx0g06od
        bED9VTVADmgtNZ2GWs6G4yAgeA==
X-Google-Smtp-Source: APXvYqwPCVmrHuNQsu+V3IVoJ6JlOom1LqJ0JNrlLBv+rc79vCsB3yVJlQZi8FK9es6qo7D5qIk82Q==
X-Received: by 2002:a17:906:c44a:: with SMTP id ck10mr3605843ejb.149.1578472268962;
        Wed, 08 Jan 2020 00:31:08 -0800 (PST)
Received: from [192.168.27.209] ([37.157.136.193])
        by smtp.googlemail.com with ESMTPSA id u21sm58393edv.43.2020.01.08.00.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 00:31:07 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: qcom: add Venus firmware node on Cheza
To:     Rob Clark <robdclark@gmail.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        linux-media@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vikash Garodia <vgarodia@codeaurora.org>
References: <20200107143402.122455-1-acourbot@chromium.org>
 <3aef91ea-30c1-530f-0c18-ea52b92347f9@linaro.org>
 <CAF6AEGvgYB8w_GD-6_XywKk4XkS6bFFCiJHeY-CSz71Foz7JTg@mail.gmail.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <1d31b609-9bae-8bbd-0329-f27f59b4533e@linaro.org>
Date:   Wed, 8 Jan 2020 10:31:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAF6AEGvgYB8w_GD-6_XywKk4XkS6bFFCiJHeY-CSz71Foz7JTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/7/20 7:42 PM, Rob Clark wrote:
> On Tue, Jan 7, 2020 at 6:51 AM Stanimir Varbanov
> <stanimir.varbanov@linaro.org> wrote:
>>
>> Hi Alex,
>>
>> On 1/7/20 4:34 PM, Alexandre Courbot wrote:
>>> Cheza boards require this node to probe, so add it.
>>>
>>> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 6 ++++++
>>>  arch/arm64/boot/dts/qcom/sdm845.dtsi       | 2 +-
>>>  2 files changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
>>> index 9a4ff57fc877..35ba65cd9822 100644
>>> --- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
>>> @@ -1279,3 +1279,9 @@ config {
>>>               };
>>>       };
>>>  };
>>> +
>>> +&venus_codec {
>>
>> We have similar patch for sc7180 and call it just "venus". Do you think
>> we should shorten it here too?
>>
>>> +     video-firmware {
>>> +             iommus = <&apps_smmu 0x10b2 0x0>;
>>> +     };
> 
> 
> btw Stan, not sure if you noticed, but Bjorn started adding
> firmware-name properties so we can have different device specific
> subdirectories for signed fw (ie. so one /lib/firmware can work on
> multiple different devices).  I'm just looking at doing the same thing
> for gpu zap fw.  Afaiu the venus fw is also signed, so I guess it
> could benefit from the same treatment?  Not sure if that is something
> you've already talked with Bjorn about?

I have to check does Venus fw is signed with device specific keys or
with something else (like HMAC).

Cc: Vikash for opinion

> 
> BR,
> -R
> 
>>> +};
>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> index ddb1f23c936f..7b913688cc6d 100644
>>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> @@ -2567,7 +2567,7 @@ usb_2_dwc3: dwc3@a800000 {
>>>                       };
>>>               };
>>>
>>> -             video-codec@aa00000 {
>>> +             venus_codec: video-codec@aa00000 {
>>>                       compatible = "qcom,sdm845-venus";
>>>                       reg = <0 0x0aa00000 0 0xff000>;
>>>                       interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
>>>
>>
>> --
>> regards,
>> Stan

-- 
regards,
Stan
