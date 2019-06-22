Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283A8C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 14:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F192C2070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 14:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfFVOuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 10:50:23 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:50119 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfFVOuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 10:50:23 -0400
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x5MEoBSI050936;
        Sat, 22 Jun 2019 23:50:11 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp);
 Sat, 22 Jun 2019 23:50:10 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp)
Received: from [192.168.1.2] (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x5MEoAQH050929
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 22 Jun 2019 23:50:10 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH] ARM: dts: rockchip: add ethernet phy node for tinker
 board
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190621180017.29646-1-katsuhiro@katsuster.net>
 <1871177.hjLhdHVgcu@phil>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <ccf5ad2c-bd56-2d77-4728-d7906045e302@katsuster.net>
Date:   Sat, 22 Jun 2019 23:50:10 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1871177.hjLhdHVgcu@phil>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Current linux-next on my environment, 'ifconfig eth0 up' does not
work correctly with following message...

-----
root@linaro-alip:~# ifconfig eth0 up
[  105.028916] rk_gmac-dwmac ff290000.ethernet eth0: stmmac_open: Cannot 
attach to PHY (error: -19)
SIOCSIFFLAGS: No such device
-----

I checked drivers/net/ethernet/stmicro/stmmac/stmmac_main.c and found
stmmac_init_phy() is going to fail if ethernet device node does not
have following property:
   - phy-handle
   - phy
   - phy-device

I salvaged old version of linux-next kernel (5.2.0-rc1-20190523),
network device of my Tinker Board worked correctly if use it.

I have not bisect commit of root cause yet... Is it better to bisect
and find problem instead of sending this patch?

Best Regards,
---
Katsuhiro Suzuki


On 2019/06/22 17:33, Heiko Stuebner wrote:
> Hi,
> 
> Am Freitag, 21. Juni 2019, 20:00:17 CEST schrieb Katsuhiro Suzuki:
>> This patch adds missing mdio and ethernet PHY nodes for rk3328 ASUS
>> tinker board.
>>
>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> 
> just for my understanding, which problem does this solve?
> Normally the gmac can establish connections just fine on
> the rk3288 by probing the phy in the automatic way.
> 
> And I also don't see any additional properties like phy
> interrupt line below.
> 
> 
> Thanks
> Heiko
> 
>> ---
>>   arch/arm/boot/dts/rk3288-tinker.dtsi | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
>> index 293576869546..3190817e8d5d 100644
>> --- a/arch/arm/boot/dts/rk3288-tinker.dtsi
>> +++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
>> @@ -117,6 +117,7 @@
>>   	assigned-clocks = <&cru SCLK_MAC>;
>>   	assigned-clock-parents = <&ext_gmac>;
>>   	clock_in_out = "input";
>> +	phy-handle = <&phy0>;
>>   	phy-mode = "rgmii";
>>   	phy-supply = <&vcc33_lan>;
>>   	pinctrl-names = "default";
>> @@ -127,6 +128,17 @@
>>   	tx_delay = <0x30>;
>>   	rx_delay = <0x10>;
>>   	status = "ok";
>> +
>> +	mdio0 {
>> +		compatible = "snps,dwmac-mdio";
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		phy0: ethernet-phy@0 {
>> +			compatible = "ethernet-phy-ieee802.3-c22";
>> +			reg = <0>;
>> +		};
>> +	};
>>   };
>>   
>>   &gpu {
>>
> 
> 
> 
> 
> 

