Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10ABFC41514
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 00:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CC52184E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 00:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfHSAiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 20:38:07 -0400
Received: from regular1.263xmail.com ([211.150.70.198]:36486 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfHSAiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 20:38:06 -0400
X-Greylist: delayed 500 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Aug 2019 20:38:02 EDT
Received: from kever.yang?rock-chips.com (unknown [192.168.167.160])
        by regular1.263xmail.com (Postfix) with ESMTP id 0BCDD265;
        Mon, 19 Aug 2019 08:29:33 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [172.16.12.9] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P912T139738371585792S1566174570916231_;
        Mon, 19 Aug 2019 08:29:32 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <360de786e17596abca2fbe6c887ae0e9>
X-RL-SENDER: kever.yang@rock-chips.com
X-SENDER: yk@rock-chips.com
X-LOGIN-NAME: kever.yang@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH v2] arm: dts: rockchip: fix vcc_host_5v regulator for usb3
 host
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomohiro Mayama <parly-gh@iris.mystia.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20190815081252.27405-1-kever.yang@rock-chips.com>
 <2932927.UJgUFA1Pmh@phil>
From:   Kever Yang <kever.yang@rock-chips.com>
Message-ID: <208c56e1-bfe0-a982-927d-bdddc3116631@rock-chips.com>
Date:   Mon, 19 Aug 2019 08:29:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2932927.UJgUFA1Pmh@phil>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On 2019/8/16 下午8:24, Heiko Stuebner wrote:
> Hi Kever, TL,
>
> [added TL Lim for clarification]
>
> Am Donnerstag, 15. August 2019, 10:12:52 CEST schrieb Kever Yang:
>> According to rock64 schemetic V2 and V3, the VCC_HOST_5V output is
>> controlled by USB_20_HOST_DRV, which is the same as VCC_HOST1_5V.
> The v1 schematics I have do reference the GPIO0_A0 as controlling this
> supply, so the big question would be how to handle the different versions.
>
> Because adding this would probably break v1 boards in this function.
>
> @TL: where v1 boards also sold or were they only used during development?


I have check this with TL when I make this patch, the V1 hardware was 
never sold and only V2/V3

are available on the market.


Thanks,

- Kever

> If this were the case, we could just apply the patch, not caring about
> v1 boards, but if v1 boards were also sold to customers there would be
> more of a problem.
>
> Thanks
> Heiko
>
>
>> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>> ---
>>
>> Changes in v2:
>> - remove enable-active-high property
>>
>>   arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 11 ++---------
>>   1 file changed, 2 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
>> index 7cfd5ca6cc85..62936b432f9a 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
>> @@ -34,10 +34,9 @@
>>   
>>   	vcc_host_5v: vcc-host-5v-regulator {
>>   		compatible = "regulator-fixed";
>> -		enable-active-high;
>> -		gpio = <&gpio0 RK_PA0 GPIO_ACTIVE_HIGH>;
>> +		gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
>>   		pinctrl-names = "default";
>> -		pinctrl-0 = <&usb30_host_drv>;
>> +		pinctrl-0 = <&usb20_host_drv>;
>>   		regulator-name = "vcc_host_5v";
>>   		regulator-always-on;
>>   		regulator-boot-on;
>> @@ -320,12 +319,6 @@
>>   			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
>>   		};
>>   	};
>> -
>> -	usb3 {
>> -		usb30_host_drv: usb30-host-drv {
>> -			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
>> -		};
>> -	};
>>   };
>>   
>>   &sdmmc {
>>
>
>
>
>


