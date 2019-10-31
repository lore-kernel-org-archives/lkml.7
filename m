Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4462CA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C0120650
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbfJaSMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 14:12:20 -0400
Received: from wp126.webpack.hosteurope.de ([80.237.132.133]:32774 "EHLO
        wp126.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729127AbfJaSMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 14:12:20 -0400
Received: from [2003:a:659:3f00:1e6f:65ff:fe31:d1d5] (helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iQEvg-000408-2i; Thu, 31 Oct 2019 19:12:16 +0100
X-Virus-Scanned: by amavisd-new 2.11.1 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from dell2.five-lan.de (pD9E89D59.dip0.t-ipconnect.de [217.232.157.89])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.14.5/SuSE Linux 0.8) with ESMTPSA id x9VICB4k007592
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 31 Oct 2019 19:12:11 +0100
Subject: Re: [PATCH] arm64: dts: rockchip: Add PCIe node on rk3399-roc-pc
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org
References: <09300c2d-4298-1b01-ac41-d1b2610589d4@fivetechno.de>
 <1719506.vT9a8mQdzu@phil>
From:   Markus Reichl <m.reichl@fivetechno.de>
Message-ID: <f66fe5c3-6760-20b0-54cc-8f0c1a754bab@fivetechno.de>
Date:   Thu, 31 Oct 2019 19:12:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1719506.vT9a8mQdzu@phil>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1572545539;eb906180;
X-HE-SMSGID: 1iQEvg-000408-2i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,
Am 31.10.19 um 17:57 schrieb Heiko Stuebner:
> Hi,
> 
> Am Montag, 28. Oktober 2019, 15:47:27 CET schrieb Markus Reichl:
>> rk3399-roc-pc has a PCIe interface. Enable it for use with
>> the M.2 NGFF M_KEY slot on roc-rk3399-mezzanine board.
>> Tested with Samsung 970 evo plus SSD.
>> 
>> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
>> ---
>>  .../arm64/boot/dts/rockchip/rk3399-roc-pc.dts | 38 +++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
>> index 9313251765c7..2d637d54994b 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
>> @@ -158,6 +158,21 @@
>>  		regulator-max-microvolt = <1400000>;
>>  		vin-supply = <&vcc_sys>;
>>  	};
>> +
>> +	/* on roc-rk3399-mezzanine board */
> 
> I'm undecided on this. From what I've seen that mezzanine board is some
> sort of addon, like a raspberry pi hat. Therefore it's not always present,
> so probably should not be part of the base board dts.
> 
> I'm thinking a dt-overlay that can then be activated might be the solution
> of choice, but I've reached out to arm-soc poeple on irc to determine the
> correct course.
> 
I have seen some board.dtsi with board_only.dts respective board_extension.dts
in the arch/arm64/boot/dts/rockchip directory. Would that be ok?

Markus 

> 
> Heiko
> 
>> +	vcc3v3_pcie: vcc3v3-pcie {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc3v3_pcie";
>> +		enable-active-high;
>> +		gpio = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&vcc3v3_pcie_en>;
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		vin-supply = <&dc_12v>;
>> +	};
>>  };
>>  
>>  &cpu_l0 {
>> @@ -514,6 +529,19 @@
>>  	status = "okay";
>>  };
>>  
>> +&pcie_phy {
>> +	status = "okay";
>> +};
>> +
>> +&pcie0 {
>> +	ep-gpios = <&gpio4 RK_PD1 GPIO_ACTIVE_HIGH>;
>> +	num-lanes = <4>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pcie_perst>;
>> +	vpcie3v3-supply = <&vcc3v3_pcie>;
>> +	status = "okay";
>> +};
>> +
>>  &pinctrl {
>>  	lcd-panel {
>>  		lcd_panel_reset: lcd-panel-reset {
>> @@ -535,6 +563,16 @@
>>  		};
>>  	};
>>  
>> +	pcie {
>> +		vcc3v3_pcie_en: vcc3v3-pcie-en {
>> +			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +
>> +		pcie_perst: pcie-perst {
>> +			rockchip,pins = <4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +	};
>> +
>>  	pmic {
>>  		vsel1_gpio: vsel1-gpio {
>>  			rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_down>;
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
