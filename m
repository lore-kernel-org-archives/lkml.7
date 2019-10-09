Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF89ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642FF21848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbfJIJiB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:38:01 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:53045 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729616AbfJIJiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:38:00 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-103-VZzcP8GxPMmH4z8lG9RLRA-1; Wed, 09 Oct 2019 10:37:57 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 9 Oct 2019 10:37:56 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 9 Oct 2019 10:37:56 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Pavel Machek' <pavel@ucw.cz>
CC:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Mc Guire <hofrat@opentech.at>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: RE: x86/random: Speculation to the rescue
Thread-Topic: x86/random: Speculation to the rescue
Thread-Index: AQHVfV0j+0Zbqc/i0UCMngMctaT4AqdQmbewgAFKogCAACVSoA==
Date:   Wed, 9 Oct 2019 09:37:56 +0000
Message-ID: <0ee565c2378a4abab6b623d6d3e10a7f@AcuMS.aculab.com>
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
 <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
 <20191006114129.GD24605@amd>
 <CAHk-=wjvhovO6V4-zT=xEMFnRonYteZvsPo-S0_n_DetSTUk5A@mail.gmail.com>
 <20191006173501.GA31243@amd>
 <CAHk-=whgfz2+OgBTVrHLoHK57emYb4gN6TtJ_s-607U=jBQ+ig@mail.gmail.com>
 <20191006182103.GA2394@amd> <20191007114734.GA6104@mit.edu>
 <20191007221817.GA4027@amd>
 <4748b43e6b00415fb21c1a127a835e87@AcuMS.aculab.com>
 <20191009080240.GA11561@amd>
In-Reply-To: <20191009080240.GA11561@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: VZzcP8GxPMmH4z8lG9RLRA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Machek
> Sent: 09 October 2019 09:03
> > NAND flash requires ECC so is likely to be async.
> > But I2C is clocked from the cpu end - so is fixed.
>
> RTC i2c may be clocked from the CPU end, but the time source needs to
> work when machine is off, so that has a separate crystal for
> timekeeping.

That only helps if the rtc chip lets you read its internal counters.
You get one read of a few bits of 'randomness'.

> > Also an embedded system could be booting off a large serial EEPROM.
> > These have fixed timings and are clocked from the cpu end.
> 
> Have you seen such system running Linux?

You can run Linux on the Nios cpu on an Altera/Intel FPGA.
The kernel is likely to be loaded from the same serial eeprom as the FPGA image.

I've not personally run such a setup, but there are examples for the dev boards
so I assume some people do.
I'm not sure I'd want to run Linux on a 100MHz cpu with a slow memory interface.
Better finding an fpga with an arm core in the corner!

(We do use the Nios cpu - but for standalone code that fits in small internal
memory blocks.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

