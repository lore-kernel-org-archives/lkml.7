Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PDS_BTC_ID,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C27C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4144C2075C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfLFNGd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 08:06:33 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:59597 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726157AbfLFNGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 08:06:33 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-191-B72c3dN0PhWkXzJBAqYldw-1; Fri, 06 Dec 2019 13:06:20 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 6 Dec 2019 13:06:19 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 6 Dec 2019 13:06:19 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Running an Ivy Bridge cpu at fixed frequency
Thread-Topic: Running an Ivy Bridge cpu at fixed frequency
Thread-Index: AdWqwtS5CEX1+9oiRRqqz+2UyKDrUwAjenUAAAvrmWAAJ2vSAAAFs35g
Date:   Fri, 6 Dec 2019 13:06:19 +0000
Message-ID: <bc8cfc6f443f45989a692f051a8a01ca@AcuMS.aculab.com>
References: <8eeee0695c664305ba6a56bce42a995f@AcuMS.aculab.com>
 <20191205094535.GF2810@hirez.programming.kicks-ass.net>
 <df5b67c5f51b48c391480358d6af53ca@AcuMS.aculab.com>
 <20191206101540.GB2844@hirez.programming.kicks-ass.net>
In-Reply-To: <20191206101540.GB2844@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: B72c3dN0PhWkXzJBAqYldw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra
> Sent: 06 December 2019 10:16
> To: David Laight <David.Laight@ACULAB.COM>
...
> The whole counter scaling crud is just that, crud you can mostly forget
> about if you want to quickly hack something together. See
> mmap_read_pinned() for the simplified (and much faster version) that
> ignores all that.

I noticed that version later :-(
The 'seqcount' is interesting, since it only protects against updates
that happen while the process itself is in kernel space.
It doesn't allow arbitrary kernel updates of the memory area.

...
> You still need to do the rdpmc sign extent crud, but see
> mmap_read_pinned() that does just about that.

Actually for what I'm doing i can truncate the counter to 32 bits
and not worry about when it wraps.

Anyway I've not got some histograms of the elapsed cycle counts
for recvfrom() and recvmsg() with, and without, some of the
HARDENED_USERCOPY costs.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

