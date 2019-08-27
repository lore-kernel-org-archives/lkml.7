Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B58C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2556217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b7P2GhkD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbfH0U3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 16:29:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45884 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731238AbfH0U3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:29:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id q12so114566wrj.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 13:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MNtgMowNOziQU04tj21QpB7UTHF+CQydh5Mx2MU8eSk=;
        b=b7P2GhkDgx27DNyq0sjWmuBd2+u9U15lHb46pibNLi+dCp5bNz8y514//rUZKUKu3D
         dEILlf0Wbax4H4GnSa4lJmq8ZfTQ+hKIMqsaZ81JcO6yxwfihGNrCEvPZ1aImRMxOlTZ
         SM5y9YmLxdtZgLpfSIfttP4GJDF1h7yAtUxsC0lFevA9F2/p26MkBVD6sxbjFe8MAmHt
         GMIqg7qCRfCdR2Zv2jRBTfNtUTTG9FBzNRiWfz0N/GCKAe+CXSQPX2FcIN/O2KsdXs9A
         DaxIPLCqNlsuOY6IR400wVJAL1YgF24eO3+gVdzlljq/RE0W+c9TDI/segUAdJ7t15D4
         v+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MNtgMowNOziQU04tj21QpB7UTHF+CQydh5Mx2MU8eSk=;
        b=EsvJPnNdCNvMkxHLV7rbguvJOOjwoya1BPF76Z3KC6U22wnWaB13TzxVMrRU2yZlXt
         wSL1WJaL4bGHNlDwRYiRxFm28knTd5mlkojwpphEWTZXt/iMjr5E7T25Ma8XeD0Pk6j1
         ZqsDRpoaKBuCHHeT9VOLuCAj5UKI/klHvffS3DwrCsjBgLBGR0T9dFm9HB/mmFXYjkXB
         51ezqIWGyMdAmqsn29T/9Db6KGUMJdkb6OPvSAfyHiDxEpWHpSjKgYVjtmLmm+2CL3SH
         e9s0DdtyZ4+09J+NjY14bRwbW0+Pnqvk+MFi4IP6KT0MEZMEEjbj5b6hoqkmaYKQmHW1
         5+zw==
X-Gm-Message-State: APjAAAUNNz0gIngp1uE+Gm4n3qn91PWJXB6cMRQWtD3Iup1kUBW5M3AV
        3guZcCGXM+py9Hlz/e1deo6uWw==
X-Google-Smtp-Source: APXvYqyqCKkUfNCobT49Kq8m/ke+WZcPuDoTmO1DYlDvMjvIx4arhT/4wdztPrpeCEQna1wLRCKfmQ==
X-Received: by 2002:a05:6000:1186:: with SMTP id g6mr66120wrx.17.1566937738779;
        Tue, 27 Aug 2019 13:28:58 -0700 (PDT)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id n14sm227060wra.75.2019.08.27.13.28.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 13:28:57 -0700 (PDT)
Subject: Re: [RESEND PATCH v4 1/4] dt-bindings: soundwire: add slave bindings
To:     Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     broonie@kernel.org, spapothi@codeaurora.org,
        bgoswami@codeaurora.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org
References: <20190822233759.12663-1-srinivas.kandagatla@linaro.org>
 <20190822233759.12663-2-srinivas.kandagatla@linaro.org>
 <20190823065340.GD2672@vkoul-mobl> <20190827202022.GA7783@bogus>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <ccc90c56-f776-0c1c-df6b-cb661aa5ea97@linaro.org>
Date:   Tue, 27 Aug 2019 21:28:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827202022.GA7783@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

thanks for reviewing the patch!

