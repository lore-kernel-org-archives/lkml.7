Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C546CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F8020578
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gzlVwieG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389173AbfJ1MmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:42:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36002 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389151AbfJ1MmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:42:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id c22so8981319wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 05:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5xksvSoWClSEPqFisZy8fkW7iGrHC1hgE7A27QwV7HQ=;
        b=gzlVwieGLL+vRKmFH25rxW6uJL3c7ZUDBTuLJonZBtrHudOawmBb5SHfGzviP1gH8t
         hXNTMOg8xclCA4Od9HvUqPTpcRylA/7YwAB5NbK1tNVot+6H2lJFyZ5wbLwZZQOt0YVz
         xDnVaSEo0t2c+06VHQHs1nRNkAI5C1pmeyrCOXqrhFGYnXDmgbbUrrD2PNTKXunkRP7y
         oDc/IoxUdoZHmoIYw1TIkqegXCxMusr/wiFg9SLQxjUgWVw3yhOA0KI7B8xgellvl6sZ
         94/xu5989N5qnqz+ahT4jSbYLDj3j+bumF1FilJiuCvN85Q6RlCdoTO/AR90E2wvVWrR
         iB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5xksvSoWClSEPqFisZy8fkW7iGrHC1hgE7A27QwV7HQ=;
        b=NuV+4W6WZK0d8KTRmAszkasvGS5zNvTrCX8KBCVCbymnPtShhFXr0tchNqbXMzyDJw
         z5r9kKlo45+EdH6D6Nf5uJfiJYNdesCdWuETwrRGCE59aFVXtOLe1Ny00L5cKaRQGnza
         tzmsg6C1/W0qMr/cKv2JtcHa7zjHK9Krh6SBn3hLS0L7Hd9HHD+A6LMwxW+uXluR3ftP
         wz2z40bkDF2S9PtI2F1NZCVPTM7kbb+gpq5m9tnHIPfiF6ODUNBwcO3OXIOFGj7cY95k
         l1d9O7k75P9SYqZ7BuPE6lax1v5DgWGA20rM7GmyDwRn/dlvB0OlZcOsZyqHFaUA2lmP
         7j3g==
X-Gm-Message-State: APjAAAUAJm/5e4j3MIjIYsf7fpkG/1HkLI/FnDh4FuU5JSRNoAjWA+2v
        gLgFV4N0oOJqIb2OcG+utgglQA==
X-Google-Smtp-Source: APXvYqygo0fnWXSv7nZYL4U1ZXDFCeZaEZJnTPCrkdL1XZ8dj3TrWb5bXsY76ZWjmyYR8KItRj/F5g==
X-Received: by 2002:a1c:a751:: with SMTP id q78mr16448120wme.129.1572266517809;
        Mon, 28 Oct 2019 05:41:57 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id u21sm13971582wmu.27.2019.10.28.05.41.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 05:41:56 -0700 (PDT)
Subject: Re: [PATCH v2 08/11] dt-bindings: pinctrl: qcom-wcd934x: Add bindings
 for gpio
To:     Rob Herring <robh@kernel.org>
Cc:     broonie@kernel.org, linus.walleij@linaro.org, lee.jones@linaro.org,
        vinod.koul@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org, bgoswami@codeaurora.org,
        linux-gpio@vger.kernel.org
References: <20191018001849.27205-1-srinivas.kandagatla@linaro.org>
 <20191018001849.27205-9-srinivas.kandagatla@linaro.org>
 <20191025210021.GA12751@bogus>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e05ff19a-7c12-da80-4faf-3b152b24517d@linaro.org>
Date:   Mon, 28 Oct 2019 12:41:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191025210021.GA12751@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thamks for the review Rob,


On 25/10/2019 22:00, Rob Herring wrote:
> On Fri, Oct 18, 2019 at 01:18:46AM +0100, Srinivas Kandagatla wrote:
>> Qualcomm Technologies Inc WCD9340/WCD9341 Audio Codec has integrated
>> gpio controller to control 5 gpios on the chip. This patch adds
>> required device tree bindings for it.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../pinctrl/qcom,wcd934x-pinctrl.yaml         | 51 +++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,wcd934x-pinctrl.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,wcd934x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,wcd934x-pinctrl.yaml
>> new file mode 100644
>> index 000000000000..c8a36cbc4935
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,wcd934x-pinctrl.yaml
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pinctrl/qcom,wcd934x-pinctrl.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: WCD9340/WCD9341 GPIO Pin controller
>> +
>> +maintainers:
>> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> +
>> +description: |
>> +  Qualcomm Technologies Inc WCD9340/WCD9341 Audio Codec has integrated
>> +  gpio controller to control 5 gpios on the chip.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,wcd9340-pinctrl
>> +      - qcom,wcd9341-pinctrl
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  gpio-controller: true
>> +
>> +  gpio-ranges:
>> +    maxItems: 1
>> +
>> +  '#gpio-cells':
>> +    const: 2
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - gpio-controller
>> +  - gpio-ranges
>> +  - "#gpio-cells"
> 
> additionalProperties: false
> 
>> +
>> +
>> +examples:
>> +  - |
>> +    wcdpinctrl: wcdpinctrl@42 {
> 
> pinctrl@42

I will address above two comments in next version!

Thanks,
srini
> 
>> +        compatible = "qcom,wcd9340-pinctrl";
>> +        reg = <0x042 0x2>;
>> +        gpio-controller;
>> +        gpio-ranges = <&wcdpinctrl 0 0 5>;
>> +        #gpio-cells = <2>;
>> +    };
>> +
>> +...
>> -- 
>> 2.21.0
>>
