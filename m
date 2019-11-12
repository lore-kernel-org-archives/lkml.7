Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A56C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D411721925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573566563;
	bh=6XMWe/tgt0P/juZyTHtJJv45+E6TW1sRskKkrjJOLJc=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=nue2Wf07zn8mf+xD+sg95EcaQwmi4NDXgZASRy6CXhBRNYrbb1qJLyFNJT5/geVdi
	 04ZSxXfpgf/zmLrcYaV2AraHBq1HcXVrj4199wEscCM14evSPu5//OFFvONcPerqkS
	 YluxJX+Zp5Ryr0Fq8ebCk+t1nFFp3DY+1Ti/0cUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfKLNtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 08:49:23 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:50360 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726946AbfKLNtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 08:49:22 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iUWXl-00084H-Gl; Tue, 12 Nov 2019 14:49:17 +0100
To:     Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: ls1021a-tsn: Use interrupts for the SGMII  PHYs
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 12 Nov 2019 14:58:38 +0109
From:   Marc Zyngier <maz@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>
In-Reply-To: <CA+h21hqw16o0TqOV1WWYYcOs3YWJe=xq_K0=miU+BFTA31OTmQ@mail.gmail.com>
References: <20191112132010.18274-1-linux@rasmusvillemoes.dk>
 <20191112132010.18274-3-linux@rasmusvillemoes.dk>
 <CA+h21hqw16o0TqOV1WWYYcOs3YWJe=xq_K0=miU+BFTA31OTmQ@mail.gmail.com>
Message-ID: <6d4292fcb0cf290837306388bdfe9b0f@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: olteanv@gmail.com, linux@rasmusvillemoes.dk, shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-12 14:53, Vladimir Oltean wrote:
> On Tue, 12 Nov 2019 at 15:20, Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> From: Vladimir Oltean <olteanv@gmail.com>
>>
>> On the LS1021A-TSN board, the 2 Atheros AR8031 PHYs for eth0 and 
>> eth1
>> have interrupt lines connected to the shared IRQ2_B LS1021A pin.
>>
>> Switching to interrupts offloads the PHY library from the task of
>> polling the MDIO status and AN registers (1, 4, 5) every second.
>>
>> Unfortunately, the BCM5464R quad PHY connected to the switch does 
>> not
>> appear to have an interrupt line routed to the SoC.
>>
>> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>>  arch/arm/boot/dts/ls1021a-tsn.dts | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/ls1021a-tsn.dts 
>> b/arch/arm/boot/dts/ls1021a-tsn.dts
>> index 5b7689094b70..135d36461af4 100644
>> --- a/arch/arm/boot/dts/ls1021a-tsn.dts
>> +++ b/arch/arm/boot/dts/ls1021a-tsn.dts
>> @@ -203,11 +203,15 @@
>>         /* AR8031 */
>>         sgmii_phy1: ethernet-phy@1 {
>>                 reg = <0x1>;
>> +               /* SGMII1_PHY_INT_B: connected to IRQ2, active low 
>> */
>> +               interrupts-extended = <&extirq 2 
>> IRQ_TYPE_EDGE_FALLING>;
>>         };
>>
>>         /* AR8031 */
>>         sgmii_phy2: ethernet-phy@2 {
>>                 reg = <0x2>;
>> +               /* SGMII2_PHY_INT_B: connected to IRQ2, active low 
>> */
>> +               interrupts-extended = <&extirq 2 
>> IRQ_TYPE_EDGE_FALLING>;
>>         };
>>
>>         /* BCM5464 quad PHY */
>> --
>> 2.23.0
>>
>
> +netdev and Andrew for this patch, since the interrupt polarity 
> caught
> his attention in v1.

Certainly, the comments and the interrupt specifier do not match.
Which one is true?

         M.
-- 
Jazz is not dead. It just smells funny...
