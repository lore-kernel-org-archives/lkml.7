Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE44C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 09:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C57206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 09:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TuHziGI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfHXJ2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 05:28:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35503 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfHXJ2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 05:28:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so11290212wmg.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2019 02:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zo965yYSGqb8bD4x2EypL21hFRTb95lRpBchUKxraiE=;
        b=TuHziGI6AfbI1Kuy0OQ1kygyW8xn4FAKLazEENYj8VPvkldA//5vm/dgH0+xVuZx14
         tkT6llIsrwTyokSfhZgJOYqkNMjvJgvHidUAVbYW/7RGar56ohaLaQbeHESb05JuBSC2
         NM76IW6gtS1QA9I+1XRbBxFG6xlK7Sh3KhhFhnlvuovONgvGGFgc/x9SGYpBACZsYtqi
         034qAW47LP5Y3RI1NpEyi6gOZPdnsyGveM8wRDVRemkvq/SydyTKy97XrJuPRuOatWuz
         hGHeqjoZULuC/UmSXmBQG4H5VzlhH9nIW5aoSLZkUDPxnTehDME4zWw2YDjrR7wKn3bM
         GQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zo965yYSGqb8bD4x2EypL21hFRTb95lRpBchUKxraiE=;
        b=d+ytdGPjqJGE1l2nLOhA4+2+vy/LhBatkOm83qfM7pQEhGMdt+DCpjoQYVGvVIydUL
         xXvZCpPOwUl+YzscVzybwQrL7giB9iVe6NF3DRQ6t+1NRj9kW8t3gXIPql26X1flPMTO
         D0t8dW7xe6CxQrUeRXnxTgSwXJIsRXEhmoXg7/uzdMGSIQgbfYknsVZyTMo54XckGu3n
         oi03BDHX3KQFkZoe8yhSsVu5Fx8H4Bsp8MgXbCdKRNrzKMnRbkQODLv3MyViVr9if5b5
         SFH/LBQ8PefdB5CV5bAv+ALCtoL4V2bPg/N004nteUjaVSvHT/4guk1OLnK1BV0/Fjg5
         Msag==
X-Gm-Message-State: APjAAAVxWK7HY+FqPJQgemI1rI9fWfxmeY56Zf/KlIf/jtSBWuSERRYP
        frWJS7lc1RvSVzn2ydljefmEtgog0/8=
X-Google-Smtp-Source: APXvYqwz3U/TghRbVyV88lkhhqltT+Y394ij6+j58+VszZyqblPtGXpd66unQ4zGBmBYW+D8/WNiuQ==
X-Received: by 2002:a1c:6387:: with SMTP id x129mr9751912wmb.166.1566638891646;
        Sat, 24 Aug 2019 02:28:11 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id b15sm4627906wrt.77.2019.08.24.02.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Aug 2019 02:28:10 -0700 (PDT)
Subject: Re: [alsa-devel] [RESEND PATCH v4 1/4] dt-bindings: soundwire: add
 slave bindings
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, robh+dt@kernel.org, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, spapothi@codeaurora.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org
References: <20190822233759.12663-1-srinivas.kandagatla@linaro.org>
 <20190822233759.12663-2-srinivas.kandagatla@linaro.org>
 <7da8aa89-2119-21d1-0e29-8894a8d40bf0@linux.intel.com>
 <37be6b6d-7e7f-2cd6-f9e9-f0cac48791ad@linaro.org>
 <d538238d-25d8-f179-c900-90be50ce814d@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <7ee47f26-12f8-6028-cb83-7f59e669979f@linaro.org>
Date:   Sat, 24 Aug 2019 10:28:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d538238d-25d8-f179-c900-90be50ce814d@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/08/2019 17:44, Pierre-Louis Bossart wrote:
> 
> 
> On 8/23/19 10:57 AM, Srinivas Kandagatla wrote:
>>
>>
>> On 23/08/2019 16:41, Pierre-Louis Bossart wrote:
>>>
>>>
>>> On 8/22/19 6:37 PM, Srinivas Kandagatla wrote:
>>>> This patch adds bindings for Soundwire Slave devices that includes how
>>>> SoundWire enumeration address and Link ID are used to represented in
>>>> SoundWire slave device tree nodes.
>>>>
>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>> ---
>>>>   .../soundwire/soundwire-controller.yaml       | 75 
>>>> +++++++++++++++++++
>>>>   1 file changed, 75 insertions(+)
>>>>   create mode 100644 
>>>> Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
>>>>
>>>> diff --git 
>>>> a/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml 
>>>> b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
>>>> new file mode 100644
>>>> index 000000000000..91aa6c6d6266
>>>> --- /dev/null
>>>> +++ 
>>>> b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
>>>> @@ -0,0 +1,75 @@
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: 
>>>> http://devicetree.org/schemas/soundwire/soundwire-controller.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: SoundWire Controller Generic Binding
>>>> +
>>>> +maintainers:
>>>> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>> +
>>>> +description: |
>>>> +  SoundWire busses can be described with a node for the SoundWire 
>>>> controller
>>>> +  device and a set of child nodes for each SoundWire slave on the bus.
>>>> +
>>>> +properties:
>>>> +  $nodename:
>>>> +    pattern: "^soundwire(@.*|-[0-9a-f])*$"
> 
> re-reading this, it looks like you are defining the controller bindings, 
> but there are no real controller-level properties except for the fact 
> that they include slave bindings?
> 
Yes, Each vendor specific master can have there specific properties 
here, this is just to represent how slave nodes represented w.r.t to 
master nodes.

