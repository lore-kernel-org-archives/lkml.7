Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C313C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD38C206DB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbfLEPx7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 10:53:59 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:41127 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726257AbfLEPx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 10:53:59 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-72-DURempHmOMK1f9U0yt4-xQ-1; Thu, 05 Dec 2019 15:53:56 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 5 Dec 2019 15:53:56 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 5 Dec 2019 15:53:56 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Running an Ivy Bridge cpu at fixed frequency
Thread-Topic: Running an Ivy Bridge cpu at fixed frequency
Thread-Index: AdWqwtS5CEX1+9oiRRqqz+2UyKDrUwAjenUAAAvrmWA=
Date:   Thu, 5 Dec 2019 15:53:55 +0000
Message-ID: <df5b67c5f51b48c391480358d6af53ca@AcuMS.aculab.com>
References: <8eeee0695c664305ba6a56bce42a995f@AcuMS.aculab.com>
 <20191205094535.GF2810@hirez.programming.kicks-ass.net>
In-Reply-To: <20191205094535.GF2810@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: DURempHmOMK1f9U0yt4-xQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra
> Sent: 05 December 2019 09:46
> As Andy already wrote, perf is really good for this.
> 
> Find attached, it probably is less shiny than what Andy handed you, but
> contains all the bits required to frob something.

You are in a maze of incomplete documentation all disjoint.

The x86 instruction set doc (eg 325462.pdf) defines the rdpmc instruction, tells you
how many counters each cpu type has, but doesn't even contain a reference
to how they are incremented.
I guess there are some processor-specific MSR for that.

perf_event_open(2) tells you a few things, but doesn't actually what anything is.
It contains all but the last 'if' clause of this function, without really saying
what any of it does - or why you might do it this way.

static inline u64 mmap_read_self(void *addr)
{
        struct perf_event_mmap_page *pc = addr;
        u32 seq, idx, time_mult = 0, time_shift = 0, width = 0;
        u64 count, cyc = 0, time_offset = 0, enabled, running, delta;
        s64 pmc = 0;

        do {
                seq = pc->lock;
                barrier();

                enabled = pc->time_enabled;
                running = pc->time_running;

                if (pc->cap_user_time && enabled != running) {
                        cyc = rdtsc();
                        time_mult = pc->time_mult;
                        time_shift = pc->time_shift;
                        time_offset = pc->time_offset;
                }

                idx = pc->index;
                count = pc->offset;
                if (pc->cap_user_rdpmc && idx) {
                        width = pc->pmc_width;
                        pmc = rdpmc(idx - 1);
                }

                barrier();
        } while (pc->lock != seq);

        if (idx) {
                pmc <<= 64 - width;
                pmc >>= 64 - width; /* shift right signed */
                count += pmc;
        }

        if (enabled != running) {
                u64 quot, rem;

                quot = (cyc >> time_shift);
                rem = cyc & ((1 << time_shift) - 1);
                delta = time_offset + quot * time_mult +
                        ((rem * time_mult) >> time_shift);

                enabled += delta;
                if (idx)
                        running += delta;

                quot = count / running;
                rem = count % running;
                count = quot * enabled + (rem * enabled) / running;
        }

        return count;
}

AFAICT:
1) The last clause is scaling the count up to allow for time when the hardware counter
   couldn't be allocated.
   I'm not convinced that is useful, better to ignore the entire measurement.
   Half this got deleted from the man page, leaving strange 'set but unused' variables.

2) The hardware counters are disabled while the process is asleep.
   On wake a different pmc counter might be used (maybe on a different cpu).
   The new cpu might not even have a counter available.

3) If you don't want to scale up for missing periods it is probably enough to do:
	do {
		seq = pc->offset;
		barrier();
		idx = pc->index;
		if (!index)
			return -1;
		count = pc->offset + rdpmc(idx - 1);
	} while (seq != pc->seq);
	return (unsigned int)count;
  
Not tried it yet :-)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

