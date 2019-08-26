Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22A4C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 18:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973FA2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 18:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387520AbfHZSzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 14:55:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:26688 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727559AbfHZSzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 14:55:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 11:55:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="185044399"
Received: from dmitra-mobl.amr.corp.intel.com (HELO [10.252.138.53]) ([10.252.138.53])
  by orsmga006.jf.intel.com with ESMTP; 26 Aug 2019 11:55:17 -0700
Subject: Re: [alsa-devel] [RESEND PATCH v4 1/4] dt-bindings: soundwire: add
 slave bindings
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org, robh+dt@kernel.org, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, spapothi@codeaurora.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org
References: <20190822233759.12663-1-srinivas.kandagatla@linaro.org>
 <20190822233759.12663-2-srinivas.kandagatla@linaro.org>
 <7da8aa89-2119-21d1-0e29-8894a8d40bf0@linux.intel.com>
 <37be6b6d-7e7f-2cd6-f9e9-f0cac48791ad@linaro.org>
 <d538238d-25d8-f179-c900-90be50ce814d@linux.intel.com>
 <7ee47f26-12f8-6028-cb83-7f59e669979f@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e5b184be-02f1-faa4-94fa-79bda8936d9d@linux.intel.com>
Date:   Mon, 26 Aug 2019 11:22:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7ee47f26-12f8-6028-cb83-7f59e669979f@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>> +title: SoundWire Controller Generic Binding
>>>>> +
>>>>> +maintainers:
>>>>> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>>> +
>>>>> +description: |
>>>>> +  SoundWire busses can be described with a node for the SoundWire 
>>>>> controller
>>>>> +  device and a set of child nodes for each SoundWire slave on the 
>>>>> bus.
>>>>> +
>>>>> +properties:
>>>>> +  $nodename:
>>>>> +    pattern: "^soundwire(@.*|-[0-9a-f])*$"
>>
>> re-reading this, it looks like you are defining the controller 
>> bindings, but there are no real controller-level properties except for 
>> the fact that they include slave bindings?
>>
> Yes, Each vendor specific master can have there specific properties 
> here, this is just to represent how slave nodes represented w.r.t to 
> master nodes.

I am not clear on how a vendor would document those controller 
properties then?

And the number of links doesn't seem like a vendor-specific definition, 
if you include the linkID in the register information below it'd help to 
known how many links can be enabled, which ones are used (if there is 
any pin-mux) and check if the configurations are correct.

> 
>> In MIPI the notion of controller is that it can deal with multiple 
>> links, each of which having specific properties (clock speed, clock 
>> stop properties, etc).
>>
>>>>> +
>>>>> +  "#address-cells":
>>>>> +    const: 2
>>>>> +
>>>>> +  "#size-cells":
>>>>> +    const: 0
>>>>> +
>>>>> +patternProperties:
>>>>> +  "^.*@[0-9a-f]+$":
>>>>> +    type: object
>>>>> +
>>>>> +    properties:
>>>>> +      compatible:
>>>>> +      pattern: "^sdw[0-9][0-9a-f]{4}[0-9a-f]{4}[0-9a-f]{2}$"
>>>>
>>>> So is this a 64-bit value, as in the MIPI spec, or is this part of 
>>>> the _ADR description?
>>>
>>> Rob did not like encoding compatible string exactly like _ADR encoding.
>>>
>>> https://lkml.org/lkml/2019/8/22/490
>>
>> Wondering if we are talking about different concepts?
>>
>> Rob's point was about the InstanceID
>>
>> "Assuming you could have more than 1 of the same device on the bus,
>> then you need some way to distinguish them and the way that's done for
>> DT is unit-address/reg. And compatible strings should be constant for
>> each instance."
>>
>> You can use the MIPI encoding *except* for the InstanceID, that'd be 
>> fine. It'll just be a bit weird since the Slave device will report the 
>> 48 bits that include the Instance ID, so you'll have to special case 
>> this field, but if this is a DT requirement then fine.
>>
>> Rob's point does not apply to the link ID - which is used when you 
>> have multiple masters in your controller. The Slave device is attached 
>> in one location and will never move, so that is a constant value.
> 
> Point is that this compatible is for slave device, it should not matter 
> where and how the slave is connected, compatible should be constant 
> irrespective of Link ID.
> Lets say for example if WSA881x slave device is connected to a 
> single-Link Controller and the same device is connected to a 
> MultiLink-controller then we would endup in more than one compatible 
> string for WSA881x driver. >
> 
>  From Disco Specic it clearly says that LinkID values are relative
> to the immediate parent Device. So having LinkID in compatible string is 
> very fragile.

ok, fine then.

> 
>>
>>>
>>>> I also don't get why the first item in in base10?
>>>>
>>>
>>> As this corresponds to Soundwire Version, and I have no visibility of 
>>> version number encoding after reaching number 9 in this field.
>>>
>>> This can be updated once we have more info on how the Version 
>>> encoding will look like in future.
>>>
>>> Idea of limiting regex to [0-9] for version is to enforce some checking!
>>
>> the version is a 4 bit value starting at 1 for SoundWire 1.0. There is 
>> nothing in the spec that talks about a limit to 9.
>>
>> It's unlikely we'll ever reach that but you are interpreting a spec 
>> here. plus just below you mention all fields as being hexadecimal.
>>
> Am happy to change this to
> 
> pattern: "^sdw[0-9a-f][0-9a-f]{4}[0-9a-f]{4}[0-9a-f]{2}$"
> 
> if you are okay with rest of the stuff.

yes, ok.

> 
> thanks,
> srini
>>>
>>> --srini
>>>
>>>>
>>>>> +      description:
>>>>> +      Is the textual representation of SoundWire Enumeration
>>>>> +      address. compatible string should contain SoundWire Version ID,
>>>>> +      Manufacturer ID, Part ID and Class ID in order and shall be in
>>>>> +      lower-case hexadecimal with leading zeroes.
>>>>> +      Valid sizes of these fields are
>>>>> +      Version ID is 1 nibble, number '0x1' represents SoundWire 1.0
>>>>> +      and '0x2' represents SoundWire 1.1 and so on.
>>>>> +      MFD is 4 nibbles
>>>>> +      PID is 4 nibbles
>>>>> +      CID is 2 nibbles
>>>>> +      More Information on detail of encoding of these fields can be
>>>>> +      found in MIPI Alliance DisCo & SoundWire 1.0 Specifications.
>>>>> +
>>>>> +      reg:
>>>>> +        maxItems: 1
>>>>> +        description:
>>>>> +          Instance ID and Link ID of SoundWire Device Address.

maybe put link first and make it clear that both are required.

>>>>> +
>>>>> +    required:
>>>>> +      - compatible
>>>>> +      - reg
>>>>> +
>>>>> +examples:
>>>>> +  - |
>>>>> +    soundwire@c2d0000 {
>>>>> +        #address-cells = <2>;
>>>>> +        #size-cells = <0>;
>>>>> +        compatible = "qcom,soundwire-v1.5.0";
>>>>> +        reg = <0x0c2d0000 0x2000>;
>>>>> +
>>>>> +        speaker@1 {
>>>>> +            compatible = "sdw10217201000";
>>>>> +            reg = <1 0>;
>>>>> +        };
>>>>> +
>>>>> +        speaker@2 {
>>>>> +            compatible = "sdw10217201000";
>>>>> +            reg = <2 0>;
>>>>> +        };
>>>>> +    };
>>>>> +
>>>>> +...
>>>>>
