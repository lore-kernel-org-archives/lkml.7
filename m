Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD817C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70ED320820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EeGNO3FG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbfDJJwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:52:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38527 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730104AbfDJJwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:52:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id w15so1847531wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 02:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NUV53/oB4wG+6wjO64XKH+JAP0dM3Iqgdg3p6qjAeB0=;
        b=EeGNO3FG+79etFuzLNgxtFGtGfNVEeFLQ4+UczJysLZJuON/e18mDLogmaq8DXFQLW
         BSnhCHM8/vwlC7pvbTQ6/DZ6az/vkQh2ZuIp4d7aMgZdNVntyFOF6/odH1O84n5yic/B
         rGbQFbDtdqABGzCOh3Wkv1r06O654DSuE/LzLOIVe/92zr/szCo5i2j1/YrDM+erE1K1
         PWEuHLEaaZcnjIQngdEZ8ALBgktrObr6aSF5qhIyA9Z8jdxomS2GS5hjuYN8DcXbuR0N
         nVXjM18veW+xN+T+WtehRXOI6Ju4TEqXIc3SfV7MSzxIlMuVY+MBKuHj80jWWk5IsaB8
         wi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NUV53/oB4wG+6wjO64XKH+JAP0dM3Iqgdg3p6qjAeB0=;
        b=qfnb8A3t7os8PXDBpaz4p81fZp8NiAEG6n8vGXifwxk0wVyRvQEEvw+ncPfoemPGhb
         Q0C5q8yXEyDpqzCtOm5PaW6HtUDxo1Tom32Mm5cIc1WZUrv7FrHDvSRaYRLzvSeX6Bof
         niGwfghTKv9yyGSH+cUoAHUjjZ5t31dvoKFNTLyAjBMrPqc/emGiko6PXIoQ/g/Fljz4
         czn3R6xKEdlMsiDLpa1AvEojje42wqcRw8+UT6rNkWReSQK9hdF7Pd61u85ao8Wk0WLo
         62fPHTFdMvLh2jpxZy+zLq2IzaHChP/WH3IHMUOaPfRGi1aqHlnMoktGD3MZOarLdNwL
         7AGA==
X-Gm-Message-State: APjAAAXCAx1VH7pdkFV8EgmSXJNi5HsSezZIssD6flaoCXEsoOLlk0NQ
        TPlSxNze7+OObDnMlNIexhjD/Q==
X-Google-Smtp-Source: APXvYqySkwzFY0FKpoyUUSvx2o6SqFCxHOanp5UeHKUk0Qjoda+QQ2fSvr9wDIKO0mRSvuFdtZH+CA==
X-Received: by 2002:a1c:6455:: with SMTP id y82mr2054928wmb.104.1554889939478;
        Wed, 10 Apr 2019 02:52:19 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id d3sm3495206wmf.46.2019.04.10.02.52.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 02:52:18 -0700 (PDT)
Subject: Re: [PATCH 1/4] dt-bindings: opp: Introduce opp-bw-MBs bindings
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     vireshk@kernel.org, sboyd@kernel.org, nm@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net,
        jcrouse@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, sibis@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20190313090010.20534-1-georgi.djakov@linaro.org>
 <20190313090010.20534-2-georgi.djakov@linaro.org>
 <20190314062312.vwyu3ryeyc6iv55h@vireshk-i7>
 <e462c932-4789-4f59-ad58-98c62266d977@linaro.org>
 <20190410040556.uwnhmhajcasic7hb@vireshk-i7>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <b94feeea-49d2-6761-11f5-fe2e9a3fa98b@linaro.org>
