Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49536C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C58E2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M3G4Y3h4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbfH0UZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 16:25:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37618 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfH0UZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:25:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id z11so142988wrt.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 13:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z2ACtSe6Yiw1+YbjAjRq/giYtTA4VS+c+Zl+5oYIiXY=;
        b=M3G4Y3h42bkVq/9crq1VzDHEGrLQc0rjs9gPpAzbIP/UbZna8LkFJy34RTWoq/YD3y
         L//flOHT9MxTy0DixdqaCDt5j90xIg0Qu1edv8Z96TmRZhgr0YVEeW4sT6iSvHtXaRbL
         5JPpzH44Kpii6B5L2PwOGZMKmFyqesbaXfoFfGiNmMrlbB7fwqJuzwoAJf+rxQ5Ni+QS
         q2R6YLyw0zZWdRFnh0ez0geQui90mQIvjsTNYyb9p4042lKSlqlDKx1FHGsuC2Iq5aGu
         O+u4szumPoIF4XBmwLADecXc1QSAfSHTPekC+nzGKT354vm41lpBItQD1cF/IJnkCopL
         p4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z2ACtSe6Yiw1+YbjAjRq/giYtTA4VS+c+Zl+5oYIiXY=;
        b=S6efHxYsV4NXzW1aMNmCPOKwU7Efdx9GPhpa4tDOdVvwEx+1P2QDh/si1DXiyWze7M
         iZwLPoC+RgEMkcW9YLzfgvZehMYhLan1OW7lGJsIImXc4ouJjJVuyzS3eq7lLBGQPrCx
         eWqeyWPwvcPU6fylR7iADOF9+LjSlkVY+/8/M0jvMYUtqM6D4H7EBmD2ci8jffwaPJ6h
         Xkis7m9rQAewIXMrpEERDpdOR2rJm29ja9JUyhFxshHlBAYt0eDpQcrBw63HTFPI7wGE
         fP6PcSQjRv48yKwqW74TIbqs4lE/qhiTGb5vVcvzP2vRE/4VzwFW10uAAtVKbD0BWG1R
         uh1g==
X-Gm-Message-State: APjAAAW4+3rF87eM0ZovhXVyWO0ICT4Q7SgrojkCPml5XfWlS17BlZhW
        5drBP1L5Dd/JYdRGp6RBviA2CQ==
X-Google-Smtp-Source: APXvYqyHpC6GdfK/HOCjnBJXEVM8YLHpWnP6P2IknR138f8AEZoNrRpK/Q0KA/Y/KqjK4k3jrZPmZQ==
X-Received: by 2002:adf:f507:: with SMTP id q7mr66707wro.210.1566937522099;
        Tue, 27 Aug 2019 13:25:22 -0700 (PDT)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id e11sm292024wrc.4.2019.08.27.13.25.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 13:25:21 -0700 (PDT)
Subject: Re: [RESEND PATCH v4 3/4] dt-bindings: ASoC: Add WSA881x bindings
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Vinod <vkoul@kernel.org>,
        spapothi@codeaurora.org, Banajit Goswami <bgoswami@codeaurora.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
References: <20190822233759.12663-1-srinivas.kandagatla@linaro.org>
 <20190822233759.12663-4-srinivas.kandagatla@linaro.org>
 <CAL_JsqLjgOy3TKrpuNYYkRxy-Ln+3FOoKVE9KweS0ycTxriWMQ@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <81888350-9296-7db1-01b5-4594a3bd5d60@linaro.org>
Date:   Tue, 27 Aug 2019 21:25:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLjgOy3TKrpuNYYkRxy-Ln+3FOoKVE9KweS0ycTxriWMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking time to review!

On 27/08/2019 13:20, Rob Herring wrote:
> On Thu, Aug 22, 2019 at 6:38 PM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>>
>> This patch adds bindings for WSA8810/WSA8815 Class-D Smart Speaker
>> Amplifier. This Amplifier also has a simple thermal sensor for
>> over temperature and speaker protection.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../bindings/sound/qcom,wsa881x.yaml          | 44 +++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml b/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
>> new file mode 100644
>> index 000000000000..ad718d75c660
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
>> @@ -0,0 +1,44 @@
>> +# SPDX-License-Identifier: GPL-2.0
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
>> +allOf:
>> +  - $ref: "soundwire-controller.yaml#"
> 
> This is not the controller, so this should not be included here. You
> should get lots of warnings from doing so. You did run 'make
> dt_binding_check', right?

no, I was not aware of this command! will run that before sending next 
version.


> 
>> +
>> +properties:
>> +  compatible:
>> +    const: sdw10217201000
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  pd-gpios:
> 
> powerdown-gpios is the standard name.
> 
sounds good to me, will change this in next version!

>> +    description: GPIO spec for Powerdown/Shutdown line to use
>> +    maxItems: 1
>> +
>> +  "#thermal-sensor-cells":
>> +    const: 0
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - pd-gpios
>> +  - #thermal-sensor-cells
>> +
>> +examples:
>> +  - |
>> +    efuse@1c23800 {
>> +        compatible = "allwinner,sun4i-a10-sid";
> 
> Huh?

Opps! copy paste bugs!!! :-)

> 
>> +        reg = <0x01c23800 0x10>;
>> +        pd-gpios = <&wcdpinctrl 2 0>;
>> +        #thermal-sensor-cells = <0>;
>> +    };
>> +
>> +...
>> --
>> 2.21.0
>>