> In MIPI the notion of controller is that it can deal with multiple 
> links, each of which having specific properties (clock speed, clock stop 
> properties, etc).
> 
>>>> +
>>>> +  "#address-cells":
>>>> +    const: 2
>>>> +
>>>> +  "#size-cells":
>>>> +    const: 0
>>>> +
>>>> +patternProperties:
>>>> +  "^.*@[0-9a-f]+$":
>>>> +    type: object
>>>> +
>>>> +    properties:
>>>> +      compatible:
>>>> +      pattern: "^sdw[0-9][0-9a-f]{4}[0-9a-f]{4}[0-9a-f]{2}$"
>>>
>>> So is this a 64-bit value, as in the MIPI spec, or is this part of 
>>> the _ADR description?
>>
>> Rob did not like encoding compatible string exactly like _ADR encoding.
>>
>> https://lkml.org/lkml/2019/8/22/490
> 
> Wondering if we are talking about different concepts?
> 
> Rob's point was about the InstanceID
> 
> "Assuming you could have more than 1 of the same device on the bus,
> then you need some way to distinguish them and the way that's done for
> DT is unit-address/reg. And compatible strings should be constant for
> each instance."
> 
> You can use the MIPI encoding *except* for the InstanceID, that'd be 
> fine. It'll just be a bit weird since the Slave device will report the 
> 48 bits that include the Instance ID, so you'll have to special case 
> this field, but if this is a DT requirement then fine.
> 
> Rob's point does not apply to the link ID - which is used when you have 
> multiple masters in your controller. The Slave device is attached in one 
> location and will never move, so that is a constant value.

Point is that this compatible is for slave device, it should not matter 
where and how the slave is connected, compatible should be constant 
irrespective of Link ID.
Lets say for example if WSA881x slave device is connected to a 
single-Link Controller and the same device is connected to a 
MultiLink-controller then we would endup in more than one compatible 
string for WSA881x driver.


 From Disco Specic it clearly says that LinkID values are relative
to the immediate parent Device. So having LinkID in compatible string is 
very fragile.

> 
>>
>>> I also don't get why the first item in in base10?
>>>
>>
>> As this corresponds to Soundwire Version, and I have no visibility of 
>> version number encoding after reaching number 9 in this field.
>>
>> This can be updated once we have more info on how the Version encoding 
>> will look like in future.
>>
>> Idea of limiting regex to [0-9] for version is to enforce some checking!
> 
> the version is a 4 bit value starting at 1 for SoundWire 1.0. There is 
> nothing in the spec that talks about a limit to 9.
> 
> It's unlikely we'll ever reach that but you are interpreting a spec 
> here. plus just below you mention all fields as being hexadecimal.
> 
Am happy to change this to

pattern: "^sdw[0-9a-f][0-9a-f]{4}[0-9a-f]{4}[0-9a-f]{2}$"

if you are okay with rest of the stuff.

thanks,
srini
>>
>> --srini
>>
>>>
>>>> +      description:
>>>> +      Is the textual representation of SoundWire Enumeration
>>>> +      address. compatible string should contain SoundWire Version ID,
>>>> +      Manufacturer ID, Part ID and Class ID in order and shall be in
>>>> +      lower-case hexadecimal with leading zeroes.
>>>> +      Valid sizes of these fields are
>>>> +      Version ID is 1 nibble, number '0x1' represents SoundWire 1.0
>>>> +      and '0x2' represents SoundWire 1.1 and so on.
>>>> +      MFD is 4 nibbles
>>>> +      PID is 4 nibbles
>>>> +      CID is 2 nibbles
>>>> +      More Information on detail of encoding of these fields can be
>>>> +      found in MIPI Alliance DisCo & SoundWire 1.0 Specifications.
>>>> +
>>>> +      reg:
>>>> +        maxItems: 1
>>>> +        description:
>>>> +          Instance ID and Link ID of SoundWire Device Address.
>>>> +
>>>> +    required:
>>>> +      - compatible
>>>> +      - reg
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    soundwire@c2d0000 {
>>>> +        #address-cells = <2>;
>>>> +        #size-cells = <0>;
>>>> +        compatible = "qcom,soundwire-v1.5.0";
>>>> +        reg = <0x0c2d0000 0x2000>;
>>>> +
>>>> +        speaker@1 {
>>>> +            compatible = "sdw10217201000";
>>>> +            reg = <1 0>;
>>>> +        };
>>>> +
>>>> +        speaker@2 {
>>>> +            compatible = "sdw10217201000";
>>>> +            reg = <2 0>;
>>>> +        };
>>>> +    };
>>>> +
>>>> +...
>>>>
