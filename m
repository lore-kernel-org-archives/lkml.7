Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A81C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F3121852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfGELgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 07:36:51 -0400
Received: from host-88-217-225-28.customer.m-online.net ([88.217.225.28]:55434
        "EHLO mail.dev.tdt.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726107AbfGELgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 07:36:50 -0400
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id B24B42110C;
        Fri,  5 Jul 2019 11:36:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 05 Jul 2019 13:36:47 +0200
From:   Florian Eckert <fe@dev.tdt.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Eckert.Florian@googlemail.com,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] Update pcengines-apuv2 platform device
In-Reply-To: <CAHp75VdHPRXgg6YsBM8uAfuM4CBs1HHn1condus6uW5BqC5COg@mail.gmail.com>
References: <20190704090205.19400-1-fe@dev.tdt.de>
 <CAHp75Vcocs=9AwX32ouOWFc+wAduCFv2DT_p4JYPUVV0BumjqA@mail.gmail.com>
 <e2c50449b498c796de8258fac0b0aba6@dev.tdt.de>
 <CAHp75VdHPRXgg6YsBM8uAfuM4CBs1HHn1condus6uW5BqC5COg@mail.gmail.com>
Message-ID: <226c0a14b7a662be019d02eee4695d17@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.1.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy

>> >> This patchset adds the following changes to this pcengines-apuv2
>> >> platform device.
>> >>
>> >
>> > Before doing anything to this driver, what is the plan for previously
>> > upstreamed:
>> >
>> > drivers/leds/leds-apu.c
>> 
>> I think we can remove the related APU2/APU3 code stuff from this 
>> driver.
>> The recently added pcengines-apuv2 driver does *not* support the APU1.
>> So I think we need the related APU1 stuff if we still want to support
>> this board.
> 
> So, I would like to see some unification (since it's material for v5.4
> cycle anyway, we have time).

A few thoughts and information about your suggestion to unify this.

APU1 (PC-Engines) CPU "AMD G series T40E APU":
This is also an old design and is not recommend for new design 
(deprecated).
Also not many were produced and are in the field.
See https://pcengines.ch/apu.htm

Platform-Device (LEDs, Button):
I have no platform device description found in the linux sources.
So the GPIO button should not work.

LEDs-Driver:
Only the LEDs should work with this device driver.
This is shared additonal with new APU2/APU3.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/leds/leds-apu.c

I think we should remove the APU2/APU3 stuff. This will now be handled 
by the new gpio-amd-fch.c / pcengines-apuv2.c
kombination.


APU2/APU3/APU4 (PC-Engines) CPU "AMD Embedded G series GX-412TC":
This is the newest design and is recommend for new products.
See https://pcengines.ch/apu2.htm

GPIO-Driver:
The following driver is responsible for the GPIO export and handling
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpio/gpio-amd-fch.c

Platform-Device (LEDs, Button):
This Platform description is only valid for APU2/APU3 and not for APU1.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/platform/x86/pcengines-apuv2.c

LEDs-Driver:
We have an additional device only for LEDs this works for 
APU1/APU2/APU3.
I think we should remove the APU2/APU3 LEDs from the leds-apu device as 
mentioned above.
So this device supports only the APU1 LEDs.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/leds/leds-apu.c

We could extend and/or rename the pcengienes-apuv2 device to support 
also APU3 and the newest APU4.
The APU2 does only have LEDs Button and the MPCIE2 reset lines see my 
patch.
The APU3 does have an additional the simswap pin.
So the current pcengines-apuv2 platform is from my point of view wrong.
We should change this to the following layout and add the legacy GPIO 
numbering.

This are the following GPIOs:

APU2:
LED1
LED2
LED3
BUTTON
MPCIE2
MPCIE3

APU3:
LED1
LED2
LED3
BUTTON
MPCIE2
MPCIE3
SIMSWAP

APU4:
TODO


>> > arch/x86/platform/geode/alix.c
>> 
>> I think this is not related because this is a different platform 
>> driver.
>> Maybe we should move them to drivers/platform/x86?
> 
> You mentioned somewhere ALIx, can you elaborate if these are platforms
> of the same family (PC engines)?
> 
> Looking into the code, I think we may unify all three under umbrella
> of one driver if the above is true.

ALIX (PC-Engines) CPU "AMD Geode LX":
This is an old design we have already in use and is not recommend for 
new design (deprecated)
https://pcengines.ch/alix.htm

GPIO-Driver:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpio/gpio-cs5535.c

Platform-Device (LEDs, button):
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/platform/geode/alix.c

I think we should leave the driver as it is because this is a different 
design and has nothing to do with the PUs.
The only thing I can imagine is to move the platform device to 
"drivers/platform/x86", but this is cosmetic.
I have only mentioned the alix board to explain why I think that we 
should change the APU key code from the GPIO button to unify this.

With Best Regards,

Florian

