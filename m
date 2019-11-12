Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0322C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99BB221925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfKLIM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:12:28 -0500
Received: from regular1.263xmail.com ([211.150.70.205]:53274 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfKLIM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:12:28 -0500
Received: from localhost (unknown [192.168.165.103])
        by regular1.263xmail.com (Postfix) with ESMTP id 4ACCB3F3;
        Tue, 12 Nov 2019 16:05:07 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.60.65] (unknown [103.29.142.67])
        by smtp.263.net (postfix) whith ESMTP id P28956T140214521083648S1573545889847809_;
        Tue, 12 Nov 2019 16:05:05 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <a1e7a1b6f9fa5cb3f53851fe515b3e1c>
X-RL-SENDER: kever.yang@rock-chips.com
X-SENDER: yk@rock-chips.com
X-LOGIN-NAME: kever.yang@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH 3/3] arm64: dts: rk3399: Add init voltage for vdd_log
To:     Soeren Moch <smoch@web.de>, heiko@sntech.de
Cc:     linux-rockchip@lists.infradead.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Akash Gajjar <akash@openedev.com>,
        Alexis Ballier <aballier@gentoo.org>,
        =?UTF-8?Q?Andrius_=c5=a0tikonas?= <andrius@stikonas.eu>,
        Andy Yan <andyshrk@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Xie <nick@khadas.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Pragnesh Patel <Pragnesh_Patel@mentor.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20191111005158.25070-1-kever.yang@rock-chips.com>
 <20191111005158.25070-3-kever.yang@rock-chips.com>
 <ef8830f3-10d1-7b71-0e18-232f2eaeef2d@web.de>
From:   Kever Yang <kever.yang@rock-chips.com>
Message-ID: <1eaef5d5-c923-da56-b9c4-48d517b3c969@rock-chips.com>
Date:   Tue, 12 Nov 2019 16:04:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ef8830f3-10d1-7b71-0e18-232f2eaeef2d@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/11/11 下午4:42, Soeren Moch wrote:
> On 11.11.19 01:51, Kever Yang wrote:
>> Since there is no devfreq used for vdd_log, so the vdd_log(pwm regulator)
>> will be 'enable' with the dts node at a default PWM state with high or low
>> output. Both too high or too low for vdd_log is not good for the board,
>> add init voltage for driver to make the regulator get into a know output.
>>
>> Note that this will be used by U-Boot for init voltage output, and this
>> is very important for it may get system hang somewhere during system
>> boot up with regulator enable and without this init value.
> I think it's a good idea to include this setting in the main dts for the
> boards (not in u-boot specific additions as is done now). But there is
> (for some reason?) no documented binding for regulator-init-microvolt in
> linux.


Ohh, I forgot the kernel driver does not support this property.

@Heiko, can we add this 'regulator-init-microvolt' without driver 
support but adding document for

it at dt-binding?


Thanks,

- Kever

>
> Regards,
> Soeren
>> CC: Elaine Zhang <zhangqing@rock-chips.com>
>> CC: Peter Robinson <pbrobinson@gmail.com>
>> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>> ---
>>
>>   arch/arm64/boot/dts/rockchip/rk3399-evb.dts          | 1 +
>>   arch/arm64/boot/dts/rockchip/rk3399-firefly.dts      | 1 +
>>   arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts   | 1 +
>>   arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi | 1 +
>>   arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts    | 1 +
>>   arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts     | 1 +
>>   arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts       | 1 +
>>   arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts    | 1 +
>>   arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi    | 1 +
>>   9 files changed, 9 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
>> index 77008dca45bc..fa241aeb11b0 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
>> @@ -65,6 +65,7 @@
>>   		regulator-name = "vdd_center";
>>   		regulator-min-microvolt = <800000>;
>>   		regulator-max-microvolt = <1400000>;
>> +		regulator-init-microvolt = <950000>;
>>   		regulator-always-on;
>>   		regulator-boot-on;
>>   		status = "okay";
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
>> index 92de83dd4dbc..4e45269fcdff 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
>> @@ -208,6 +208,7 @@
>>   		regulator-boot-on;
>>   		regulator-min-microvolt = <430000>;
>>   		regulator-max-microvolt = <1400000>;
>> +		regulator-init-microvolt = <950000>;
>>   		vin-supply = <&vcc_sys>;
>>   	};
>>   };
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
>> index c133e8d64b2a..692f3154edc3 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
>> @@ -100,6 +100,7 @@
>>   		regulator-name = "vdd_log";
>>   		regulator-min-microvolt = <800000>;
>>   		regulator-max-microvolt = <1400000>;
>> +		regulator-init-microvolt = <950000>;
>>   		regulator-always-on;
>>   		regulator-boot-on;
>>   	};
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
>> index 4944d78a0a1c..c2ac80d99301 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
>> @@ -79,6 +79,7 @@
>>   		regulator-boot-on;
>>   		regulator-min-microvolt = <800000>;
>>   		regulator-max-microvolt = <1400000>;
>> +		regulator-init-microvolt = <950000>;
>>   		vin-supply = <&vsys_3v3>;
>>   	};
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts b/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
>> index 73be38a53796..c32abcc4ddc1 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
>> @@ -101,6 +101,7 @@
>>   		regulator-boot-on;
>>   		regulator-min-microvolt = <800000>;
>>   		regulator-max-microvolt = <1400000>;
>> +		regulator-init-microvolt = <950000>;
>>   		vin-supply = <&vcc5v0_sys>;
>>   	};
>>   };
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
>> index 0541dfce924d..9d674c51f025 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
>> @@ -164,6 +164,7 @@
>>   		regulator-boot-on;
>>   		regulator-min-microvolt = <800000>;
>>   		regulator-max-microvolt = <1400000>;
>> +		regulator-init-microvolt = <950000>;
>>   		vin-supply = <&vcc_sys>;
>>   	};
>>   };
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
>> index 19f7732d728c..7d856ce1d156 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
>> @@ -129,6 +129,7 @@
>>   		regulator-boot-on;
>>   		regulator-min-microvolt = <800000>;
>>   		regulator-max-microvolt = <1400000>;
>> +		regulator-init-microvolt = <950000>;
>>   		vin-supply = <&vcc3v3_sys>;
>>   	};
>>   };
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
>> index e544deb61d28..8fbccbc8bf47 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
>> @@ -174,6 +174,7 @@
>>   		regulator-boot-on;
>>   		regulator-min-microvolt = <800000>;
>>   		regulator-max-microvolt = <1700000>;
>> +		regulator-init-microvolt = <950000>;
>>   		vin-supply = <&vcc5v0_sys>;
>>   	};
>>   };
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
>> index 1bc1579674e5..f8e2cb8c0624 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
>> @@ -133,6 +133,7 @@
>>   		regulator-boot-on;
>>   		regulator-min-microvolt = <800000>;
>>   		regulator-max-microvolt = <1400000>;
>> +		regulator-init-microvolt = <950000>;
>>   		vin-supply = <&vcc_sys>;
>>   	};
>>   };


