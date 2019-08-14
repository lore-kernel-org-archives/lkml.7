Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5263AC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28BD92133F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfHNQ0k convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 12:26:40 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:24467 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725828AbfHNQ0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 12:26:40 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-70-13AhKNIkPQ24sx6GpjZKVg-1; Wed, 14 Aug 2019 17:26:37 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 14 Aug 2019 17:26:36 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 14 Aug 2019 17:26:36 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Theodore Y. Ts'o'" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "John Stultz" <john.stultz@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Florian Weimer" <fweimer@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        "GNU C Library" <libc-alpha@sourceware.org>,
        Karel Zak <kzak@redhat.com>,
        "Lennart Poettering" <lennart@poettering.net>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: RE: New kernel interface for sys_tz and timewarp?
Thread-Topic: New kernel interface for sys_tz and timewarp?
Thread-Index: AQHVUjQ/cTmrC79R5ESb1PKLJmuvcqb60iGA
Date:   Wed, 14 Aug 2019 16:26:36 +0000
Message-ID: <342565604d704b6ebaf2e9ec28d3e109@AcuMS.aculab.com>
References: <CAK8P3a0VxM1BkjY1D2FfHi6L-ho_NH3v3+gBu45EfpjLF5NU5w@mail.gmail.com>
 <CAHk-=wiO2CWONDBud4nxoPgUJN1JEewFWhHa5wAqY8G5rrTXRQ@mail.gmail.com>
 <20190814000622.GB20365@mit.edu>
In-Reply-To: <20190814000622.GB20365@mit.edu>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 13AhKNIkPQ24sx6GpjZKVg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Theodore Y. Ts'o
> Sent: 14 August 2019 01:06
> On Tue, Aug 13, 2019 at 10:30:34AM -0700, Linus Torvalds wrote:
> >
> > I suspect the only actual _valid_ use in the kernel for a time zone
> > setting is likely for RTC clock setting, but even that isn't really
> > "global", as much as "per RTC".
> 
> As I recall (and I may or may not have been original for the original
> sys_tz; it was many years ago, and my memories of 1992 are a bit
> fuzzy) the only reason why we added it was because x86 systems that
> were dual-booting with Windows had a RTC which ticked localtime, and
> originally, the system time was fetched from the RTC in early boot,
> and then when the timezone was set, the time would be warped so it
> would be correct.

x86 systems are very likely to have the RTC set by the bios config.
In which case it will almost certainly get set to local time.
It is certainly the default for windows installs - I don't even know
if you have any other option.

The 'real fun' (tm) happens when a dual boot system changes from
winter to summer time.
ISTR that it is quite easy to get both (or more) OS to change the
RTC by an hour (I went home an hour early one year).
Although the x86 RTC chip has a bit defined for 'summertime', nothing
sets it (at least when I looked).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

