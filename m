Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D22C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D37B20850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="qc18gtG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbfCAG3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 01:29:41 -0500
Received: from uho.ysoft.cz ([81.19.3.130]:34315 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfCAG3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 01:29:40 -0500
Received: from [10.1.8.111] (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id 29F0BA31FB;
        Fri,  1 Mar 2019 07:29:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1551421778;
        bh=rmro/aMkyywCPDRcJVMslFDYwfgZxHPdZisxkAvaywk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qc18gtG35e/W+xjPgyRhYlcKLsI6yUPJ7Jl0fjv4PV160qGJM4QtTPWUxKefAOSRN
         rl7BoouiSJXEsXU/+7Fto/0eNuQpF4OE6P+e8K5e998eCNh73SVCDfAomc+TwBae/G
         zFn8lIF1LOsfPmMl04J/ycs0nIT/XlmIN8+XCzPU=
Subject: Re: [PATCH] ARM: dts: imx6dl-yapp4: Use rgmii-id phy mode on the cpu
 port
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1550583420-112858-1-git-send-email-michal.vokac@ysoft.com>
 <20190301021344.GK26041@dragon>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <47d36e23-1113-56ff-e285-f9bd274004ff@ysoft.com>
Date:   Fri, 1 Mar 2019 07:29:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190301021344.GK26041@dragon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01. 03. 19 3:13, Shawn Guo wrote:
> On Tue, Feb 19, 2019 at 02:37:00PM +0100, Michal Vokáč wrote:
>> The PHY must add delays to both Tx and Rx clock on the cpu port
>> to work propperly.
>>
>> It worked with the rgmii mode before beacause the qca8k driver
>> (incorrecly) enabled delays in that mode.
>>
>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
>> ---
>> This imx6dl-yapp4 platform is currently waiting in linux-next.
>>
>> Commit 5ecdd77c61c8 ("net: dsa: qca8k: disable delay for RGMII mode"), now
>> also in linux-next removed the delays from the RGMII mode so the networking
>> stopped working.
>>
>> Recently Koul submitted a patch that implements the rgmii-id mode to fix
>> the issue [1].
>>
>> As the networking is broken at this moment it does not matter which patch
>> goes in first. It is not neccessary to wait until the Koul's patch is
>> applied/merged if that should be the case.
>>
>> [1] http://patchwork.ozlabs.org/patch/1044505/
> 
> Can we have such useful info in the commit log in some proper form?

Sure, I will transplant relevant parts of the message into the commit
log. I just thought that most of this info will be outdated immediately
after applying.

BTW the patch[1] from Vinod is already merged.

Michal

>>
>>   arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
>> index b715ab0fa1ff..091d829f6b05 100644
>> --- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
>> +++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
>> @@ -125,7 +125,7 @@
>>   				ethphy0: port@0 {
>>   					reg = <0>;
>>   					label = "cpu";
>> -					phy-mode = "rgmii";
>> +					phy-mode = "rgmii-id";
>>   					ethernet = <&fec>;
>>   
>>   					fixed-link {
>> -- 
>> 2.1.4
>>

