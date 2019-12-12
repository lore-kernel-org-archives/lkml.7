Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA15C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C282073B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbfLLQ34 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 11:29:56 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:51621 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729762AbfLLQ3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 11:29:54 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-183-9bqkSpuKPHSIRWR5dhDRIA-1; Thu, 12 Dec 2019 16:29:51 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 12 Dec 2019 16:29:50 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 12 Dec 2019 16:29:50 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, "Will Deacon" <will@kernel.org>
Subject: RE: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Thread-Topic: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Thread-Index: AQHVsHPW6yBAo1s5f0Kws0hZvGpx8qe2RQqAgAAzZICAABroAA==
Date:   Thu, 12 Dec 2019 16:29:50 +0000
Message-ID: <082649e791a74992bc438263d103d21b@AcuMS.aculab.com>
References: <20191121202508.GZ4097@hirez.programming.kicks-ass.net>
 <CALCETrXbe_q07kL1AyaNaAqgUHsdN6rEDzzZ0CEtv-k9VvQL0A@mail.gmail.com>
 <20191122092555.GA4097@hirez.programming.kicks-ass.net>
 <3908561D78D1C84285E8C5FCA982C28F7F4DD19F@ORSMSX115.amr.corp.intel.com>
 <20191122203105.GE2844@hirez.programming.kicks-ass.net>
 <CALCETrVjXC7RHZCkAcWEeCrJq7DPeVBooK8S3mG0LT8q9AxvPw@mail.gmail.com>
 <20191211175202.GQ2827@hirez.programming.kicks-ass.net>
 <20191211184416.GA6344@agluck-desk2.amr.corp.intel.com>
 <20191211223917.GU2844@hirez.programming.kicks-ass.net>
 <5ba0190e63594ad1b8b032bc12553393@AcuMS.aculab.com>
 <20191212130421.GX2827@hirez.programming.kicks-ass.net>
In-Reply-To: <20191212130421.GX2827@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 9bqkSpuKPHSIRWR5dhDRIA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra
> Sent: 12 December 2019 13:04
> On Thu, Dec 12, 2019 at 10:36:27AM +0000, David Laight wrote:
...
> > set_bit() (etc) include the 'lock' prefix (dunno why this decision was made...).
> 
> Because it is the atomic set bit function, we have __set_bit() if you
> want the non-atomic one.

Horrid name, looks like part of the implementation...
I know _ prefixes get used for functions that don't acquire the obvious lock,
but they usually require the caller to hold the lock.

set_bit_nonatomic() and set_bit_atomic() wold be better names.

> Atomic bitops are (obviously) useful if you have concurrent changes to
> your bitmap.
> 
> Lots of people seem confused on this though, as evidenced by a lot of
> the broken crap we keep finding (then again, them using __set_bit()
> would still be broken due to the endian thing).

Yep, quite a bit of code just wants  x |= 1 << n;

> > For locked operations (including misaligned ones) that don't cross cache-line
> > boundaries the read operation almost certainly locks the cache line (against
> > a snoop) until the write has updated the cache line.
> 
> Note your use of 'almost'. Almost isn't good enough. Note that other
> architectures allow the store from atomic operations to hit the store
> buffer. And I strongly suspect x86 does the same.
> 
> Waiting for a store-buffer drain is *expensive*.

Right, the cpu doesn't need to wait for the store buffer to drain,
but the cache line needs to remain locked until it has drained.

...
> > This won't happen until the write 'drains' from the store buffer.
> > (I suspect that locked read requests act like write requests in ensuring
> > that no other cpu has a dirty copy of the cache line, and also marking it dirty.)
> > Although this will delay the response to the snoop it will only
> > stall the cpu (or other bus master), not the entire memory 'bus'.
> 
> I really don't think so. The commit I pointed to earlier in the thread,
> that replaced MFENCE with LOCK ADD $0, -4(%RSP) for smp_mb(), strongly
> indicates LOCK prefixed instructions do _NOT_ flush the store buffer.

They don't need to.
It is only a remote cpu trying to gain exclusive access to the cache line
that needs to be stalled by the LOCK prefix write.
Once that write has escaped the store buffer the cache line can be released.

Of course the store buffer may be able to contain the write data for multiple
atomic operations to different parts of the same cache line.

...
> > (If you are doing concurrent locked and unlocked accesses to the same
> > memory location something is badly broken.)
> 
> It is actually quite common.

Sorry I meant unlocked writes.

> > It really can't matter whether one access is a mis-aligned 64bit word
> > and the other a byte. Both do atomic RMW updates so the result
> > cannot be unexpected.
> 
> Expectations are often violated. Esp when talking about memory ordering.

Especially on DEC Alpha :-)

> > In principle two separate 8 bit RMW cycles could be done concurrently
> > to two halves of a 16 bit 'flag' word without losing any bits or any reads
> > returning any of the expected 4 values.
> > Not that any memory system would support such updates.
> 
> I'm thinking you ought to go read that paper on mixed size concurrency I
> referenced earlier in this thread. IIRC the conclusion was that PowerPC
> does exactly that and ARM64 allows for it but it hasn't been observed,
> yet.

CPU with shared L1 cache might manage to behave 'oddly'.
But they still need to do locked RMW cycles.

> Anyway, I'm not saying x86 behaves this way, I'm saying that I have lots
> of questions and very little answers. I'm also saying that the variant
> with non-overlapping atomics could conceivably misbehave, while the
> variant with overlapping atomics is guaranteed not to.
> 
> Specifically smp_mb()/SYNC on PowerPC can not restore Sequential
> Consistency under mixed size operations. How's that for expectations?

Is that the spanish inquistion?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

