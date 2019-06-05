Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC3AC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734402075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfFEJiw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 05:38:52 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:40805 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726690AbfFEJiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 05:38:52 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-140-obHVVIjyNKmcrmatuEDzRA-1; Wed, 05 Jun 2019 10:38:49 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 5 Jun 2019 10:38:48 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 5 Jun 2019 10:38:48 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: sched_setaffinity() with > 1024 cpus on gcc-9
Thread-Topic: sched_setaffinity() with > 1024 cpus on gcc-9
Thread-Index: AdUbgnpEuljvuI+IR8mR//XAM+iBRw==
Date:   Wed, 5 Jun 2019 09:38:48 +0000
Message-ID: <6b42c210ba704118b00d0f44742efddf@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: obHVVIjyNKmcrmatuEDzRA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I suspect that if I compile the following using gcc-9 It'll bleat
about going beyond the end of the array:

#define _GNU_SOURCE
#include <sched.h>

#define MAX_CPU 2048

int fubar(void)
{
        cpu_set_t *set = CPU_ALLOC(MAX_CPU);
        CPU_SET_S(MAX_CPU - 2, CPU_ALLOC_SIZE(MAX_CPU), set);
        return CPU_COUNT_S(CPU_ALLOC_SIZE(MAX_CPU), set);
}

I can't test since I don't have a copy of gcc-9.

The whole interface for > 1024 cpus looks horrid though.
Reading version 5.01 on the man page.
I'd have thought that if the application provided a short mask
to sched_setaffinity() the rest would be deemed to be zeros.
And that if an overlong mask is passed to sched_getaffinity()
the extra bytes/longs would either be zerod or unchanged.

       Be aware that CPU_ALLOC(3) may allocate a slightly larger CPU set
       than requested (because CPU sets are implemented as bit masks
       allocated in units of sizeof(long)).  Consequently,
       sched_getaffinity() can set bits beyond the requested allocation
       size, because the kernel sees a few additional bits.  Therefore, the
       caller should iterate over the bits in the returned set, counting
       those which are set, and stop upon reaching the value returned by
       CPU_COUNT(3) (rather than iterating over the number of bits requested
       to be allocated).

A short mask to sched_getaffinity() should also do something
more sensible than just returning an error.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

