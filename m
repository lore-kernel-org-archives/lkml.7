Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DC0C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B0C2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="itjfuEoX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387955AbfFJIOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 04:14:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35445 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387824AbfFJIOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 04:14:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id m3so8194022wrv.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 01:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FoeVTYzF5ZDi2tID72FryeJ/j+o8r81eaeVqgETUoko=;
        b=itjfuEoXOvXwxbRwuF6HrhTmMzpt6ljGh0o24LPk+N83H/V44mafKAvoTtxvdP14KI
         LJFlVdi880AiwQnNR9viKWtZQ/ad5i6A238QtGDRjDfySmXGFr6sRkq82+fKocOAZg5N
         4FziCyWxT7dEY3/oADWNFmOvqND8lybwrvWtQqEOafXloTjd6s9k1YaLHjevxD08LR1U
         kDfqayPy7cM7+IajIExVAVT7g1tOUDCkmPYDVnR1yGcu5rH0JH6gGpihkAiIv3xsatlv
         isLSXUYnVtLdBH7SmW7QVjYbO/Md30vYrs7/2WQEtnGwzMYCg1yf40HuHbDIHbr5Q6Pu
         IzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FoeVTYzF5ZDi2tID72FryeJ/j+o8r81eaeVqgETUoko=;
        b=pyi7TRajwEijQ90t3K/F2fcgnrCVHp52S0IqDRUzzo0o1n12+gyHIM68raDVa4hmgK
         s5SUT/6Xmd/22cvF0tnB3G7w8HYg4qoEiTgAZaxb1n5t3dMAdK0fwDE2QbZGB5sVlKG/
         /7R1VXK1AG2aibpi1yG+8Rcn3z7nWmIl+KkRv3D18GlKK5uTS795zgTOZ4njtgAcxPlJ
         UdHgdBphg1Ij77pmh2Q1G+/3SlYHskcoeGv1K2aXflrJMoVTbt2yxHhHlXVSFNo3iRIF
         N++LafPg2qoPqvPxPWO2z5VMQ5tUbxApjfuhb3ecMqRKNuagGPBz6cAceNwo+axH3VZ6
         NHLA==
X-Gm-Message-State: APjAAAWAFn2HRg8jRTfZgOC8CVZj3CJlXxGnlon+ZumRx5Xi8GDzgr/j
        /CAHWEXSrXYsZX3c2pXbw92YpdfHVlHz4g==
X-Google-Smtp-Source: APXvYqy9NQENDTf7h9IM9Fr1WLtg2wN5q3OPNu/X/z7kY2UX4lC5AHdyFIKS7VcslrPFuacPBM++HA==
X-Received: by 2002:adf:e2c3:: with SMTP id d3mr16647979wrj.314.1560154480327;
        Mon, 10 Jun 2019 01:14:40 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id f2sm17310279wrq.48.2019.06.10.01.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 01:14:39 -0700 (PDT)
Subject: Re: [RFC PATCH 5/6] dt-bindings: soundwire: add bindings for Qcom
 controller
To:     Vinod Koul <vkoul@kernel.org>
Cc:     broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
 <20190607085643.932-6-srinivas.kandagatla@linaro.org>
 <20190610045150.GJ9160@vkoul-mobl.Dlink>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <f1e68207-caa2-02e0-19af-ac5763c86e41@linaro.org>
Date:   Mon, 10 Jun 2019 09:14:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190610045150.GJ9160@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/06/2019 05:51, Vinod Koul wrote:
> On 07-06-19, 09:56, Srinivas Kandagatla wrote:
>> This patch adds bindings for Qualcomm soundwire controller.
>>
>> Qualcomm SoundWire Master controller is present in most Qualcomm SoCs
>> either integrated as part of WCD audio codecs via slimbus or
>> as part of SOC I/O.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../bindings/soundwire/qcom,swr.txt           | 62 +++++++++++++++++++
> 
> So I was expecting to see bus support patches for OF first. I think you
> have missed those changes. Please do include those in v2 with bindings
> and OF support for bus.

I was planning to post bus bindings along with soundwire slave bindings 
of WSA881x driver!
I will be sending this soon!

> 
>>   1 file changed, 62 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soundwire/qcom,swr.txt
>>
>> diff --git a/Documentation/devicetree/bindings/soundwire/qcom,swr.txt b/Documentation/devicetree/bindings/soundwire/qcom,swr.txt
>> new file mode 100644
>> index 000000000000..eb84d0f4f36f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soundwire/qcom,swr.txt
>> @@ -0,0 +1,62 @@
>> +Qualcomm SoundWire Controller
>> +
>> +This binding describes the Qualcomm SoundWire Controller Bindings.
>> +
>> +Required properties:
>> +
>> +- compatible:		Must be "qcom,soundwire-v<MAJOR>.<MINOR>.<STEP>",
>> +	 		example:
>> +			"qcom,soundwire-v1.3.0"
>> +			"qcom,soundwire-v1.5.0"
>> +			"qcom,soundwire-v1.6.0"
>> +- reg:			SoundWire controller address space.
>> +- interrupts:		SoundWire controller interrupt.
>> +- clock-names:		Must contain "iface".
>> +- clocks:		Interface clocks needed for controller.
>> +- #sound-dai-cells:	Must be 1 for digital audio interfaces on the controllers.
>> +- #address-cells:	Must be 1 for SoundWire devices;
>> +- #size-cells:		Must be <0> as SoundWire addresses have no size component.
>> +- qcom,dout-ports: 	Must be count of data out ports
>> +- qcom,din-ports: 	Must be count of data in ports
> 
> On these I think we should have specified dpn properties as specified in
> DisCo, but then looking at spec we do not define that for master, but
> bus seems to have it.
> 
> Pierre do you why master does not have dpn properties in DisCo?
> 
>> +- qcom,ports-offset1:	Must be frame offset1 of each data port.
>> +			Out followed by In. Used for Block size calculation.
>> +- qcom,ports-offset2: 	Must be frame offset2 of each data port.
>> +			Out followed by In. Used for Block size calculation.
>> +- qcom,ports-sinterval-low: Must be sample interval low of each data port.
>> +			Out followed by In. Used for Sample Interval calculation.
> 
> These are software so do not belong here
These are board-specfic properties w.r.t this controller ports 
configuration.
I don't see any other option to specify this?
Do you have any alternative suggestions?

--srini
> 
