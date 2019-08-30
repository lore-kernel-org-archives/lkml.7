Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506FEC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1149F21874
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cqARl1b8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfH3IFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 04:05:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38596 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfH3IFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 04:05:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id e16so5998243wro.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 01:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ljpav7cp0jQCcXvbtu+znGOpg/cjpMnD8tVzcIJZM3U=;
        b=cqARl1b8o1qWpahsIaOF3U049kFqLEgTCiSqSir1tjOVGr12xcRjsf3fLLdFFzPahH
         /c2+z82jmorUf+NUTiTTMdcAwc7XojOAlTCA2zEg/+ioO9jEBu5Yifhq8pm/grtMxxxS
         vp029MRA0gVO8xvPQmGyX5Xec3c3losomUo9DIE+sYzKSd0/sxvTXI0kI6ItuCv8lPa4
         79FqueXiTnc33GKkIYg6I03vvVhEfKIjoeU9S1iiBuAYtE+jyKHrRpWJWZHoiwCotB7/
         hc12QzIrcdHkNjQtX14XrE2LT+VujJlyhb00rKG9oQNRbemqmtA/3l/XNlp/iO/oJwuP
         1gkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ljpav7cp0jQCcXvbtu+znGOpg/cjpMnD8tVzcIJZM3U=;
        b=t3ZOnFD6blLDaxwYj2PTjPwajBsY1srkqpMjbCWkyiW46uFWG3BdVBVbeMfc3Ep7Qv
         TVDiCcsXfXxbnmu4H6NuyCJNHCZ/nTe0PQU2n6R9wDCzikg0SEQ4OKA0aKJ/sY8IzAZM
         ca35zoZJLVdcAgBGXqn1Z3vVRUl8hnwqofczdkMT0VbGTonSCf0bCo2H31YoMVNh1da0
         9IWJ1Gh14Q9fpGLRBhRF9eKPPkjHCYNvsp4Glrvb9+cLv19VxZxmGdj+B4VUEs1STK+V
         Fbb7kU+gRtOwjz/qQpCSA5APmdydQ9wbcxWsf/4/6439DK6KS8+n6DBdu9HN+rNHCLSp
         gOxw==
X-Gm-Message-State: APjAAAVNuDpzLyYyGkWHNr1uwnqYK8FipIHGhajHTi9jVV962tYLnTXz
        IB3UFI9E4uHlhHl7bdIG2o9nPA==
X-Google-Smtp-Source: APXvYqxTJNG20RJIdTPA3YfkECo8o2rMaAsKPaXHCnjnxBnsTCuivMK2A/r9MzNhLc6cP34/tDa1Pw==
X-Received: by 2002:adf:db03:: with SMTP id s3mr17762359wri.214.1567152346692;
        Fri, 30 Aug 2019 01:05:46 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id t8sm11299633wra.73.2019.08.30.01.05.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 01:05:45 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] dt-bindings: soundwire: add bindings for Qcom
 controller
To:     Vinod Koul <vkoul@kernel.org>, robh+dt@kernel.org
Cc:     broonie@kernel.org, bgoswami@codeaurora.org, plai@codeaurora.org,
        pierre-louis.bossart@linux.intel.com, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, spapothi@codeaurora.org
References: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
 <20190813083550.5877-5-srinivas.kandagatla@linaro.org>
 <20190823072831.GE2672@vkoul-mobl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <2bf2d158-4028-8a5f-2c13-cab12ac165eb@linaro.org>
Date:   Fri, 30 Aug 2019 09:05:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823072831.GE2672@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 23/08/2019 08:28, Vinod Koul wrote:
> On 13-08-19, 09:35, Srinivas Kandagatla wrote:
>> This patch adds bindings for Qualcomm soundwire controller.
>>
>> Qualcomm SoundWire Master controller is present in most Qualcomm SoCs
>> either integrated as part of WCD audio codecs via slimbus or
>> as part of SOC I/O.
> 
> Rob.. ?
> 
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../bindings/soundwire/qcom,sdw.txt           | 167 ++++++++++++++++++
>>   1 file changed, 167 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
>>
>> diff --git a/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt b/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt

Do you see any issues with the these bindings?

