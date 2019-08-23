Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6753C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E00206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zvVqHz2V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733065AbfHWP5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 11:57:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47073 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732573AbfHWP5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 11:57:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so9066918wru.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 08:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hodw0B1rU6OSggTzkDjrdfTrrPwaArVuQPWVuu09IUs=;
        b=zvVqHz2VpQBCK4S1LVU+jh9F+hVVJgTy/PjAaD0PaNWNrQSSo3AQXyK1x2j63ui/yH
         6uExGkNx1jbV5COHM7Dub0QWEwWatEoQo5VVUV2Mu1Feq4ROuOL4AtAmdSYGhz48UMQ6
         KbXbZsbA4+Tsckktx0c4fT793JXSbwuTiJ7y8gqGkHEsOGQmy1kFdoCSALAZx62sQUME
         CjtklaAM9Irl3oA0FcvX9yOlnM1KDE4xEIzwCK6MIvxO5kwAM7+Nov8iV4XNRMo7c6lE
         cwFlNR9a4amW/K6a3E7kkzfQwhR2J0852QJOW2b3C42GLDiVRMW4rWO/GEaw9C2LOSlC
         i8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hodw0B1rU6OSggTzkDjrdfTrrPwaArVuQPWVuu09IUs=;
        b=YwG+FQ4y4XDzgtdAggsMFH5TN+zJvlnqt2iDtl5M4AyPjyNeTI0kzzTXAwuqTpaF5+
         6esOdZ3o0JaMEM/soHYUbNjXBMPX1UASc6EJ+qcXMt5Tb4xHvuXDwU8aMIU/6p1UEjrl
         NtZQTHnRLa8lQgWbZqw/ls+Utd/Nt6wi/sJ/56U5uIT1plK9iKaWNA0yZ0M9OzXulMvD
         dmJLsJ6u65/5eRDOj4RJMabFT0JA9TkFMpA9LRXtL0+11Yt2II82Qwt1EkVxBJzLscq3
         PLp+tHnEqeFG+SNnH25EicJ193oG9oiTTFpxRvxrqi+sOa96+eZVh412qvpbXlpB11cc
         VUNw==
X-Gm-Message-State: APjAAAVaDiDdyRRJx5KPBHNUimUsgwiYsmLR8Lm3iSDRt73XsuSvohw7
        QjzkSLkk/VvlSzvYF14xr7ei895Sr5A=
X-Google-Smtp-Source: APXvYqzIwQ+5myiKhr1G9wWq8c2PBlfeuHux2i0D/z7S7/79vfbDXw1uO8xmudCwqPkEVdMx//a5Jw==
X-Received: by 2002:adf:ea89:: with SMTP id s9mr6357549wrm.76.1566575846953;
        Fri, 23 Aug 2019 08:57:26 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id z2sm2369567wmi.2.2019.08.23.08.57.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 08:57:26 -0700 (PDT)
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
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <37be6b6d-7e7f-2cd6-f9e9-f0cac48791ad@linaro.org>
Date:   Fri, 23 Aug 2019 16:57:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7da8aa89-2119-21d1-0e29-8894a8d40bf0@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/08/2019 16:41, Pierre-Louis Bossart wrote:
> 
> 
> On 8/22/19 6:37 PM, Srinivas Kandagatla wrote:
>> This patch adds bindings for Soundwire Slave devices that includes how
>> SoundWire enumeration address and Link ID are used to represented in
>> SoundWire slave device tree nodes.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../soundwire/soundwire-controller.yaml       | 75 +++++++++++++++++++
>>   1 file changed, 75 insertions(+)
>>   create mode 100644 
>> Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml 
>>
>> new file mode 100644
>> index 000000000000..91aa6c6d6266
>> --- /dev/null
>> +++ 
>> b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
>> @@ -0,0 +1,75 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/soundwire/soundwire-controller.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: SoundWire Controller Generic Binding
>> +
>> +maintainers:
>> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> +
>> +description: |
>> +  SoundWire busses can be described with a node for the SoundWire 
>> controller
>> +  device and a set of child nodes for each SoundWire slave on the bus.
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "^soundwire(@.*|-[0-9a-f])*$"
>> +
>> +  "#address-cells":
>> +    const: 2
>> +
>> +  "#size-cells":
>> +    const: 0
>> +
>> +patternProperties:
>> +  "^.*@[0-9a-f]+$":
>> +    type: object
>> +
>> +    properties:
>> +      compatible:
>> +      pattern: "^sdw[0-9][0-9a-f]{4}[0-9a-f]{4}[0-9a-f]{2}$"
> 
> So is this a 64-bit value, as in the MIPI spec, or is this part of the 
> _ADR description?

Rob did not like encoding compatible string exactly like _ADR encoding.

https://lkml.org/lkml/2019/8/22/490

> I also don't get why the first item in in base10?
> 

As this corresponds to Soundwire Version, and I have no visibility of 
version number encoding after reaching number 9 in this field.

This can be updated once we have more info on how the Version encoding 
will look like in future.

Idea of limiting regex to [0-9] for version is to enforce some checking!

--srini

> 
>> +      description:
>> +      Is the textual representation of SoundWire Enumeration
>> +      address. compatible string should contain SoundWire Version ID,
>> +      Manufacturer ID, Part ID and Class ID in order and shall be in
>> +      lower-case hexadecimal with leading zeroes.
>> +      Valid sizes of these fields are
>> +      Version ID is 1 nibble, number '0x1' represents SoundWire 1.0
>> +      and '0x2' represents SoundWire 1.1 and so on.
>> +      MFD is 4 nibbles
>> +      PID is 4 nibbles
>> +      CID is 2 nibbles
>> +      More Information on detail of encoding of these fields can be
>> +      found in MIPI Alliance DisCo & SoundWire 1.0 Specifications.
>> +
>> +      reg:
>> +        maxItems: 1
>> +        description:
>> +          Instance ID and Link ID of SoundWire Device Address.
>> +
>> +    required:
>> +      - compatible
>> +      - reg
>> +
>> +examples:
>> +  - |
>> +    soundwire@c2d0000 {
>> +        #address-cells = <2>;
>> +        #size-cells = <0>;
>> +        compatible = "qcom,soundwire-v1.5.0";
>> +        reg = <0x0c2d0000 0x2000>;
>> +
>> +        speaker@1 {
>> +            compatible = "sdw10217201000";
>> +            reg = <1 0>;
>> +        };
>> +
>> +        speaker@2 {
>> +            compatible = "sdw10217201000";
>> +            reg = <2 0>;
>> +        };
>> +    };
>> +
>> +...
>>
