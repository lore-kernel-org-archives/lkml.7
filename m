Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F6DC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635A921479
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfEMJNb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:13:31 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:51352 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728619AbfEMJN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:13:29 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-136-_UGF8YZbNt6WPKgejzV5ow-1; Mon, 13 May 2019 10:13:26 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 13 May 2019 10:13:25 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 13 May 2019 10:13:25 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ingo Molnar' <mingo@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: RE: FYI -ffreestanding shrinks kernel by 2% on x86_64
Thread-Topic: FYI -ffreestanding shrinks kernel by 2% on x86_64
Thread-Index: AQHVCWblbUBOOHnv10eqH+bQW22gjaZoxQGg
Date:   Mon, 13 May 2019 09:13:25 +0000
Message-ID: <3a3b9e840dbb456ab01815f7afdbb493@AcuMS.aculab.com>
References: <20190511200223.GA14143@avx2> <20190511201344.GA11535@avx2>
 <20190512093228.GA8088@gmail.com>
In-Reply-To: <20190512093228.GA8088@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: _UGF8YZbNt6WPKgejzV5ow-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar
> Sent: 12 May 2019 10:32
...
> Has anyone investigated by any chance where the -ffreestanding space
> savings come from mostly - is it mostly in cold paths, or does it make or
> hot codepaths more efficient as well?
> 
> If it's the latter then the kernel would be directly faster as well
> (fewer instructions executed), not just indirectly from better cache
> packing, I suppse?

My guess is that -ffreestanding stops gcc inlining memcpy() (etc).
The calls can be smaller than the inline code, but will (probably)
run more slowly.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