--srini
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
>> +
>> +- qcom,din-ports:
>> +	Usage: required
>> +	Value type: <u32>
>> +	Definition: must be count of data in ports
>> +
>> +- qcom,ports-offset1:
>> +	Usage: required
>> +	Value type: <prop-encoded-array>
>> +	Definition: should specify payload transport window offset1 of each
>> +		    data port. Out ports followed by In ports.
>> +		    More info in MIPI Alliance SoundWire 1.0 Specifications.
>> +
>> +- qcom,ports-offset2:
>> +	Usage: required
>> +	Value type: <prop-encoded-array>
>> +	Definition: should specify payload transport window offset2 of each
>> +		    data port. Out ports followed by In ports.
>> +		    More info in MIPI Alliance SoundWire 1.0 Specifications.
>> +
>> +- qcom,ports-sinterval-low:
>> +	Usage: required
>> +	Value type: <prop-encoded-array>
>> +	Definition: should be sample interval low of each data port.
>> +		    Out ports followed by In ports. Used for Sample Interval
>> +		    calculation.
>> +		    More info in MIPI Alliance SoundWire 1.0 Specifications.
>> +
>> +- qcom,ports-word-length:
>> +	Usage: optional
>> +	Value type: <prop-encoded-array>
>> +	Definition: should be size of payload channel sample.
>> +		    More info in MIPI Alliance SoundWire 1.0 Specifications.
>> +
>> +- qcom,ports-block-pack-mode:
>> +	Usage: optional
>> +	Value type: <prop-encoded-array>
>> +	Definition: should be 0 or 1 to indicate the block packing mode.
>> +		    0 to indicate Blocks are per Channel
>> +		    1 to indicate Blocks are per Port.
>> +		    Out ports followed by In ports.
>> +		    More info in MIPI Alliance SoundWire 1.0 Specifications.
>> +
>> +- qcom,ports-block-group-count:
>> +	Usage: optional
>> +	Value type: <prop-encoded-array>
>> +	Definition: should be in range 1 to 4 to indicate how many sample
>> +		    intervals are combined into a payload.
>> +		    Out ports followed by In ports.
>> +		    More info in MIPI Alliance SoundWire 1.0 Specifications.
>> +
>> +- qcom,ports-lane-control:
>> +	Usage: optional
>> +	Value type: <prop-encoded-array>
>> +	Definition: should be in range 0 to 7 to identify which	data lane
>> +		    the data port uses.
>> +		    Out ports followed by In ports.
>> +		    More info in MIPI Alliance SoundWire 1.0 Specifications.
>> +
>> +- qcom,ports-hstart:
>> +	Usage: optional
>> +	Value type: <prop-encoded-array>
>> +	Definition: should be number identifying lowerst numbered coloum in
>> +		    SoundWire Frame, i.e. left edge of the Transport sub-frame
>> +		    for each port. Values between 0 and 15 are valid.
>> +		    Out ports followed by In ports.
>> +		    More info in MIPI Alliance SoundWire 1.0 Specifications.
>> +
>> +- qcom,ports-hstop:
>> +	Usage: optional
>> +	Value type: <prop-encoded-array>
>> +	Definition: should be number identifying highest numbered coloum in
>> +		    SoundWire Frame, i.e. the right edge of the Transport
>> +		    sub-frame for each port. Values between 0 and 15 are valid.
>> +		    Out ports followed by In ports.
>> +		    More info in MIPI Alliance SoundWire 1.0 Specifications.
>> +
>> +- qcom,dports-type:
>> +	Usage: optional
>> +	Value type: <prop-encoded-array>
>> +	Definition: should be one of the following types
>> +		    0 for reduced port
>> +		    1 for simple ports
>> +		    2 for full port
>> +		    Out ports followed by In ports.
>> +		    More info in MIPI Alliance SoundWire 1.0 Specifications.
>> +
>> +Note:
>> +	More Information on detail of encoding of these fields can be
>> +found in MIPI Alliance SoundWire 1.0 Specifications.
>> +
>> += SoundWire devices
>> +Each subnode of the bus represents SoundWire device attached to it.
>> +The properties of these nodes are defined by the individual bindings.
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
>> +		....
>> +	};
>> +
>> +	/* Right Speaker */
>> +	right{
>> +		....
>> +	};
>> +};
>> -- 
>> 2.21.0
> 