On 27/08/2019 21:20, Rob Herring wrote:
> On Fri, Aug 23, 2019 at 12:23:40PM +0530, Vinod Koul wrote:
>> On 23-08-19, 00:37, Srinivas Kandagatla wrote:
>>> This patch adds bindings for Soundwire Slave devices that includes how
>>> SoundWire enumeration address and Link ID are used to represented in
>>> SoundWire slave device tree nodes.
>>>
>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>> ---
>>>   .../soundwire/soundwire-controller.yaml       | 75 +++++++++++++++++++
>>>   1 file changed, 75 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
>>> new file mode 100644
>>> index 000000000000..91aa6c6d6266
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
>>> @@ -0,0 +1,75 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/soundwire/soundwire-controller.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: SoundWire Controller Generic Binding
>>
>> Controller does not make sense here, why not use spec terminology and
>> say "SoundWire Slave Generic Binding"
> 
> It's both IMO. It's describing the structure of child devices of a
> controller (aka a bus).
> 
>>
>>> +
>>> +maintainers:
>>> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>> +
>>> +description: |
>>> +  SoundWire busses can be described with a node for the SoundWire controller
>>> +  device and a set of child nodes for each SoundWire slave on the bus.
>>> +
>>> +properties:
>>> +  $nodename:
>>> +    pattern: "^soundwire(@.*|-[0-9a-f])*$"
> 
> '-[0-9a-f]' was to handle cases like spi-gpio or i2c-gpio. Would a
> bit banged interface be possible here?

Highly unlikely!


> 
>>> +
>>> +  "#address-cells":
>>> +    const: 2
>>> +
>>> +  "#size-cells":
>>> +    const: 0
>>> +
>>> +patternProperties:
>>> +  "^.*@[0-9a-f]+$":
> 
> If there are distinct fields in the address, they are typically comma
> separated in the unit-address.

okay, will fix that in next version!


> 
>>> +    type: object
>>> +
>>> +    properties:
>>> +      compatible:
>>> +      pattern: "^sdw[0-9][0-9a-f]{4}[0-9a-f]{4}[0-9a-f]{2}$"
>>> +      description:
>>> +	  Is the textual representation of SoundWire Enumeration
>>> +	  address. compatible string should contain SoundWire Version ID,
>>> +	  Manufacturer ID, Part ID and Class ID in order and shall be in
>>> +	  lower-case hexadecimal with leading zeroes.
>>> +	  Valid sizes of these fields are
>>> +	  Version ID is 1 nibble, number '0x1' represents SoundWire 1.0
>>> +	  and '0x2' represents SoundWire 1.1 and so on.
>>> +	  MFD is 4 nibbles
>>> +	  PID is 4 nibbles
>>> +	  CID is 2 nibbles
>>> +	  More Information on detail of encoding of these fields can be
>>> +	  found in MIPI Alliance DisCo & SoundWire 1.0 Specifications.
>>> +
>>> +      reg:
>>> +        maxItems: 1
>>> +        description:
>>> +          Instance ID and Link ID of SoundWire Device Address.
>>
>> This looks better :) Thanks.
>>
>> Apart from the minor nit above this looks good to me, I can merge the
>> sdw parts if Rob is fine with them.
>>
>> Thanks
>>
>>> +
>>> +    required:
>>> +      - compatible
>>> +      - reg
>>> +
>>> +examples:
>>> +  - |
>>> +    soundwire@c2d0000 {
>>> +        #address-cells = <2>;
>>> +        #size-cells = <0>;
>>> +        compatible = "qcom,soundwire-v1.5.0";
> 
> This will probably change once I review it. :)

:-)

thanks,
srini
> 
>>> +        reg = <0x0c2d0000 0x2000>;
>>> +
>>> +        speaker@1 {
>>> +            compatible = "sdw10217201000";
>>> +            reg = <1 0>;
>>> +        };
>>> +
>>> +        speaker@2 {
>>> +            compatible = "sdw10217201000";
>>> +            reg = <2 0>;
>>> +        };
>>> +    };
>>> +
>>> +...
>>> -- 
>>> 2.21.0
>>
>> -- 
>> ~Vinod
