Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CD5C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD65A20821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbfDPKrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:47:22 -0400
Received: from mail2.sp2max.com.br ([138.185.4.9]:58652 "EHLO
        mail2.sp2max.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfDPKrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:47:22 -0400
Received: from [172.17.0.2] (unknown [186.137.130.251])
        (Authenticated sender: pablo@fliagreco.com.ar)
        by mail2.sp2max.com.br (Postfix) with ESMTPA id 5B7377B0148;
        Tue, 16 Apr 2019 07:47:11 -0300 (-03)
Subject: Re: [PATCH v2 2/6] ARM: dts: sun8i: v40: bananapi-m2-berry: Enable
 GMAC ethernet controller
To:     maxime.ripard@bootlin.com
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1555065186-8154-1-git-send-email-pgreco@centosproject.org>
 <1555065186-8154-3-git-send-email-pgreco@centosproject.org>
 <20190415075309.p7pgj62mmtmxsnnr@flea>
From:   =?UTF-8?Q?Pablo_Sebasti=c3=a1n_Greco?= <pgreco@centosproject.org>
Message-ID: <eb80d64f-7355-071b-c1d1-04e0eb4475ce@centosproject.org>
Date:   Tue, 16 Apr 2019 07:47:09 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415075309.p7pgj62mmtmxsnnr@flea>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-SP2Max-MailScanner-Information: Please contact the ISP for more information
X-SP2Max-MailScanner-ID: 5B7377B0148.AE739
X-SP2Max-MailScanner: Sem Virus encontrado
X-SP2Max-MailScanner-SpamCheck: nao spam, SpamAssassin (not cached,
        escore=-2.9, requerido 6, autolearn=not spam, ALL_TRUSTED -1.00,
        BAYES_00 -1.90)
X-SP2Max-MailScanner-From: pgreco@centosproject.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


El 15/4/19 a las 04:53, Maxime Ripard escribió:
> On Fri, Apr 12, 2019 at 07:33:01AM -0300, Pablo Greco wrote:
>> Just like the Bananapi M2 Ultra, the Bananapi M2 Berry has a Realtek
>> RTL8211E RGMII PHY tied to the GMAC.
>> The PMIC's DC1SW output provides power for the PHY, while the ALDO2
>> output provides I/O voltages on both sides.
>>
>> Signed-off-by: Pablo Greco <pgreco@centosproject.org>
>> ---
>>   arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts | 30 +++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
>> index f05cabd..0d79e91 100644
>> --- a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
>> +++ b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
>> @@ -50,6 +50,7 @@
>>   	compatible = "sinovoip,bpi-m2-berry", "allwinner,sun8i-r40";
>>
>>   	aliases {
>> +		ethernet0 = &gmac;
>>   		serial0 = &uart0;
>>   	};
>>
>> @@ -92,6 +93,22 @@
>>   	status = "okay";
>>   };
>>
>> +&gmac {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&gmac_rgmii_pins>;
>> +	phy-handle = <&phy1>;
>> +	phy-mode = "rgmii";
>> +	phy-supply = <&reg_dc1sw>;
>> +	status = "okay";
>> +};
>> +
>> +&gmac_mdio {
>> +	phy1: ethernet-phy@1 {
>> +		compatible = "ethernet-phy-ieee802.3-c22";
>> +		reg = <1>;
>> +	};
>> +};
>> +
>>   &i2c0 {
>>   	status = "okay";
>>
>> @@ -123,6 +140,13 @@
>>   	status = "okay";
>>   };
>>
>> +&reg_aldo2 {
>> +	regulator-always-on;
>> +	regulator-min-microvolt = <2500000>;
>> +	regulator-max-microvolt = <2500000>;
>> +	regulator-name = "vcc-pa";
>> +};
>> +
> If this one provides power to the pins, it should be tied to the PIO
> node.
In that case, I should fix the bananapi-m2-ultra the same way. Do you 
prefer me to add those fixes to this series?
Or is it better to apply this like it is, and I fix both together in a 
separated series?
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
Pablo.
