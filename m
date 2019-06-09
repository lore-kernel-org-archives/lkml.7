Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6D3C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94FE2070B
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j6uxcaoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbfFIMQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 08:16:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36878 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbfFIMQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 08:16:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id 22so5700534wmg.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 05:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EEIVK1Eriab7DfTys4fv9a6X+JgT7Ww4XuNFF08fezk=;
        b=j6uxcaoaKCapNqqp5pQ9ML3LEuvXv1L3nZmhRq3LFKy1gEbKnEBzNv7Fe+5GbsIg0w
         HxHdYHudjlSPUPc6C/waBTmPiwCW0TqQlgEGr7mrdlVpHjpcerO3uAqr49Q/3Vajesso
         Ppqzpo2aFO31OanB9cYzZuSu++GBEqxR+fh1vi7V+I9ZlBJtLBtpY2xpXlOP2a22wnlT
         Y0qNlfpikAO3pFmpjtrqwBooYM3By7/cvRo3joQcrajuQtPiasKuOv7YoB+sXB7swaH+
         nnoeim3adrEzqOOReKYq2+ib59zzEWaKwRNlx+Ua3K1bgo7GNrOgQGWconv6IpolU14L
         flDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EEIVK1Eriab7DfTys4fv9a6X+JgT7Ww4XuNFF08fezk=;
        b=SbZTosR2JCb/3H45wpzEW8WpfDFk3eTjLxp8dW7ZXrcN/bYcvCPegNHdGDZTsr/R0s
         Xxlw4rV+s6RTAAYJBoj7z/vDBUzlBvPcEBawB6rYfT4/bJ+w52ubVkSEwc/RIo/j38oA
         VKHmO1bWfng8qbSwOLvb0I2PZBmCoPk2IZukNXZB61LJLLO4zs0WwFKYyaDKuiAE3NxC
         PeG+EvXBC/DWgmca4Y3joM9OWYFUmDV5m3wzgpPyxDeVWNoZKPchRYT50rI1gG8v7gtY
         sBwl2TsATcpMxtauXBcyafHmN/frBbCSPHaBdKPfk4i40w2Ixnszm3J+ayiCpfhFSn0n
         kPXg==
X-Gm-Message-State: APjAAAX6g1ckrPwgbAUFwq1PNjAOmABFQJoehuBsl5ksaFkhs8lkkisS
        8I1w2OAGEIzzCtsZR0myYJFyzV+T/PSm0g==
X-Google-Smtp-Source: APXvYqzS5FT4ul4wt6NNZJuc6Ovby2vtZ6Ue5SHYemoOi2SUcSOC1UMQrdBs0n3M43l90j00aEgZ1g==
X-Received: by 2002:a7b:c018:: with SMTP id c24mr7567870wmb.37.1560082570895;
        Sun, 09 Jun 2019 05:16:10 -0700 (PDT)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id t6sm7526665wmb.29.2019.06.09.05.16.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 05:16:10 -0700 (PDT)
Subject: Re: [alsa-devel] [RFC PATCH 5/6] dt-bindings: soundwire: add bindings
 for Qcom controller
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, vkoul@kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
 <20190607085643.932-6-srinivas.kandagatla@linaro.org>
 <f2ea97b2-935d-0c7d-cb55-6e16a19c2060@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <7cde3f3b-5b42-5939-1ee8-8e1d57e9ec9f@linaro.org>
Date:   Sun, 9 Jun 2019 13:16:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f2ea97b2-935d-0c7d-cb55-6e16a19c2060@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking time to review,

On 07/06/2019 13:50, Pierre-Louis Bossart wrote:
> On 6/7/19 3:56 AM, Srinivas Kandagatla wrote:
>> This patch adds bindings for Qualcomm soundwire controller.
>>
>> Qualcomm SoundWire Master controller is present in most Qualcomm SoCs
>> either integrated as part of WCD audio codecs via slimbus or
>> as part of SOC I/O.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../bindings/soundwire/qcom,swr.txt           | 62 +++++++++++++++++++
>>   1 file changed, 62 insertions(+)
>>   create mode 100644 
>> Documentation/devicetree/bindings/soundwire/qcom,swr.txt
> 
> you seem to use the 'swr' prefix in this patch. Most implementers use 
> 'sdw', and that's the default also used in the MIPI DisCo spec for 
> properties. Can we align on the same naming conventions?
> 
>>
>> diff --git a/Documentation/devicetree/bindings/soundwire/qcom,swr.txt 
>> b/Documentation/devicetree/bindings/soundwire/qcom,swr.txt
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
>> +- compatible:        Must be "qcom,soundwire-v<MAJOR>.<MINOR>.<STEP>",
>> +             example:
>> +            "qcom,soundwire-v1.3.0"
>> +            "qcom,soundwire-v1.5.0"
>> +            "qcom,soundwire-v1.6.0"
>> +- reg:            SoundWire controller address space.
>> +- interrupts:        SoundWire controller interrupt.
>> +- clock-names:        Must contain "iface".
>> +- clocks:        Interface clocks needed for controller.
>> +- #sound-dai-cells:    Must be 1 for digital audio interfaces on the 
>> controllers.
>> +- #address-cells:    Must be 1 for SoundWire devices;
>> +- #size-cells:        Must be <0> as SoundWire addresses have no size 
>> component.
>> +- qcom,dout-ports:     Must be count of data out ports
>> +- qcom,din-ports:     Must be count of data in ports
>> +- qcom,ports-offset1:    Must be frame offset1 of each data port.
>> +            Out followed by In. Used for Block size calculation.
>> +- qcom,ports-offset2:     Must be frame offset2 of each data port.
>> +            Out followed by In. Used for Block size calculation.
>> +- qcom,ports-sinterval-low: Must be sample interval low of each data 
>> port.
>> +            Out followed by In. Used for Sample Interval calculation.
> 
> These definitions are valid only for specific types of ports, I believe 
> here it's a 'reduced' port since offset2 is not required for simpler 
> ports and you don't have Hstart/Hstop.
> 
Yes, this version of the controller which am working on does not have 
DPN_SampleCtrl2 register for SampleIntervalHigh Field and has registers 
for programming offset2 does indeed indicate that these ports are 
reduced ports.

However looks like new versions of the this controller does support full 
data ports.

I can add more flexibility in bindings by adding qcom,dport-type field 
indicating this in next version.

> so if you state that all of these properties are required, you are 
> explicitly ruling out future implementations of simple ports or will 
> have to redefine them later.
> 
> Also the definition 'frame offset1/2' is incorrect. the offset is 
> defined within each Payload Transport Window - not each frame - and its 
> definition depends on the packing mode used, which isn't defined or 
> stated here.

Yep, BlockPackingMode is missing. 1.3 version of this controller only 
supports Block Per Port Block mode.

I guess this can be derived with in the driver by using compatible 
string, I can add some notes in the binding to make this more explicit.
I will also reword offset1/2 description to include transport window 
within frame

> 
> And last it looks like you assume a fixed frame shape - likely 50 rows 
> by 8 columns, it might be worth adding a note on the max values for 
> offset1/2 implied by this frame shape.

Its 48x16 in this case.


Thanks,
srini
