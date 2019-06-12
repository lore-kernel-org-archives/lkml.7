Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EDDC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1FB20896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TW/UKNjw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439093AbfFLMoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:44:25 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17814 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfFLMoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:44:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d00f3a80000>; Wed, 12 Jun 2019 05:44:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 12 Jun 2019 05:44:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 12 Jun 2019 05:44:23 -0700
Received: from [10.25.72.203] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 12 Jun
 2019 12:44:20 +0000
Subject: Re: [PATCH v2 2/2] arm64: tegra: enable ACONNECT, ADMA and AGIC
To:     Jon Hunter <jonathanh@nvidia.com>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <mkumard@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1560243406-2535-1-git-send-email-spujar@nvidia.com>
 <1560243406-2535-2-git-send-email-spujar@nvidia.com>
 <4e017e97-8a05-c1fe-2cd9-b985e79d02a1@nvidia.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <ce8e26f7-4ed0-a5a4-821b-fdfa3a7e334e@nvidia.com>
Date:   Wed, 12 Jun 2019 18:14:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <4e017e97-8a05-c1fe-2cd9-b985e79d02a1@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560343464; bh=Q55uAwywKsR8epPdBWkz9Rpb97YuyeCnSeDhkK2Usfw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=TW/UKNjwz3P+VCTBecICJr11lxGiXiWNMiEKY8cgSztu6D6zTLqmiyNi+xUCocypy
         b6+Wji+ndya4GU81AnoRydpzTP63n4I1d8L4fR2QuYD3MfVKIHwGPXkbld/hbmsyex
         spEa1W7DFFCe21KbgpJDODRcKbOdspe3k1IesvXXbMfPSCShW1uBnT8iEzHVbsyC5p
         ZT3Iz/qQPIOKtl3x54OoHFEpxVRz+kGTwDcuIJYKsa4fAZSHgFzn9wf17bt3W8NY98
         X2o1W4r5/cKMLn+7rDTLtDUal67pDnKX+8CRAntuI7h/PRCvztRbGiSVvkTbirnrjn
         gb9QvA74tXxVw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/12/2019 6:07 PM, Jon Hunter wrote:
>
> On 11/06/2019 09:56, Sameer Pujar wrote:
>> Enable ACONNECT, ADMA and AGIC devices for following platforms
>>    * Jetson TX2
>>    * Jetson Xavier
>>
>> Verified driver probe path and devices get registered fine.
>>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> ---
>>   arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts | 12 ++++++++++++
>>   arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts | 12 ++++++++++++
>>   2 files changed, 24 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
>> index 5102de1..b818355 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
>> +++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
>> @@ -298,4 +298,16 @@
>>   			vin-supply = <&vdd_5v0_sys>;
>>   		};
>>   	};
>> +
>> +	aconnect@2a41000 {
>> +		status = "okay";
>> +
>> +		dma-controller@2930000 {
>> +			status = "okay";
>> +		};
>> +
>> +		agic@2a41000 {
>> +			status = "okay";
>> +		};
>> +	};
>>   };
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
>> index 6e6df65..d1cc028 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
>> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
>> @@ -167,4 +167,16 @@
>>   			};
>>   		};
>>   	};
>> +
>> +	aconnect@2a41000 {
>> +		status = "okay";
>> +
>> +		dma-controller@2930000 {
>> +			status = "okay";
>> +		};
>> +
>> +		agic@2a41000 {
>> +			status = "okay";
>> +		};
>> +	};
>>   };
>>
> I believe that I have already ACK'ed this, so please include for the
> next revision.
There is a small change related to dma node.
Will include ACK in the next revision.
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
>
> Cheers
> Jon
>
