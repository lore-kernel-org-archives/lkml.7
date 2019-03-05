Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D880C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3847420684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="k/cHofTa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfCEB0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 20:26:12 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:54142 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfCEB0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 20:26:12 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E80E9886BC;
        Tue,  5 Mar 2019 14:26:08 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1551749168;
        bh=vw0hwgvAXaDbbHvWMzvpb4Ex24tZ9/w2+JM8EVFPMq4=;
        h=From:To:CC:Subject:Date:References;
        b=k/cHofTasJdqy0QicsUwrnu0fpSIDS1vVTlCh2KNvrdT57iKLz3sX3OQv4jlCRbCT
         E1bSc+R5wVs9VbfLVY1J3XCYtcUM8TtZRDd9JvM4NEJ2+nizhNNVk3oYg587mSiM1i
         NoUl0z+F7+S6na9oBlFOj+GSIX6xT9ol2WPf8j9KQiADnHvjnFHoz4kWRRHtWPqfHJ
         EvD6RajFbEf+UxFMc1bHLkvOQB3wMjxeW/SfV0Rr5vnNvWdiw3f+RHiUIGKk/RG++W
         oRZUcWVs6YPmdZ0On/VcxJu8v6B6ajuXN8Fm39JBBnJ1qdwpgeu15gkNFKX8+Plj0o
         1DbmBD7/mH1Yg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c7dd02f0001>; Tue, 05 Mar 2019 14:26:07 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Tue, 5 Mar 2019 14:26:08 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Tue, 5 Mar 2019 14:26:08 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] watchdog: orion_wdt: use timer1 as a pretimeout
Thread-Topic: [PATCH 2/2] watchdog: orion_wdt: use timer1 as a pretimeout
Thread-Index: AQHU0tznXEshF/alRUmxsGLMo19NMQ==
Date:   Tue, 5 Mar 2019 01:26:08 +0000
Message-ID: <5605e7b7a0f540a7908a1eb5191bbe5e@svr-chch-ex1.atlnz.lc>
References: <20190227230707.GA28635@roeck-us.net>
 <20190304225152.26831-1-chris.packham@alliedtelesis.co.nz>
 <20190304225152.26831-3-chris.packham@alliedtelesis.co.nz>
 <20190305005710.GL26378@lunn.ch>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/03/19 1:57 PM, Andrew Lunn wrote:=0A=
> On Tue, Mar 05, 2019 at 11:51:52AM +1300, Chris Packham wrote:=0A=
>> The orion watchdog can either reset the CPU or generate an interrupt.=0A=
>> The interrupt would be useful for debugging as it provides panic()=0A=
>> output about the watchdog expiry, however if the interrupt is used the=
=0A=
>> watchdog can't reset the CPU in the event of being stuck in a loop with=
=0A=
>> interrupts disabled or if the CPU is prevented from accessing memory=0A=
>> (e.g. an unterminated DMA).=0A=
>>=0A=
>> All of the orion based CPU cores (at least back as far as Kirkwood) have=
=0A=
>> spare timers that aren't currently used by the Linux kernel.=0A=
=0A=
Actually this appears to be incorrect Kirkwood does configure timer1 as =0A=
a clockevent timer. So I can't just grab timer1 for all platforms.=0A=
=0A=
>> We can use=0A=
>> timer1 to provide a pre-timeout ahead of the watchdog timer and provide=
=0A=
>> the possibility of gathering debug before the reset triggers.=0A=
> =0A=
> Hi Chris=0A=
> =0A=
> I had a quick look at other drivers implementing pre-timeout. They=0A=
> seem to call watchdog_notify_pretimeout(). I don't see that here? What=0A=
> happens when timer1 fires?=0A=
> =0A=
=0A=
It invokes the regular orion_wdt_irq(). On Armada-385 prior to this =0A=
change the irq was not specified because the reset always kicked in so =0A=
there was no point.=0A=
=0A=
For correctness I could make the devicetree binding specify 2 =0A=
interrupts. One for the regular watchdog interrupt (which would never =0A=
usually get hit because the reset would kick in) and one for the =0A=
pretimeout/timer1.=0A=
=0A=
>> @@ -169,38 +174,46 @@ static int armadaxp_wdt_clock_init(struct platform=
_device *pdev,=0A=
>>   	}=0A=
>>   =0A=
>>   	/* Enable the fixed watchdog clock input */=0A=
>> -	atomic_io_modify(dev->reg + TIMER_CTRL,=0A=
>> -			 WDT_AXP_FIXED_ENABLE_BIT,=0A=
>> -			 WDT_AXP_FIXED_ENABLE_BIT);=0A=
>> +	val =3D WDT_AXP_FIXED_ENABLE_BIT | TIMER1_FIXED_ENABLE_BIT;=0A=
>> +	atomic_io_modify(dev->reg + TIMER_CTRL, val, val);=0A=
>>   =0A=
>>   	dev->clk_rate =3D clk_get_rate(dev->clk);=0A=
>> +=0A=
>> +=0A=
> =0A=
> One blank line is sufficient,=0A=
> =0A=
> =0A=
>>   	return 0;=0A=
>>   }=0A=
> =0A=
>     Andrew=0A=
> =0A=
=0A=
