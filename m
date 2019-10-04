Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910B5C10F14
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 02:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6728D2086A
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 02:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731817AbfJDCYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 22:24:08 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:33530 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731665AbfJDCYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 22:24:08 -0400
X-Greylist: delayed 534 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Oct 2019 22:24:03 EDT
Received: from localhost (unknown [192.168.167.69])
        by lucky1.263xmail.com (Postfix) with ESMTP id CF3F05D332;
        Fri,  4 Oct 2019 10:15:00 +0800 (CST)
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.10.106] (unknown [220.200.58.186])
        by smtp.263.net (postfix) whith ESMTP id P20279T139768363312896S1570155286485644_;
        Fri, 04 Oct 2019 10:14:59 +0800 (CST)
X-UNIQUE-TAG: <ba7e53742f06ad9e000d5da00b9ed5d3>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 220.200.58.186
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Cc:     shawn.lin@rock-chips.com, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_3/3=5d_arm64=3a_dts=3a_rockchip=3a_fix_Roc?=
 =?UTF-8?B?a1BybzY0IHNkbW1jIHNldHRpbmdz44CQ6K+35rOo5oSP77yM6YKu5Lu255SxbGlu?=
 =?UTF-8?Q?ux-rockchip-bounces+shawn=2elin=3drock-chips=2ecom=40lists=2einfr?=
 =?UTF-8?B?YWRlYWQub3Jn5Luj5Y+R44CR?=
To:     Soeren Moch <smoch@web.de>, Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>
References: <20191003215036.15023-1-smoch@web.de>
 <20191003215036.15023-3-smoch@web.de>
 <31181f3c-20ec-e717-1f7e-8b35cd54d96d@arm.com>
 <a8b20c45-0426-ee42-4efc-52e56ea6bb20@web.de>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <120e2dbc-55eb-2205-b00f-7e50928ec706@rock-chips.com>
Date:   Fri, 4 Oct 2019 10:13:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <a8b20c45-0426-ee42-4efc-52e56ea6bb20@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/4 8:53, Soeren Moch wrote:
> 
> 
> On 04.10.19 02:01, Robin Murphy wrote:
>> On 2019-10-03 10:50 pm, Soeren Moch wrote:
>>> According to the RockPro64 schematic [1] the rk3399 sdmmc controller is
>>> connected to a microSD (TF card) slot, which cannot be switched to 1.8V.
>>
>> Really? AFAICS the SDMMC0 wiring looks pretty much identical to the
>> NanoPC-T4 schematic (it's the same reference design, after all), and I
>> know that board can happily drive a UHS-I microSD card with 1.8v I/Os,
>> because mine's doing so right now.
>>
>> Robin.
> OK, the RockPro64 does not allow a card reset (power cycle) since
> VCC3V0_SD is directly connected to VCC3V3_SYS (via R89555), the
> SDMMC0_PWH_H signal is not connected. So the card fails to identify
> itself after suspend or reboot when switched to 1.8V operation.
> 

I believe we addressed this issue long time ago, please check:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6a11fc47f175c8d87018e89cb58e2d36c66534cb

> Regards,
> Soeren
>>
>>> So also configure the vcc_sdio regulator, which drives the i/o voltage
>>> of the sdmmc controller, accordingly.
>>>
>>> While at it, also remove the cap-mmc-highspeed property of the sdmmc
>>> controller, since no mmc card can be connected here.
>>>
>>> [1] http://files.pine64.org/doc/rockpro64/rockpro64_v21-SCH.pdf
>>>
>>> Fixes: e4f3fb490967 ("arm64: dts: rockchip: add initial dts support
>>> for Rockpro64")
>>> Signed-off-by: Soeren Moch <smoch@web.de>
>>> ---
>>> Cc: Heiko Stuebner <heiko@sntech.de>
>>> Cc: linux-rockchip@lists.infradead.org
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-kernel@vger.kernel.org
>>> ---
>>>    arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts | 3 +--
>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
>>> b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
>>> index 2e44dae4865a..084f1d994a50 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
>>> @@ -353,7 +353,7 @@
>>>                    regulator-name = "vcc_sdio";
>>>                    regulator-always-on;
>>>                    regulator-boot-on;
>>> -                regulator-min-microvolt = <1800000>;
>>> +                regulator-min-microvolt = <3000000>;
>>>                    regulator-max-microvolt = <3000000>;
>>>                    regulator-state-mem {
>>>                        regulator-on-in-suspend;
>>> @@ -624,7 +624,6 @@
>>>
>>>    &sdmmc {
>>>        bus-width = <4>;
>>> -    cap-mmc-highspeed;
>>>        cap-sd-highspeed;
>>>        cd-gpios = <&gpio0 7 GPIO_ACTIVE_LOW>;
>>>        disable-wp;
>>> -- 
>>> 2.17.1
>>>
>>>
>>> _______________________________________________
>>> Linux-rockchip mailing list
>>> Linux-rockchip@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>>>
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 


-- 
Best Regards
Shawn Lin


