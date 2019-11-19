Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852D9C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6377F219F6
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfKSJLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 04:11:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:39200 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbfKSJLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 04:11:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4B85DB235;
        Tue, 19 Nov 2019 09:11:40 +0000 (UTC)
Subject: Re: [PATCH] arm64: dts: realtek: Add Realtek rtd1619 and mjolnir
To:     James Tai <james.tai@realtek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <43B123F21A8CFE44A9641C099E4196FFCF91BEFA@RTITMBSVM04.realtek.com.tw>
 <25fdd8eb-f1a0-82ae-9c4b-22325b163b0e@suse.de>
 <43B123F21A8CFE44A9641C099E4196FFCF920024@RTITMBSVM04.realtek.com.tw>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <6182b89f-cd7e-ce7c-56f7-e2f500321cde@suse.de>
Date:   Tue, 19 Nov 2019 10:11:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <43B123F21A8CFE44A9641C099E4196FFCF920024@RTITMBSVM04.realtek.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Am 08.11.19 um 16:36 schrieb James Tai:
>> Is the UART no longer behind an IRQ mux on RTD1619, or is the above the IRQ
>> mux interrupt as a workaround for lack of in-tree irqchip driver?
>>
> Yes, the UART no longer behind an IRQ mux on RTD1619.

This conflicts with what I see in BSP irq mux code here:
https://github.com/BPI-SINOVOIP/BPI-M4-bsp/blob/master/linux-rtk/drivers/irqchip/irq-rtd16xx.h

That does show UR0 as bit 2 for the iso irq mux, as for previous SoCs.
Is that code wrong, or does the same UART0 IP block have two alternative
interrupts for backwards compatibility? I therefore held back RTD1619
irq mux patches from my irqchip v4 series [1].

The BSP DT does assign non-mux interrupts to the UART node like you did:
https://github.com/BPI-SINOVOIP/BPI-M4-bsp/blob/master/linux-rtk/arch/arm64/boot/dts/realtek/rtd16xx/rtd-16xx.dtsi
And I obviously trust that you tested your DT to produce serial output.


Also note how there are UR1_TO and UR2_TO (TO = timeout?) in addition to
regular UR1 and UR2 interrupts in the mux above, just as for RTD1295 and
RTD1195 (UR1/UR1_TO only). From my irqmux v4 series posted last night I
had to drop those additional interrupts property values from the DT [2],
as they violate mainline's DesignWare DT schema's maxItems 1 and would
require a new compatible string (and a driver patch to make use of it).

https://github.com/BPI-SINOVOIP/BPI-M4-bsp/blob/master/linux-rtk/drivers/irqchip/irq-rtd119x.h
https://github.com/BPI-SINOVOIP/BPI-M4-bsp/blob/master/linux-rtk/drivers/irqchip/irq-rtd129x.h
https://github.com/BPI-SINOVOIP/BPI-M4-bsp/blob/master/linux-rtk/drivers/irqchip/irq-rtd139x.h

Regards,
Andreas

[1] https://patchwork.kernel.org/cover/11250643/
[2] https://patchwork.kernel.org/patch/11250645/

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
