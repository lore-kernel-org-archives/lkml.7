Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6B6C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 03:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C11206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 03:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfKVDDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 22:03:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:34986 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726335AbfKVDDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 22:03:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 48413AE2C;
        Fri, 22 Nov 2019 03:03:02 +0000 (UTC)
Subject: Re: [PATCH] arm64: dts: realtek: Add Realtek rtd1619 and mjolnir
To:     James Tai <james.tai@realtek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
References: <43B123F21A8CFE44A9641C099E4196FFCF91BEFA@RTITMBSVM04.realtek.com.tw>
 <25fdd8eb-f1a0-82ae-9c4b-22325b163b0e@suse.de>
 <43B123F21A8CFE44A9641C099E4196FFCF920024@RTITMBSVM04.realtek.com.tw>
 <6182b89f-cd7e-ce7c-56f7-e2f500321cde@suse.de>
 <993d5da60a87443995347ee2a4c74959@realtek.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <6d44e7f8-1ae5-ed3d-ac3c-0ee7903d660b@suse.de>
Date:   Fri, 22 Nov 2019 04:03:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <993d5da60a87443995347ee2a4c74959@realtek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Am 20.11.19 um 08:58 schrieb James Tai:
>> This conflicts with what I see in BSP irq mux code here:
>> https://github.com/BPI-SINOVOIP/BPI-M4-bsp/blob/master/linux-rtk/drivers/ir
>> qchip/irq-rtd16xx.h
>>
>> That does show UR0 as bit 2 for the iso irq mux, as for previous SoCs.
>> Is that code wrong, or does the same UART0 IP block have two alternative
>> interrupts for backwards compatibility? I therefore held back RTD1619 irq mux
>> patches from my irqchip v4 series [1].
>>
> It is code wrong. The UR0 should remove from "irq-rtd16xx.h".

Actually, I just tested that UR0 works! (rev A01) So we shouldn't remove
it from the irqchip driver, given the mapping changes requested for v5.

RTD1619 driver support and DT nodes pushed to my rtd1295-next branch.

>> The BSP DT does assign non-mux interrupts to the UART node like you did:
>> https://github.com/BPI-SINOVOIP/BPI-M4-bsp/blob/master/linux-rtk/arch/arm
>> 64/boot/dts/realtek/rtd16xx/rtd-16xx.dtsi
>> And I obviously trust that you tested your DT to produce serial output.

We should obviously leave the new GIC interrupts in the DT.

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