Date:   Wed, 10 Apr 2019 12:52:15 +0300
MIME-Version: 1.0
In-Reply-To: <20190410040556.uwnhmhajcasic7hb@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On 4/10/19 07:05, Viresh Kumar wrote:
> On 09-04-19, 17:36, Georgi Djakov wrote:
>> Hi Viresh,
>>
>> On 3/14/19 08:23, Viresh Kumar wrote:
>>> On 13-03-19, 11:00, Georgi Djakov wrote:
>>>> In addition to frequency and voltage, some devices may have bandwidth
>>>> requirements for their interconnect throughput - for example a CPU
>>>> or GPU may also need to increase or decrease their bandwidth to DDR
>>>> memory based on the current operating performance point.
>>>>
>>>> Extend the OPP tables with additional property to describe the bandwidth
>>>> needs of a device. The average and peak bandwidth values depend on the
>>>> hardware and its properties.
>>>>
>>>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>>>> ---
>>>>  Documentation/devicetree/bindings/opp/opp.txt | 45 +++++++++++++++++++
>>>>  1 file changed, 45 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
>>>> index 76b6c79604a5..fa598264615f 100644
>>>> --- a/Documentation/devicetree/bindings/opp/opp.txt
>>>> +++ b/Documentation/devicetree/bindings/opp/opp.txt
>>>> @@ -129,6 +129,9 @@ Optional properties:
>>>>  - opp-microamp-<name>: Named opp-microamp property. Similar to
>>>>    opp-microvolt-<name> property, but for microamp instead.
>>>>  
>>>> +- opp-bw-MBs: The interconnect bandwidth is specified with an array containing
>>>> +  the two integer values for average and peak bandwidth in megabytes per second.
>>>> +
>>>>  - opp-level: A value representing the performance level of the device,
>>>>    expressed as a 32-bit integer.
>>>>  
>>>> @@ -546,3 +549,45 @@ Example 6: opp-microvolt-<name>, opp-microamp-<name>:
>>>>  		};
>>>>  	};
>>>>  };
>>>> +
>>>> +Example 7: opp-bw-MBs:
>>>> +(example: average and peak bandwidth values are defined for each OPP and the
>>>> +interconnect between CPU and DDR memory is scaled together with CPU frequency)
>>>> +
>>>> +/ {
>>>> +	cpus {
>>>> +		CPU0: cpu@0 {
>>>> +			compatible = "arm,cortex-a53", "arm,armv8";
>>>> +			...
>>>> +			operating-points-v2 = <&cpu_opp_table>;
>>>> +			/* path between the CPU and DDR memory */
>>>> +			interconnects = <&rpm_bimc MASTER_AMPSS_M0
>>>> +					&rpm_bimc SLAVE_EBI_CH0>;
>>>
>>> Can we have multiple paths for a device ?
>>
>> I suppose that this is also a possible scenario. Will propose something
>> to handle multiple paths too.
>>
>>>> +		};
>>>> +	};
>>>> +
>>>> +	cpu_opp_table: cpu_opp_table {
>>>> +		compatible = "operating-points-v2";
>>>> +		opp-shared;
>>>> +
>>>> +		opp-200000000 {
>>>> +			opp-hz = /bits/ 64 <200000000>;
>>>> +			/* 457 MB/s average and 1525 MB/s peak bandwidth */
>>>> +			opp-bw-MBs = <457 1525>;
>>>
>>> In that case fixing this to just 2 entries in the array is incorrect
>>> and we should take care of that in the bindings here.
>>
>> We can encode the path name into the property (when there are multiple
>> paths). We already have opp-microamp-<name> and opp-microamp-<name>, so
>> we can follow the same practice.
>>
>> For example:
>>
>> CPU0: cpu@0 {
>> 	compatible = "arm,cortex-a53", "arm,armv8";
>> 	...
>> 	operating-points-v2 = <&cpu_opp_table>;
>> 	/* path between the CPU and DDR and path between CPU and L3 */
>> 	interconnects = <&bimc MASTER_AMPSS_M0 &bimc SLAVE_EBI_CH0>,
>> 			<&bimc MASTER_AMPSS_M0 &bimc SLAVE_L3>;
>> 	interconnect-names "cpu-mem", "cpu-l3";
>> };
>>
>> cpu_opp_table: cpu_opp_table {
>> 	compatible = "operating-points-v2";
>> 	opp-shared;
>>
>> 	opp-200000000 {
>> 		opp-hz = /bits/ 64 <200000000>;
>> 		/* 457 MB/s average, 1525 MB/s peak bandwidth to DDR */
>> 		opp-bw-MBps-cpu-mem = <457 1525>;
>> 		/* 914 MB/s average, 3050 MB/s peak bandwidth to L3 */
>> 		opp-bw-MBps-cpu-l3 = <914 3050>;
>> 	};
>> };
> 
> The -<name> property is different as only one of the value is ever used, i.e. we
> can have opp-microvolt-speed0/1/2/3 (4 different values/properties) and only
> opp-microvolt-speed1 will be used eventually and all others are discarded.
> 
> Also I am not sure if this will be actually required. We already have a list of
> interconnects above and the order of that can be taken as reference here. i.e.
> 
> CPU0: cpu@0 {
> 	compatible = "arm,cortex-a53", "arm,armv8";
> 	...
> 	operating-points-v2 = <&cpu_opp_table>;
> 	/* path between the CPU and DDR and path between CPU and L3 */
> 	interconnects = <&bimc MASTER_AMPSS_M0 &bimc SLAVE_EBI_CH0>,
> 			<&bimc MASTER_AMPSS_M0 &bimc SLAVE_L3>;
> };
> 
> cpu_opp_table: cpu_opp_table {
> 	compatible = "operating-points-v2";
> 	opp-shared;
> 
> 	opp-200000000 {
> 		opp-hz = /bits/ 64 <200000000>;
> 		/* 457 MB/s average, 1525 MB/s peak bandwidth to DDR */
> 		/* 914 MB/s average, 3050 MB/s peak bandwidth to L3 */
> 		opp-bw-MBps = <457 1525>, <914 3050>;
> 	};
> };

This works too.

> 
> I also strongly believe that "opp-bw-MBps" should be renamed in a way to make it
> independent of the OPPs. For example, we may have devices which also need to add
> their vote for the bandwidth but don't have an OPP table as they don't do DVFS.
> And the same property should be used by them directly as what we will have in
> the individual OPPs in the above example case.
> 
> So maybe something like bw-MBps or something else.

Ok, will make it bandwidth-MBps.

Thanks,
Georgi
