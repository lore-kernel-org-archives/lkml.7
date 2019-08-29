Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F706C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0964D21726
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rT/NyY7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfH2PrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:47:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39449 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfH2PrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:47:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id n2so2974597wmk.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 08:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Aaw5MPLGPnpP7hqH6Z404TXcUkGBN8Qiv1+S+/xAVYs=;
        b=rT/NyY7coIzUv343vYFq7wWdbCT9F36sX/Fd6Rlbe3nR1U5cXovKf3nwRpsN5ymTP2
         7LMZIqiDpQFCLumf+0JpXoro1S2r6fH0v1306RPD20/tJ8mvLQYSjJOIfIQaY0Y3pQPr
         99W6gR6/jLWLGvDDofIljq356uA1jBGBJALq80cVFTyJukUm99qydHoHvRilQORJWXgW
         nGPJffv85OVoJjJyNuK4IFfnJ1C+f+zhmkaXcjFUWvaK6Q7Elr/jeRKFlvAmZHYWytVl
         k1IG+USz73jXlWv1q7KEsmxB7qQvTpWLp2zmZnGgOp2kCP7UHZSa3Uir1Pp9NkmphXpb
         27EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Aaw5MPLGPnpP7hqH6Z404TXcUkGBN8Qiv1+S+/xAVYs=;
        b=XFwQgF//649d7xYb4VKf8QwVgr5M8QrNCi6I0WYhwtbFBJLuagdo2jntB5qojXkq6J
         IU95H0C9TPV4qCgkBzMmyW3BDxw5wdVQiXyrkqMOMyq0hVcPPAZGHd9i6n/+qmGXVjgm
         Ek+0FDpkKSv+cGTmBJ/utO2vZ230tqc4G20mQfxcSSVQ91gCIenbzyE7G/jXW3g1DODi
         pgJBoNq6l32HlICfXellWgrizc/5iwMytQiTLBKzoYHr9z3gbf3T6Q2zMEC+MXSrhvYO
         yJNnx3EgHZah7GIV3PXqqzNMMytF62VYJcJXHsAY+3nnj18fBM0/omHkT0Bd7h9RQzya
         +MEw==
X-Gm-Message-State: APjAAAXD2nqAcAIOJ7jA/mw3Gp+0Ad2Z6JnE9ftMd40RDThJ8taWCcJi
        WdLnDPr3T5ev6walMtHRYcQPKQ==
X-Google-Smtp-Source: APXvYqyQZXgC/DaNfrLvmAO/M3j3aa3a7nj3YJJVohAxA+7UE0VyCZXo9XbqRn1ojGqTnKl1laLJuw==
X-Received: by 2002:a05:600c:386:: with SMTP id w6mr791462wmd.152.1567093623775;
        Thu, 29 Aug 2019 08:47:03 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id n9sm3284805wrp.54.2019.08.29.08.47.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 08:47:03 -0700 (PDT)
Subject: Re: [PATCH v5 1/4] dt-bindings: soundwire: add slave bindings
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Vinod <vkoul@kernel.org>,
        spapothi@codeaurora.org, Banajit Goswami <bgoswami@codeaurora.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
References: <20190829144442.6210-1-srinivas.kandagatla@linaro.org>
 <20190829144442.6210-2-srinivas.kandagatla@linaro.org>
 <CAL_JsqLwbz5eiBEw8PmXsJrxzXffNc7rRON-wQ0KviVW8JVv5A@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <b00f653f-7337-f475-1696-a94c51aa22ba@linaro.org>
Date:   Thu, 29 Aug 2019 16:47:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLwbz5eiBEw8PmXsJrxzXffNc7rRON-wQ0KviVW8JVv5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/08/2019 16:42, Rob Herring wrote:
> On Thu, Aug 29, 2019 at 9:45 AM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>>
>> This patch adds bindings for Soundwire Slave devices that includes how
>> SoundWire enumeration address and Link ID are used to represented in
>> SoundWire slave device tree nodes.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../soundwire/soundwire-controller.yaml       | 72 +++++++++++++++++++
>>   1 file changed, 72 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
>> new file mode 100644
>> index 000000000000..449b6130ce63
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
>> @@ -0,0 +1,72 @@
>> +# SPDX-License-Identifier: GPL-2.0
> 
> (GPL-2.0-only OR BSD-2-Clause) for new bindings.
> 
Okay Sure will do that!
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/soundwire/soundwire-controller.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: SoundWire Controller Generic Binding
>> +
>> +maintainers:
>> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> +  - Vinod Koul <vkoul@kernel.org>
>> +
>> +description: |
>> +  SoundWire busses can be described with a node for the SoundWire controller
>> +  device and a set of child nodes for each SoundWire slave on the bus.
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "^soundwire(@.*)?$"
>> +
>> +  "#address-cells":
>> +    const: 2
>> +
>> +  "#size-cells":
>> +    const: 0
>> +
>> +patternProperties:
>> +  "^.*@[0-9a-f],[0-9a-f]$":
>> +    type: object
>> +
>> +    properties:
>> +      compatible:
>> +        pattern: "^sdw[0-9a-f]{1}[0-9a-f]{4}[0-9a-f]{4}[0-9a-f]{2}$"
>> +        description: Is the textual representation of SoundWire Enumeration
>> +          address. compatible string should contain SoundWire Version ID,
>> +          Manufacturer ID, Part ID and Class ID in order and shall be in
>> +          lower-case hexadecimal with leading zeroes.
>> +          Valid sizes of these fields are
>> +          Version ID is 1 nibble, number '0x1' represents SoundWire 1.0
>> +          and '0x2' represents SoundWire 1.1 and so on.
>> +          MFD is 4 nibbles
>> +          PID is 4 nibbles
>> +          CID is 2 nibbles
>> +          More Information on detail of encoding of these fields can be
>> +          found in MIPI Alliance DisCo & SoundWire 1.0 Specifications.
>> +
>> +      reg:
>> +        maxItems: 1
>> +        description:
>> +          Link ID followed by Instance ID of SoundWire Device Address.
>> +
>> +    additionalProperties: false
> 
> I'm pretty sure you'll want nodes with other properties. If not, then
> why are they in DT? So drop this.

will do!
> 
> Both the controller and child nodes need to list required properties.
> 
Okay, will spin that in next version!
Thanks,
srini

>> +
>> +examples:
>> +  - |
>> +    soundwire@c2d0000 {
>> +        #address-cells = <2>;
>> +        #size-cells = <0>;
>> +        reg = <0x0c2d0000 0x2000>;
>> +
>> +        speaker@0,1 {
>> +            compatible = "sdw10217201000";
>> +            reg = <0 1>;
>> +        };
>> +
>> +        speaker@0,2 {
>> +            compatible = "sdw10217201000";
>> +            reg = <0 2>;
>> +        };
>> +    };
>> +
>> +...
>> --
>> 2.21.0
>>
