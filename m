Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A584AC4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 02:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAA521924
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 02:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392769AbfIJCp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 22:45:26 -0400
Received: from regular1.263xmail.com ([211.150.70.199]:51554 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392755AbfIJCp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 22:45:26 -0400
Received: from zhangzj?rock-chips.com (unknown [192.168.167.84])
        by regular1.263xmail.com (Postfix) with ESMTP id 72F88401;
        Tue, 10 Sep 2019 10:45:17 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [172.16.9.224] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P16693T140560903952128S1568083501895127_;
        Tue, 10 Sep 2019 10:45:05 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <9c1844bd32ab9429d9ac9fa2b5c8436b>
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
 <3b9cbffa-291e-fc95-bce6-5b24f5fd860d@rock-chips.com>
 <3345609.Z0LLm6LDBC@phil>
From:   Elon Zhang <zhangzj@rock-chips.com>
Message-ID: <192e0e32-363b-b6aa-84ed-67040c0c5f4f@rock-chips.com>
Date:   Tue, 10 Sep 2019 10:45:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3345609.Z0LLm6LDBC@phil>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On 9/1/2019 07:04, Heiko Stuebner wrote:
> Hi Elon,
>
> Am Donnerstag, 29. August 2019, 13:31:00 CEST schrieb Elon Zhang:
>> On 8/27/2019 22:28, Heiko Stuebner wrote:
>>> Am Dienstag, 27. August 2019, 09:14:39 CEST schrieb Elon Zhang:
>>>> Not every board needs to enable crypto node, so the node should
>>>> be set default disabled in rk3288.dtsi and enabled in specific
>>>> board dts file.
>>> Can you give a bit more rationale here? There would need to be a very
>>> specific reason because of the following:
>>>
>>> The crypto module is not wired to some board-specific components,
>>> so its usability does not depend on the specific board at all.
>>> Instead every board can just use it out of the box and the devicetree
>>> is supposed to describe the hardware and is _not_ meant as a space
>>> for user configuration.
>> Right for almost all normal hardware modules but the crypto module was
>> designed
>>
>> for secure world. As a result,  the crypto module will become
>> inaccessible for linux kernel if secure world enable it.
>>
>> We plan to enable the crypto module in secure world so we should set
>> crypto module default disabled in linux kernel.
> ok ... I'm halfway convinced ;-) .
>
> The big thing I want to see is that secure setting in the actual firmware.
> Aka right now you probably have that in your Rockchip-specific ATF fork
> and I really want to see the relevant change for public uboot or ATF.
>
> I don't necessarily require it to be fully merged before taking this, but
> I really want to see the change either on a mailing list or atf gerrit
> instance [that makes the crypto engine secure only].
>
> Rationale behind this is that we don't care very much about private stuff
> that the general ecosystem doesn't benefit from.

Now the crypto security property setting is done in the rockchip private 
code, which is not

opensource. So  if you don't care about private stuff and the change in 
private stuff will not

affect the upstream kernel,  the crypto can be enabled in upstream kernel?

>
>
> Thanks
> Heiko
>
>
>>> So in fact the status property should probably go away completely from
>>> the crypto node, as it's usable out of the box in all cases.
>>>
>>>
>>> Heiko
>>>
>>>
>>>
>>>> Signed-off-by: Elon Zhang <zhangzj@rock-chips.com>
>>>> ---
>>>>    arch/arm/boot/dts/rk3288.dtsi | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
>>>> index cc893e154fe5..d509aa24177c 100644
>>>> --- a/arch/arm/boot/dts/rk3288.dtsi
>>>> +++ b/arch/arm/boot/dts/rk3288.dtsi
>>>> @@ -984,7 +984,7 @@
>>>>    		clock-names = "aclk", "hclk", "sclk", "apb_pclk";
>>>>    		resets = <&cru SRST_CRYPTO>;
>>>>    		reset-names = "crypto-rst";
>>>> -		status = "okay";
>>>> +		status = "disabled";
>>>>    	};
>>>>    
>>>>    	iep_mmu: iommu@ff900800 {
>>>>
>>>
>>>
>>>
>>>
>>>
>>
>>
>
>
>
>
>
>


