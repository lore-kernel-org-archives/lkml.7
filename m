Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06FEC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F6420854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vHl8FZk3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388547AbfJNRex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 13:34:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43489 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730180AbfJNRex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 13:34:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id j18so20671197wrq.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 10:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=goZ9xr3ZvDzSv2nJz6yrf4HXNzE2UZomKxVxc5DO9BY=;
        b=vHl8FZk3irxNcBHFS6WDvNRLbzSI+2dM7zbxblpP7TrH699NnU4A9rTupP3aIW6xLI
         1s3nVKqg749HwtV8wrwNj90Rz/dzdgcEmIkULO5n8TlL+B6U1do2uDthDToVn3+D0YP2
         9KgM6aqtUcji4E1xaPX9PywJHKS7Cs+v8hJnM9lZJWyE2XoCv2GwTYJru5+SC4Z8hfl/
         rv+8BvLK+Z/9arnhKtio+xT6q+iTiwV6I9bGi04EUmqVK2PkXEHChONF6QBNgpvEGZB4
         wKKgOeuVaw+6Alc/huUKGS08Csjskopiso9M5JfZMRrALxCYDFSX/ZxvrWlPdwdadWeU
         8vGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=goZ9xr3ZvDzSv2nJz6yrf4HXNzE2UZomKxVxc5DO9BY=;
        b=pvIvPtl9VrF2fuY5dcWh47nnoBP6luxf6ADTalsl2QkpEHGxG90jXZYg0wmSRy58Tm
         mpvVIBtsUPm1+uRuLPsgklemOnivljJciRDiJlFuiRNCW7+bJCQInVvsdmuNY7bVIVgJ
         c4l2J0/qCeyqF8XJRpIKbpKeohjY88eNKblmapLEEzJKZL30Gn17u+tr1ZG+4mus/EHG
         qHxv3+UbeEgPk1W8B0jalTlrAqHitDaQkSCZKf4JHi4Op2/R2czv5i8412xiDnibAgRN
         k3NCne9fht1tt7Mqw493GkRyu3hdGBw9jR8wxYwdb2UbexzVWcR408nj59Tw7gBWOw8B
         M55A==
X-Gm-Message-State: APjAAAUghdUnhPfGnE9JjddDRzHdmiWCLZPmpL/PYxcxZ5O2VmPodmpy
        vAsQzDY+ihY+B7pxha8ROOyVKQ==
X-Google-Smtp-Source: APXvYqx6o+W6CiM2QYYNE1LOP02RBlpY0Gjx6cCk2+/iSWkz3HaCQgW35hyYYEVSjE7RAe42vaKioA==
X-Received: by 2002:a05:6000:1204:: with SMTP id e4mr12865496wrx.23.1571074488594;
        Mon, 14 Oct 2019 10:34:48 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id g185sm26164302wme.10.2019.10.14.10.34.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2019 10:34:47 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] dt-bindings: soundwire: add bindings for Qcom
 controller
To:     Rob Herring <robh@kernel.org>
Cc:     vkoul@kernel.org, broonie@kernel.org, bgoswami@codeaurora.org,
        pierre-louis.bossart@linux.intel.com, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, spapothi@codeaurora.org
References: <20191011154423.2506-1-srinivas.kandagatla@linaro.org>
 <20191011154423.2506-2-srinivas.kandagatla@linaro.org>
 <20191014171241.GA24989@bogus>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <76be1a0d-43ea-44c3-ef6c-9f9a2025c7a2@linaro.org>
Date:   Mon, 14 Oct 2019 18:34:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191014171241.GA24989@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Rob for taking time to review,

On 14/10/2019 18:12, Rob Herring wrote:
> On Fri, Oct 11, 2019 at 04:44:22PM +0100, Srinivas Kandagatla wrote:
>> This patch adds bindings for Qualcomm soundwire controller.
>>
>> Qualcomm SoundWire Master controller is present in most Qualcomm SoCs
>> either integrated as part of WCD audio codecs via slimbus or
>> as part of SOC I/O.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../bindings/soundwire/qcom,sdw.txt           | 167 ++++++++++++++++++
>>   1 file changed, 167 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
> 
> Next time, do a DT schema.
> 
Sure! I can do that in next version!

