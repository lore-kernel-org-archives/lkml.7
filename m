Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA224C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5EE2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s/BkU/Su"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbfH2PwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:52:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53633 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728456AbfH2PwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:52:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id 10so4255496wmp.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 08:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LnH0w/K/K8vFf4T8B8Pk9QjQILA18r17IdgmbEo/xQc=;
        b=s/BkU/Sux2u6RPNlBX0IHCd6Nn145MOMsbJ5Qi37t6m5TOKh4CdzKB2nosIq2bP6Cw
         H7hhdrs2HTB+lXIFe3Y9StlYcNr1yJOfRagPoslen2GJeSBHPG5RUb+P7Qzd2697eJew
         kvXuvNsEBQpxN0TlS0I6avL2J6B9N1J8l8r+QzotEISe4dxMoEoGbm+nzjrS3myENM5K
         6cPT2stStZfhlJVbXS5tWHA2AGj30QefGul99ZQ3qRg7Fj0OIIC3ik4ih1yBUqL+3HQk
         6oiA12Bu1m5phpmbbYBtzO56be2D34bhGmW/gJDrpXc5MmomNzBpGkFzi0nlor6RRxrq
         GHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LnH0w/K/K8vFf4T8B8Pk9QjQILA18r17IdgmbEo/xQc=;
        b=k5rVjUiMrTbGGci2T4SHn1IDlkJAzQl2ddiCe1EENLFLLpCunU8EbCrrxkf8HMaGx/
         q6B7ItiUhLFDtDKbL52l7KCx1opSTn/6RX9z9rNTE/4PUQj7ueX1d9MIw5uVbqKPklCu
         HU5+vOljPEc7kUOi2bxVoTwEjg3S1wO52L+jjR753//kNcvfnyFoGoonoJLfNg4xDxtp
         PoYo04NBwbWNaci9QqgdmTQcJ0nGBSITjPvUZaooyOOizV0cM7Mwz8M5eEOPIXlt2Nhj
         FziQnApUj73YyW0cty+auK2U5Q5wvjarscOXcxqZjfb/pRuFJViQcLyKuQaFwlrxaX1M
         J6NA==
X-Gm-Message-State: APjAAAWmgDg6Le6tarOqR2vSIe7c+vrEWpjEGzIbAcWRORiC+zMmDJA9
        ZdTMkE6apZDVfbounayU2iqanQ==
X-Google-Smtp-Source: APXvYqyqrcnzdUapgwZZmzywb2WvczjVj7DbtThNc0+7wpYTtqQcO97DJpeJRLSvqOSI+XQE7EsAnA==
X-Received: by 2002:a1c:810a:: with SMTP id c10mr11920180wmd.72.1567093934178;
        Thu, 29 Aug 2019 08:52:14 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id g14sm5983745wrb.38.2019.08.29.08.52.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 08:52:13 -0700 (PDT)
Subject: Re: [PATCH v5 3/4] dt-bindings: ASoC: Add WSA881x bindings
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Vinod <vkoul@kernel.org>,
        spapothi@codeaurora.org, Banajit Goswami <bgoswami@codeaurora.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
References: <20190829144442.6210-1-srinivas.kandagatla@linaro.org>
 <20190829144442.6210-4-srinivas.kandagatla@linaro.org>
 <CAL_JsqLOHA+r9UCTwyvj+_BzWSrsVDZw5vp-1XhYYvQxncx0sw@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <ef01465e-25d6-059c-1f5d-8e8ebd6b887d@linaro.org>
Date:   Thu, 29 Aug 2019 16:52:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLOHA+r9UCTwyvj+_BzWSrsVDZw5vp-1XhYYvQxncx0sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review!

On 29/08/2019 16:46, Rob Herring wrote:
> On Thu, Aug 29, 2019 at 9:45 AM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>>
>> This patch adds bindings for WSA8810/WSA8815 Class-D Smart Speaker
>> Amplifier. This Amplifier also has a simple thermal sensor for
>> over temperature and speaker protection.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../bindings/sound/qcom,wsa881x.yaml          | 41 +++++++++++++++++++
>>   1 file changed, 41 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml b/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
>> new file mode 100644
>> index 000000000000..7a486c024732
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
>> @@ -0,0 +1,41 @@
>> +# SPDX-License-Identifier: GPL-2.0
> 
> Dual license please.
> 
Will do that!

>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/qcom,wsa881x.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Bindings for Qualcomm WSA8810/WSA8815 Class-D Smart Speaker Amplifier
>> +
>> +maintainers:
>> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> +
>> +description: |
>> +  WSA8810 is a class-D smart speaker amplifier and WSA8815
>> +  is a high-output power class-D smart speaker amplifier.
>> +  Their primary operating mode uses a SoundWire digital audio
>> +  interface. This binding is for SoundWire interface.
>> +
>> +properties:
>> +  compatible:
>> +    const: "sdw10217201000"
> 
> No need for quotes.

Did not knew that! Still getting used to yaml stuff :-)

> 
>> +
>> +  reg:
>> +    maxItems: 1
>> +
> 
>> +  powerdown-gpios:
>> +    description: GPIO spec for Powerdown/Shutdown line to use
>> +    maxItems: 1
>> +
>> +  '#thermal-sensor-cells':
>> +    const: 0
> 
> Either of these required?
> 

"make dt_binding_check" was complaining when I added this! Let me retry it!

> Here you can put 'additionalProperties: false'
> 
>> +
>> +examples:
>> +  - |
>> +    speaker@0,1 {
> 
> This should be under a soundwire bus node.

okay..

> 
>> +        compatible = "sdw10217201000";
>> +        reg = <0 1>;
>> +        powerdown-gpios = <&wcdpinctrl 2 0>;
>> +        #thermal-sensor-cells = <0>;
>> +    };
>> +
>> +...
>> --
>> 2.21.0
>>
