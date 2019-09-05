Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD711C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 04:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22202080C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 04:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lYLMDrnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbfIEEap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 00:30:45 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12812 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfIEEao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 00:30:44 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d708f740000>; Wed, 04 Sep 2019 21:30:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 04 Sep 2019 21:30:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 04 Sep 2019 21:30:43 -0700
Received: from [10.24.193.88] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 5 Sep
 2019 04:30:40 +0000
Subject: Re: [Patch V8 6/8] arm64: tegra: Enable xudc on Jetson TX1
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1567585440-13751-1-git-send-email-nkristam@nvidia.com>
 <1567585440-13751-7-git-send-email-nkristam@nvidia.com>
 <1567590435.7317.55.camel@mhfsdcap03>
X-Nvconfidentiality: public
From:   Nagarjuna Kristam <nkristam@nvidia.com>
Message-ID: <cac7603a-ba64-5ce1-edd9-43bdad729f61@nvidia.com>
Date:   Thu, 5 Sep 2019 10:02:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567590435.7317.55.camel@mhfsdcap03>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567657844; bh=UD9f/D9VyQKio7JMo+pBG9krt73CQjyUYKHYsPw7ZK4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=lYLMDrnBHlM4+wYCJRstqpuMx7/VzVSZNqMhJGHBhl7+6+0eEth7KBqeouZIBDfbc
         qqW/gqBupgzthOLNhDPXSwmOZfkAfN/34ZPF483FJmiQYV6uyTEZyyj6eex4GAP7DT
         BHMMsmMrlvZR/qZ7DT3QbTQNrtXcOgWKmAkVJg3+TEHlPsAZBmsHHjq8JpJ5QShC5g
         JzjfqESElcEpGkaRzy7r0kcatuLw0gDl9rGrlv2xLk6YOOZzJ/MIAcCV53RkZ2SE3g
         fLxkBA6dN8fAgJ49bHu2wfEas6N+kwLyeEVDHx8CQbfIZ09B3mHpKhqfBC0WYui952
         kEfj3bGgDzIAg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04-09-2019 15:17, Chunfeng Yun wrote:
> On Wed, 2019-09-04 at 13:53 +0530, Nagarjuna Kristam wrote:
>> Enable XUSB device mode driver for USB0 slot on Jetson TX1.
>>
>> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
>> Reviewed-by: JC Kuo <jckuo@nvidia.com>
>> ---
>>  arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi | 31 +++++++++++++++++++++++++-
>>  1 file changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
>> index a7dc319..6aba1ba 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
>> @@ -1362,7 +1362,7 @@
>>  				status = "okay";
>>  
>>  				lanes {
>> -					usb2-0 {
>> +					micro_b: usb2-0 {
>>  						nvidia,function = "xusb";
>>  						status = "okay";
>>  					};
>> @@ -1483,6 +1483,21 @@
>>  		vmmc-supply = <&vdd_3v3_sd>;
>>  	};
>>  
>> +	usb@700d0000 {
>> +		status = "okay";
>> +		phys = <&micro_b>;
>> +		phy-names = "usb2";
>> +		avddio-usb-supply = <&vdd_3v3_sys>;
>> +		hvdd-usb-supply = <&vdd_1v8>;
>> +		usb-role-switch;
>> +
>> +		port {
>> +			usb_role_switch: endpoint {
>> +				remote-endpoint = <&usb_b_conn_ep>;
>> +			};
>> +		};
>> +	};
>> +
>>  	regulators {
>>  		compatible = "simple-bus";
>>  		#address-cells = <1>;
>> @@ -1641,4 +1656,18 @@
>>  			linux,code = <KEY_VOLUMEUP>;
>>  		};
>>  	};
>> +
>> +	usb_type_b: connector {
>> +		compatible = "linux,usb-conn-gpio", "gpio-usb-b-connector";
> please use "gpio-usb-b-connector" and "usb-b-connector", due to
> "linux,usb-conn-gpio" is not supported now
> 
> 

Thanks for info, will update accordingly.

>> +		label = "micro-USB";
>> +		type = "micro";
>> +		vbus-gpio = <&gpio TEGRA_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
>> +
>> +		port {
>> +			usb_b_conn_ep: endpoint {
>> +				remote-endpoint = <&usb_role_switch>;
>> +			};
>> +		};
>> +	};
>> +
>>  };
> 
> 
