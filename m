Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BC0C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E768C20815
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730856AbfJHLdy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 07:33:54 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:22595 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730833AbfJHLdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:33:51 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-90-a7HITZQhP0ySUXEt4BGcmA-1; Tue, 08 Oct 2019 12:33:47 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 8 Oct 2019 12:33:47 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 8 Oct 2019 12:33:47 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Pavel Machek' <pavel@ucw.cz>, "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Mc Guire <hofrat@opentech.at>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: RE: x86/random: Speculation to the rescue
Thread-Topic: x86/random: Speculation to the rescue
Thread-Index: AQHVfV0j+0Zbqc/i0UCMngMctaT4AqdQmbew
Date:   Tue, 8 Oct 2019 11:33:46 +0000
Message-ID: <4748b43e6b00415fb21c1a127a835e87@AcuMS.aculab.com>
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
 <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
 <20191006114129.GD24605@amd>
 <CAHk-=wjvhovO6V4-zT=xEMFnRonYteZvsPo-S0_n_DetSTUk5A@mail.gmail.com>
 <20191006173501.GA31243@amd>
 <CAHk-=whgfz2+OgBTVrHLoHK57emYb4gN6TtJ_s-607U=jBQ+ig@mail.gmail.com>
 <20191006182103.GA2394@amd> <20191007114734.GA6104@mit.edu>
 <20191007221817.GA4027@amd>
In-Reply-To: <20191007221817.GA4027@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: a7HITZQhP0ySUXEt4BGcmA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Machek
> Sent: 07 October 2019 23:18
..
> I have many systems including SoC here, but technology needed for NAND
> flash is different from technology for CPU, so these parts do _not_
> share a silicon die. They do not even share same package. (Also RTC
> tends to be on separate chip, connected using i2c).

NAND flash requires ECC so is likely to be async.
But I2C is clocked from the cpu end - so is fixed.

Also an embedded system could be booting off a large serial EEPROM.
These have fixed timings and are clocked from the cpu end.

So until you get any ethernet interface up and can look at receive packet
timings there isn't likely to be any randomness at all.
A high resolution voltage  (or temperature) monitor might generate noise
in its LSB - but they don't often have a higher resolution than the stability
of the signal.

I can't remember (from the start of this thread) why 'speculation' is expected to
generate randomness.
I'd have thought the loop was deterministic - but you don't know the initial state.
More iterations may just be amplifying the initial small randomness - rather than
generating extra randomness.
So while it gets the system to boot, it hasn't actually done its job.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