>> diff --git a/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt b/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
>> new file mode 100644
>> index 000000000000..436547f3b155
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
>> @@ -0,0 +1,167 @@
>> +Qualcomm SoundWire Controller Bindings
>> +
>> +
>> +This binding describes the Qualcomm SoundWire Controller along with its
>> +board specific bus parameters.
>> +
>> +- compatible:
>> +	Usage: required
>> +	Value type: <stringlist>
>> +	Definition: must be "qcom,soundwire-v<MAJOR>.<MINOR>.<STEP>",
>> +		    Example:
>> +			"qcom,soundwire-v1.3.0"
>> +			"qcom,soundwire-v1.5.0"
>> +			"qcom,soundwire-v1.6.0"
> 
> This needs to be the actual versions supported, not examples. Elsewhere
> in QCom bindings, we've used standard SoC specific compatibles as there
> never tends to be many SoCs with the same version. Anything different
> here?
> 

These values of MAJOR MINOR and STEP are defined as part of IP spec. And 
most of the QCom IPs follow such scheme. We can read back these values 
from the Hardware registers.

Having SoC Names here might not be very efficient here.
We have used such compatibles on may QCom IPs, like BAM DMA, SLIMBus and 
other drivers.

>> +- reg:
>> +	Usage: required
>> +	Value type: <prop-encoded-array>
>> +	Definition: the base address and size of SoundWire controller
>> +		    address space.
>> +
>> +- interrupts:
>> +	Usage: required
>> +	Value type: <prop-encoded-array>
>> +	Definition: should specify the SoundWire Controller IRQ
>> +
>> +- clock-names:
>> +	Usage: required
>> +	Value type: <stringlist>
>> +	Definition: should be "iface" for SoundWire Controller interface clock
>> +
>> +- clocks:
>> +	Usage: required
>> +	Value type: <prop-encoded-array>
>> +	Definition: should specify the SoundWire Controller interface clock
>> +
>> +- #sound-dai-cells:
>> +	Usage: required
>> +	Value type: <u32>
>> +	Definition: must be 1 for digital audio interfaces on the controller.
>> +
>> +- qcom,dout-ports:
>> +	Usage: required
>> +	Value type: <u32>
>> +	Definition: must be count of data out ports
> 
> Up to how many?
> 
>> +
>> +- qcom,din-ports:
>> +	Usage: required
>> +	Value type: <u32>
>> +	Definition: must be count of data in ports
> 
> Up to how many?

Up to 15 data ports in total

> 
>> +
...

>> +Note:
>> +	More Information on detail of encoding of these fields can be
>> +found in MIPI Alliance SoundWire 1.0 Specifications.
>> +
>> += SoundWire devices
>> +Each subnode of the bus represents SoundWire device attached to it.
>> +The properties of these nodes are defined by the individual bindings.
> 
> Is there some sort of addressing that needs to be defined?
> 
Thanks, Looks like I missed that here.

it should be something like this,

#address-cells = <2>;
#size-cells = <0>;

Will add the in next version.


>> +
>> += EXAMPLE
>> +The following example represents a SoundWire controller on DB845c board
>> +which has controller integrated inside WCD934x codec on SDM845 SoC.
>> +
>> +soundwire: soundwire@c85 {
>> +	compatible = "qcom,soundwire-v1.3.0";
>> +	reg = <0xc85 0x20>;
>> +	interrupts = <20 IRQ_TYPE_EDGE_RISING>;
>> +	clocks = <&wcc>;
>> +	clock-names = "iface";
>> +	#sound-dai-cells = <1>;
>> +	qcom,dports-type = <0>;
>> +	qcom,dout-ports	= <6>;
>> +	qcom,din-ports	= <2>;
>> +	qcom,ports-sinterval-low = /bits/ 8  <0x07 0x1F 0x3F 0x7 0x1F 0x3F 0x0F 0x0F>;
>> +	qcom,ports-offset1 = /bits/ 8 <0x01 0x02 0x0C 0x6 0x12 0x0D 0x07 0x0A >;
>> +	qcom,ports-offset2 = /bits/ 8 <0x00 0x00 0x1F 0x00 0x00 0x1F 0x00 0x00>;
>> +
>> +	/* Left Speaker */
>> +	left{
> 
> space       ^
>> +		....
>> +	};
>> +
>> +	/* Right Speaker */
>> +	right{
> 
> ditto
> 
>> +		....
>> +	};
>> +};
>> -- 
>> 2.21.0
>>
