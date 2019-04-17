Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F95C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E23820663
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732794AbfDQPzd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:55:33 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:40205 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731454AbfDQPzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:55:33 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-43-4U1-6HfcPGaTLGSoAXGjSw-1; Wed, 17 Apr 2019 16:55:07 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 17 Apr 2019 16:53:36 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 17 Apr 2019 16:53:36 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Theodore Ts'o' <tytso@mit.edu>
CC:     "'Reshetova, Elena'" <elena.reshetova@intel.com>,
        'Peter Zijlstra' <peterz@infradead.org>,
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
Thread-Index: AQHU9E1UquBTkhVACE2y3BuRFoekIqY8wW2AgAAdM1CAAXexAIAANZ3ggAAW1gCAAApRgIAAMeKAgAAd+PCAARJkYIAAWDaAgAAZlPA=
Date:   Wed, 17 Apr 2019 15:53:36 +0000
Message-ID: <99e045427125403ba2b90c2707d74e02@AcuMS.aculab.com>
References: <20190415060918.3766-1-elena.reshetova@intel.com>
 <20190415072535.GA51449@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C4F90F@IRSMSX102.ger.corp.intel.com>
 <20190416073444.GC127769@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C51962@IRSMSX102.ger.corp.intel.com>
 <20190416120822.GV11158@hirez.programming.kicks-ass.net>
 <01914abbfc1a4053897d8d87a63e3411@AcuMS.aculab.com>
 <20190416154348.GB3004@mit.edu>
 <2236FBA76BA1254E88B949DDB74E612BA4C52338@IRSMSX102.ger.corp.intel.com>
 <9cf586757eb44f2c8f167abf078da921@AcuMS.aculab.com>
 <20190417151555.GG4686@mit.edu>
In-Reply-To: <20190417151555.GG4686@mit.edu>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 4U1-6HfcPGaTLGSoAXGjSw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Theodore Ts'o
> Sent: 17 April 2019 16:16
> On Wed, Apr 17, 2019 at 09:28:35AM +0000, David Laight wrote:
> >
> > If you can guarantee back to back requests on the PRNG then it is probably
> > possible to recalculate its state from 'bits of state'/5 calls.
> > Depend on the PRNG this might be computationally expensive.
> > For some PRNG it will be absolutely trivial.
> > ...
> > Stirring in a little bit of entropy doesn't help much either.
> > The entropy bits are effectively initial state bits.
> > Add 4 in with each request and 128 outputs gives 640 linear
> > equations in the (128 + 4 * 128) unknowns - still solvable.
> 
> This is basically a scenario where the attacker has already taken
> control of Ring 3 execution and the question is how hard is it for
> them to perform privilege escalation attack to ring 0, right?

Or extract information that should only be known by ring 0.
I fairly sure many of the side-channel attacks not only require
ring 3 access, but also the ability to request ring 0 repeatedly
perform a specific action on an otherwise idle system.

> I'm sure the security folks will think I'm defeatist, but my personal rule
> of thumb is if the attacker has ring 3 control, you've already lost
> --- I figure there are so many zero days that getting ring 0 control
> is a foregone conclusion.  :-(
> 
> So that basically means if we want to protect against this, we're
> going to do something which involves Real Crypto (tm).  Whether that's
> RDRAND, or using Chacha20, etc., or something that has some attack
> resistance, such as "half MD5", etc., but emminently crackable by
> brute force, is essentially a overhead vs. security argument, and what
> it is we are willing to pay.

Some of these 'random' values have a short lifetime - and would need
to be cracked quickly to be of any use.

I suspect that combining the output three linear generators with
addition not xor would make it computationally much harder to
reverse.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

