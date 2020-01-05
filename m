Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D521C3F68F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 09:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D86A24672
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 09:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgAEJQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 04:16:26 -0500
Received: from wp126.webpack.hosteurope.de ([80.237.132.133]:46506 "EHLO
        wp126.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725535AbgAEJQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 04:16:26 -0500
Received: from [2003:a:659:3f00:1e6f:65ff:fe31:d1d5] (helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1io215-0007wK-3N; Sun, 05 Jan 2020 10:16:11 +0100
X-Virus-Scanned: by amavisd-new 2.11.1 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from dell2.five-lan.de (p508F34C7.dip0.t-ipconnect.de [80.143.52.199])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.14.5/SuSE Linux 0.8) with ESMTPSA id 0059G9tA005418
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 5 Jan 2020 10:16:09 +0100
Subject: Re: [PATCH 5/5] arm64: dts: rockchip: Enable mp8859 regulator on
 rk3399-roc-pc
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org
References: <20200104153321.6584-1-m.reichl@fivetechno.de>
 <20200104153321.6584-6-m.reichl@fivetechno.de> <11639547.aalzkRAYeW@phil>
From:   Markus Reichl <m.reichl@fivetechno.de>
Message-ID: <2dd59b6a-7890-8546-8030-198c6ae8608b@fivetechno.de>
Date:   Sun, 5 Jan 2020 10:16:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <11639547.aalzkRAYeW@phil>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1578215786;eeaad5e1;
X-HE-SMSGID: 1io215-0007wK-3N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

Am 04.01.20 um 22:23 schrieb Heiko Stuebner:
> Hi Markus,
> 
> Am Samstag, 4. Januar 2020, 16:32:49 CET schrieb Markus Reichl:
>> The rk3399-roc-pc uses a MP8859 DC/DC converter for 12V supply.
>> This supplies 5V only in default state after booting.
> 
> Just for my understanding ... both the old static regulator before as
> well as the new i2c node said to supply 12V, but above you say that
> the default is 5V ... so I'm wondering who configured the 12V before.
> 
> Or was it the case that the old regulator node was just wrong and we
> had 5V running on the dc_12v line?

Yes, the dc_12v line was running at 5V (measured 4,7V) as it is the
default power up value for the MP8859. This is as documented in the data
sheet [1].

[1] https://www.monolithicpower.com/en/documentview/productdocument/index/version/2/document_type/Datasheet/lang/en/sku/MP8859/document_id/4033/

Gruß
--
Markus
> 
> Thanks
> Heiko
> 
>> Now we can control the output voltage via I2C interface.
>> Add a node for the driver to reach 12V.
>> 
>> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
>> ---
>>  .../boot/dts/rockchip/rk3399-roc-pc.dtsi      | 32 +++++++++++--------
>>  1 file changed, 18 insertions(+), 14 deletions(-)
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
>> index 8e01b04144b7..9f225e9c3d54 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
>> @@ -110,20 +110,6 @@ vcc_vbus_typec0: vcc-vbus-typec0 {
>>  		regulator-max-microvolt = <5000000>;
>>  	};
>>  
>> -	/*
>> -	 * should be placed inside mp8859, but not until mp8859 has
>> -	 * its own dt-binding.
>> -	 */
>> -	dc_12v: mp8859-dcdc1 {
>> -		compatible = "regulator-fixed";
>> -		regulator-name = "dc_12v";
>> -		regulator-always-on;
>> -		regulator-boot-on;
>> -		regulator-min-microvolt = <12000000>;
>> -		regulator-max-microvolt = <12000000>;
>> -		vin-supply = <&vcc_vbus_typec0>;
>> -	};
>> -
>>  	/* switched by pmic_sleep */
>>  	vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
>>  		compatible = "regulator-fixed";
>> @@ -546,6 +532,24 @@ fusb0: usb-typec@22 {
>>  		vbus-supply = <&vcc_vbus_typec0>;
>>  		status = "okay";
>>  	};
>> +
>> +	mp8859: regulator@66 {
>> +		compatible = "mps,mp8859";
>> +		reg = <0x66>;
>> +		dc_12v: mp8859_dcdc {
>> +			regulator-name = "dc_12v";
>> +			regulator-min-microvolt = <12000000>;
>> +			regulator-max-microvolt = <12000000>;
>> +			regulator-always-on;
>> +			regulator-boot-on;
>> +			vin-supply = <&vcc_vbus_typec0>;
>> +
>> +			regulator-state-mem {
>> +				regulator-on-in-suspend;
>> +				regulator-suspend-microvolt = <12000000>;
>> +			};
>> +		};
>> +	};
>>  };
>>  
>>  &i2s0 {
>> 
> 
> 
> 
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
