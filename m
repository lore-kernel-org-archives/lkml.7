Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966A2C606AC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8FF20844
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731381AbfGHNmf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 09:42:35 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:32592 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729758AbfGHNmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 09:42:35 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-222-uhSA7YLRORSo_gbkd03xIg-1; Mon, 08 Jul 2019 14:42:31 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon,
 8 Jul 2019 14:42:30 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 8 Jul 2019 14:42:30 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mans Rullgard <mans@mansr.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] auxdisplay: charlcd: Deduplicate simple_strtoul()
Thread-Topic: [PATCH v3 2/2] auxdisplay: charlcd: Deduplicate simple_strtoul()
Thread-Index: AQHVNZIQJ0L6vr820kiLy31xXvYoWKbAuXow
Date:   Mon, 8 Jul 2019 13:42:30 +0000
Message-ID: <17f403303bfc4f6b90573858ae966cb7@AcuMS.aculab.com>
References: <20190704115532.15679-1-andriy.shevchenko@linux.intel.com>
 <20190704115532.15679-2-andriy.shevchenko@linux.intel.com>
 <20190708131652.s3gdoieixgyekued@pathway.suse.cz>
 <20190708133534.GO9224@smile.fi.intel.com>
In-Reply-To: <20190708133534.GO9224@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: uhSA7YLRORSo_gbkd03xIg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > simple_strtoul() tries to detect the base even when it has been
> > explicitely specified.
> 
> I can't see it from the code. Can you point out to this drastic bug that has to
> be fixed?
> 
> > I am afraid that it might cause some
> > regressions.
> >
> > For example, the following input is strange but it is valid:
> >
> >     x0x10;  new code would return (16, <orig_y>) instead of (10, <orig_y>)
> >     x010;   new code would return (8, <orig_y>) instead of (10, <orig_y>)

While having simple_stroul("0x10", 10) use base 16 is possibly not unreasonable,
using base 8 for simple_strtoul("010", 10) is just plain wrong.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

