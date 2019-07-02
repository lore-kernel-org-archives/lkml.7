Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D77C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9AF6206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QDE4lDiH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfGBIWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:22:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41003 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfGBIWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:22:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so16687706wrm.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 01:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=npK20M4VjgRq8bweyVfDmxYuK/3oR7Zc4HxgTAOxcqU=;
        b=QDE4lDiHJUMLEnF5ZiGmGwnAjKcFsLz0g7kuRJXlBy0qd0j80HVGb4RjGm8VYTR+dH
         xuTtJuu7t6EsfUFrxGaKMmWYjpYutbhZFLfjfyUN2MnSDD2QULDY5EhmojzlUVKB3KjR
         /HO475AdE8D0WOYYCsK0XrORwUrvRnVXXZAGFK06rmBbLbdGC2xHMZo793IyfOgFWN1Q
         mmc/5TM1UyQYsDGjHaka+j4f/XXUGEhjZS7jhJuef/HFbUIEi8NYrTz+0m59ZH8tIwG3
         9K5X3N8WPJvs2ghje0N4nnPF8Zd1QB/HP3my3eVW3NZGFyd7546K5GyWqPC/1sw9C6OS
         gSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=npK20M4VjgRq8bweyVfDmxYuK/3oR7Zc4HxgTAOxcqU=;
        b=lDZUZB8COeg69+jCTl0GJ4rN+axurVwj/c7rAFiLuxShREspCogZiHudjixjr4A8aJ
         +Om+cVEv3EfJBKzeKjaf3jN+nYLy3iZ6kwVBR3lEPvH0Eo7ICf3ztfcX1bNveq3yg9UZ
         52upvnTkn1D1myM7el+Ars/xV9glLGQTmAo3SVDCzdZV0+rnpE9y8ywGong4/YXV9Rjx
         OBcY97afHDIqeGdP+NwoZRfzaANI1z3Hhr30AWSY4DhBYelhQ4CvD+TstlfvtTvMK/Dw
         pU+J+yqZDZprGmj8NbMpTdxmQYgXrysdcxX486mPJ3cXhpmJyrbAqWQhwGMqt85Vnk6g
         SB0A==
X-Gm-Message-State: APjAAAVpbDIXLuNiOoy83IJ6+Tfn+tiUJzec31/VZUwTGpi4jD1DGKOC
        U0anMphth0BGvbsyV0myHC/m4w==
X-Google-Smtp-Source: APXvYqwevDSd+3eE4DJi0D0ipmYNR9B2qOUnZJQVIAPek/FAfF+1wQicHfJKOQPBQDQ1R3DWnHdT9w==
X-Received: by 2002:adf:dc81:: with SMTP id r1mr22261339wrj.298.1562055722799;
        Tue, 02 Jul 2019 01:22:02 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id l124sm2121489wmf.36.2019.07.02.01.22.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 01:22:02 -0700 (PDT)
Subject: Re: [RFC PATCH 1/5] dt-bindings: soundwire: add slave bindings
To:     Vinod Koul <vkoul@kernel.org>
Cc:     broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        bgoswami@quicinc.com
References: <20190611104043.22181-1-srinivas.kandagatla@linaro.org>
 <20190611104043.22181-2-srinivas.kandagatla@linaro.org>
 <20190701061155.GJ2911@vkoul-mobl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <ce1e445e-3254-1308-8752-2cb56a7e0cc6@linaro.org>
Date:   Tue, 2 Jul 2019 09:22:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190701061155.GJ2911@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Vinod for taking time to review,

On 01/07/2019 07:11, Vinod Koul wrote:
> On 11-06-19, 11:40, Srinivas Kandagatla wrote:
>> This patch adds bindings for Soundwire Slave devices which includes how
>> SoundWire enumeration address is represented in SoundWire slave device
>> tree nodes.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../devicetree/bindings/soundwire/bus.txt     | 48 +++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soundwire/bus.txt
>>
>> diff --git a/Documentation/devicetree/bindings/soundwire/bus.txt b/Documentation/devicetree/bindings/soundwire/bus.txt
>> new file mode 100644
>> index 000000000000..19a672b0d528
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soundwire/bus.txt
> 
> The bindings are for slave right and the file is bus.txt?

I tried to follow what I have done for SLIMBus.
Do you prefer them to be documented in slave.txt?

> 
>> @@ -0,0 +1,48 @@
>> +SoundWire bus bindings.
>> +
>> +SoundWire is a 2-pin multi-drop interface with data and clock line.
>> +It facilitates development of low cost, efficient, high performance systems.
>> +
>> +SoundWire controller bindings are very much specific to vendor.
>> +
>> +Child nodes(SLAVE devices):
>> +Every SoundWire controller node can contain zero or more child nodes
>> +representing slave devices on the bus. Every SoundWire slave device is
>> +uniquely determined by the enumeration address containing 5 fields:
>> +SoundWire Version, Instance ID, Manufacturer ID, Part ID and Class ID
>> +for a device. Addition to below required properties, child nodes can
>> +have device specific bindings.
>> +
>> +Required property for SoundWire child node if it is present:
>> +- compatible:	 "sdwVER,MFD,PID,CID". The textual representation of
>> +		  SoundWire Enumeration address comprising SoundWire
>> +		  Version, Manufacturer ID, Part ID and Class ID,
>> +		  shall be in lower-case hexadecimal with leading
>> +		  zeroes suppressed.
>> +		  Version number '0x10' represents SoundWire 1.0
>> +		  Version number '0x11' represents SoundWire 1.1
>> +		  ex: "sdw10,0217,2010,0"
> 
> any reason why we want to code version number and not say sdw,1.0,...
> and so on?

For consistency reasons, as other info in hex.

> 
>> +
>> +- sdw-instance-id: Should be ('Instance ID') from SoundWire
>> +		  Enumeration Address. Instance ID is for the cases
>> +		  where multiple Devices of the same type or Class
>> +		  are attached to the bus.
> 
> instance id is part of the 48bit device id, so wont it make sense to add
> that to compatible as well?
> 
So we could have multiple instance of same IP, so adding this to 
compatible string does not make sense! As driver has to list all the 
possible compatible strings.

>> +
>> +SoundWire example for Qualcomm's SoundWire controller:
>> +
>> +soundwire@c2d0000 {
>> +	compatible = "qcom,soundwire-v1.5.0"
>> +	reg = <0x0c2d0000 0x2000>;
>> +
>> +	spkr_left:wsa8810-left{
>> +		compatible = "sdw10,0217,2010,0";
>> +		sdw-instance-id = <1>;
>> +		...
>> +	};
>> +
>> +	spkr_right:wsa8810-right{
>> +		compatible = "sdw10,0217,2010,0";
>> +		sdw-instance-id = <2>;
>> +		...
>> +	};
>> +};
>> -- 
>> 2.21.0
> 
