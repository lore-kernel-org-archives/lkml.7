Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D97C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B962189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbfH2LbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 07:31:14 -0400
Received: from regular1.263xmail.com ([211.150.70.203]:39944 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbfH2LbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:31:10 -0400
Received: from zhangzj?rock-chips.com (unknown [192.168.167.73])
        by regular1.263xmail.com (Postfix) with ESMTP id 2B4EF38D;
        Thu, 29 Aug 2019 19:30:58 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [172.16.9.224] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P18543T140265176168192S1567078256984205_;
        Thu, 29 Aug 2019 19:30:57 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <658534ad7c1ca7df45c972965d3d6d09>
X-RL-SENDER: zhangzj@rock-chips.com
X-SENDER: zhangzj@rock-chips.com
X-LOGIN-NAME: zhangzj@rock-chips.com
X-FST-TO: linux-rockchip@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH v1 1/1] ARM: dts: rockchip: set crypto default disabled on
 rk3288
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     mark.rutland@arm.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <20190827071439.14767-1-zhangzj@rock-chips.com>
 <4806912.UyKsYhR33o@phil>
From:   Elon Zhang <zhangzj@rock-chips.com>
Message-ID: <3b9cbffa-291e-fc95-bce6-5b24f5fd860d@rock-chips.com>
Date:   Thu, 29 Aug 2019 19:31:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4806912.UyKsYhR33o@phil>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On 8/27/2019 22:28, Heiko Stuebner wrote:
> Hi,
>
> Am Dienstag, 27. August 2019, 09:14:39 CEST schrieb Elon Zhang:
>> Not every board needs to enable crypto node, so the node should
>> be set default disabled in rk3288.dtsi and enabled in specific
>> board dts file.
> Can you give a bit more rationale here? There would need to be a very
> specific reason because of the following:
>
> The crypto module is not wired to some board-specific components,
> so its usability does not depend on the specific board at all.
> Instead every board can just use it out of the box and the devicetree
> is supposed to describe the hardware and is _not_ meant as a space
> for user configuration.

Right for almost all normal hardware modules but the crypto module was 
designed

for secure world. As a result,  the crypto module will become 
inaccessible for linux

kernel if secure world enable it.

We plan to enable the crypto module in secure world so we should set 
crypto module

default disabled in linux kernel.

>
> So in fact the status property should probably go away completely from
> the crypto node, as it's usable out of the box in all cases.
>
>
> Heiko
>
>
>
>> Signed-off-by: Elon Zhang <zhangzj@rock-chips.com>
>> ---
>>   arch/arm/boot/dts/rk3288.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
>> index cc893e154fe5..d509aa24177c 100644
>> --- a/arch/arm/boot/dts/rk3288.dtsi
>> +++ b/arch/arm/boot/dts/rk3288.dtsi
>> @@ -984,7 +984,7 @@
>>   		clock-names = "aclk", "hclk", "sclk", "apb_pclk";
>>   		resets = <&cru SRST_CRYPTO>;
>>   		reset-names = "crypto-rst";
>> -		status = "okay";
>> +		status = "disabled";
>>   	};
>>   
>>   	iep_mmu: iommu@ff900800 {
>>
>
>
>
>
>
>


