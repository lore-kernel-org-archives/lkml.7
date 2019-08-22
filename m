Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7306C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA90B2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VgOU7tWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387500AbfHVKMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 06:12:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35414 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfHVKMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 06:12:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so5170112wmg.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 03:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0wHYij0xMMbdONxhmt2Q6DoydIxVDY+xQcUzVqKt+3s=;
        b=VgOU7tWz9tj2ZdvC4hTvHdDaQeGT2Si9AZVE8FGa92l8Oqtw3XYoZkoc96vdmoLdwG
         6TLN0rXhF0HlZDEryfz+wuT6E51l6pbx4Lf9TVcLUd06F/yHq01QI5omfVdWK3HPxT/F
         ExM9NolGj7qcF7ZhmHYoy6SZ8+UzqDCfc/F2KM0bpe/QmgNyg6OFQ6Ut5AonVM2upk4L
         uTEf4SMluqVUX0JjgTH6DS5X7IHsLnkjFboNrZCxS1in6ghFay4ibpKZ0lJQLIUexKs8
         14HBW067R2l0VDDAnUk0xHLo79dXLaE+oecNJBZjoZyFZvbHb9LoS62NzVMlobfZHEVk
         gVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0wHYij0xMMbdONxhmt2Q6DoydIxVDY+xQcUzVqKt+3s=;
        b=rMzzMqAPfKq3wzDuQDvP43BITC8LwVKYuFOVj+Yb0udyq1pArOpuox70qNDIzTNmpv
         aXBUyqO15F+riMEiE8EaJ1sCyiaz7wIbat9J2/dyfY5m/Sd7wSPPwCxejRLL++8bLtRm
         ac0Z3xggxOvvM1MGz3jAj7MsdbrP3elEdAdCUKMEUVgadHzdHF2ybSU1J+6AXYq1/31I
         AzctSHT2JZs+ZnT6ROybmO0k8WNKqWYyh2Bpc7KsmnOHWauholycd8uLAD4BrhS+dSXe
         EWTGzpLE5ydA80mCzl+sT8nzC1BdlbmgQBmv39ir8HXMzCx7YK8JBFeWWij5/xvZGiko
         4ZBA==
X-Gm-Message-State: APjAAAXq6e/8yiLwBnoO0oYPeYvchFHka8jwXmxqww1kOdhlWqKewINT
        6onXWyOo3W9LZXJOBPKQiAeBDdW01VM=
X-Google-Smtp-Source: APXvYqzzdoD/tdJWCm9pMx3HqDlxZuqqt0CYYFgVGFGn8E/l9KoCM2HsQQahV6f7pF/TvpSlqT7Klg==
X-Received: by 2002:a7b:cb89:: with SMTP id m9mr5588534wmi.50.1566468729143;
        Thu, 22 Aug 2019 03:12:09 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id u186sm8418829wmu.26.2019.08.22.03.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 03:12:08 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] dt-bindings: soundwire: add slave bindings
To:     Rob Herring <robh@kernel.org>
Cc:     vkoul@kernel.org, broonie@kernel.org, bgoswami@codeaurora.org,
        plai@codeaurora.org, pierre-louis.bossart@linux.intel.com,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20190809133407.25918-1-srinivas.kandagatla@linaro.org>
 <20190809133407.25918-2-srinivas.kandagatla@linaro.org>
 <20190821214436.GA13936@bogus>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <0272eafd-0aa5-f695-64e4-f6ad7157a3a6@linaro.org>
Date:   Thu, 22 Aug 2019 11:12:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821214436.GA13936@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/08/2019 22:44, Rob Herring wrote:
> On Fri, Aug 09, 2019 at 02:34:04PM +0100, Srinivas Kandagatla wrote:
>> This patch adds bindings for Soundwire Slave devices that includes how
>> SoundWire enumeration address and Link ID are used to represented in
>> SoundWire slave device tree nodes.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../devicetree/bindings/soundwire/slave.txt   | 51 +++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soundwire/slave.txt
> 
> Can you convert this to DT schema given it is a common binding.
> 

I will give that a go in next version!

> What does the host controller look like? You need to define the node
> hierarchy. Bus controller schemas should then include the bus schema.
> See spi-controller.yaml.

Host controller is always parent of these devices which is represented 
in the example.

In my previous patches, i did put this slave bindings in bus.txt, but 
Vinod suggested to move it to slave.txt.

Are you suggesting to add two yamls here, one for slave and one for bus
Or just document this in one bus bindings?


> 
>>
>> diff --git a/Documentation/devicetree/bindings/soundwire/slave.txt b/Documentation/devicetree/bindings/soundwire/slave.txt
>> new file mode 100644
>> index 000000000000..201f65d2fafa
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soundwire/slave.txt
>> @@ -0,0 +1,51 @@
>> +SoundWire slave device bindings.
>> +
>> +SoundWire is a 2-pin multi-drop interface with data and clock line.
>> +It facilitates development of low cost, efficient, high performance systems.
>> +
>> +SoundWire slave devices:
>> +Every SoundWire controller node can contain zero or more child nodes
>> +representing slave devices on the bus. Every SoundWire slave device is
>> +uniquely determined by the enumeration address containing 5 fields:
>> +SoundWire Version, Instance ID, Manufacturer ID, Part ID
>> +and Class ID for a device. Addition to below required properties,
>> +child nodes can have device specific bindings.
>> +
>> +Required properties:
>> +- compatible:	 "sdw<LinkID><VersionID><InstanceID><MFD><PID><CID>".
>> +		  Is the textual representation of SoundWire Enumeration
>> +		  address along with Link ID. compatible string should contain
>> +		  SoundWire Link ID, SoundWire Version ID, Instance ID,
>> +		  Manufacturer ID, Part ID and Class ID in order
>> +		  represented as above and shall be in lower-case hexadecimal
>> +		  with leading zeroes. Vaild sizes of these fields are
>> +		  LinkID is 1 nibble,
>> +		  Version ID is 1 nibble
>> +		  Instance ID in 1 nibble
>> +		  MFD in 4 nibbles
>> +		  PID in 4 nibbles
>> +		  CID is 2 nibbles
>> +
>> +		  Version number '0x1' represents SoundWire 1.0
>> +		  Version number '0x2' represents SoundWire 1.1
> 
> This can all be a regex.
> 
>> +		  ex: "sdw0110217201000" represents 0 LinkID,
>> +		  SoundWire 1.0 version slave with Instance ID 1.
>> +		  More Information on detail of encoding of these fields can be
>> +		  found in MIPI Alliance DisCo & SoundWire 1.0 Specifications.
>> +
>> +SoundWire example for Qualcomm's SoundWire controller:
>> +
>> +soundwire@c2d0000 {
>> +	compatible = "qcom,soundwire-v1.5.0"
>> +	reg = <0x0c2d0000 0x2000>;
>> +
>> +	spkr_left:wsa8810-left{
>> +		compatible = "sdw0110217201000";
>> +		...
>> +	};
>> +
>> +	spkr_right:wsa8810-right{
>> +		compatible = "sdw0120217201000";
> 
> The normal way to distinguish instances is with 'reg'. So I think you
> need 'reg' with Instance ID moved there at least. Just guessing, but
> perhaps Link ID, too? And for 2 different classes of device is that
> enough?

In previous bindings ( https://lists.gt.net/linux/kernel/3403276 ) we 
did have instance-id as different property, however Pierre had some good 
suggestion to make it align with _ADR encoding as per MIPI DisCo spec.

Do you still think that we should split the instance id to reg property?

Thanks,
srini

> 
> Rob
> 
