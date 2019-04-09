Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556EDC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E852084B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LCk8k4Zk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfDIOgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:36:20 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35248 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfDIOgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:36:10 -0400
Received: by mail-lj1-f194.google.com with SMTP id t4so14705002ljc.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 07:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GRmQuqs3ki74ifaBC4duDeXTD7XEpeEOC8f0jKIOaIY=;
        b=LCk8k4Zkg0y1iFhGdvdkxB+n46LRjRrwwK32lZepZHauaMPbdjO+9IlenZ5JcY70XE
         47j0iTv5MwFNG3TC4w/RweT2niA2WGDNYyt2xq+kj8VBXx1mQi34W2lGtoU7UgNv7R7x
         nO6Q4f6FejCktD3AebC4qvdzLbSmimPUex2P8xwiiGxagkXGXPyYnDUMIlfeCgIOTY0k
         knG5g979wo6Ryt8Vjw9bFdElhiH28AOJcVAo0kvhy2zQeXIetFeIwxIcaXUB8Cm+jYbb
         LwVlof9EaSZIT5PLgMfJTz+K4Mfgn0zud11KypKP3x0LrDXdmRDHa5PXQjAPTDdSuddz
         Dc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GRmQuqs3ki74ifaBC4duDeXTD7XEpeEOC8f0jKIOaIY=;
        b=aBhaRojnmRdW+cY+dxeDKRcxzl6cCLkiLmXzIlpaECF3+cvvzu6Iunihvcm7DCdc30
         +J2BhBFiYijVZJy6ZO6FEQ0ks/F1kbOjObfTkcu3Inpft7sDxcjctDT0CFauv12K1YGS
         mB91IKogH3NNozPDIKR/kfmZiygLWYpgIjujPAWzMmrCDllWNT81DLJfXYq3bd7SY2Ru
         WLe5CEXceK1NopcuhSIVfbBL/iQJ4R1GmL5sQWsNz0IQSolPXvOUScfK7+mZSQI9EUgZ
         65gHbEnTRB1l9hGVY3Q8pKwuFhUGjukE20hFi3swehn5kQ8VQCkMSVMPs/57sK/XVMYd
         v+Gw==
X-Gm-Message-State: APjAAAWxDXiF3hVXyhuNwd96vBEmds9Nl7HJiFakKyTXyJwkJQAshjHf
        du0ZXkOdB6xtqEtAS7UR5858OQ==
X-Google-Smtp-Source: APXvYqyLc3sO65Z2SZuDoRhtOIvze8wC+nFjxz8Mz9QrL1JYPTFxWMV3Qkf0tufAzwZpYiWKTCO2Lg==
X-Received: by 2002:a2e:9b48:: with SMTP id o8mr3654468ljj.51.1554820566747;
        Tue, 09 Apr 2019 07:36:06 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id e17sm6783545ljj.20.2019.04.09.07.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 07:36:05 -0700 (PDT)
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
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <e462c932-4789-4f59-ad58-98c62266d977@linaro.org>
Date:   Tue, 9 Apr 2019 17:36:01 +0300
MIME-Version: 1.0
In-Reply-To: <20190314062312.vwyu3ryeyc6iv55h@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On 3/14/19 08:23, Viresh Kumar wrote:
> On 13-03-19, 11:00, Georgi Djakov wrote:
>> In addition to frequency and voltage, some devices may have bandwidth
>> requirements for their interconnect throughput - for example a CPU
>> or GPU may also need to increase or decrease their bandwidth to DDR
>> memory based on the current operating performance point.
>>
>> Extend the OPP tables with additional property to describe the bandwidth
>> needs of a device. The average and peak bandwidth values depend on the
>> hardware and its properties.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/opp/opp.txt | 45 +++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
>> index 76b6c79604a5..fa598264615f 100644
>> --- a/Documentation/devicetree/bindings/opp/opp.txt
>> +++ b/Documentation/devicetree/bindings/opp/opp.txt
>> @@ -129,6 +129,9 @@ Optional properties:
>>  - opp-microamp-<name>: Named opp-microamp property. Similar to
>>    opp-microvolt-<name> property, but for microamp instead.
>>  
>> +- opp-bw-MBs: The interconnect bandwidth is specified with an array containing
>> +  the two integer values for average and peak bandwidth in megabytes per second.
>> +
>>  - opp-level: A value representing the performance level of the device,
>>    expressed as a 32-bit integer.
>>  
>> @@ -546,3 +549,45 @@ Example 6: opp-microvolt-<name>, opp-microamp-<name>:
>>  		};
>>  	};
>>  };
>> +
>> +Example 7: opp-bw-MBs:
>> +(example: average and peak bandwidth values are defined for each OPP and the
>> +interconnect between CPU and DDR memory is scaled together with CPU frequency)
>> +
>> +/ {
>> +	cpus {
>> +		CPU0: cpu@0 {
>> +			compatible = "arm,cortex-a53", "arm,armv8";
>> +			...
>> +			operating-points-v2 = <&cpu_opp_table>;
>> +			/* path between the CPU and DDR memory */
>> +			interconnects = <&rpm_bimc MASTER_AMPSS_M0
>> +					&rpm_bimc SLAVE_EBI_CH0>;
> 
> Can we have multiple paths for a device ?

I suppose that this is also a possible scenario. Will propose something
to handle multiple paths too.

>> +		};
>> +	};
>> +
>> +	cpu_opp_table: cpu_opp_table {
>> +		compatible = "operating-points-v2";
>> +		opp-shared;
>> +
>> +		opp-200000000 {
>> +			opp-hz = /bits/ 64 <200000000>;
>> +			/* 457 MB/s average and 1525 MB/s peak bandwidth */
>> +			opp-bw-MBs = <457 1525>;
> 
> In that case fixing this to just 2 entries in the array is incorrect
> and we should take care of that in the bindings here.

We can encode the path name into the property (when there are multiple
paths). We already have opp-microamp-<name> and opp-microamp-<name>, so
we can follow the same practice.

For example:

CPU0: cpu@0 {
	compatible = "arm,cortex-a53", "arm,armv8";
	...
	operating-points-v2 = <&cpu_opp_table>;
	/* path between the CPU and DDR and path between CPU and L3 */
	interconnects = <&bimc MASTER_AMPSS_M0 &bimc SLAVE_EBI_CH0>,
			<&bimc MASTER_AMPSS_M0 &bimc SLAVE_L3>;
	interconnect-names "cpu-mem", "cpu-l3";
};

cpu_opp_table: cpu_opp_table {
	compatible = "operating-points-v2";
	opp-shared;

	opp-200000000 {
		opp-hz = /bits/ 64 <200000000>;
		/* 457 MB/s average, 1525 MB/s peak bandwidth to DDR */
		opp-bw-MBps-cpu-mem = <457 1525>;
		/* 914 MB/s average, 3050 MB/s peak bandwidth to L3 */
		opp-bw-MBps-cpu-l3 = <914 3050>;
	};
};

Thanks,
Georgi
