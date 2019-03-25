Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B57C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00DE20989
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbfCYQ0a convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:26:30 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:37426 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725788AbfCYQ0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:26:30 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-219-8j2QYFXANHq-iCJja5DgIQ-1; Mon, 25 Mar 2019 16:26:26 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon,
 25 Mar 2019 16:27:30 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 25 Mar 2019 16:27:30 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andi Kleen' <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Arnd Bergmann <arnd@arndb.de>, Andi Kleen <andi@firstfloor.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: RE: [PATCH 01/17] kbuild: Disable -Waddress-of-packed-member for gcc
 9
Thread-Topic: [PATCH 01/17] kbuild: Disable -Waddress-of-packed-member for gcc
 9
Thread-Index: AQHU4NCjB9yIonUPSkeI8Ri7iuki4aYci9IA
Date:   Mon, 25 Mar 2019 16:27:30 +0000
Message-ID: <0eef6cb14cbd460b9f66f7b24a0d34b6@AcuMS.aculab.com>
References: <20190321220009.29334-1-andi@firstfloor.org>
 <20190321220009.29334-2-andi@firstfloor.org>
 <CAK8P3a31L6ddJ1JPpygHqeVspExv7eaKWsLQ5pb+T8LAF2Zjtw@mail.gmail.com>
 <20190322163954.GG7905@worktop.programming.kicks-ass.net>
 <20190322165826.GE24002@tassilo.jf.intel.com>
In-Reply-To: <20190322165826.GE24002@tassilo.jf.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 8j2QYFXANHq-iCJja5DgIQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen
> Sent: 22 March 2019 16:58
> > Lol... we're actively moving away from the C standard on many places.
> 
> Yes and also packed is not part of the C standard.
> 
> > Why does the silly compiler think it is a problem to take the address of
> > a member of a packed structure? That sounds like something that's
> > perfectly fine and useful.
> 
> Probably because a pointer reference doesn't do whatever magic
> may be needed on architectures with poor misalignment handling.
> In theory you would need memcpy().

And you can't use memcpy() on a misaligned pointer because the
C standard doesn't allow misaligned pointer to happen and the
compiler will optimise the memcpy() to aligned register moves.

> In practice it's likely a lot of false positives, like
> the architectures with poor misalignment handling are usually
> in SOCs without PCI and they don't have the devices
> with the problematic drivers.

A lot of it is code that has structures marked 'packed' when
they don't need to be at all.
Structures that map hardware registers probably want the
'error if any padding' check - but some people seem to think
they should be 'packed'.

For hardware structures that have fields on incorrect boundaries
you need to mark the field member as having a lesser alignment
rather than making the structure itself packed.
Do it right and you can get the compiler to do 16bit accesses
for a 32bit field that might be on a 4n+2 boundary.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

