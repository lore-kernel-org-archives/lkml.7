Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20865C2BBE2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF50D207DD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfLDLOO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:14:14 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:26716 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727268AbfLDLON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:14:13 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-171-xQ-iqH-0NqakegqgDHauPg-1; Wed, 04 Dec 2019 11:14:09 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 4 Dec 2019 11:14:08 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 4 Dec 2019 11:14:08 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Paul Burton' <paulburton@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] MIPS: Use __copy_{to,from}_user() for emulated FP
 loads/stores
Thread-Topic: [PATCH] MIPS: Use __copy_{to,from}_user() for emulated FP
 loads/stores
Thread-Index: AQHVqhshCXVq7CTTBEufX7LGTbPWHKep0u6g
Date:   Wed, 4 Dec 2019 11:14:08 +0000
Message-ID: <f5e09155580d417e9dcd07b1c20786ed@AcuMS.aculab.com>
References: <20191203204933.1642259-1-paulburton@kernel.org>
In-Reply-To: <20191203204933.1642259-1-paulburton@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: xQ-iqH-0NqakegqgDHauPg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Burton
> Sent: 03 December 2019 20:50
> Our FPU emulator currently uses __get_user() & __put_user() to perform
> emulated loads & stores. This is problematic because __get_user() &
> __put_user() are only suitable for naturally aligned memory accesses,
> and the address we're accessing is entirely under the control of
> userland.
> 
> This allows userland to cause a kernel panic by simply performing an
> unaligned floating point load or store - the kernel will handle the
> address error exception by attempting to emulate the instruction, and in
> the process it may generate another address error exception itself.
> This time the exception is taken with EPC pointing at the kernels FPU
> emulation code, and we hit a die_if_kernel() in
> emulate_load_store_insn().

Won't this be true of almost all code that uses get_user() and put_user()
(with or without the leading __).

> Fix this up by using __copy_from_user() instead of __get_user() and
> __copy_to_user() instead of __put_user(). These replacements will handle
> arbitrary alignment without problems.

They'll also kill performance.....

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

