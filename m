Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PDS_BTC_ID,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40495C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1685920675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfLDKGr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 05:06:47 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:55142 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726893AbfLDKGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 05:06:46 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-230-uXAw4WH1P6aWgBVH6XDs0A-1; Wed, 04 Dec 2019 10:06:43 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 4 Dec 2019 10:06:42 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 4 Dec 2019 10:06:42 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH] x86: Optimise x86 IP checksum code
Thread-Topic: [PATCH] x86: Optimise x86 IP checksum code
Thread-Index: AdWpzyHtgEC6Bj0rR0OBHDPJtRbpCgAtCXoAAADaK7A=
Date:   Wed, 4 Dec 2019 10:06:42 +0000
Message-ID: <4eb6bf799d5848e6829a89bae96c359e@AcuMS.aculab.com>
References: <c92db041c78e4d81a70aaf4249393901@AcuMS.aculab.com>
 <20191204091450.GQ2844@hirez.programming.kicks-ass.net>
In-Reply-To: <20191204091450.GQ2844@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: uXAw4WH1P6aWgBVH6XDs0A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra
> Sent: 04 December 2019 09:15
> On Tue, Dec 03, 2019 at 11:52:09AM +0000, David Laight wrote:
> 
> > I did get about 12 bytes/clock using adox/adcx but that would need run-time
> > patching and some AMD cpu that support the instructions run them very slowly.
> 
> Isn't that was we have alternative_call() for?

You'd need to do a run-time check even if the instructions are supported.

Getting the ad[oc]x loop to work is a lot of effort for little gain.
I only tested the loop, not the alignment code - which is tricky since
the loop needs significant unrolling (on Intel cpu adc and jmp need ports
0 or 5 - so you can only do two per clock).
It might be worth doing it on AMD Ryzen where you can use the 'loop'
instruction - but then you'd need to setup multiple base registers and
would be processing memory backwards (loses prefetches).

Quite likely you'd need a reasonably long buffer to get any benefit.
(a few kb at least).

In any case, even in 2004 (the last time this code was changed in git)
it was pointed out that performance isn't that critical.
Interestingly in 2004 only AMD cpus were likely to run the adc chain
at 1 instruction/clock - all the intel ones took 2.
4 bytes/clock can be trivially achieved in C by adding 32 bit words
to a 64 bit register.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

