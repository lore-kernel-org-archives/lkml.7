Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A7EC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094DC20652
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfEBQeu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 12:34:50 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:33168 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726300AbfEBQeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 12:34:50 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-160-SA7C3NSCNyuEpoaJBQmVzg-1; Thu, 02 May 2019 17:34:47 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu,
 2 May 2019 17:34:46 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 2 May 2019 17:34:46 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ingo Molnar' <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>
CC:     "Reshetova, Elena" <elena.reshetova@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Eric Biggers <ebiggers3@gmail.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: RE: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Thread-Topic: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Thread-Index: AQHU9E1UquBTkhVACE2y3BuRFoekIqY8wW2AgAAdM1CAAXexAIAANZ3ggAAW1gCAAApRgIAAMeKAgAAd+PCAAQuGgIAAYQuAgAAKhwCACsPi4IADJTwAgAAcagCAAExngIAEBbGAgACIbACAAbyQ8IAA9yhggAF9YoCAABkBsIAAayebgAAR3KA=
Date:   Thu, 2 May 2019 16:34:46 +0000
Message-ID: <d64b3562d179430f9bdd8712999ff98a@AcuMS.aculab.com>
References: <2236FBA76BA1254E88B949DDB74E612BA4C63E24@IRSMSX102.ger.corp.intel.com>
 <20190426140102.GA4922@mit.edu>
 <57357E35-3D9B-4CA7-BAB9-0BE89E0094D2@amacapital.net>
 <2236FBA76BA1254E88B949DDB74E612BA4C66A8A@IRSMSX102.ger.corp.intel.com>
 <6860856C-6A92-4569-9CD8-FF6C5C441F30@amacapital.net>
 <2236FBA76BA1254E88B949DDB74E612BA4C6A4D7@IRSMSX102.ger.corp.intel.com>
 <303fc4ee5ac04e4fac104df1188952e8@AcuMS.aculab.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C6C2C3@IRSMSX102.ger.corp.intel.com>
 <2e55aeb3b39440c0bebf47f0f9522dd8@AcuMS.aculab.com>
 <CALCETrXjGvWVgZHrKCfH6RBsnYOyD2+Mey1Esw7BsA4Eg6PS0A@mail.gmail.com>
 <20190502150853.GA16779@gmail.com>
In-Reply-To: <20190502150853.GA16779@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: SA7C3NSCNyuEpoaJBQmVzg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar
> Sent: 02 May 2019 16:09
> * Andy Lutomirski <luto@kernel.org> wrote:
> 
> > Or we decide that calling get_random_bytes() is okay with IRQs off and
> > this all gets a bit simpler.
> 
> BTW., before we go down this path any further, is the plan to bind this
> feature to a real CPU-RNG capability, i.e. to the RDRAND instruction,
> which excludes a significant group of x86 of CPUs?

It has already been measured - it is far too slow.
Even just using 6 bits so it doesn't have to be read every system call is
probably a significant overhead (I don't think that was tested though).

I do agree that using 'real' randomness is probably OTT here.

> Because calling tens of millions of system calls per second will deplete
> any non-CPU-RNG sources of entropy and will also starve all other users
> of random numbers, which might have a more legitimate need for
> randomness, such as the networking stack ...

If the function you use to generate random numbers from the 'entropy
pool' isn't reversible (in a finite time) I don't think you really need
to worry about bits-in v bits-out.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

