Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3781C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 10:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD135206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 10:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XdZDPG1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfLWKMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 05:12:12 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33694 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfLWKMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 05:12:12 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBNABjPi016210;
        Mon, 23 Dec 2019 04:11:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577095905;
        bh=k+tddIamd1GoffpRlXypzqb1aH//9w2l3PTAw6k6ivk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=XdZDPG1BdBY3eniRcgcc0wE2sFeoqj26AvQ/1upCR53cLTTn/ynkbDKdv7ePE7jwH
         +wakbPP9IbfzX+i3gbbbBWiN3F+hKQMFQCsVCDjZDAqI8/YoRVkm1g/ko29ncuDS/X
         IhwqRJ6zYZ+a4jl8RJYbqiKOAifOpBRTP0CYLFXg=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBNABjWd078419
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Dec 2019 04:11:45 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 23
 Dec 2019 04:11:45 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 23 Dec 2019 04:11:45 -0600
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBNABe33065334;
        Mon, 23 Dec 2019 04:11:41 -0600
Subject: Re: [PATCH V3 2/2] drivers/irqchip: add NXP INTMUX interrupt
 multiplexer support
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        Marc Zyngier <maz@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Andy Duan <fugang.duan@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1576827431-31942-1-git-send-email-qiangqing.zhang@nxp.com>
 <1576827431-31942-3-git-send-email-qiangqing.zhang@nxp.com>
 <ad5165ba-24d7-ceeb-8794-cdbe4e564bd5@ti.com>
 <DB7PR04MB4618B9A227807CCF884910C6E62D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <8bc6bcf113cce13816c62c166f091785@www.loen.fr>
 <DB7PR04MB4618A390C538DCD6929DE998E62D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <d7ee5841-0b99-32d3-1d62-d2b47adf4476@ti.com>
Date:   Mon, 23 Dec 2019 15:40:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <DB7PR04MB4618A390C538DCD6929DE998E62D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/12/19 8:56 PM, Joakim Zhang wrote:
> 
>> -----Original Message-----
>> From: Marc Zyngier <maz@kernel.org>
>> Sent: 2019年12月20日 22:20
>> To: Joakim Zhang <qiangqing.zhang@nxp.com>
>> Cc: Lokesh Vutla <lokeshvutla@ti.com>; tglx@linutronix.de;
>> jason@lakedaemon.net; robh+dt@kernel.org; mark.rutland@arm.com;
>> shawnguo@kernel.org; s.hauer@pengutronix.de; Andy Duan
>> <fugang.duan@nxp.com>; S.j. Wang <shengjiu.wang@nxp.com>;
>> linux-kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
>> kernel@pengutronix.de; linux-arm-kernel@lists.infradead.org
>> Subject: RE: [PATCH V3 2/2] drivers/irqchip: add NXP INTMUX interrupt
>> multiplexer support
>>
>> On 2019-12-20 14:10, Joakim Zhang wrote:
>>>> -----Original Message-----
>>>> From: Lokesh Vutla <lokeshvutla@ti.com>
>>
>> [...]
>>
>>>> Does the user care to which channel does the interrupt source goes
>>>> to? If not, interrupt-cells in DT can just be a single entry and the
>>>> channel selection can be controlled by the driver no? I am trying to
>>>> understand why user should specify the channel no.
>>> Hi Lokesh,
>>>
>>> If a fixed channel is specified in the driver, all interrupt sources
>>> will be connected to this channel, affecting the interrupt priority to
>>> some extent.
>>>
>>> From my point of view, a fixed channel could be enough if don't care
>>> interrupt priority.
>>
>> Hold on a sec:
>>
>> Is the channel to which an interrupt is routed to programmable? What has the
>> priority of the interrupt to do with this? How does this affect interrupt
>> delivery?
>>
>> It looks like this HW does more that you initially explained...
> Hi Marc,
> 
> The channel to which an interrupt is routed to is not programmable. Each channel has the same 32 interrupt sources.

But the interrupt source to channel is programmable right? I guess you are
worried about the affinity for each interrupt. You can bring the logic inside
the driver to assign the channel to each interrupt source and can maintain the
affinity to some extent..

> Each channel has mask, unmask and status register.
> If use 1 channel, 32 interrupt sources input and 1 interrupt output.
> If use 2 channels, 32 interrupt sources input and 2 interrupts output.
> And so on. You can see above INTMUX block diagram. This is how HW works.
> 
> For example:
> 1) use 1 channel:
> We can enable 0~31 interrupt in channel 0. And 1 interrupt output. If generate interrupt, we cannot figure out which half happened first.

Hmm...does this mean that each channel is capable of handling only 15 interrupt
sources or did I missunderstood the hardware?

Thanks and regards,
Lokesh

> 2)use 2 channels:
> We can enable 0~15 interrupt in channel 0, and enable 16~31 in channel 1. And 2 interrupts output. If generate interrupt, at least we can find channel 0 or channel 1 first. Then find 0~15 or 16~31 first.
> 
> This is my understanding of the interrupt priority from this intmux, I don't know if it is my misunderstanding.
> 
> Best Regards,
> Joakim Zhang
>>          M.
>> --
>> Jazz is not dead. It just smells funny...
