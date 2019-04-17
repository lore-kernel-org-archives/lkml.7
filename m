Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3388BC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A52A217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbfDQJ12 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:27:28 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:51261 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727177AbfDQJ12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 05:27:28 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-37-Zm0YF45mM2C0fT5Ghah7NQ-1; Wed, 17 Apr 2019 10:27:25 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 17 Apr 2019 10:28:35 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 17 Apr 2019 10:28:35 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Reshetova, Elena'" <elena.reshetova@intel.com>,
        Theodore Ts'o <tytso@mit.edu>
CC:     'Peter Zijlstra' <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "luto@kernel.org" <luto@kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Thread-Topic: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Thread-Index: AQHU9E1UquBTkhVACE2y3BuRFoekIqY8wW2AgAAdM1CAAXexAIAANZ3ggAAW1gCAAApRgIAAMeKAgAAd+PCAARJkYA==
Date:   Wed, 17 Apr 2019 09:28:35 +0000
Message-ID: <9cf586757eb44f2c8f167abf078da921@AcuMS.aculab.com>
References: <20190415060918.3766-1-elena.reshetova@intel.com>
 <20190415072535.GA51449@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C4F90F@IRSMSX102.ger.corp.intel.com>
 <20190416073444.GC127769@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C51962@IRSMSX102.ger.corp.intel.com>
 <20190416120822.GV11158@hirez.programming.kicks-ass.net>
 <01914abbfc1a4053897d8d87a63e3411@AcuMS.aculab.com>
 <20190416154348.GB3004@mit.edu>
 <2236FBA76BA1254E88B949DDB74E612BA4C52338@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4C52338@IRSMSX102.ger.corp.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: Zm0YF45mM2C0fT5Ghah7NQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reshetova, Elena
> Sent: 16 April 2019 17:47
..
> > It seems though the assumption that we're assuming the attacker has
> > arbitrary ability to get the low bits of the stack, so *if* that's
> > true, then eventually, you'd be able to get enough samples that you
> > could reverse engineer the prandom state.  This could take long enough
> > that the process will have gotten rescheduled to another CPU, and
> > since the prandom state is per-cpu, that adds another wrinkle.
> 
> Well, yes, this is also my feeling that it is going to be hard to do, but can we get
> some more concrete numbers of this? We can forget about per-cpu rescheduling
> for simplicity and just calculate how many calls it would take to recover the state
> given that each call leaks 5 bits.

If you can guarantee back to back requests on the PRNG then it is probably
possible to recalculate its state from 'bits of state'/5 calls.
Depend on the PRNG this might be computationally expensive.
For some PRNG it will be absolutely trivial.

IIRC the kernel PRNG is just the xor of several crc, without any
addition or multiply operations it is probably analytically reversible.

Thinks further...
If it has 128 state bits, 26 consecutive outputs of 5 bits gives
you 130 linear equations in 128 unknowns - trivially solvable.

Stirring in a little bit of entropy doesn't help much either.
The entropy bits are effectively initial state bits.
Add 4 in with each request and 128 outputs gives 640 linear
equations in the (128 + 4 * 128) unknowns - still solvable.

The extra entropy does stop you completely predicting the following
outputs.

Of course, if the PRNG is non-linear solving the equations is hard.
In that case you don't need to worry anywhere near as much about
feeding in more entropy bits than are being removed.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

