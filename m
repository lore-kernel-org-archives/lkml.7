Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E7DC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CF42173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbfLLKge convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:36:34 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:39928 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728631AbfLLKge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:36:34 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-56-h9JTAAgyNGuF0q8-5La6xQ-1; Thu, 12 Dec 2019 10:36:28 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 12 Dec 2019 10:36:27 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 12 Dec 2019 10:36:27 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        "Luck, Tony" <tony.luck@intel.com>
CC:     Andy Lutomirski <luto@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Will Deacon <will@kernel.org>
Subject: RE: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Thread-Topic: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Thread-Index: AQHVsHPW6yBAo1s5f0Kws0hZvGpx8qe2RQqA
Date:   Thu, 12 Dec 2019 10:36:27 +0000
Message-ID: <5ba0190e63594ad1b8b032bc12553393@AcuMS.aculab.com>
References: <CALCETrW+qxrE633qetS4c1Rn2AX_hk5OgneZRtoZPFN1J395Ng@mail.gmail.com>
 <20191121185303.GB199273@romley-ivt3.sc.intel.com>
 <20191121202508.GZ4097@hirez.programming.kicks-ass.net>
 <CALCETrXbe_q07kL1AyaNaAqgUHsdN6rEDzzZ0CEtv-k9VvQL0A@mail.gmail.com>
 <20191122092555.GA4097@hirez.programming.kicks-ass.net>
 <3908561D78D1C84285E8C5FCA982C28F7F4DD19F@ORSMSX115.amr.corp.intel.com>
 <20191122203105.GE2844@hirez.programming.kicks-ass.net>
 <CALCETrVjXC7RHZCkAcWEeCrJq7DPeVBooK8S3mG0LT8q9AxvPw@mail.gmail.com>
 <20191211175202.GQ2827@hirez.programming.kicks-ass.net>
 <20191211184416.GA6344@agluck-desk2.amr.corp.intel.com>
 <20191211223917.GU2844@hirez.programming.kicks-ass.net>
In-Reply-To: <20191211223917.GU2844@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: h9JTAAgyNGuF0q8-5La6xQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra
> Sent: 11 December 2019 22:39
> On Wed, Dec 11, 2019 at 10:44:16AM -0800, Luck, Tony wrote:
> > On Wed, Dec 11, 2019 at 06:52:02PM +0100, Peter Zijlstra wrote:
> > > Sure, but we're talking two cpus here.
> > >
> > > 	u32 var = 0;
> > > 	u8 *ptr = &var;
> > >
> > > 	CPU0			CPU1
> > >
> > > 				xchg(ptr, 1)
> > >
> > > 	xchg((ptr+1, 1);
> > > 	r = READ_ONCE(var);
> >
> > It looks like our current implementation of set_bit() would already run
> > into this if some call sites for a particular bitmap `pass in constant
> > bit positions (which get optimized to byte wide "orb") while others pass
> > in a variable bit (which execute as 64-bit "bts").
> 
> Yes, but luckily most nobody cares.
> 
> I only know of two places in the entire kernel where we considered this,
> one is clear_bit_unlock_is_negative_byte() and there we punted and
> stuffed everything in a single byte, and the other is that x86
> queued_fetch_set_pending_acquire() thing I pointed out earlier.
> 
> > I'm not a h/w architect ... but I've assumed that a LOCK operation
> > on something contained entirely within a cache line gets its atomicity
> > by keeping exclusive ownership of the cache line.
> 
> Right, but like I just wrote to Andy, consider SMT where each thread has
> its own store-buffer. Then the line is local to the core, but there
> still is a remote sb to hide stores in.
> 
> I don't know if anything x86 does that, or even allows that, but I'm not
> aware of specs that are clear enough to say either way.

On x86 'xchg' is always 'locked' regardless of whether there is a 'lock' prefix.
set_bit() (etc) include the 'lock' prefix (dunno why this decision was made...).

For locked operations (including misaligned ones) that don't cross cache-line
boundaries the read operation almost certainly locks the cache line (against
a snoop) until the write has updated the cache line.
This won't happen until the write 'drains' from the store buffer.
(I suspect that locked read requests act like write requests in ensuring
that no other cpu has a dirty copy of the cache line, and also marking it dirty.)
Although this will delay the response to the snoop it will only
stall the cpu (or other bus master), not the entire memory 'bus'.

If you read the description of 'lock btr' you'll see that it always does the
write cycle (to complete the atomic RMW expected by the memory
subsystem) even when the bit is clear.

Remote store buffers are irrelevant to locked accesses.
(If you are doing concurrent locked and unlocked accesses to the same
memory location something is badly broken.)

It really can't matter whether one access is a mis-aligned 64bit word
and the other a byte. Both do atomic RMW updates so the result
cannot be unexpected.

In principle two separate 8 bit RMW cycles could be done concurrently
to two halves of a 16 bit 'flag' word without losing any bits or any reads
returning any of the expected 4 values.
Not that any memory system would support such updates.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

